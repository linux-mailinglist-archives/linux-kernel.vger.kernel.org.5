Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7303E7FBBB0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345757AbjK1Ngi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345429AbjK1Nge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:36:34 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C6FDA;
        Tue, 28 Nov 2023 05:36:40 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3316c6e299eso3656019f8f.1;
        Tue, 28 Nov 2023 05:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701178599; x=1701783399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+1JCV7ywK09T18Om+G9iHl0r6MG2LGHGo6/W9Qoc40=;
        b=QEKfkZdMoXdjdUAZAXU+VmMyz0BsV2Acgm3TpBtMobubzc+z16u6sAUMGovlCiowE9
         Y85mFbGidXqs13AvHfHcCsAzWJ95ekEFQQJOib6fm+JdUBRUE4JRXqNBbVMT/DqRGaCc
         jiBspQmG2ZggsfPTAF6q7trZFrgeqWKDpIXIwBLY+Sj+5kB/b+8xeEaqQqxk/QCcjQS4
         fXWMWf4W4DpK+L+y5gA0znMult+uGPAmSMCn1EmVJKeE3bvE/t32QQB23cPwPvT9a50n
         9h5z0zkiBpCPsv0EMf33IYuk1oYPj0nzfHg+qzQyMwxg8PFhw6qoUqHhKq7k+11IpSGH
         XY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701178599; x=1701783399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+1JCV7ywK09T18Om+G9iHl0r6MG2LGHGo6/W9Qoc40=;
        b=DuIdFs1HpZYsMUBku2cH4OfqFtUFmsoM9PH7QCm66d4/zmrpttUD+90KZxAIMqpUcT
         viv7ABEqFfWJ53yIoMuQWZVaEP7XwDxFurxrbBkFdSYsKEW7pApozobcEmqS77KzT8Az
         mrX3jZ60UXIJfUVRS0XcEIADkZIYQA7WibaOCU9H+yhCYgy14Ah9gUuYDJ0cRr81Z0WI
         /3Hcig/x3lS77mpoDEQsqw7IUK4APaq58yWk66mJOFoqFUprWnXyk96whnk93dKqsJLB
         KKMzlWPD4BnH6yauK7kRA7NKAP/syQMKnPXrYkmIm0zoR5snW9FnKbG7oQSH38Wsjkp3
         WPdQ==
X-Gm-Message-State: AOJu0YylYylQaUSTMrvoFVcbT431LxYPVM+wz1W4uz4VMMcGAykz5ccD
        OcAIAxLHQUshxgKma9l9euE=
X-Google-Smtp-Source: AGHT+IGBWA7E4n9A6yrT8bT49hI66jo6Xoe/HykW+OqNQj7X2ede5bp6U11rvVqpaOW1la2xTM3gBw==
X-Received: by 2002:a05:6000:bc1:b0:331:6a36:a05f with SMTP id dm1-20020a0560000bc100b003316a36a05fmr10323256wrb.65.1701178598506;
        Tue, 28 Nov 2023 05:36:38 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id a8-20020adffb88000000b00333083a20e5sm3713132wrr.113.2023.11.28.05.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 05:36:38 -0800 (PST)
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
Subject: [net-next PATCH v3 3/3] net: phy: add support for PHY package MMD read/write
Date:   Tue, 28 Nov 2023 14:36:30 +0100
Message-Id: <20231128133630.7829-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231128133630.7829-1-ansuelsmth@gmail.com>
References: <20231128133630.7829-1-ansuelsmth@gmail.com>
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
Changes v3:
- Move in phy-core.c from phy.h
- Base c45 from phydev
Changes v2:
- Rework to use newly introduced helper
- Add common check for regnum and devad

 drivers/net/phy/phy-core.c | 136 +++++++++++++++++++++++++++++++++++++
 include/linux/phy.h        |  33 +++++++++
 2 files changed, 169 insertions(+)

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
index 51702e349d83..41e0698a3685 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2049,6 +2049,39 @@ static inline int __phy_package_write(struct phy_device *phydev,
 	return __mdiobus_write(phydev->mdio.bus, addr, regnum, val);
 }
 
+/*
+ * __phy_package_read_mmd - Convenience function for reading a register
+ * on an MMD on a given PHY using the PHY package base addr, added of
+ * the addr_offset value.
+ */
+int __phy_package_read_mmd(struct phy_device *phydev,
+			   unsigned int addr_offset, int devad,
+			   u32 regnum);
+/*
+ * phy_package_read_mmd - Convenience function for reading a register
+ * on an MMD on a given PHY using the PHY package base addr, added of
+ * the addr_offset value.
+ */
+int phy_package_read_mmd(struct phy_device *phydev,
+			 unsigned int addr_offset, int devad,
+			 u32 regnum);
+/*
+ * __phy_package_write_mmd - Convenience function for writing a register
+ * on an MMD on a given PHY using the PHY package base addr, added of
+ * the addr_offset value.
+ */
+int __phy_package_write_mmd(struct phy_device *phydev,
+			    unsigned int addr_offset, int devad,
+			    u32 regnum, u16 val);
+/*
+ * phy_package_write_mmd - Convenience function for writing a register
+ * on an MMD on a given PHY using the PHY package base addr, added of
+ * the addr_offset value.
+ */
+int phy_package_write_mmd(struct phy_device *phydev,
+			  unsigned int addr_offset, int devad,
+			  u32 regnum, u16 val);
+
 static inline bool __phy_package_set_once(struct phy_device *phydev,
 					  unsigned int b)
 {
-- 
2.40.1

