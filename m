Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70E37FCCC4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 03:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjK2CN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 21:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbjK2CMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 21:12:50 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B7A1BF1;
        Tue, 28 Nov 2023 18:12:45 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40a4848c6e1so44217345e9.1;
        Tue, 28 Nov 2023 18:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701223963; x=1701828763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c433RXTiU4cjP0ypjcS0Kp/km1zjrPR1BHsoalfxolY=;
        b=CAJKicTnomqEBAExbEmr1LEk2sYIrv8hXlrTR6syyc+CgdI3tblR21Wz2u8PufTjmf
         wkjxOU2sPWU8QVQkiinYeP6LlyCK3bdawHt9NnDmgsqCMUZOP7R7V9S4d8L5YBGjpBlC
         /JsyPN/AeZXgabVDXNBzX6vL3cuf7Uj1VHfc65U1OTpgc/0dMy/kjq/EQPHuR0afgMOU
         1VxG0SAhrx6hOA19zmo1SlwRLQs9DAWMuthJdOpK5nenhx4LuVJ2LnI5xm9trmpr3oiJ
         JHqaD2m1z4YYUciyKldgALMpeQWRJ3d1yERqcjGMs3ThoGUFozlJOV3/93C8VHXkzDXe
         B0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701223963; x=1701828763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c433RXTiU4cjP0ypjcS0Kp/km1zjrPR1BHsoalfxolY=;
        b=BDIEAAij340okKiyk9tGgFX2BTOt81nNdjDeG87DWELIZBSptJ8joITS2z5W0Sunbl
         +UJJkrQy/ibQDR21TgJVCbHYyZFgRpUkcAjtRREcBQVJiyYGtn0Z/YszrUFFsXG0/cS0
         vD34h9n8jHgSgyq/Ae0m800UA+ALJZCRwQdWt6Tez1FgY/AyjU/qagjGJpliyn7g0eVN
         6sVvuvG8ZjFuj6gUNMvdWwPMBMlo/yQBXOzNh9TLTjVRyqWWNilSgWhNLXiVmqTJp5Ty
         yjfJKePuB9crI3FyVfl3DVt4gNjathtFOfTRIo8rSmIgwhnGHlXtI64U3GAU+ToJmHdC
         mcyg==
X-Gm-Message-State: AOJu0YzDuCbAm76GzcgaZVe63z+CMAZP/Z3qI0XzvBhgDGesmHHSQOmb
        x8Fwisvs89El18adyUGg0QE=
X-Google-Smtp-Source: AGHT+IEhYmt8sMNbBpuEfDCqdSGEMrXQxofIi7y76U0r8WfmA0tpE/GGbcOesx+Q4cLz04P505f/EQ==
X-Received: by 2002:a05:600c:43d3:b0:40a:5c71:2c3e with SMTP id f19-20020a05600c43d300b0040a5c712c3emr12794377wmn.19.1701223963188;
        Tue, 28 Nov 2023 18:12:43 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id b19-20020a05600c4e1300b0040648217f4fsm321406wmq.39.2023.11.28.18.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 18:12:42 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 14/14] net: phy: qcom: detach qca808x PHY driver from at803x
Date:   Wed, 29 Nov 2023 03:12:19 +0100
Message-Id: <20231129021219.20914-15-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129021219.20914-1-ansuelsmth@gmail.com>
References: <20231129021219.20914-1-ansuelsmth@gmail.com>
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

Almost all the QCA8081 PHY driver OPs are specific and only some of them
use the generic at803x.

To make the at803x code slimmer, move all the specific qca808x regs and
functions to a dedicated PHY driver.

All the shared function are moved to the shared .c since they are both
used by qca808x and at803x.

Also a new Kconfig is introduced QCA808X_PHY, to compile the newly
introduced PHY driver for QCA8081 PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/qcom/Kconfig   |   5 +
 drivers/net/phy/qcom/Makefile  |   1 +
 drivers/net/phy/qcom/at803x.c  | 894 +--------------------------------
 drivers/net/phy/qcom/common.c  | 303 ++++++++++-
 drivers/net/phy/qcom/qca808x.c | 550 ++++++++++++++++++++
 drivers/net/phy/qcom/qcom.h    |  86 ++++
 6 files changed, 945 insertions(+), 894 deletions(-)
 create mode 100644 drivers/net/phy/qcom/qca808x.c

diff --git a/drivers/net/phy/qcom/Kconfig b/drivers/net/phy/qcom/Kconfig
index 06914f23a92e..0c227f2c2917 100644
--- a/drivers/net/phy/qcom/Kconfig
+++ b/drivers/net/phy/qcom/Kconfig
@@ -10,3 +10,8 @@ config QCA83XX_PHY
 	tristate "Qualcomm Atheros QCA833x PHYs"
 	help
 	  Currently supports the internal QCA8337(Internal qca8k PHY) model
+
+config QCA808X_PHY
+	tristate "Qualcomm QCA808x PHYs"
+	help
+	  Currently supports the QCA8081 model
diff --git a/drivers/net/phy/qcom/Makefile b/drivers/net/phy/qcom/Makefile
index 43e4d14df8ea..391c2dde8131 100644
--- a/drivers/net/phy/qcom/Makefile
+++ b/drivers/net/phy/qcom/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_AT803X_PHY)	+= at803x.o common.o
 obj-$(CONFIG_QCA83XX_PHY)	+= qca83xx.o common.o
+obj-$(CONFIG_QCA808X_PHY)	+= qca808x.o common.o
diff --git a/drivers/net/phy/qcom/at803x.c b/drivers/net/phy/qcom/at803x.c
index 80da66c3d3e9..1370b511bd96 100644
--- a/drivers/net/phy/qcom/at803x.c
+++ b/drivers/net/phy/qcom/at803x.c
@@ -24,65 +24,8 @@
 
 #include "qcom.h"
 
-#define AT803X_SPECIFIC_FUNCTION_CONTROL	0x10
-#define AT803X_SFC_ASSERT_CRS			BIT(11)
-#define AT803X_SFC_FORCE_LINK			BIT(10)
-#define AT803X_SFC_MDI_CROSSOVER_MODE_M		GENMASK(6, 5)
-#define AT803X_SFC_AUTOMATIC_CROSSOVER		0x3
-#define AT803X_SFC_MANUAL_MDIX			0x1
-#define AT803X_SFC_MANUAL_MDI			0x0
-#define AT803X_SFC_SQE_TEST			BIT(2)
-#define AT803X_SFC_POLARITY_REVERSAL		BIT(1)
-#define AT803X_SFC_DISABLE_JABBER		BIT(0)
-
-#define AT803X_SPECIFIC_STATUS			0x11
-#define AT803X_SS_SPEED_MASK			GENMASK(15, 14)
-#define AT803X_SS_SPEED_1000			2
-#define AT803X_SS_SPEED_100			1
-#define AT803X_SS_SPEED_10			0
-#define AT803X_SS_DUPLEX			BIT(13)
-#define AT803X_SS_SPEED_DUPLEX_RESOLVED		BIT(11)
-#define AT803X_SS_MDIX				BIT(6)
-
-#define QCA808X_SS_SPEED_MASK			GENMASK(9, 7)
-#define QCA808X_SS_SPEED_2500			4
-
-#define AT803X_INTR_ENABLE			0x12
-#define AT803X_INTR_ENABLE_AUTONEG_ERR		BIT(15)
-#define AT803X_INTR_ENABLE_SPEED_CHANGED	BIT(14)
-#define AT803X_INTR_ENABLE_DUPLEX_CHANGED	BIT(13)
-#define AT803X_INTR_ENABLE_PAGE_RECEIVED	BIT(12)
-#define AT803X_INTR_ENABLE_LINK_FAIL		BIT(11)
-#define AT803X_INTR_ENABLE_LINK_SUCCESS		BIT(10)
-#define AT803X_INTR_ENABLE_LINK_FAIL_BX		BIT(8)
-#define AT803X_INTR_ENABLE_LINK_SUCCESS_BX	BIT(7)
-#define AT803X_INTR_ENABLE_WIRESPEED_DOWNGRADE	BIT(5)
-#define AT803X_INTR_ENABLE_POLARITY_CHANGED	BIT(1)
-#define AT803X_INTR_ENABLE_WOL			BIT(0)
-
-#define AT803X_INTR_STATUS			0x13
-
-#define AT803X_SMART_SPEED			0x14
-#define AT803X_SMART_SPEED_ENABLE		BIT(5)
-#define AT803X_SMART_SPEED_RETRY_LIMIT_MASK	GENMASK(4, 2)
-#define AT803X_SMART_SPEED_BYPASS_TIMER		BIT(1)
-#define AT803X_CDT				0x16
-#define AT803X_CDT_MDI_PAIR_MASK		GENMASK(9, 8)
-#define AT803X_CDT_ENABLE_TEST			BIT(0)
-#define AT803X_CDT_STATUS			0x1c
-#define AT803X_CDT_STATUS_STAT_NORMAL		0
-#define AT803X_CDT_STATUS_STAT_SHORT		1
-#define AT803X_CDT_STATUS_STAT_OPEN		2
-#define AT803X_CDT_STATUS_STAT_FAIL		3
-#define AT803X_CDT_STATUS_STAT_MASK		GENMASK(9, 8)
-#define AT803X_CDT_STATUS_DELTA_TIME_MASK	GENMASK(7, 0)
 #define AT803X_LED_CONTROL			0x18
 
-#define AT803X_PHY_MMD3_WOL_CTRL		0x8012
-#define AT803X_WOL_EN				BIT(5)
-#define AT803X_LOC_MAC_ADDR_0_15_OFFSET		0x804C
-#define AT803X_LOC_MAC_ADDR_16_31_OFFSET	0x804B
-#define AT803X_LOC_MAC_ADDR_32_47_OFFSET	0x804A
 #define AT803X_REG_CHIP_CONFIG			0x1f
 #define AT803X_BT_BX_REG_SEL			0x8000
 
@@ -134,10 +77,6 @@
 #define AT803X_CLK_OUT_STRENGTH_HALF		1
 #define AT803X_CLK_OUT_STRENGTH_QUARTER		2
 
-#define AT803X_DEFAULT_DOWNSHIFT		5
-#define AT803X_MIN_DOWNSHIFT			2
-#define AT803X_MAX_DOWNSHIFT			9
-
 #define AT803X_MMD3_SMARTEEE_CTL1		0x805b
 #define AT803X_MMD3_SMARTEEE_CTL2		0x805c
 #define AT803X_MMD3_SMARTEEE_CTL3		0x805d
@@ -150,8 +89,6 @@
 #define ATH8035_PHY_ID				0x004dd072
 #define AT8030_PHY_ID_MASK			0xffffffef
 
