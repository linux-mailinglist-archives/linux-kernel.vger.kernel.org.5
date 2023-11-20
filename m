Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF0D7F14B9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjKTNvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjKTNvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:51:20 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08EC11A;
        Mon, 20 Nov 2023 05:51:14 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40842752c6eso16249175e9.1;
        Mon, 20 Nov 2023 05:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700488273; x=1701093073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=170V99bF9fbfKYiUs+utHt6sltSk5a5hRXsRWfq9j/0=;
        b=HmIofVy08rNlatvNMXCD1zP9m32NF/HRYHJPkmME4lW12R6gx5PEUZUBS241lu5nUy
         RzWaI9KiGaLqyzJI64PvQ5QJbJ+FENq34VvjfbA85INHniRuOWKEarLY0uE/vA7zUHIq
         nE6UFB8LkVnL1IiUaPva7nKrYLzOKlGlGaOci3AfrB7GkWozQNV+aLgspMLzZ40geFyM
         V0+qQ4zgb92UPCNwxPcT96Zg1WNCt+ea/Nxcl8aZwY4qDmSpd8Gc1irT378+8gIFBMjU
         8YF0Fb6WXm3AXgIMhUnCMZwhKHS+Wn1n/4KoYSsYNxBu43abStCifCSkqW68JaIMIaJ8
         vGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700488273; x=1701093073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=170V99bF9fbfKYiUs+utHt6sltSk5a5hRXsRWfq9j/0=;
        b=RPw9qwxO4FTGwRxizaPfELUWdEJvXv/5Z4bnynsyAH4p+lEb4N5Op8iI6j7aqdbkmz
         uNfMsuEn8BNCIuDViUuNh9zuHNss7KvOHhsTZDMNn8oVIkeh+/D9Y/NGcP4FoJQQeHYu
         x8EimvLVLESSYUMoCH/doQWehn5dpcnE37FMTtG3vRNZamL29I0lZk5Q5heJ/QK2OR2o
         DINqZcZs8RFCKWmEdpvg5nULn5ZmGMzTtYEtjfRk3Jk/cIZK4EGwiGUYSLvYckrk/jHz
         qvRT9/I62dZ3/E6e0VLSwct2W7NHE4GeQ5idvYsRttu9SfsL9iBcmsLqeYYLG2nNJb4r
         xWVw==
X-Gm-Message-State: AOJu0Yw3YHiO7Zov6UN43ckVkQppZ6FacvWRtsMynGotejUWzH2/BM82
        815Qgm6sEIVUmE2ZrBCgirE=
X-Google-Smtp-Source: AGHT+IFTkDfxMNb1b6FZQ9MepE/DjOHpjkTOnj3b3hIBgk5iYkgdd79aYf85OFwnUYWEh7hwYf5COA==
X-Received: by 2002:a05:600c:4445:b0:407:8e85:899f with SMTP id v5-20020a05600c444500b004078e85899fmr6518168wmn.16.1700488272715;
        Mon, 20 Nov 2023 05:51:12 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j33-20020a05600c1c2100b0040772934b12sm18205846wms.7.2023.11.20.05.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 05:51:12 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        Simon Horman <horms@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [net-next RFC PATCH 01/14] net: phy: extend PHY package API to support multiple global address
Date:   Mon, 20 Nov 2023 14:50:28 +0100
Message-Id: <20231120135041.15259-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231120135041.15259-1-ansuelsmth@gmail.com>
References: <20231120135041.15259-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current API for PHY package are limited to single address to configure
global settings for the PHY package.

It was found that some PHY package (for example the qca807x, a PHY
package that is shipped with a bundle of 5 PHY) require multiple PHY
address to configure global settings. An example scenario is a PHY that
have a dedicated PHY for PSGMII/serdes calibrarion and have a specific
PHY in the package where the global PHY mode is set and affects every
other PHY in the package.

Change the API in the following way:
- Make phy_package_join() require a list of address to be passed and the
  number of address in the list
