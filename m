Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533B27EEFCB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345800AbjKQKKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345734AbjKQKKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:10:08 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB707C4;
        Fri, 17 Nov 2023 02:10:04 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9df8d0c2505so344637666b.0;
        Fri, 17 Nov 2023 02:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700215803; x=1700820603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkMOHJc0OcMmrqNaANsP5Qp8DkKGD0Xp7KJHYY+XOZs=;
        b=BUtaIKXtDID03EDI65cRNTd4bjOZO08xakCsZ5hPpjrE7k9VQb/5otwjiGgrk+DTb3
         KYsURxs7e6doawx3klGqIVRBUrfuLXxyRTP+lSSODXR97Q2JFOGvn9i+G40AjtL/x0VC
         YC0Jdf2pJ/JvT8x6SDP2jxsgmz6fkGpGssccKnZiZRpgok3bUnwThmqSyQapuM7afRba
         FUldef5oMfsRcijPydxQuTjZkHn+SNk+XYW6sp6XJW+h3xJsC3o/esZ5H+FvjCIp6PQW
         H0BH3pv+F3q7rqDZocLJO9OpmlxbJTTMEyOmrnwNETkCyUv6xMImhxTDZMdQZNpMiXmO
         mNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700215803; x=1700820603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkMOHJc0OcMmrqNaANsP5Qp8DkKGD0Xp7KJHYY+XOZs=;
        b=fgWS1vBzn7CJSEuiQXqGZxr5Fqj0MWZOee+JMVp+yJqqB4phFJ2ftdWlFHLIyelC3E
         iCO4gyhrJHDOZgG/ejJYHiTnYEbDazMgPLMPZc3yfbAR8PUFpGJZ5BmYwhV4oxuMQDw4
         xZEoPp2KbjAyKS2M0EQSjyKw7T6ok8wJul20ZB1xociGFezbgSlZZ1KRPk/Te+mTS6k+
         HKsuxQZjFcYLYH0T1gwnFy7MDXKBNoN6zULNFgG21KOgrkLPfQhtENglMx84bBnwMnGu
         wGTcF3vv9VUvYRoDhUt68bpZYJC2727U3Ui0g6BKIvDl/qtVd/lRqiKa4xFWfjQYHSfo
         6z1g==
X-Gm-Message-State: AOJu0YwnNWQcOFhgpuerPVjO+F+PmfajuPqLbNrZ0vnpZWRDB8tO6p/M
        fn7oXE1/PH2479Pu51WIlaI=
X-Google-Smtp-Source: AGHT+IGFl1KnB4AxZBJI3CYh9611cwLe5zHHRJSF8ohVLd8UH2H4mYNf8rIvVa5gztii6HcHHt8NJw==
X-Received: by 2002:a17:906:fcc2:b0:9ad:8a9e:23ee with SMTP id qx2-20020a170906fcc200b009ad8a9e23eemr4152841ejb.13.1700215803309;
        Fri, 17 Nov 2023 02:10:03 -0800 (PST)
Received: from fedora.. (dh207-97-146.xnet.hr. [88.207.97.146])
        by smtp.googlemail.com with ESMTPSA id u22-20020a17090617d600b009e5e4ff01d4sm610599eje.129.2023.11.17.02.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 02:10:02 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ansuelsmth@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH net-next 2/2] net: phy: aquantia: enable USXGMII autoneg on AQR107
Date:   Fri, 17 Nov 2023 11:09:49 +0100
Message-ID: <20231117100958.425354-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117100958.425354-1-robimarko@gmail.com>
References: <20231117100958.425354-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case USXGMII is being used as the PHY interface mode then USXGMII
autoneg must be enabled as well.

HW defaults to USXGMII autoneg being disabled which then results in
autoneg timeout, so enable it in case USXGMII is used.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 7711e052e737..c602873052a0 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -26,6 +26,9 @@
 #define PHY_ID_AQR412	0x03a1b712
 #define PHY_ID_AQR113C	0x31c31c12
 
+#define MDIO_PHYXS_XAUI_RX_VEND2		0xc441
+#define MDIO_PHYXS_XAUI_RX_VEND2_USX_AUTONEG_EN	BIT(3)
+
 #define MDIO_PHYXS_VEND_IF_STATUS		0xe812
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_MASK	GENMASK(7, 3)
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_KR	0
@@ -545,6 +548,15 @@ static int aqr107_config_init(struct phy_device *phydev)
 
 	aqr107_validate_mode(phydev, phydev->interface);
 
+	if (phydev->interface == PHY_INTERFACE_MODE_USXGMII) {
+		ret = phy_modify_mmd(phydev, MDIO_MMD_PHYXS,
+				     MDIO_PHYXS_XAUI_RX_VEND2,
+				     MDIO_PHYXS_XAUI_RX_VEND2_USX_AUTONEG_EN,
+				     MDIO_PHYXS_XAUI_RX_VEND2_USX_AUTONEG_EN);
+		if (ret)
+			return ret;
+	}
+
 	return aqr107_set_downshift(phydev, MDIO_AN_VEND_PROV_DOWNSHIFT_DFLT);
 }
 
-- 
2.42.0

