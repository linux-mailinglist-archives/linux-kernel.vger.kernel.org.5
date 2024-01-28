Return-Path: <linux-kernel+bounces-41613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB2D83F560
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 13:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96844282A8F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114952E64F;
	Sun, 28 Jan 2024 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFzm2Nue"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0B928699;
	Sun, 28 Jan 2024 12:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706443509; cv=none; b=aJPYP4lF17R4wj7M3oczvB4DjULH0eK0ghkOsncUKFwIvu/uvRwy3FEg+KBMSzaiRipSYl9ZCF/TZcxsr/CRbIB1ppcwKCMlFM4rchcXr5FpnpCDDlHKjxKwnjR0PVg5AsJaf2X9Np+zhyvw/w+UeZj8bHH42JGN0DtAvKeOsl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706443509; c=relaxed/simple;
	bh=bOy9ptxYfhFqvuTjh35hHt/R1X1z+YMTQmiuRt0Vh8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r93azhHleEUyNqkttKOzBV8eqW3M7I7qihkFByX4Q244Lctc9kq8hbAYl+0NWur4nJASxIRh1fREumH+jj+KieGbYnTv0StpSPByMCFhozGnD7lp67/E5BQXIuY9Lam62VPuCPZ2Oy23WPOMBN1AnVEKGDmVi/0tc2HKzAHurN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFzm2Nue; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3392b045e0aso1781538f8f.2;
        Sun, 28 Jan 2024 04:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706443504; x=1707048304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEw/y+PPGnnMamA+XZ8DEM3XpMsH6JfYOGyBk6luOHY=;
        b=eFzm2NueBjp+UuDWqrQQwbxMVmE2oA1Ej2pRUhHTOhhL0fL+Ipu5uQnybxifAmnqix
         tFJ0WmpAUCWUWAO4bjqHcI68uTFi3vzc+RGybscMoAXQSy4bhSx+OLhzY0OpQRBVLxjT
         +xQZ1ruXPspAHPTxWO3D/svIRqupvml5o3o6pUV6Csk6tvGwNKtn0PTCrTdVJ6Py6Bcb
         ZptCbyemeByOiy/EUVOlthqU6c9KL6x4HH9LbGo1nk4abBTD1LNFnR1i+pN+sW+1LdfT
         bom8ygZCwXsCGX0LFWFzw/BPywnrc67ZkOq+wnPRnyQIwsWcjR3gb7Exs4SsMJ3qnXSq
         i0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706443504; x=1707048304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEw/y+PPGnnMamA+XZ8DEM3XpMsH6JfYOGyBk6luOHY=;
        b=JjVfgQduQ8qLQWcwWJxm2zzXIoBrU3BXmPY5MEtwpeyO6kF+CbH91KPYbWWMNS/6dD
         RZ25W7b8ao/LwHmx/OYGjHPYqtQpnyhUoOHuR5oJXnAfZxtFi8y9Z3L5Py4YnsQ7UHCK
         4WuvmyVlNW/9zYLpqp68O0nOYmSidGe+KL2G2QAzLZM7rWpn0LxWY4/6fx3D6JXqNKxh
         eEU2OYv4Q+xm+bBuXwAp6FXNRGgupU9WNWfyRdfNetHS+iWk9VrVDlWYXWU4sMSL74tl
         bcWtBkIfU327YeRuH11XjADT8S09Z3bn8K2bVMh/FMLNoMgwAj5DhCx5ogsw8oSLXYSe
         k5mA==
X-Gm-Message-State: AOJu0YwFCUR2mW+FEFj7MnW8NoNbuPaLV++Lsu9QdnKEpro5Dla9DcQO
	6uanDcqx8LjokgoaaPtX7TXHQfJgRBoAIXS35X8qla1W7ge742U4
