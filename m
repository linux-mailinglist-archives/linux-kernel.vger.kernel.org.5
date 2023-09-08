Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69516798C6D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241210AbjIHSQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240497AbjIHSQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:16:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C915213A;
        Fri,  8 Sep 2023 11:15:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637E4C433CB;
        Fri,  8 Sep 2023 18:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196190;
        bh=Xn6LIQNwACdfOkwsE41NEZqkM6NyqqRvO+3pqH5M/ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lOwauLWi7ydpEhD/pm50erWaOdH8oKxI+zexwXdvn1Jf/Gxu28twhaRQ5Y4lf+G+S
         q7h9juanKJtp0WM7N6TaeqG51dPPtj4y/wxiqclXSF/bOuaHhhxKeKlq8O/eWDvOlW
         rxxtv4WODaaj8hKUvZErMDP4RVhctYrlwjm+ZFVzDb+s28uoqSPpW1XbwDPXT6R9/+
         E/OWJDjLD51KNAjc9ClHGF6fNc1KbmwS8Jy6jCPxoaK7K5UhVvoBHlmsnWRHLhGE2L
         4yGopf+AhCkw40o4cBsMh1V7o82gmx6LRCNKf35fnyzkm3+RHeNPNlToX4FuJ2qfkQ
         R+byFe719Q3fQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xu Yang <xu.yang_2@nxp.com>, Frank Li <Frank.Li@nxp.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        Frank.li@nxp.com, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 7/9] perf/imx_ddr: speed up overflow frequency of cycle
Date:   Fri,  8 Sep 2023 14:02:38 -0400
Message-Id: <20230908180240.3458469-7-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908180240.3458469-1-sashal@kernel.org>
References: <20230908180240.3458469-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.131
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit e89ecd8368860bf05437eabd07d292c316221cfc ]

For i.MX8MP, we cannot ensure that cycle counter overflow occurs at least
4 times as often as other events. Due to byte counters will count for any
event configured, it will overflow more often. And if byte counters
overflow that related counters would stop since they share the
COUNTER_CNTL. We can speed up cycle counter overflow frequency by setting
counter parameter (CP) field of cycle counter. In this way, we can avoid
stop counting byte counters when interrupt didn't come and the byte
counters can be fetched or updated from each cycle counter overflow
interrupt.

Because we initialize CP filed to shorten counter0 overflow time, the cycle
counter will start couting from a fixed/base value each time. We need to
remove the base from the result too. Therefore, we could get precise result
from cycle counter.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20230811015438.1999307-1-xu.yang_2@nxp.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/fsl_imx8_ddr_perf.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index b1b2a55de77fc..1016b6704e1d2 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -28,6 +28,8 @@
 #define CNTL_CLEAR_MASK		0xFFFFFFFD
 #define CNTL_OVER_MASK		0xFFFFFFFE
 
+#define CNTL_CP_SHIFT		16
+#define CNTL_CP_MASK		(0xFF << CNTL_CP_SHIFT)
 #define CNTL_CSV_SHIFT		24
 #define CNTL_CSV_MASK		(0xFFU << CNTL_CSV_SHIFT)
 
@@ -35,6 +37,8 @@
 #define EVENT_CYCLES_COUNTER	0
 #define NUM_COUNTERS		4
 
+/* For removing bias if cycle counter CNTL.CP is set to 0xf0 */
+#define CYCLES_COUNTER_MASK	0x0FFFFFFF
 #define AXI_MASKING_REVERT	0xffff0000	/* AXI_MASKING(MSB 16bits) + AXI_ID(LSB 16bits) */
 
 #define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
@@ -428,6 +432,17 @@ static void ddr_perf_counter_enable(struct ddr_pmu *pmu, int config,
 		writel(0, pmu->base + reg);
 		val = CNTL_EN | CNTL_CLEAR;
 		val |= FIELD_PREP(CNTL_CSV_MASK, config);
+
+		/*
+		 * On i.MX8MP we need to bias the cycle counter to overflow more often.
+		 * We do this by initializing bits [23:16] of the counter value via the
+		 * COUNTER_CTRL Counter Parameter (CP) field.
+		 */
+		if (pmu->devtype_data->quirks & DDR_CAP_AXI_ID_FILTER_ENHANCED) {
+			if (counter == EVENT_CYCLES_COUNTER)
+				val |= FIELD_PREP(CNTL_CP_MASK, 0xf0);
+		}
+
 		writel(val, pmu->base + reg);
 	} else {
 		/* Disable counter */
@@ -467,6 +482,12 @@ static void ddr_perf_event_update(struct perf_event *event)
 	int ret;
 
 	new_raw_count = ddr_perf_read_counter(pmu, counter);
+	/* Remove the bias applied in ddr_perf_counter_enable(). */
+	if (pmu->devtype_data->quirks & DDR_CAP_AXI_ID_FILTER_ENHANCED) {
+		if (counter == EVENT_CYCLES_COUNTER)
+			new_raw_count &= CYCLES_COUNTER_MASK;
+	}
+
 	local64_add(new_raw_count, &event->count);
 
 	/*
-- 
2.40.1

