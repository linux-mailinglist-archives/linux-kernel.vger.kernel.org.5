Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB687F5E91
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345218AbjKWL62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345194AbjKWL6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:58:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3737B0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:58:29 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6683E1042;
        Thu, 23 Nov 2023 03:59:15 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2EA663F7A6;
        Thu, 23 Nov 2023 03:58:28 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will@kernel.org
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: [PATCH] perf/arm-cmn: Fix HN-F class_occup_id events
Date:   Thu, 23 Nov 2023 11:58:13 +0000
Message-Id: <5a22439de84ff188ef76674798052448eb03a3e1.1700740693.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A subtle copy-paste error managed to slip through the reorganisation
of these patches in development, and not only give some HN-F events
the wrong type, but use that wrong type before the subsequent patch
defined it. Too late to fix history, but we can at least fix the bug.

Fixes: b1b7dc38e482 ("perf/arm-cmn: Refactor HN-F event selector macros")
Reported-by: Jing Zhang <renyu.zj@linux.alibaba.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 014010d03588..86d970e74129 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -811,7 +811,7 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
 #define CMN_EVENT_HNF_OCC(_model, _name, _event)			\
 	CMN_EVENT_HN_OCC(_model, hnf_##_name, CMN_TYPE_HNF, _event)
 #define CMN_EVENT_HNF_CLS(_model, _name, _event)			\
-	CMN_EVENT_HN_CLS(_model, hnf_##_name, CMN_TYPE_HNS, _event)
+	CMN_EVENT_HN_CLS(_model, hnf_##_name, CMN_TYPE_HNF, _event)
 #define CMN_EVENT_HNF_SNT(_model, _name, _event)			\
 	CMN_EVENT_HN_SNT(_model, hnf_##_name, CMN_TYPE_HNF, _event)
 
-- 
2.39.2.101.g768bb238c484.dirty

