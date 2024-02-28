Return-Path: <linux-kernel+bounces-85512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED0386B6E4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D5F1C21485
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6645B40869;
	Wed, 28 Feb 2024 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="db60gfZj"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBD740847
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144041; cv=none; b=SYGdsBNlfaxM3IMzhJcaWiCQF9mmCINnwdYoWGoxUJrjTOO0ED6Uyi35Xi/KOtmwVGQNZM/0DojoktvnQK04hLXFIIivqJQrrxmYB/6UZTEQYkzb4LOp4vLwXFinhaP5w8sY1jB6I9OjxMWOWH/A4cy/8CYpzmYYwSjOTT+X0k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144041; c=relaxed/simple;
	bh=IUp2O1DyurNt3DHOePkrTCbRZHnoqxYLM0e7Jur/hNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mbSbJfONADc8ExmWFvBmjSvKK9R+tIyRimElB3M9t9RnFVdU874LRE09pBktf953t0/x+2/aQ66W7shSYVK9I8TkkShxxf2WUVliEOkt0UtuCf91lwFdpWJgsDyDi5j0cyEnRlvfC2MwEjWbRlPX606GmAKdZA4c+Fx/E5V2nWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=db60gfZj; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a0932aa9ecso10870eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709144037; x=1709748837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JHGQf153ISVcw0os1WKKJ+NMnoBEbvgIaH2/2iMTb0w=;
        b=db60gfZjnMbn4CHlwQlB8YP9QpafdbEAuVYp1vulcPJ5SpPGglQOW84gKMpi4EQfh8
         0dqC9yOlhKy2QKZlIAyjFzsXZjDQxHThxc/608s519MMC+tpe7103colh1TRr7NnZFM3
         EnUtPW/iEz5gyg8nPJWGErnYStWbL7p27FK6SnzJteVmzLVTgYMdbunw0s2lbciTg5Xl
         p79Pi9aVT6eYurRpleOiQo5v3W0idyBO1qvP2H0k40QLonaks9+tQqLtxT1Y2cOaTdll
         ll3Ba4flA6LTa+YpzT/2nGNwTSQP6xyrVBRe1whjcimmZr21BfDypfWyVcIlOPFFypd7
         FU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709144037; x=1709748837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JHGQf153ISVcw0os1WKKJ+NMnoBEbvgIaH2/2iMTb0w=;
        b=TUMRvqPiDz20Eaz4DTUUbBUlUiTXjId8T36ib3W7+g0rV+ZWC9zUd/JPOLL5DYE3kM
         R8CWUz7Bukh9PrbMboZLXZW2zW47Yg5KgouPBLGhtKQen4QDgZC70RE4tSCY7dfWy67/
         v1uHiu1NrVX1D8QLsM2ZyuGobutVZxtAhiYND9RjJEs8mD+QbLScDzFAR3aihA4+udEB
         GDFLXxN2or4VM5u4X2W4H43wDjHsTjqMZoVDJgLrr9e4TS93K5MLAdMYHNV36oewW2iw
         DY/6dnG++wbpDs4n74muHnRdyk71J6IKs+UU13n7nt4gE/3LD4RuSOZX/OlZol8RKsUW
         kvYA==
X-Forwarded-Encrypted: i=1; AJvYcCWdh/T+3o31I8h8V4K17yx5kvQhXtYWsz7qgfPZVXEhu4gG8tSZUT4mSt6t1feLUTnQBVDYEib8R5dVDeTCXv0yxUAsZwwBuMNmQFVO
X-Gm-Message-State: AOJu0YyUZP/VaYKsVJOwGi8GWNtRk5B/wAANGZca7EUyb3CZpMdiVcUY
	T+7QKDH4Z6TbM3QibGH7NjpnEy2Bv9JcOhfjGwarAwUxdXzXIts3WLP5rPOwXnk=
X-Google-Smtp-Source: AGHT+IFR/nSV2424gDV/2o+aGcU+yEiir6WLvMYS7zCkUxW6QTer+XFLz59fw4fIyJc3hJM2jNxFhg==
X-Received: by 2002:a4a:241a:0:b0:5a0:357a:546c with SMTP id m26-20020a4a241a000000b005a0357a546cmr413610oof.6.1709144037018;
        Wed, 28 Feb 2024 10:13:57 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f20-20020a4a9d54000000b005a0ac863a99sm12291ook.13.2024.02.28.10.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:13:56 -0800 (PST)
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
Subject: [PATCH v3 0/2] iio: adc: ad7944: new driver
Date: Wed, 28 Feb 2024 12:10:02 -0600
Message-ID: <20240228-ad7944-mainline-v3-0-781b922334af@baylibre.com>
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
Changes in v3:
- Removed 'multi' value from adi,spi-mode property in DT bindings
- Modified driver for above change
- Fixed spelling of 'conventional'
- Added '#daisy-chained-devices' to DT bindings
- Added comments explaining that '3-wire' mode is not related to
  spi-3wire/SPI_3WIRE
- Replaced _sign with _diff in chip info struct to properly handle
  pseudo-differential vs. true differential chips
- Link to v2: https://lore.kernel.org/r/20240216-ad7944-mainline-v2-0-7eb69651e592@baylibre.com

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

 .../devicetree/bindings/iio/adc/adi,ad7944.yaml    | 213 +++++++++++
 MAINTAINERS                                        |   9 +
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad7944.c                           | 413 +++++++++++++++++++++
 5 files changed, 646 insertions(+)
---
base-commit: 205bbf0d2dd2e0fcd6bf2a15b7df6fc570967e3b
change-id: 20240206-ad7944-mainline-17c968aa0967

