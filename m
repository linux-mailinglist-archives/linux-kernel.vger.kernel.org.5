Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C3E7F96A8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 00:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjKZXwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 18:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjKZXvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 18:51:53 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFB3113;
        Sun, 26 Nov 2023 15:51:59 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b34563987so20146135e9.1;
        Sun, 26 Nov 2023 15:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701042718; x=1701647518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igZnYyFKrMpXiYvtb+6rWbbtYfx7FdvfY2mFz0zvQMQ=;
        b=aqNDAG4dR+GOEi6nxXyLmhVH+JQKjdL31f+4gCCI/I8HAE5FfJhcTljaqWBuaEts9e
         lCntGbQXiibkWsx/dISe8kjUsfU89QEw42HuS+2mCJdE4o+CME1xsSPoSINn3uUScnFP
         fmKYzB2giv3lsHUp81zlrbvpqPLfBQ013c08k0JtTj3l3Yh7Ad8gUn9oBPDW111JLaxD
         oUKK0xQIRFbUxKRlJND6ieVMnbCbISHd7VY6cVb4nZQXoXYWjZcrbX5BMVyYAdvUwjKc
         QreSiotRrpiOZUTCNIbIfzu1w7YgTafZ42aq5QD/5eBMMK37PbSXcpD8qGNUF36JWFRb
         8V5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701042718; x=1701647518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igZnYyFKrMpXiYvtb+6rWbbtYfx7FdvfY2mFz0zvQMQ=;
        b=Jd2TTs10QBI/kjzUJkWieKEW/lznS4ytJ/5FlIo2TrKp4yxdtlBL5+kb81i/bUcCvU
         xv22rRwQYT9yj0IZdPc/tiNy8+xbRZ6X0ymWfwBNmJwibVG+VusBsf+v/ORAvo+MKFBD
         N8+1GtWggmadYdlwWb1gcYL7ucnOVrZVKotjJBb5CN08X9P7+pQ997dedZ+YdxQL5p2V
         zHKHFusqZy3IKCWaiNfYGplY4D+2IOVrovbNot1zZIPcOYLYdt9TsNS79Q8YQbrcA2/h
         Qq/jhSe8Y7yjFmBWOa9lyp/lcGotquXAPMlgfi5iaqfYg5eIFfurHaXwnkF5gJ7fS+p7
         NacA==
X-Gm-Message-State: AOJu0Yyr5emJO39qenHBwDAJaCAy0UhMaMfqcK0wVv1noDmnhUlPWsdR
        OS3c7ni8a3U4oxiv5FD1mEM=
X-Google-Smtp-Source: AGHT+IGD6L6HK5CRxztosRedXkEPAJPvYZxo5tQWQ68zrG+TnQAE5/fkLrmeChD84JeEw7FrVx4/dg==
X-Received: by 2002:a05:600c:4746:b0:405:784a:d53e with SMTP id w6-20020a05600c474600b00405784ad53emr6744788wmo.20.1701042717734;
        Sun, 26 Nov 2023 15:51:57 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id m4-20020a05600c4f4400b0040b3dbb5c93sm1202151wmq.1.2023.11.26.15.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 15:51:57 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [net-next PATCH v2 4/4] net: phy: add support for PHY package MMD read/write
Date:   Mon, 27 Nov 2023 00:51:41 +0100
Message-Id: <20231126235141.17996-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231126235141.17996-1-ansuelsmth@gmail.com>
References: <20231126235141.17996-1-ansuelsmth@gmail.com>
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

Some PHY in PHY package may require to read/write MMD regs to correctly
configure the PHY package.

Add support for these additional required function in both lock and no
lock variant.

It's possible to set is_c45 bool for phy_package_read/write to true to
access mmd regs for accessing C45 PHY in PHY package for global
configuration.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Rework to use newly introduced helper
- Add common check for regnum and devad

 include/linux/phy.h | 78 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 96f6f34be051..3e507bd2c3b4 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2085,6 +2085,84 @@ static inline int __phy_package_write(struct phy_device *phydev,
 	return __mdiobus_write(phydev->mdio.bus, addr, regnum, val);
 }
 
+static inline int phy_package_read_mmd(struct phy_device *phydev,
+				       unsigned int addr_offset, bool is_c45,
+				       int devad, u32 regnum)
+{
+	struct phy_package_shared *shared = phydev->shared;
+	int addr = shared->base_addr + addr_offset;
+	int val;
+
+	if (addr >= PHY_MAX_ADDR)
+		return -EIO;
+
+	if (regnum > (u16)~0 || devad > 32)
+		return -EINVAL;
+
+	phy_lock_mdio_bus(phydev);
+	val = mmd_phy_read(phydev->mdio.bus, addr, is_c45, devad,
+			   regnum);
+	phy_unlock_mdio_bus(phydev);
+
+	return val;
+}
+
+static inline int __phy_package_read_mmd(struct phy_device *phydev,
+					 unsigned int addr_offset, bool is_c45,
+					 int devad, u32 regnum)
+{
+	struct phy_package_shared *shared = phydev->shared;
+	int addr = shared->base_addr + addr_offset;
+
+	if (addr >= PHY_MAX_ADDR)
+		return -EIO;
+
+	if (regnum > (u16)~0 || devad > 32)
+		return -EINVAL;
+
+	return mmd_phy_read(phydev->mdio.bus, addr, is_c45, devad,
+			    regnum);
+}
+
+static inline int phy_package_write_mmd(struct phy_device *phydev,
+					unsigned int addr_offset, bool is_c45,
+					int devad, u32 regnum, u16 val)
+{
+	struct phy_package_shared *shared = phydev->shared;
+	int addr = shared->base_addr + addr_offset;
+	int ret;
+
+	if (addr >= PHY_MAX_ADDR)
+		return -EIO;
+
+	if (regnum > (u16)~0 || devad > 32)
+		return -EINVAL;
+
+	phy_lock_mdio_bus(phydev);
+	ret = mmd_phy_write(phydev->mdio.bus, addr, is_c45, devad,
+			    regnum, val);
+	phy_unlock_mdio_bus(phydev);
+
+	return ret;
+}
+
+static inline int __phy_package_write_mmd(struct phy_device *phydev,
+					  unsigned int addr_offset, bool is_c45,
+					  int devad, u32 regnum, u16 val)
+{
+	struct phy_package_shared *shared = phydev->shared;
+	int addr = shared->base_addr + addr_offset;
+
+	if (addr >= PHY_MAX_ADDR)
+		return -EIO;
+
+	if (regnum > (u16)~0 || devad > 32)
+		return -EINVAL;
+
+	return mmd_phy_write(phydev->mdio.bus, addr, is_c45, devad,
+			     regnum, val);
+}
+
 static inline bool __phy_package_set_once(struct phy_device *phydev,
 					  unsigned int b)
 {
-- 
2.40.1