X-Google-Smtp-Source: AGHT+IHb1TQpC4iM7f+7ijga2QM2U44kJPj3tNjenzCu0nG0TEzO/90Ps/2d/zyIPngpQENQr4ZNgw==
X-Received: by 2002:a5d:4d11:0:b0:337:c6a6:6241 with SMTP id z17-20020a5d4d11000000b00337c6a66241mr2168346wrt.26.1706443504314;
        Sun, 28 Jan 2024 04:05:04 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id v1-20020a5d59c1000000b0033aeab6f75fsm1110034wry.79.2024.01.28.04.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 04:05:03 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v3 4/5] net: phy: qcom: move additional functions to shared library
Date: Sun, 28 Jan 2024 13:04:25 +0100
Message-ID: <20240128120451.31219-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128120451.31219-1-ansuelsmth@gmail.com>
References: <20240128120451.31219-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move additional functions to shared library in preparation for qca808x
PHY Family to be detached from at803x driver.

Only the shared defines are moved to the shared qcom.h header.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/qcom/at803x.c       | 426 +---------------------------
 drivers/net/phy/qcom/qcom-phy-lib.c | 376 ++++++++++++++++++++++++
 drivers/net/phy/qcom/qcom.h         |  86 ++++++
 3 files changed, 463 insertions(+), 425 deletions(-)

diff --git a/drivers/net/phy/qcom/at803x.c b/drivers/net/phy/qcom/at803x.c
index 638babc50df1..6a753498b994 100644
--- a/drivers/net/phy/qcom/at803x.c
+++ b/drivers/net/phy/qcom/at803x.c
@@ -24,65 +24,11 @@
 
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
 
 #define AT803X_PHY_MMD3_WOL_CTRL		0x8012
 #define AT803X_WOL_EN				BIT(5)
-#define AT803X_LOC_MAC_ADDR_0_15_OFFSET		0x804C
-#define AT803X_LOC_MAC_ADDR_16_31_OFFSET	0x804B
-#define AT803X_LOC_MAC_ADDR_32_47_OFFSET	0x804A
+
 #define AT803X_REG_CHIP_CONFIG			0x1f
 #define AT803X_BT_BX_REG_SEL			0x8000
 
@@ -138,10 +84,6 @@
 #define AT803X_CLK_OUT_STRENGTH_HALF		1
 #define AT803X_CLK_OUT_STRENGTH_QUARTER		2
 
-#define AT803X_DEFAULT_DOWNSHIFT		5
-#define AT803X_MIN_DOWNSHIFT			2
-#define AT803X_MAX_DOWNSHIFT			9
-
 #define AT803X_MMD3_SMARTEEE_CTL1		0x805b
 #define AT803X_MMD3_SMARTEEE_CTL2		0x805c
 #define AT803X_MMD3_SMARTEEE_CTL3		0x805d
@@ -366,11 +308,6 @@ MODULE_DESCRIPTION("Qualcomm Atheros AR803x and QCA808X PHY driver");
 MODULE_AUTHOR("Matus Ujhelyi");
 MODULE_LICENSE("GPL");
 
