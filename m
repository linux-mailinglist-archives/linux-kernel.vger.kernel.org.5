Return-Path: <linux-kernel+bounces-158755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12798B2488
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7299B1F222F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA18314AD33;
	Thu, 25 Apr 2024 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SmiKmF2S"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96F514A605
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057419; cv=none; b=jcUzDOsiez871OFyTBnzWffkvEbCZKZr1ApydPgsiNM9WlFXM4yzg2QY8YWTFoM+THaFpllAWcSZQBj1ro124AYZqJfezw0t5Q9uin0LCDLsjj1AJszM9S/QKUostkLUiDEG0sQfwBqZ6x/N0t7oBjKsIdIhGbmsvVSLaP0T0/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057419; c=relaxed/simple;
	bh=Tsa8/Wzig6FNUfuFlRIUELjsQKPsOH3Pulp9FrfGw6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAQ7c3uoCL/ZbMzH9juII4ubt0tWhwbF5lZy3Z/h3tcmyOwLioAPUqp2/Dp5hRFYSxgB6aiIPuop1dQ6j/9YGxDNmvnSex2tiwTNOvb0c/XU0pahtU9nL9RPzjIYoJaXHvR+OnBW7/Qwu/PmbUbH+eTPNpPKDCrX+F3iAReUhlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SmiKmF2S; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-233e41de0caso600262fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714057415; x=1714662215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHHT3V3NAkn80zT3ZwzVgbMDW8DV/51JYCXCI4YMBAU=;
        b=SmiKmF2SkD/BZUvZPccQMXBK9J0xIYh+u5CHbb32k7yqi7ZmCoj2/LHiJEqVra2gps
         7BQWKXF3v7ADpENGe8PPrsop4Z2PnzphPt1pKsQaJcEgY/aJxhzY5AIwfiMD95XFuBdc
         t4Mf/VWCw9yANI2ZEsVHuQCdp1mAuPPnzxJ4eB3T2VszzpbrxdCqHuShQ6Ssa3G1BBGi
         PMleiFcNjz9CL137aYOGJeULxmwHxRWWphSyi1ZfFV4SjoGTXxTFnWSH9045L5FOD82k
         QJG943vaJemk0Br/BrEKYNifCtjZ6FOpMTW0SrhN2j4aUK5yPYKs0jb7ta5k6FV7/mE3
         KvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714057415; x=1714662215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHHT3V3NAkn80zT3ZwzVgbMDW8DV/51JYCXCI4YMBAU=;
        b=VyXCmQZ/3AIKjkOrOGdHzjl4C3ZvUgFWtLzzg6sHlmv2tCAp8ZYGa7r+vTR7RrHmtQ
         b2xGXsb0JE53aFFXmRM31J3oFePaCH/q3MsGnIlAvypyPpQ0I9xUT3oLf5oYrFXYDnlJ
         549UEgg7x8rIT668piHTUvyYACCgoct/X+XOMgcAht+JEsHc+zpgFQlRrEL9uyTySaRk
         A3sRPaXS4hd4fGvfm0oVIzcYvtXkRikTGz3XQi6P6/lF68iws+PvccX5+7NlLIrgqJoi
         Mquh5bxWhKQereTWJZ9yk2H4qjE1oJdX9A8umD3bgicqD9v3+w4CQcYzgtOIPouF6GhJ
         ckDw==
X-Forwarded-Encrypted: i=1; AJvYcCVp8185OxC8ejX+nweciCrDlEk2hh6W9OXQeZ6wYhTOmtANRnwRmzr0jC6mD+BpBi/bpM4gZ3FvC9iiKsvRytimE0GrzuVwsPfCjA9w
X-Gm-Message-State: AOJu0YwRagCFa7DdACYnCcQtSez9Y6chvnwRG8PmV5R86OgWMfz3yS9a
	jNLNMjotuwJ/oPBZkoMD7D89OBwgIk4dQjIoalC/aoSjZ+cTxE2pYfjLlLZ7HNw=
X-Google-Smtp-Source: AGHT+IGKUzbiZmA4xkuzW4Obu31RHZOeYQIUKpUb81CCZ1vyHCvuVjk+AQ/mnzT8PDS0gPeY3MKOiA==
X-Received: by 2002:a05:6871:b13:b0:22e:c787:5fa2 with SMTP id fq19-20020a0568710b1300b0022ec7875fa2mr6465784oab.58.1714057414871;
        Thu, 25 Apr 2024 08:03:34 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id mp2-20020a056871328200b0023b6d4723edsm166739oac.14.2024.04.25.08.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 08:03:34 -0700 (PDT)
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
Subject: [PATCH 1/3] iio: adc: ad7266: don't set masklength
Date: Thu, 25 Apr 2024 10:03:27 -0500
Message-ID: <20240425-b4-iio-masklength-cleanup-v1-1-d3d16318274d@baylibre.com>
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
drivers, so remove the assignment in the ad7266 driver.

__iio_device_register() will populate this field with the correct value.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7266.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 468c2656d2be..353a97f9c086 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -371,7 +371,6 @@ static void ad7266_init_channels(struct iio_dev *indio_dev)
 	indio_dev->channels = chan_info->channels;
 	indio_dev->num_channels = chan_info->num_channels;
 	indio_dev->available_scan_masks = chan_info->scan_masks;
-	indio_dev->masklength = chan_info->num_channels - 1;
 }
 
 static const char * const ad7266_gpio_labels[] = {

-- 
2.43.2


