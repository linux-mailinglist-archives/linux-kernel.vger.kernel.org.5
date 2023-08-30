Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E2978DA4B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjH3Sf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243286AbjH3Kgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:36:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2991B3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:36:32 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a21b6d105cso696514566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1693391791; x=1693996591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4gcF63fe1TKqOf9MhohsxK7SINhHLw9bxgMUJq7sfo=;
        b=XcebUdpkpREnKUrmXXeHno0wR/GKAU3Npq48IfeNOP5Td8HSdZBgN8AGOgrKh0sxWS
         RKqljFbJLVYyaa6z/A/El5gnuswvpAG7/PZuPPlljryLouELr3f2mtLTo8PX77QNGqdK
         fNWTkdHLoiL6LnZ6vwM8yD4MFKXrVcbxvPdToW3lTJIvSyGeEAp951NZQawYuTlh3rgX
         /qPWdIei3PxzSaQlLAARg5pZWkY+3ZBQ7Pu0lKao/WBk0mMHvVEZ1XKHYw7Ur7Tlp6RK
         tVfDz45eyqjAfOnlJ5bdb9C3Xk+3CocDwdcPyaOBBKRUVZQBa5i039m9EBoq96FFkW7G
         HMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693391791; x=1693996591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4gcF63fe1TKqOf9MhohsxK7SINhHLw9bxgMUJq7sfo=;
        b=PUJGoLSJIdNGoPx0HuBbrSonEstyaD6/e76NkQFGB6tMd28P6OGNUPH/gzF8Xg04Z6
         LRrR4qE9RqX/HFW99Lde6N2KCflh5WgMfDf2apw2AYsbfbQOHNHGwXENrG1ITeGZNUie
         cqdawdLcLxoVDTlcdpWJ0NI00wHpts0Vi7g1rraQ25lNbdnx71Tp/vf3BVgUj7hwQ2Wr
         EkolPqdstNEvlWT1NPOgL6ye+/H+3hUGUO6khaLe/HfmG4rH/IWT9enqdHlXPW5hmyT8
         17pQnHCvSG5+bB71t5BfS/mneie+JGl//Ep23g3KWqcSUDUb/VMBcMeGVg54IUug00Ro
         oe7A==
X-Gm-Message-State: AOJu0YxU631Po0lsLYC08Lb5NRm91Tak2uEouZIKyt3zUkwva0J8/32u
        zkiq6Lu4aq2Eu9H53L9gWqtORA==
X-Google-Smtp-Source: AGHT+IF76+9hldlskjqC7pLsmnE2/a2NSFWqx+2nnc0wgV0yGIxasR7Jf3rNt3XO8xSKL8J7ufT+Qg==
X-Received: by 2002:a17:906:7683:b0:9a5:d657:47ec with SMTP id o3-20020a170906768300b009a5d65747ecmr1217086ejm.64.1693391790963;
        Wed, 30 Aug 2023 03:36:30 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id s11-20020a170906354b00b00992bea2e9d2sm7027620eja.62.2023.08.30.03.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 03:36:30 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] hwmon: (pmbus/tda38640) Add workaround for SVID mode
Date:   Wed, 30 Aug 2023 12:36:18 +0200
Message-ID: <20230830103620.3611761-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830103620.3611761-1-Naresh.Solanki@9elements.com>
References: <20230830103620.3611761-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

TDA38640 can operate in either PMBus mode or SVID mode.

In SVID mode, by design ENABLE pin is the only option for controlling
the output rail i.e., ENABLE pin is chained to power good of another
reglator & FPGA.

In cases where the chip is configured for SVID mode, and the ENABLE pin
is set at a fixed level or is left unconnected (with an internal
pull-down), while requiring software control, the following
workaround is necessary.

The workaround utilizes ENABLE pin polarity flipping to control
output rail.

If property 'infineon,en-pin-fixed-level' is specified then
determine if chip is in SVID mode by checking BIT15 of MTP memory offset
0x44 as described in the datasheet.

If chip is in SVID mode then apply the workaround by
1. Determine EN pin level
2. Maps BIT7 of OPERATION(01h) to EN_PIN_POLARITY(BIT1) of
   PB_ON_OFF_CONFIG.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
----
Changes in V4:
- Update DT property name
- Commit message update
Changes in V3:
- Use dt property to determine if workaround is needed.
Changes in V2:
- Remove dependency on DT propery,
- Runtime determine SVID mode & ENABLE pin level,
- Update commit message.
---
 drivers/hwmon/pmbus/tda38640.c | 154 ++++++++++++++++++++++++++++++++-
 1 file changed, 152 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/tda38640.c b/drivers/hwmon/pmbus/tda38640.c
index 450b0273fb59..c238330d2e6c 100644
--- a/drivers/hwmon/pmbus/tda38640.c
+++ b/drivers/hwmon/pmbus/tda38640.c
@@ -18,6 +18,127 @@ static const struct regulator_desc __maybe_unused tda38640_reg_desc[] = {
 	PMBUS_REGULATOR("vout", 0),
 };
 