-struct at803x_ss_mask {
-	u16 speed_mask;
-	u8 speed_shift;
-};
-
 struct at803x_priv {
 	int flags;
 	u16 clk_25m_reg;
@@ -470,80 +407,6 @@ static void at803x_context_restore(struct phy_device *phydev,
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
-		mac = (const u8 *)ndev->dev_addr;
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
@@ -816,73 +679,6 @@ static int at803x_config_init(struct phy_device *phydev)
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
@@ -908,69 +704,6 @@ static void at803x_link_change_notify(struct phy_device *phydev)
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
@@ -1006,50 +739,6 @@ static int at803x_read_status(struct phy_device *phydev)
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
-static int at803x_prepare_config_aneg(struct phy_device *phydev)
-{
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
-	return 0;
-}
-
 static int at803x_config_aneg(struct phy_device *phydev)
 {
 	struct at803x_priv *priv = phydev->priv;
@@ -1065,80 +754,6 @@ static int at803x_config_aneg(struct phy_device *phydev)
 	return genphy_config_aneg(phydev);
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
@@ -1170,45 +785,6 @@ static bool at803x_cdt_fault_length_valid(u16 status)
 	return false;
 }
 
-static int at803x_cdt_fault_length(int dt)
-{
-	/* According to the datasheet the distance to the fault is
-	 * DELTA_TIME * 0.824 meters.
-	 *
-	 * The author suspect the correct formula is:
-	 *
-	 *   fault_distance = DELTA_TIME * (c * VF) / 125MHz / 2
-	 *
-	 * where c is the speed of light, VF is the velocity factor of
-	 * the twisted pair cable, 125MHz the counter frequency and
-	 * we need to divide by 2 because the hardware will measure the
-	 * round trip time to the fault and back to the PHY.
-	 *
-	 * With a VF of 0.69 we get the factor 0.824 mentioned in the
-	 * datasheet.
-	 */
-	return (dt * 824) / 10;
-}
-
-static int at803x_cdt_start(struct phy_device *phydev,
-			    u32 cdt_start)
-{
-	return phy_write(phydev, AT803X_CDT, cdt_start);
-}
-
-static int at803x_cdt_wait_for_completion(struct phy_device *phydev,
-					  u32 cdt_en)
-{
-	int val, ret;
-
-	/* One test run takes about 25ms */
-	ret = phy_read_poll_timeout(phydev, AT803X_CDT, val,
-				    !(val & cdt_en),
-				    30000, 100000, true);
-
-	return ret < 0 ? ret : 0;
-}
-
 static int at803x_cable_test_one_pair(struct phy_device *phydev, int pair)
 {
 	static const int ethtool_pair[] = {
diff --git a/drivers/net/phy/qcom/qcom-phy-lib.c b/drivers/net/phy/qcom/qcom-phy-lib.c
index 7192184429b7..e0295d4b4a51 100644
--- a/drivers/net/phy/qcom/qcom-phy-lib.c
+++ b/drivers/net/phy/qcom/qcom-phy-lib.c
@@ -3,6 +3,9 @@
 #include <linux/phy.h>
 #include <linux/module.h>
 
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+
 #include "qcom.h"
 
 MODULE_DESCRIPTION("Qualcomm PHY driver Common Functions");
@@ -51,3 +54,376 @@ int at803x_debug_reg_write(struct phy_device *phydev, u16 reg, u16 data)
 	return phy_write(phydev, AT803X_DEBUG_DATA, data);
 }
 EXPORT_SYMBOL_GPL(at803x_debug_reg_write);
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
+EXPORT_SYMBOL_GPL(at803x_set_wol);
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
+EXPORT_SYMBOL_GPL(at803x_get_wol);
+
+int at803x_ack_interrupt(struct phy_device *phydev)
+{
+	int err;
+
+	err = phy_read(phydev, AT803X_INTR_STATUS);
+
+	return (err < 0) ? err : 0;
+}
+EXPORT_SYMBOL_GPL(at803x_ack_interrupt);
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
+EXPORT_SYMBOL_GPL(at803x_config_intr);
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
+EXPORT_SYMBOL_GPL(at803x_handle_interrupt);
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
+EXPORT_SYMBOL_GPL(at803x_read_specific_status);
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
+EXPORT_SYMBOL_GPL(at803x_config_mdix);
+
+int at803x_prepare_config_aneg(struct phy_device *phydev)
+{
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
+	return 0;
+}
+EXPORT_SYMBOL_GPL(at803x_prepare_config_aneg);
+
+static int at803x_get_downshift(struct phy_device *phydev, u8 *d)
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
+static int at803x_set_downshift(struct phy_device *phydev, u8 cnt)
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
+EXPORT_SYMBOL_GPL(at803x_get_tunable);
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
+EXPORT_SYMBOL_GPL(at803x_set_tunable);
+
+int at803x_cdt_fault_length(int dt)
+{
+	/* According to the datasheet the distance to the fault is
+	 * DELTA_TIME * 0.824 meters.
+	 *
+	 * The author suspect the correct formula is:
+	 *
+	 *   fault_distance = DELTA_TIME * (c * VF) / 125MHz / 2
+	 *
+	 * where c is the speed of light, VF is the velocity factor of
+	 * the twisted pair cable, 125MHz the counter frequency and
+	 * we need to divide by 2 because the hardware will measure the
+	 * round trip time to the fault and back to the PHY.
+	 *
+	 * With a VF of 0.69 we get the factor 0.824 mentioned in the
+	 * datasheet.
+	 */
+	return (dt * 824) / 10;
+}
+EXPORT_SYMBOL_GPL(at803x_cdt_fault_length);
+
+int at803x_cdt_start(struct phy_device *phydev, u32 cdt_start)
+{
+	return phy_write(phydev, AT803X_CDT, cdt_start);
+}
+EXPORT_SYMBOL_GPL(at803x_cdt_start);
+
+int at803x_cdt_wait_for_completion(struct phy_device *phydev,
+				   u32 cdt_en)
+{
+	int val, ret;
+
+	/* One test run takes about 25ms */
+	ret = phy_read_poll_timeout(phydev, AT803X_CDT, val,
+				    !(val & cdt_en),
+				    30000, 100000, true);
+
+	return ret < 0 ? ret : 0;
+}
+EXPORT_SYMBOL_GPL(at803x_cdt_wait_for_completion);
diff --git a/drivers/net/phy/qcom/qcom.h b/drivers/net/phy/qcom/qcom.h
index 8eb476d7c282..c127d8f50f0f 100644
--- a/drivers/net/phy/qcom/qcom.h
+++ b/drivers/net/phy/qcom/qcom.h
@@ -1,5 +1,63 @@
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
+#define AT803X_LOC_MAC_ADDR_0_15_OFFSET		0x804C
+#define AT803X_LOC_MAC_ADDR_16_31_OFFSET	0x804B
+#define AT803X_LOC_MAC_ADDR_32_47_OFFSET	0x804A
+
 #define AT803X_DEBUG_ADDR			0x1D
 #define AT803X_DEBUG_DATA			0x1E
 
@@ -16,6 +74,10 @@
 #define   AT803X_DEBUG_HIB_CTRL_EN_ANY_CHANGE	BIT(13)
 #define   AT803X_DEBUG_HIB_CTRL_PS_HIB_EN	BIT(15)
 
+#define AT803X_DEFAULT_DOWNSHIFT		5
+#define AT803X_MIN_DOWNSHIFT			2
+#define AT803X_MAX_DOWNSHIFT			9
+
 enum stat_access_type {
 	PHY,
 	MMD
@@ -28,7 +90,31 @@ struct at803x_hw_stat {
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
+int at803x_set_wol(struct phy_device *phydev,
+		   struct ethtool_wolinfo *wol);
+void at803x_get_wol(struct phy_device *phydev,
+		    struct ethtool_wolinfo *wol);
+int at803x_ack_interrupt(struct phy_device *phydev);
+int at803x_config_intr(struct phy_device *phydev);
+irqreturn_t at803x_handle_interrupt(struct phy_device *phydev);
+int at803x_read_specific_status(struct phy_device *phydev,
+				struct at803x_ss_mask ss_mask);
+int at803x_config_mdix(struct phy_device *phydev, u8 ctrl);
+int at803x_prepare_config_aneg(struct phy_device *phydev);
+int at803x_get_tunable(struct phy_device *phydev,
+		       struct ethtool_tunable *tuna, void *data);
+int at803x_set_tunable(struct phy_device *phydev,
+		       struct ethtool_tunable *tuna, const void *data);
+int at803x_cdt_fault_length(int dt);
+int at803x_cdt_start(struct phy_device *phydev, u32 cdt_start);
+int at803x_cdt_wait_for_completion(struct phy_device *phydev,
+				   u32 cdt_en);
-- 
2.43.0


