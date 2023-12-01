Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9159800006
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377428AbjLAAOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377405AbjLAAOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:14:48 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B0710E2;
        Thu, 30 Nov 2023 16:14:54 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b472f98b1so13895985e9.3;
        Thu, 30 Nov 2023 16:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701389693; x=1701994493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CMZETdDgYu5hG2aMQ54/zJsbch0uzjPkjbZMzkqZ7k=;
        b=XIinhrnjz7dWzJYuskefNNY5GyQyoSmQxBU8bXbcRKp9X2onzoFcGebpwI9MVq2sp3
         Pnp0IVoddaQdW5BhKZDZEuryVM2jHaRof0l9thRylgrNnVayUwOdycP4NHYr1ZvE3Yc7
         qUoauW+El07A3VzupbgTmhK51DQewIKzSnV7Fqk5nz4pEo0FxOdeSKEObz+MAEty/1iS
         t35cY2+mASKotbARy/QxzNtlVMe0Pt3PlHx5UPCEka701M5F0ziuNip8atDHP2LOrSo4
         rG0tWguo+WJsB/KMH97v+KgDzwo0nd2P8VSDUTB6+kmSG5G0wYuJPfVazU3uc8vAGtr8
         uuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701389693; x=1701994493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CMZETdDgYu5hG2aMQ54/zJsbch0uzjPkjbZMzkqZ7k=;
        b=ItFmUJfr3sCZMDZLAz8ZnPVNDPwQ2YKTpksY/R1Q9q+jO2OTglxZTUq9OEa1CN31K5
         zXJ03M2wWAFqsR0UCbEkZ8OBx4CMwFvDtQC0c2Rtu2BoREBYBnuMDzhV8PbqiOTAey6w
         CiF33zLmqZSud/acBY9ldcFEeP9aJ7ncnsMrKlDYJ3ROX6O9rmWpnGNGgYM141LAVjFC
         ygFOmdAx8rwJCgnrQFnWOaJEO7zUoDtGftCohP4lECbjVhGToi+0NZvZhK11GJtVMpN7
         nQ2qKiJUWIHHTx+IubEkFm1BGMi/wTsb/Sl/8nCogz8SrUCt3BrUhwK+D9uwg8VwN3vj
         Qo9Q==
X-Gm-Message-State: AOJu0YxVNUtxSVVG2pqFuE/KT/Okdu+tS5V1D41LkpBNi7rseQo/cvJ7
        2xG4C/gwJrydUzEyVF5HkwQ=
X-Google-Smtp-Source: AGHT+IEuBzLU+KdC/JG7LCoXIkdGiA9P98BRz0a/w3LpbtIGeM9ybcp/SpfrKoh3MffP+oCLvxIVTw==
X-Received: by 2002:a7b:c8d5:0:b0:40b:5e59:ea1c with SMTP id f21-20020a7bc8d5000000b0040b5e59ea1cmr92057wml.187.1701389692734;
        Thu, 30 Nov 2023 16:14:52 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id g16-20020a05600c4ed000b0040b47c53610sm3535457wmq.14.2023.11.30.16.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 16:14:52 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v2 04/12] net: phy: at803x: move qca83xx specific check in dedicated functions
Date:   Fri,  1 Dec 2023 01:14:14 +0100
Message-Id: <20231201001423.20989-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231201001423.20989-1-ansuelsmth@gmail.com>
References: <20231201001423.20989-1-ansuelsmth@gmail.com>
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

Rework qca83xx specific check to dedicated function to tidy things up
and drop useless phy_id check.

Also drop an useless link_change_notify for QCA8337 as it did nothing an
returned early.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/at803x.c | 68 ++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index b1ea52ba3f07..779e0835fa5d 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -1625,27 +1625,26 @@ static int qca83xx_config_init(struct phy_device *phydev)
 		break;
 	}
 
