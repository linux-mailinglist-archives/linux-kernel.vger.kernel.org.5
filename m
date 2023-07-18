Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054D3757C01
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjGRMlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGRMlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:41:50 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3390B99
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1689684109;
  x=1721220109;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=MIg98QeotzlFKIUE1hpL5s/FiWR80QS6lSN9xynpoEQ=;
  b=d/cLaNyJ57rmS7SoBZwSK+mtbTrj0nSubKCQN0gLaBvo6SX3hbhcwiKM
   0wWAClrCNGmCPIxPLnUgdOQNN0e1NMRHAhdW1xcuk78KP1Byu6BTZwcwm
   hkn9kPMWnvQhxSvyNE8JUgQzc215iARa2i3nbjp2zs+Q4enxYWo2LO7KB
   ajNvDLZsXuoSIQvkjH/m4729VnUu3BRGohyZhM083kFirqjKQFG5LwKL8
   oCc9Xx0hpagnY22vwFLSnNYrNUm04teIzINBFVcX0lLZTpILXiQxz2rnK
   TJytFAvdl9uSWAnQW/1stE1d9FBrPA+q/7lBUO4dcHFG4C+EWooJlImad
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Tue, 18 Jul 2023 14:41:45 +0200
Subject: [PATCH] ubifs: Fix memory leak of bud->log_hash
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230718-ubifs-replay-auth-leak-v1-1-2dd2e00e6dc6@axis.com>
X-B4-Tracking: v=1; b=H4sIAIiItmQC/x3MTQ5AMBBA4avIrE2iGj91FbFomTIhSKtCxN01l
 t/ivQc8OSYPTfKAo5M9b2uESBPoJ72OhDxEQ57lMqtEjcGw9ehoX/SNOhwTLqRnVEaqwtRSqNJ
 CjHdHlq9/3Hbv+wEE8Ts0aAAAAA==
To:     Richard Weinberger <richard@nod.at>
CC:     Sascha Hauer <s.hauer@pengutronix.de>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that the allocated bud->log_hash (if any) is freed in all cases
when the bud itself is freed, to fix this leak caught by kmemleak:

 # keyctl add logon foo:bar data @s
 # echo clear > /sys/kernel/debug/kmemleak
 # mount -t ubifs /dev/ubi0_0 mnt -o auth_hash_name=sha256,auth_key=foo:bar
 # echo a > mnt/x
 # umount mnt
 # mount -t ubifs /dev/ubi0_0 mnt -o auth_hash_name=sha256,auth_key=foo:bar
 # umount mnt
 # sleep 5
 # echo scan > /sys/kernel/debug/kmemleak
 # echo scan > /sys/kernel/debug/kmemleak
 # cat /sys/kernel/debug/kmemleak
 unreferenced object 0xff... (size 128):
   comm "mount"
   backtrace:
     __kmalloc
     __ubifs_hash_get_desc+0x5d/0xe0 ubifs
     ubifs_replay_journal
     ubifs_mount
     ...

Fixes: da8ef65f9573 ("ubifs: Authenticate replayed journal")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 fs/ubifs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 32cb14759796..0ef8c1f3d760 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -923,8 +923,10 @@ static void free_buds(struct ubifs_info *c)
 {
 	struct ubifs_bud *bud, *n;
 
-	rbtree_postorder_for_each_entry_safe(bud, n, &c->buds, rb)
+	rbtree_postorder_for_each_entry_safe(bud, n, &c->buds, rb) {
+		kfree(bud->log_hash);
 		kfree(bud);
+	}
 }
 
 /**
@@ -1193,6 +1195,7 @@ static void destroy_journal(struct ubifs_info *c)
 
 		bud = list_entry(c->old_buds.next, struct ubifs_bud, list);
 		list_del(&bud->list);
+		kfree(bud->log_hash);
 		kfree(bud);
 	}
 	ubifs_destroy_idx_gc(c);

---
base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
change-id: 20230718-ubifs-replay-auth-leak-9b395b83196f

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

