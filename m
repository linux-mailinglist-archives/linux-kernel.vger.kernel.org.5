Return-Path: <linux-kernel+bounces-122160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE5288F2E8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F44F1C2B23C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132CC15666B;
	Wed, 27 Mar 2024 23:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3MBuSFOf"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DF8154C05
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711581550; cv=none; b=AYNFIK2e2CWjpez4GefqJhhdCMRZnIkAiSnEN7VW8N9NNi/ReHfuVvVMIkHwUHsfy3kV0ips2toeQLGLVtkFw6st/w8qzHel2qCizcmqFSFkBVxbBAZlMY5dzbY7wEAAFEQs+aLhhtuKaZ1ZXxGUqckG5vckLkUPRvjUmZH1ZtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711581550; c=relaxed/simple;
	bh=m3bHOTwCtpGjb4KTDA27x15GCtpMS/P661zbUhfKKAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFvrrQdVtAR0CJAlD/vf/8DUWhlKMkU4LWxhpeNsk/dT0rw5rtfUG248HO4Mac/flZ9GzFhZzKSwBgdKH7eTgavZZ16Tp8v8zSuHujb0m+DZAnL6sDhkh74t3+MMsLF5RsfJG8DiVWLXzsbZY4+mRTBrvyJV53snxVPAeM2RA4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3MBuSFOf; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-229cbc52318so225204fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711581547; x=1712186347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hg1dHpRYZjEho4rhJz+qSTgS0nJB4BPNbR6dsgqeqo=;
        b=3MBuSFOfpS+fPoYdwlmYLFjL8VMaVgYuenjL9Tlox/H3N8RxgoDSy3BZYC3zMKtl+1
         RxtIb8FoS/c/4EiMMEmT4W5gZR79EzGFeQx7l/VYH00fQCeNObyjUY4IefVVL8xefach
         x4ityzMfV/spe6lcmtLxicztH/cJi+pbgxB0MadC7xuVdvyw9zl3ffCQb4wy/frTO4ql
         mRErsQAfWYe0D5uprmJO4RLhd83rmzbXnRehMp+LiEqeow6xyKMnNhNwUOgW+xZ1FV1U
         0wSL5TC+B4308ishEAtcpfIiK6ffMhuwOKwwluK4hvjRUKMGrjsSjJKlHSUdCtOiKtY9
         7n1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711581547; x=1712186347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5hg1dHpRYZjEho4rhJz+qSTgS0nJB4BPNbR6dsgqeqo=;
        b=d/kMvr9ZPLOPPNt1+uiMYU8JZloV6BiDnE22FOSZWJ/Cj2xiP64iEImCMDXvLyPXwf
         EDKPcb4QbnxZSVA6wM421ZNSTYeqYE4fi2cUAF0KMy1ZTCqyJaRtvwWXP6mB2k/g7cWu
         0NZ+mZ2Ysm38GuCHgNEDGrl0A7FcIDC/wWhysKdMQWOthjK77aye0UQljfuKQWfDAWqz
         bE6QYXsYBohpxz5smtWLNXyLwIzNRx+agnKg6F/CNbdZ1ibKzgolgyRZlSCW3n/Lltcs
         oEj4UdlAV9YoowY2pAD7GpsLpMiLfLzVgmOkIEnOb6lq8231vv7gRNxNlAJnoPEkqFMJ
         aXRg==
X-Forwarded-Encrypted: i=1; AJvYcCW7vQruidWay/NcqQvYqFeUDFSrqsgLW+VwJjXon/N7rNCguFlW0hjfOhFYjAJeJhwWLYlZGpWDlzFzrLSoGlhOKn8Z+q+MiJ12IU3l
X-Gm-Message-State: AOJu0Yxp2Zk4DP3W61/U1hbzVsANpPBNeaAJMpFHW7+QRR7snFBIHs1B
	/3rcERY+HwToN7IBKB96t4naEsHn3C4DkmdIJ2f9xW4UIpuHGlxEadYZfX4bDPk=
X-Google-Smtp-Source: AGHT+IHk3eSdmsSABjkDyaK0jauAUum2pB/dkonw6qcHUydV0+mxlwiPUnWMWCTRhHhYGOh0khoS/A==
X-Received: by 2002:a05:6870:5cc4:b0:222:63e2:aba3 with SMTP id et4-20020a0568705cc400b0022263e2aba3mr1314518oab.8.1711581547039;
        Wed, 27 Mar 2024 16:19:07 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id js3-20020a056870bac300b0022a0519183csm81381oab.2.2024.03.27.16.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 16:19:06 -0700 (PDT)
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
Subject: [PATCH RFC 4/7] iio: addac: ad74115: Use devm_regulator_get_enable_get_voltage()
Date: Wed, 27 Mar 2024 18:18:53 -0500
Message-ID: <20240327-regulator-get-enable-get-votlage-v1-4-5f4517faa059@baylibre.com>
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
 drivers/iio/addac/ad74115.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
index e6bc5eb3788d..01073d7de6aa 100644
--- a/drivers/iio/addac/ad74115.c
+++ b/drivers/iio/addac/ad74115.c
@@ -199,7 +199,6 @@ struct ad74115_state {
 	struct spi_device		*spi;
 	struct regmap			*regmap;
 	struct iio_trigger		*trig;
-	struct regulator		*avdd;
 
 	/*
 	 * Synchronize consecutive operations when doing a one-shot
@@ -1672,14 +1671,6 @@ static int ad74115_setup(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	if (val == AD74115_DIN_THRESHOLD_MODE_AVDD) {
-		ret = regulator_get_voltage(st->avdd);
-		if (ret < 0)
-			return ret;
-
-		st->avdd_mv = ret / 1000;
-	}
-
 	st->din_threshold_mode = val;
 
 	ret = ad74115_apply_fw_prop(st, &ad74115_dac_bipolar_fw_prop, &val);
@@ -1788,11 +1779,6 @@ static int ad74115_reset(struct ad74115_state *st)
 	return 0;
 }
 
-static void ad74115_regulator_disable(void *data)
-{
-	regulator_disable(data);
-}
-
 static int ad74115_setup_trigger(struct iio_dev *indio_dev)
 {
 	struct ad74115_state *st = iio_priv(indio_dev);
@@ -1855,19 +1841,11 @@ static int ad74115_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad74115_info;
 
-	st->avdd = devm_regulator_get(dev, "avdd");
-	if (IS_ERR(st->avdd))
-		return PTR_ERR(st->avdd);
-
-	ret = regulator_enable(st->avdd);
-	if (ret) {
-		dev_err(dev, "Failed to enable avdd regulator\n");
+	ret = devm_regulator_get_enable_get_voltage(dev, "avdd");
+	if (ret < 0)
 		return ret;
-	}
 
-	ret = devm_add_action_or_reset(dev, ad74115_regulator_disable, st->avdd);
-	if (ret)
-		return ret;
+	st->avdd_mv = ret / 1000;
 
 	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
 					     regulator_names);

-- 
2.43.2


