Return-Path: <linux-kernel+bounces-22434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819F8829DB4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80161C229EA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFA04CE19;
	Wed, 10 Jan 2024 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAb1HznO"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149DA4CB2E;
	Wed, 10 Jan 2024 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33694bf8835so3651398f8f.3;
        Wed, 10 Jan 2024 07:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704901087; x=1705505887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0/TYd/8rVyUf11DYs46AxL5K7um2W7Rvs+jbNKoDFo=;
        b=fAb1HznOPJ/GJdfbCg43IEkSKbemVgE4hmw7GoxTqTPxetdFwu2yXLuNEee6HlFPCu
         6S+5jkyP2kxyUDlg2CYs3CLVdn4/0zjZoY8PuThHgWhaY+7A5KsP6p2AM9ovoJIW4Xy9
         +SUqEUOuXRacG7AtXwRyJUA6YJEnn9QvzhWBKLFLmmr91P57FUqZ4JGoxox2IyeiYUyK
         /t7gykykgFnOSDxbJAwKpR3nlFByCErepPdWicO0zd7ARNmURj2h480btqSTVTbFjvra
         8Ae4zQC1U3NTHVzRmmzH5DDNn+rdOEk2jz1K9OhDthLJo17bDg9EYgf3tzFOHXcqbQMG
         D67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704901087; x=1705505887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0/TYd/8rVyUf11DYs46AxL5K7um2W7Rvs+jbNKoDFo=;
        b=Pav2CLKgz73D7x0hdxQfP03tzQC17VCONEq4/03LhpVUpoalF5ElDoqDYJMzPLI8yZ
         AATC12eIeibBOLpXd9EU//VMUUBzsjdLbNPiOLawzpZb1Tg2+CDUCfBy6qCHuSrQF+wA
         SmPhAh4N9KWf9dWNi9nAIb2JH6y92/kYHBccQ4SntD1J05wOG3OEYHjEMuKpNQokzhew
         aThaG/EAgymY/l2djxWKhXtkNg9jpEyQu7oAQx5RNs3/S/NjWysoXLfLLd+zI9gxaYtF
         ZjdN2h2Tct0LESWKilkqQ/r7RxOQyiOdUhdZntfQmo7xmUvBl+lX2ASCBgCz2pMInDav
         nqPw==
X-Gm-Message-State: AOJu0Ywp0faarNeHy7BBTyNrHaPoFhbcwD5uYZY8mNhpz/jSzjg6OOn9
	Ubimuq8z9KhYKWFjXtS5ppk=
X-Google-Smtp-Source: AGHT+IFqvQsL+DTp2axD0PBfim+O6DZbpg//OkpBTPX6uGG1RloTjz+kw0cRTCOjXfk5+c8qzaJktQ==
X-Received: by 2002:a5d:498e:0:b0:336:7754:6909 with SMTP id r14-20020a5d498e000000b0033677546909mr642344wrq.111.1704901087033;
        Wed, 10 Jan 2024 07:38:07 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([86.125.72.218])
        by smtp.gmail.com with ESMTPSA id e30-20020a5d595e000000b0033776a50472sm4179907wri.10.2024.01.10.07.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 07:38:06 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: 
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH v2 3/4] iio: amplifiers: hmc425a: move conversion logic
Date: Wed, 10 Jan 2024 17:37:11 +0200
Message-ID: <20240110153757.5754-4-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240110153757.5754-1-mitrutzceclan@gmail.com>
References: <20240110153757.5754-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move gain-dB<->code conversion logic from read_raw and write_raw to
hmc425a_gain_dB_to_code() and hmc425a_code_to_gain_dB().

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 drivers/iio/amplifiers/hmc425a.c | 100 ++++++++++++++++++-------------
 1 file changed, 57 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index ed4d72922696..b5fd19403d15 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -56,35 +56,70 @@ static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
 	return 0;
 }
 
