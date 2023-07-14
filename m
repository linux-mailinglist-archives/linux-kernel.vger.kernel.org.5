Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B623D7541B8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbjGNRye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236499AbjGNRyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:54:01 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403C2422D;
        Fri, 14 Jul 2023 10:53:31 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-34637e55d8dso9316605ab.2;
        Fri, 14 Jul 2023 10:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357120; x=1691949120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTzcVBJWZ3FygfO4cCF34p+eZrcFm8fXrcWkJJkRg+4=;
        b=hz6pMEia4jYQqXWj9MAwlz6fbO70Ka295gSCypy+W9uUrjbUcVU2jmIiJNT7KXiGEq
         Hc4ESJtKa3izSLY7nutgh19SMB20rMfFzW5U0CiMnRUa6WMyDX2iPNEakwKs1ivbKKgb
         ClRct5C8YN7PKR3HWODyGmH39ZUzytE7RKFyoK9fB46AJyoloqAP4mJmqtcbyooV/8Vq
         TwiejJyOgsjU6+0WAUYGXJiDGzzVZ9nQWoT0gjKf1L/Ly98dZy1vYRSADNBeOCWG8e0W
         pNXNDxx/BHFxyOTSpa8SH7RYoWUVbijDHy0HkYyRI74ChfeRtrxM2kYgsq2s1GgA+NXp
         a0Eg==
X-Gm-Message-State: ABy/qLaVlN+8G68JJnaGL0RbPkE2VpFDm68l7YWcc5DRsuE5Gpg/rBsp
        C/Gi/93RxQI/U1jE8RCwCg==
X-Google-Smtp-Source: APBJJlGpJgoM+pVfwZn7OJWzOzIWz07PqgfABsQSmT1UwRrTyjoPvoB0A+qUcXRVic/HD+YI9+DzRg==
X-Received: by 2002:a05:6e02:109:b0:345:ad48:d160 with SMTP id t9-20020a056e02010900b00345ad48d160mr5022494ilm.17.1689357120622;
        Fri, 14 Jul 2023 10:52:00 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id ed26-20020a056638291a00b0042b451aa95esm2589606jab.150.2023.07.14.10.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:52:00 -0700 (PDT)
Received: (nullmailer pid 4067752 invoked by uid 1000);
        Fri, 14 Jul 2023 17:51:40 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] soc: microchip: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:51:38 -0600
Message-Id: <20230714175139.4067685-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
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
 drivers/soc/atmel/sfr.c                     | 1 -
 drivers/soc/microchip/mpfs-sys-controller.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/atmel/sfr.c b/drivers/soc/atmel/sfr.c
index 0525eef49d1a..cc94ca1b494c 100644
--- a/drivers/soc/atmel/sfr.c
+++ b/drivers/soc/atmel/sfr.c
@@ -10,7 +10,6 @@
 #include <linux/nvmem-provider.h>
 #include <linux/random.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/microchip/mpfs-sys-controller.c
index 216d9f4ea0ce..fbcd5fd24d7c 100644
--- a/drivers/soc/microchip/mpfs-sys-controller.c
+++ b/drivers/soc/microchip/mpfs-sys-controller.c
@@ -13,7 +13,7 @@
 #include <linux/module.h>
 #include <linux/jiffies.h>
 #include <linux/interrupt.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/mailbox_client.h>
 #include <linux/platform_device.h>
 #include <soc/microchip/mpfs.h>
-- 
2.40.1