-#define QCA8081_PHY_ID				0x004dd101
-
 #define QCA9561_PHY_ID				0x004dd042
 
 #define AT803X_PAGE_FIBER			0
@@ -165,99 +102,10 @@
 /* disable hibernation mode */
 #define AT803X_DISABLE_HIBERNATION_MODE		BIT(2)
 
-/* ADC threshold */
-#define QCA808X_PHY_DEBUG_ADC_THRESHOLD		0x2c80
-#define QCA808X_ADC_THRESHOLD_MASK		GENMASK(7, 0)
-#define QCA808X_ADC_THRESHOLD_80MV		0
-#define QCA808X_ADC_THRESHOLD_100MV		0xf0
-#define QCA808X_ADC_THRESHOLD_200MV		0x0f
-#define QCA808X_ADC_THRESHOLD_300MV		0xff
-
-/* CLD control */
-#define QCA808X_PHY_MMD3_ADDR_CLD_CTRL7		0x8007
-#define QCA808X_8023AZ_AFE_CTRL_MASK		GENMASK(8, 4)
-#define QCA808X_8023AZ_AFE_EN			0x90
-
-/* AZ control */
-#define QCA808X_PHY_MMD3_AZ_TRAINING_CTRL	0x8008
-#define QCA808X_MMD3_AZ_TRAINING_VAL		0x1c32
-
-#define QCA808X_PHY_MMD1_MSE_THRESHOLD_20DB	0x8014
-#define QCA808X_MSE_THRESHOLD_20DB_VALUE	0x529
-
-#define QCA808X_PHY_MMD1_MSE_THRESHOLD_17DB	0x800E
-#define QCA808X_MSE_THRESHOLD_17DB_VALUE	0x341
-
-#define QCA808X_PHY_MMD1_MSE_THRESHOLD_27DB	0x801E
-#define QCA808X_MSE_THRESHOLD_27DB_VALUE	0x419
-
-#define QCA808X_PHY_MMD1_MSE_THRESHOLD_28DB	0x8020
-#define QCA808X_MSE_THRESHOLD_28DB_VALUE	0x341
-
-#define QCA808X_PHY_MMD7_TOP_OPTION1		0x901c
-#define QCA808X_TOP_OPTION1_DATA		0x0
-
-#define QCA808X_PHY_MMD3_DEBUG_1		0xa100
-#define QCA808X_MMD3_DEBUG_1_VALUE		0x9203
-#define QCA808X_PHY_MMD3_DEBUG_2		0xa101
-#define QCA808X_MMD3_DEBUG_2_VALUE		0x48ad
-#define QCA808X_PHY_MMD3_DEBUG_3		0xa103
-#define QCA808X_MMD3_DEBUG_3_VALUE		0x1698
-#define QCA808X_PHY_MMD3_DEBUG_4		0xa105
-#define QCA808X_MMD3_DEBUG_4_VALUE		0x8001
-#define QCA808X_PHY_MMD3_DEBUG_5		0xa106
-#define QCA808X_MMD3_DEBUG_5_VALUE		0x1111
-#define QCA808X_PHY_MMD3_DEBUG_6		0xa011
-#define QCA808X_MMD3_DEBUG_6_VALUE		0x5f85
-
-/* master/slave seed config */
-#define QCA808X_PHY_DEBUG_LOCAL_SEED		9
-#define QCA808X_MASTER_SLAVE_SEED_ENABLE	BIT(1)
-#define QCA808X_MASTER_SLAVE_SEED_CFG		GENMASK(12, 2)
-#define QCA808X_MASTER_SLAVE_SEED_RANGE		0x32
-
-/* Hibernation yields lower power consumpiton in contrast with normal operation mode.
- * when the copper cable is unplugged, the PHY enters into hibernation mode in about 10s.
- */
-#define QCA808X_DBG_AN_TEST			0xb
-#define QCA808X_HIBERNATION_EN			BIT(15)
-
-#define QCA808X_CDT_ENABLE_TEST			BIT(15)
-#define QCA808X_CDT_INTER_CHECK_DIS		BIT(13)
-#define QCA808X_CDT_LENGTH_UNIT			BIT(10)
-
-#define QCA808X_MMD3_CDT_STATUS			0x8064
-#define QCA808X_MMD3_CDT_DIAG_PAIR_A		0x8065
-#define QCA808X_MMD3_CDT_DIAG_PAIR_B		0x8066
-#define QCA808X_MMD3_CDT_DIAG_PAIR_C		0x8067
-#define QCA808X_MMD3_CDT_DIAG_PAIR_D		0x8068
-#define QCA808X_CDT_DIAG_LENGTH			GENMASK(7, 0)
-
-#define QCA808X_CDT_CODE_PAIR_A			GENMASK(15, 12)
-#define QCA808X_CDT_CODE_PAIR_B			GENMASK(11, 8)
-#define QCA808X_CDT_CODE_PAIR_C			GENMASK(7, 4)
-#define QCA808X_CDT_CODE_PAIR_D			GENMASK(3, 0)
-#define QCA808X_CDT_STATUS_STAT_FAIL		0
-#define QCA808X_CDT_STATUS_STAT_NORMAL		1
-#define QCA808X_CDT_STATUS_STAT_OPEN		2
-#define QCA808X_CDT_STATUS_STAT_SHORT		3
-
-/* QCA808X 1G chip type */
-#define QCA808X_PHY_MMD7_CHIP_TYPE		0x901d
-#define QCA808X_PHY_CHIP_TYPE_1G		BIT(0)
-
-#define QCA8081_PHY_SERDES_MMD1_FIFO_CTRL	0x9072
-#define QCA8081_PHY_FIFO_RSTN			BIT(11)
-
-MODULE_DESCRIPTION("Qualcomm Atheros AR803x and QCA808X PHY driver");
+MODULE_DESCRIPTION("Qualcomm Atheros AR803x PHY driver");
 MODULE_AUTHOR("Matus Ujhelyi");
 MODULE_LICENSE("GPL");
 
-struct at803x_ss_mask {
-	u16 speed_mask;
-	u8 speed_shift;
-};
-
 struct at8031_data {
 	bool is_fiber;
 	bool is_1000basex;
@@ -362,80 +210,6 @@ static void at803x_context_restore(struct phy_device *phydev,
 	phy_write(phydev, AT803X_LED_CONTROL, context->led_control);
 }
 
-static int at803x_set_wol(struct phy_device *phydev,
-			  struct ethtool_wolinfo *wol)
-{
-	int ret, irq_enabled;
-
-	if (wol->wolopts & WAKE_MAGIC) {
-		struct net_device *ndev = phydev->attached_dev;
-		const u8 *mac;
-		unsigned int i;
-		static const unsigned int offsets[] = {
-			AT803X_LOC_MAC_ADDR_32_47_OFFSET,
-			AT803X_LOC_MAC_ADDR_16_31_OFFSET,
-			AT803X_LOC_MAC_ADDR_0_15_OFFSET,
-		};
-
-		if (!ndev)
-			return -ENODEV;
-
-		mac = (const u8 *) ndev->dev_addr;
-
-		if (!is_valid_ether_addr(mac))
-			return -EINVAL;
-
-		for (i = 0; i < 3; i++)
-			phy_write_mmd(phydev, MDIO_MMD_PCS, offsets[i],
-				      mac[(i * 2) + 1] | (mac[(i * 2)] << 8));
-
-		/* Enable WOL interrupt */
-		ret = phy_modify(phydev, AT803X_INTR_ENABLE, 0, AT803X_INTR_ENABLE_WOL);
-		if (ret)
-			return ret;
-	} else {
-		/* Disable WOL interrupt */
-		ret = phy_modify(phydev, AT803X_INTR_ENABLE, AT803X_INTR_ENABLE_WOL, 0);
-		if (ret)
-			return ret;
-	}
-
-	/* Clear WOL status */
-	ret = phy_read(phydev, AT803X_INTR_STATUS);
-	if (ret < 0)
-		return ret;
-
-	/* Check if there are other interrupts except for WOL triggered when PHY is
-	 * in interrupt mode, only the interrupts enabled by AT803X_INTR_ENABLE can
-	 * be passed up to the interrupt PIN.
-	 */
-	irq_enabled = phy_read(phydev, AT803X_INTR_ENABLE);
-	if (irq_enabled < 0)
-		return irq_enabled;
-
-	irq_enabled &= ~AT803X_INTR_ENABLE_WOL;
-	if (ret & irq_enabled && !phy_polling_mode(phydev))
-		phy_trigger_machine(phydev);
-
-	return 0;
-}
-
-static void at803x_get_wol(struct phy_device *phydev,
-			   struct ethtool_wolinfo *wol)
-{
-	int value;
-
-	wol->supported = WAKE_MAGIC;
-	wol->wolopts = 0;
-
-	value = phy_read(phydev, AT803X_INTR_ENABLE);
-	if (value < 0)
-		return;
-
-	if (value & AT803X_INTR_ENABLE_WOL)
-		wol->wolopts |= WAKE_MAGIC;
-}
-
 static int at803x_suspend(struct phy_device *phydev)
 {
 	int value;
@@ -675,73 +449,6 @@ static int at803x_config_init(struct phy_device *phydev)
 	return phy_modify(phydev, MII_ADVERTISE, MDIO_AN_CTRL1_XNP, 0);
 }
 
-static int at803x_ack_interrupt(struct phy_device *phydev)
-{
-	int err;
-
-	err = phy_read(phydev, AT803X_INTR_STATUS);
-
-	return (err < 0) ? err : 0;
-}
-
-static int at803x_config_intr(struct phy_device *phydev)
-{
-	int err;
-	int value;
-
-	value = phy_read(phydev, AT803X_INTR_ENABLE);
-
-	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
-		/* Clear any pending interrupts */
-		err = at803x_ack_interrupt(phydev);
-		if (err)
-			return err;
-
-		value |= AT803X_INTR_ENABLE_AUTONEG_ERR;
-		value |= AT803X_INTR_ENABLE_SPEED_CHANGED;
-		value |= AT803X_INTR_ENABLE_DUPLEX_CHANGED;
-		value |= AT803X_INTR_ENABLE_LINK_FAIL;
-		value |= AT803X_INTR_ENABLE_LINK_SUCCESS;
-
-		err = phy_write(phydev, AT803X_INTR_ENABLE, value);
-	} else {
-		err = phy_write(phydev, AT803X_INTR_ENABLE, 0);
-		if (err)
-			return err;
-
-		/* Clear any pending interrupts */
-		err = at803x_ack_interrupt(phydev);
-	}
-
-	return err;
-}
-
-static irqreturn_t at803x_handle_interrupt(struct phy_device *phydev)
-{
-	int irq_status, int_enabled;
-
-	irq_status = phy_read(phydev, AT803X_INTR_STATUS);
-	if (irq_status < 0) {
-		phy_error(phydev);
-		return IRQ_NONE;
-	}
-
-	/* Read the current enabled interrupts */
-	int_enabled = phy_read(phydev, AT803X_INTR_ENABLE);
-	if (int_enabled < 0) {
-		phy_error(phydev);
-		return IRQ_NONE;
-	}
-
-	/* See if this was one of our enabled interrupts */
-	if (!(irq_status & int_enabled))
-		return IRQ_NONE;
-
-	phy_trigger_machine(phydev);
-
-	return IRQ_HANDLED;
-}
-
 static void at803x_link_change_notify(struct phy_device *phydev)
 {
 	/*
@@ -767,69 +474,6 @@ static void at803x_link_change_notify(struct phy_device *phydev)
 	}
 }
 
-static int at803x_read_specific_status(struct phy_device *phydev,
-				       struct at803x_ss_mask ss_mask)
-{
-	int ss;
-
-	/* Read the AT8035 PHY-Specific Status register, which indicates the
-	 * speed and duplex that the PHY is actually using, irrespective of
-	 * whether we are in autoneg mode or not.
-	 */
-	ss = phy_read(phydev, AT803X_SPECIFIC_STATUS);
-	if (ss < 0)
-		return ss;
-
-	if (ss & AT803X_SS_SPEED_DUPLEX_RESOLVED) {
-		int sfc, speed;
-
-		sfc = phy_read(phydev, AT803X_SPECIFIC_FUNCTION_CONTROL);
-		if (sfc < 0)
-			return sfc;
-
-		speed = ss & ss_mask.speed_mask;
-		speed >>= ss_mask.speed_shift;
-
-		switch (speed) {
-		case AT803X_SS_SPEED_10:
-			phydev->speed = SPEED_10;
-			break;
-		case AT803X_SS_SPEED_100:
-			phydev->speed = SPEED_100;
-			break;
-		case AT803X_SS_SPEED_1000:
-			phydev->speed = SPEED_1000;
-			break;
-		case QCA808X_SS_SPEED_2500:
-			phydev->speed = SPEED_2500;
-			break;
-		}
-		if (ss & AT803X_SS_DUPLEX)
-			phydev->duplex = DUPLEX_FULL;
-		else
-			phydev->duplex = DUPLEX_HALF;
-
-		if (ss & AT803X_SS_MDIX)
-			phydev->mdix = ETH_TP_MDI_X;
-		else
-			phydev->mdix = ETH_TP_MDI;
-
-		switch (FIELD_GET(AT803X_SFC_MDI_CROSSOVER_MODE_M, sfc)) {
-		case AT803X_SFC_MANUAL_MDI:
-			phydev->mdix_ctrl = ETH_TP_MDI;
-			break;
-		case AT803X_SFC_MANUAL_MDIX:
-			phydev->mdix_ctrl = ETH_TP_MDI_X;
-			break;
-		case AT803X_SFC_AUTOMATIC_CROSSOVER:
-			phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
-			break;
-		}
-	}
-
-	return 0;
-}
-
 static int at803x_read_status(struct phy_device *phydev)
 {
 	struct at803x_ss_mask ss_mask = { 0 };
@@ -865,29 +509,6 @@ static int at803x_read_status(struct phy_device *phydev)
 	return 0;
 }
 
