Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E006765A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjG0RTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjG0RTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:19:04 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A0E128
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:18:45 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686f1240a22so985994b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690478324; x=1691083124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktpWtMwT9dpeC33OUaPHH6/Z5MIjVDj91Q86MN6Mk68=;
        b=e6DcIHEEnnX3iIOWGLqJ7y9zqMALlfXD5b2RWvBK62PzvT1+HUn4sLyb1zwNNYmEv0
         FcT63N8JPGM1eTXDVZt2Hr8pIf9AGYh7ZwpqJOGANz8WWDL8DzJFqgNsAarfmhvMb/xp
         2ytjgoAe177xfFghUbeJWiyjBs/6yiKjoWV+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690478324; x=1691083124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktpWtMwT9dpeC33OUaPHH6/Z5MIjVDj91Q86MN6Mk68=;
        b=kofLPe/FrmxgbPsQ+/Wz2Af3YPfoZXy3bA3linX4bocECexhl+6dLBrwywOMr4bCCE
         tbKFHfE6mAAdOc/h7QT+bKxsArfKTuEavG39V7tpiWfozjcVIjgAqrYLNla3hmKug0qY
         wf73ikOgnGHwmlpUhCUp6JTKCm660g7skplJ8FT7caVfhP+AIwp8Xi3CE0JabLhDzWEg
         7Y1ag8Mw48SOaOiQKYHw4gFF0PE4d8+C6BKnMr8YIpvJ7Ha/knuqlHin0IQgv1aAjFFp
         E8LHrlwszHYzYu2KN3wdftWhpNLFphECK5A4e7QgAWHvuWY/xdcwRm8valFigqqpiICZ
         Hw3A==
X-Gm-Message-State: ABy/qLbzIwkeLlYNr/hiTvpJMMPvDSY2aIdS8yNDqqbCiSBjJ3x8rot7
        qjZKUY+/HMZO92A1kFURaxWVgg==
X-Google-Smtp-Source: APBJJlFI4ulREcnYhiYEqiypn/CcfSaWl2pU5xhKDO414/TYYGi809LpHmTqvUM3kKTBTycyzjKtEA==
X-Received: by 2002:a05:6a20:410:b0:12c:c614:f55 with SMTP id a16-20020a056a20041000b0012cc6140f55mr4946150pza.43.1690478324616;
        Thu, 27 Jul 2023 10:18:44 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:2339:954b:b98f:611a])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79111000000b0064f76992905sm1702524pfh.202.2023.07.27.10.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 10:18:44 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-arm-msm@vger.kernel.org,
        yangcong5@huaqin.corp-partner.google.com,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        hsinyi@google.com, Chris Morgan <macroalpha82@gmail.com>,
        linux-input@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v4 06/11] HID: i2c-hid: Rearrange probe() to power things up later
Date:   Thu, 27 Jul 2023 10:16:33 -0700
Message-ID: <20230727101636.v4.6.Ifcc9b0a44895d164788966f9b9511fe094ca8cf9@changeid>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230727171750.633410-1-dianders@chromium.org>
References: <20230727171750.633410-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a future patch, we want to change i2c-hid not to necessarily power
up the touchscreen during probe. In preparation for that, rearrange
the probe function so that we put as much stuff _before_ powering up
the device as possible.

