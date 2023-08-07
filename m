Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FD77732D5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 00:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjHGWM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 18:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjHGWMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:12:13 -0400
X-Greylist: delayed 210 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Aug 2023 15:11:10 PDT
Received: from p3plsmtpa13-06.prod.phx3.secureserver.net (p3plsmtpa13-06.prod.phx3.secureserver.net [72.167.218.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A372116
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 15:11:10 -0700 (PDT)
Received: from localhost ([82.27.99.45])
        by :SMTPAUTH: with ESMTPA
        id T8N3qcRyBSo81T8N4qaX53; Mon, 07 Aug 2023 15:06:39 -0700
X-CMAE-Analysis: v=2.4 cv=WazKKWtX c=1 sm=1 tr=0 ts=64d16aef
 a=YwMIiW7BGddQzL8MrqPWMg==:117 a=YwMIiW7BGddQzL8MrqPWMg==:17 a=j-LfP5YGAAAA:8
 a=FPoep68dpx1dqRdUuF0A:9 a=pci6KG57UX3UzFLC8IW4:22
X-SECURESERVER-ACCT: atomlin@atomlin.com
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     tj@kernel.org
Cc:     atomlin@atomlin.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH] workqueue: Rename rescuer kworker
Date:   Mon,  7 Aug 2023 23:06:37 +0100
Message-Id: <20230807220637.3203739-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFo1C2Z9MFQIaTePl+WZBSY4ik/ke84/WMSJuqTXrhMD0BDb4rJsX1iSVy1HfdPpEWL9ywDIIro1zi7IRVVcWBF7cAGQyY1R/0f/I28llA74/e9Hrvnq
 RClOc8bz9QWCAPC/Y/zC1bIO+mqEgxifew4NWMuxtTgsv2OH4K8pWKaLqUGHw30r/Q4/vidsyIt3X1KECzZGw46l7t4zh8OS/e7fQ6EZm3vejMsa9aND8ydr
 PfT3emNoUeTwNbtlwnixJWfN4vxwX8dvOW2N4FjHo6wgsBy7XG7tNEd8ne9OLQoMl17GnQgallEKZ1PWxJJ7Xg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each CPU-specific and unbound kworker kthread conforms to a particular
naming scheme. However, this does not extend to the rescuer kworker.
At present, a rescuer kworker is simply named according to its
workqueue's name. This can be cryptic.

From the context of user-mode, it can be useful to identify a rescuer
kworker since their CPU affinity cannot be modified and their initial
CPU assignment can be safely ignored. By design a rescuer kworker can
run anywhere and only processes work items in an emergency situation.

This patch modifies a rescuer to follow the kworker naming scheme.
The "r" and "-" is indicative of a rescuer and its workqueue's
name respectively e.g. "kworker/r-ext4-rsv-conver".

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 02a8f402eeb5..d9bb375b8d02 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4599,7 +4599,7 @@ static int init_rescuer(struct workqueue_struct *wq)
 	}
 
 	rescuer->rescue_wq = wq;
-	rescuer->task = kthread_create(rescuer_thread, rescuer, "%s", wq->name);
+	rescuer->task = kthread_create(rescuer_thread, rescuer, "kworker/r-%s", wq->name);
 	if (IS_ERR(rescuer->task)) {
 		ret = PTR_ERR(rescuer->task);
 		pr_err("workqueue: Failed to create a rescuer kthread for wq \"%s\": %pe",
-- 
2.39.1

