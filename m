Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD99478D8D0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbjH3SbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243859AbjH3L63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:58:29 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8131B0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 04:58:26 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-500a8b2b73eso8036121e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 04:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1693396705; x=1694001505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkHk2loL9NCqNiqGYQo3IA9z812u1ZOg7XOjk7HU8JU=;
        b=JJQqQbbICnk/RWUXTMPBWSQDIVKDLT4hbfpAHWxb8oVwVIYZsBkYbToOeVccWAB7sq
         EWWkDZ148GYVDxBeiwKfcli1oNMK39lJazCwJywpjj1oynfsAuqHJqH9VLkO9G1gBElQ
         1oSVWtVPWwFqjqNtG6s1Q4rbCDSoDuF1kuT98L1epITZk+PV6cGfzxqN0mrK4OWi+rvt
         wiseHic+glhiheSTE3ayPZYb3v4gE1sZHr0JBQR8C3UbpGNIV8qXumRFKf4DHHhMB6at
         aquLbVLXPNXaq0wvtWFBU8o4sqEpFh2JpsQaGYPZckd64UabZ8WVMXrXNMFUgv2o4b+E
         d8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693396705; x=1694001505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkHk2loL9NCqNiqGYQo3IA9z812u1ZOg7XOjk7HU8JU=;
        b=SKr6HdLX1Zy48sDcjM0TfUWEi0HEiGDiWtj743cl0oV1W+4bit/C0KiG6rhtrMGSWs
         0+K6hZPFgV3igyymzrZr5PIPNlN31K2KyLAqsY2NaG0h4HxBwDTupCOFC5v2hgHBpJmm
         i47G4Stg9EY6UaXcZgG6wG4QBk3oU8PX0NszkBwCWA91sKpyp9yrSkAvaw8a1EVdVBjw
         0C/RahOiWGcA9/5S6ctILIikK0AuCTAoAiWcAuJLo1JBPIkJvqmSTbR/JRomBbZecxx1
         YCHVK2IpyWk/SJDZ2p6xWNXPPrfnldke796vdpyeS4aLRFDagLUOCdSSMDu6G4FJfAqJ
         CSkA==
X-Gm-Message-State: AOJu0YyeeDP+uRRNcWSjnuY9PNP90fhVeHCDbiYVdmSFUlsntZ689WjH
        ZmWX700A1yAFMerbCWf1LWYIZg==
X-Google-Smtp-Source: AGHT+IFLaUbs5W43ZQ5OArheWLh5UIXhU8Ue0fD5xs9o+zwVEcgOHyPA0VLUxWvozqztFYinc1Lx1g==
X-Received: by 2002:a05:6512:2829:b0:4fd:b1f6:b6ca with SMTP id cf41-20020a056512282900b004fdb1f6b6camr1408368lfb.25.1693396704396;
        Wed, 30 Aug 2023 04:58:24 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id u8-20020aa7d888000000b00527e7087d5dsm6681571edq.15.2023.08.30.04.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 04:58:24 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] i2c: muxes: Enable features on MAX7357
Date:   Wed, 30 Aug 2023 13:57:43 +0200
Message-ID: <20230830115744.4102929-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830115744.4102929-1-Naresh.Solanki@9elements.com>
References: <20230830115744.4102929-1-Naresh.Solanki@9elements.com>
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

Detect that max7357 is being used and run custom init sequence.

By default MAX7357 disconnects all channels on a bus lock-up and
signals	this condition to the bus master using an interrupt.

Disable the interrupt as it's not useful within the kernel and
it might conflict with the reset functionality that shares the same
pin.

Use the introduced 'maxim,bus-lockup-fix' property to enable
faulty channel isolation and flush-out sequence generation.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 56 ++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 2219062104fb..0c1ff1438e7c 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -57,6 +57,21 @@
 
 #define PCA954X_IRQ_OFFSET 4
 
+/*
+ * MAX7357 exposes 7 registers on POR which allow to configure additional
+ * features. The configuration register holds the following settings:
+ */
+#define MAX7357_CONF_INT_ENABLE			BIT(0)
+#define MAX7357_CONF_FLUSH_OUT			BIT(1)
+#define MAX7357_CONF_RELEASE_INT		BIT(2)
+#define MAX7357_CONF_LOCK_UP_CLEAR		BIT(3)
+#define MAX7357_CONF_DISCON_SINGLE_CHAN		BIT(4)
+#define MAX7357_CONF_BUS_LOCKUP_DETECT_DIS	BIT(5)
+#define MAX7357_CONF_ENABLE_BASIC_MODE		BIT(6)
+#define MAX7357_CONF_PRECONNECT_TEST		BIT(7)
+
+#define MAX7357_POR_DEFAULT_CONF		BIT(0)
+
 enum pca_type {
 	max_7356,
 	max_7357,
@@ -477,6 +492,41 @@ static int pca954x_init(struct i2c_client *client, struct pca954x *data)
 	return ret;
 }
 
+static int max7357_init(struct i2c_client *client, struct pca954x *data)
+{
+	struct i2c_adapter *adap = client->adapter;
+	u8 conf = MAX7357_POR_DEFAULT_CONF;
+	int ret;
+
+	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
+		return pca954x_init(client, data);
+
+	if (data->idle_state >= 0)
+		data->last_chan = pca954x_regval(data, data->idle_state);
+	else
+		data->last_chan = 0; /* Disconnect multiplexer */
+
+	/*
+	 * The interrupt signals downstream channels that are stuck, but
+	 * there's nothing to do and it prevents using the shared pin as reset.
+	 */
+	conf &= MAX7357_CONF_INT_ENABLE;
+
+	/*
+	 * On bus lock-up isolate the failing channel and try to clear the
+	 * fault by sending the flush-out sequence.
+	 */
+	if (device_property_read_bool(&client->dev, "maxim,bus-lockup-fix"))
+		conf |= MAX7357_CONF_DISCON_SINGLE_CHAN |
+			MAX7357_CONF_FLUSH_OUT;
+
+	ret = i2c_smbus_write_byte_data(client, data->last_chan, conf);
+	if (ret < 0)
+		data->last_chan = 0;
+
+	return ret;
+}
+
 /*
  * I2C init/probing/exit functions
  */
@@ -560,7 +610,11 @@ static int pca954x_probe(struct i2c_client *client)
 	 * initializes the mux to a channel
 	 * or disconnected state.
 	 */
-	ret = pca954x_init(client, data);
+	if ((dev->of_node && of_device_is_compatible(dev->of_node, "maxim,max7357")) ||
+	    id->driver_data == max_7357)
+		ret = max7357_init(client, data);
+	else
+		ret = pca954x_init(client, data);
 	if (ret < 0) {
 		dev_warn(dev, "probe failed\n");
 		ret = -ENODEV;
-- 
2.41.0

