Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE947EEFC6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345793AbjKQKJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345739AbjKQKI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:08:57 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB707C1;
        Fri, 17 Nov 2023 02:08:53 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5482df11e73so924953a12.0;
        Fri, 17 Nov 2023 02:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700215732; x=1700820532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkMOHJc0OcMmrqNaANsP5Qp8DkKGD0Xp7KJHYY+XOZs=;
        b=XvzdDW0sRMHzXueMg0eHjspxUcFzEJPGrHvxFTPcCasCjCcwPKB4Xgj/nPOBwq/8/P
         UHjLaIjpjNb39l8SwcTyK+qtUnMTQrtkcYAVz+YN9X9eqkEvLexIwsEkAvJEdDYDNOxz
         KWZWYsY10Uap3jwrR0FuJUAkGeCtjvVCT/qdQOXzhGP3xYb7wuWm648ouE3gI2TvhGQl
         0vzXyvV+bp7ilkFbKdr4Dddls+tCZ5rbOX5E5W7u3hkMeSs9fRvmIqjw6fF0ruDMg9yL
         0VmThdy849m738EKnwmWsjsC/pVVAHZ/y+4rXD3PqYqyxbYazE9gH5+D4EwJMzsvqwgl
         nqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700215732; x=1700820532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkMOHJc0OcMmrqNaANsP5Qp8DkKGD0Xp7KJHYY+XOZs=;
        b=F+fB3Uo9/fjW0pKoJH7bNd6WOWO6dfq8vl6OwfQoX1dQ3irsro2eWopUS1KLMCFqAC
         /1CxrJMXa+fxkZkIj08Um7YTg8W49O/I0fIVoGwQDhSq0/x/7m6QpH++MAJU/54p0Xuo
         1ptq4LR2U/B7WOPcgy02icbVdBthF6FVjK0WM6Zfl0EDeWUuZluOsAKj19wY/A2c8ljT
         4DoUYLa781tD873KtJxlZ2pCtxByajMxMLK8OQEwTc9mq3+x2zizvp5X5sFc1RXVXq2N
         PlFGa08pGOnxDCxJKX+DD/SGm7fVgw2i0vbNucb4BdxaiKMN5MLC+LAZDexHu40PjCNY
         3Lsg==
X-Gm-Message-State: AOJu0Yyd9ZdlUQ6Gt/n0srRd2JLuLgGohfS39M1Oa2XAY7DAKMmVOgu0
        x/GKDHUFziVLA94cHLLqmp4=
X-Google-Smtp-Source: AGHT+IEXFgmjWud9XyeYKnvw0NYmjgEYy4RVIYs041mCHThwIfWZcP4Z8jQlyhW9ixt9GcFYE18bBg==
X-Received: by 2002:a50:ff10:0:b0:53d:a7d9:5149 with SMTP id a16-20020a50ff10000000b0053da7d95149mr10863567edu.6.1700215732251;
        Fri, 17 Nov 2023 02:08:52 -0800 (PST)
Received: from fedora.. (dh207-97-146.xnet.hr. [88.207.97.146])
        by smtp.googlemail.com with ESMTPSA id n26-20020a056402061a00b0054358525a5bsm554368edv.62.2023.11.17.02.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 02:08:51 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ansuelsmth@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/2] net: phy: aquantia: enable USXGMII autoneg on AQR107
Date:   Fri, 17 Nov 2023 11:05:05 +0100
Message-ID: <20231117100848.424372-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117100848.424372-1-robimarko@gmail.com>
References: <20231117100848.424372-1-robimarko@gmail.com>
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

