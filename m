Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A117ED55B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344982AbjKOVES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344976AbjKOVDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:03:54 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424B2198A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:03:27 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ce2eaf7c2bso57303a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:03:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700082206; x=1700687006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TOxsynhRcsQpspET2rGRXcJTfs3kg/OnXXBbiAJArDQ=;
        b=dY+t5j+hLHYt/lLZLfBwshbsBd4ETEpBXGPArBaATBQ9PslcN4VtxWPnCyGTmuNvTu
         RFvFAqnFS5spjo/a7udSIO4FQsmb1skDf6suOKWUMIxdKpH1/WcbwJK0IM4SOs8Ab/yt
         mIYZEudx2qpmWjQpamdsypnV6KWJSNeIZRgR9d2LUhIU588q3SjDGo4sEkGIwMfYpb4z
         KjANBP6N/FuVtTPqLtByh+b0q0gz88sCrehstOc5djZEPdApNf2XXc3ARDNh6fCsBG5C
         VWhrV1eQCCk1aKymFmJ3D9BnxK+o6F0FqZCHEPG1IKnJt0pyJZV31Mh4FO5qoEGt/hTM
         7KQQ==
X-Gm-Message-State: AOJu0YwIoDKD6C6yenngDxfBuv2r51LAiPP+vIqQoKUcvY/+4utUNY/f
        KqpeQ31vdfu+R+rvEPpyYA==
X-Google-Smtp-Source: AGHT+IFW0uhDYGUzbH1Ef+e9gAZlnJ1rqTH3m/OAXMWQ8DRDz/rhGdc7NHP3E0sqMJantRNrsGmeIg==
X-Received: by 2002:a9d:6441:0:b0:6b8:7eef:a236 with SMTP id m1-20020a9d6441000000b006b87eefa236mr6280865otl.30.1700082206536;
        Wed, 15 Nov 2023 13:03:26 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a18-20020a056830101200b006cdf9935af2sm494337otp.53.2023.11.15.13.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 13:03:25 -0800 (PST)
Received: (nullmailer pid 3747903 invoked by uid 1000);
        Wed, 15 Nov 2023 21:03:25 -0000
From:   Rob Herring <robh@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] ARM: imx: Use device_get_match_data()
Date:   Wed, 15 Nov 2023 15:03:18 -0600
Message-ID: <20231115210319.3747145-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
2.42.0

