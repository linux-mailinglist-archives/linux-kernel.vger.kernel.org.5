Return-Path: <linux-kernel+bounces-70264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F39859563
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0B428234F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4523A1EA7F;
	Sun, 18 Feb 2024 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4PraJEV"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806B61D6AA;
	Sun, 18 Feb 2024 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708243099; cv=none; b=c5qHyhqP385oCTUO61mhU7/XZGETWNy6pOVKZoAFkQKg7kUK3D2+XiL6awlKZ/SGTfG8W0Z9AXHYgW721zFdRSRsJ2uY6jgB7ftuBVhhXI+Q8JBHZ1JAYA/em6k4we3/bhIOCA9ZSrGiwocR1zGYJDGKZepi/8GAqSYcE4/F99M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708243099; c=relaxed/simple;
	bh=APHd53FETp7bMcTra6Q2uekzr3ZPbBpRLKIx89mhIt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eZ/e7+Dee9zoNaHk8ZPO5x/hYjMpBOgoL5A2Nb3v1CdBB2nldtytkN73/wRa/AlxseQubBQQC1NDa1ogdkUViSZQoXbPdc7zEv5mSJ0tdC5DC4hkcs5UTwmHOIK/oUZcTKKUugz3IpvYg+bagoPqjn/fNvp1ySwkJHZ7ONoZuxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4PraJEV; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3e891b5e4eso464166b.0;
        Sat, 17 Feb 2024 23:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708243096; x=1708847896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOctRdMaVKvlxxQLiZyj1BX0A6EczB9hIAIpTNelg5c=;
        b=M4PraJEVWQgyuWlkuy1OQoDmH3owV1mSElK3KLwNNgpUi0HruzXUJpZQb91MhyBQUY
         bRFUIVSFZvUTZFAY0yKXDD4oZuZNfdSiPJKUA5731AVeXEEIst7e08yPA2Bi0UjShUfX
         XOaBjNgwJ0+vtKw3cLB00CNLY8LslWsWiB9CoHZD/VIptdqEr3mzcXQXzrSSsbMPVxih
         itsz5Mfnztw9xIgAnFvqB6kmEpcO2wWXizRS0Y2w90khYwVqAkHqFQFZEwFAgsIkQMD1
         xStmL4xbZZdJoBIvSz4zocxmOSgE1c06uP0d8srNsbLIWLjBeLuooFcxzc2FfTrB+Va+
         RGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708243096; x=1708847896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOctRdMaVKvlxxQLiZyj1BX0A6EczB9hIAIpTNelg5c=;
        b=EGq4MCzQb7lcHUpnBl1kby/h89V9KOkGNzZ52DvuBUEbWPtplgXDyWwyHKLWWrR0pl
         7PviYcXQWHkLd4pY6nwUifCfXXXgRe2VkAq7aihxb4dXMi11hBKFbm4bGCtrg5i+EHom
         /dSPsmaq/4gk2yjTFrxx4E0DP550e+s7594HrYVyOkezhJPa245LPPuqjAcDhmttv2Tt
         jDiOxWinI+cxufM+OqJvALV8PZpg4WA1eoMord55vkujkL68jwB77lJYW6oryCnY+Xoe
         YxKz0+V/JO48OZVl3jTgiu+/yI81zXXsST3nKtlgex4H0dwd/JpwFdYoGa4+eMWJUhtm
         /6jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD1kEHi8bHkJSRv3RxKtdH3IXqxa7FjkqNpb0Lyr1j70n2Mwyl6mrqrClCn8mTeJobRZtlDABLSRnuDPAW2Jl6U8A/p4Qi3vwmrTusarO8td9J0ITuP4EugEj4jggjKapLZbqc
X-Gm-Message-State: AOJu0YwSS/c/Ij3RMZoEJUNFvC7YAu17S6DH4lKlcTmH5r1Gnd8B5dpN
	oKlMLV5QfyzohlmkOu7KmnQmN4798UqdmGWWIHGWX69VMWwrcm+X
X-Google-Smtp-Source: AGHT+IEis5Td4gJlGqzyMPzrBgl03RLfsaeHUTC7vGBI5Adt7nStq6043pikjkxr9EssV3LXjPxuYg==
X-Received: by 2002:a17:906:af0f:b0:a3d:dfa:7a92 with SMTP id lx15-20020a170906af0f00b00a3d0dfa7a92mr6592739ejb.36.1708243095819;
        Sat, 17 Feb 2024 23:58:15 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id jj12-20020a170907984c00b00a3e64bcd2c1sm458732ejc.142.2024.02.17.23.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 23:58:15 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 net-next 06/14] net: phy: marvell-88q2xxx: add interrupt support for link detection
