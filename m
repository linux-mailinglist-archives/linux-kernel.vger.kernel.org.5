Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682137ED547
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344757AbjKOVDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbjKOVCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:02:54 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66005D6A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:02:37 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b2f507c03cso56162b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700082156; x=1700686956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+l4iWaR6h+VOkkOHlCg7l333+HWiuAX0svGEETkQvCE=;
        b=DPC6zyC+ndbPKo1C8ytBv3U7a9mGA7JPiOO+qOvqIWXLfLgXYnwGQA3Pg9ypbIFtA8
         /43rQMg8uo9b5Tag3d9gOZNpaU7q83SGffYhNoW7Txav/e3XbpGBoMOW0iazSMlMdnr6
         1fMIhjTbklteyJ+lpOzz2gF9gRxGdmPa6C41I3P7pXLbBcLZnR3nmn2K0b/Bba/Hqvfu
         R4YQHpmcG7Gt7pxnMq4BsPZS1Jcn9gSOCKJReBuGWuA7E/+/r0igji0Pov6ME674/IoQ
         7j8hIOGUdde8ft0rdfMe6MYR96nKgGKflOviThFRcJzqO6Qt7nbnMopFBisqA4dcSMRP
         nVWQ==
X-Gm-Message-State: AOJu0YxT7Osayf1Er6qd0aq5F5bqTSdbX4Pctm67hKTRfDr9cXvu7h7o
        2Lu2gnhHSZ7NipA/aD3/nQ==
X-Google-Smtp-Source: AGHT+IFySdlGGNcNzqz0BYk7uO+iI4jMX2mScewB9bsNEw9TYpdOk1K4TOv50GG0gPr+QUFIO+XP2g==
X-Received: by 2002:a05:6808:448d:b0:3b5:ae0d:b1f5 with SMTP id eq13-20020a056808448d00b003b5ae0db1f5mr16898152oib.50.1700082156694;
        Wed, 15 Nov 2023 13:02:36 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a9-20020a05680804c900b003b29c2f50f0sm1589471oie.18.2023.11.15.13.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 13:02:36 -0800 (PST)
Received: (nullmailer pid 3744363 invoked by uid 1000);
        Wed, 15 Nov 2023 21:02:35 -0000
From:   Rob Herring <robh@kernel.org>
To:     Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] ipmi: si: Use device_get_match_data()
Date:   Wed, 15 Nov 2023 15:02:29 -0600
Message-ID: <20231115210230.3744198-1-robh@kernel.org>
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
 drivers/char/ipmi/ipmi_si_platform.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
index c3d8ac7873ba..cd2edd8f8a03 100644
--- a/drivers/char/ipmi/ipmi_si_platform.c
+++ b/drivers/char/ipmi/ipmi_si_platform.c
@@ -11,10 +11,11 @@
 
 #include <linux/types.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/acpi.h>
 #include "ipmi_si.h"
 #include "ipmi_dmi.h"
@@ -224,7 +225,6 @@ MODULE_DEVICE_TABLE(of, of_ipmi_match);
 
 static int of_ipmi_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct si_sm_io io;
 	struct resource resource;
 	const __be32 *regsize, *regspacing, *regshift;
@@ -237,10 +237,6 @@ static int of_ipmi_probe(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "probing via device tree\n");
 
-	match = of_match_device(of_ipmi_match, &pdev->dev);
-	if (!match)
-		return -ENODEV;
-
 	if (!of_device_is_available(np))
 		return -EINVAL;
 
@@ -269,7 +265,7 @@ static int of_ipmi_probe(struct platform_device *pdev)
 	}
 
 	memset(&io, 0, sizeof(io));
-	io.si_type	= (unsigned long) match->data;
+	io.si_type	= (enum si_type)device_get_match_data(&pdev->dev);
 	io.addr_source	= SI_DEVICETREE;
 	io.irq_setup	= ipmi_std_irq_setup;
 
-- 
2.42.0

