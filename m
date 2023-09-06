Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140C4794218
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 19:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239041AbjIFRjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 13:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjIFRjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:39:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940E6199B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 10:39:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445C3C433C7;
        Wed,  6 Sep 2023 17:39:07 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, dhavale@google.com
Subject: [PATCH] workqueue: Remove duplicate worqueue attributes allocation
Date:   Wed,  6 Sep 2023 18:39:04 +0100
Message-Id: <20230906173904.475722-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 84193c07105c ("workqueue: Generalize unbound CPU pods")
inadvertently introduced another call to alloc_workqueue_attrs()
overriding the pointer returned by a previous alloc_workqueue_attrs() a
few lines up in workqueue_init_early(). This leads to a kmemleak report:

unreferenced object 0xffff000040015000 (size 96):
  comm "swapper/0", pid 0, jiffies 4294892296 (age 163.956s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000004cec0d50>] __kmem_cache_alloc_node+0x1c4/0x288
    [<0000000083361c2a>] kmalloc_trace+0x20/0x2c
    [<000000005ca61f11>] workqueue_init_early+0xe4/0x538
    [<000000004e6ea358>] start_kernel+0x23c/0x5ec
    [<00000000aea9761e>] __primary_switched+0xbc/0xc4

Remove the first allocation.

Fixes: 84193c07105c ("workqueue: Generalize unbound CPU pods")
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Tejun Heo <tj@kernel.org>
---

I've seen this mentioned by Sandeep as well but I couldn't find a patch,
so here it is.

https://lore.kernel.org/r/CAB=BE-S=cxewXu7nqJY1DC5w9Bapar_C0cTjpZOQ-Qd5GGwYyw@mail.gmail.com/

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
