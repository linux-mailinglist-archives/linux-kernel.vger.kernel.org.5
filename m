Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8F17D1043
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377403AbjJTNHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377144AbjJTNG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:06:58 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41718B8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:06:53 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1e9b6f39f9eso563977fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697807212; x=1698412012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qoifS+46L935RaOWjpS8M82tnDKrW+MvtenA40on/GA=;
        b=fiH52N7M0MsAm6rlUmQ40WW2T8Fd77rwSuvk7ETOhwY2oQvaswX3usFkkCXWrV0BTl
         dA1jrL1jZ6vVbtqqEATGnY2i7UjVPNQoRalq7l2c6+piKSBJOU9r4A/38EcsS3J0jezc
         M1tbg7Q2hN5lDBoACXWmYPsmJf9wRE5o9tG1WtkRh7u8i4E4A6oyuGj69EQ8JqhPj3PS
         aJWeN+UQkhy1GDdcXeCaAx9PtNFfH+ijtrFWE5h64ZLh+NsQApNK9+nHsWd90gQGbC2Z
         /UeVdjPEuCcMZsXKNZM2vuSepU02XWppMte/aFPUpi6IuC5l/dGfcqg95S6+HASihsJr
         d1bw==
X-Gm-Message-State: AOJu0Yw43bTXaleyFtbiSn5+JZeSI4oy9weVZInKxbeWsWhN7wC1M6hK
        FUC927Gu76/vlrX4bOVPKg==
X-Google-Smtp-Source: AGHT+IErTEs7gVCuW7P2bJpMAh0j1jao5EUSDsAiQDFXDr2mhhA5u3pG+6PrGB9WMXV5orp4mKLZCQ==
X-Received: by 2002:a05:6871:918b:b0:1e9:c974:5f7e with SMTP id ak11-20020a056871918b00b001e9c9745f7emr1962949oac.40.1697807212365;
        Fri, 20 Oct 2023 06:06:52 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p3-20020a05687052c300b001e98fa5c9edsm349124oak.40.2023.10.20.06.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 06:06:51 -0700 (PDT)
Received: (nullmailer pid 2963897 invoked by uid 1000);
        Fri, 20 Oct 2023 13:06:50 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH v2] irqchip/ls-scfg-msi: Use device_get_match_data()
Date:   Fri, 20 Oct 2023 08:02:56 -0500
Message-ID: <20231020130255.2954415-3-robh@kernel.org>
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
get the driver match data in a single step without the unnecessary
intermediate match pointer. With this, adjust the includes to
explicitly include the correct headers. That also serves as
preparation to remove implicit includes within the DT headers.
of_platform.h currently includes platform_device.h among others.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Expand commit message
---
 drivers/irqchip/irq-ls-scfg-msi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index f31a262fe438..15cf80b46322 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -17,7 +17,8 @@
 #include <linux/irqdomain.h>
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/spinlock.h>
 
 #define MSI_IRQS_PER_MSIR	32
@@ -334,20 +335,17 @@ MODULE_DEVICE_TABLE(of, ls_scfg_msi_id);
 
 static int ls_scfg_msi_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct ls_scfg_msi *msi_data;
 	struct resource *res;
 	int i, ret;
 
-	match = of_match_device(ls_scfg_msi_id, &pdev->dev);
-	if (!match)
-		return -ENODEV;
-
 	msi_data = devm_kzalloc(&pdev->dev, sizeof(*msi_data), GFP_KERNEL);
 	if (!msi_data)
 		return -ENOMEM;
 
-	msi_data->cfg = (struct ls_scfg_msi_cfg *) match->data;
+	msi_data->cfg = (struct ls_scfg_msi_cfg *)device_get_match_data(&pdev->dev);
+	if (!msi_data->cfg)
+		return -ENODEV;
 
 	msi_data->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(msi_data->regs)) {
-- 
2.42.0

