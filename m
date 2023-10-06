Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8194E7BC180
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjJFVpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjJFVpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:45:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BE3106
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 14:45:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1830FC433C8;
        Fri,  6 Oct 2023 21:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696628729;
        bh=jhTvNdwkAK5i2O/ryu6aashqaiqoKrsyDK/KlPkKAww=;
        h=From:To:Cc:Subject:Date:From;
        b=jM+oNNnOR0OE2uvj8z+/ns1ljA1k4vCNaBg2FcHhrsqq5TT4Pg5zz9+UxpmZ1S5Cj
         jhXjsJl/jp2qMaJs0A4UisSEqn6nzTanDe9HNPg4B5LrieRYsAcyfTrNv2K95G+adS
         f6C8G1k4nAwusm4R4dn8OSCMY3ljsw2wYH0U6SB/J9oHu6K3+HuAKmo/aAwEwdWzWP
         Zo4U5BGyufIFS+QqlZ5V6pvDlni9tSGOK6bBChXUIwDpNb+34pBbAT+2ouB5Pou3SA
         /8fg8Z5ldIiu7Ih/J50dLqeMwvlOPDcLt6Fm1RK+TfAiufU3/TncsIPZpYYwLUw5Uo
         W5FRj51KBFxbQ==
Received: (nullmailer pid 340886 invoked by uid 1000);
        Fri, 06 Oct 2023 21:45:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 16:45:23 -0500
Message-Id: <20231006214523.340759-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-imx/mmdc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index 2157493b78a9..897e6def59ee 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -13,7 +13,8 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/perf_event.h>
 #include <linux/slab.h>
 
@@ -103,7 +104,7 @@ struct mmdc_pmu {
 	struct device *dev;
 	struct perf_event *mmdc_events[MMDC_NUM_COUNTERS];
 	struct hlist_node node;
-	struct fsl_mmdc_devtype_data *devtype_data;
+	const struct fsl_mmdc_devtype_data *devtype_data;
 	struct clk *mmdc_ipg_clk;
 };
 
@@ -474,8 +475,6 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
 	struct mmdc_pmu *pmu_mmdc;
 	char *name;
 	int ret;
-	const struct of_device_id *of_id =
-		of_match_device(imx_mmdc_dt_ids, &pdev->dev);
 
 	pmu_mmdc = kzalloc(sizeof(*pmu_mmdc), GFP_KERNEL);
 	if (!pmu_mmdc) {
@@ -503,7 +502,7 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
 				GFP_KERNEL, "mmdc%d", ret);
 
 	pmu_mmdc->mmdc_ipg_clk = mmdc_ipg_clk;
-	pmu_mmdc->devtype_data = (struct fsl_mmdc_devtype_data *)of_id->data;
+	pmu_mmdc->devtype_data = device_get_match_data(&pdev->dev);
 
 	hrtimer_init(&pmu_mmdc->hrtimer, CLOCK_MONOTONIC,
 			HRTIMER_MODE_REL);
-- 
2.40.1

