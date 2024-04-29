Return-Path: <linux-kernel+bounces-163165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A6A8B6696
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50EA91F21873
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE1B1A38F3;
	Mon, 29 Apr 2024 23:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bduqQ5a+"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FED19DF78
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714434044; cv=none; b=nXd1VM1rKwp2CnqUnKyDiKZ53kGZ18r4iZ/DLr6ejeCABCZZaJHdtlUgiQdtEsi3fo6LOh2GuDA3z8xTHSJed8LwurHXQyFraxQwGvUOOtJDDnj93Gg6xfvzXv/+KQ57cU7DebQKB43XvVl28wWjwoE3crM4QF1CwxpOnBRD1XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714434044; c=relaxed/simple;
	bh=4b44S3VIMtdkbxcMOARrPEB6+EsrH1npp+wwSXp0/Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RtoZpFTNXbYJk7rRCfJ8yvXXrgSkMM2JyPxAAoXQIpVH6dlLa5JhIWrJ8LLMpxauPfcem/S0754S/xvQJJwRNcYaDA8NUwQ8Vygo+apqyobiFNVL/uLSYrkaFX7rtUtlCAqNa2pc6wouW/IL+UprT68cT2jzad4cug/A7W6PUik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bduqQ5a+; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5aa362cc2ccso3592340eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714434040; x=1715038840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cubJgWS5pQ7P3B0LhmHJm/4bbMow1xJhT8KxVswt/M=;
        b=bduqQ5a+j6loGrmIgbI8tMn11NJphoFzKCIbBzmNfndnCaiQUMzWt+B0+ictA1WVtS
         GZxyBFLnXLCZeYn3MdZwLEkjs+vMX3yHnNMq5xp9flDqXYcoTnBKcH+OArn2ljmrKh1I
         ODn9jZUMfRGn6hIcCvoR9qN4dTVH185Lm1N+iNiuTr9S2BYPOb7BmjAsry94d4fxBkmi
         rhZbIzTGTOEkZ9c7SqI3THA24S9cfBUEU7Ha33/xcvos3s9ecDM6udVr8DwxZR8azH8w
         VKkBxWgAjars0jJdUyFR+bYmLQo1DZdHEpLjCQhU1V0afc730679HinA70Th/YfDgd9a
         1x0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714434040; x=1715038840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cubJgWS5pQ7P3B0LhmHJm/4bbMow1xJhT8KxVswt/M=;
        b=LaO7KDKce1AdLxDLmQph+odzArPkPwdJdbkxIAc5t5uEBNcsYLgJeqR5INQXAXtC6A
         6Qale1Ftl+B5Ox/QTwiDS+26Og/wHX+Gz/84Mq7rjGFEo0GPoRsHfb2MzunekzMD/ADq
         3PBtzCQKkr3vWsIdK5NcrO3m2IqKdzyxbIhOLW+J3mxZp4laEtn+N7w10RThVTDgBxWq
         T0i5AlydhAbKArAirvD+EAMv0glHzbUXOWIH9oCFGBRWyfah2OL+J/1jpdVrc0qXh40X
         LW2o3BwJyUSeFDzPuzlfNWIfpzE9qxm83XlIO8PpQKukralU0KXRA05jq37GdqlPRbuY
         gTBA==
X-Forwarded-Encrypted: i=1; AJvYcCXykIzd0Tv7LkNPrE0czy7V2u01o/QGgURaAq2cydv+XclgvbNn/g7Ay6ichJ2JZeVX1BbQA7SLRZwiVtpgHecikJxS6UeQiH4Nr+0C
X-Gm-Message-State: AOJu0Yzncqvsuo8mFeGj8Vyw1Zp63h001tgp9D6zteuo43MAmwZ9xp3O
	1u5nxFUylTkHw0cg33DQMAsPcCMmpd5Vc+OfGC2ri83a6Ks/E7PBQB9FkzHvb673VKfxlIoWTSn
	K
X-Google-Smtp-Source: AGHT+IF9FNXMJn6cCCuS5KH/ro7axiMukYHYUjRjs+0McXERXtUeYMZud/t0NDESAzUK3Kc/OnKC2Q==
X-Received: by 2002:a05:6870:8a0f:b0:23c:6020:6733 with SMTP id p15-20020a0568708a0f00b0023c60206733mr6514806oaq.27.1714434040496;
        Mon, 29 Apr 2024 16:40:40 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id hp22-20020a0568709a9600b0023b58aa20afsm2144508oab.25.2024.04.29.16.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 16:40:40 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Support Opensource <support.opensource@diasemi.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-input@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 6/7] staging: iio: impedance-analyzer: ad5933: Use devm_regulator_get_enable_read_voltage()
Date: Mon, 29 Apr 2024 18:40:14 -0500
Message-ID: <20240429-regulator-get-enable-get-votlage-v2-6-b1f11ab766c1@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240429-regulator-get-enable-get-votlage-v2-0-b1f11ab766c1@baylibre.com>
References: <20240429-regulator-get-enable-get-votlage-v2-0-b1f11ab766c1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

We can reduce boilerplate code by using
devm_regulator_get_enable_read_voltage().

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
* fixed wrong driver name in patch subject
* renamed to devm_regulator_get_enable_read_voltage()
* restored error message
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 26 ++-----------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 9149d41fe65b..b7af5fe63e09 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -84,7 +84,6 @@
 
 struct ad5933_state {
 	struct i2c_client		*client;
-	struct regulator		*reg;
 	struct clk			*mclk;
 	struct delayed_work		work;
 	struct mutex			lock; /* Protect sensor state */
@@ -660,13 +659,6 @@ static void ad5933_work(struct work_struct *work)
 	}
 }
 
-static void ad5933_reg_disable(void *data)
-{
-	struct ad5933_state *st = data;
-
-	regulator_disable(st->reg);
-}
-
 static int ad5933_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -685,23 +677,9 @@ static int ad5933_probe(struct i2c_client *client)
 
 	mutex_init(&st->lock);
 
-	st->reg = devm_regulator_get(&client->dev, "vdd");
-	if (IS_ERR(st->reg))
-		return PTR_ERR(st->reg);
-
-	ret = regulator_enable(st->reg);
-	if (ret) {
-		dev_err(&client->dev, "Failed to enable specified VDD supply\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&client->dev, ad5933_reg_disable, st);
-	if (ret)
-		return ret;
-
-	ret = regulator_get_voltage(st->reg);
+	ret = devm_regulator_get_enable_read_voltage(&client->dev, "vdd");
 	if (ret < 0)
-		return ret;
+		return dev_err_probe(&client->dev, ret, "failed to get vdd voltage\n");
 
 	st->vref_mv = ret / 1000;
 

-- 
2.43.2