+	/* Following original QCA sourcecode set port to prefer master */
+	phy_set_bits(phydev, MII_CTRL1000, CTL1000_PREFER_MASTER);
+
+	return 0;
+}
+
+static int qca8327_config_init(struct phy_device *phydev)
+{
 	/* QCA8327 require DAC amplitude adjustment for 100m set to +6%.
 	 * Disable on init and enable only with 100m speed following
 	 * qca original source code.
 	 */
-	if (phydev->drv->phy_id == QCA8327_A_PHY_ID ||
-	    phydev->drv->phy_id == QCA8327_B_PHY_ID)
-		at803x_debug_reg_mask(phydev, AT803X_DEBUG_ANALOG_TEST_CTRL,
-				      QCA8327_DEBUG_MANU_CTRL_EN, 0);
+	at803x_debug_reg_mask(phydev, AT803X_DEBUG_ANALOG_TEST_CTRL,
+			      QCA8327_DEBUG_MANU_CTRL_EN, 0);
 
-	/* Following original QCA sourcecode set port to prefer master */
-	phy_set_bits(phydev, MII_CTRL1000, CTL1000_PREFER_MASTER);
-
-	return 0;
+	return qca83xx_config_init(phydev);
 }
 
 static void qca83xx_link_change_notify(struct phy_device *phydev)
 {
-	/* QCA8337 doesn't require DAC Amplitude adjustement */
-	if (phydev->drv->phy_id == QCA8337_PHY_ID)
-		return;
-
 	/* Set DAC Amplitude adjustment to +6% for 100m on link running */
 	if (phydev->state == PHY_RUNNING) {
 		if (phydev->speed == SPEED_100)
@@ -1688,19 +1687,6 @@ static int qca83xx_resume(struct phy_device *phydev)
 
 static int qca83xx_suspend(struct phy_device *phydev)
 {
-	u16 mask = 0;
-
-	/* Only QCA8337 support actual suspend.
-	 * QCA8327 cause port unreliability when phy suspend
-	 * is set.
-	 */
-	if (phydev->drv->phy_id == QCA8337_PHY_ID) {
-		genphy_suspend(phydev);
-	} else {
-		mask |= ~(BMCR_SPEED1000 | BMCR_FULLDPLX);
-		phy_modify(phydev, MII_BMCR, mask, 0);
-	}
-
 	at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_GREEN,
 			      AT803X_DEBUG_GATE_CLK_IN1000, 0);
 
@@ -1711,6 +1697,27 @@ static int qca83xx_suspend(struct phy_device *phydev)
 	return 0;
 }
 
+static int qca8337_suspend(struct phy_device *phydev)
+{
+	/* Only QCA8337 support actual suspend. */
+	genphy_suspend(phydev);
+
+	return qca83xx_suspend(phydev);
+}
+
+static int qca8327_suspend(struct phy_device *phydev)
+{
+	u16 mask = 0;
+
+	/* QCA8327 cause port unreliability when phy suspend
+	 * is set.
+	 */
+	mask |= ~(BMCR_SPEED1000 | BMCR_FULLDPLX);
+	phy_modify(phydev, MII_BMCR, mask, 0);
+
+	return qca83xx_suspend(phydev);
+}
+
 static int qca808x_phy_fast_retrain_config(struct phy_device *phydev)
 {
 	int ret;
@@ -2172,7 +2179,6 @@ static struct phy_driver at803x_driver[] = {
 	.phy_id_mask		= QCA8K_PHY_ID_MASK,
 	.name			= "Qualcomm Atheros 8337 internal PHY",
 	/* PHY_GBIT_FEATURES */
-	.link_change_notify	= qca83xx_link_change_notify,
 	.probe			= at803x_probe,
 	.flags			= PHY_IS_INTERNAL,
 	.config_init		= qca83xx_config_init,
@@ -2180,7 +2186,7 @@ static struct phy_driver at803x_driver[] = {
 	.get_sset_count		= qca83xx_get_sset_count,
 	.get_strings		= qca83xx_get_strings,
 	.get_stats		= qca83xx_get_stats,
-	.suspend		= qca83xx_suspend,
+	.suspend		= qca8337_suspend,
 	.resume			= qca83xx_resume,
 }, {
 	/* QCA8327-A from switch QCA8327-AL1A */
@@ -2191,12 +2197,12 @@ static struct phy_driver at803x_driver[] = {
 	.link_change_notify	= qca83xx_link_change_notify,
 	.probe			= at803x_probe,
 	.flags			= PHY_IS_INTERNAL,
-	.config_init		= qca83xx_config_init,
+	.config_init		= qca8327_config_init,
 	.soft_reset		= genphy_soft_reset,
 	.get_sset_count		= qca83xx_get_sset_count,
 	.get_strings		= qca83xx_get_strings,
 	.get_stats		= qca83xx_get_stats,
-	.suspend		= qca83xx_suspend,
+	.suspend		= qca8327_suspend,
 	.resume			= qca83xx_resume,
 }, {
 	/* QCA8327-B from switch QCA8327-BL1A */
@@ -2207,12 +2213,12 @@ static struct phy_driver at803x_driver[] = {
 	.link_change_notify	= qca83xx_link_change_notify,
 	.probe			= at803x_probe,
 	.flags			= PHY_IS_INTERNAL,
-	.config_init		= qca83xx_config_init,
+	.config_init		= qca8327_config_init,
 	.soft_reset		= genphy_soft_reset,
 	.get_sset_count		= qca83xx_get_sset_count,
 	.get_strings		= qca83xx_get_strings,
 	.get_stats		= qca83xx_get_stats,
-	.suspend		= qca83xx_suspend,
+	.suspend		= qca8327_suspend,
 	.resume			= qca83xx_resume,
 }, {
 	/* Qualcomm QCA8081 */
-- 
2.40.1

