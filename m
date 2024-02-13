Return-Path: <linux-kernel+bounces-63667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C508532FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E16281E66
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A291658AA6;
	Tue, 13 Feb 2024 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="TP/yR7VR"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C55458222
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834157; cv=none; b=KZ5WLwYc4uSd4G7WDTlVR/7db+q5cnMWXV+tKc6R8Jp4Bc8Pu0ThWNTILgJSSoK5V9AtphN4EiyrBJgcrmJJHu5AHhZuH/N0AZhA0Yf4Ejf7tGVX5Oq0DSedpweUmPXfxDYyWJN/9sBmlRrzTUDYlVCWFRSR22VPZdhnZjZfSbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834157; c=relaxed/simple;
	bh=cGDhgb9JjmXcz1B7VT0bk/gyC+uEs/PtygXq4+otMW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mx9tB5TKypsDWfHEJxWY8QRnXgr0qNYLIu4p3S9JSOjRdg6ZRI+jF1oBm85r/7dbjynNlEzvN1MVZZAK/cczkRj8bRqOfHwy2mv135PA2gNQCso5jhdF6lF2vaA4YxTJC2SSoagU4LaSGioQNXYeNIvOcu02GbojQYu9KmJAMbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=TP/yR7VR; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a28a6cef709so596957366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1707834154; x=1708438954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCYSTKoBxU4qe92Ir9ZfO3GMV6uHY4MYfHL/wqf2edA=;
        b=TP/yR7VRXLPX0OG5HSbNrYzroOXb7VcjRpJDaRdrn9WIW/OUGhkdvYsI95ApApjX8l
         tUlKoi4/YCSAmMW+qe86UQTyY9TynLLj923Qzl0JL5QiznNdlv8YEv3sauq3EgPeJhlE
         MCMwwOP7eFLKFg8HKYD34hvDoA1SfOdn8fa8l0rEjSRBu0hZ2ZOQTuyofct24v81YNXC
         N1qYxTmqte1Vw6lJSucgipRSFi6am6F98gxUEA5fdT3EIvkDdks1iLo6/L7HKnqO7LIP
         tewCHKb01eiYaP1Ir3UnC0mHlxzhCRHyEq0BcZov3b+qFFXpiJ01agQQqWSHzfCqARJb
         gWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707834154; x=1708438954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCYSTKoBxU4qe92Ir9ZfO3GMV6uHY4MYfHL/wqf2edA=;
        b=vDqi3wK3ZqNiHQuKzYMwWUKY5xvDg43WMxGlkhYPMFrx8mzDz2yRmIFVt2xHEF9lI8
         e5A1NnfWqjOEyGM6NGCw6n4tY7pNWrSR/C5Nr5zm+XuNWJjuUMen9zCrTD6bNpacQ3AL
         8jIcr1+wqE3hBYu5YKCHSkCJpV0UEngs4XxsuiUCUJX7cBIfodTVQrJSE7SfrA36JAAX
         eoduzZK8Hjd5rc+/uTL0TQ6PWuwAX5Pr01oZtU1kOBV/mkDuD2igSD84RH7yF8DKcm5l
         4ADqZDuRYjh2bmhm5oGU7tCI1++ZfHwD2xXqbGWnswjovkNpHOKeN4YHRAKpwy1jezBY
         1Vgg==
X-Forwarded-Encrypted: i=1; AJvYcCUgf1BF8K0PmO/a+0vX2sBXPoxnBKmmmG0cX4HLo/THP5EQ8jGHMkaufsK3DaYgniCQoFipYkxHVHxUXioNMdAOMfiWHfzbGT0xkudZ
X-Gm-Message-State: AOJu0YzCCqz4mjWU1SZ+9YKK9SZDjaS2GoHJsMXCGwWuxfk5phQ+52h1
	f70SGJ2dA76Zbiz/QXMMrbzup2nF1JZxybCVWrlHwwWhQ9CsUYykpvZXaZj1x0f/b5bzd/JmjQE
	M
X-Google-Smtp-Source: AGHT+IHAm5yBpKrrKAQM0NVFE3L0ONc7OAUE4TZQLYXUEswIWkYHS4muNrhIi6ltgFhBibdGbdKPkg==
X-Received: by 2002:a17:906:8417:b0:a38:7541:36f6 with SMTP id n23-20020a170906841700b00a38754136f6mr7924946ejx.21.1707834154387;
        Tue, 13 Feb 2024 06:22:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW+2fap3g67K+xlSpRgqPTfNeRFPdzmmy/1Sx9FWajc48LBob+MvxXHOnI+Ei/e5oZegJo4x8nh8raGGIC4NyDVAx/TYdDm0DRRf/MIBxmzzQinnbYgCdihQfg11itAXNObnDMKWMSuRULKdzFPimF/I4XLscPtOntuY5iyXPD/3VYuNrAhtJgFBfUD7FNQj68SO6a8UkPfoyzmqyVewj1cCfsgkh+Ows8ZsjYy2jsw6TiVd6Yixmb9ZLRB
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id lu1-20020a170906fac100b00a3c97e49bc9sm1322671ejb.218.2024.02.13.06.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:22:33 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Peter Rosin <peda@axentia.se>
Cc: mazziesaccount@gmail.com,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] i2c: muxes: pca954x: Enable features on MAX7357
Date: Tue, 13 Feb 2024 19:52:27 +0530
Message-ID: <20240213142228.2146218-2-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240213142228.2146218-1-naresh.solanki@9elements.com>
References: <20240213142228.2146218-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Enable additional features based on DT settings and unconditionally
release the shared interrupt pin after 1.6 seconds and allow to use
it as reset.

These features aren't enabled by default and it's up to board designer
to validate for proper functioning and detection of devices in secondary
bus as sometimes it can cause secondary bus being disabled.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

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
2.42.0


