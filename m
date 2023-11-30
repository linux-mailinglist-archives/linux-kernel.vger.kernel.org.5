Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E71C7FFCFC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376786AbjK3UoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376770AbjK3Un7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:43:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15D711731;
        Thu, 30 Nov 2023 12:43:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ED9F1042;
        Thu, 30 Nov 2023 12:44:43 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 617BF3F73F;
        Thu, 30 Nov 2023 12:43:55 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, quic_mdtipton@quicinc.com,
        quic_asartor@quicinc.com, quic_lingutla@quicinc.com,
        Sibi Sankar <quic_sibis@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 1/2] firmware: arm_scmi: Fix frequency truncation by promoting multiplier to u64
Date:   Thu, 30 Nov 2023 20:43:42 +0000
Message-ID: <20231130204343.503076-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.43.0
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

Fix the frequency truncation for all values equal to or greater 4GHz by
updating the multiplier 'mult_factor' to u64 type. It is also possible
that the multiplier itself can be greater than or equal to 2^32. So we need
to also fix the equation computing the value of the multiplier.

Fixes: a9e3fbfaa0ff ("firmware: arm_scmi: add initial support for performance protocol")
Reported-by: Sibi Sankar <quic_sibis@quicinc.com>
Closes: https://lore.kernel.org/all/20231129065748.19871-3-quic_sibis@quicinc.com/
Cc: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/perf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 81dd5c5e5533..8ce449922e55 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -152,7 +152,7 @@ struct perf_dom_info {
 	u32 opp_count;
 	u32 sustained_freq_khz;
 	u32 sustained_perf_level;
-	u32 mult_factor;
+	u64 mult_factor;
 	struct scmi_perf_domain_info info;
 	struct scmi_opp opp[MAX_OPPS];
 	struct scmi_fc_info *fc_info;
@@ -273,8 +273,8 @@ scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
 			dom_info->mult_factor =	1000;
 		else
 			dom_info->mult_factor =
-					(dom_info->sustained_freq_khz * 1000) /
-					dom_info->sustained_perf_level;
+					(dom_info->sustained_freq_khz * 1000UL)
+					/ dom_info->sustained_perf_level;
 		strscpy(dom_info->info.name, attr->name,
 			SCMI_SHORT_NAME_MAX_SIZE);
 	}
--
2.43.0

