Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FB5807C4C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379669AbjLFX0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441820AbjLFXZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:25:59 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5597A3;
        Wed,  6 Dec 2023 15:26:03 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c09d62b70so4230125e9.1;
        Wed, 06 Dec 2023 15:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701905162; x=1702509962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8nM9qWelyRyVgavRdtFw3MAmrowMHhgp/kZSBIDqog=;
        b=PT+XEm1kc+HEl8oGYN/OKBmB5OcdX1my3T//i/nAKSqCkc/AzvUlsImMrRVFFObkQW
         3lqgeC6H2uNc+ZH5s7nc8as7eYyQcUQuuMPCGGFGAte/h7+slOuNIYsg4TxFk6dKJsmJ
         u4qOSn2hsCJAgQ9yluI+kxXtYRQH+InTlj5U4e1/o3cr74Iv0PnYlxk5b0Vlp22wcMNY
         XA3/9PSeZydNWs2l1ZSwrAr2NmGa8wyY4vXo2T2SlwjgnSvXVhy6ILCO9yQYjoE3fz0s
         EsncvUhVbU/1KACZcuyXURuHJ6Ia+umPX343e8s0D/UrCffll93PaGP8bIZ+KPV7ifgz
         37mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701905162; x=1702509962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8nM9qWelyRyVgavRdtFw3MAmrowMHhgp/kZSBIDqog=;
        b=vREjrSrCyjXqCqNt8B2c7lMjKexARKRGc8zJ8QLa6SMQuYxjRnfQxj4qYeE/BMFvoJ
         rRXcSzAEmI4IaiDEs49l9Fc51Ugekyf4Hh+gJy17HKZBnyE8khC79ak+344MJhYy4dk4
         iWmZUQd3hHYJNgA1c5hp6FpdDtULZALfdGEGY6+mY2514izGlUigjvSToYlzNUvhEseS
         m33OO9dk5iBVsE4qWlDrrorwrP9XujADWeTUdNQC7qxdFH/2ignQ76k/h5M9WebBO7Ci
         rss5KDyC+IosPkWKQTu+wMsmMvHrwS7MnSeG3pZs+WzFCPohE5j1eKNz2QN3lDhaioQ8
         UvFg==
X-Gm-Message-State: AOJu0YyVZwyvGlIItjIcBxRgu9O7LREkXfcg9tlmcKyfAANwEZtb+nt3
        C3QNl5OoiXM0G/9EWs0NL+4=
X-Google-Smtp-Source: AGHT+IGSryGfcwe2mbxn82t4MKHOIrokLTAXFZlwfzmfi5rB3Rom1wn5/b9JD+NszNdAbUiLyyn1RQ==
X-Received: by 2002:a05:600c:354e:b0:405:1bbd:aa9c with SMTP id i14-20020a05600c354e00b004051bbdaa9cmr711037wmq.34.1701905162266;
        Wed, 06 Dec 2023 15:26:02 -0800 (PST)
Received: from localhost.localdomain (host-79-26-252-6.retail.telecomitalia.it. [79.26.252.6])
        by smtp.googlemail.com with ESMTPSA id n2-20020a5d51c2000000b0033339027c89sm718754wrv.108.2023.12.06.15.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 15:26:02 -0800 (PST)
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
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next PATCH v4 3/3] net: phy: add support for PHY package MMD read/write
Date:   Thu,  7 Dec 2023 00:25:47 +0100
Message-Id: <20231206232547.2501-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231206232547.2501-1-ansuelsmth@gmail.com>
References: <20231206232547.2501-1-ansuelsmth@gmail.com>
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

It's assumed that the entire PHY package is either C22 or C45. We use
C22 or C45 way of writing/reading to mmd regs based on the passed phydev
whether it's C22 or C45.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v4:
- Drop function comments in header file
Changes v3:
- Move in phy-core.c from phy.h
- Base c45 from phydev
Changes v2:
- Rework to use newly introduced helper
- Add common check for regnum and devad

 drivers/net/phy/phy-core.c | 136 +++++++++++++++++++++++++++++++++++++
 include/linux/phy.h        |  16 +++++
 2 files changed, 152 insertions(+)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index b729ac8b2640..b5868282def1 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -650,6 +650,142 @@ int phy_write_mmd(struct phy_device *phydev, int devad, u32 regnum, u16 val)
 }
 EXPORT_SYMBOL(phy_write_mmd);
 
