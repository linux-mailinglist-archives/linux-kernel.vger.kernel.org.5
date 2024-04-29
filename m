Return-Path: <linux-kernel+bounces-163163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E9C8B668D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADB63B237CC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37F41A0B17;
	Mon, 29 Apr 2024 23:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZMCOsu5f"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E95319DF48
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714434042; cv=none; b=uZkAfst4M9y2/HHWOBRl/GsEH0z7OKu+80X2iyH84/OPfSVTvxhSg39HnWefExaIM9PMCW0twMvW8adknfOaSUtsrnN5k1i7XYpFxBAcwPLpw0nJHp1tBNmhp+VoUwFG0PfHYSAo3j6Huj21x1HGmb+CDGAh3awhkwYErkU0lQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714434042; c=relaxed/simple;
	bh=3hilpxNXGTNYNV/psPrPfqfzf4YMNvFNvehwsbDVqf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVuY8fsxz9HiZ0HifZzhhvAdYzoMYKM3Ol0ukx+svMENJHkVPugY0TBvSkpWuzKRbS4xJANvk6A7iuWTeWzrEXbvAdMIGKtUn56M34dqvDcJIIjbxb8rJt5x/9jsNOG8l6728fOv84O1ywMCeIKQu15C2i3yJRT7VM3weFAAiWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZMCOsu5f; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5aa2a74c238so3697147eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714434038; x=1715038838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMPnK0ZmMp+orXBCVZaO6rHB522p+A6Oq1x+E+/WEkw=;
        b=ZMCOsu5f6QifjuBcTkNswzU6fvqPP4XkmOabRxJdPiS+zDnyExIufYLwXOdpirCtYM
         gD2TVZw31Px3KB/AuKMxwl5RVLLr/QbLSr94jz9fxHV558z++ITEdStCZgv0NXqSO1BY
         7fmkysQiz/OoREErE7ojaKN7mlDqhuSaqhhX9PsjTGzWNOKAuPBr5+T8yRc3U67SuFUs
         4lU/eg05dyWDqxSyLdb0+TFIetpuLH25q/ipuFFKbP8nmH/LZGDV699Pn89Ch+A64d9M
         GCf2HYaZa8A75WBI0/k4lDJBQ2Wrl9mDV8SxcFgJy9NVOn/2KfHtkPGCNj2fn06afMkM
         0cVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714434038; x=1715038838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMPnK0ZmMp+orXBCVZaO6rHB522p+A6Oq1x+E+/WEkw=;
        b=Fy7vpkWydpwA/ZM5R7bxikehNWGM2Dg6eVXCc0Stxf1pJLkGMeA+CaLJv9P3JZmb2b
         VuPJUD3lH93zpIA1xfSiBsA9bCBhVzeufq0qdjQsO8GQsAheu+srbkFxY7hJOT+178dv
         HpFivpVgVIhsYFaHTsJcwXn6poQkNnO6M2CnvPvUmIpnMGuTp99V4wHUl8U6dy/irMRL
         9+gTajLc0Ov0kCd8FmMn8VWJyj6kP4hSUxM2V8uYG/h58KmIh0TNbiDvu8f5EWTRBDd+
         hsKLUJHEHGkAbrhsieu++WvomRkKDJg1EZSlr7lSVR8G3H2wpVJ8B4wBkDP4jZapt4tV
         416A==
X-Forwarded-Encrypted: i=1; AJvYcCVXRBz2EpAJfF/nGyk2iv+SJcKUjgCdmIO6LvoQGr4NmGrOBx478NbhcOhGG0rhsngLkwIHSSJTGSgtb4AxTUUNFT50EYz29EKnJIUY
X-Gm-Message-State: AOJu0Yw5sIyxrD/uk7aYqfxsYQLP9a5TReR1up6DH8crKzljq7dv/JFF
	xCu36NlvikQutpjwIGpmPogGxUedGfcYOK0xf4W3A6bwY6lJOmp6/w7ywf9tUFw=
X-Google-Smtp-Source: AGHT+IHCto7xk1AhSGi7ynmclCr1dSNmOQSXsdzM1syGcPB+E666URhfsrB23a+JfSpjd1mIFdGxEg==
X-Received: by 2002:a05:6870:9a1b:b0:23c:9f74:f6d4 with SMTP id fo27-20020a0568709a1b00b0023c9f74f6d4mr1370575oab.52.1714434038300;
        Mon, 29 Apr 2024 16:40:38 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id hp22-20020a0568709a9600b0023b58aa20afsm2144508oab.25.2024.04.29.16.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 16:40:37 -0700 (PDT)
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
	linux-input@vger.kernel.org
Subject: [PATCH v2 4/7] iio: addac: ad74115: Use devm_regulator_get_enable_read_voltage()
Date: Mon, 29 Apr 2024 18:40:12 -0500
Message-ID: <20240429-regulator-get-enable-get-votlage-v2-4-b1f11ab766c1@baylibre.com>
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

To maintain backwards compatibility in the case a DT does not provide
an avdd-supply, we fall back to calling devm_regulator_get_enable()
so that there is no change in user-facing behavior (e.g. dummy regulator
will still be in sysfs).

Also add an informative error message when we failed to get the voltage
and knowing the voltage is required while we are touching this.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
* renamed to devm_regulator_get_enable_read_voltage()
* restored error message on failure
* restored validation check in ad74115_setup() and added error message
* added fallback call to devm_regulator_get_enable() for compatibility
---
 drivers/iio/addac/ad74115.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
index e6bc5eb3788d..12dc43d487b4 100644
--- a/drivers/iio/addac/ad74115.c
+++ b/drivers/iio/addac/ad74115.c
@@ -199,7 +199,6 @@ struct ad74115_state {
 	struct spi_device		*spi;
 	struct regmap			*regmap;
 	struct iio_trigger		*trig;
-	struct regulator		*avdd;
 
 	/*
 	 * Synchronize consecutive operations when doing a one-shot
@@ -1672,13 +1671,9 @@ static int ad74115_setup(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	if (val == AD74115_DIN_THRESHOLD_MODE_AVDD) {
-		ret = regulator_get_voltage(st->avdd);
-		if (ret < 0)
-			return ret;
-
-		st->avdd_mv = ret / 1000;
-	}
+	if (val == AD74115_DIN_THRESHOLD_MODE_AVDD && !st->avdd_mv)
+		return dev_err_probe(dev, -EINVAL,
+				     "AVDD voltage is required for digital input threshold mode AVDD\n");
 
 	st->din_threshold_mode = val;
 
@@ -1788,11 +1783,6 @@ static int ad74115_reset(struct ad74115_state *st)
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
@@ -1855,20 +1845,20 @@ static int ad74115_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad74115_info;
 
-	st->avdd = devm_regulator_get(dev, "avdd");
-	if (IS_ERR(st->avdd))
-		return PTR_ERR(st->avdd);
-
-	ret = regulator_enable(st->avdd);
-	if (ret) {
-		dev_err(dev, "Failed to enable avdd regulator\n");
-		return ret;
+	ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
+	if (ret < 0) {
+		/*
+		 * Since this is both a power supply and only optionally a
+		 * reference voltage, make sure to enable it even when the
+		 * voltage is not available.
+		 */
+		ret = devm_regulator_get_enable(dev, "avdd");
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to enable avdd\n");
+	} else {
+		st->avdd_mv = ret / 1000;
 	}
 
-	ret = devm_add_action_or_reset(dev, ad74115_regulator_disable, st->avdd);
-	if (ret)
-		return ret;
-
 	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
 					     regulator_names);
 	if (ret)

-- 
2.43.2


