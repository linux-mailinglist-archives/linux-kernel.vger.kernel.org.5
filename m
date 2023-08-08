Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A728773CDD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjHHQKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjHHQI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:08:57 -0400
Received: from sxb1plsmtpa01-12.prod.sxb1.secureserver.net (sxb1plsmtpa01-12.prod.sxb1.secureserver.net [188.121.53.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8987684
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:46:20 -0700 (PDT)
Received: from localhost ([82.27.99.45])
        by :SMTPAUTH: with ESMTPA
        id TLQyqf72Oc1SOTLR0qNRjP; Tue, 08 Aug 2023 05:03:35 -0700
X-CMAE-Analysis: v=2.4 cv=U+FUT8nu c=1 sm=1 tr=0 ts=64d22f18
 a=YwMIiW7BGddQzL8MrqPWMg==:117 a=YwMIiW7BGddQzL8MrqPWMg==:17 a=j-LfP5YGAAAA:8
 a=LJjOXhdp0eP329QD6j4A:9 a=pci6KG57UX3UzFLC8IW4:22
X-SECURESERVER-ACCT: atomlin@atomlin.com
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     tj@kernel.org
Cc:     atomlin@atomlin.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v2 1/1] workqueue: Rename rescuer kworker
Date:   Tue,  8 Aug 2023 13:03:29 +0100
Message-Id: <20230808120329.3400069-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230808120329.3400069-1-atomlin@atomlin.com>
References: <20230808120329.3400069-1-atomlin@atomlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBEp2AhS5pbYuLvwccdfyhTj2bnwuzsxO+t/cW5GGLjqwySKa5DBHi6IAquyEc4TKV3tOVzHUWZKC11elOUZ6LAkPntOjthAu1cPVAtpiqKeYmNxU/iw
 gWC9brJcpO4OOcoPn7IAZKlwCfRbV4sM+y8j5eBOMNo6HIbKNw5iXa6CbioOQly7WLPfYznOHT6NeXbf14BdaHUGJki/mOVuQEsJXPxxBJXfgQZL7PfoQe2h
 97D+TAdO4pislXzDfoBytPnIfEKt8nfDAmNAcPjeZWIVx/wz0jE3DgrLAYcUiBlK3XB+5V3ICi0uav3eXP60vQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each CPU-specific and unbound kworker kthread conforms to a particular
naming scheme. However, this does not extend to the rescuer kworker.
At present, a rescuer kworker is simply named according to its
workqueue's name. This can be cryptic.

This patch modifies a rescuer to follow the kworker naming scheme.
The "r" is indicative of a rescuer and after "-" is its workqueue's
name e.g. "kworker/r-ext4-rsv-conver".

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

