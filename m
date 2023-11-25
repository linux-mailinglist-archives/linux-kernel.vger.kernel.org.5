Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAAD7F8740
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 01:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjKYAfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 19:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjKYAf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 19:35:27 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA7D1BC1;
        Fri, 24 Nov 2023 16:35:29 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b27726369so17263385e9.0;
        Fri, 24 Nov 2023 16:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700872528; x=1701477328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7OVOcGHUcPnU+8BUU2tjf4Y7gvtOJAy7pXlV7RvF1I=;
        b=LUsvjnkmu78VqrV5G5vv9wqZBp8i1oOkR0zd9XjcmO5PsWVzK7n7NPb8D8DR+D2X4T
         yv7Oz6LjoyFYxkS9N5uNJVu9Xft6tUsvxZzXNouB2T1Sr8d2ee+H9o6V75HitxYj8a0a
         T17LOHwQjGrQr3qF1jSUzlpyahaYDg7ephknuyK/lUmo10jcGhSW6CzyPMb4xugsRk8d
         x3AawqgqbsBzghjTrwpAUDRargf5vq3xf1b3IoelqOSbty8ulh8VHNZPy1OEH2YXC4BE
         Jm3MoJfZOlFIMJUBT7LcMjSj3lFjurcC2Y2jCHCHbQkrWejcBi2jinrRVsiOfk/Z9XWI
         CVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700872528; x=1701477328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7OVOcGHUcPnU+8BUU2tjf4Y7gvtOJAy7pXlV7RvF1I=;
        b=gao/7ZSK7eP7zMjoJOt9sjkuhFeS/IQDjibomW3v/uai1bHqaFbxcjVpSSTRP+/ii+
         qWUMMqZBpu6Zk+BpquZNB4nF+zAH1xX1JB6Ytupq6SL8G/s+DILxirKFpsC5SIdxytXr
         aW4vso4QJw+yPJGJ+m0fRp6FoZOgy+4Imkw9DuEGsklr0a4DjQwwHCV0VWVQaW4vf2Gz
         2rcQB07wSNCDGnYCfJeAb/zAljZvVmBuCT1iK4t2EPJWLMsNmW/ta5GjCBjamulPsSvm
         CSwcq5Q7zJ0mv8ZRiRWO2b2mxG0ZRnW14eMUYA0j9VVVfwPp+RpN/46ehc/EkgF3TRWu
         jVCQ==
X-Gm-Message-State: AOJu0YyMhsPemQH4PRjJFyU0nyb0JB4JZe8a0WL8dx/ioUWHYjukmH8I
        AeE5ICoAPH0b2aWq9HwlaCk=
X-Google-Smtp-Source: AGHT+IGcE1dOF2/4XmII3D8k9pAOirkX3JthCM23UGSAVeigejq1ME7yX5mhXBajq2F60t3CrBZvGg==
X-Received: by 2002:a05:600c:3b16:b0:3fe:ba7:f200 with SMTP id m22-20020a05600c3b1600b003fe0ba7f200mr3564351wms.20.1700872527977;
        Fri, 24 Nov 2023 16:35:27 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id u13-20020a05600c00cd00b00405718cbeadsm4268005wmm.1.2023.11.24.16.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 16:35:27 -0800 (PST)
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
        Vladimir Oltean <olteanv@gmail.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [net-next RFC PATCH v2 07/11] net: phy: add support for PHY package MMD read/write
Date:   Sat, 25 Nov 2023 01:11:23 +0100
Message-Id: <20231125001127.5674-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231125001127.5674-1-ansuelsmth@gmail.com>
References: <20231125001127.5674-1-ansuelsmth@gmail.com>
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

Some PHY in PHY package may require to read/write MMD regs to correctly
configure the PHY package.

Add support for these additional required function in both lock and no
lock variant.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/linux/phy.h | 72 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 0f3b21c90583..4c5856d9865d 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2104,6 +2104,78 @@ static inline int __phy_package_write(struct phy_device *phydev,
 	return __mdiobus_write(phydev->mdio.bus, addr, regnum, val);
 }
 
+static inline int phy_package_read_mmd(struct phy_device *phydev,
+				       int global_phy_index, int devad, u32 regnum)
+{
+	struct phy_package_shared *shared = phydev->shared;
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr, val;
+
+	if (!shared || global_phy_index > shared->addrs_num - 1)
+		return -EIO;
+
+	addr = shared->addrs[global_phy_index];
+
+	phy_lock_mdio_bus(phydev);
+	mmd_phy_indirect(bus, addr, devad, regnum);
+	val = __mdiobus_read(bus, addr, MII_MMD_DATA);
+	phy_unlock_mdio_bus(phydev);
+
+	return val;
+}
+
+static inline int __phy_package_read_mmd(struct phy_device *phydev,
+					 int global_phy_index, int devad, u32 regnum)
+{
+	struct phy_package_shared *shared = phydev->shared;
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr;
+
+	if (!shared || global_phy_index > shared->addrs_num - 1)
+		return -EIO;
+
+	addr = shared->addrs[global_phy_index];
+	mmd_phy_indirect(bus, addr, devad, regnum);
+	return __mdiobus_read(bus, addr, MII_MMD_DATA);
+}
+
+static inline int phy_package_write_mmd(struct phy_device *phydev,
+					int global_phy_index, int devad,
+					u32 regnum, u16 val)
+{
+	struct phy_package_shared *shared = phydev->shared;
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr, ret;
+
+	if (!shared || global_phy_index > shared->addrs_num - 1)
+		return -EIO;
+
+	addr = shared->addrs[global_phy_index];
+
+	phy_lock_mdio_bus(phydev);
+	mmd_phy_indirect(bus, addr, devad, regnum);
+	ret = __mdiobus_write(bus, addr, MII_MMD_DATA, val);
+	phy_unlock_mdio_bus(phydev);
+
+	return ret;
+}
+
+static inline int __phy_package_write_mmd(struct phy_device *phydev,
+					  int global_phy_index, int devad,
+					  u32 regnum, u16 val)
+{
+	struct phy_package_shared *shared = phydev->shared;
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr;
+
+	if (!shared || global_phy_index > shared->addrs_num - 1)
+		return -EIO;
+
+	addr = shared->addrs[global_phy_index];
+	mmd_phy_indirect(bus, addr, devad, regnum);
+	return __mdiobus_write(bus, addr, MII_MMD_DATA, val);
+}
+
 static inline bool __phy_package_set_once(struct phy_device *phydev,
 					  unsigned int b)
 {
-- 
2.40.1

