Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B0D810F8D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378825AbjLMLNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378718AbjLMLNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:13:33 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6D9A0;
        Wed, 13 Dec 2023 03:13:39 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c3f68b649so44014715e9.0;
        Wed, 13 Dec 2023 03:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702466017; x=1703070817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZeodouXCxjXC5HG8L3ZXr6Z5BBeR9v4nmWTsbrew50=;
        b=L0qQrMymRo5zx7lDcDuk1+a4BL8YEHsVPbxzKOXhUEd8xtZdcyDZD+eWpLTFDyrEl2
         aWrv6b7YmrEyC/JNWCXrT/Xcst2v9KMyMA9wrc6H1s3dXG4sDnbuUkMk37zT+zHEYJCO
         ruweIQPja0WS8aEXhkwzs3MgAZAEFYhzL88xwUGkVMhBZf3nWV7ZiGC46TDu1lQSVBZs
         65zi0JB4fd7UDLBtcJLgyLLOtS56g78jTtd6gBjO5P8ThLryQcQbo9Wuwq6Ffi0572hV
         6XizWAFJrn+ujsKTX6VBt+hluoGtpiDBIj3Erad41nJ8+aaw+J73D6n+Nu4Ral7565KQ
         QP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702466017; x=1703070817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZeodouXCxjXC5HG8L3ZXr6Z5BBeR9v4nmWTsbrew50=;
        b=nh1J5kddSv5cBVbYuIYV8J6UYC4pN0SkWzlFN9Wb6kQV5mXpnGJf/eiaMFJOKkIAkZ
         wnX+ouArnqcJNCkNlR3pkamL/BxClYqZLLaZjIFvJfAIWbbWapch+bxcWuk7vokGL5ub
         WQ+qPoXVvnBoCei858mIHlfXPi8nk66KcUnsB2ZAg4AiMNjpVjTWgDNnmQjHRlJlq9qv
         yUSUkkfoLMP0Qbf3LgY6pwJDwdr1Z7UqOXi2+37Whz0frk32KNByHgFEWJmo6jPlDklA
         fUKPOqT0Evp7gMvLDFRC+Rd6spvoi4LkKrPJ3PRJp1jHHSEuU++eQxLw5sIKP919lgY0
         Tk/g==
X-Gm-Message-State: AOJu0YyTkNTcv2cyy9JY1LFDU83UlJeAClePV6tkc/JSOM3C7MXaDalN
        o+33w181fM2eRr73bSuHHxFeolTf5Yc=
X-Google-Smtp-Source: AGHT+IFQKSl9n4TYl62M8nM8yYnZMCSCw6LyxgfxewxKPLSTipo7xIx7sM9ojzOf4Tta4JOrSmlcbQ==
X-Received: by 2002:a05:600c:1d12:b0:40c:236b:6737 with SMTP id l18-20020a05600c1d1200b0040c236b6737mr2860971wms.171.1702466017532;
        Wed, 13 Dec 2023 03:13:37 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id fc7-20020a05600c524700b0040c44cb251dsm12388301wmb.46.2023.12.13.03.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 03:13:37 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [net-next PATCH v3 4/4] net: phy: at803x: add LED support for qca808x
Date:   Wed, 13 Dec 2023 12:13:22 +0100
Message-Id: <20231213111322.6152-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213111322.6152-1-ansuelsmth@gmail.com>
References: <20231213111322.6152-1-ansuelsmth@gmail.com>
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

Add LED support for QCA8081 PHY.

Documentation for this LEDs PHY is very scarce even with NDA access
to Documentation for OEMs. Only the blink pattern are documented and are
very confusing most of the time. No documentation is present about
forcing the LED on/off or to always blink.

Those settings were reversed by poking the regs and trying to find the
correct bits to trigger these modes. Some bits mode are not clear and
maybe the documentation option are not 100% correct. For the sake of LED
support the reversed option are enough to add support for current LED
APIs.

Supported HW control modes are:
- tx
- rx
- link10
- link100
- link1000
- half_duplex
- full_duplex

Also add support for LED polarity set to set LED polarity to active
high or low. QSDK sets this value to high by default but PHY reset value
doesn't have this enabled by default.

QSDK also sets 2 additional bits but their usage is not clear, info about
this is added in the header. It was verified that for correct function
of the LED if active high is needed, only BIT 6 is needed.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v3:
- Out of RFC
- Drop link_25000 and add TODO commends waiting for the
  netdev trigger thing to be merged (I will take care of
  sending a followup patch later)