+/**
+ * __phy_package_read_mmd - Convenience function for reading a register
+ * on an MMD on a given PHY using the PHY package base addr, added of
+ * the addr_offset value.
+ * @phydev: The phy_device struct
+ * @addr_offset: The offset to be added to PHY package base_addr
+ * @devad: The MMD to read from
+ * @regnum: The register on the MMD to read
+ *
+ * Same rules as for __phy_read();
+ *
+ * NOTE: It's assumed that the entire PHY package is either C22 or C45.
+ */
+int __phy_package_read_mmd(struct phy_device *phydev,
+			   unsigned int addr_offset, int devad,
+			   u32 regnum)
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
+	return mmd_phy_read(phydev->mdio.bus, addr, phydev->is_c45, devad,
+			    regnum);
+}
+EXPORT_SYMBOL(__phy_package_read_mmd);
+
+/**
+ * phy_package_read_mmd - Convenience function for reading a register
+ * on an MMD on a given PHY using the PHY package base addr, added of
+ * the addr_offset value.
+ * @phydev: The phy_device struct
+ * @addr_offset: The offset to be added to PHY package base_addr
+ * @devad: The MMD to read from
+ * @regnum: The register on the MMD to read
+ *
+ * Same rules as for phy_read();
+ *
+ * NOTE: It's assumed that the entire PHY package is either C22 or C45.
+ */
+int phy_package_read_mmd(struct phy_device *phydev,
+			 unsigned int addr_offset, int devad,
+			 u32 regnum)
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
+	val = mmd_phy_read(phydev->mdio.bus, addr, phydev->is_c45, devad,
+			   regnum);
+	phy_unlock_mdio_bus(phydev);
+
+	return val;
+}
+EXPORT_SYMBOL(phy_package_read_mmd);
+
+/**
+ * __phy_package_write_mmd - Convenience function for writing a register
+ * on an MMD on a given PHY using the PHY package base addr, added of
+ * the addr_offset value.
+ * @phydev: The phy_device struct
+ * @addr_offset: The offset to be added to PHY package base_addr
+ * @devad: The MMD to read from
+ * @regnum: The register on the MMD to read
+ * @val: value to write to @regnum
+ *
+ * Same rules as for __phy_write();
+ *
+ * NOTE: It's assumed that the entire PHY package is either C22 or C45.
+ */
+int __phy_package_write_mmd(struct phy_device *phydev,
+			    unsigned int addr_offset, int devad,
+			    u32 regnum, u16 val)
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
+	return mmd_phy_write(phydev->mdio.bus, addr, phydev->is_c45, devad,
+			     regnum, val);
+}
+EXPORT_SYMBOL(__phy_package_write_mmd);
+
+/**
+ * phy_package_write_mmd - Convenience function for writing a register
+ * on an MMD on a given PHY using the PHY package base addr, added of
+ * the addr_offset value.
+ * @phydev: The phy_device struct
+ * @addr_offset: The offset to be added to PHY package base_addr
+ * @devad: The MMD to read from
+ * @regnum: The register on the MMD to read
+ * @val: value to write to @regnum
+ *
+ * Same rules as for phy_write();
+ *
+ * NOTE: It's assumed that the entire PHY package is either C22 or C45.
+ */
+int phy_package_write_mmd(struct phy_device *phydev,
+			  unsigned int addr_offset, int devad,
+			  u32 regnum, u16 val)
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
+	ret = mmd_phy_write(phydev->mdio.bus, addr, phydev->is_c45, devad,
+			    regnum, val);
+	phy_unlock_mdio_bus(phydev);
+
+	return ret;
+}
+EXPORT_SYMBOL(phy_package_write_mmd);
+
 /**
  * phy_modify_changed - Function for modifying a PHY register
  * @phydev: the phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 51702e349d83..f58a9ff52e0d 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2049,6 +2049,22 @@ static inline int __phy_package_write(struct phy_device *phydev,
 	return __mdiobus_write(phydev->mdio.bus, addr, regnum, val);
 }
 
+int __phy_package_read_mmd(struct phy_device *phydev,
+			   unsigned int addr_offset, int devad,
+			   u32 regnum);
+
+int phy_package_read_mmd(struct phy_device *phydev,
+			 unsigned int addr_offset, int devad,
+			 u32 regnum);
+
+int __phy_package_write_mmd(struct phy_device *phydev,
+			    unsigned int addr_offset, int devad,
+			    u32 regnum, u16 val);
+
+int phy_package_write_mmd(struct phy_device *phydev,
+			  unsigned int addr_offset, int devad,
+			  u32 regnum, u16 val);
+
 static inline bool __phy_package_set_once(struct phy_device *phydev,
 					  unsigned int b)
 {
-- 
2.40.1

