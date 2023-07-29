Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F1C767FD0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjG2N4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjG2N4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:56:06 -0400
Received: from p3plsmtpa09-04.prod.phx3.secureserver.net (p3plsmtpa09-04.prod.phx3.secureserver.net [173.201.193.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1783326B8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 06:55:58 -0700 (PDT)
Received: from localhost ([82.27.99.45])
        by :SMTPAUTH: with ESMTPA
        id PkO5qj0LwPVHGPkO6qd5ER; Sat, 29 Jul 2023 06:53:43 -0700
X-CMAE-Analysis: v=2.4 cv=NMoTuW2g c=1 sm=1 tr=0 ts=64c519e7
 a=YwMIiW7BGddQzL8MrqPWMg==:117 a=YwMIiW7BGddQzL8MrqPWMg==:17 a=j-LfP5YGAAAA:8
 a=GEFmKsjkgO09kH4bplAA:9 a=pci6KG57UX3UzFLC8IW4:22
X-SECURESERVER-ACCT: atomlin@atomlin.com
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     linux-kernel@vger.kernel.org
Cc:     tj@kernel.org, jiangshanlai@gmail.com, peterz@infradead.org
Subject: [RFC PATCH 2/2] workqueue: Simplify current_is_workqueue_rescuer()
Date:   Sat, 29 Jul 2023 14:53:34 +0100
Message-Id: <20230729135334.566138-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230729135334.566138-1-atomlin@atomlin.com>
References: <20230729135334.566138-1-atomlin@atomlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMj1Olg5iWlv2paV4ar06WTogbgtL9xU/Az9oJG7AVchwkVuVW2WBWJP09XjCVFhic7Fv3YhWnelxsQj1MlKmN/KW2AB3MI5DUbS8ocNd0UTPKd/QeXW
 GZLrbuUWyITNru6NzmZR7IrawBOCh0oWOiMGwXC1dyNg/8FlupqzJI0MyZtKxVWRkPSMMG7B/rJA1lrFX/xojAgIXT+XVCQjF3bn0bkNHbruoyrFG/6inY2o
 CgsGUc28O+WfUEBFLO4kCRZa50rD2pqVjI4uTQuL2RQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch simplifies current_is_workqueue_rescuer()
due to the addition of PF_WQ_RESCUE_WORKER.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 kernel/workqueue.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 6d38d714b72b..3b7a4d60cb6a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4890,9 +4890,9 @@ EXPORT_SYMBOL(current_work);
  */
 bool current_is_workqueue_rescuer(void)
 {
-	struct worker *worker = current_wq_worker();
-
-	return worker && worker->rescue_wq;
+	if (in_task() && (current->flags & PF_WQ_RESCUE_WORKER))
+		return true;
+	return false;
 }
 
 /**
-- 
2.39.1

