Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AE379E4A9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239643AbjIMKQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239605AbjIMKQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:16:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E188A19B2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:16:39 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694600197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lsQkFEGOfI0iTMla2oxJpk+1VZ0aBz8IS1SfHikhG0E=;
        b=4L5tv09nLX3TJ+ucf5Vl8nfFx/rchv6fs+fjF1lAuHkOo3sohpiw/pRxnvo3Ryvqmm7yHy
        NEwMxI8yU8lr6C/XcBju/cxzFHyEecK6G4E3YiDccsk3dVWT9DyTKznqy+nGCZeDcu+AX3
        itfu9KbPHEkweSxV1wNqIFHoThOINyIl4LNfVZNT97Lrm1pJHE1zIG7o/Ho4ogRoPG6P/U
        AJT6HODJeUqz5nmueIA/cSu+SoT51W1P3hRaSLbIybjdT9IraDNUrIRJV4WB8YiNb6Uu4c
        BKA2n5G78NzXR07crYDb1ev0CbXMPR1UuIArTVQgUI4oWI4gyVrTHMveCkV7qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694600197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lsQkFEGOfI0iTMla2oxJpk+1VZ0aBz8IS1SfHikhG0E=;
        b=8h3cVqiGAikaWSGmo0PhID5kItFlKCihsyQpwglmRlXZplOk86n/4rCwnhJbuDJ8H97VMf
        5dpbqxEsnLHcqnDA==
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: fix duplicate wq_update_pod_attrs_buf allocation
Date:   Wed, 13 Sep 2023 12:22:34 +0206
Message-Id: <20230913101634.553699-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the hunks for the patch resulting in
commit 84193c07105c ("workqueue: Generalize unbound CPU pods") was
applied incorrectly. This resulted in @wq_update_pod_attrs_buf
being allocated twice.

From the kmemleak detector:

unreferenced object 0xc0000000040074c0 (size 64):
  comm "swapper/0", pid 0, jiffies 4294937296 (age 1936.580s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000076b83a6e>] .kmalloc_trace+0x54/0x190
    [<00000000898f2356>] .alloc_workqueue_attrs+0x2c/0x60
    [<0000000063365e1f>] .workqueue_init_early+0xe4/0x4b8
    [<00000000ca97ff39>] .start_kernel+0x8d0/0xba4
    [<000000002ee12080>] start_here_common+0x1c/0x20

Remove the redundant allocation.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/workqueue.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c85825e17df8..43ab8399b72b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6524,9 +6524,6 @@ void __init workqueue_init_early(void)
 
 	pwq_cache = KMEM_CACHE(pool_workqueue, SLAB_PANIC);
 
-	wq_update_pod_attrs_buf = alloc_workqueue_attrs();
-	BUG_ON(!wq_update_pod_attrs_buf);
-
 	/* initialize WQ_AFFN_SYSTEM pods */
 	pt->pod_cpus = kcalloc(1, sizeof(pt->pod_cpus[0]), GFP_KERNEL);
 	pt->pod_node = kcalloc(1, sizeof(pt->pod_node[0]), GFP_KERNEL);

base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
-- 
2.39.2

