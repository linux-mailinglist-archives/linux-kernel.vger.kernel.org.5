Return-Path: <linux-kernel+bounces-37702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F0883B41C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDFC21F24B56
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFCC136651;
	Wed, 24 Jan 2024 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCWHre3R"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1FB13540A;
	Wed, 24 Jan 2024 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132220; cv=none; b=dWJhNCC6SESb2gq9wTUCw/XtdztZYFKCw4ZApp67601sMTH5Wv1iwX7qZxHZXTiVuFDHm9LuOJEIoko0i1XCO5QJy4FfJY8aAgJHJnKGza7O/DK82IUjInqdoOB3pb0K+tjeLOXbM3/mYgiAG7cU1dZr7zM5YqGZHRHnUu8qRhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132220; c=relaxed/simple;
	bh=HiTLyQa2KKZSm3Od3FweVhdcb+fIx8SekXbCe5zH2mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbtqEpMZ14V76wnVMBFpzMg+zdFncmMZ9TpJ0uTqJZnpZu15vRDP0s8MgItKLPBGIvtGOkBHaowhYZKNRIasGt/gPFqdlszwbjzYax3Dlg6nCKHgohuOka/CGAVAaDCEtfuy5IG+dhNF8fDGG+NdBAsyzP0kaRZt9izmhwOveg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCWHre3R; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40eccccfce0so7827875e9.1;
        Wed, 24 Jan 2024 13:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706132217; x=1706737017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tp/E23mZHgvcs3xcO6EdfWN3EmGOTFfoELajIfWpK/I=;
        b=QCWHre3RaI8Uok0/XoVZx0zM2CV9L2F39lj1cVsQlQSkiTHpa1etKV8KwGPbd+EC+S
         9oEEqkoeHhpWEvqsUI+xL6BMjiLwVx+59MfTdVSYlY3rWXZ4aIYMx0aTFrjjsPYHQHzf
         aoflGQomWg0o03HMecS8/MzVvikoW3EntAHp+YBL7n6x4+8FJ7Qb9KlYtJPwscGf8TNN
         8j2lHxbEY9F/FK/cKlnlrHM3QOFYsJIU0XTyLwgNY47ohkQ/P6kzr/bTppGfXMajuHKN
         cNH6Il0CJ4hGFkIbTWIVv35Xd2fnwYGgNLhxXFuZSPqvmsbuOhdH7fJDQrvkEg/6hGE8
         qFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706132217; x=1706737017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tp/E23mZHgvcs3xcO6EdfWN3EmGOTFfoELajIfWpK/I=;
        b=C1WxLK+XbZe5Cy5FYyAtXUvTks6a/XMRVQTtkj0V6zwHDlbSI646Bs/+h4kgLc3+tn
         daH56oZD8yA7NM/1EGE4jZ/hLiPumhF0tLmEoHnbj+c2ACNGiNcUo6f8wRJ9TZdqYfqb
         9dU4VWNPFO8SEDdIOcqxk0cVI5hAdxmkRwYQOBUlM8xtqynJVhIoywBha+wOhU1T22yz
         xeTYh0QZyIsBTXPYAwW1fCOAHtiZ6pFW/7r/rkNzMRQ1MMzvgTTa+yKQbeOM0uR8GaBs
         r6v0Nf71RQY2LZZ67Ti9YbJfZZUHdbZ7jguzohkj8obqVMGBToASKvx9vABDmsCNDBaD
         Lr6A==
X-Gm-Message-State: AOJu0YwqtrLErehZqyqd7oy0ncueXCajhW1s2o5mORYrNjKAZAsggqz6
	DRckgG+URZyPN49OCyjK68zcDx32C3mCnmS5ccnfs4rZzlAQ/bnC
X-Google-Smtp-Source: AGHT+IE192+WYaQcaX0ef9nYySbwmu0BPx+vc1zygEDlUdqvZFcsF5n7VION2CbpxoSQ3/iOmnF9qg==
X-Received: by 2002:a05:600c:5857:b0:40e:5577:17e with SMTP id ka23-20020a05600c585700b0040e5577017emr1623610wmb.57.1706132216978;
        Wed, 24 Jan 2024 13:36:56 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id q13-20020a05600c46cd00b0040e89ade84bsm339466wmo.4.2024.01.24.13.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 13:36:56 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 2/3] net: mdio: ipq4019: add support for clock-frequency property
Date: Wed, 24 Jan 2024 22:36:32 +0100
Message-ID: <20240124213640.7582-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124213640.7582-1-ansuelsmth@gmail.com>
References: <20240124213640.7582-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IPQ4019 MDIO internally divide the clock feed by AHB based on the
MDIO_MODE reg. On reset or power up, the default value for the
divider is 0xff that reflect the divider set to /256.

This makes the MDC run at a very low rate, that is, considering AHB is
always fixed to 100Mhz, a value of 390KHz.

This hasn't have been a problem as MDIO wasn't used for time sensitive
operation, it is now that on IPQ807x is usually mounted with PHY that
requires MDIO to load their firmware (example Aquantia PHY).

To handle this problem and permit to set the correct designed MDC
frequency for the SoC add support for the standard "clock-frequency"
property for the MDIO node.

The divider supports value from /1 to /256 and the common value are to
set it to /16 to reflect 6.25Mhz or to /8 on newer platform to reflect
12.5Mhz.

To scan if the requested rate is supported by the divider, loop with
each supported divider and stop when the requested rate match the final
rate with the current divider. An error is returned if the rate doesn't
match any value.