-static int at803x_config_mdix(struct phy_device *phydev, u8 ctrl)
-{
-	u16 val;
-
-	switch (ctrl) {
-	case ETH_TP_MDI:
-		val = AT803X_SFC_MANUAL_MDI;
-		break;
-	case ETH_TP_MDI_X:
-		val = AT803X_SFC_MANUAL_MDIX;
-		break;
-	case ETH_TP_MDI_AUTO:
-		val = AT803X_SFC_AUTOMATIC_CROSSOVER;
-		break;
-	default:
-		return 0;
-	}
-
-	return phy_modify_changed(phydev, AT803X_SPECIFIC_FUNCTION_CONTROL,
-			  AT803X_SFC_MDI_CROSSOVER_MODE_M,
-			  FIELD_PREP(AT803X_SFC_MDI_CROSSOVER_MODE_M, val));
-}
-
 static int at803x_config_aneg(struct phy_device *phydev)
 {
 	int ret;
@@ -914,80 +535,6 @@ static int at803x_config_aneg(struct phy_device *phydev)
 	return __genphy_config_aneg(phydev, ret);
 }
 
-static int at803x_get_downshift(struct phy_device *phydev, u8 *d)
-{
-	int val;
-
-	val = phy_read(phydev, AT803X_SMART_SPEED);
-	if (val < 0)
-		return val;
-
-	if (val & AT803X_SMART_SPEED_ENABLE)
-		*d = FIELD_GET(AT803X_SMART_SPEED_RETRY_LIMIT_MASK, val) + 2;
-	else
-		*d = DOWNSHIFT_DEV_DISABLE;
-
-	return 0;
-}
-
-static int at803x_set_downshift(struct phy_device *phydev, u8 cnt)
-{
-	u16 mask, set;
-	int ret;
-
-	switch (cnt) {
-	case DOWNSHIFT_DEV_DEFAULT_COUNT:
-		cnt = AT803X_DEFAULT_DOWNSHIFT;
-		fallthrough;
-	case AT803X_MIN_DOWNSHIFT ... AT803X_MAX_DOWNSHIFT:
-		set = AT803X_SMART_SPEED_ENABLE |
-		      AT803X_SMART_SPEED_BYPASS_TIMER |
-		      FIELD_PREP(AT803X_SMART_SPEED_RETRY_LIMIT_MASK, cnt - 2);
-		mask = AT803X_SMART_SPEED_RETRY_LIMIT_MASK;
-		break;
-	case DOWNSHIFT_DEV_DISABLE:
-		set = 0;
-		mask = AT803X_SMART_SPEED_ENABLE |
-		       AT803X_SMART_SPEED_BYPASS_TIMER;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	ret = phy_modify_changed(phydev, AT803X_SMART_SPEED, mask, set);
-
-	/* After changing the smart speed settings, we need to perform a
-	 * software reset, use phy_init_hw() to make sure we set the
-	 * reapply any values which might got lost during software reset.
-	 */
-	if (ret == 1)
-		ret = phy_init_hw(phydev);
-
-	return ret;
-}
-
-static int at803x_get_tunable(struct phy_device *phydev,
-			      struct ethtool_tunable *tuna, void *data)
-{
-	switch (tuna->id) {
-	case ETHTOOL_PHY_DOWNSHIFT:
-		return at803x_get_downshift(phydev, data);
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
-static int at803x_set_tunable(struct phy_device *phydev,
-			      struct ethtool_tunable *tuna, const void *data)
-{
-	switch (tuna->id) {
-	case ETHTOOL_PHY_DOWNSHIFT:
-		return at803x_set_downshift(phydev, *(const u8 *)data);
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
 static int at803x_cable_test_result_trans(u16 status)
 {
 	switch (FIELD_GET(AT803X_CDT_STATUS_STAT_MASK, status)) {
@@ -1551,423 +1098,6 @@ static int at8035_probe(struct phy_device *phydev)
 	return at8035_parse_dt(phydev);
 }
 
-static int qca808x_config_aneg(struct phy_device *phydev)
-{
-	int phy_ctrl = 0;
-	int ret;
-
-	ret = at803x_config_mdix(phydev, phydev->mdix_ctrl);
-	if (ret < 0)
-		return ret;
-
-	/* Changes of the midx bits are disruptive to the normal operation;
-	 * therefore any changes to these registers must be followed by a
-	 * software reset to take effect.
-	 */
-	if (ret == 1) {
-		ret = genphy_soft_reset(phydev);
-		if (ret < 0)
-			return ret;
-	}
-
-	/* Do not restart auto-negotiation by setting ret to 0 defautly,
-	 * when calling __genphy_config_aneg later.
-	 */
-	ret = 0;
-
-	/* The reg MII_BMCR also needs to be configured for force mode, the
-	 * genphy_config_aneg is also needed.
-	 */
-	if (phydev->autoneg == AUTONEG_DISABLE)
-		genphy_c45_pma_setup_forced(phydev);
-
-	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->advertising))
-		phy_ctrl = MDIO_AN_10GBT_CTRL_ADV2_5G;
-
-	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
-				     MDIO_AN_10GBT_CTRL_ADV2_5G, phy_ctrl);
-	if (ret < 0)
-		return ret;
-
-	return __genphy_config_aneg(phydev, ret);
-}
-
-static int qca808x_phy_fast_retrain_config(struct phy_device *phydev)
-{
-	int ret;
-
-	/* Enable fast retrain */
-	ret = genphy_c45_fast_retrain(phydev, true);
-	if (ret)
-		return ret;
-
-	phy_write_mmd(phydev, MDIO_MMD_AN, QCA808X_PHY_MMD7_TOP_OPTION1,
-			QCA808X_TOP_OPTION1_DATA);
-	phy_write_mmd(phydev, MDIO_MMD_PMAPMD, QCA808X_PHY_MMD1_MSE_THRESHOLD_20DB,
-			QCA808X_MSE_THRESHOLD_20DB_VALUE);
-	phy_write_mmd(phydev, MDIO_MMD_PMAPMD, QCA808X_PHY_MMD1_MSE_THRESHOLD_17DB,
-			QCA808X_MSE_THRESHOLD_17DB_VALUE);
-	phy_write_mmd(phydev, MDIO_MMD_PMAPMD, QCA808X_PHY_MMD1_MSE_THRESHOLD_27DB,
-			QCA808X_MSE_THRESHOLD_27DB_VALUE);
-	phy_write_mmd(phydev, MDIO_MMD_PMAPMD, QCA808X_PHY_MMD1_MSE_THRESHOLD_28DB,
-			QCA808X_MSE_THRESHOLD_28DB_VALUE);
-	phy_write_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_DEBUG_1,
-			QCA808X_MMD3_DEBUG_1_VALUE);
-	phy_write_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_DEBUG_4,
-			QCA808X_MMD3_DEBUG_4_VALUE);
-	phy_write_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_DEBUG_5,
-			QCA808X_MMD3_DEBUG_5_VALUE);
-	phy_write_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_DEBUG_3,
-			QCA808X_MMD3_DEBUG_3_VALUE);
-	phy_write_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_DEBUG_6,
-			QCA808X_MMD3_DEBUG_6_VALUE);
-	phy_write_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_DEBUG_2,
-			QCA808X_MMD3_DEBUG_2_VALUE);
-
-	return 0;
-}
-
-static int qca808x_phy_ms_seed_enable(struct phy_device *phydev, bool enable)
-{
-	u16 seed_value;
-
-	if (!enable)
-		return at803x_debug_reg_mask(phydev, QCA808X_PHY_DEBUG_LOCAL_SEED,
-				QCA808X_MASTER_SLAVE_SEED_ENABLE, 0);
-
-	seed_value = get_random_u32_below(QCA808X_MASTER_SLAVE_SEED_RANGE);
-	return at803x_debug_reg_mask(phydev, QCA808X_PHY_DEBUG_LOCAL_SEED,
-			QCA808X_MASTER_SLAVE_SEED_CFG | QCA808X_MASTER_SLAVE_SEED_ENABLE,
-			FIELD_PREP(QCA808X_MASTER_SLAVE_SEED_CFG, seed_value) |
-			QCA808X_MASTER_SLAVE_SEED_ENABLE);
-}
-
-static bool qca808x_is_prefer_master(struct phy_device *phydev)
-{
-	return (phydev->master_slave_get == MASTER_SLAVE_CFG_MASTER_FORCE) ||
-		(phydev->master_slave_get == MASTER_SLAVE_CFG_MASTER_PREFERRED);
-}
-
-static bool qca808x_has_fast_retrain_or_slave_seed(struct phy_device *phydev)
-{
-	return linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported);
-}
-
-static int qca808x_config_init(struct phy_device *phydev)
-{
-	int ret;
-
-	/* Active adc&vga on 802.3az for the link 1000M and 100M */
-	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_ADDR_CLD_CTRL7,
-			QCA808X_8023AZ_AFE_CTRL_MASK, QCA808X_8023AZ_AFE_EN);
-	if (ret)
-		return ret;
-
-	/* Adjust the threshold on 802.3az for the link 1000M */
-	ret = phy_write_mmd(phydev, MDIO_MMD_PCS,
-			QCA808X_PHY_MMD3_AZ_TRAINING_CTRL, QCA808X_MMD3_AZ_TRAINING_VAL);
-	if (ret)
-		return ret;
-
-	if (qca808x_has_fast_retrain_or_slave_seed(phydev)) {
-		/* Config the fast retrain for the link 2500M */
-		ret = qca808x_phy_fast_retrain_config(phydev);
-		if (ret)
-			return ret;
-
-		ret = genphy_read_master_slave(phydev);
-		if (ret < 0)
-			return ret;
-
-		if (!qca808x_is_prefer_master(phydev)) {
-			/* Enable seed and configure lower ramdom seed to make phy
-			 * linked as slave mode.
-			 */
-			ret = qca808x_phy_ms_seed_enable(phydev, true);
-			if (ret)
-				return ret;
-		}
-	}
-
-	/* Configure adc threshold as 100mv for the link 10M */
-	return at803x_debug_reg_mask(phydev, QCA808X_PHY_DEBUG_ADC_THRESHOLD,
-			QCA808X_ADC_THRESHOLD_MASK, QCA808X_ADC_THRESHOLD_100MV);
-}
-
-static int qca808x_read_status(struct phy_device *phydev)
-{
-	struct at803x_ss_mask ss_mask = { 0 };
-	int ret;
-
-	ret = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_STAT);
-	if (ret < 0)
-		return ret;
-
-	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->lp_advertising,
-			ret & MDIO_AN_10GBT_STAT_LP2_5G);
-
-	ret = genphy_read_status(phydev);
-	if (ret)
-		return ret;
-
-	/* qca8081 takes the different bits for speed value from at803x */
-	ss_mask.speed_mask = QCA808X_SS_SPEED_MASK;
-	ss_mask.speed_shift = __bf_shf(QCA808X_SS_SPEED_MASK);
-	ret = at803x_read_specific_status(phydev, ss_mask);
-	if (ret < 0)
-		return ret;
-
-	if (phydev->link) {
-		if (phydev->speed == SPEED_2500)
-			phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
-		else
-			phydev->interface = PHY_INTERFACE_MODE_SGMII;
-	} else {
-		/* generate seed as a lower random value to make PHY linked as SLAVE easily,
-		 * except for master/slave configuration fault detected or the master mode
-		 * preferred.
-		 *
-		 * the reason for not putting this code into the function link_change_notify is
-		 * the corner case where the link partner is also the qca8081 PHY and the seed
-		 * value is configured as the same value, the link can't be up and no link change
-		 * occurs.
-		 */
-		if (qca808x_has_fast_retrain_or_slave_seed(phydev)) {
-			if (phydev->master_slave_state == MASTER_SLAVE_STATE_ERR ||
-					qca808x_is_prefer_master(phydev)) {
-				qca808x_phy_ms_seed_enable(phydev, false);
-			} else {
-				qca808x_phy_ms_seed_enable(phydev, true);
-			}
-		}
-	}
-
-	return 0;
-}
-
-static int qca808x_soft_reset(struct phy_device *phydev)
-{
-	int ret;
-
-	ret = genphy_soft_reset(phydev);
-	if (ret < 0)
-		return ret;
-
-	if (qca808x_has_fast_retrain_or_slave_seed(phydev))
-		ret = qca808x_phy_ms_seed_enable(phydev, true);
-
-	return ret;
-}
-
-static bool qca808x_cdt_fault_length_valid(int cdt_code)
-{
-	switch (cdt_code) {
-	case QCA808X_CDT_STATUS_STAT_SHORT:
-	case QCA808X_CDT_STATUS_STAT_OPEN:
-		return true;
-	default:
-		return false;
-	}
-}
-
-static int qca808x_cable_test_result_trans(int cdt_code)
-{
-	switch (cdt_code) {
-	case QCA808X_CDT_STATUS_STAT_NORMAL:
-		return ETHTOOL_A_CABLE_RESULT_CODE_OK;
-	case QCA808X_CDT_STATUS_STAT_SHORT:
-		return ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT;
-	case QCA808X_CDT_STATUS_STAT_OPEN:
-		return ETHTOOL_A_CABLE_RESULT_CODE_OPEN;
-	case QCA808X_CDT_STATUS_STAT_FAIL:
-	default:
-		return ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC;
-	}
-}
-
-static int qca808x_cdt_fault_length(struct phy_device *phydev, int pair)
-{
-	int val;
-	u32 cdt_length_reg = 0;
-
-	switch (pair) {
-	case ETHTOOL_A_CABLE_PAIR_A:
-		cdt_length_reg = QCA808X_MMD3_CDT_DIAG_PAIR_A;
-		break;
-	case ETHTOOL_A_CABLE_PAIR_B:
-		cdt_length_reg = QCA808X_MMD3_CDT_DIAG_PAIR_B;
-		break;
-	case ETHTOOL_A_CABLE_PAIR_C:
-		cdt_length_reg = QCA808X_MMD3_CDT_DIAG_PAIR_C;
-		break;
-	case ETHTOOL_A_CABLE_PAIR_D:
-		cdt_length_reg = QCA808X_MMD3_CDT_DIAG_PAIR_D;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	val = phy_read_mmd(phydev, MDIO_MMD_PCS, cdt_length_reg);
-	if (val < 0)
-		return val;
-
-	return (FIELD_GET(QCA808X_CDT_DIAG_LENGTH, val) * 824) / 10;
-}
-
-static int qca808x_cable_test_start(struct phy_device *phydev)
-{
-	int ret;
-
-	/* perform CDT with the following configs:
-	 * 1. disable hibernation.
-	 * 2. force PHY working in MDI mode.
-	 * 3. for PHY working in 1000BaseT.
-	 * 4. configure the threshold.
-	 */
-
-	ret = at803x_debug_reg_mask(phydev, QCA808X_DBG_AN_TEST, QCA808X_HIBERNATION_EN, 0);
-	if (ret < 0)
-		return ret;
-
-	ret = at803x_config_mdix(phydev, ETH_TP_MDI);
-	if (ret < 0)
-		return ret;
-
-	/* Force 1000base-T needs to configure PMA/PMD and MII_BMCR */
-	phydev->duplex = DUPLEX_FULL;
-	phydev->speed = SPEED_1000;
-	ret = genphy_c45_pma_setup_forced(phydev);
-	if (ret < 0)
-		return ret;
-
-	ret = genphy_setup_forced(phydev);
-	if (ret < 0)
-		return ret;
-
-	/* configure the thresholds for open, short, pair ok test */
-	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x8074, 0xc040);
-	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x8076, 0xc040);
-	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x8077, 0xa060);
-	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x8078, 0xc050);
-	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x807a, 0xc060);
-	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x807e, 0xb060);
-
-	return 0;
-}
-
-static int qca808x_cdt_start(struct phy_device *phydev)
-{
-	u16 cdt;
-
-	/* qca8081 takes the different bit 15 to enable CDT test */
-	cdt = QCA808X_CDT_ENABLE_TEST |
-	      QCA808X_CDT_LENGTH_UNIT |
-	      QCA808X_CDT_INTER_CHECK_DIS;
-
-	return phy_write(phydev, AT803X_CDT, cdt);
-}
-
-static int qca808x_cdt_wait_for_completition(struct phy_device *phydev)
-{
-	int val, ret;
-
-	/* One test run takes about 25ms */
-	ret = phy_read_poll_timeout(phydev, AT803X_CDT, val,
-				    !(val & QCA808X_CDT_ENABLE_TEST),
-				    30000, 100000, true);
-
-	return ret < 0 ? ret : 0;
-}
-
-static int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finished)
-{
-	int ret, val;
-	int pair_a, pair_b, pair_c, pair_d;
-
-	*finished = false;
-
-	ret = qca808x_cdt_start(phydev);
-	if (ret)
-		return ret;
-
-	ret = qca808x_cdt_wait_for_completition(phydev);
-	if (ret)
-		return ret;
-
-	val = phy_read_mmd(phydev, MDIO_MMD_PCS, QCA808X_MMD3_CDT_STATUS);
-	if (val < 0)
-		return val;
-
-	pair_a = FIELD_GET(QCA808X_CDT_CODE_PAIR_A, val);
-	pair_b = FIELD_GET(QCA808X_CDT_CODE_PAIR_B, val);
-	pair_c = FIELD_GET(QCA808X_CDT_CODE_PAIR_C, val);
-	pair_d = FIELD_GET(QCA808X_CDT_CODE_PAIR_D, val);
-
-	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_A,
-				qca808x_cable_test_result_trans(pair_a));
-	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_B,
-				qca808x_cable_test_result_trans(pair_b));
-	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_C,
-				qca808x_cable_test_result_trans(pair_c));
-	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_D,
-				qca808x_cable_test_result_trans(pair_d));
-
-	if (qca808x_cdt_fault_length_valid(pair_a))
-		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A,
-				qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A));
-	if (qca808x_cdt_fault_length_valid(pair_b))
-		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B,
-				qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B));
-	if (qca808x_cdt_fault_length_valid(pair_c))
-		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C,
-				qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C));
-	if (qca808x_cdt_fault_length_valid(pair_d))
-		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D,
-				qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D));
-
-	*finished = true;
-
-	return 0;
-}
-
-static int qca808x_get_features(struct phy_device *phydev)
-{
-	int ret;
-
-	ret = genphy_c45_pma_read_abilities(phydev);
-	if (ret)
-		return ret;
-
-	/* The autoneg ability is not existed in bit3 of MMD7.1,
-	 * but it is supported by qca808x PHY, so we add it here
-	 * manually.
-	 */
-	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, phydev->supported);
-
-	/* As for the qca8081 1G version chip, the 2500baseT ability is also
-	 * existed in the bit0 of MMD1.21, we need to remove it manually if
-	 * it is the qca8081 1G chip according to the bit0 of MMD7.0x901d.
-	 */
-	ret = phy_read_mmd(phydev, MDIO_MMD_AN, QCA808X_PHY_MMD7_CHIP_TYPE);
-	if (ret < 0)
-		return ret;
-
-	if (QCA808X_PHY_CHIP_TYPE_1G & ret)
-		linkmode_clear_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported);
-
-	return 0;
-}
-
-static void qca808x_link_change_notify(struct phy_device *phydev)
-{
-	/* Assert interface sgmii fifo on link down, deassert it on link up,
-	 * the interface device address is always phy address added by 1.
-	 */
-	mdiobus_c45_modify_changed(phydev->mdio.bus, phydev->mdio.addr + 1,
-			MDIO_MMD_PMAPMD, QCA8081_PHY_SERDES_MMD1_FIFO_CTRL,
-			QCA8081_PHY_FIFO_RSTN, phydev->link ? QCA8081_PHY_FIFO_RSTN : 0);
-}
-
 static struct phy_driver at803x_driver[] = {
 {
 	/* Qualcomm Atheros AR8035 */
@@ -2075,27 +1205,6 @@ static struct phy_driver at803x_driver[] = {
 	.read_status		= at803x_read_status,
 	.soft_reset		= genphy_soft_reset,
 	.config_aneg		= at803x_config_aneg,
-}, {
-	/* Qualcomm QCA8081 */
-	PHY_ID_MATCH_EXACT(QCA8081_PHY_ID),
-	.name			= "Qualcomm QCA8081",
-	.flags			= PHY_POLL_CABLE_TEST,
-	.config_intr		= at803x_config_intr,
-	.handle_interrupt	= at803x_handle_interrupt,
-	.get_tunable		= at803x_get_tunable,
-	.set_tunable		= at803x_set_tunable,
-	.set_wol		= at803x_set_wol,
-	.get_wol		= at803x_get_wol,
-	.get_features		= qca808x_get_features,
-	.config_aneg		= qca808x_config_aneg,
-	.suspend		= genphy_suspend,
-	.resume			= genphy_resume,
-	.read_status		= qca808x_read_status,
-	.config_init		= qca808x_config_init,
-	.soft_reset		= qca808x_soft_reset,
-	.cable_test_start	= qca808x_cable_test_start,
-	.cable_test_get_status	= qca808x_cable_test_get_status,
-	.link_change_notify	= qca808x_link_change_notify,
 }, };
 
 module_phy_driver(at803x_driver);
@@ -2107,7 +1216,6 @@ static struct mdio_device_id __maybe_unused atheros_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(ATH8035_PHY_ID) },
 	{ PHY_ID_MATCH_EXACT(ATH9331_PHY_ID) },
 	{ PHY_ID_MATCH_EXACT(QCA9561_PHY_ID) },