+static int hmc425a_gain_dB_to_code(struct hmc425a_state *st, int val, int val2, int *code)
+{
+	struct hmc425a_chip_info *inf = st->chip_info;
+	int gain, temp;
+
+	if (val < 0)
+		gain = (val * 1000) - (val2 / 1000);
+	else
+		gain = (val * 1000) + (val2 / 1000);
+
+	if (gain > inf->gain_max || gain < inf->gain_min)
+		return -EINVAL;
+
+	switch (st->type) {
+	case ID_HMC425A:
+		*code = ~((abs(gain) / 500) & 0x3F);
+		break;
+	case ID_HMC540S:
+		*code = ~((abs(gain) / 1000) & 0xF);
+		break;
+	case ID_ADRF5740:
+		temp = (abs(gain) / 2000) & 0xF;
+		*code = temp & BIT(3) ? temp | BIT(2) : temp;
+		break;
+	}
+	return 0;
+}
+
+static int hmc425a_code_to_gain_dB(struct hmc425a_state *st, int *val, int *val2)
+{
+	int code, gain;
+
+	code = st->gain;
+	switch (st->type) {
+	case ID_HMC425A:
+		gain = ~code * -500;
+		break;
+	case ID_HMC540S:
+		gain = ~code * -1000;
+		break;
+	case ID_ADRF5740:
+		code = code & BIT(3) ? code & ~BIT(2) : code;
+		gain = code * -2000;
+		break;
+	}
+
+	*val = gain / 1000;
+	*val2 = (gain % 1000) * 1000;
+	return 0;
+}
+
 static int hmc425a_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, int *val,
 			    int *val2, long m)
 {
 	struct hmc425a_state *st = iio_priv(indio_dev);
-	int code, gain = 0;
 	int ret;
 
 	mutex_lock(&st->lock);
 	switch (m) {
 	case IIO_CHAN_INFO_HARDWAREGAIN:
-		code = st->gain;
-
-		switch (st->type) {
-		case ID_HMC425A:
-			gain = ~code * -500;
-			break;
-		case ID_HMC540S:
-			gain = ~code * -1000;
-			break;
-		case ID_ADRF5740:
-			code = code & BIT(3) ? code & ~BIT(2) : code;
-			gain = code * -2000;
+		ret = hmc425a_code_to_gain_dB(st, val, val2);
+		if (ret)
 			break;
-		}
-
-		*val = gain / 1000;
-		*val2 = (gain % 1000) * 1000;
-
 		ret = IIO_VAL_INT_PLUS_MICRO_DB;
 		break;
 	default:
@@ -100,36 +135,15 @@ static int hmc425a_write_raw(struct iio_dev *indio_dev,
 			     int val2, long mask)
 {
 	struct hmc425a_state *st = iio_priv(indio_dev);
-	struct hmc425a_chip_info *inf = st->chip_info;
-	int code = 0, gain;
-	int ret;
-
-	if (val < 0)
-		gain = (val * 1000) - (val2 / 1000);
-	else
-		gain = (val * 1000) + (val2 / 1000);
-
-	if (gain > inf->gain_max || gain < inf->gain_min)
-		return -EINVAL;
-
-	switch (st->type) {
-	case ID_HMC425A:
-		code = ~((abs(gain) / 500) & 0x3F);
-		break;
-	case ID_HMC540S:
-		code = ~((abs(gain) / 1000) & 0xF);
-		break;
-	case ID_ADRF5740:
-		code = (abs(gain) / 2000) & 0xF;
-		code = code & BIT(3) ? code | BIT(2) : code;
-		break;
-	}
+	int code = 0, ret;
 
 	mutex_lock(&st->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_HARDWAREGAIN:
+		ret = hmc425a_gain_dB_to_code(st, val, val2, &code);
+		if (ret)
+			break;
 		st->gain = code;
-
 		ret = hmc425a_write(indio_dev, st->gain);
 		break;
 	default:
-- 
2.42.0


