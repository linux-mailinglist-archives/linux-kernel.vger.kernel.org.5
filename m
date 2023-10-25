Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2CC7D7179
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjJYQMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjJYQMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:12:34 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1332E5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 09:12:30 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b2ea7cc821so4042345b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 09:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698250350; x=1698855150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ytctWrVvmrwWikQYcV1BL3D331y6HoCG+PzKBkTXgc=;
        b=DBmn+jmy0Cig8xaarnbOR1XEiZ35V3ZfPgQxhSG7ihL3kJduz3V8pCNsyeyT1wOFe2
         U8E1eh59dN+Gyx756lGHfzju63bg79D1jd2vok26T9Rg22Byr5d6qz3RGhEWm6cLX1US
         lC1znfN4Xn+y0qXxSul7ekpJb69GHu0L5Qa4VVCRR81/QHhxJDKItnn2z5P8JgX1kk1v
         qgv76O1p9DVbwv5+4eRxYtoAabWSN1vQICR3qOTde3nRSEskE/EQdGIksXgoGd4CmqP2
         i4Ta/wiEOFPNDMGDxaCCVkA4WCLHR43wIoaveTL5EoZmdBeZ81/lGLGmnRGmv0GfyxA0
         Zzrw==
X-Gm-Message-State: AOJu0Yy0k7huiD6T/+WIL/Zrsi53ncvLQkTfPbOjjaSQUuQLZNDSLdcy
        B/ZDCmSXvRLPgwnSQpmQBA==
X-Google-Smtp-Source: AGHT+IGss1R2cE3hvVhgLoTGqsidfQCVdHOZlUa4acNBNDNVO4NsnM5QDajtWSyLtHp7Jt4v+KhQtg==
X-Received: by 2002:a05:6808:110:b0:3a7:b4e8:563e with SMTP id b16-20020a056808011000b003a7b4e8563emr15249119oie.38.1698250350223;
        Wed, 25 Oct 2023 09:12:30 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 4-20020aca1004000000b003af642cf646sm2418298oiq.37.2023.10.25.09.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 09:12:29 -0700 (PDT)
Received: (nullmailer pid 371325 invoked by uid 1000);
        Wed, 25 Oct 2023 16:12:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] bus: imx-weim: Use device_get_match_data()
Date:   Wed, 25 Oct 2023 11:12:21 -0500
Message-ID: <20231025161221.371153-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
 drivers/bus/imx-weim.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 42c9386a7b42..6b5da73c8541 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -11,7 +11,10 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <linux/regmap.h>
@@ -202,9 +205,7 @@ static int weim_timing_setup(struct device *dev, struct device_node *np,
 
 static int weim_parse_dt(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id = of_match_device(weim_id_table,
-							   &pdev->dev);
-	const struct imx_weim_devtype *devtype = of_id->data;
+	const struct imx_weim_devtype *devtype = device_get_match_data(&pdev->dev);
 	int ret = 0, have_child = 0;
 	struct device_node *child;
 	struct weim_priv *priv;
-- 
2.42.0

