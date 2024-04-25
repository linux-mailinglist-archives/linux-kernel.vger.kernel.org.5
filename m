Return-Path: <linux-kernel+bounces-158754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB728B2485
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27DF1F22169
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759D214A633;
	Thu, 25 Apr 2024 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vZ2IK7Lg"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D684514A09B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057417; cv=none; b=Q4qIW5r+vr+Ef4uZ77O+qz8mafCDUJi0fab1AqjuoKyOpN+7fMzTziTXb4UjRyvJMI1zhZIqxjvBPNMKKVuUV8eqogTx5jhSD68rhRuMvLiHcvDi4LYYcM2sJ3m3whZbFNF8HyQCbFajHXPEWBmd8/3rnz5a3NCMHA0lFClbbSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057417; c=relaxed/simple;
	bh=6HVultyKajYKe1H+uYe3q2OjaTtG4U901xdI1ul0mzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WQkm+3VjqkgYvM7dg3qysFZqPk3oBTg1hMuNgEsfEfcsEHt1RfcOUIabng701M0c4TbT73Mizu7lUa4GwE6OgS5y6GMAizIAEXviAqY4NPHNJ6jF1xxd5S04Zrtyg+0+yoRsRZ3K1EJ6vc/0IsDeBEGWKhCIoy5L8ML/sn5haog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vZ2IK7Lg; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-22efc6b8dc5so722553fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714057414; x=1714662214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TVzvIdSysiCQUUen73Bj+sLcl+k2nyJjAr6PCZt7XT4=;
        b=vZ2IK7LgLhbBoBnz7IHLo0FqRTI/tkJniG5xIH3D4dWRXRzKyz5BHZB7NZvaHo0Kdd
         JwAuBZOhIxM7brr9IGfGxUN2OzRHCuIReG1CnaB64GEMZTYRsM+TfQ9gKMi79Rg7+Fs3
         KPNwVka+xoLKC4uFQsAbiji6UD7XtuyZUoZQAF5tDtJrTz5umkpnBUH+0nnKUYIvQ0XU
         Wz3ENt4PzAXFyhj8GlwYD22hdeZrUVBQPKzTQtRKwMKNBD3bq+dxNUvccHHNcH/Q3b/L
         znRzYxwZhCQMCZzyqG00VHaTRKQn4d7v6poN7Tv6wn5lgAd+P45pEuqAlaq4ueCmbtMq
         QEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714057414; x=1714662214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVzvIdSysiCQUUen73Bj+sLcl+k2nyJjAr6PCZt7XT4=;
        b=dMoyIliHO1hZGPHxhd7XpHLBt/PElNzDh3eu/Nmb+px6RorSFBdIOvgB8e3ohRSdRg
         IYGw/WBurriI35aZqMoXR7ee9213kBQbttSlNaG2xHTSSRkTfN+B1h2NVA4IKjXoSJo0
         o7IIPvAFI4AKsgLOWTedJznf9UUl3sytG0ODCxNJAKUCxgORfXpUp/ayuDdCS9EzGfFM
         T2NhALs3NkpuPGdSWw3gjozraFt2/AWLJSRPtr7wVt9ToNUnwVkjkoFn7sqMsYvEEUDl
         xFSJO39dI/wlcrbln+nqNjO9Znin0872Ssjkz3c3g4cEDmcJ966yP9GAMrp+57rhaQu9
         j0vw==
X-Forwarded-Encrypted: i=1; AJvYcCVlsgk/AfYE7CL/45UBP1sb8Uf3HM1blVTUwCOdWxDimdVOfti50OSKVJsuAQYfhxzVyxsbFCu4fxzqwc/z4Hm4xXLVAyhmgXWGuQCG
X-Gm-Message-State: AOJu0YyGKU43cQoDlQIRlj4huD3EjgSkx3rInF+r4iOmy/3txmtgI7IS
	y2TLvT/80xJ1Qe25Ueoyff5qk/SPeSeCuAUSXGXV4TnzZI2wfcCvFrhsoqEQka4=
X-Google-Smtp-Source: AGHT+IE7uk/e9lPnEmRVtei7ZdUwH47uHhQ5kFtFyZHHsMq0kRAPIHbtnVqwEvJRA8mUQD2RSmGSfw==
X-Received: by 2002:a05:6871:4393:b0:233:276e:6bbf with SMTP id lv19-20020a056871439300b00233276e6bbfmr6917951oab.15.1714057413979;
        Thu, 25 Apr 2024 08:03:33 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id mp2-20020a056871328200b0023b6d4723edsm166739oac.14.2024.04.25.08.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 08:03:33 -0700 (PDT)
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
Subject: [PATCH 0/3] iio: cleanup masklength usage
Date: Thu, 25 Apr 2024 10:03:26 -0500
Message-ID: <20240425-b4-iio-masklength-cleanup-v1-0-d3d16318274d@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

While working on other patches I noticed that a few drivers are setting
the masklength field of struct iio_dev even though it is marked as
[INTERN]. It looks like maybe this was not always the case, but we can
safely clean it up now without breaking anything.

---
David Lechner (3):
      iio: adc: ad7266: don't set masklength
      iio: adc: mxs-lradc-adc: don't set masklength
      iio: buffer: initialize masklength accumulator to 0

 drivers/iio/adc/ad7266.c          | 1 -
 drivers/iio/adc/mxs-lradc-adc.c   | 1 -
 drivers/iio/industrialio-buffer.c | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)
---
base-commit: b80ad8e3cd2712b78b98804d1f59199680d8ed91
change-id: 20240425-b4-iio-masklength-cleanup-86b632b19901