This change is expected to have no functional effect.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- i2c_hid_core_initial_power_up() is now static.

 drivers/hid/i2c-hid/i2c-hid-core.c | 124 ++++++++++++++++++-----------
 1 file changed, 77 insertions(+), 47 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 19d985c20a5c..d29e6421ecba 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -855,7 +855,8 @@ static int i2c_hid_init_irq(struct i2c_client *client)
 		irqflags = IRQF_TRIGGER_LOW;
 
 	ret = request_threaded_irq(client->irq, NULL, i2c_hid_irq,
-				   irqflags | IRQF_ONESHOT, client->name, ihid);
+				   irqflags | IRQF_ONESHOT | IRQF_NO_AUTOEN,
+				   client->name, ihid);
 	if (ret < 0) {
 		dev_warn(&client->dev,
 			"Could not register for %s interrupt, irq = %d,"
@@ -940,6 +941,72 @@ static void i2c_hid_core_shutdown_tail(struct i2c_hid *ihid)
 	ihid->ops->shutdown_tail(ihid->ops);
 }
 
+/**
+ * i2c_hid_core_initial_power_up() - First time power up of the i2c-hid device.
+ * @ihid: The ihid object created during probe.
+ *
+ * This function is called at probe time.
+ *
+ * The initial power on is where we do some basic validation that the device
+ * exists, where we fetch the HID descriptor, and where we create the actual
+ * HID devices.
+ *
+ * Return: 0 or error code.
+ */
+static int i2c_hid_core_initial_power_up(struct i2c_hid *ihid)
+{
+	struct i2c_client *client = ihid->client;
+	struct hid_device *hid = ihid->hid;
+	int ret;
+
+	ret = i2c_hid_core_power_up(ihid);
+	if (ret)
+		return ret;
+
+	/* Make sure there is something at this address */
+	ret = i2c_smbus_read_byte(client);
+	if (ret < 0) {
+		i2c_hid_dbg(ihid, "nothing at this address: %d\n", ret);
+		ret = -ENXIO;
+		goto err;
+	}
+
+	ret = i2c_hid_fetch_hid_descriptor(ihid);
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"Failed to fetch the HID Descriptor\n");
+		goto err;
+	}
+
+	enable_irq(client->irq);
+
+	hid->version = le16_to_cpu(ihid->hdesc.bcdVersion);
+	hid->vendor = le16_to_cpu(ihid->hdesc.wVendorID);
+	hid->product = le16_to_cpu(ihid->hdesc.wProductID);
+
+	hid->initial_quirks |= i2c_hid_get_dmi_quirks(hid->vendor,
+						      hid->product);
+
+	snprintf(hid->name, sizeof(hid->name), "%s %04X:%04X",
+		 client->name, (u16)hid->vendor, (u16)hid->product);
+	strscpy(hid->phys, dev_name(&client->dev), sizeof(hid->phys));
+
+	ihid->quirks = i2c_hid_lookup_quirk(hid->vendor, hid->product);
+
+	ret = hid_add_device(hid);
+	if (ret) {
+		if (ret != -ENODEV)
+			hid_err(client, "can't add hid device: %d\n", ret);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	i2c_hid_core_power_down(ihid);
+	return ret;
+}
+
 int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
 		       u16 hid_descriptor_address, u32 quirks)
 {
@@ -966,16 +1033,10 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
 	if (!ihid)
 		return -ENOMEM;
 
-	ihid->ops = ops;
-
-	ret = i2c_hid_core_power_up(ihid);
-	if (ret)
-		return ret;
-
 	i2c_set_clientdata(client, ihid);
 
+	ihid->ops = ops;
 	ihid->client = client;
-
 	ihid->wHIDDescRegister = cpu_to_le16(hid_descriptor_address);
 
 	init_waitqueue_head(&ihid->wait);
@@ -986,28 +1047,12 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
 	 * real computation later. */
 	ret = i2c_hid_alloc_buffers(ihid, HID_MIN_BUFFER_SIZE);
 	if (ret < 0)
-		goto err_powered;
-
+		return ret;
 	device_enable_async_suspend(&client->dev);
 
-	/* Make sure there is something at this address */
-	ret = i2c_smbus_read_byte(client);
-	if (ret < 0) {
-		i2c_hid_dbg(ihid, "nothing at this address: %d\n", ret);
-		ret = -ENXIO;
-		goto err_powered;
-	}
-
-	ret = i2c_hid_fetch_hid_descriptor(ihid);
-	if (ret < 0) {
-		dev_err(&client->dev,
-			"Failed to fetch the HID Descriptor\n");
-		goto err_powered;
-	}
-
 	ret = i2c_hid_init_irq(client);
 	if (ret < 0)
-		goto err_powered;
+		goto err_buffers_allocated;
 
 	hid = hid_allocate_device();
 	if (IS_ERR(hid)) {
@@ -1021,26 +1066,11 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
 	hid->ll_driver = &i2c_hid_ll_driver;
 	hid->dev.parent = &client->dev;
 	hid->bus = BUS_I2C;
-	hid->version = le16_to_cpu(ihid->hdesc.bcdVersion);
-	hid->vendor = le16_to_cpu(ihid->hdesc.wVendorID);
-	hid->product = le16_to_cpu(ihid->hdesc.wProductID);
-
 	hid->initial_quirks = quirks;
-	hid->initial_quirks |= i2c_hid_get_dmi_quirks(hid->vendor,
-						      hid->product);
-
-	snprintf(hid->name, sizeof(hid->name), "%s %04X:%04X",
-		 client->name, (u16)hid->vendor, (u16)hid->product);
-	strscpy(hid->phys, dev_name(&client->dev), sizeof(hid->phys));
-
-	ihid->quirks = i2c_hid_lookup_quirk(hid->vendor, hid->product);
 
-	ret = hid_add_device(hid);
-	if (ret) {
-		if (ret != -ENODEV)
-			hid_err(client, "can't add hid device: %d\n", ret);
+	ret = i2c_hid_core_initial_power_up(ihid);
+	if (ret)
 		goto err_mem_free;
-	}
 
 	return 0;
 
@@ -1050,9 +1080,9 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
 err_irq:
 	free_irq(client->irq, ihid);
 
-err_powered:
-	i2c_hid_core_power_down(ihid);
+err_buffers_allocated:
 	i2c_hid_free_buffers(ihid);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(i2c_hid_core_probe);
@@ -1062,6 +1092,8 @@ void i2c_hid_core_remove(struct i2c_client *client)
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	struct hid_device *hid;
 
+	i2c_hid_core_power_down(ihid);
+
 	hid = ihid->hid;
 	hid_destroy_device(hid);
 
@@ -1069,8 +1101,6 @@ void i2c_hid_core_remove(struct i2c_client *client)
 
 	if (ihid->bufsize)
 		i2c_hid_free_buffers(ihid);
-
-	i2c_hid_core_power_down(ihid);
 }
 EXPORT_SYMBOL_GPL(i2c_hid_core_remove);
 
-- 
2.41.0.487.g6d72f3e995-goog

