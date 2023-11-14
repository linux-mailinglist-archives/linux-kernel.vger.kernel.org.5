Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E429B7EB19B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjKNOJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjKNOJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:09:00 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A6118A;
        Tue, 14 Nov 2023 06:08:52 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32dcd3e5f3fso3499027f8f.1;
        Tue, 14 Nov 2023 06:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699970931; x=1700575731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTk1wDnmA9Ps5c2tCmXmxnWtTAEG7izLmI6R72fPwTM=;
        b=hvXk9lr91lhPiaLLOPEIKMyV5qKSCbzCennFf5KdLpPtPvWm3YTSjCODv19KaJsMCE
         k5fuRnczuSVIi2J5mQUOLRb3Y1WjGrvCUGtdDbfnQ5DZ0auRw+OONRkRBvPiLNzqZYGS
         GRI0vADKob7EJj5pox7hw9+Su5CB9BphSzPJwZnBB6chOE9ALw02IYgiANigj2EzJHRA
         0/LJEnxdw/Q2hti/aSlARb/FxjOBTba23gwc9qijPOFZnDDCb3CcaBAg5t1muC/OlXhT
         pnDISTLfCdcGwrCAT8ZcUj58PwrwXFODNlwqArudvpLDF5B1cuLSwAm3Gk5Arg38vw0H
         C79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699970931; x=1700575731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTk1wDnmA9Ps5c2tCmXmxnWtTAEG7izLmI6R72fPwTM=;
        b=blKy1hJIltEi41/CYn75wGX+TBAf6BstK6/sw1Leqg5BsAX9G5QHLQG6b7u3PWCP6/
         R2Ch49+4MLBRgtwHkUtCIFiPqe8wLP48+Gfw6F/JReScqnJHGGjT0gK8elXchQdPFhwb
         0U4QqdQ21z3wUdLsf8GtdvRqMfrhS1ljgXuBxP4KWO/VJwhWe0xGl6ULdE2bx6lgOGAJ
         ja3xxifDeBqNA1JmGSObsH9R3OV7Tkm1GxL6hcxCBlLSVZU9xSSOiDxuCAyWFB18JIGq
         E7eAjehcyNtai6LcrAbObL9UjAvz+DxJkgtE8Ww5flqpMZQj6T3NEbgIKFX9aDVEfsSk
         nYbA==
X-Gm-Message-State: AOJu0Yy72QnM4BktqwI52bG1l/4J0IWhu9ymNC0bu1zZWBducuQAWnek
        zCWgGkp7vYxtn0af4kIC5Gs=
X-Google-Smtp-Source: AGHT+IFFcZ8fTek7GdQnrRdQt5Y9l73BTPukIEN67o0JKZfkP46BcJZg7SpQovVTsF/p+IGcps2kpQ==
X-Received: by 2002:a5d:4574:0:b0:32f:b902:e018 with SMTP id a20-20020a5d4574000000b0032fb902e018mr5966373wrc.25.1699970930602;
        Tue, 14 Nov 2023 06:08:50 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id q2-20020adf9dc2000000b0032db4825495sm8014603wre.22.2023.11.14.06.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 06:08:50 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [net-next PATCH v8 2/4] net: phy: aquantia: move MMD_VEND define to header
Date:   Tue, 14 Nov 2023 15:08:42 +0100
Message-Id: <20231114140844.9596-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231114140844.9596-1-ansuelsmth@gmail.com>
References: <20231114140844.9596-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move MMD_VEND define to header to clean things up and in preparation for
firmware loading support that require some define placed in
aquantia_main.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Changes v8:
- Out of RFC
Changes v4:
- Add Reviewed-by tag
Changes v3:
- Add this patch

 drivers/net/phy/aquantia/aquantia.h       | 69 +++++++++++++++++++++++
 drivers/net/phy/aquantia/aquantia_hwmon.c | 14 -----
 drivers/net/phy/aquantia/aquantia_main.c  | 55 ------------------
 3 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
