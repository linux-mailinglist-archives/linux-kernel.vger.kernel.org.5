Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411D67F9DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjK0Klg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjK0Klb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:41:31 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1866B136
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:41:37 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507962561adso6155587e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1701081695; x=1701686495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywOmUh3+E3BrPrVrzGPyOnQBIBtadDkzgT4Gfly9luU=;
        b=usgzsHoI3U6TkoYITS5G/id7DF71mcUwqy60tdenlD5fijl3cTV1lXtml0CVuhU3Jm
         8/kM/uLx/1noQZlE7kspFrsSyi8Tmp7SFAPJq2prstC0x6Lrfm6DjSFkuMobzg9gBQwK
         LN9J9ycQSbROpAd19NLzOp8YoirK3TGsaHMqPv6uv1Bu8HJGCGB0GUnaXijYLi2XXMup
         E5yzTHK2mNLnuXhj6r3VLAK7JqdhipYZz7QW1grG6VOEDBdVmvwZgEcGZ3ZzatwFfZAR
         Tz+uQ2gpdxEWJ/NiF9jX9I4If9xUUAFnBvBr0BzaXFW4FqFSnBTaEeWImc80M8dt11TX
         j9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701081695; x=1701686495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywOmUh3+E3BrPrVrzGPyOnQBIBtadDkzgT4Gfly9luU=;
        b=Y0srojANTglolf2+0t32ub6ji1s8YfXFe8P6+aOAMFOVQ7Rf400wUUpQdau2l6XenU
         zw+4CK6pyVCInJptE3hRUeSPzbnb/sh3zjIp1RcPcVNhAhOBVAXhUgRfFQLALV0gSbsj
         C4xfF8uJuahBtV5KBc5OtNh9/3wbt1TlsOt1lBwhx8e6knVBZkScrEk84Yuzv0+9UjUL
         yRFXYspUZfXrcAcnGj3XRwDTLRG52dVvZYxw2eoB1TS/L0geZBgHtXZMVeSzFnBREnKK
         1G/QY7xnZHw3g7s0Lg0/rSOY1106sDEBs/s5Dq9YV3BPGraDxaxRQ6KYK3WEVLx5PAC1
         r0WQ==
X-Gm-Message-State: AOJu0YzzLO7kYpgjDybBPXdnD1vygYfMixBodc+7i1vbnm2ZRAFiwlP0
        CKH+gaDpvEDYocgW1iTJIXwMog==
X-Google-Smtp-Source: AGHT+IFnNWMBpcw27UBqGAplcSub4tfqzr/5uFem0JSEXjZ+D63ENv+dHHYwT+N5O3+TSDiDa44iGw==
X-Received: by 2002:a05:6512:2101:b0:50b:aa7e:c350 with SMTP id q1-20020a056512210100b0050baa7ec350mr3988251lfr.36.1701081695415;
        Mon, 27 Nov 2023 02:41:35 -0800 (PST)
Received: from localhost.localdomain ([185.117.107.42])
        by smtp.gmail.com with ESMTPSA id l6-20020a19c206000000b004fe1f1c0ee4sm1432070lfc.82.2023.11.27.02.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 02:41:34 -0800 (PST)
From:   =?UTF-8?q?Ram=C3=B3n=20N=2ERodriguez?= 
        <ramon.nordin.rodriguez@ferroamp.se>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ram=C3=B3n=20N=2ERodriguez?= 
        <ramon.nordin.rodriguez@ferroamp.se>
Subject: [PATCH 2/3] net: microchip_t1s: add support for LAN867x Rev.C1
Date:   Mon, 27 Nov 2023 11:40:44 +0100
Message-ID: <20231127104045.96722-3-ramon.nordin.rodriguez@ferroamp.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
References: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramón Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>

This commit adds support for yet another Microchip T1S lan867x phy
revision. The only meaningful difference between Rev.B that already is
supported and Rev.C is the init change where other undocumented regs
needs writes with unexplained values.
The changes introduced here attempts to follow the manufacturer
recommendations in AN1699.

Signed-off-by: Ramón Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
---
 drivers/net/phy/microchip_t1s.c | 96 +++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index ace2bf35a18a..db84d850b165 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -12,6 +12,7 @@
 #include <linux/phy.h>
 
 #define PHY_ID_LAN867X_REVB1 0x0007C162
+#define PHY_ID_LAN867X_REVC1 0x0007C164
 #define PHY_ID_LAN865X_REVB0 0x0007C1B3
 
 #define LAN867X_REG_STS2 0x0019
