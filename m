Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BD77AC724
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 10:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjIXITW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 04:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjIXITU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 04:19:20 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77FCD3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 01:19:13 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50317080342so7429392e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 01:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695543552; x=1696148352; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1hHLqx//+KHKke7RxCV9Yuyp7jdtEnxin017FD+uo04=;
        b=j5sXX0y9otl1g2XHDtxW2ZZalq5xYNivaSQ8SC0z0+ojPDPmwsajQO6vg4MOyrLBXE
         J68QpllXYRSs7lE6dLGUJAZe501gxmQm3h6/kJHHGffTIxZMKlukEP5MzEV7A9Pllbm4
         YIpOvuVVgrIn7m95jBUQKLnQF0MUpG6o7Q8biARUrYs1858qE21xaGRmbi4MYi1bYGVW
         O4CLuHb0P1Q55hEbRhk+J/SMOfqXBlFUVW+Mr5k079o/5Ji92q947QwdhWftGQzUhbQQ
         AbJTizFNYQuFUaSLSVL0L3N+Je0H7wvTEq4h201tHcpBZaRY9krvunS/Y/M9Zo8I00+4
         f91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695543552; x=1696148352;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1hHLqx//+KHKke7RxCV9Yuyp7jdtEnxin017FD+uo04=;
        b=g0dAH0MDbFPqZOhKzOK+l+xDCub+Nu/o7xwrMp9ukdI7oVEY2LCV3GcRJYVSBdQa8I
         PGNluHoc8VbvtnVrL5n5AvZQgK68zELYPTPsm5kW+VCbjobhgAKRhVMVtVlKDZ0BPNcm
         S9G+LUZA1N17PX6x/pDS9aVmbu0qwXFmPHrvXnWx5HQ5b/UaKOEz3883uI3EZ4lb/JDM
         U8qPkmNDz+VzT9x+APYWcG148z6TRHGFXPqq1qP8CRlVqORE75RxkOpQqoqE3oFWSkwX
         L4DKKgzFDvuF2BTZzPEt4v366JqT71T+78Td0fOcl/UmLtDDxezEX1hw4ly86ENL4qI8
         xPVg==
X-Gm-Message-State: AOJu0YxC88Yk/tK8Yyjl1dUPybvYySzb89Nd9ZsNoYBtY3z9Ml3Iqe+v
        p5iYtpm7HR+dYUnlwJQ1aG1YLA==
X-Google-Smtp-Source: AGHT+IHGm7AQbFXuimot0EDmqmJRuWEsigBLLH9wurZI26YcE210hwvBjgQtg2QBwug/Mmho6/dcrw==
X-Received: by 2002:a05:6512:546:b0:503:2dce:4544 with SMTP id h6-20020a056512054600b005032dce4544mr2945667lfl.59.1695543551864;
        Sun, 24 Sep 2023 01:19:11 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id c19-20020a197613000000b005033948f108sm1335674lff.272.2023.09.24.01.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 01:19:11 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 24 Sep 2023 10:19:02 +0200
Subject: [PATCH net-next] net: phy: amd: Support the Altima AMI101L
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230924-ac101l-phy-v1-1-5e6349e28aa4@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPXwD2UC/x3MwQpAQBRG4VfRXbt1Z5B4FVlM/LiloRmJ5N1Nl
 t/inIcigiJSmz0UcGrUzSeYPKNhcX4G65hMVmwhjS3ZDUbMyvtycy0lGiemsqgoBXvApNc/68j
 jYI/roP59P/FOBkZmAAAA
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Altima AC101L is obviously compatible with the AMD PHY,
as seen by reading the datasheet.

Datasheet: https://docs.broadcom.com/doc/AC101L-DS05-405-RDS.pdf

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/phy/Kconfig |  4 ++--
 drivers/net/phy/amd.c   | 33 +++++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 107880d13d21..421d2b62918f 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -69,9 +69,9 @@ config SFP
 comment "MII PHY device drivers"
 
 config AMD_PHY
-	tristate "AMD PHYs"
+	tristate "AMD and Altima PHYs"
 	help
-	  Currently supports the am79c874
+	  Currently supports the AMD am79c874 and Altima AC101L.
 
 config MESON_GXL_PHY
 	tristate "Amlogic Meson GXL Internal PHY"
diff --git a/drivers/net/phy/amd.c b/drivers/net/phy/amd.c
index 001bb6d8bfce..930b15fa6ce9 100644
--- a/drivers/net/phy/amd.c
+++ b/drivers/net/phy/amd.c
@@ -13,6 +13,7 @@
 #include <linux/mii.h>
 #include <linux/phy.h>
 
+#define PHY_ID_AC101L		0x00225520
 #define PHY_ID_AM79C874		0x0022561b
 
 #define MII_AM79C_IR		17	/* Interrupt Status/Control Register */
@@ -87,19 +88,31 @@ static irqreturn_t am79c_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }
 
-static struct phy_driver am79c_driver[] = { {
-	.phy_id		= PHY_ID_AM79C874,
-	.name		= "AM79C874",
-	.phy_id_mask	= 0xfffffff0,
-	/* PHY_BASIC_FEATURES */
-	.config_init	= am79c_config_init,
-	.config_intr	= am79c_config_intr,
-	.handle_interrupt = am79c_handle_interrupt,
-} };
+static struct phy_driver am79c_drivers[] = {
+	{
+		.phy_id		= PHY_ID_AM79C874,
+		.name		= "AM79C874",
+		.phy_id_mask	= 0xfffffff0,
+		/* PHY_BASIC_FEATURES */
+		.config_init	= am79c_config_init,
+		.config_intr	= am79c_config_intr,
+		.handle_interrupt = am79c_handle_interrupt,
+	},
+	{
+		.phy_id		= PHY_ID_AC101L,
+		.name		= "AC101L",
+		.phy_id_mask	= 0xfffffff0,
+		/* PHY_BASIC_FEATURES */
+		.config_init	= am79c_config_init,
+		.config_intr	= am79c_config_intr,
+		.handle_interrupt = am79c_handle_interrupt,
+	},
+};
 
-module_phy_driver(am79c_driver);
+module_phy_driver(am79c_drivers);
 
 static struct mdio_device_id __maybe_unused amd_tbl[] = {
+	{ PHY_ID_AC101L, 0xfffffff0 },
 	{ PHY_ID_AM79C874, 0xfffffff0 },
 	{ }
 };

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230924-ac101l-phy-704e9a0152e5

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