index c684b65c642c..f0c767c4fad1 100644
--- a/drivers/net/phy/aquantia/aquantia.h
+++ b/drivers/net/phy/aquantia/aquantia.h
@@ -9,6 +9,75 @@
 #include <linux/device.h>
 #include <linux/phy.h>
 
+/* Vendor specific 1, MDIO_MMD_VEND1 */
+#define VEND1_GLOBAL_FW_ID			0x0020
+#define VEND1_GLOBAL_FW_ID_MAJOR		GENMASK(15, 8)
+#define VEND1_GLOBAL_FW_ID_MINOR		GENMASK(7, 0)
+
+/* The following registers all have similar layouts; first the registers... */
+#define VEND1_GLOBAL_CFG_10M			0x0310
+#define VEND1_GLOBAL_CFG_100M			0x031b
+#define VEND1_GLOBAL_CFG_1G			0x031c
+#define VEND1_GLOBAL_CFG_2_5G			0x031d
+#define VEND1_GLOBAL_CFG_5G			0x031e
+#define VEND1_GLOBAL_CFG_10G			0x031f
+/* ...and now the fields */
+#define VEND1_GLOBAL_CFG_RATE_ADAPT		GENMASK(8, 7)
+#define VEND1_GLOBAL_CFG_RATE_ADAPT_NONE	0
+#define VEND1_GLOBAL_CFG_RATE_ADAPT_USX		1
+#define VEND1_GLOBAL_CFG_RATE_ADAPT_PAUSE	2
+
+/* Vendor specific 1, MDIO_MMD_VEND2 */
+#define VEND1_THERMAL_PROV_HIGH_TEMP_FAIL	0xc421
+#define VEND1_THERMAL_PROV_LOW_TEMP_FAIL	0xc422
+#define VEND1_THERMAL_PROV_HIGH_TEMP_WARN	0xc423
+#define VEND1_THERMAL_PROV_LOW_TEMP_WARN	0xc424
+#define VEND1_THERMAL_STAT1			0xc820
+#define VEND1_THERMAL_STAT2			0xc821
+#define VEND1_THERMAL_STAT2_VALID		BIT(0)
+#define VEND1_GENERAL_STAT1			0xc830
+#define VEND1_GENERAL_STAT1_HIGH_TEMP_FAIL	BIT(14)
+#define VEND1_GENERAL_STAT1_LOW_TEMP_FAIL	BIT(13)
+#define VEND1_GENERAL_STAT1_HIGH_TEMP_WARN	BIT(12)
+#define VEND1_GENERAL_STAT1_LOW_TEMP_WARN	BIT(11)
+
+#define VEND1_GLOBAL_GEN_STAT2			0xc831
+#define VEND1_GLOBAL_GEN_STAT2_OP_IN_PROG	BIT(15)
+
+#define VEND1_GLOBAL_RSVD_STAT1			0xc885
+#define VEND1_GLOBAL_RSVD_STAT1_FW_BUILD_ID	GENMASK(7, 4)
+#define VEND1_GLOBAL_RSVD_STAT1_PROV_ID		GENMASK(3, 0)
+
+#define VEND1_GLOBAL_RSVD_STAT9			0xc88d
+#define VEND1_GLOBAL_RSVD_STAT9_MODE		GENMASK(7, 0)
+#define VEND1_GLOBAL_RSVD_STAT9_1000BT2		0x23
+
+#define VEND1_GLOBAL_INT_STD_STATUS		0xfc00
+#define VEND1_GLOBAL_INT_VEND_STATUS		0xfc01
+
+#define VEND1_GLOBAL_INT_STD_MASK		0xff00
+#define VEND1_GLOBAL_INT_STD_MASK_PMA1		BIT(15)
+#define VEND1_GLOBAL_INT_STD_MASK_PMA2		BIT(14)
+#define VEND1_GLOBAL_INT_STD_MASK_PCS1		BIT(13)
+#define VEND1_GLOBAL_INT_STD_MASK_PCS2		BIT(12)
+#define VEND1_GLOBAL_INT_STD_MASK_PCS3		BIT(11)
+#define VEND1_GLOBAL_INT_STD_MASK_PHY_XS1	BIT(10)
+#define VEND1_GLOBAL_INT_STD_MASK_PHY_XS2	BIT(9)
+#define VEND1_GLOBAL_INT_STD_MASK_AN1		BIT(8)
+#define VEND1_GLOBAL_INT_STD_MASK_AN2		BIT(7)
+#define VEND1_GLOBAL_INT_STD_MASK_GBE		BIT(6)
+#define VEND1_GLOBAL_INT_STD_MASK_ALL		BIT(0)
+
+#define VEND1_GLOBAL_INT_VEND_MASK		0xff01
+#define VEND1_GLOBAL_INT_VEND_MASK_PMA		BIT(15)
+#define VEND1_GLOBAL_INT_VEND_MASK_PCS		BIT(14)
+#define VEND1_GLOBAL_INT_VEND_MASK_PHY_XS	BIT(13)
+#define VEND1_GLOBAL_INT_VEND_MASK_AN		BIT(12)
+#define VEND1_GLOBAL_INT_VEND_MASK_GBE		BIT(11)
+#define VEND1_GLOBAL_INT_VEND_MASK_GLOBAL1	BIT(2)
+#define VEND1_GLOBAL_INT_VEND_MASK_GLOBAL2	BIT(1)
+#define VEND1_GLOBAL_INT_VEND_MASK_GLOBAL3	BIT(0)
+
 #if IS_REACHABLE(CONFIG_HWMON)
 int aqr_hwmon_probe(struct phy_device *phydev);
 #else
