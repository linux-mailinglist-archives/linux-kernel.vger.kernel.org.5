Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6C7752B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 22:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjGMUVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 16:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjGMUVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 16:21:31 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB5D2127
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:21:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-314417861b9so1269947f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1689279687; x=1691871687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v4CrEIfrjQ2FMKZX2ewx6d372/dw3pvGNTCu7mW4Pns=;
        b=gkiTYElMTDBnu1cdXyXHvgBU4WRMsZ2e0jQndmpTL9Q9PAo2YUKoHPO3Cxb1CtjNx0
         CDWaBqwpB/tNblbkeyftrlujX/t1qvXjLtJOtB4cAe2BQuw9PE7OqzI6Oks/WOCOidf7
         LxHdXmqXi9pWmjWQ8A3dFHBp9z3uuD7jGxxvo74uzOZUQInY+Sp8EgtkNWapzJiN47V7
         /EoMw+1JMJtQX1e1ri91SViJ/UOUjhqxL4KsOsPksWAOhUa1zztI3cBhc39Yfp2/WTRi
         nVwQeGbi7g2vQnITRqm47VjpxsEQRV55DaxnaaJVT+5Oq9AMubklN9gA0qdrhQjkkKGi
         re0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689279687; x=1691871687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4CrEIfrjQ2FMKZX2ewx6d372/dw3pvGNTCu7mW4Pns=;
        b=EM7BOZk7B8Ih1lv5VSoHRU2E859LqnPdJzygngCOvNeH7c2FplxaEbfmbqO5FtOy4A
         J23kAmdgiVwUeOzhlyFArMI3Bvqi/M+GF5msWzWtFv4T6yutscGBWah/JfpuuKt/EFR3
         ys9HPPbDF6jZvnU7XRE6/85v9rxXJjPWE5biYpBC53xUR9TC0IT/MvaCKG1NRvwiPVos
         7+uoAbQsBJ/w6iUTbBrWbmprIq388WQ4w6I0lJt291Obu52GhmENCy/fLcqBa3xk0Vmn
         X6NNPKHFjHOLAmJiokqllFnTm8Rr/glYuNu/LoEdtstt/L6Yup7D7JGAyZPaFf5UaXHX
         IW6g==
X-Gm-Message-State: ABy/qLb2+d5ltKkQeoGptSkjU00++oePQ8C96ks5RttuO3RW6jSr+HBw
        JmQdn+FlwfSuf8AtPo6HWt5a2w==
X-Google-Smtp-Source: APBJJlHq2pUSPgBx5Tj6uSYMyYQXaacAVg9+vui4gpLQ5d0tkeJ9qBx5xIDImovX3hluY8+Wyit8Vw==
X-Received: by 2002:a5d:490f:0:b0:314:4237:8832 with SMTP id x15-20020a5d490f000000b0031442378832mr2246109wrq.48.1689279686899;
        Thu, 13 Jul 2023 13:21:26 -0700 (PDT)
Received: from localhost.localdomain ([188.27.129.168])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d560d000000b0031590317c26sm8880170wrv.61.2023.07.13.13.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 13:21:26 -0700 (PDT)
From:   Alexandru Ardelean <alex@shruggie.ro>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        olteanv@gmail.com, alex@shruggie.ro, marius.muresan@mxt.ro
Subject: [PATCH v2 1/2 net-next] net: phy: mscc: add support for CLKOUT ctrl reg for VSC8531 and similar
Date:   Thu, 13 Jul 2023 23:21:22 +0300
Message-ID: <20230713202123.231445-1-alex@shruggie.ro>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VSC8531 and similar PHYs (i.e. VSC8530, VSC8531, VSC8540 & VSC8541)
have a CLKOUT pin on the chip that can be controlled by register (13G in
the General Purpose Registers page) that can be configured to output a
frequency of 25, 50 or 125 Mhz.