Date: Sun, 18 Feb 2024 08:57:43 +0100
Message-Id: <20240218075753.18067-7-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240218075753.18067-1-dima.fedrau@gmail.com>
References: <20240218075753.18067-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added .config_intr and .handle_interrupt callbacks. Whenever the link
goes up or down an interrupt will be triggered. Interrupts are configured
separately for 100/1000BASET1.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 123 +++++++++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 9829facde253..7c7517af346b 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -24,6 +24,19 @@
 #define MDIO_MMD_AN_MV_STAT2_100BT1		0x2000
 #define MDIO_MMD_AN_MV_STAT2_1000BT1		0x4000
 
+#define MDIO_MMD_PCS_MV_INT_EN			32784
+#define MDIO_MMD_PCS_MV_INT_EN_LINK_UP		0x0040
+#define MDIO_MMD_PCS_MV_INT_EN_LINK_DOWN	0x0080
+#define MDIO_MMD_PCS_MV_INT_EN_100BT1		0x1000
+
+#define MDIO_MMD_PCS_MV_GPIO_INT_STAT			32785
+#define MDIO_MMD_PCS_MV_GPIO_INT_STAT_LINK_UP		0x0040
+#define MDIO_MMD_PCS_MV_GPIO_INT_STAT_LINK_DOWN		0x0080
+#define MDIO_MMD_PCS_MV_GPIO_INT_STAT_100BT1_GEN	0x1000
+
+#define MDIO_MMD_PCS_MV_GPIO_INT_CTRL			32787
+#define MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS		0x0800
+
 #define MDIO_MMD_PCS_MV_100BT1_STAT1			33032
 #define MDIO_MMD_PCS_MV_100BT1_STAT1_IDLE_ERROR		0x00ff
 #define MDIO_MMD_PCS_MV_100BT1_STAT1_JABBER		0x0100
@@ -38,6 +51,12 @@
 #define MDIO_MMD_PCS_MV_100BT1_STAT2_LINK	0x0004
 #define MDIO_MMD_PCS_MV_100BT1_STAT2_ANGE	0x0008
 
+#define MDIO_MMD_PCS_MV_100BT1_INT_EN			33042
+#define MDIO_MMD_PCS_MV_100BT1_INT_EN_LINKEVENT		0x0400
+
+#define MDIO_MMD_PCS_MV_COPPER_INT_STAT			33043
+#define MDIO_MMD_PCS_MV_COPPER_INT_STAT_LINKEVENT	0x0400
+
 #define MDIO_MMD_PCS_MV_RX_STAT			33328
 
 struct mmd_val {
@@ -99,13 +118,15 @@ static int mv88q2xxx_read_link_gbit(struct phy_device *phydev)
 
 	/* Read vendor specific Auto-Negotiation status register to get local
 	 * and remote receiver status according to software initialization
-	 * guide.
+	 * guide. However, when not in polling mode the local and remote
+	 * receiver status are not evaluated due to the Marvell 88Q2xxx APIs.
 	 */
 	ret = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_MMD_AN_MV_STAT);
 	if (ret < 0) {
 		return ret;
-	} else if ((ret & MDIO_MMD_AN_MV_STAT_LOCAL_RX) &&
-		   (ret & MDIO_MMD_AN_MV_STAT_REMOTE_RX)) {
+	} else if (((ret & MDIO_MMD_AN_MV_STAT_LOCAL_RX) &&
+		   (ret & MDIO_MMD_AN_MV_STAT_REMOTE_RX)) ||
+		   !phy_polling_mode(phydev)) {
 		/* The link state is latched low so that momentary link
 		 * drops can be detected. Do not double-read the status
 		 * in polling mode to detect such short link drops except
@@ -145,7 +166,18 @@ static int mv88q2xxx_read_link_100m(struct phy_device *phydev)
 	 * the link was already down. In case we are not polling,
 	 * we always read the realtime status.
 	 */
-	if (!phy_polling_mode(phydev) || !phydev->link) {
+	if (!phy_polling_mode(phydev)) {
+		phydev->link = false;
+		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
+				   MDIO_MMD_PCS_MV_100BT1_STAT2);
+		if (ret < 0)
+			return ret;
+
+		if (ret & MDIO_MMD_PCS_MV_100BT1_STAT2_LINK)
+			phydev->link = true;
+
+		return 0;
+	} else if (!phydev->link) {
 		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
 				   MDIO_MMD_PCS_MV_100BT1_STAT1);
 		if (ret < 0)
@@ -356,6 +388,79 @@ static int mv88q2xxx_get_sqi_max(struct phy_device *phydev)
 	return 15;
 }
 
