Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C4079DAA4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjILVY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjILVY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:24:26 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA1B10CA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 14:24:22 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-502a25ab777so7109292e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 14:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694553860; x=1695158660; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fwMp5ydndUjR+3VeuLFst0X3OH2AndWvcFZaHSMkeVU=;
        b=hI1Dz3zBkvdWBzC/OkI2enrDUNF4Bv4AxLnC0wKfmZYXyJArDDrMkd8ANNmEA56lS8
         nqTjrNj5+TBEVzNt5gHEJ7zK74RU9nRmvqY6L3fiM9CosfcTA3ZBj4dZaB6o/ZiO6hBc
         GHVrvrJtxWPKNVZ+Ww1AmBmnWMjdHKAxxIdpg/U0MfvXfLfm+pHERR0ASIRLCsEr1ifw
         OaDSa5liJPHB8IQBtiHx88P0th3EBQMcNAa3lJ8ze1qqKSP35ITh+9S+1KOW7fjGwPii
         LMUSag1b85XhW0L8l9RBNo3VZHnfwxJadyUu6WUKLpHbUkn5kC/LFPBa0ZOI1T7KESr+
         djVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694553860; x=1695158660;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwMp5ydndUjR+3VeuLFst0X3OH2AndWvcFZaHSMkeVU=;
        b=dePGfW4R2r2ffti/CUVlbEJMwVcB0alErEZCyqKmfDiEEEA46zs8BUo0OBA3ldCaKH
         VutASzYiN8C+JOQBgJFOQkx464rMgzQkZOmxmZ7mjVrIPrKgJjTHzMhDzUnnXw47yHCk
         bIbNDIrIzwF2FRxEAc5vM4ip+MA0VdScsF/OEtHfc3uJ1sPFmU13uLYoDxesGgbuybil
         Xeyw1Y48TrGOT0WOUABVS5UK0c2pUYdy19AAldbGDEzdqancMS6/vBSONgIpyZtFydjm
         8J9j6TCEr6ig6kt2LTgDin4TQRrC/9e+Ir8DN6sWWCaw7Sh+HP/ZP+oE6qOxfZR5YP8w
         3vxg==
X-Gm-Message-State: AOJu0Yw/WQLb6YQhB/xqzJKEtdcCvJbTPl8H9YrerGzNw7eNDZcdBCvX
        GvpVcwHtA5qUjdCPN9mgkHrtzw==
X-Google-Smtp-Source: AGHT+IHIfT3RNpxxYtDUlEF16+O2NBesmMWtuDvxn8ONlTgM/WOgQJ8sZA7bR2cdw/Yq0Ce1quCpAQ==
X-Received: by 2002:a05:6512:360b:b0:500:b2c9:7da9 with SMTP id f11-20020a056512360b00b00500b2c97da9mr467472lfs.45.1694553859879;
        Tue, 12 Sep 2023 14:24:19 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id j10-20020ac2550a000000b00500a44e158csm1873916lfk.235.2023.09.12.14.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 14:24:19 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Sep 2023 23:24:18 +0200
Subject: [PATCH net-next] net: dsa: rtl8366rb: Implement setting up link on
 CPU port
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-rtl8366rb-link-v1-1-216eed63f357@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAHXAGUC/x3MwQqDMAyA4VeRnA20UZzzVcRD1XQLSiZpGYL47
 is7fof/vyCxCScYqguMv5LkowW+rmB5B30xyloM5KhxT09oee+brrMZd9ENHzPFGJxfXUtQosM
 4yvkfjqCcUfnMMN33D4UeIVxqAAAA
To:     =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We auto-negotiate most ports in the RTL8366RB driver, but
the CPU port is hard-coded to 1Gbit, full duplex, tx and
rx pause.

This isn't very nice. People may configure speed and
duplex differently in the device tree.

Actually respect the arguments passed to the function for
the CPU port, which get passed properly after Russell's
patch "net: dsa: realtek: add phylink_get_caps implementation"

After this the link is still set up properly.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/dsa/realtek/rtl8366rb.c | 44 +++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 7868ef237f6c..b39b719a5b8f 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -95,12 +95,6 @@
 #define RTL8366RB_PAACR_RX_PAUSE	BIT(6)
 #define RTL8366RB_PAACR_AN		BIT(7)
 
-#define RTL8366RB_PAACR_CPU_PORT	(RTL8366RB_PAACR_SPEED_1000M | \
-					 RTL8366RB_PAACR_FULL_DUPLEX | \
-					 RTL8366RB_PAACR_LINK_UP | \
-					 RTL8366RB_PAACR_TX_PAUSE | \
-					 RTL8366RB_PAACR_RX_PAUSE)
-
 /* bits 0..7 = port 0, bits 8..15 = port 1 */
 #define RTL8366RB_PSTAT0		0x0014
 /* bits 0..7 = port 2, bits 8..15 = port 3 */
@@ -1081,29 +1075,61 @@ rtl8366rb_mac_link_up(struct dsa_switch *ds, int port, unsigned int mode,
 		      int speed, int duplex, bool tx_pause, bool rx_pause)
 {
 	struct realtek_priv *priv = ds->priv;
+	unsigned int val;
 	int ret;
 
+	/* Allow forcing the mode on the fixed CPU port, no autonegotiation.
+	 * We assume autonegotiation works on the PHY-facing ports.
+	 */
 	if (port != priv->cpu_port)
 		return;
 
 	dev_dbg(priv->dev, "MAC link up on CPU port (%d)\n", port);
 
-	/* Force the fixed CPU port into 1Gbit mode, no autonegotiation */
 	ret = regmap_update_bits(priv->map, RTL8366RB_MAC_FORCE_CTRL_REG,
 				 BIT(port), BIT(port));
 	if (ret) {
-		dev_err(priv->dev, "failed to force 1Gbit on CPU port\n");
+		dev_err(priv->dev, "failed to force CPU port\n");
 		return;
 	}
 
+	/* Conjure port config */
+	switch (speed) {
+	case SPEED_10:
+		val = RTL8366RB_PAACR_SPEED_10M;
+		break;
+	case SPEED_100:
+		val = RTL8366RB_PAACR_SPEED_100M;
+		break;
+	case SPEED_1000:
+		val = RTL8366RB_PAACR_SPEED_1000M;
+		break;
+	default:
+		val = RTL8366RB_PAACR_SPEED_1000M;
+		break;
+	}
+
+	if (duplex == DUPLEX_FULL)
+		val |= RTL8366RB_PAACR_FULL_DUPLEX;
+
+	if (tx_pause)
+		val |=  RTL8366RB_PAACR_TX_PAUSE;
+
+	if (rx_pause)
+		val |= RTL8366RB_PAACR_RX_PAUSE;
+
+	val |= RTL8366RB_PAACR_LINK_UP;
+
 	ret = regmap_update_bits(priv->map, RTL8366RB_PAACR2,
 				 0xFF00U,
-				 RTL8366RB_PAACR_CPU_PORT << 8);
+				 val << 8);
 	if (ret) {
 		dev_err(priv->dev, "failed to set PAACR on CPU port\n");
 		return;
 	}
 
+	dev_dbg(priv->dev, "set PAACR to %04x\n", val);
+
 	/* Enable the CPU port */
 	ret = regmap_update_bits(priv->map, RTL8366RB_PECR, BIT(port),
 				 0);

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230912-rtl8366rb-link-7b2ffa01d042

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

