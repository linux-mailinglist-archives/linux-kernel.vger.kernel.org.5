Return-Path: <linux-kernel+bounces-122162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DAA88F2F1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCEA51F29E40
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7F615688B;
	Wed, 27 Mar 2024 23:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AZe/5H+P"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EE91552E2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711581553; cv=none; b=OkfIN9c6paO2+A+zIortI4kcUSWbu9CYCnrx1FSv52PxfZps7OzH9I2KpyAgELD46uNfvWzRhwfFVZhEL7tWxPU0K5dznMQLaDwB/kHj/xRFD/ytKOagnDS6ir/LdK3Bxr78XcM55xR13NlgYs1yQLGgNF4r3CCUO9LAjeQJbz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711581553; c=relaxed/simple;
	bh=xlOFHnY+VUAHimj0/6CI3uzJ6CONg5CROD3tFFJ2TF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rP6Tv3YMTA/9tXdFC781T3mjnk/Wclm32jgm7inJZ3wY9qLnAj+aW5TydohA4rKmqLpMpfII/+n2Udt5p0buSFkllOD3xXCx2KIDTP/XAmYUQLI+BeKl6ldpIjnlsyL1RDGVCh5ivyD/08DQ3Z3ZP7orQHYoiRhkiRax0RlZ4SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AZe/5H+P; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-22215ccbafeso260714fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711581549; x=1712186349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBx5yqCcIG/deXybWASqoKrfUt47GVVbdT7E/yXEMkE=;
        b=AZe/5H+Pjy5tCOeoAALOzNVLm6n1Q05iv9SH37MheVT1+g0TMz85zs6kL0vLUX5hRI
         gkaVoES9vc1z7jptM736If8A1nvpdcEZJb3ylbLRrEBcGud7KoJoDk6rPvt61ysRhnKb
         bKczNZLbrIb07MnkGyjqTJB7Q5+iT+PAxDnNA/AYFSNU8P8CR7Kkkwnn7y3eG9VoyJbZ
         Z1FzV9DRwmCFD+ccxbCVFv6cxwpJz6Cvl5PqQLZS3ch5H7fQm2jzuTTS1ylPJXX9BKTH
         qCwFjwoPgkRFzZS23CN9bn5BfO5lXQrGT0gyO94Lll+G1k3THkzdh0dGAFF6QxnGMKTz
         Og/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711581549; x=1712186349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBx5yqCcIG/deXybWASqoKrfUt47GVVbdT7E/yXEMkE=;
        b=GciV0eZdRSiJ6nzas43QpkneXjOAqHCfimg1OaojBtxxwQDjrCHvDtxR3Zbfrl9o7y
         7VNREWrfD7rjlVuwqEkfNQ8o/cyDbUZrZgnzMOyPPuFeYV4lPpCuOOaVxNMfcRM6AHzc
         s93NISfufVayF8wAUDyvYb51tpfwwqix88urgWZfsViPvBs55MYplvsR/VZwZhWSew52
         t/m0JKUp4WuSZ31yZh6TpmWYwD5DVQpibn2TItIgjIBz3Sidtt5rXT+El+Rj8izL+O3w
         WfKVagLeLMO9edkuKdRJnZ+tqwbyieS0YQ6LRyAgkMH1ta6TcUA+QDDZzbhl+9/kdMji
         lr8w==
X-Forwarded-Encrypted: i=1; AJvYcCW+LfPgzka66pov5XdB/4skvf0UV0dtr7R9eKWq5pRbLh2AsGyJQJa5bRyb7TzvF1pR94r1k+8UZdAIu4VBkVVcOaIPV++dUBNMWd5C
X-Gm-Message-State: AOJu0Yzr9RuaHcxu5IPv/z+fA6X+7kZe+BqGjSOXZanvagGrVEiRzNnP
	IEtw6+5FKPlO2dT8UKu06k0Fxi5ZkOteLGrm+i8tUtLUQUQHuGvGkYG+N3TzSxc=
X-Google-Smtp-Source: AGHT+IFXU8zmzWmrbkxOxvW7wtT9Hq/b5rbtfGnHI6ZuQs2D4otmJCIrbq7hVTyLaL9P54g4uvOwbQ==
X-Received: by 2002:a05:6870:b14b:b0:229:fa5a:2fec with SMTP id a11-20020a056870b14b00b00229fa5a2fecmr1265617oal.54.1711581549199;
        Wed, 27 Mar 2024 16:19:09 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id js3-20020a056870bac300b0022a0519183csm81381oab.2.2024.03.27.16.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 16:19:08 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Support Opensource <support.opensource@diasemi.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-input@vger.kernel.org
Subject: [PATCH RFC 6/7] staging: iio: impedance-analyzer: admv1013: Use devm_regulator_get_enable_get_voltage()
Date: Wed, 27 Mar 2024 18:18:55 -0500
Message-ID: <20240327-regulator-get-enable-get-votlage-v1-6-5f4517faa059@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240327-regulator-get-enable-get-votlage-v1-0-5f4517faa059@baylibre.com>
References: <20240327-regulator-get-enable-get-votlage-v1-0-5f4517faa059@baylibre.com>
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
devm_regulator_get_enable_get_voltage().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 9149d41fe65b..e4942833b793 100644
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
@@ -685,21 +677,7 @@ static int ad5933_probe(struct i2c_client *client)
 
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
+	ret = devm_regulator_get_enable_get_voltage(&client->dev, "vdd");
 	if (ret < 0)
 		return ret;
 

-- 
2.43.2