+static int mv88q2xxx_config_intr(struct phy_device *phydev)
+{
+	int ret;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		/* Enable interrupts for 1000BASE-T1 link up and down events
+		 * and enable general interrupts for 100BASE-T1.
+		 */
+		ret = phy_write_mmd(phydev, MDIO_MMD_PCS,
+				    MDIO_MMD_PCS_MV_INT_EN,
+				    MDIO_MMD_PCS_MV_INT_EN_LINK_UP |
+				    MDIO_MMD_PCS_MV_INT_EN_LINK_DOWN |
+				    MDIO_MMD_PCS_MV_INT_EN_100BT1);
+		if (ret < 0)
+			return ret;
+
+		/* Enable interrupts for 100BASE-T1 link events */
+		return phy_write_mmd(phydev, MDIO_MMD_PCS,
+				     MDIO_MMD_PCS_MV_100BT1_INT_EN,
+				     MDIO_MMD_PCS_MV_100BT1_INT_EN_LINKEVENT);
+	} else {
+		ret = phy_write_mmd(phydev, MDIO_MMD_PCS,
+				    MDIO_MMD_PCS_MV_INT_EN, 0);
+		if (ret < 0)
+			return ret;
+
+		return phy_write_mmd(phydev, MDIO_MMD_PCS,
+				     MDIO_MMD_PCS_MV_100BT1_INT_EN, 0);
+	}
+}
+
+static irqreturn_t mv88q2xxx_handle_interrupt(struct phy_device *phydev)
+{
+	bool trigger_machine = false;
+	int irq;
+
+	/* Before we can acknowledge the 100BT1 general interrupt, that is in
+	 * the 1000BT1 interrupt status register, we have to acknowledge any
+	 * interrupts that are related to it. Therefore we read first the 100BT1
+	 * interrupt status register, followed by reading the 1000BT1 interrupt
+	 * status register.
+	 */
+
+	irq = phy_read_mmd(phydev, MDIO_MMD_PCS,
+			   MDIO_MMD_PCS_MV_COPPER_INT_STAT);
+	if (irq < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	/* Check link status for 100BT1 */
+	if (irq & MDIO_MMD_PCS_MV_COPPER_INT_STAT_LINKEVENT)
+		trigger_machine = true;
+
+	irq = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_GPIO_INT_STAT);
+	if (irq < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	/* Check link status for 1000BT1 */
+	if ((irq & MDIO_MMD_PCS_MV_GPIO_INT_STAT_LINK_UP) ||
+	    (irq & MDIO_MMD_PCS_MV_GPIO_INT_STAT_LINK_DOWN))
+		trigger_machine = true;
+
+	if (!trigger_machine)
+		return IRQ_NONE;
+
+	phy_trigger_machine(phydev);
+
+	return IRQ_HANDLED;
+}
+
 static int mv88q222x_soft_reset(struct phy_device *phydev)
 {
 	int ret;
@@ -422,6 +527,14 @@ static int mv88q222x_revb0_config_init(struct phy_device *phydev)
 	 */
 	phydev->pma_extable = MDIO_PMA_EXTABLE_BT1;
 
+	/* Configure interrupt with default settings, output is driven low for
+	 * active interrupt and high for inactive.
+	 */
+	if (phy_interrupt_is_valid(phydev))
+		return phy_set_bits_mmd(phydev, MDIO_MMD_PCS,
+					MDIO_MMD_PCS_MV_GPIO_INT_CTRL,
+					MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS);
+
 	return 0;
 }
 
@@ -448,6 +561,8 @@ static struct phy_driver mv88q2xxx_driver[] = {
 		.config_init		= mv88q222x_revb0_config_init,
 		.read_status		= mv88q2xxx_read_status,
 		.soft_reset		= mv88q222x_soft_reset,
+		.config_intr		= mv88q2xxx_config_intr,
+		.handle_interrupt	= mv88q2xxx_handle_interrupt,
 		.set_loopback		= genphy_c45_loopback,
 		.get_sqi		= mv88q2xxx_get_sqi,
 		.get_sqi_max		= mv88q2xxx_get_sqi_max,
-- 
2.39.2