diff --git a/drivers/net/phy/aquantia/aquantia_hwmon.c b/drivers/net/phy/aquantia/aquantia_hwmon.c
index 0da451e46f69..7b3c49c3bf49 100644
--- a/drivers/net/phy/aquantia/aquantia_hwmon.c
+++ b/drivers/net/phy/aquantia/aquantia_hwmon.c
@@ -13,20 +13,6 @@
 
 #include "aquantia.h"
 
-/* Vendor specific 1, MDIO_MMD_VEND2 */
-#define VEND1_THERMAL_PROV_HIGH_TEMP_FAIL	0xc421
-#define VEND1_THERMAL_PROV_LOW_TEMP_FAIL	0xc422
-#define VEND1_THERMAL_PROV_HIGH_TEMP_WARN	0xc423
-#define VEND1_THERMAL_PROV_LOW_TEMP_WARN	0xc424
-#define VEND1_THERMAL_STAT1			0xc820
-#define VEND1_THERMAL_STAT2			0xc821
-#define VEND1_THERMAL_STAT2_VALID		BIT(0)
-#define VEND1_GENERAL_STAT1			0xc830
-#define VEND1_GENERAL_STAT1_HIGH_TEMP_FAIL	BIT(14)
-#define VEND1_GENERAL_STAT1_LOW_TEMP_FAIL	BIT(13)
-#define VEND1_GENERAL_STAT1_HIGH_TEMP_WARN	BIT(12)
-#define VEND1_GENERAL_STAT1_LOW_TEMP_WARN	BIT(11)
-
 #if IS_REACHABLE(CONFIG_HWMON)
 
 static umode_t aqr_hwmon_is_visible(const void *data,
diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 334a6904ca5a..4498426e9a52 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -91,61 +91,6 @@
 #define MDIO_C22EXT_STAT_SGMII_TX_FRAME_ALIGN_ERR	0xd31a
 #define MDIO_C22EXT_STAT_SGMII_TX_RUNT_FRAMES		0xd31b
 
-/* Vendor specific 1, MDIO_MMD_VEND1 */
-#define VEND1_GLOBAL_FW_ID			0x0020
-#define VEND1_GLOBAL_FW_ID_MAJOR		GENMASK(15, 8)
-#define VEND1_GLOBAL_FW_ID_MINOR		GENMASK(7, 0)
-
-#define VEND1_GLOBAL_GEN_STAT2			0xc831
-#define VEND1_GLOBAL_GEN_STAT2_OP_IN_PROG	BIT(15)
-
-/* The following registers all have similar layouts; first the registers... */
-#define VEND1_GLOBAL_CFG_10M			0x0310
-#define VEND1_GLOBAL_CFG_100M			0x031b
-#define VEND1_GLOBAL_CFG_1G			0x031c
-#define VEND1_GLOBAL_CFG_2_5G			0x031d
-#define VEND1_GLOBAL_CFG_5G			0x031e
-#define VEND1_GLOBAL_CFG_10G			0x031f
-/* ...and now the fields */
-#define VEND1_GLOBAL_CFG_RATE_ADAPT		GENMASK(8, 7)
-#define VEND1_GLOBAL_CFG_RATE_ADAPT_NONE	0
-#define VEND1_GLOBAL_CFG_RATE_ADAPT_USX		1
-#define VEND1_GLOBAL_CFG_RATE_ADAPT_PAUSE	2
-
-#define VEND1_GLOBAL_RSVD_STAT1			0xc885
-#define VEND1_GLOBAL_RSVD_STAT1_FW_BUILD_ID	GENMASK(7, 4)
-#define VEND1_GLOBAL_RSVD_STAT1_PROV_ID		GENMASK(3, 0)
-
-#define VEND1_GLOBAL_RSVD_STAT9			0xc88d
-#define VEND1_GLOBAL_RSVD_STAT9_MODE		GENMASK(7, 0)
-#define VEND1_GLOBAL_RSVD_STAT9_1000BT2		0x23
-
-#define VEND1_GLOBAL_INT_STD_STATUS		0xfc00
-#define VEND1_GLOBAL_INT_VEND_STATUS		0xfc01
-
-#define VEND1_GLOBAL_INT_STD_MASK		0xff00
-#define VEND1_GLOBAL_INT_STD_MASK_PMA1		BIT(15)
-#define VEND1_GLOBAL_INT_STD_MASK_PMA2		BIT(14)
-#define VEND1_GLOBAL_INT_STD_MASK_PCS1		BIT(13)
-#define VEND1_GLOBAL_INT_STD_MASK_PCS2		BIT(12)
-#define VEND1_GLOBAL_INT_STD_MASK_PCS3		BIT(11)
-#define VEND1_GLOBAL_INT_STD_MASK_PHY_XS1	BIT(10)
-#define VEND1_GLOBAL_INT_STD_MASK_PHY_XS2	BIT(9)
-#define VEND1_GLOBAL_INT_STD_MASK_AN1		BIT(8)
-#define VEND1_GLOBAL_INT_STD_MASK_AN2		BIT(7)
-#define VEND1_GLOBAL_INT_STD_MASK_GBE		BIT(6)
-#define VEND1_GLOBAL_INT_STD_MASK_ALL		BIT(0)
-
-#define VEND1_GLOBAL_INT_VEND_MASK		0xff01
-#define VEND1_GLOBAL_INT_VEND_MASK_PMA		BIT(15)
-#define VEND1_GLOBAL_INT_VEND_MASK_PCS		BIT(14)
-#define VEND1_GLOBAL_INT_VEND_MASK_PHY_XS	BIT(13)
-#define VEND1_GLOBAL_INT_VEND_MASK_AN		BIT(12)
-#define VEND1_GLOBAL_INT_VEND_MASK_GBE		BIT(11)
-#define VEND1_GLOBAL_INT_VEND_MASK_GLOBAL1	BIT(2)
-#define VEND1_GLOBAL_INT_VEND_MASK_GLOBAL2	BIT(1)
-#define VEND1_GLOBAL_INT_VEND_MASK_GLOBAL3	BIT(0)
-
 /* Sleep and timeout for checking if the Processor-Intensive
  * MDIO operation is finished
  */
-- 
2.40.1

