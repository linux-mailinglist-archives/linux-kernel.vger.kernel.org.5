Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E193765074
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjG0J7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjG0J7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:59:36 -0400
Received: from out-88.mta0.migadu.com (out-88.mta0.migadu.com [91.218.175.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28999C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:59:33 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690451971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DNWLHhv5T3pdBxH+svwzRV+94Efsn3aqq01UEqVJuHE=;
        b=dT/EjlSElwKm8Z9BWLzDRYC3ol71xwzcyjNVK8NXbjM7rGtG1z7FzCJ3GIp2/Il4qVkFIU
        7K8xdTkoZu1CAYNFnX+eznvcbSGVwBppQ7pG2bpoc+z3FtHATSq8UqgzBBSY22DD9ExGP3
        +LhKYvMtkT7bLSyORg3HpUf83YC/+9k=
From:   Qi Zheng <qi.zheng@linux.dev>
To:     linkinjeon@kernel.org, sfrench@samba.org, senozhatsky@chromium.org,
        tom@talpey.com, hyc.lee@gmail.com, lsahlber@redhat.com,
        paulmck@kernel.org
Cc:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH] cifsd: fix potential UAF
Date:   Thu, 27 Jul 2023 09:59:11 +0000
Message-Id: <20230727095911.3657425-1-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qi Zheng <zhengqi.arch@bytedance.com>

After calling opinfo_put(), the opinfo may be freed, then using this
opinfo in the next traversal will cause UAF bug.

To fix it, swap the call order of opinfo_put() and rcu_read_lock(), so
that the opinfo_free_rcu() will not be called, and the opinfo will not be
freed, then we can safely perform the next traversal.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/smb/server/oplock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 844b303baf29..a0e47eb2df83 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -1021,8 +1021,8 @@ int find_same_lease_key(struct ksmbd_session *sess, struct ksmbd_inode *ci,
 			goto out;
 		}
 op_next:
-		opinfo_put(opinfo);
 		rcu_read_lock();
+		opinfo_put(opinfo);
 	}
 	rcu_read_unlock();
 
@@ -1314,8 +1314,8 @@ void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
 		brk_op->open_trunc = is_trunc;
 		oplock_break(brk_op, SMB2_OPLOCK_LEVEL_NONE);
 next:
-		opinfo_conn_put(brk_op);
 		rcu_read_lock();
+		opinfo_conn_put(brk_op);
 	}
 	rcu_read_unlock();
 
@@ -1711,8 +1711,8 @@ struct oplock_info *lookup_lease_in_table(struct ksmbd_conn *conn,
 			goto out;
 		}
 op_next:
-		opinfo_put(opinfo);
 		rcu_read_lock();
+		opinfo_put(opinfo);
 	}
 	rcu_read_unlock();
 
-- 
2.30.2