Changes v2:
- Move to new led_polarity_set implementation
- Drop special probe

 drivers/net/phy/at803x.c | 281 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 281 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index b9d3a26cf6dc..7c3c4df65787 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -272,6 +272,69 @@
 #define QCA808X_CDT_STATUS_STAT_OPEN		2
 #define QCA808X_CDT_STATUS_STAT_SHORT		3
 
+#define QCA808X_MMD7_LED2_CTRL			0x8074
+#define QCA808X_MMD7_LED2_FORCE_CTRL		0x8075
+#define QCA808X_MMD7_LED1_CTRL			0x8076
+#define QCA808X_MMD7_LED1_FORCE_CTRL		0x8077
+#define QCA808X_MMD7_LED0_CTRL			0x8078
+#define QCA808X_MMD7_LED_CTRL(x)		(0x8078 - ((x) * 2))
+
+/* LED hw control pattern is the same for every LED */
+#define QCA808X_LED_PATTERN_MASK		GENMASK(15, 0)
+#define QCA808X_LED_SPEED2500_ON		BIT(15)
+#define QCA808X_LED_SPEED2500_BLINK		BIT(14)
+/* Follow blink trigger even if duplex or speed condition doesn't match */
+#define QCA808X_LED_BLINK_CHECK_BYPASS		BIT(13)
+#define QCA808X_LED_FULL_DUPLEX_ON		BIT(12)
+#define QCA808X_LED_HALF_DUPLEX_ON		BIT(11)
+#define QCA808X_LED_TX_BLINK			BIT(10)
+#define QCA808X_LED_RX_BLINK			BIT(9)
+#define QCA808X_LED_TX_ON_10MS			BIT(8)
+#define QCA808X_LED_RX_ON_10MS			BIT(7)
+#define QCA808X_LED_SPEED1000_ON		BIT(6)
+#define QCA808X_LED_SPEED100_ON			BIT(5)
+#define QCA808X_LED_SPEED10_ON			BIT(4)
+#define QCA808X_LED_COLLISION_BLINK		BIT(3)
+#define QCA808X_LED_SPEED1000_BLINK		BIT(2)
+#define QCA808X_LED_SPEED100_BLINK		BIT(1)
+#define QCA808X_LED_SPEED10_BLINK		BIT(0)
+
+#define QCA808X_MMD7_LED0_FORCE_CTRL		0x8079
+#define QCA808X_MMD7_LED_FORCE_CTRL(x)		(0x8079 - ((x) * 2))
+
+/* LED force ctrl is the same for every LED
+ * No documentation exist for this, not even internal one
+ * with NDA as QCOM gives only info about configuring
+ * hw control pattern rules and doesn't indicate any way
+ * to force the LED to specific mode.
+ * These define comes from reverse and testing and maybe
+ * lack of some info or some info are not entirely correct.
+ * For the basic LED control and hw control these finding
+ * are enough to support LED control in all the required APIs.
+ */
+#define QCA808X_LED_FORCE_MASK			GENMASK(15, 13)
+#define QCA808X_LED_FORCE_BLINK_8HZ		FIELD_PREP(QCA808X_LED_FORCE_MASK, 0x7)
+#define QCA808X_LED_FORCE_BLINK_4HZ		FIELD_PREP(QCA808X_LED_FORCE_MASK, 0x6)
+#define QCA808X_LED_FORCE_ON			FIELD_PREP(QCA808X_LED_FORCE_MASK, 0x5)
+#define QCA808X_LED_FORCE_OFF			FIELD_PREP(QCA808X_LED_FORCE_MASK, 0x4)
+/* HW control option are confusing:
+ * - 0x3 is 50% on 50% off at 4hz
+ * - 0x2 is 75% on 25% off at 4hz
+ * - 0x1 is 25% on 75% off at 4hz
+ * - 0x0 is 50% on 50% off at 8hz and is set by default
+ * This comes from visual check and may not be 100% correct.
+ */
+#define QCA808X_LED_HW_CONTROL_50_50_4HZ	FIELD_PREP(QCA808X_LED_FORCE_MASK, 0x3)
+#define QCA808X_LED_HW_CONTROL_75_25		FIELD_PREP(QCA808X_LED_FORCE_MASK, 0x2)
+#define QCA808X_LED_HW_CONTROL_25_75		FIELD_PREP(QCA808X_LED_FORCE_MASK, 0x1)
+#define QCA808X_LED_HW_CONTROL_50_50_8HZ	FIELD_PREP(QCA808X_LED_FORCE_MASK, 0x0)
+
+#define QCA808X_MMD7_LED_POLARITY_CTRL		0x901a
+/* QSDK sets by default 0x46 to this reg that sets BIT 6 for
+ * LED to active high. It's not clear what BIT 3 and BIT 4 does.
+ */
+#define QCA808X_LED_ACTIVE_HIGH			BIT(6)
+
 /* QCA808X 1G chip type */
 #define QCA808X_PHY_MMD7_CHIP_TYPE		0x901d
 #define QCA808X_PHY_CHIP_TYPE_1G		BIT(0)
