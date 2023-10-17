Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAF77CCE28
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343689AbjJQUfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbjJQUfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:35:50 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5304C4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:35:48 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1e9db321ed1so2660073fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697574948; x=1698179748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEKHT0qI1+WlzdtatENWMRpkRl1UGDjdgNPMaLXpSgE=;
        b=sxQkuvsR8YlaY/nYOZVKseamN7jS8JtOLXTCACx2CcIwC7REXzMpBIJVhfEeHeQooF
         BjwJ8/9Q4H5in1U46AktrMWJM1r8sCpYgbm8kdnUG1+xNFpshPGt4dxx66iGeJiMy/DV
         VZitVdMsl47k5ZQ19ppxjuHaFMRt3nVQGSf1xibRg74UVerw8W/2FtrWpgwAr9QV1dhm
         2WaF4/IBvZn9eiAJg0y4g22vDsRBfuNWgHQT6uCzQfLi+zXhfTz8TNltxedsxzzaZG8C
         H2sENpOGNAYNLAkJSWm7J7lhja9h9vgBERL0PLpbFlLOcaC53SH5rxfO7KDFqL32gzoG
         bSAQ==
X-Gm-Message-State: AOJu0YzB2udS1cOrdTOLWblN9zwXjiJDO3i6IWJV2GlBdGa65dkYuc7l
        tBm+9/CaOkiZ5DcNCKILQQ==
X-Google-Smtp-Source: AGHT+IGnFY3iBYrviNnboVBVK4LgJbEcA5hOSHP7k+Gpm0+UG7/34dic4sE+xtHoZNl6VRr1m8sKIQ==
X-Received: by 2002:a05:6870:d60b:b0:1e9:d158:2465 with SMTP id a11-20020a056870d60b00b001e9d1582465mr3718215oaq.17.1697574948208;
        Tue, 17 Oct 2023 13:35:48 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ds22-20020a0568705b1600b001ea689d8969sm396488oab.48.2023.10.17.13.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:35:47 -0700 (PDT)
Received: (nullmailer pid 2700551 invoked by uid 1000);
        Tue, 17 Oct 2023 20:35:46 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] mfd: motorola-cpcap: Drop unnecessary of_match_device() call
Date:   Tue, 17 Oct 2023 15:35:36 -0500
Message-ID: <20231017203537.2700340-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If probe is reached, we've already matched the device and in the case of
DT matching, the struct device_node pointer will be set. Therefore, there
is no need to call of_match_device() in probe.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/mfd/motorola-cpcap.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
index a19691ba8d8b..d8243b956f87 100644
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -11,7 +11,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
 #include <linux/sysfs.h>
 
@@ -290,14 +290,9 @@ static const struct mfd_cell cpcap_mfd_devices[] = {
 
 static int cpcap_probe(struct spi_device *spi)
 {
-	const struct of_device_id *match;
 	struct cpcap_ddata *cpcap;
 	int ret;
 
-	match = of_match_device(cpcap_of_match, &spi->dev);
-	if (!match)
-		return -ENODEV;
-
 	cpcap = devm_kzalloc(&spi->dev, sizeof(*cpcap), GFP_KERNEL);
 	if (!cpcap)
 		return -ENOMEM;
-- 
2.42.0

