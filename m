Return-Path: <linux-kernel+bounces-62532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C158C852274
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 398E2B235D0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F67E4F8A8;
	Mon, 12 Feb 2024 23:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MzkgzzL3"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ACE4F5FE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 23:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780477; cv=none; b=Pm/VEwQMZBGledi24Ytb632HLEj20VUa3hIgHuTuxp2ewgOnpc6Cx/aY43azldeIueIQp8S6CJGWUUcJpr5O2p42Az2h4UTKbyiRhxoC/n4PLQnTa6Gus1lKlhUaMSyTJGvbddPvmm3Ky7GSc81rtbdvnEMw0aHn/Ij+E4xudnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780477; c=relaxed/simple;
	bh=wQOLAzpAqdTMxbzgxQagsub1MlQcJ776NbBb/5ZmX74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R5fPwsatL7kJx533NlTXb6oOgJzYLkZXLwHxCqpbP49sc895/VlzRR8F+xcvQc+NfjB9f+lHR5/hhQ6FDYmBOG8sjcGvJb8KTKJX6BNtvZrXvUFb/6hw3/U91sZsgjRmfttVJaJpTzRBSFSoBLRthiG1Fhrlrzlszp9JHWRsn2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MzkgzzL3; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e2de202d9aso1146719a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707780474; x=1708385274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3+egtMFSB5wP/JnRwyX/FLjZ4VS6y7AaGO4xFQVkuUk=;
        b=MzkgzzL35sh2Hd+HStux+3lGfZoFx7BkilNaOUALWkvWugwmOYoS+6P5/MfIdtzwLr
         ehKLKlttNTDbLLxsqJMJt4c4fuJKu3RayyfQgcocUWMvtTjSN/i9xXGldsBtTBFEa8UY
         3Sp8WFg7OhoUlZ0dppHfWFLshzgxwsJU7rqfRyF7uR+7J1oSHBIChuiMXaPqCtH6b2ni
         FTPmicM8416vHwfK6s0L2b7ru3nF0eOtA5TemYDxy2Yj3/1VT2jrX7m7H2g8p+ITL+ie
         873w6fL2sG6YOZ5odZn17r2CGHxBZOSlO5Zlsjs24qKoRBqH0wn6SMlp00w0jdjfkqUf
         85Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707780474; x=1708385274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+egtMFSB5wP/JnRwyX/FLjZ4VS6y7AaGO4xFQVkuUk=;
        b=jwkgB1oGso5xC4kp83gX9tKJlJK5V2TDerubLAwBkwptpQaxDxbiTpRMG2MESnW4RS
         i9hmXNjQgH6H2eJq7DxYB0vlQjNgBf4dtgKfp/yMKjurgsWgDWFQPdki4ojq2hsvpAr3
         JWbji9j8f9HedhLXuAvZxciLHNVzY3N3ZfQesZkRXupAiQKULs3mAy1lNxXv2cy9O0tA
         K+l+jk2eT523NggpGW2uCBOZ5W52CaFco8DppTVBEouzWpq7rhADM9c8Ubp4oFQeHgD0
         Lm6p8gnf9IB7aUJ+HnNCyPgNJW9uwr0UqWuSoQ7Faowvw8wjYPwAdIbJB6s/1n8qbRaU
         qmvw==
X-Forwarded-Encrypted: i=1; AJvYcCXUIQRP9s5OMB2o+nwDkMmBjY095kyw2KX919XppxmkSUPGbgopR/3hk5MLMapR8v9z+tVxzAuv7GQlTr/KbCfTlP2YxbxRBydAlpj0
X-Gm-Message-State: AOJu0YxVuEbRd/RDQt4lCC0ugZyqzJOqrqqA5r/Iv032px6Mh0ZiDkbi
	Mhw4vw97F6iep0FtUK0JrIZrThGoeNV0nXCadXuWByhsz2zkeVSvXYMQr78fWdM=
