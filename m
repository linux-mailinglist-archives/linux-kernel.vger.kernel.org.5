Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B4176D7CD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 21:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbjHBTcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 15:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjHBTcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:32:13 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DF126BB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 12:32:11 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe167d4a18so2300055e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 12:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1691004730; x=1691609530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYt9Jjxnfumr5xXWagiHEc6kz+KL1UN3g0bRxIEi7bI=;
        b=BGGslXHtIQBHWYdVYrx5YGuUAjIzVNlro61Kvk419BDSKHCb/aats6mo74h6P/a85f
         3SZoZQTqPPTUs4bmq0Sn1hR7U0IVPJwVW9aRGX4hpGbGTTuynmECf06hUGjW1xyGP9Tt
         sYgT3Re/5bXqVTfTXv/jNwNaPmzsCLVRmI1Dc5p3qOuiAUzq3OxnXKpK9J/N9SxHQJ5E
         LK6+3RdwGoqa6+nHHEVHVJMmMBR1tkruhIe6vee2Wi668T1S/G4xHrdaDQ1RMjwrUVqR
         7PG1bEOjH6IUVDWakcoUMZ25p56W03pwW0adYRzVSLroTyWLpu3UPigHu6DOk5pdy6Rp
         BWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691004730; x=1691609530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYt9Jjxnfumr5xXWagiHEc6kz+KL1UN3g0bRxIEi7bI=;
        b=OD9x0qCeTC2/mbEMkW/SRfD4P48LhVIkEzCAdvVFp2bQ1AttEKI2wztej1S55eW5zw
         S7rX1c1J26iK1StB7Rd8lV1PDbnr7RBOPnE6NWZ278rBUbkxc5acVRbPbCP+p7TKr4O5
         3cQiCR8/B2FnEsH+gNMK5En0WoRsqq/qJbnx631i/PunlvMCTdquV558OiilUJHtZJt6
         nr/gynvtnOhLjfbTQkpDXjZj3oYcc1H2LK3bi1G9iaUiQJ6I2V72Y1fGy/08bBDBOvZu
         9nEEVUbXluyYXKwuQ6BT1XTj59ofDfYrN9ksnA6X0v8wevS5Bk6AC3sactW3+WtbJfIE
         ulaw==
X-Gm-Message-State: ABy/qLbL+HnXoYUwJahw6roVuByXMQlY61OZAActhNsIQo4YVcD6HR/X
        Z6EM2tB43AXajqJ5RTeY0mdWNA==
X-Google-Smtp-Source: APBJJlEvvBLgMV6oJ6BCOVfbLLmUZBXR9uqzdDEOFn/AV7mIi7vS8jJEIEFjX+kTsYrmGKS16dtpuw==
X-Received: by 2002:a7b:c3d2:0:b0:3fb:e054:903f with SMTP id t18-20020a7bc3d2000000b003fbe054903fmr6024825wmj.36.1691004730239;
        Wed, 02 Aug 2023 12:32:10 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d43d2000000b003177074f830sm19666773wrr.59.2023.08.02.12.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 12:32:09 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] hwmon: (pmbus/tda38640) Add workaround for bug in SVID mode
Date:   Wed,  2 Aug 2023 21:31:53 +0200
Message-ID: <20230802193155.2170935-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802193155.2170935-1-Naresh.Solanki@9elements.com>
References: <20230802193155.2170935-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

TDA38640 can operate in either PMBus mode or SVID mode.
In SVID mode, by design ENABLE pin is the only option for controlling
the output rail.

In scenarios that utilizes the chip in SVID mode with ENABLE pin either
grounded or tied to logic high & software control is desired then use
dt property 'infineon,en-svid-control' to enable the below workaround.

The workaround utilizes ENABLE pin polarity flipping to control
output rail.

If property 'infineon,en-svid-control' is specified then
determine if chip is in SVID mode by checking BIT15 of MTP memory offset
0x44 as described in the datasheet.

If chip is in SVID mode then apply the workaround by
1. Determine EN pin level
2. Maps BIT7 of OPERATION(01h) to EN_PIN_POLARITY(BIT1) of
   PB_ON_OFF_CONFIG.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
----
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
index 450b0273fb59..d3d987d0d7b6 100644
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
+	    of_property_read_bool(client->dev.of_node, "infineon,en-svid-control")) {
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