@@ -2128,6 +2191,218 @@ static void qca808x_link_change_notify(struct phy_device *phydev)
 			QCA8081_PHY_FIFO_RSTN, phydev->link ? QCA8081_PHY_FIFO_RSTN : 0);
 }
 
+static int qca808x_led_parse_netdev(struct phy_device *phydev, unsigned long rules,
+				    u16 *offload_trigger)
+{
+	/* TODO: add link_2500 when added to netdev trigger */
+	/* Parsing specific to netdev trigger */
+	if (test_bit(TRIGGER_NETDEV_TX, &rules))
+		*offload_trigger |= QCA808X_LED_TX_BLINK;
+	if (test_bit(TRIGGER_NETDEV_RX, &rules))
+		*offload_trigger |= QCA808X_LED_RX_BLINK;
+	if (test_bit(TRIGGER_NETDEV_LINK_10, &rules))
+		*offload_trigger |= QCA808X_LED_SPEED10_ON;
+	if (test_bit(TRIGGER_NETDEV_LINK_100, &rules))
+		*offload_trigger |= QCA808X_LED_SPEED100_ON;
+	if (test_bit(TRIGGER_NETDEV_LINK_1000, &rules))
+		*offload_trigger |= QCA808X_LED_SPEED1000_ON;
+	if (test_bit(TRIGGER_NETDEV_HALF_DUPLEX, &rules))
+		*offload_trigger |= QCA808X_LED_HALF_DUPLEX_ON;
+	if (test_bit(TRIGGER_NETDEV_FULL_DUPLEX, &rules))
+		*offload_trigger |= QCA808X_LED_FULL_DUPLEX_ON;
+
+	if (rules && !*offload_trigger)
+		return -EOPNOTSUPP;
+
+	/* Enable BLINK_CHECK_BYPASS by default to make the LED
+	 * blink even with duplex or speed mode not enabled.
+	 */
+	*offload_trigger |= QCA808X_LED_BLINK_CHECK_BYPASS;
+
+	return 0;
+}
+
+static int qca808x_led_hw_control_enable(struct phy_device *phydev, u8 index)
+{
+	u16 reg;
+
+	if (index > 2)
+		return -EINVAL;
+
+	reg = QCA808X_MMD7_LED_FORCE_CTRL(index);
+
+	return phy_clear_bits_mmd(phydev, MDIO_MMD_AN, reg,
+				  QCA808X_LED_FORCE_MASK);
+}
+
+static int qca808x_led_hw_is_supported(struct phy_device *phydev, u8 index,
+				       unsigned long rules)
+{
+	u16 offload_trigger = 0;
+
+	if (index > 2)
+		return -EINVAL;
+
+	return qca808x_led_parse_netdev(phydev, rules, &offload_trigger);
+}
+
+static int qca808x_led_hw_control_set(struct phy_device *phydev, u8 index,
+				      unsigned long rules)
+{
+	u16 reg, offload_trigger = 0;
+	int ret;
+
+	if (index > 2)
+		return -EINVAL;
+
+	reg = QCA808X_MMD7_LED_CTRL(index);
+
+	ret = qca808x_led_parse_netdev(phydev, rules, &offload_trigger);
+	if (ret)
+		return ret;
+
+	ret = qca808x_led_hw_control_enable(phydev, index);
+	if (ret)
+		return ret;
+
+	return phy_modify_mmd(phydev, MDIO_MMD_AN, reg,
+			      QCA808X_LED_PATTERN_MASK,
+			      offload_trigger);
+}
+
+static bool qca808x_led_hw_control_status(struct phy_device *phydev, u8 index)
+{
+	u16 reg;
+	int val;
+
+	if (index > 2)
+		return false;
+
+	reg = QCA808X_MMD7_LED_FORCE_CTRL(index);
+
+	val = phy_read_mmd(phydev, MDIO_MMD_AN, reg);
+
+	return !(val & QCA808X_LED_FORCE_MASK);
+}
+
+static int qca808x_led_hw_control_get(struct phy_device *phydev, u8 index,
+				      unsigned long *rules)
+{
+	u16 reg;
+	int val;
+
+	if (index > 2)
+		return -EINVAL;
+
+	/* Check if we have hw control enabled */
+	if (qca808x_led_hw_control_status(phydev, index))
+		return -EINVAL;
+
+	reg = QCA808X_MMD7_LED_CTRL(index);
+
+	/* TODO: add link_2500 when added to netdev trigger */
+	val = phy_read_mmd(phydev, MDIO_MMD_AN, reg);
+	if (val & QCA808X_LED_TX_BLINK)
+		set_bit(TRIGGER_NETDEV_TX, rules);
+	if (val & QCA808X_LED_RX_BLINK)
+		set_bit(TRIGGER_NETDEV_RX, rules);
+	if (val & QCA808X_LED_SPEED10_ON)
+		set_bit(TRIGGER_NETDEV_LINK_10, rules);
+	if (val & QCA808X_LED_SPEED100_ON)
+		set_bit(TRIGGER_NETDEV_LINK_100, rules);
+	if (val & QCA808X_LED_SPEED1000_ON)
+		set_bit(TRIGGER_NETDEV_LINK_1000, rules);
+	if (val & QCA808X_LED_HALF_DUPLEX_ON)
+		set_bit(TRIGGER_NETDEV_HALF_DUPLEX, rules);
+	if (val & QCA808X_LED_FULL_DUPLEX_ON)
+		set_bit(TRIGGER_NETDEV_FULL_DUPLEX, rules);
+
+	return 0;
+}
+
+static int qca808x_led_hw_control_reset(struct phy_device *phydev, u8 index)
+{
+	u16 reg;
+
+	if (index > 2)
+		return -EINVAL;
+
+	reg = QCA808X_MMD7_LED_CTRL(index);
+
+	return phy_clear_bits_mmd(phydev, MDIO_MMD_AN, reg,
+				  QCA808X_LED_PATTERN_MASK);
+}
+
+static int qca808x_led_brightness_set(struct phy_device *phydev,
+				      u8 index, enum led_brightness value)
+{
+	u16 reg;
+	int ret;
+
+	if (index > 2)
+		return -EINVAL;
+
+	if (!value) {
+		ret = qca808x_led_hw_control_reset(phydev, index);
+		if (ret)
+			return ret;
+	}
+
+	reg = QCA808X_MMD7_LED_FORCE_CTRL(index);
+
+	return phy_modify_mmd(phydev, MDIO_MMD_AN, reg,
+			      QCA808X_LED_FORCE_MASK,
+			      value ? QCA808X_LED_FORCE_ON :
+				      QCA808X_LED_FORCE_OFF);
+}
+
+static int qca808x_led_blink_set(struct phy_device *phydev, u8 index,
+				 unsigned long *delay_on,
+				 unsigned long *delay_off)
+{
+	u16 reg;
+	int ret;
+
+	if (index > 2)
+		return -EINVAL;
+
+	reg = QCA808X_MMD7_LED_FORCE_CTRL(index);
+
+	ret = phy_modify_mmd(phydev, MDIO_MMD_AN, reg,
+			     QCA808X_LED_FORCE_MASK,
+			     QCA808X_LED_FORCE_BLINK_4HZ);
+	if (ret)
+		return ret;
+
+	/* We set blink to 4Hz, aka 250ms */
+	*delay_on = 250 / 2;
+	*delay_off = 250 / 2;
+
+	return 0;
+}
+
+static int qca808x_led_polarity_set(struct phy_device *phydev, int index,
+				    bool active_low)
+{
+	int ret;
+
+	/* Ignore calling LED polarity set for LED node */
+	if (index >= 0)
+		return 0;
+
+	if (active_low) {
+		ret = phy_clear_bits_mmd(phydev, MDIO_MMD_AN,
+					 QCA808X_MMD7_LED_POLARITY_CTRL,
+					 QCA808X_LED_ACTIVE_HIGH);
+	} else {
+		ret = phy_set_bits_mmd(phydev, MDIO_MMD_AN,
+				       QCA808X_MMD7_LED_POLARITY_CTRL,
+				       QCA808X_LED_ACTIVE_HIGH);
+	}
+
+	return ret;
+}
+
 static struct phy_driver at803x_driver[] = {
 {
 	/* Qualcomm Atheros AR8035 */
@@ -2304,6 +2579,12 @@ static struct phy_driver at803x_driver[] = {
 	.cable_test_start	= qca808x_cable_test_start,
 	.cable_test_get_status	= qca808x_cable_test_get_status,
 	.link_change_notify	= qca808x_link_change_notify,
+	.led_brightness_set	= qca808x_led_brightness_set,
+	.led_blink_set		= qca808x_led_blink_set,
+	.led_hw_is_supported	= qca808x_led_hw_is_supported,
+	.led_hw_control_set	= qca808x_led_hw_control_set,
+	.led_hw_control_get	= qca808x_led_hw_control_get,
+	.led_polarity_set	= qca808x_led_polarity_set,
 }, };
 
 module_phy_driver(at803x_driver);
-- 
2.40.1