-	{ PHY_ID_MATCH_EXACT(QCA8081_PHY_ID) },
 	{ }
 };
 
diff --git a/drivers/net/phy/qcom/common.c b/drivers/net/phy/qcom/common.c
index 1d9b80fea2e9..48c1614eb979 100644
--- a/drivers/net/phy/qcom/common.c
+++ b/drivers/net/phy/qcom/common.c
@@ -2,7 +2,7 @@
 
 #include <linux/phy.h>
 #include <linux/module.h>
-
+#include <linux/etherdevice.h>
 #include <linux/regulator/driver.h>
 #include <linux/of.h>
 #include <linux/phylink.h>
@@ -48,3 +48,304 @@ int at803x_debug_reg_write(struct phy_device *phydev, u16 reg, u16 data)
 
 	return phy_write(phydev, AT803X_DEBUG_DATA, data);
 }
+
+int at803x_config_mdix(struct phy_device *phydev, u8 ctrl)
+{
+	u16 val;
+
+	switch (ctrl) {
+	case ETH_TP_MDI:
+		val = AT803X_SFC_MANUAL_MDI;
+		break;
+	case ETH_TP_MDI_X:
+		val = AT803X_SFC_MANUAL_MDIX;
+		break;
+	case ETH_TP_MDI_AUTO:
+		val = AT803X_SFC_AUTOMATIC_CROSSOVER;
+		break;
+	default:
+		return 0;
+	}
+
+	return phy_modify_changed(phydev, AT803X_SPECIFIC_FUNCTION_CONTROL,
+			  AT803X_SFC_MDI_CROSSOVER_MODE_M,
+			  FIELD_PREP(AT803X_SFC_MDI_CROSSOVER_MODE_M, val));
+}
+
+int at803x_read_specific_status(struct phy_device *phydev,
+				struct at803x_ss_mask ss_mask)
+{
+	int ss;
+
+	/* Read the AT8035 PHY-Specific Status register, which indicates the
+	 * speed and duplex that the PHY is actually using, irrespective of
+	 * whether we are in autoneg mode or not.
+	 */
+	ss = phy_read(phydev, AT803X_SPECIFIC_STATUS);
+	if (ss < 0)
+		return ss;
+
+	if (ss & AT803X_SS_SPEED_DUPLEX_RESOLVED) {
+		int sfc, speed;
+
+		sfc = phy_read(phydev, AT803X_SPECIFIC_FUNCTION_CONTROL);
+		if (sfc < 0)
+			return sfc;
+
+		speed = ss & ss_mask.speed_mask;
+		speed >>= ss_mask.speed_shift;
+
+		switch (speed) {
+		case AT803X_SS_SPEED_10:
+			phydev->speed = SPEED_10;
+			break;
+		case AT803X_SS_SPEED_100:
+			phydev->speed = SPEED_100;
+			break;
+		case AT803X_SS_SPEED_1000:
+			phydev->speed = SPEED_1000;
+			break;
+		case QCA808X_SS_SPEED_2500:
+			phydev->speed = SPEED_2500;
+			break;
+		}
+		if (ss & AT803X_SS_DUPLEX)
+			phydev->duplex = DUPLEX_FULL;
+		else
+			phydev->duplex = DUPLEX_HALF;
+
+		if (ss & AT803X_SS_MDIX)
+			phydev->mdix = ETH_TP_MDI_X;
+		else
+			phydev->mdix = ETH_TP_MDI;
+
+		switch (FIELD_GET(AT803X_SFC_MDI_CROSSOVER_MODE_M, sfc)) {
+		case AT803X_SFC_MANUAL_MDI:
+			phydev->mdix_ctrl = ETH_TP_MDI;
+			break;
+		case AT803X_SFC_MANUAL_MDIX:
+			phydev->mdix_ctrl = ETH_TP_MDI_X;
+			break;
+		case AT803X_SFC_AUTOMATIC_CROSSOVER:
+			phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
+			break;
+		}
+	}
+
+	return 0;
+}
+
+int at803x_config_intr(struct phy_device *phydev)
+{
+	int err;
+	int value;
+
+	value = phy_read(phydev, AT803X_INTR_ENABLE);
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		/* Clear any pending interrupts */
+		err = at803x_ack_interrupt(phydev);
+		if (err)
+			return err;
+
+		value |= AT803X_INTR_ENABLE_AUTONEG_ERR;
+		value |= AT803X_INTR_ENABLE_SPEED_CHANGED;
+		value |= AT803X_INTR_ENABLE_DUPLEX_CHANGED;
+		value |= AT803X_INTR_ENABLE_LINK_FAIL;
+		value |= AT803X_INTR_ENABLE_LINK_SUCCESS;
+
+		err = phy_write(phydev, AT803X_INTR_ENABLE, value);
+	} else {
+		err = phy_write(phydev, AT803X_INTR_ENABLE, 0);
+		if (err)
+			return err;
+
+		/* Clear any pending interrupts */
+		err = at803x_ack_interrupt(phydev);
+	}
+
+	return err;
+}
+
+int at803x_ack_interrupt(struct phy_device *phydev)
+{
+	int err;
+
+	err = phy_read(phydev, AT803X_INTR_STATUS);
+
+	return (err < 0) ? err : 0;
+}
+
+irqreturn_t at803x_handle_interrupt(struct phy_device *phydev)
+{
+	int irq_status, int_enabled;
+
+	irq_status = phy_read(phydev, AT803X_INTR_STATUS);
+	if (irq_status < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	/* Read the current enabled interrupts */
+	int_enabled = phy_read(phydev, AT803X_INTR_ENABLE);
+	if (int_enabled < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	/* See if this was one of our enabled interrupts */
+	if (!(irq_status & int_enabled))
+		return IRQ_NONE;
+
+	phy_trigger_machine(phydev);
+
+	return IRQ_HANDLED;
+}
+
+int at803x_get_tunable(struct phy_device *phydev,
+		       struct ethtool_tunable *tuna, void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_DOWNSHIFT:
+		return at803x_get_downshift(phydev, data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+int at803x_set_tunable(struct phy_device *phydev,
+		       struct ethtool_tunable *tuna, const void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_DOWNSHIFT:
+		return at803x_set_downshift(phydev, *(const u8 *)data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+int at803x_get_downshift(struct phy_device *phydev, u8 *d)
+{
+	int val;
+
+	val = phy_read(phydev, AT803X_SMART_SPEED);
+	if (val < 0)
+		return val;
+
+	if (val & AT803X_SMART_SPEED_ENABLE)
+		*d = FIELD_GET(AT803X_SMART_SPEED_RETRY_LIMIT_MASK, val) + 2;
+	else
+		*d = DOWNSHIFT_DEV_DISABLE;
+
+	return 0;
+}
+
+int at803x_set_downshift(struct phy_device *phydev, u8 cnt)
+{
+	u16 mask, set;
+	int ret;
+
+	switch (cnt) {
+	case DOWNSHIFT_DEV_DEFAULT_COUNT:
+		cnt = AT803X_DEFAULT_DOWNSHIFT;
+		fallthrough;
+	case AT803X_MIN_DOWNSHIFT ... AT803X_MAX_DOWNSHIFT:
+		set = AT803X_SMART_SPEED_ENABLE |
+		      AT803X_SMART_SPEED_BYPASS_TIMER |
+		      FIELD_PREP(AT803X_SMART_SPEED_RETRY_LIMIT_MASK, cnt - 2);
+		mask = AT803X_SMART_SPEED_RETRY_LIMIT_MASK;
+		break;
+	case DOWNSHIFT_DEV_DISABLE:
+		set = 0;
+		mask = AT803X_SMART_SPEED_ENABLE |
+		       AT803X_SMART_SPEED_BYPASS_TIMER;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = phy_modify_changed(phydev, AT803X_SMART_SPEED, mask, set);
+
+	/* After changing the smart speed settings, we need to perform a
+	 * software reset, use phy_init_hw() to make sure we set the
+	 * reapply any values which might got lost during software reset.
+	 */
+	if (ret == 1)
+		ret = phy_init_hw(phydev);
+
+	return ret;
+}
+
+int at803x_set_wol(struct phy_device *phydev,
+		   struct ethtool_wolinfo *wol)
+{
+	int ret, irq_enabled;
+
+	if (wol->wolopts & WAKE_MAGIC) {
+		struct net_device *ndev = phydev->attached_dev;
+		const u8 *mac;
+		unsigned int i;
+		static const unsigned int offsets[] = {
+			AT803X_LOC_MAC_ADDR_32_47_OFFSET,
+			AT803X_LOC_MAC_ADDR_16_31_OFFSET,
+			AT803X_LOC_MAC_ADDR_0_15_OFFSET,
+		};
+
+		if (!ndev)
+			return -ENODEV;
+
+		mac = (const u8 *)ndev->dev_addr;
+
+		if (!is_valid_ether_addr(mac))
+			return -EINVAL;
+
+		for (i = 0; i < 3; i++)
+			phy_write_mmd(phydev, MDIO_MMD_PCS, offsets[i],
+				      mac[(i * 2) + 1] | (mac[(i * 2)] << 8));
+
+		/* Enable WOL interrupt */
+		ret = phy_modify(phydev, AT803X_INTR_ENABLE, 0, AT803X_INTR_ENABLE_WOL);
+		if (ret)
+			return ret;
+	} else {
+		/* Disable WOL interrupt */
+		ret = phy_modify(phydev, AT803X_INTR_ENABLE, AT803X_INTR_ENABLE_WOL, 0);
+		if (ret)
+			return ret;
+	}
+
+	/* Clear WOL status */
+	ret = phy_read(phydev, AT803X_INTR_STATUS);
+	if (ret < 0)
+		return ret;
+
+	/* Check if there are other interrupts except for WOL triggered when PHY is
+	 * in interrupt mode, only the interrupts enabled by AT803X_INTR_ENABLE can
+	 * be passed up to the interrupt PIN.
+	 */
+	irq_enabled = phy_read(phydev, AT803X_INTR_ENABLE);
+	if (irq_enabled < 0)
+		return irq_enabled;
+
+	irq_enabled &= ~AT803X_INTR_ENABLE_WOL;
+	if (ret & irq_enabled && !phy_polling_mode(phydev))
+		phy_trigger_machine(phydev);
+
+	return 0;
+}
+
+void at803x_get_wol(struct phy_device *phydev,
+		    struct ethtool_wolinfo *wol)
+{
+	int value;
+
+	wol->supported = WAKE_MAGIC;
+	wol->wolopts = 0;
+
+	value = phy_read(phydev, AT803X_INTR_ENABLE);
+	if (value < 0)
+		return;
+
+	if (value & AT803X_INTR_ENABLE_WOL)
+		wol->wolopts |= WAKE_MAGIC;
+}
diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
new file mode 100644
index 000000000000..61bc98bc8869
--- /dev/null
+++ b/drivers/net/phy/qcom/qca808x.c
@@ -0,0 +1,550 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/phy.h>
+#include <linux/module.h>
+#include <linux/ethtool_netlink.h>
+
+#include "qcom.h"
+
+/* ADC threshold */
+#define QCA808X_PHY_DEBUG_ADC_THRESHOLD		0x2c80
+#define QCA808X_ADC_THRESHOLD_MASK		GENMASK(7, 0)
+#define QCA808X_ADC_THRESHOLD_80MV		0
+#define QCA808X_ADC_THRESHOLD_100MV		0xf0
+#define QCA808X_ADC_THRESHOLD_200MV		0x0f
+#define QCA808X_ADC_THRESHOLD_300MV		0xff
+
+/* CLD control */
+#define QCA808X_PHY_MMD3_ADDR_CLD_CTRL7		0x8007
+#define QCA808X_8023AZ_AFE_CTRL_MASK		GENMASK(8, 4)
+#define QCA808X_8023AZ_AFE_EN			0x90
+
+/* AZ control */
+#define QCA808X_PHY_MMD3_AZ_TRAINING_CTRL	0x8008
+#define QCA808X_MMD3_AZ_TRAINING_VAL		0x1c32
+
+#define QCA808X_PHY_MMD1_MSE_THRESHOLD_20DB	0x8014
+#define QCA808X_MSE_THRESHOLD_20DB_VALUE	0x529
+
+#define QCA808X_PHY_MMD1_MSE_THRESHOLD_17DB	0x800E
+#define QCA808X_MSE_THRESHOLD_17DB_VALUE	0x341
+
+#define QCA808X_PHY_MMD1_MSE_THRESHOLD_27DB	0x801E
+#define QCA808X_MSE_THRESHOLD_27DB_VALUE	0x419
+
+#define QCA808X_PHY_MMD1_MSE_THRESHOLD_28DB	0x8020
+#define QCA808X_MSE_THRESHOLD_28DB_VALUE	0x341
+
+#define QCA808X_PHY_MMD7_TOP_OPTION1		0x901c
+#define QCA808X_TOP_OPTION1_DATA		0x0
+
+#define QCA808X_PHY_MMD3_DEBUG_1		0xa100
+#define QCA808X_MMD3_DEBUG_1_VALUE		0x9203
+#define QCA808X_PHY_MMD3_DEBUG_2		0xa101
+#define QCA808X_MMD3_DEBUG_2_VALUE		0x48ad
+#define QCA808X_PHY_MMD3_DEBUG_3		0xa103
+#define QCA808X_MMD3_DEBUG_3_VALUE		0x1698
+#define QCA808X_PHY_MMD3_DEBUG_4		0xa105
+#define QCA808X_MMD3_DEBUG_4_VALUE		0x8001
+#define QCA808X_PHY_MMD3_DEBUG_5		0xa106
+#define QCA808X_MMD3_DEBUG_5_VALUE		0x1111
+#define QCA808X_PHY_MMD3_DEBUG_6		0xa011
+#define QCA808X_MMD3_DEBUG_6_VALUE		0x5f85
+
+/* master/slave seed config */
+#define QCA808X_PHY_DEBUG_LOCAL_SEED		9
+#define QCA808X_MASTER_SLAVE_SEED_ENABLE	BIT(1)
+#define QCA808X_MASTER_SLAVE_SEED_CFG		GENMASK(12, 2)
+#define QCA808X_MASTER_SLAVE_SEED_RANGE		0x32
+
+/* Hibernation yields lower power consumpiton in contrast with normal operation mode.
+ * when the copper cable is unplugged, the PHY enters into hibernation mode in about 10s.
+ */
+#define QCA808X_DBG_AN_TEST			0xb
+#define QCA808X_HIBERNATION_EN			BIT(15)
+
+#define QCA808X_CDT_ENABLE_TEST			BIT(15)
+#define QCA808X_CDT_INTER_CHECK_DIS		BIT(13)
+#define QCA808X_CDT_LENGTH_UNIT			BIT(10)
+
+#define QCA808X_MMD3_CDT_STATUS			0x8064
+#define QCA808X_MMD3_CDT_DIAG_PAIR_A		0x8065
+#define QCA808X_MMD3_CDT_DIAG_PAIR_B		0x8066
+#define QCA808X_MMD3_CDT_DIAG_PAIR_C		0x8067
+#define QCA808X_MMD3_CDT_DIAG_PAIR_D		0x8068
+#define QCA808X_CDT_DIAG_LENGTH			GENMASK(7, 0)
+
+#define QCA808X_CDT_CODE_PAIR_A			GENMASK(15, 12)
+#define QCA808X_CDT_CODE_PAIR_B			GENMASK(11, 8)
+#define QCA808X_CDT_CODE_PAIR_C			GENMASK(7, 4)
+#define QCA808X_CDT_CODE_PAIR_D			GENMASK(3, 0)
+#define QCA808X_CDT_STATUS_STAT_FAIL		0
+#define QCA808X_CDT_STATUS_STAT_NORMAL		1
+#define QCA808X_CDT_STATUS_STAT_OPEN		2
+#define QCA808X_CDT_STATUS_STAT_SHORT		3
+
+/* QCA808X 1G chip type */
+#define QCA808X_PHY_MMD7_CHIP_TYPE		0x901d
+#define QCA808X_PHY_CHIP_TYPE_1G		BIT(0)
+
+#define QCA8081_PHY_SERDES_MMD1_FIFO_CTRL	0x9072
+#define QCA8081_PHY_FIFO_RSTN			BIT(11)
+
+#define QCA8081_PHY_ID				0x004dd101
+
+MODULE_DESCRIPTION("Qualcomm QCA808X PHY driver");
+MODULE_AUTHOR("Matus Ujhelyi");
+MODULE_LICENSE("GPL");
+
+static int qca808x_config_aneg(struct phy_device *phydev)
+{
+	int phy_ctrl = 0;
+	int ret;
+
+	ret = at803x_config_mdix(phydev, phydev->mdix_ctrl);
+	if (ret < 0)
+		return ret;
+
+	/* Changes of the midx bits are disruptive to the normal operation;
+	 * therefore any changes to these registers must be followed by a
+	 * software reset to take effect.
+	 */
+	if (ret == 1) {
+		ret = genphy_soft_reset(phydev);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Do not restart auto-negotiation by setting ret to 0 defautly,
+	 * when calling __genphy_config_aneg later.
+	 */
+	ret = 0;
+
+	/* The reg MII_BMCR also needs to be configured for force mode, the
+	 * genphy_config_aneg is also needed.
+	 */
+	if (phydev->autoneg == AUTONEG_DISABLE)
+		genphy_c45_pma_setup_forced(phydev);
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->advertising))
+		phy_ctrl = MDIO_AN_10GBT_CTRL_ADV2_5G;
+
+	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
+				     MDIO_AN_10GBT_CTRL_ADV2_5G, phy_ctrl);
+	if (ret < 0)
+		return ret;
+
+	return __genphy_config_aneg(phydev, ret);
+}
+
+static int qca808x_phy_fast_retrain_config(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Enable fast retrain */
+	ret = genphy_c45_fast_retrain(phydev, true);
+	if (ret)
+		return ret;
+
+	phy_write_mmd(phydev, MDIO_MMD_AN, QCA808X_PHY_MMD7_TOP_OPTION1,
+		      QCA808X_TOP_OPTION1_DATA);
+	phy_write_mmd(phydev, MDIO_MMD_PMAPMD, QCA808X_PHY_MMD1_MSE_THRESHOLD_20DB,
+		      QCA808X_MSE_THRESHOLD_20DB_VALUE);
+	phy_write_mmd(phydev, MDIO_MMD_PMAPMD, QCA808X_PHY_MMD1_MSE_THRESHOLD_17DB,
+		      QCA808X_MSE_THRESHOLD_17DB_VALUE);
+	phy_write_mmd(phydev, MDIO_MMD_PMAPMD, QCA808X_PHY_MMD1_MSE_THRESHOLD_27DB,
+		      QCA808X_MSE_THRESHOLD_27DB_VALUE);
+	phy_write_mmd(phydev, MDIO_MMD_PMAPMD, QCA808X_PHY_MMD1_MSE_THRESHOLD_28DB,
+		      QCA808X_MSE_THRESHOLD_28DB_VALUE);
+	phy_write_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_DEBUG_1,
+		      QCA808X_MMD3_DEBUG_1_VALUE);
+	phy_write_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_DEBUG_4,
+		      QCA808X_MMD3_DEBUG_4_VALUE);
+	phy_write_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_DEBUG_5,
+		      QCA808X_MMD3_DEBUG_5_VALUE);
+	phy_write_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_DEBUG_3,
+		      QCA808X_MMD3_DEBUG_3_VALUE);
+	phy_write_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_DEBUG_6,
+		      QCA808X_MMD3_DEBUG_6_VALUE);
+	phy_write_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_DEBUG_2,
+		      QCA808X_MMD3_DEBUG_2_VALUE);
+
+	return 0;
+}
+
+static int qca808x_phy_ms_seed_enable(struct phy_device *phydev, bool enable)
+{
+	u16 seed_value;
+
+	if (!enable)
+		return at803x_debug_reg_mask(phydev, QCA808X_PHY_DEBUG_LOCAL_SEED,
+				QCA808X_MASTER_SLAVE_SEED_ENABLE, 0);
+
+	seed_value = get_random_u32_below(QCA808X_MASTER_SLAVE_SEED_RANGE);
+	return at803x_debug_reg_mask(phydev, QCA808X_PHY_DEBUG_LOCAL_SEED,
+			QCA808X_MASTER_SLAVE_SEED_CFG | QCA808X_MASTER_SLAVE_SEED_ENABLE,
+			FIELD_PREP(QCA808X_MASTER_SLAVE_SEED_CFG, seed_value) |
+			QCA808X_MASTER_SLAVE_SEED_ENABLE);
+}
+
+static bool qca808x_is_prefer_master(struct phy_device *phydev)
+{
+	return (phydev->master_slave_get == MASTER_SLAVE_CFG_MASTER_FORCE) ||
+		(phydev->master_slave_get == MASTER_SLAVE_CFG_MASTER_PREFERRED);
+}
+
+static bool qca808x_has_fast_retrain_or_slave_seed(struct phy_device *phydev)
+{
+	return linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported);
+}
+
+static int qca808x_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Active adc&vga on 802.3az for the link 1000M and 100M */
+	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_ADDR_CLD_CTRL7,
+			     QCA808X_8023AZ_AFE_CTRL_MASK, QCA808X_8023AZ_AFE_EN);
+	if (ret)
+		return ret;
+
+	/* Adjust the threshold on 802.3az for the link 1000M */
+	ret = phy_write_mmd(phydev, MDIO_MMD_PCS,
+			    QCA808X_PHY_MMD3_AZ_TRAINING_CTRL,
+			    QCA808X_MMD3_AZ_TRAINING_VAL);
+	if (ret)
+		return ret;
+
+	if (qca808x_has_fast_retrain_or_slave_seed(phydev)) {
+		/* Config the fast retrain for the link 2500M */
+		ret = qca808x_phy_fast_retrain_config(phydev);
+		if (ret)
+			return ret;
+
+		ret = genphy_read_master_slave(phydev);
+		if (ret < 0)
+			return ret;
+
+		if (!qca808x_is_prefer_master(phydev)) {
+			/* Enable seed and configure lower ramdom seed to make phy
+			 * linked as slave mode.
+			 */
+			ret = qca808x_phy_ms_seed_enable(phydev, true);
+			if (ret)
+				return ret;
+		}
+	}
+
+	/* Configure adc threshold as 100mv for the link 10M */
+	return at803x_debug_reg_mask(phydev, QCA808X_PHY_DEBUG_ADC_THRESHOLD,
+				     QCA808X_ADC_THRESHOLD_MASK,
+				     QCA808X_ADC_THRESHOLD_100MV);
+}
+
+static int qca808x_read_status(struct phy_device *phydev)
+{
+	struct at803x_ss_mask ss_mask = { 0 };
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_STAT);
+	if (ret < 0)
+		return ret;
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->lp_advertising,
+			 ret & MDIO_AN_10GBT_STAT_LP2_5G);
+
+	ret = genphy_read_status(phydev);
+	if (ret)
+		return ret;
+
+	/* qca8081 takes the different bits for speed value from at803x */
+	ss_mask.speed_mask = QCA808X_SS_SPEED_MASK;
+	ss_mask.speed_shift = __bf_shf(QCA808X_SS_SPEED_MASK);
+	ret = at803x_read_specific_status(phydev, ss_mask);
+	if (ret < 0)
+		return ret;
+
+	if (phydev->link) {
+		if (phydev->speed == SPEED_2500)
+			phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
+		else
+			phydev->interface = PHY_INTERFACE_MODE_SGMII;
+	} else {
+		/* generate seed as a lower random value to make PHY linked as SLAVE easily,
+		 * except for master/slave configuration fault detected or the master mode
+		 * preferred.
+		 *
+		 * the reason for not putting this code into the function link_change_notify is
+		 * the corner case where the link partner is also the qca8081 PHY and the seed
+		 * value is configured as the same value, the link can't be up and no link change
+		 * occurs.
+		 */
+		if (qca808x_has_fast_retrain_or_slave_seed(phydev)) {
+			if (phydev->master_slave_state == MASTER_SLAVE_STATE_ERR ||
+			    qca808x_is_prefer_master(phydev)) {
+				qca808x_phy_ms_seed_enable(phydev, false);
+			} else {
+				qca808x_phy_ms_seed_enable(phydev, true);
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int qca808x_soft_reset(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_soft_reset(phydev);
+	if (ret < 0)
+		return ret;
+
+	if (qca808x_has_fast_retrain_or_slave_seed(phydev))
+		ret = qca808x_phy_ms_seed_enable(phydev, true);
+
+	return ret;
+}
+
+static bool qca808x_cdt_fault_length_valid(int cdt_code)
+{
+	switch (cdt_code) {
+	case QCA808X_CDT_STATUS_STAT_SHORT:
+	case QCA808X_CDT_STATUS_STAT_OPEN:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int qca808x_cable_test_result_trans(int cdt_code)
+{
+	switch (cdt_code) {
+	case QCA808X_CDT_STATUS_STAT_NORMAL:
+		return ETHTOOL_A_CABLE_RESULT_CODE_OK;
+	case QCA808X_CDT_STATUS_STAT_SHORT:
+		return ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT;
+	case QCA808X_CDT_STATUS_STAT_OPEN:
+		return ETHTOOL_A_CABLE_RESULT_CODE_OPEN;
+	case QCA808X_CDT_STATUS_STAT_FAIL:
+	default:
+		return ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC;
+	}
+}
+
+static int qca808x_cdt_fault_length(struct phy_device *phydev, int pair)
+{
+	int val;
+	u32 cdt_length_reg = 0;
+
+	switch (pair) {
+	case ETHTOOL_A_CABLE_PAIR_A:
+		cdt_length_reg = QCA808X_MMD3_CDT_DIAG_PAIR_A;
+		break;
+	case ETHTOOL_A_CABLE_PAIR_B:
+		cdt_length_reg = QCA808X_MMD3_CDT_DIAG_PAIR_B;
+		break;
+	case ETHTOOL_A_CABLE_PAIR_C:
+		cdt_length_reg = QCA808X_MMD3_CDT_DIAG_PAIR_C;
+		break;
+	case ETHTOOL_A_CABLE_PAIR_D:
+		cdt_length_reg = QCA808X_MMD3_CDT_DIAG_PAIR_D;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	val = phy_read_mmd(phydev, MDIO_MMD_PCS, cdt_length_reg);
+	if (val < 0)
+		return val;
+
+	return (FIELD_GET(QCA808X_CDT_DIAG_LENGTH, val) * 824) / 10;
+}
+
+static int qca808x_cable_test_start(struct phy_device *phydev)
+{
+	int ret;
+
+	/* perform CDT with the following configs:
+	 * 1. disable hibernation.
+	 * 2. force PHY working in MDI mode.
+	 * 3. for PHY working in 1000BaseT.
+	 * 4. configure the threshold.
+	 */
+
+	ret = at803x_debug_reg_mask(phydev, QCA808X_DBG_AN_TEST, QCA808X_HIBERNATION_EN, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = at803x_config_mdix(phydev, ETH_TP_MDI);
+	if (ret < 0)
+		return ret;
+
+	/* Force 1000base-T needs to configure PMA/PMD and MII_BMCR */
+	phydev->duplex = DUPLEX_FULL;
+	phydev->speed = SPEED_1000;
+	ret = genphy_c45_pma_setup_forced(phydev);
+	if (ret < 0)
+		return ret;
+
+	ret = genphy_setup_forced(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* configure the thresholds for open, short, pair ok test */
+	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x8074, 0xc040);
+	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x8076, 0xc040);
+	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x8077, 0xa060);
+	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x8078, 0xc050);
+	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x807a, 0xc060);
+	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x807e, 0xb060);
+
+	return 0;
+}
+
+static int qca808x_cdt_start(struct phy_device *phydev)
+{
+	u16 cdt;
+
+	/* qca8081 takes the different bit 15 to enable CDT test */
+	cdt = QCA808X_CDT_ENABLE_TEST |
+	      QCA808X_CDT_LENGTH_UNIT |
+	      QCA808X_CDT_INTER_CHECK_DIS;
+
+	return phy_write(phydev, AT803X_CDT, cdt);
+}
+
+static int qca808x_cdt_wait_for_completition(struct phy_device *phydev)
+{
+	int val, ret;
+
+	/* One test run takes about 25ms */
+	ret = phy_read_poll_timeout(phydev, AT803X_CDT, val,
+				    !(val & QCA808X_CDT_ENABLE_TEST),
+				    30000, 100000, true);
+
+	return ret < 0 ? ret : 0;
+}
+
+static int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finished)
+{
+	int ret, val;
+	int pair_a, pair_b, pair_c, pair_d;
+
+	*finished = false;
+
+	ret = qca808x_cdt_start(phydev);
+	if (ret)
+		return ret;
+
+	ret = qca808x_cdt_wait_for_completition(phydev);
+	if (ret)
+		return ret;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_PCS, QCA808X_MMD3_CDT_STATUS);
+	if (val < 0)
+		return val;
+
+	pair_a = FIELD_GET(QCA808X_CDT_CODE_PAIR_A, val);
+	pair_b = FIELD_GET(QCA808X_CDT_CODE_PAIR_B, val);
+	pair_c = FIELD_GET(QCA808X_CDT_CODE_PAIR_C, val);
+	pair_d = FIELD_GET(QCA808X_CDT_CODE_PAIR_D, val);
+
+	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_A,
+				qca808x_cable_test_result_trans(pair_a));
+	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_B,
+				qca808x_cable_test_result_trans(pair_b));
+	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_C,
+				qca808x_cable_test_result_trans(pair_c));
+	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_D,
+				qca808x_cable_test_result_trans(pair_d));
+
+	if (qca808x_cdt_fault_length_valid(pair_a))
+		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A,
+				qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A));
+	if (qca808x_cdt_fault_length_valid(pair_b))
+		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B,
+				qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B));
+	if (qca808x_cdt_fault_length_valid(pair_c))
+		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C,
+				qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C));
+	if (qca808x_cdt_fault_length_valid(pair_d))
+		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D,
+				qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D));
+
+	*finished = true;
+
+	return 0;
+}
+
+static int qca808x_get_features(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_c45_pma_read_abilities(phydev);
+	if (ret)
+		return ret;
+
+	/* The autoneg ability is not existed in bit3 of MMD7.1,
+	 * but it is supported by qca808x PHY, so we add it here
+	 * manually.
+	 */
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, phydev->supported);
+
+	/* As for the qca8081 1G version chip, the 2500baseT ability is also
+	 * existed in the bit0 of MMD1.21, we need to remove it manually if
+	 * it is the qca8081 1G chip according to the bit0 of MMD7.0x901d.
+	 */
+	ret = phy_read_mmd(phydev, MDIO_MMD_AN, QCA808X_PHY_MMD7_CHIP_TYPE);
+	if (ret < 0)
+		return ret;
+
+	if (QCA808X_PHY_CHIP_TYPE_1G & ret)
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported);
+
+	return 0;
+}
+
+static void qca808x_link_change_notify(struct phy_device *phydev)
+{
+	/* Assert interface sgmii fifo on link down, deassert it on link up,
+	 * the interface device address is always phy address added by 1.
+	 */
+	mdiobus_c45_modify_changed(phydev->mdio.bus, phydev->mdio.addr + 1,
+				   MDIO_MMD_PMAPMD, QCA8081_PHY_SERDES_MMD1_FIFO_CTRL,
+				   QCA8081_PHY_FIFO_RSTN,
+				   phydev->link ? QCA8081_PHY_FIFO_RSTN : 0);
+}
+
+static struct phy_driver qca808x_driver[] = {
+{
+	/* Qualcomm QCA8081 */
+	PHY_ID_MATCH_EXACT(QCA8081_PHY_ID),
+	.name			= "Qualcomm QCA8081",
+	.flags			= PHY_POLL_CABLE_TEST,
+	.config_intr		= at803x_config_intr,
+	.handle_interrupt	= at803x_handle_interrupt,
+	.get_tunable		= at803x_get_tunable,
+	.set_tunable		= at803x_set_tunable,
+	.set_wol		= at803x_set_wol,
+	.get_wol		= at803x_get_wol,
+	.get_features		= qca808x_get_features,
+	.config_aneg		= qca808x_config_aneg,
+	.suspend		= genphy_suspend,
+	.resume			= genphy_resume,
+	.read_status		= qca808x_read_status,
+	.config_init		= qca808x_config_init,
+	.soft_reset		= qca808x_soft_reset,
+	.cable_test_start	= qca808x_cable_test_start,
+	.cable_test_get_status	= qca808x_cable_test_get_status,
+	.link_change_notify	= qca808x_link_change_notify,
+}, };
+
+module_phy_driver(qca808x_driver);
+
+static struct mdio_device_id __maybe_unused qca808x_tbl[] = {
+	{ PHY_ID_MATCH_EXACT(QCA8081_PHY_ID) },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(mdio, qca808x_tbl);
diff --git a/drivers/net/phy/qcom/qcom.h b/drivers/net/phy/qcom/qcom.h
index 17cc6705dd3e..cc968ea3e972 100644
--- a/drivers/net/phy/qcom/qcom.h
+++ b/drivers/net/phy/qcom/qcom.h
@@ -1,5 +1,65 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#define AT803X_SPECIFIC_FUNCTION_CONTROL	0x10
+#define AT803X_SFC_ASSERT_CRS			BIT(11)
+#define AT803X_SFC_FORCE_LINK			BIT(10)
+#define AT803X_SFC_MDI_CROSSOVER_MODE_M		GENMASK(6, 5)
+#define AT803X_SFC_AUTOMATIC_CROSSOVER		0x3
+#define AT803X_SFC_MANUAL_MDIX			0x1
+#define AT803X_SFC_MANUAL_MDI			0x0
+#define AT803X_SFC_SQE_TEST			BIT(2)
+#define AT803X_SFC_POLARITY_REVERSAL		BIT(1)
+#define AT803X_SFC_DISABLE_JABBER		BIT(0)
+
+#define AT803X_SPECIFIC_STATUS			0x11
+#define AT803X_SS_SPEED_MASK			GENMASK(15, 14)
+#define AT803X_SS_SPEED_1000			2
+#define AT803X_SS_SPEED_100			1
+#define AT803X_SS_SPEED_10			0
+#define AT803X_SS_DUPLEX			BIT(13)
+#define AT803X_SS_SPEED_DUPLEX_RESOLVED		BIT(11)
+#define AT803X_SS_MDIX				BIT(6)
+
+#define QCA808X_SS_SPEED_MASK			GENMASK(9, 7)
+#define QCA808X_SS_SPEED_2500			4
+
+#define AT803X_INTR_ENABLE			0x12
+#define AT803X_INTR_ENABLE_AUTONEG_ERR		BIT(15)
+#define AT803X_INTR_ENABLE_SPEED_CHANGED	BIT(14)
+#define AT803X_INTR_ENABLE_DUPLEX_CHANGED	BIT(13)
+#define AT803X_INTR_ENABLE_PAGE_RECEIVED	BIT(12)
+#define AT803X_INTR_ENABLE_LINK_FAIL		BIT(11)
+#define AT803X_INTR_ENABLE_LINK_SUCCESS		BIT(10)
+#define AT803X_INTR_ENABLE_LINK_FAIL_BX		BIT(8)
+#define AT803X_INTR_ENABLE_LINK_SUCCESS_BX	BIT(7)
+#define AT803X_INTR_ENABLE_WIRESPEED_DOWNGRADE	BIT(5)
+#define AT803X_INTR_ENABLE_POLARITY_CHANGED	BIT(1)
+#define AT803X_INTR_ENABLE_WOL			BIT(0)
+
+#define AT803X_INTR_STATUS			0x13
+
+#define AT803X_SMART_SPEED			0x14
+#define AT803X_SMART_SPEED_ENABLE		BIT(5)
+#define AT803X_SMART_SPEED_RETRY_LIMIT_MASK	GENMASK(4, 2)
+#define AT803X_SMART_SPEED_BYPASS_TIMER		BIT(1)
+
+#define AT803X_CDT				0x16
+#define AT803X_CDT_MDI_PAIR_MASK		GENMASK(9, 8)
+#define AT803X_CDT_ENABLE_TEST			BIT(0)
+#define AT803X_CDT_STATUS			0x1c
+#define AT803X_CDT_STATUS_STAT_NORMAL		0
+#define AT803X_CDT_STATUS_STAT_SHORT		1
+#define AT803X_CDT_STATUS_STAT_OPEN		2
+#define AT803X_CDT_STATUS_STAT_FAIL		3
+#define AT803X_CDT_STATUS_STAT_MASK		GENMASK(9, 8)
+#define AT803X_CDT_STATUS_DELTA_TIME_MASK	GENMASK(7, 0)
+
+#define AT803X_PHY_MMD3_WOL_CTRL		0x8012
+#define AT803X_WOL_EN				BIT(5)
+#define AT803X_LOC_MAC_ADDR_0_15_OFFSET		0x804C
+#define AT803X_LOC_MAC_ADDR_16_31_OFFSET	0x804B
+#define AT803X_LOC_MAC_ADDR_32_47_OFFSET	0x804A
+
 #define AT803X_DEBUG_ANALOG_TEST_CTRL		0x00
 #define QCA8327_DEBUG_MANU_CTRL_EN		BIT(2)
 #define QCA8337_DEBUG_MANU_CTRL_EN		GENMASK(3, 2)
@@ -20,6 +80,10 @@
 #define AT803X_DEBUG_PLL_ON			BIT(2)
 #define AT803X_DEBUG_RGMII_1V8			BIT(3)
 
+#define AT803X_DEFAULT_DOWNSHIFT		5
+#define AT803X_MIN_DOWNSHIFT			2
+#define AT803X_MAX_DOWNSHIFT			9
+
 enum stat_access_type {
 	PHY,
 	MMD
@@ -32,7 +96,29 @@ struct at803x_hw_stat {
 	enum stat_access_type access_type;
 };
 
+struct at803x_ss_mask {
+	u16 speed_mask;
+	u8 speed_shift;
+};
+
 int at803x_debug_reg_read(struct phy_device *phydev, u16 reg);
 int at803x_debug_reg_mask(struct phy_device *phydev, u16 reg,
 			  u16 clear, u16 set);
 int at803x_debug_reg_write(struct phy_device *phydev, u16 reg, u16 data);
+
+int at803x_config_mdix(struct phy_device *phydev, u8 ctrl);
+int at803x_read_specific_status(struct phy_device *phydev,
+				struct at803x_ss_mask ss_mask);
+int at803x_config_intr(struct phy_device *phydev);
+int at803x_ack_interrupt(struct phy_device *phydev);
+irqreturn_t at803x_handle_interrupt(struct phy_device *phydev);
+int at803x_get_tunable(struct phy_device *phydev,
+		       struct ethtool_tunable *tuna, void *data);
+int at803x_set_tunable(struct phy_device *phydev,
+		       struct ethtool_tunable *tuna, const void *data);
+int at803x_get_downshift(struct phy_device *phydev, u8 *d);
+int at803x_set_downshift(struct phy_device *phydev, u8 cnt);
+int at803x_set_wol(struct phy_device *phydev,
+		   struct ethtool_wolinfo *wol);
+void at803x_get_wol(struct phy_device *phydev,
+		    struct ethtool_wolinfo *wol);
-- 
2.40.1

