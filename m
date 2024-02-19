Return-Path: <linux-kernel+bounces-72064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE6E85AE84
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13AB1C21E88
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CFF5674D;
	Mon, 19 Feb 2024 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0etZHdle"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512D854FA7
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382099; cv=none; b=FFeYrUiCfZfX1M943GwnyGy8q2d/PBliVsqdzl0V2Pjq9o8MU637nuaBE3x4mUt+QKblGQEOFFhbWAaV0tJPmhakOwT8CrS3keZkMkVI4hGjeswTEs1gmEgboDJ0RGElPIN1qzy8i1AyG2RoIzTKjs2y9BIDF9FZZ5OXo8bGrmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382099; c=relaxed/simple;
	bh=JBQIaeDHrV9gKbQrmALiRPHPoHWife80Dv1jrDFlRFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bdDEFzJxzu/nJB+E0YCaMU2zzIkEvFZzyykqGMbGqbtZYTjHuXUzZxX3rgC7j3XNMyAb090qaXlaczD6b29EK9DD0CowCGyPjDIAvN0MxMussR6QoI+Edv252FsTzip11ePwf7rJ6nluWbS6K0sa7HWXMdsHRIKTvTSRiuzNuqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0etZHdle; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e44c9a62b6so668702a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708382096; x=1708986896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gpwEAehth1tWZQpA0TjLevm8DWTiiteNXTP4U1INUoM=;
        b=0etZHdlePnEd71oUCgiJk2f5JR+B3L3l1NYcLXpVBrkNN+19nl3CvOHgqZaEcwWBzL
         dYvZPVg0A/0PT6K0gGHzaDXNqH0EuQ6bRau+jEXq8u1MGojCFWXzvjJvZ0MParMa+HqP
         Uo2KGe1xpwtF1PnJqPjPTk7dXUEsAZCsM/ExhcnjqqdA0N6sX3S6RbQpQqmoP+kCqkJD
         4NTWILyHH9nPdJ2/jFMX4YZqRmj5afjOS/lQ5k7sdPFXhOURKhxv5topXSBfY402jxiB
         LzYO15aAWW6e7RjeaueEAGTS8K7Ec9P95aEIKppMxQ8miNB953WEomNSvOTS4yYm7SMh
         f1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708382096; x=1708986896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpwEAehth1tWZQpA0TjLevm8DWTiiteNXTP4U1INUoM=;
        b=p3SNbmReNUBhnT6xQNfR9kgfvYkdmU6Ikl6qY+BT7fzbF0fDn1CcfJ1T8guGFhSzF3
         bLsVdRoDN73UHOIHqaunyjq2gYEclmHXlaOW2kZ2ZoIKkdMdG8iKablheA+ckQJHih5i
         VPPoEEfyHBVFOCwwUCf7YzqrgeyiRZFU4pdFCsaV2re4f/VbEbQWI7KMXkSa7XWr9523
         76L0gSX1F/nfJAohFlqWp3I98i/Rfw9ZJBCnZ/o/siMBaz5XjRyljzqZy2vWt5EaZoAs
         TzVzzxoI4+Iyumgy15pOVM3PPpZ+t+/O6lM1gpE9m4tFD68+mFp6QDzKCXQe2xhTQ4Pw
         rMCw==
X-Forwarded-Encrypted: i=1; AJvYcCWaeIqMGhGEf3kPecX6ABZk7CwuimtNrCTVzDw8iJfSSUb17OLT7a1syVyoIi9mT293dCCrg6ff9Oxw4yRyiqV39cUrk2d6Sp6nZ/Ov
X-Gm-Message-State: AOJu0YwAAMnbZNFWxXfK7UtwVYFfSyxEOD4Z1eCsjPzIWp1pM0V1wLCU
	gO+t6lqmgRUUNSU5ySmATPROB8KVZGaYa5ThoCiyBBcmwDWzfErYJnzqX0kPHzU=