+struct tda38640_data {
+	struct pmbus_driver_info info;
+	u32 en_pin_lvl;
+};
+
+#define to_tda38640_data(x)  container_of(x, struct tda38640_data, info)
+
+/*
+ * Map PB_ON_OFF_CONFIG_POLARITY_HIGH to PB_OPERATION_CONTROL_ON.
+ */
+static int tda38640_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct tda38640_data *data = to_tda38640_data(info);
+	int ret, on_off_config, enabled;
+
+	if (reg != PMBUS_OPERATION)
+		return -ENODATA;
+
+	ret = pmbus_read_byte_data(client, page, reg);
+	if (ret < 0)
+		return ret;
+
+	on_off_config = pmbus_read_byte_data(client, page,
+					     PMBUS_ON_OFF_CONFIG);
+	if (on_off_config < 0)
+		return on_off_config;
+
+	enabled = !!(on_off_config & PB_ON_OFF_CONFIG_POLARITY_HIGH);
+
+	enabled ^= data->en_pin_lvl;
+	if (enabled)
+		ret &= ~PB_OPERATION_CONTROL_ON;
+	else
+		ret |= PB_OPERATION_CONTROL_ON;
+
+	return ret;
+}
+
+/*
+ * Map PB_OPERATION_CONTROL_ON to PB_ON_OFF_CONFIG_POLARITY_HIGH.
+ */
+static int tda38640_write_byte_data(struct i2c_client *client, int page,
+				    int reg, u8 byte)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct tda38640_data *data = to_tda38640_data(info);
+	int enable, ret;
+
+	if (reg != PMBUS_OPERATION)
+		return -ENODATA;
+
+	enable = !!(byte & PB_OPERATION_CONTROL_ON);
+
+	byte &= ~PB_OPERATION_CONTROL_ON;
+	ret = pmbus_write_byte_data(client, page, reg, byte);
+	if (ret < 0)
+		return ret;
+
+	enable ^= data->en_pin_lvl;
+
+	return pmbus_update_byte_data(client, page, PMBUS_ON_OFF_CONFIG,
+				      PB_ON_OFF_CONFIG_POLARITY_HIGH,
+				      enable ? 0 : PB_ON_OFF_CONFIG_POLARITY_HIGH);
+}
+
+static int svid_mode(struct i2c_client *client, struct tda38640_data *data)
+{
+	/* PMBUS_MFR_READ(0xD0) + MTP Address offset */
+	u8 write_buf[] = {0xd0, 0x44, 0x00};
+	u8 read_buf[2];
+	int ret, svid;
+	bool off, reg_en_pin_pol;
+
+	struct i2c_msg msgs[2] = {
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.buf = write_buf,
+			.len = sizeof(write_buf),
+		},
+		{
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.buf = read_buf,
+			.len = sizeof(read_buf),
+		}
+	};
+
+	ret = i2c_transfer(client->adapter, msgs, 2);
+	if (ret < 0) {
+		dev_err(&client->dev, "i2c_transfer failed. %d", ret);
+		return ret;
+	}
+
+	/*
+	 * 0x44[15] determines PMBus Operating Mode
+	 * If bit is set then it is SVID mode.
+	 */
+	svid = !!(read_buf[1] & BIT(7));
+
+	/*
+	 * Determine EN pin level for use in SVID mode.
+	 * This is done with help of STATUS_BYTE bit 6(OFF) & ON_OFF_CONFIG bit 2(EN pin polarity).
+	 */
+	if (svid) {
+		ret = i2c_smbus_read_byte_data(client, PMBUS_STATUS_BYTE);
+		if (ret < 0)
+			return ret;
+		off = !!(ret & PB_STATUS_OFF);
+
+		ret = i2c_smbus_read_byte_data(client, PMBUS_ON_OFF_CONFIG);
+		if (ret < 0)
+			return ret;
+		reg_en_pin_pol = !!(ret & PB_ON_OFF_CONFIG_POLARITY_HIGH);
+		data->en_pin_lvl = off ^ reg_en_pin_pol;
+	}
+
+	return svid;
+}
+
 static struct pmbus_driver_info tda38640_info = {
 	.pages = 1,
 	.format[PSC_VOLTAGE_IN] = linear,
@@ -26,7 +147,6 @@ static struct pmbus_driver_info tda38640_info = {
 	.format[PSC_CURRENT_IN] = linear,
 	.format[PSC_POWER] = linear,
 	.format[PSC_TEMPERATURE] = linear,
-
 	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
 	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
 	    | PMBUS_HAVE_IIN
@@ -41,7 +161,37 @@ static struct pmbus_driver_info tda38640_info = {
 
 static int tda38640_probe(struct i2c_client *client)
 {
-	return pmbus_do_probe(client, &tda38640_info);
+	struct tda38640_data *data;
+	int svid;
+
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	memcpy(&data->info, &tda38640_info, sizeof(tda38640_info));
+
+	if (IS_ENABLED(CONFIG_SENSORS_TDA38640_REGULATOR) && \
+	    of_property_read_bool(client->dev.of_node, "infineon,en-pin-fixed-level")) {
+		svid = svid_mode(client, data);
+		if (svid < 0) {
+			dev_err_probe(&client->dev, svid, "Could not determine operating mode.");
+			return svid;
+		}
+
+		/*
+		 * Apply ON_OFF_CONFIG workaround as enabling the regulator using the
+		 * OPERATION register doesn't work in SVID mode.
+		 *
+		 * One should configure PMBUS_ON_OFF_CONFIG here, but
+		 * PB_ON_OFF_CONFIG_POWERUP_CONTROL and PB_ON_OFF_CONFIG_EN_PIN_REQ
+		 * are ignored by the device.
+		 * Only PB_ON_OFF_CONFIG_POLARITY_HIGH has an effect.
+		 */
+		if (svid) {
+			data->info.read_byte_data = tda38640_read_byte_data;
+			data->info.write_byte_data = tda38640_write_byte_data;
+		}
+	}
+	return pmbus_do_probe(client, &data->info);
 }
 
 static const struct i2c_device_id tda38640_id[] = {
-- 
2.41.0

