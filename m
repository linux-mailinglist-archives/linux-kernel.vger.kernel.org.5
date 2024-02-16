Return-Path: <linux-kernel+bounces-69263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADA985865B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2969AB23FE3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45722138496;
	Fri, 16 Feb 2024 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XaPJPgGf"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B403131E5C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708112854; cv=none; b=QDe7BvLj64y2UdrJ9GcceuF+V0iEgQCkfuga/L+6Tvhq+su9rcFnYwH0BrRZwbdBbPmah4CH3WSXps2cFe/U1bNwCeRYfbxr61BumPXH2mxW5KNL1jKbQ4acLS1KoWIFmBOdWaqjHtRb3O3MqJsnw1oLxaFGGgqpUeZtC3bHFK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708112854; c=relaxed/simple;
	bh=SmhWWVRherSSU6IqXDSK9iug5x4NrJoiSZ8Z8ot0gvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dRh0OllRXKjVG+54AJUM4fCgmblGHZiT7FFaMQyVgSXZNJ3kF/QC+YQQBE2H0ull64wp/1lC4qFVWm0LwN8qg4tMOXJAKzhfFo1tLMHaf4xrlbhIgR2k820KsC/kV3eZkS1PfygzEtDa3HxDF4fQJwF6UrWm/hJWDxRQ9IMYaXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XaPJPgGf; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c1333b0974so1853409b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 11:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708112850; x=1708717650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aMru+TbGR1l/T6gVtc9rPekac/11roVdl4ywF715rRI=;
        b=XaPJPgGf6+4DSb+48CZdpb/6zy2dVdfciJU9M7veAukxk21aBXcgBkaBunaxw4qfcW
         W0qYVl9gm62oIhzFnlZ5XhTja2wncdmkE1XZsIWtAaWtf1ZkO41Di4V2kxnIM88pXz1z
         6Xzh3kHXkpP51Yl8L41YMZYz6oNMWEP+inW8FzzMjXoGnnRWIh19WaLTIMH//jFxctOv
         eeX8ORtg2epRipILHtgKvNjmckzOz+MOMW0XRVIyEDvU+tOv7tVcOrNC1LXpml2IPcmX
         jasxzHnKIIr+gzmQHKew39h9Jw2d6+ueP8CXz3wt4jKll7oQy3D8kj1JlpQqnHYonmDl
         RBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708112850; x=1708717650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMru+TbGR1l/T6gVtc9rPekac/11roVdl4ywF715rRI=;
        b=gNTqFwb3DAj5huWrDK2R7/neSmGVtZCuFkHKRKmYxVTVf/OreHVtSR7UOFON7kLoP4
         gcFqsXNPWx7FraLMvX03efd2Ztixp7vUsD4kAJcQdp1j1BfzcM5a9f8odft7SwtN4mWJ
         PePxGO0qdaIUQo/6Vngm+XD0ytIDJ0KDKmBe+dSfU0DGKHNEqoTm6AnDXS3cDRPOtJcT
         4CyiUjj1gLZORM35UqJ3owH1i3hTgqp7RdLVhFK1htukjPelZK5F/4e1rFN8hS2qhK9+
         VyB/H0se9SjWdskrZBveBzDNSVfSL3FyxSKZ5CmYD3sdQPsL2QAvgDiJBjtEvRbJSBef
         znqA==
X-Forwarded-Encrypted: i=1; AJvYcCWbP5ZNXhJiVVq2dtEqYDsBZV5TJ3IJqAejnswOw7UHhu1kivuzSfiBlM8sJypvbL7X6zzzxOHmwlcAFm0jYNhzICK5PasFVoWNyJmB
X-Gm-Message-State: AOJu0YyIS7zz3Ax999zeraCDhIvaBjaXoo0B0ow1DFpjhNE87b1TEC5Y
	eLIN7Bvzs8PI9N3Zs7+NKKCHSdgfKru925peh4GrK7ZIgjKjItadoUUOZWYpYys=
X-Google-Smtp-Source: AGHT+IGJBZrYvbYX0IG7bRqDEFfE5DW3EZ9u9PL8550Cr0O0GrdlPovf38xkFRfX8pcp2zGtIU7kIA==
X-Received: by 2002:a05:6808:f91:b0:3c1:3d7f:5363 with SMTP id o17-20020a0568080f9100b003c13d7f5363mr3720080oiw.36.1708112850496;
        Fri, 16 Feb 2024 11:47:30 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id cg10-20020a056808328a00b003c136d7ed2dsm83412oib.43.2024.02.16.11.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 11:47:29 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iio: adc: ad7944: new driver
Date: Fri, 16 Feb 2024 13:46:17 -0600
Message-ID: <20240216-ad7944-mainline-v2-0-7eb69651e592@baylibre.com>
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

This is a new driver for the Analog Devices AD7944/AD7985/AD7986 family
of ADCs. These are fairly simple chips (e.g. no configuration registers).
The initial driver is only supporting the 'multi' (4-wire) SPI mode. We
plan to follow up with support for the 'single' (3-wire) SPI mode.

This work is done on behalf of Analog Devices, Inc., hence the
MAINTAINERS are @analog.com folks.

---
Changes in v2:
- Added limit to spi-max-frequency for chain mode in DT bindings
- Added spi-cpol property to DT bindings
- Renamed '3-wire' mode to 'single' mode (to avoid confusion with spi-3wire)
- Renamed '4-wire' mode to 'multi' mode
- Dropped adi,reference property - now using only ref-supply and 
  refin-supply to determine the reference voltage source
- Fixed spelling of TURBO
- Renamed t_cnv to t_conv to match datasheet name and fixed comment
- Fixed wrong timestamp pushed to buffer
- Fixed scaling for chips with signed data
- Make use of sysfs_match_string() function
- Link to v1: https://lore.kernel.org/r/20240206-ad7944-mainline-v1-0-bf115fa9474f@baylibre.com

---
David Lechner (2):
      dt-bindings: iio: adc: add ad7944 ADCs
      iio: adc: ad7944: add driver for AD7944/AD7985/AD7986

 .../devicetree/bindings/iio/adc/adi,ad7944.yaml    | 204 ++++++++++
 MAINTAINERS                                        |   9 +
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad7944.c                           | 427 +++++++++++++++++++++
 5 files changed, 651 insertions(+)
---
base-commit: bd2f1ed8873d4bbb2798151bbe28c86565251cfb
change-id: 20240206-ad7944-mainline-17c968aa0967

