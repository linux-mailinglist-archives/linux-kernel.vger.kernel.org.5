Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F33F793144
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbjIEVty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbjIEVtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:49:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFD5CF2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:49:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586ECC433C8;
        Tue,  5 Sep 2023 21:49:16 +0000 (UTC)
Date:   Tue, 5 Sep 2023 17:49:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] workqueue: Removed double allocation of
 wq_update_pod_attrs_buf
Message-ID: <20230905174935.2d75feab@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

First commit 2930155b2e272 ("workqueue: Initialize unbound CPU pods later in
the boot") added the initialization of wq_update_pod_attrs_buf to
workqueue_init_early(), and then latter on, commit 84193c07105c6
("workqueue: Generalize unbound CPU pods") added it as well. This appeared
in a kmemleak run where the second allocation made the first allocation
leak.

Fixes: 84193c07105c6 ("workqueue: Generalize unbound CPU pods")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/workqueue.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c85825e17df8..129328b765fb 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6535,9 +6535,6 @@ void __init workqueue_init_early(void)
 
 	BUG_ON(!zalloc_cpumask_var_node(&pt->pod_cpus[0], GFP_KERNEL, NUMA_NO_NODE));
 
-	wq_update_pod_attrs_buf = alloc_workqueue_attrs();
-	BUG_ON(!wq_update_pod_attrs_buf);
-
 	pt->nr_pods = 1;
 	cpumask_copy(pt->pod_cpus[0], cpu_possible_mask);
 	pt->pod_node[0] = NUMA_NO_NODE;
-- 
2.40.1

