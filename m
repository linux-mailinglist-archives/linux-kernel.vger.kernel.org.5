Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E85756C31
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjGQSgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGQSgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:36:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D2194
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:36:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 139EF611EC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 18:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741BEC433C7;
        Mon, 17 Jul 2023 18:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618964;
        bh=9yE12PZ29ftJGWkQSTA0NaFgX48aRCYj4ThbucaU9ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qq7BU6ChMsy/ajc3jDBg3X32u8GY/CKhM7Xwa94P9zvmRefEK6JM6D9dioCAITlqG
         DftQwzSUfZOj2G1xf9EJokEE+Ad9EGHRdO0VmhJcm8FYVPkefNjSyBXwgd4hfC3I57
         SaPQKFvdTXeorrf0Xue5P/9h3kIYWPnCGiGIh49/Ko4+aEOwE9ndZUnMkfcz7Oxegd
         6eWR74hIaF4tBLEPK1XMGo7deyoc6bNLmcy2N+pFSJeFSmgeZto/YWjfuRv3xmJ3cS
         eFo03CCLPVxVFUN0c+kANxKNEDROzEMVC6f60LyCUtkEaFgYuZSxDnbn45QSTiLchI
         gHfv3eOLTXWdA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2F6FDCE03F1; Mon, 17 Jul 2023 11:36:04 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org, jgross@suse.com, vschneid@redhat.com,
        yury.norov@gmail.com
Cc:     linux-kernel@vger.kernel.org, imran.f.khan@oracle.com,
        kernel-team@meta.com, "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH csd-lock 1/2] smp: Reduce logging due to dump_stack of CSD waiters
Date:   Mon, 17 Jul 2023 11:36:01 -0700
Message-Id: <20230717183602.1099773-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <96818440-a922-4b43-8871-50358e18b523@paulmck-laptop>
References: <96818440-a922-4b43-8871-50358e18b523@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Imran Khan <imran.f.khan@oracle.com>

If a waiter is waiting for CSD lock, its call stack will not change
between first and subsequent hang detection for the same CSD lock.
Therefore, do dump_stack only for first-time detection for a given waiter.

This avoids excessive logging on systems with hundreds of CPUs where
repetitive dump_stack from hundreds of CPUs would otherwise flood the
console.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 385179dae360..1d41a0cb54f1 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -259,7 +259,8 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
 			arch_send_call_function_single_ipi(cpu);
 		}
 	}
-	dump_stack();
+	if (firsttime)
+		dump_stack();
 	*ts1 = ts2;
 
 	return false;
-- 
2.40.1

