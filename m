Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579A4800010
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377448AbjLAAPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377416AbjLAAPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:15:02 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFCE1713;
        Thu, 30 Nov 2023 16:14:58 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b474c925bso11565075e9.3;
        Thu, 30 Nov 2023 16:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701389697; x=1701994497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lg7qa9kgNv3JPVirMlKzkE9ZBdZKAWAeOTAv7Yn8WPU=;
        b=GovzP+pz0W2rx7ANrQQ4VMX3XgKrw74AF64oBej8McdvMoNfjfXa8xIXyVZVYZgsm6
         98QjPBaLEykVUKjZzgdlgOlTQ+4ut1jttbgxySpbLtuEGc6E32XolJUQoV/B5p4t6zVc
         lk/J251gNAJgGxSC1j0aSqxWwhur7qzEe4LiZt1iqwwlh2BESzHsxPoQpaNh7YfPSHA4
         MGFSoVJLSFIrqvZmz3eTeWjJT7c5F2kvMRwYeUV/I9ZZjhGFmtOfc/Whb2r+vD2XCqWz
         mVbI1qkCvqVLOjDDbUZ7ltiOakOClAryd8vRxCTBPIaDCccLTpRXtkuE17teFAwaNO9P
         V/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701389697; x=1701994497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lg7qa9kgNv3JPVirMlKzkE9ZBdZKAWAeOTAv7Yn8WPU=;
        b=vdj+zSUNBvsGOLEuR9bfKwl3mX1T1vmxJa/aMZq18FfvztuGWnwmBQiOKcnPW6/s+j
         cTuE2oCPwEkxZLoAn9f4jLrGNZjjj29761/kioNu6do5KTwp63rdhmMrCLOM5V8fK1C6
         Zr9w9UJK6T5Q+AR4gaKxUeedHPmb+ZwM/qf1kFDk0LzZxFlviYd/O23bPwq7bSzS5gUt
         a7+5ilmcm0JqNVwfWshgheYArwUa41gDERxqV9NZhj1NxBgGwXOQViDlwpq1EAygH/4h
         aO9VjtYfR3E//KaJWEVbHcYR8aXpM7hsNL1lxV5l8/Mvo0Q9EpakndB1QspIceN8ZcfV
         sX2A==
X-Gm-Message-State: AOJu0Yw8Y9mctAZ9OB76fWCs1i7AumW+26rfQX5R1cWu2nI0JMuuMQqS
        NL63z3Rs8H7F6FG/qRLbC4eq8a/t2mQ=
X-Google-Smtp-Source: AGHT+IGR3shfq9xuKVy/nBdBAZ85IwEKsnWA2bvG7xK9anfcSYhiGwq/EKIp5OizPNNpfLCrpqob5Q==
X-Received: by 2002:a1c:7c0d:0:b0:40b:5e59:b7c5 with SMTP id x13-20020a1c7c0d000000b0040b5e59b7c5mr129344wmc.162.1701389696941;
        Thu, 30 Nov 2023 16:14:56 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id g16-20020a05600c4ed000b0040b47c53610sm3535457wmq.14.2023.11.30.16.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 16:14:56 -0800 (PST)
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
Subject: [net-next PATCH v2 08/12] net: phy: at803x: move specific at8031 WOL bits to dedicated function
Date:   Fri,  1 Dec 2023 01:14:18 +0100
Message-Id: <20231201001423.20989-9-ansuelsmth@gmail.com>
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

Move specific at8031 WOL enable/disable to dedicated function to make
at803x_set_wol more generic.

This is needed in preparation for PHY driver split as qca8081 share the
same function to toggle WOL settings.

In this new implementation WOL module in at8031 is enabled after the
generic interrupt is setup. This should not cause any problem as the
WOL_INT has a separate implementation and only relay on MAC bits.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 42 ++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 02ac71f98466..2de7a59c0faa 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -466,27 +466,11 @@ static int at803x_set_wol(struct phy_device *phydev,
 			phy_write_mmd(phydev, MDIO_MMD_PCS, offsets[i],
 				      mac[(i * 2) + 1] | (mac[(i * 2)] << 8));
 
-		/* Enable WOL function for 1588 */
-		if (phydev->drv->phy_id == ATH8031_PHY_ID) {
-			ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
-					     AT803X_PHY_MMD3_WOL_CTRL,
-					     0, AT803X_WOL_EN);
-			if (ret)
-				return ret;
-		}
 		/* Enable WOL interrupt */
 		ret = phy_modify(phydev, AT803X_INTR_ENABLE, 0, AT803X_INTR_ENABLE_WOL);
 		if (ret)
 			return ret;
 	} else {
-		/* Disable WoL function for 1588 */
-		if (phydev->drv->phy_id == ATH8031_PHY_ID) {
-			ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
-					     AT803X_PHY_MMD3_WOL_CTRL,
-					     AT803X_WOL_EN, 0);
-			if (ret)
-				return ret;
-		}
 		/* Disable WOL interrupt */
 		ret = phy_modify(phydev, AT803X_INTR_ENABLE, AT803X_INTR_ENABLE_WOL, 0);
 		if (ret)
@@ -1611,6 +1595,30 @@ static int at8031_config_init(struct phy_device *phydev)
 	return at803x_config_init(phydev);
 }
 
+static int at8031_set_wol(struct phy_device *phydev,
+			  struct ethtool_wolinfo *wol)
+{
+	int ret;
+
+	/* First setup MAC address and enable WOL interrupt */
+	ret = at803x_set_wol(phydev, wol);
+	if (ret)
+		return ret;
+
+	if (wol->wolopts & WAKE_MAGIC)
+		/* Enable WOL function for 1588 */
+		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
+				     AT803X_PHY_MMD3_WOL_CTRL,
+				     0, AT803X_WOL_EN);
+	else
+		/* Disable WoL function for 1588 */
+		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
+				     AT803X_PHY_MMD3_WOL_CTRL,
+				     AT803X_WOL_EN, 0);
+
+	return ret;
+}
+
 static int qca83xx_config_init(struct phy_device *phydev)
 {
 	u8 switch_revision;
@@ -2123,7 +2131,7 @@ static struct phy_driver at803x_driver[] = {
 	.config_init		= at8031_config_init,
 	.config_aneg		= at803x_config_aneg,
 	.soft_reset		= genphy_soft_reset,
-	.set_wol		= at803x_set_wol,
+	.set_wol		= at8031_set_wol,
 	.get_wol		= at803x_get_wol,
 	.suspend		= at803x_suspend,
 	.resume			= at803x_resume,
-- 
2.40.1

