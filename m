Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AB97541F3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbjGNR7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbjGNR6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:58:36 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D053C22;
        Fri, 14 Jul 2023 10:58:09 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7872d448c5aso90289839f.0;
        Fri, 14 Jul 2023 10:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357118; x=1691949118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbnWXAP6JBrW+dHGKwXKkOfj8OfWH0aRyqnE7uTJeWs=;
        b=aODUPDw0eoHBj18TjlcxSfLEDixS/oBrXQmLWZbYgSdAUTwj747iNumRW2DZMBdnre
         lmk0zhJBsn6k1yGv2wsa0RYYphWhTX/FSR1ILH5HaDJm6EDchlFV7+rR2UPC1ea7BBvW
         GG5fLujFPkli2GNhWkkeUC+/nYAgIBJ+QMUch2alUcFSCBeQHFU4idKTPADrELKdQGHL
         Z7AfUqldhCl2oI8K6i6WjkApmGKC85BeW21bJClaIRnEY4JSsW7qIUrWrgK8hxZrE489
         7h276ac2YF1Kfe0sP5p3Nb8PTEbYO5Lh8LJY8wUYqx8jBi0o51vO1WS3rM7FogG0S8Gy
         dXjQ==
X-Gm-Message-State: ABy/qLYQ/fciCIfMZP9oA9K2kSZP3mXdfiFBAUatnSUAD9ySeWmPYi7/
        wKp3yAppkYuNyNUR8lRYDw==
X-Google-Smtp-Source: APBJJlFH2dqRNFNmY4eF86k3IcG5y+s8DPiZ/Ue6nMPz4EC0ut7JoIFqrEm1IKWNxSfwo+867jK3BA==
X-Received: by 2002:a5e:8b49:0:b0:785:ca70:46a2 with SMTP id z9-20020a5e8b49000000b00785ca7046a2mr6042928iom.4.1689357118670;
        Fri, 14 Jul 2023 10:51:58 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id u8-20020a5edd48000000b007862c74cec6sm2797330iop.1.2023.07.14.10.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:51:57 -0700 (PDT)
Received: (nullmailer pid 4067296 invoked by uid 1000);
        Fri, 14 Jul 2023 17:51:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: bcm: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:51:29 -0600
Message-Id: <20230714175130.4067236-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/soc/bcm/bcm63xx/bcm-pmb.c       | 1 -
 drivers/soc/bcm/bcm63xx/bcm63xx-power.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/soc/bcm/bcm63xx/bcm-pmb.c b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
index 9407cac47fdb..a72ba26ecf9d 100644
--- a/drivers/soc/bcm/bcm63xx/bcm-pmb.c
+++ b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
@@ -8,7 +8,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/reset/bcm63xx_pmb.h>
diff --git a/drivers/soc/bcm/bcm63xx/bcm63xx-power.c b/drivers/soc/bcm/bcm63xx/bcm63xx-power.c
index aa72e13d5d0e..98b0c2430dbc 100644
--- a/drivers/soc/bcm/bcm63xx/bcm63xx-power.c
+++ b/drivers/soc/bcm/bcm63xx/bcm63xx-power.c
@@ -14,7 +14,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 struct bcm63xx_power_dev {
 	struct generic_pm_domain genpd;
-- 
2.40.1