X-Google-Smtp-Source: AGHT+IE2e9IPdvZzRdmlGUC/m+SCrl+vlfAO1vOVWnmmv6s7Y3hILnYtoJnl9bqMN42qD9thWqnGRA==
X-Received: by 2002:a05:6830:4cb:b0:6e4:3cef:5e0b with SMTP id s11-20020a05683004cb00b006e43cef5e0bmr8226071otd.13.1708382096244;
        Mon, 19 Feb 2024 14:34:56 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id h25-20020a9d6419000000b006e45a5f0a70sm171776otl.49.2024.02.19.14.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 14:34:55 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Martin Sperl <kernel@martin.sperl.org>,
	David Jander <david@protonic.nl>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	Julien Stephan <jstephan@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 0/5] spi: add support for pre-cooking messages
Date: Mon, 19 Feb 2024 16:33:17 -0600
Message-ID: <20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
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

This is a follow-up to [1] where it was suggested to break down the
proposed SPI offload support into smaller series.

This takes on the first suggested task of introducing an API to
"pre-cook" SPI messages. This idea was first discussed extensively in
2013 [2][3] and revisited more briefly 2022 [4].

The goal here is to be able to improve performance (higher throughput,
and reduced CPU usage) by allowing peripheral drivers that use the
same struct spi_message repeatedly to "pre-cook" the message once to
avoid repeating the same validation, and possibly other operations each
time the message is sent.

This series includes __spi_validate() and the automatic splitting of
xfers in the optimizations. Another frequently suggested optimization
is doing DMA mapping only once. This is not included in this series, but
can be added later (preferably by someone with a real use case for it).

To show how this all works and get some real-world measurements, this
series includes the core changes, optimization of a SPI controller
driver, and optimization of an ADC driver. This test case was only able
to take advantage of the single validation optimization, since it didn't
require splitting transfers. With these changes, CPU usage of the
threaded interrupt handler, which calls spi_sync(), was reduced from
83% to 73% while at the same time the sample rate (frequency of SPI
xfers) was increased from 20kHz to 25kHz.

[1]: https://lore.kernel.org/linux-spi/20240109-axi-spi-engine-series-3-v1-1-e42c6a986580@baylibre.com/T/
[2]: https://lore.kernel.org/linux-spi/E81F4810-48DD-41EE-B110-D0D848B8A510@martin.sperl.org/T/
[3]: https://lore.kernel.org/linux-spi/39DEC004-10A1-47EF-9D77-276188D2580C@martin.sperl.org/T/
[4]: https://lore.kernel.org/linux-spi/20220525163946.48ea40c9@erd992/T/

---
Changes in v2:
- Removed pre_optimized parameter from __spi_optimize_message()
- Added comment explaining purpose of pre_optimized flag
- Fixed missing doc comment for @pre_optimized
- Removed kernel doc inclusion (/** -> /*) from static members
- Removed unrelated comment about calling spi_finalize_current_message()
- Reworked IIO driver patch
- Link to v1: https://lore.kernel.org/r/20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com

---
David Lechner (5):
      spi: add spi_optimize_message() APIs
      spi: move splitting transfers to spi_optimize_message()
      spi: stm32: move splitting transfers to optimize_message
      spi: axi-spi-engine: move message compile to optimize_message
      iio: adc: ad7380: use spi_optimize_message()

 drivers/iio/adc/ad7380.c         |  36 +++++-
 drivers/spi/spi-axi-spi-engine.c |  40 +++---
 drivers/spi/spi-stm32.c          |  28 +++--
 drivers/spi/spi.c                | 259 ++++++++++++++++++++++++++++++++-------
 include/linux/spi/spi.h          |  20 +++
 5 files changed, 297 insertions(+), 86 deletions(-)
---
base-commit: 55072343f1df834879b8bae9e419cd5cbb5f3259
prerequisite-patch-id: 844c06b6caf25a2724e130dfa7999dc90dd26fde
change-id: 20240208-mainline-spi-precook-message-189b2f08ba7f