X-Google-Smtp-Source: AGHT+IEnqNuLs+L+SkljOkSHhq48382/YhpcidnWFKrPiXnIR0zV1wGkfWPgAvmmTXxR3uMFQYBdTw==
X-Received: by 2002:a05:6871:80f:b0:218:55c9:bb20 with SMTP id q15-20020a056871080f00b0021855c9bb20mr9748766oap.21.1707780473886;
        Mon, 12 Feb 2024 15:27:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVBCLWzInzImFpjlEde3du9xxWbJtlsO+FIOwVJCqeIGb3XUsPpgQL9MqOSJhqdb/VUAjFuoxvugBtbTKi0LRU+DEKsVET+S1y2BKftd8n6uHN7eeWchHaIuejP1qVpCOCqRjZ3rAXp+AA2CHyMY/eGgTU4nz9PpqD+iqlOeB3kH1N1kKZ7mEr1PH+lJ7gWJDxlmsPqZZHS0DxgHZpOfGcmKawoi/MFfiLH+0ce4Kbn6Y+/gewTIz+E2ZdUOnbXW1TGZMKrbwASINXfQwv80bKsZ5NIf94Sw9NEVO3RBB/IIoXmP0ie0xeGEHT8UiIrqoS8kPntNLX8W8Hcdi3VobfLuV7GLDGv12WG9ityJo9cjFG26LHR7rP6t7f1S7xMAubULcG9BWN44pTpMGAE0FbXXrXzpPbX/+lBsk/NXOlX9/U2dLT7WeQc4mc9RSWZikiWe/v1k16bK24UkDKgHCLfm156oNu0rmFechfXGHcU4GPpxjnzd2n/gMlEIuV8Ejo2/TY2z3/Ue/fUm1amIh69Ij5EeMw=
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id pk17-20020a0568704c1100b0021a7a45e0b1sm330141oab.35.2024.02.12.15.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 15:27:53 -0800 (PST)
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
	linux-iio@vger.kernel.org
Subject: [PATCH 0/5] spi: add support for pre-cooking messages
Date: Mon, 12 Feb 2024 17:26:40 -0600
Message-ID: <20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
X-Mailer: git-send-email 2.43.0
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

Finally, there has been quite a bit of discussion on the naming of the
API already. The most natural suggestion of spi_message_[un]prepare()
conflicts with the existing prepare_message controller callback which
does something a bit different. I've so far stuck with [un]optimize()
from [3], but am not partial to it. Maybe [un]cook() would makes more
sense to people? Or maybe we could rename the existing prepare_message
callback to free up the name?

[1]: https://lore.kernel.org/linux-spi/20240109-axi-spi-engine-series-3-v1-1-e42c6a986580@baylibre.com/T/
[2]: https://lore.kernel.org/linux-spi/E81F4810-48DD-41EE-B110-D0D848B8A510@martin.sperl.org/T/
[3]: https://lore.kernel.org/linux-spi/39DEC004-10A1-47EF-9D77-276188D2580C@martin.sperl.org/T/
[4]: https://lore.kernel.org/linux-spi/20220525163946.48ea40c9@erd992/T/

---
David Lechner (5):
      spi: add spi_optimize_message() APIs
      spi: move splitting transfers to spi_optimize_message()
      spi: stm32: move splitting transfers to optimize_message
      spi: axi-spi-engine: move message compile to optimize_message
      iio: adc: ad7380: use spi_optimize_message()

 drivers/iio/adc/ad7380.c         |  52 ++++++--
 drivers/spi/spi-axi-spi-engine.c |  40 +++----
 drivers/spi/spi-stm32.c          |  28 +++--
 drivers/spi/spi.c                | 253 ++++++++++++++++++++++++++++++++-------
 include/linux/spi/spi.h          |  19 +++
 5 files changed, 305 insertions(+), 87 deletions(-)
---
base-commit: 5111fd347aee731964993fc021e428f8cf46a076
prerequisite-patch-id: 844c06b6caf25a2724e130dfa7999dc90dd26fde
change-id: 20240208-mainline-spi-precook-message-189b2f08ba7f

