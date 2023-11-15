Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786B67ED556
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344869AbjKOVEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344822AbjKOVDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:03:39 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E662719
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:03:18 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3b4145e887bso56040b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:03:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700082198; x=1700686998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ytctWrVvmrwWikQYcV1BL3D331y6HoCG+PzKBkTXgc=;
        b=KaYZoMPRAgd9oKywTlqFzCMnkkFFcVMGVHBjJHNRss6ouApIF2XptO2mP4sPGJZxZx
         wy3J79clKnPrKh1N0erw2fhe9f1pOWfEDoh6zGeWznlygzHxDrX0D3u2aGv/9pefACue
         WY3pxdMQjxi9OBlVTkwDixJ6nL3DuXz7GgNqGCnyQANWIcfcWBtJSWkREZ/9Wr4snD6C
         NJ6FiT1kpb9PjSg6SBeRqfrp2JS8hJAvMDha/O3vXD0L5XdJRiz4AumlldMQFwkOP9u5
         8MYr4/9wh6a8+O+AkRsCjRJEscnzaFIu3U6lNNAN9DnKByQoP1OtTN/MjKCBi5jdbfTb
         ZN9A==
X-Gm-Message-State: AOJu0Yz6Mfzhbn1BwI8YrsVKckmG82ZVu7YOzUykvmdYAupWX64Oh7BN
        j+BnIVhdtP6Ss6EB4/1jbg==
X-Google-Smtp-Source: AGHT+IFDJ1r87ynVeQ4wuSezEHjSiOWlCWwFEJTCC05EeQgAqXNdF5UwRQZlWRJRnV71lFxce2WK5A==
X-Received: by 2002:a05:6808:1585:b0:3b6:dd92:737e with SMTP id t5-20020a056808158500b003b6dd92737emr15353689oiw.58.1700082198015;
        Wed, 15 Nov 2023 13:03:18 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i17-20020aca2b11000000b003af60f06629sm1633534oik.6.2023.11.15.13.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 13:03:17 -0800 (PST)
Received: (nullmailer pid 3746864 invoked by uid 1000);
        Wed, 15 Nov 2023 21:03:16 -0000
From:   Rob Herring <robh@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] bus: imx-weim: Use device_get_match_data()
Date:   Wed, 15 Nov 2023 15:03:05 -0600
Message-ID: <20231115210305.3745138-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
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