@@ -59,6 +60,22 @@ static const u16 lan867x_revb1_fixup_masks[12] = {
 	0x0600, 0x7F00, 0x2000, 0xFFFF,
 };
 
+static const u16 lan867x_revc1_fixup_registers[12] = {
+	0x00D0, 0x00E0, 0x0084, 0x008A,
+	0x00E9, 0x00F5, 0x00F4, 0x00F8,
+	0x00F9, 0x0081, 0x0091, 0x0093,
+};
+
+/* Index 2 & 3 will not be used, these are runtime populated/calculated.
+ * It makes the code a lot easier to read having this arr the same len
+ * as the _fixup_registers arr though
+ */
+static const u16 lan867x_revc1_fixup_values[12] = {
+	0x3F31, 0xC000, 0xFFFF, 0xFFFF,
+	0x9E50, 0x1CF8, 0xC020, 0x9B00,
+	0x4E53, 0x0080, 0x9660, 0x06E9,
+};
+
 /* LAN865x Rev.B0 configuration parameters from AN1760 */
 static const u32 lan865x_revb0_fixup_registers[28] = {
 	0x0091, 0x0081, 0x0043, 0x0044,
@@ -263,6 +280,74 @@ static int lan867x_revb1_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static int lan867x_revc1_read_fixup_value(struct phy_device *phydev, u16 addr)
+{
+	int regval;
+	/* The AN pretty much just states 'trust us' regarding these magic vals */
+	const u16 magic_or = 0xE0;
+	const u16 magic_reg_mask = 0x1F;
+	const u16 magic_check_mask = 0x10;
+
+	regval = lan865x_revb0_indirect_read(phydev, addr);
+	if (regval < 0)
+		return regval;
+
+	regval &= magic_reg_mask;
+
+	return (regval & magic_check_mask) ? regval | magic_or : regval;
+}
+
+static int lan867x_revc1_config_init(struct phy_device *phydev)
+{
+	int err;
+	int regval;
+	u16 override0;
+	u16 override1;
+	const u16 override_addr0 = 0x4;
+	const u16 override_addr1 = 0x8;
+	const u8 index_to_override0 = 2;
+	const u8 index_to_override1 = 3;
+
+	err = lan867x_wait_for_reset_complete(phydev);
+	if (err)
+		return err;
+
+	/* The application note specifies a super convenient process
+	 * where 2 of the fixup regs needs a write with a value that is
+	 * a modified result of another reg read.
+	 * Enjoy the magic show.
+	 */
+	regval = lan867x_revc1_read_fixup_value(phydev, override_addr0);
+	if (regval < 0)
+		return regval;
+	override0 = ((regval + 9) << 10) | ((regval + 14) << 4) | 0x3;
+
+	regval = lan867x_revc1_read_fixup_value(phydev, override_addr1);
+	if (regval < 0)
+		return regval;
+	override1 = (regval + 40) << 10;
+
+	for (int i = 0; i < ARRAY_SIZE(lan867x_revc1_fixup_registers); i++) {
+		/* The hardcoded  */
+		if (i == index_to_override0)
+			err = phy_write_mmd(phydev, MDIO_MMD_VEND2,
+					    lan867x_revc1_fixup_registers[i],
+					    override0);
+		else if (i == index_to_override1)
+			err = phy_write_mmd(phydev, MDIO_MMD_VEND2,
+					    lan867x_revc1_fixup_registers[i],
+					    override1);
+		else
+			err = phy_write_mmd(phydev, MDIO_MMD_VEND2,
+					    lan867x_revc1_fixup_registers[i],
+					    lan867x_revc1_fixup_values[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int lan86xx_read_status(struct phy_device *phydev)
 {
 	/* The phy has some limitations, namely:
@@ -289,6 +374,16 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
 	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVC1),
+		.name               = "LAN867X Rev.C1",
+		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
+		.config_init        = lan867x_revc1_config_init,
+		.read_status        = lan86xx_read_status,
+		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
+		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
+		.get_plca_status    = genphy_c45_plca_get_status,
+	},
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB0),
 		.name               = "LAN865X Rev.B0 Internal Phy",
@@ -305,6 +400,7 @@ module_phy_driver(microchip_t1s_driver);
 
 static struct mdio_device_id __maybe_unused tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVB1) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVC1) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB0) },
 	{ }
 };
-- 
2.40.1

