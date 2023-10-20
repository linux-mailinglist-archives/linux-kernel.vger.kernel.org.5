Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E185C7D1282
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377653AbjJTPWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377601AbjJTPWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:22:14 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0151D55
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:22:12 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ce344fa7e4so639164a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697815332; x=1698420132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nALrk+XFNQ60cSPVh7z3lKIsU/sRLu5t+EXSak55RSA=;
        b=j/mAacAZLaoyI3zDp5SSshwTmxlOpp97W1XEGKM9/FUmPZp5DsFHyQZ93Ri5H3ETM1
         ZLkb03jpU1Fss5q1y+oi2+8djT6lMMv8NzMPg8d+UUl/MbwZM2aUyhuOOH2zDJ9ByB6W
         0xBSZvu5AZbzMJtJSYMc5dPjgq8C4GM6AfMeqqLPv6CDJynffqMbGNA3Gbki+CLeh9gG
         1leVBCBYI0VJnosYpmed/hgC3SKfL7FiygYdPHe2OS5R0McsGYBvK7rLeNTiq9RgWHye
         pqnpFt2ErMkKfPWN12YPF8Y41ILkkt8zcj+0zpBrk1QJN6AhriKyvIreKqXpzWb01wQA
         9h+g==
X-Gm-Message-State: AOJu0YxFajY9gCkBDzOqEMr/Rk7Iuk2B+CRA2uZ8O+LFKKsKvJrGMyFu
        vUUQhk4iIB8q9IegQK/4eg==
X-Google-Smtp-Source: AGHT+IGZ9ST6PCHhhD06Q1lcCdFq+lo39/J/y+pMQ+x4+1Lc4waCGqLqIb5JCIOodCOaGkbAqdgSLQ==
X-Received: by 2002:a05:6808:4d3:b0:3a7:2524:6d3b with SMTP id a19-20020a05680804d300b003a725246d3bmr2165384oie.12.1697815331839;
        Fri, 20 Oct 2023 08:22:11 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bp18-20020a056808239200b003b2e2d134a5sm357266oib.35.2023.10.20.08.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 08:22:11 -0700 (PDT)
Received: (nullmailer pid 3323161 invoked by uid 1000);
        Fri, 20 Oct 2023 15:22:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] ARM: imx: Use device_get_match_data()
Date:   Fri, 20 Oct 2023 10:21:17 -0500
Message-ID: <20231020152116.3314175-2-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
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
Resending as I had an issue sending to kernel.org accounts.

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
2.42.0