- On shared data init, each address is the list is checked and added to
  the shared struct.
- Make __/phy_package_write/read() require an additional arg that
  select what global PHY address to use in the provided list.

Each user of this API is updated to follow this new implementation
following a pattern where an enum is defined to declare the index of the
addr and the addr list is passed.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/bcm54140.c        | 23 +++++++--
 drivers/net/phy/mediatek-ge-soc.c | 11 +++-
 drivers/net/phy/micrel.c          | 13 +++--
 drivers/net/phy/mscc/mscc.h       |  7 +++
 drivers/net/phy/mscc/mscc_main.c  | 16 ++++--
 drivers/net/phy/phy_device.c      | 85 ++++++++++++++++++++-----------
 include/linux/phy.h               | 51 +++++++++++++------
 7 files changed, 147 insertions(+), 59 deletions(-)

diff --git a/drivers/net/phy/bcm54140.c b/drivers/net/phy/bcm54140.c
index d43076592f81..89c735b386d3 100644
--- a/drivers/net/phy/bcm54140.c
+++ b/drivers/net/phy/bcm54140.c
@@ -128,6 +128,12 @@
 #define BCM54140_DEFAULT_DOWNSHIFT 5
 #define BCM54140_MAX_DOWNSHIFT 9
 
+enum bcm54140_global_phy {
+	BCM54140_BASE_ADDR = 0,
+
+	__BCM54140_GLOBAL_PHY_MAX,
+};
+
 struct bcm54140_priv {
 	int port;
 	int base_addr;
@@ -429,11 +435,13 @@ static int bcm54140_base_read_rdb(struct phy_device *phydev, u16 rdb)
 	int ret;
 
 	phy_lock_mdio_bus(phydev);
-	ret = __phy_package_write(phydev, MII_BCM54XX_RDB_ADDR, rdb);
+	ret = __phy_package_write(phydev, BCM54140_BASE_ADDR,
+				  MII_BCM54XX_RDB_ADDR, rdb);
 	if (ret < 0)
 		goto out;
 
-	ret = __phy_package_read(phydev, MII_BCM54XX_RDB_DATA);
+	ret = __phy_package_read(phydev, BCM54140_BASE_ADDR,
+				 MII_BCM54XX_RDB_DATA);
 
 out:
 	phy_unlock_mdio_bus(phydev);
@@ -446,11 +454,13 @@ static int bcm54140_base_write_rdb(struct phy_device *phydev,
 	int ret;
 
 	phy_lock_mdio_bus(phydev);
-	ret = __phy_package_write(phydev, MII_BCM54XX_RDB_ADDR, rdb);
+	ret = __phy_package_write(phydev, BCM54140_BASE_ADDR,
+				  MII_BCM54XX_RDB_ADDR, rdb);
 	if (ret < 0)
 		goto out;
 
-	ret = __phy_package_write(phydev, MII_BCM54XX_RDB_DATA, val);
+	ret = __phy_package_write(phydev, BCM54140_BASE_ADDR,
+				  MII_BCM54XX_RDB_DATA, val);
 
 out:
 	phy_unlock_mdio_bus(phydev);
@@ -570,6 +580,7 @@ static int bcm54140_get_base_addr_and_port(struct phy_device *phydev)
 
 static int bcm54140_probe(struct phy_device *phydev)
 {
+	int addrs[__BCM54140_GLOBAL_PHY_MAX];
 	struct bcm54140_priv *priv;
 	int ret;
 
@@ -583,7 +594,9 @@ static int bcm54140_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	devm_phy_package_join(&phydev->mdio.dev, phydev, priv->base_addr, 0);
+	addrs[BCM54140_BASE_ADDR] = priv->base_addr;
+	devm_phy_package_join(&phydev->mdio.dev, phydev, addrs,
+			      ARRAY_SIZE(addrs), 0);
 
 #if IS_ENABLED(CONFIG_HWMON)
 	mutex_init(&priv->alarm_lock);
diff --git a/drivers/net/phy/mediatek-ge-soc.c b/drivers/net/phy/mediatek-ge-soc.c
index 8a20d9889f10..3f2043fe05ed 100644
--- a/drivers/net/phy/mediatek-ge-soc.c
+++ b/drivers/net/phy/mediatek-ge-soc.c
@@ -298,6 +298,12 @@ struct mtk_socphy_priv {
 	unsigned long		led_state;
 };
 
+enum mtk_global_phy {
+	MTK_BASE_ADDR = 0,
+
+	__MTK_GLOBAL_PHY_MAX
+};
+
 struct mtk_socphy_shared {
 	u32			boottrap;
 	struct mtk_socphy_priv	priv[4];
@@ -1431,13 +1437,16 @@ static void mt798x_phy_leds_state_init(struct phy_device *phydev)
 static int mt7988_phy_probe(struct phy_device *phydev)
 {
 	struct mtk_socphy_shared *shared;
+	int addrs[__MTK_GLOBAL_PHY_MAX];
 	struct mtk_socphy_priv *priv;
 	int err;
 
 	if (phydev->mdio.addr > 3)
 		return -EINVAL;
 
-	err = devm_phy_package_join(&phydev->mdio.dev, phydev, 0,
+	addrs[MTK_BASE_ADDR] = 0;
+	err = devm_phy_package_join(&phydev->mdio.dev, phydev,
+				    addrs, ARRAY_SIZE(addrs),
 				    sizeof(struct mtk_socphy_shared));
 	if (err)
 		return err;
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 08e3915001c3..94a4c7d9ae9c 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -328,6 +328,12 @@ struct kszphy_ptp_priv {
 	spinlock_t seconds_lock;
 };
 
+enum ksz_global_phy {
+	KSZ_BASE_ADDR = 0,
+
+	__KZS_GLOBAL_PHY_MAX,
+};
+
 struct kszphy_priv {
 	struct kszphy_ptp_priv ptp_priv;
 	const struct kszphy_type *type;
@@ -3274,8 +3280,8 @@ static int lan8814_release_coma_mode(struct phy_device *phydev)
 static int lan8814_probe(struct phy_device *phydev)
 {
 	const struct kszphy_type *type = phydev->drv->driver_data;
+	int addrs[__KZS_GLOBAL_PHY_MAX];
 	struct kszphy_priv *priv;
-	u16 addr;
 	int err;
 
 	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
@@ -3291,9 +3297,10 @@ static int lan8814_probe(struct phy_device *phydev)
 	/* Strap-in value for PHY address, below register read gives starting
 	 * phy address value
 	 */
-	addr = lanphy_read_page_reg(phydev, 4, 0) & 0x1F;
+	addrs[KSZ_BASE_ADDR] = lanphy_read_page_reg(phydev, 4, 0) & 0x1F;
 	devm_phy_package_join(&phydev->mdio.dev, phydev,
-			      addr, sizeof(struct lan8814_shared_priv));
+			      addrs, ARRAY_SIZE(addrs),
+			      sizeof(struct lan8814_shared_priv));
 
 	if (phy_package_init_once(phydev)) {
 		err = lan8814_release_coma_mode(phydev);
diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
index 7a962050a4d4..88da8eca2b94 100644
--- a/drivers/net/phy/mscc/mscc.h
+++ b/drivers/net/phy/mscc/mscc.h
@@ -416,6 +416,13 @@ struct vsc8531_private {
  * gpio_lock: used for PHC operations. Common for all PHYs as the load/save GPIO
  * is shared.
  */
+
+enum vsc85xx_global_phy {
+	VSC88XX_BASE_ADDR = 0,
+
+	__VSC8XX_GLOBAL_PHY_MAX,
+};
+
 struct vsc85xx_shared_private {
 	struct mutex gpio_lock;
 };
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 4171f01d34e5..749d4a6be60c 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -711,7 +711,7 @@ int phy_base_write(struct phy_device *phydev, u32 regnum, u16 val)
 		dump_stack();
 	}
 
-	return __phy_package_write(phydev, regnum, val);
+	return __phy_package_write(phydev, VSC88XX_BASE_ADDR, regnum, val);
 }
 
 /* phydev->bus->mdio_lock should be locked when using this function */
@@ -722,7 +722,7 @@ int phy_base_read(struct phy_device *phydev, u32 regnum)
 		dump_stack();
 	}
 
-	return __phy_package_read(phydev, regnum);
+	return __phy_package_read(phydev, VSC88XX_BASE_ADDR, regnum);
 }
 
 u32 vsc85xx_csr_read(struct phy_device *phydev,
@@ -2204,6 +2204,7 @@ static int vsc85xx_read_status(struct phy_device *phydev)
 
 static int vsc8514_probe(struct phy_device *phydev)
 {
+	int addrs[__VSC8XX_GLOBAL_PHY_MAX];
 	struct vsc8531_private *vsc8531;
 	u32 default_mode[4] = {VSC8531_LINK_1000_ACTIVITY,
 	   VSC8531_LINK_100_ACTIVITY, VSC8531_LINK_ACTIVITY,
@@ -2216,8 +2217,9 @@ static int vsc8514_probe(struct phy_device *phydev)
 	phydev->priv = vsc8531;
 
 	vsc8584_get_base_addr(phydev);
+	addrs[VSC88XX_BASE_ADDR] = vsc8531->base_addr;
 	devm_phy_package_join(&phydev->mdio.dev, phydev,
-			      vsc8531->base_addr, 0);
+			      addrs, ARRAY_SIZE(addrs), 0);
 
 	vsc8531->nleds = 4;
 	vsc8531->supp_led_modes = VSC85XX_SUPP_LED_MODES;
@@ -2233,6 +2235,7 @@ static int vsc8514_probe(struct phy_device *phydev)
 
 static int vsc8574_probe(struct phy_device *phydev)
 {
+	int addrs[__VSC8XX_GLOBAL_PHY_MAX];
 	struct vsc8531_private *vsc8531;
 	u32 default_mode[4] = {VSC8531_LINK_1000_ACTIVITY,
 	   VSC8531_LINK_100_ACTIVITY, VSC8531_LINK_ACTIVITY,
@@ -2245,8 +2248,9 @@ static int vsc8574_probe(struct phy_device *phydev)
 	phydev->priv = vsc8531;
 
 	vsc8584_get_base_addr(phydev);
+	addrs[VSC88XX_BASE_ADDR] = vsc8531->base_addr;
 	devm_phy_package_join(&phydev->mdio.dev, phydev,
-			      vsc8531->base_addr, 0);
+			      addrs, ARRAY_SIZE(addrs), 0);
 
 	vsc8531->nleds = 4;
 	vsc8531->supp_led_modes = VSC8584_SUPP_LED_MODES;
@@ -2262,6 +2266,7 @@ static int vsc8574_probe(struct phy_device *phydev)
 
 static int vsc8584_probe(struct phy_device *phydev)
 {
+	int addrs[__VSC8XX_GLOBAL_PHY_MAX];
 	struct vsc8531_private *vsc8531;
 	u32 default_mode[4] = {VSC8531_LINK_1000_ACTIVITY,
 	   VSC8531_LINK_100_ACTIVITY, VSC8531_LINK_ACTIVITY,
@@ -2280,7 +2285,8 @@ static int vsc8584_probe(struct phy_device *phydev)
 	phydev->priv = vsc8531;
 
 	vsc8584_get_base_addr(phydev);
-	devm_phy_package_join(&phydev->mdio.dev, phydev, vsc8531->base_addr,
+	addrs[VSC88XX_BASE_ADDR] = vsc8531->base_addr;
+	devm_phy_package_join(&phydev->mdio.dev, phydev, addrs, ARRAY_SIZE(addrs),
 			      sizeof(struct vsc85xx_shared_private));
 
 	vsc8531->nleds = 4;
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 478126f6b5bc..e016dbfb0d27 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1648,59 +1648,80 @@ EXPORT_SYMBOL_GPL(phy_driver_is_genphy_10g);
 /**
  * phy_package_join - join a common PHY group
  * @phydev: target phy_device struct
- * @addr: cookie and PHY address for global register access
+ * @addrs: list of cookies and PHY addresses for global register access
+ * @addrs_num: num of cookies and PHY address in addrs list
  * @priv_size: if non-zero allocate this amount of bytes for private data
  *
  * This joins a PHY group and provides a shared storage for all phydevs in
  * this group. This is intended to be used for packages which contain
  * more than one PHY, for example a quad PHY transceiver.
  *
- * The addr parameter serves as a cookie which has to have the same value
+ * The addrs parameters serves as cookies which has to have the same values
  * for all members of one group and as a PHY address to access generic
  * registers of a PHY package. Usually, one of the PHY addresses of the
  * different PHYs in the package provides access to these global registers.
- * The address which is given here, will be used in the phy_package_read()
+ * The addresses which is given here, will be used in the phy_package_read()
  * and phy_package_write() convenience functions. If your PHY doesn't have
  * global registers you can just pick any of the PHY addresses.
+ * In some special PHY package, multiple PHY are used for global init of
+ * the entire PHY package. In the scenario, multiple address are defined.
+ * phy_package_read() and phy_package_write() requires an index to be passed
+ * to communicate which PHY to use for global init on read/write.
  *
  * This will set the shared pointer of the phydev to the shared storage.
  * If this is the first call for a this cookie the shared storage will be
  * allocated. If priv_size is non-zero, the given amount of bytes are
  * allocated for the priv member.
+ * A list is allocated based on the addrs_num value and the passed list in
+ * addrs is copied to the just allocated list.
  *
  * Returns < 1 on error, 0 on success. Esp. calling phy_package_join()
  * with the same cookie but a different priv_size is an error.
  */
-int phy_package_join(struct phy_device *phydev, int addr, size_t priv_size)
+int phy_package_join(struct phy_device *phydev, int *addrs, size_t addrs_num,
+		     size_t priv_size)
 {
 	struct mii_bus *bus = phydev->mdio.bus;
 	struct phy_package_shared *shared;
-	int ret;
+	int *shared_addrs;
+	int i, addr, ret;
 
-	if (addr < 0 || addr >= PHY_MAX_ADDR)
+	if (!addrs || !addrs_num)
 		return -EINVAL;
 
+	for (i = 0; i < addrs_num; i++)
+		if (addrs[i] < 0 || addrs[i] >= PHY_MAX_ADDR)
+			return -EINVAL;
+
 	mutex_lock(&bus->shared_lock);
-	shared = bus->shared[addr];
-	if (!shared) {
-		ret = -ENOMEM;
-		shared = kzalloc(sizeof(*shared), GFP_KERNEL);
-		if (!shared)
-			goto err_unlock;
-		if (priv_size) {
-			shared->priv = kzalloc(priv_size, GFP_KERNEL);
-			if (!shared->priv)
-				goto err_free;
-			shared->priv_size = priv_size;
+	for (i = 0; i < addrs_num; i++) {
+		addr = addrs[i];
+		shared = bus->shared[addr];
+		if (!shared) {
+			ret = -ENOMEM;
+			shared = kzalloc(sizeof(*shared), GFP_KERNEL);
+			if (!shared)
+				goto err_unlock;
+			if (priv_size) {
+				shared->priv = kzalloc(priv_size, GFP_KERNEL);
+				if (!shared->priv)
+					goto err_free;
+				shared->priv_size = priv_size;
+			}
+			shared_addrs = kmalloc_array(addrs_num, sizeof(*addrs), GFP_KERNEL);
+			if (!shared_addrs)
+				goto err_free_priv;
+			memcpy(shared_addrs, addrs, sizeof(*addrs) * addrs_num);
+			shared->addrs = shared_addrs;
+			shared->addrs_num = addrs_num;
+			refcount_set(&shared->refcnt, 1);
+			bus->shared[addr] = shared;
+		} else {
+			ret = -EINVAL;
+			if (priv_size && priv_size != shared->priv_size)
+				goto err_unlock;
+			refcount_inc(&shared->refcnt);
 		}
-		shared->addr = addr;
-		refcount_set(&shared->refcnt, 1);
-		bus->shared[addr] = shared;
-	} else {
-		ret = -EINVAL;
-		if (priv_size && priv_size != shared->priv_size)
-			goto err_unlock;
-		refcount_inc(&shared->refcnt);
 	}
 	mutex_unlock(&bus->shared_lock);
 
@@ -1708,6 +1729,8 @@ int phy_package_join(struct phy_device *phydev, int addr, size_t priv_size)
 
 	return 0;
 
+err_free_priv:
+	kfree(shared->priv);
 err_free:
 	kfree(shared);
 err_unlock:
@@ -1728,13 +1751,16 @@ void phy_package_leave(struct phy_device *phydev)
 {
 	struct phy_package_shared *shared = phydev->shared;
 	struct mii_bus *bus = phydev->mdio.bus;
+	int i;
 
 	if (!shared)
 		return;
 
 	if (refcount_dec_and_mutex_lock(&shared->refcnt, &bus->shared_lock)) {
-		bus->shared[shared->addr] = NULL;
+		for (i = 0; i < shared->addrs_num; i++)
+			bus->shared[shared->addrs[i]] = NULL;
 		mutex_unlock(&bus->shared_lock);
+		kfree(shared->addrs);
 		kfree(shared->priv);
 		kfree(shared);
 	}
@@ -1752,7 +1778,8 @@ static void devm_phy_package_leave(struct device *dev, void *res)
  * devm_phy_package_join - resource managed phy_package_join()
  * @dev: device that is registering this PHY package
  * @phydev: target phy_device struct
- * @addr: cookie and PHY address for global register access
+ * @addrs: list of cookies and PHY addresses for global register access
+ * @addrs_num: num of cookies and PHY address in addrs list
  * @priv_size: if non-zero allocate this amount of bytes for private data
  *
  * Managed phy_package_join(). Shared storage fetched by this function,
@@ -1760,7 +1787,7 @@ static void devm_phy_package_leave(struct device *dev, void *res)
  * phy_package_join() for more information.
  */
 int devm_phy_package_join(struct device *dev, struct phy_device *phydev,
-			  int addr, size_t priv_size)
+			  int *addrs, size_t addrs_num, size_t priv_size)
 {
 	struct phy_device **ptr;
 	int ret;
@@ -1770,7 +1797,7 @@ int devm_phy_package_join(struct device *dev, struct phy_device *phydev,
 	if (!ptr)
 		return -ENOMEM;
 
-	ret = phy_package_join(phydev, addr, priv_size);
+	ret = phy_package_join(phydev, addrs, addrs_num, priv_size);
 
 	if (!ret) {
 		*ptr = phydev;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3cc52826f18e..c2bb3f0b9dda 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -327,7 +327,8 @@ struct mdio_bus_stats {
 
 /**
  * struct phy_package_shared - Shared information in PHY packages
- * @addr: Common PHY address used to combine PHYs in one package
+ * @addrs: List of common PHY addresses used to combine PHYs in one package
+ * @addrs_num: Number of common PHY addresses in addrs list
  * @refcnt: Number of PHYs connected to this shared data
  * @flags: Initialization of PHY package
  * @priv_size: Size of the shared private data @priv
@@ -338,7 +339,14 @@ struct mdio_bus_stats {
  * phy_package_leave().
  */
 struct phy_package_shared {
-	int addr;
+	/* addrs list pointer */
+	/* note that this pointer is shared between different phydevs.
+	 * It is allocated and freed automatically by phy_package_join() and
+	 * phy_package_leave(), the list passed to phy_package_join() is copied
+	 * to the new allocated list.
+	 */
+	int *addrs;
+	size_t addrs_num;
 	refcount_t refcnt;
 	unsigned long flags;
 	size_t priv_size;
@@ -1970,10 +1978,11 @@ int phy_ethtool_get_link_ksettings(struct net_device *ndev,
 int phy_ethtool_set_link_ksettings(struct net_device *ndev,
 				   const struct ethtool_link_ksettings *cmd);
 int phy_ethtool_nway_reset(struct net_device *ndev);
-int phy_package_join(struct phy_device *phydev, int addr, size_t priv_size);
+int phy_package_join(struct phy_device *phydev, int *addrs, size_t addrs_num,
+		     size_t priv_size);
 void phy_package_leave(struct phy_device *phydev);
 int devm_phy_package_join(struct device *dev, struct phy_device *phydev,
-			  int addr, size_t priv_size);
+			  int *addrs, size_t addrs_num, size_t priv_size);
 
 int __init mdio_bus_init(void);
 void mdio_bus_exit(void);
@@ -1996,46 +2005,56 @@ int __phy_hwtstamp_set(struct phy_device *phydev,
 		       struct kernel_hwtstamp_config *config,
 		       struct netlink_ext_ack *extack);
 
-static inline int phy_package_read(struct phy_device *phydev, u32 regnum)
+static inline int phy_package_read(struct phy_device *phydev,
+				   int global_phy_index, u32 regnum)
 {
 	struct phy_package_shared *shared = phydev->shared;
+	int addr;
 
-	if (!shared)
+	if (!shared || global_phy_index > shared->addrs_num - 1)
 		return -EIO;
 
-	return mdiobus_read(phydev->mdio.bus, shared->addr, regnum);
+	addr = shared->addrs[global_phy_index];
+	return mdiobus_read(phydev->mdio.bus, addr, regnum);
 }
 
-static inline int __phy_package_read(struct phy_device *phydev, u32 regnum)
+static inline int __phy_package_read(struct phy_device *phydev,
+				     int global_phy_index, u32 regnum)
 {
 	struct phy_package_shared *shared = phydev->shared;
+	int addr;
 
-	if (!shared)
+	if (!shared || global_phy_index > shared->addrs_num - 1)
 		return -EIO;
 
-	return __mdiobus_read(phydev->mdio.bus, shared->addr, regnum);
+	addr = shared->addrs[global_phy_index];
+	return __mdiobus_read(phydev->mdio.bus, addr, regnum);
 }
 
 static inline int phy_package_write(struct phy_device *phydev,
-				    u32 regnum, u16 val)
+				    int global_phy_index, u32 regnum, u16 val)
 {
 	struct phy_package_shared *shared = phydev->shared;
+	int addr;
 
-	if (!shared)
+	if (!shared || global_phy_index > shared->addrs_num - 1)
 		return -EIO;
 
-	return mdiobus_write(phydev->mdio.bus, shared->addr, regnum, val);
+	addr = shared->addrs[global_phy_index];
+	return mdiobus_write(phydev->mdio.bus, addr, regnum, val);
 }
 
 static inline int __phy_package_write(struct phy_device *phydev,
-				      u32 regnum, u16 val)
+				      int global_phy_index, u32 regnum, u16 val)
 {
 	struct phy_package_shared *shared = phydev->shared;
+	int addr;
 
-	if (!shared)
+	if (!shared || global_phy_index > shared->addrs_num - 1)
 		return -EIO;
 
-	return __mdiobus_write(phydev->mdio.bus, shared->addr, regnum, val);
+	addr = shared->addrs[global_phy_index];
+	return __mdiobus_write(phydev->mdio.bus, addr, regnum, val);
 }
 
 static inline bool __phy_package_set_once(struct phy_device *phydev,
-- 
2.40.1