This is useful when wanting to provide a clock source for the MAC in some
board designs.

Signed-off-by: Marius Muresan <marius.muresan@mxt.ro>
Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
---

Changelog v1 -> v2:
* https://lore.kernel.org/netdev/20230706081554.1616839-1-alex@shruggie.ro/
* changed property name 'vsc8531,clkout-freq-mhz' -> 'mscc,clkout-freq-mhz'
  as requested by Rob
* introduced 'goto set_reg' to reduce indentation (no idea why I did not
  think of that sooner)
* added 'net-next' tag as requested by Andrew

 drivers/net/phy/mscc/mscc.h      |  5 ++++
 drivers/net/phy/mscc/mscc_main.c | 41 ++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
index 7a962050a4d4..4ea21921a7ba 100644
--- a/drivers/net/phy/mscc/mscc.h
+++ b/drivers/net/phy/mscc/mscc.h
@@ -181,6 +181,11 @@ enum rgmii_clock_delay {
 #define VSC8502_RGMII_TX_DELAY_MASK	  0x0007
 #define VSC8502_RGMII_RX_CLK_DISABLE	  0x0800
 
+/* CKLOUT Control register, for VSC8531 and similar */
+#define VSC8531_CLKOUT_CNTL		  13
+#define VSC8531_CLKOUT_CNTL_ENABLE	  BIT(15)
+#define VSC8531_CLKOUT_CNTL_FREQ_MASK	  GENMASK(14, 13)
+
 #define MSCC_PHY_WOL_LOWER_MAC_ADDR	  21
 #define MSCC_PHY_WOL_MID_MAC_ADDR	  22
 #define MSCC_PHY_WOL_UPPER_MAC_ADDR	  23
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 4171f01d34e5..ec029d26071d 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -618,6 +618,42 @@ static void vsc85xx_tr_write(struct phy_device *phydev, u16 addr, u32 val)
 	__phy_write(phydev, MSCC_PHY_TR_CNTL, TR_WRITE | TR_ADDR(addr));
 }
 
+static int vsc8531_clkout_config(struct phy_device *phydev)
+{
+	static const u32 freq_vals[] = { 25, 50, 125 };
+	struct device *dev = &phydev->mdio.dev;
+	u16 mask, set;
+	u32 freq, i;
+	int rc;
+
+	mask = VSC8531_CLKOUT_CNTL_ENABLE | VSC8531_CLKOUT_CNTL_FREQ_MASK;
+	set = 0;
+
+	if (device_property_read_u32(dev, "mscc,clkout-freq-mhz", &freq))
+		goto set_reg;
+
+	/* The indices from 'freq_vals' are used in the register */
+	for (i = 0; i < ARRAY_SIZE(freq_vals); i++) {
+		if (freq != freq_vals[i])
+			continue;
+
+		set |= VSC8531_CLKOUT_CNTL_ENABLE |
+		       FIELD_PREP(VSC8531_CLKOUT_CNTL_FREQ_MASK, i);
+		break;
+	}
+	if (set == 0)
+		dev_warn(dev, "Invalid 'mscc,clkout-freq-mhz' value %u\n",
+			 freq);
+
+set_reg:
+	mutex_lock(&phydev->lock);
+	rc = phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_GPIO,
+			      VSC8531_CLKOUT_CNTL, mask, set);
+	mutex_unlock(&phydev->lock);
+
+	return rc;
+}
+
 static int vsc8531_pre_init_seq_set(struct phy_device *phydev)
 {
 	int rc;
@@ -1852,6 +1888,11 @@ static int vsc85xx_config_init(struct phy_device *phydev)
 		rc = vsc8531_pre_init_seq_set(phydev);
 		if (rc)
 			return rc;
+
+		rc = vsc8531_clkout_config(phydev);
+		if (rc)
+			return rc;
+
 	}
 
 	rc = vsc85xx_eee_init_seq_set(phydev);
-- 
2.41.0

