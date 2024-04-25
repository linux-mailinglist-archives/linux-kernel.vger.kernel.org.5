Return-Path: <linux-kernel+bounces-158757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD318B248B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C26928698B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3419314B071;
	Thu, 25 Apr 2024 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lYm5AtCr"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5484A14A604
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057419; cv=none; b=DfKoi2r6MBHzkjHMgdWqOnfGRTbSLvKmRKE2y3m2RvCm3TTYjFMFGVhVknBj7IcIwft7N30IGCQNJMnwO+09e1qOUQcFt3r/6QJDDJrYEHdh1la0xQQXdMMcP9sUsggaoSJ8f0iaD/4/bJhEkmvqcKIQRFyJwRvZgSid1Y0LLI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057419; c=relaxed/simple;
	bh=c0UVqkjMuNtarShlxI0bIDMYPsBOuAUJ6QeQyiAWEuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqmWsIdowrCxo/cWB521GdhTjmlgmM7Cxo2sHAz2xUoL2c4GtXiN3+Aqq+3j8lEqgKNyS9JDNI9rr19fvl/7S+c4rokObQ6/qTXLyJZa6zlzc1YehiS/t47URPtLyyoDrx65THyKeZ0/Q2gwiDVUymnfW/Jy/kQxol/p+LI/Els=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lYm5AtCr; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-22fa7e4b0beso474301fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714057416; x=1714662216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuUgN+eqDnD1TSwHoUcLirGapuP4idukeuGNZ2DNfLI=;
        b=lYm5AtCr7ClXsH4zVnZ7RefhauWfTi6b3MRzk5sA9543gVL5jRqOaiUiUffW0Tcstt
         /dciL2CXA9/9BOvD3xvt9/ODK+pyoK6MSI/I0jaCQ8BhDBiVHAwR3oM71QiHVEPU11Kj
         61XRfoylO6ui1TM8dl+dCj6U+nPQqm+NgnmxD+O98aKihv65YvXji0oJHRweIy3ugACJ
         oC+sWjqiXHxQpE7WreUN10iv6LZ3Iv9FDIqrkqjcQzBstPS/VaWykDWt+G7fmx7cYDjl
         rzM9icX9Oka5gT0ugLLIZV3pnf64nuWWxO8U15BqSF7by2iWlod9mcyTrkWbZMZi3JKw
         k0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714057416; x=1714662216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuUgN+eqDnD1TSwHoUcLirGapuP4idukeuGNZ2DNfLI=;
        b=JV1OCQF/OIZm/cOImPDNNaI1yeRNZ9s/4uSIyGBOefBRlVMo5OfuCWxqPlknao/0mO
         bzVzkyG2q2XD62606HK6IoAtxdhmJP7qx9GjzWVvwU1e8rSCoc2dvnwj/edZXfVjStw5
         K3Y4FZ39lH/ueegrr+jAQikIXs0cclCzE2F58aaWdoJcBGTKMlB/dVrZqspzLPIOL+qO
         hbtLCxa7QqtSjBjQnHqQy+waoHY9Me6c6YJoM/97SO93tSl9xdDlCOQi9mZdA7JhGkES
         JeeoeqpbSsiWnxNN//83ouBx2dN6xbCYXNkZGeo2c2YdP2YXVhkkyjj0eO4GwcY7clH/
         w/JA==
X-Forwarded-Encrypted: i=1; AJvYcCUY3Mh6t5mLbpQhpgtVvNHZfjCbAB4gX6QpzVfnDuDatUlxTtyKtTka2fJn+Huti617eizwE2yHqMcPnhlSpjkJEKqDLsLRrG9CVo/g
X-Gm-Message-State: AOJu0YwnGtxN+tcTs0i4TA7yni7ue5nTNGWBRCH9f/u1i5PRE0Y1aVnO
	JjgZcOBf7LSpfX4+OSjbPhJrIaU7OK8tZXaM6hceAZfZAy6ecZr1SI6ATPW79H4=
X-Google-Smtp-Source: AGHT+IFvAtaidOO7h0zkTLuuS0Zuix9lqDgu9+DKxThfm0jLTYtjgYSEE2bX05vg7lHkXPUfguF9Bw==
X-Received: by 2002:a05:6870:9f86:b0:22e:de21:e084 with SMTP id xm6-20020a0568709f8600b0022ede21e084mr7083274oab.9.1714057415874;
        Thu, 25 Apr 2024 08:03:35 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id mp2-20020a056871328200b0023b6d4723edsm166739oac.14.2024.04.25.08.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 08:03:35 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] iio: adc: mxs-lradc-adc: don't set masklength
Date: Thu, 25 Apr 2024 10:03:28 -0500
Message-ID: <20240425-b4-iio-masklength-cleanup-v1-2-d3d16318274d@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240425-b4-iio-masklength-cleanup-v1-0-d3d16318274d@baylibre.com>
References: <20240425-b4-iio-masklength-cleanup-v1-0-d3d16318274d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

The masklength field is marked as [INTERN] and should not be set by
drivers, so remove the assignment in the mxs-lradc-adc driver.

__iio_device_register() will populate this field with the correct value.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/mxs-lradc-adc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index 2e60c10ee4ff..8c7b64e78dbb 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -724,7 +724,6 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 	iio->dev.of_node = dev->parent->of_node;
 	iio->info = &mxs_lradc_adc_iio_info;
 	iio->modes = INDIO_DIRECT_MODE;
-	iio->masklength = LRADC_MAX_TOTAL_CHANS;
 
 	if (lradc->soc == IMX23_LRADC) {
 		iio->channels = mx23_lradc_chan_spec;

-- 
2.43.2