On MDIO reset, the divider is restored to the requested value to prevent
any kind of downclocking caused by the divider reverting to a default
value.

While at is also document other bits of the MDIO_MODE reg to have a
clear idea of what is actually applied there.

Documentation of some BITs is skipped as they are marked as reserved and
their usage is not clear (RES 11:9 GENPHY 16:13 RES1 19:17)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mdio/mdio-ipq4019.c | 68 ++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
index abd8b508ec16..a4c6cf901ac2 100644
--- a/drivers/net/mdio/mdio-ipq4019.c
+++ b/drivers/net/mdio/mdio-ipq4019.c
@@ -14,6 +14,20 @@
 #include <linux/clk.h>
 
 #define MDIO_MODE_REG				0x40
+#define   MDIO_MODE_MDC_MODE			BIT(12)
+/* 0 = Clause 22, 1 = Clause 45 */
+#define   MDIO_MODE_C45				BIT(8)
+#define   MDIO_MODE_DIV_MASK			GENMASK(7, 0)
+#define     MDIO_MODE_DIV(x)			FIELD_PREP(MDIO_MODE_DIV_MASK, (x) - 1)
+#define     MDIO_MODE_DIV_1			FIELD_PREP(MDIO_MODE_DIV_MASK, 0x0)
+#define     MDIO_MODE_DIV_2			FIELD_PREP(MDIO_MODE_DIV_MASK, 0x1)
+#define     MDIO_MODE_DIV_4			FIELD_PREP(MDIO_MODE_DIV_MASK, 0x3)
+#define     MDIO_MODE_DIV_8			FIELD_PREP(MDIO_MODE_DIV_MASK, 0x7)
+#define     MDIO_MODE_DIV_16			FIELD_PREP(MDIO_MODE_DIV_MASK, 0xf)
+#define     MDIO_MODE_DIV_32			FIELD_PREP(MDIO_MODE_DIV_MASK, 0x1f)
+#define     MDIO_MODE_DIV_64			FIELD_PREP(MDIO_MODE_DIV_MASK, 0x3f)
+#define     MDIO_MODE_DIV_128			FIELD_PREP(MDIO_MODE_DIV_MASK, 0x7f)
+#define     MDIO_MODE_DIV_256			FIELD_PREP(MDIO_MODE_DIV_MASK, 0xff)
 #define MDIO_ADDR_REG				0x44
 #define MDIO_DATA_WRITE_REG			0x48
 #define MDIO_DATA_READ_REG			0x4c
@@ -26,9 +40,6 @@
 #define MDIO_CMD_ACCESS_CODE_C45_WRITE	1
 #define MDIO_CMD_ACCESS_CODE_C45_READ	2
 
-/* 0 = Clause 22, 1 = Clause 45 */
-#define MDIO_MODE_C45				BIT(8)
-
 #define IPQ4019_MDIO_TIMEOUT	10000
 #define IPQ4019_MDIO_SLEEP		10
 
@@ -41,6 +52,7 @@ struct ipq4019_mdio_data {
 	void __iomem	*membase;
 	void __iomem *eth_ldo_rdy;
 	struct clk *mdio_clk;
+	unsigned int mdc_rate;
 };
 
 static int ipq4019_mdio_wait_busy(struct mii_bus *bus)
@@ -203,6 +215,38 @@ static int ipq4019_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
 	return 0;
 }
 
+static int ipq4019_mdio_set_div(struct ipq4019_mdio_data *priv)
+{
+	unsigned long ahb_rate;
+	int div;
+	u32 val;
+
+	/* If we don't have a clock for AHB use the fixed value */
+	ahb_rate = IPQ_MDIO_CLK_RATE;
+	if (priv->mdio_clk)
+		ahb_rate = clk_get_rate(priv->mdio_clk);
+
+	/* MDC rate is ahb_rate/(MDIO_MODE_DIV + 1)
+	 * While supported, internal documentation doesn't
+	 * assure correct functionality of the MDIO bus
+	 * with divider of 1, 2 or 4.
+	 */
+	for (div = 8; div <= 256; div *= 2) {
+		/* The requested rate is supported by the div */
+		if (priv->mdc_rate == ahb_rate / div) {
+			val = readl(priv->membase + MDIO_MODE_REG);
+			val &= ~MDIO_MODE_DIV_MASK;
+			val |= MDIO_MODE_DIV(div);
+			writel(val, priv->membase + MDIO_MODE_REG);
+
+			return 0;
+		}
+	}
+
+	/* The requested rate is not supported */
+	return -EINVAL;
+}
+
 static int ipq_mdio_reset(struct mii_bus *bus)
 {
 	struct ipq4019_mdio_data *priv = bus->priv;
@@ -225,8 +269,14 @@ static int ipq_mdio_reset(struct mii_bus *bus)
 		return ret;
 
 	ret = clk_prepare_enable(priv->mdio_clk);
-	if (ret == 0)
-		mdelay(10);
+	if (ret)
+		return ret;
+
+	mdelay(10);
+
+	/* Restore MDC rate if previously set */
+	if (priv->mdc_rate)
+		ret = ipq4019_mdio_set_div(priv);
 
 	return ret;
 }
@@ -252,6 +302,14 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->mdio_clk))
 		return PTR_ERR(priv->mdio_clk);
 
+	priv->mdc_rate = 0;
+	if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
+				  &priv->mdc_rate)) {
+		ret = ipq4019_mdio_set_div(priv);
+		if (ret)
+			return ret;
+	}
+
 	/* The platform resource is provided on the chipset IPQ5018 */
 	/* This resource is optional */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-- 
2.43.0


