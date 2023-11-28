Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2975F7FB67C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjK1KAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343965AbjK1KAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:00:11 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0920AD41
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:00:17 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-332ca7f95e1so3660212f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1701165615; x=1701770415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KM+51/Ab8q9Ob1ygxdet2j1y8TyHO4eFE3VACdVz/qw=;
        b=DPmy9lQD8Oa8gozxHMssDF4akvL8spS8WhcoTdR1cXi/IbG1+0ra0JGQCzaN8hCmUA
         ypV7h25+dNieVZxrWHck5nMFM0Mce2BZ4hkUbp42MsT1FPagR01/z+5gEioByxw7NYFW
         YnP9tvr89pVV+gSQblrhEO3ckPk2mwgv8SojmHjXmTaGuoGWr4ncgXej2A1JmfO//a2Z
         acO4dBWGazMn6FfltV86MRAiaxcbzHM6OASRwGrYmV95UrK0xghrg7bbFAfFcwSh8Nkf
         aEJY8/9trkS3ErMakqIHhjR46415jiHPS502cgc/buo/aVzpNaKX44mDrhg421eIviue
         wRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701165615; x=1701770415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KM+51/Ab8q9Ob1ygxdet2j1y8TyHO4eFE3VACdVz/qw=;
        b=SLzFNsGqAl4o8/V1Xz0CwGirMFrZIUVWcc7yLCs6K9g3l1xAUmJFDPZF2KHgvhkM5y
         sXQdzoyAXnP4d9rxZO6sEIl23pusdMrPcXRA3ydLnqc0hpLAp4Vfjoie468gpPxf2p60
         8UNVUd//rUbcq7GYST9F3f/kbVeqVklIc+/Uz4LIHnlxjsipTjCAcljOn1RAa/hxOpxa
         28HOWWtrkelJxv25oW1tlP6paPty/vxj4x+jLPqCoNvY2k8TR/gD/WHO6z1iIRDX9SDr
         4778qMkCJ5EwdAMVn+eS0Ksc3RzsP5hnB6gRxaCzeeJGnlgmqALXmvEOSV91XMtRETYB
         5URA==
X-Gm-Message-State: AOJu0YyxBZmMbpKgMVoyksF8zYhfK5l5SwiFK50KEJ4HB+M1OHhd2j3h
        5zHl4+qiB3sL6qHaf+v/x2GzbA==
X-Google-Smtp-Source: AGHT+IGCxctw2ZM4M4swOO43u0BADO9IEzug1carEuaCnXRjujpSdATC0LQNJ2aDdBBmxFQivkVGZA==
X-Received: by 2002:a5d:4a4e:0:b0:332:e715:f0c3 with SMTP id v14-20020a5d4a4e000000b00332e715f0c3mr9596437wrs.60.1701165615169;
        Tue, 28 Nov 2023 02:00:15 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id m5-20020a5d56c5000000b00332cbd59f8bsm14437444wrw.25.2023.11.28.02.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 02:00:14 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     andi.shyti@kernel.org, robh@kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v5 2/2] i2c: muxes: pca954x: Enable features on MAX7357
Date:   Tue, 28 Nov 2023 10:00:08 +0000
Message-ID: <20231128100009.3727407-2-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Enable additional features based on DT settings and unconditionally
release the shared interrupt pin after 1.6 seconds and allow to use
it as reset.

These features aren't enabled by default and it's up to board designer
to validate for proper functioning and detection of devices in secondary
bus as sometimes it can cause secondary bus being disabled.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

---
Changes in V5:
- Fix typos
- Update comment
- Add newline in dev_warn
Changes in V4:
- Drop max7358
- Update #define
- Move conf variable
- Print warning when I2C_FUNC_SMBUS_WRITE_BYTE_DATA isn't supported
Changes in V3:
- Delete unused #define
- Update pca954x_init
- Update commit message
Changes in V2:
- Update comments
- Update check for DT properties
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 43 ++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 2219062104fb..f5dfc33b97c0 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -57,6 +57,20 @@
 
 #define PCA954X_IRQ_OFFSET 4
 
+/*
+ * MAX7357's configuration register is writeable after POR, but
+ * can be locked by setting the basic mode bit. MAX7358 configuration
+ * register is locked by default and needs to be unlocked first.
+ * The configuration register holds the following settings:
+ */
+#define MAX7357_CONF_INT_ENABLE			BIT(0)
+#define MAX7357_CONF_FLUSH_OUT			BIT(1)
+#define MAX7357_CONF_RELEASE_INT		BIT(2)
+#define MAX7357_CONF_DISCON_SINGLE_CHAN		BIT(4)
+#define MAX7357_CONF_PRECONNECT_TEST		BIT(7)
+
+#define MAX7357_POR_DEFAULT_CONF		MAX7357_CONF_INT_ENABLE
+
 enum pca_type {
 	max_7356,
 	max_7357,
@@ -470,7 +484,34 @@ static int pca954x_init(struct i2c_client *client, struct pca954x *data)
 	else
 		data->last_chan = 0; /* Disconnect multiplexer */
 
-	ret = i2c_smbus_write_byte(client, data->last_chan);
+	if (device_is_compatible(&client->dev, "maxim,max7357")) {
+		if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WRITE_BYTE_DATA)) {
+			u8 conf = MAX7357_POR_DEFAULT_CONF;
+			/*
+			 * The interrupt signal is shared with the reset pin. Release the
+			 * interrupt after 1.6 seconds to allow using the pin as reset.
+			 */
+			conf |= MAX7357_CONF_RELEASE_INT;
+
+			if (device_property_read_bool(&client->dev, "maxim,isolate-stuck-channel"))
+				conf |= MAX7357_CONF_DISCON_SINGLE_CHAN;
+			if (device_property_read_bool(&client->dev,
+						      "maxim,send-flush-out-sequence"))
+				conf |= MAX7357_CONF_FLUSH_OUT;
+			if (device_property_read_bool(&client->dev,
+						      "maxim,preconnection-wiggle-test-enable"))
+				conf |= MAX7357_CONF_PRECONNECT_TEST;
+
+			ret = i2c_smbus_write_byte_data(client, data->last_chan, conf);
+		} else {
+			dev_warn(&client->dev, "Write byte data not supported."
+				 "Cannot enable enhanced mode features\n");
+			ret = i2c_smbus_write_byte(client, data->last_chan);
+		}
+	} else {
+		ret = i2c_smbus_write_byte(client, data->last_chan);
+	}
+
 	if (ret < 0)
 		data->last_chan = 0;
 
-- 
2.41.0

