Return-Path: <linux-kernel+bounces-89078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 633D786EA43
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3B3288341
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997C53CF4B;
	Fri,  1 Mar 2024 20:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zWSmUgla"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769ED3A1A7
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324751; cv=none; b=ki1zqRyeRgXMsr38LUJPLWl4qdCkw40gfxY1lSCzht4HgBB2B7WSyfiv/AJa0QbpoT4RRRz+MMPmXjPzZuD1ZqKpqg6Q3i0tKdthA605zIpJBnvenTOM3Iny1HczUFLzOIzDgo7DUyrw2OEQTSaXA6qL/fALqpbjnU1/oWb5pFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324751; c=relaxed/simple;
	bh=x0DFLoC174O3epeySBoaTM35XDoUrTape8KCryCpORc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mHp3XMIhmqMpQxluHL0JMAQLm3HnZRFBlfLqJDZgF/p4WNjw8+IqTXLtSxLOSNqDTh6uEdB+KCLBU1vPOSOCsxX6ayAVyx4XpqBIS6Wn0iBGCVLYlY5oXwSoVADb6hWLyq4s26WJHySNB0iqqBL30AxeUU7EOgtYm8jDUXgDvzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zWSmUgla; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e4a5ee63f4so1198657a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 12:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709324748; x=1709929548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i2nuq+lCNY6xJUUWqdq+PvBjp+jN2OieX7PRxnI0HEY=;
        b=zWSmUglaqY3cox69vAiQYjcraShWC2ORQdqQil3LL+G8HOVsLCWDDbiAjpYHMpE+Di
         /CwWBquDCZp5XtqUz7CdpbF2HaTjte0PehF7dXTBH2xwsDNkU0miOuiltfp9Gay8Yu5v
         lR8vrMNMdi68lD1kyc2iddAO/IOcaFtcUHs8q442mNWfQkr7aVL31TLYdA1RTOHhYll2
         8cbQvTtkpg5x+Iw+LCOZ4P3D48UFePz+M65OvAEOoW9WNJ5ywQjjmqXWwrRsd9+tvCtJ
         TFBq8HHaqr05UCvg1Iib8Hx0k+/y+1e9f9FFuehRuEAhn9n5s60sVgW8jkO+YPDYwOaa
         2ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709324748; x=1709929548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2nuq+lCNY6xJUUWqdq+PvBjp+jN2OieX7PRxnI0HEY=;
        b=EyZqsKtPUo+Mix9CwyAkhBMzpEtjDVjJTT/pH3X8iSPG4/YEkpZVDAfOiyCh843ftK
         br8iMeIzT0AKFGJHb2Nxyyijid4rXrurIl5E+P3EgMq3t7ZE2yYQQTWqN+HSu/2cqt1T
         Ri8iv/MJZNsN/zGoBXk7AKoJrdkM2qfG1w+S428q12Fd2/hC9UlW8u2UZRMmTOzXrT4Y
         9bKeRj6w10JXfOqiPrRhXvKusBE4nxmbSJOy5BOq1YcsrxMluw5+K3290GxbeNrlvule
         0xvzb2QiG2Xw6WRRJ3Lo9od2N00nIBHD0h0B9jnLE57VHQe5gDEy6SXe7dc/uQE5mgrl
         QqrA==
X-Forwarded-Encrypted: i=1; AJvYcCW7cTP6O+MuzVTcSieIjewKXqNt7eAGI4kQouzkkaOkX03+mV8NB8ZGyDlwysGqNZIno60kOukptkJ/ueoU6PmRr9PessmQ9dvd5MvJ
X-Gm-Message-State: AOJu0YyLzKRLr2gB0/7MWZUABP8+ulu80ewXyseM5OucIy51XeJ7XH94
	SPjGcgeejInCAxGgJbOTaV5pAd8DxM7nMVdnOqYUEv8pwAf84ReiAHzJEYIGstM=
X-Google-Smtp-Source: AGHT+IEIRcu0yF7zv3tgmtWOQSxRV+jW5LhwDWLaJSkGdaVRO9G2kgcBsWGngjq/PcjDQAJKwsHWyw==
X-Received: by 2002:a05:6830:12d8:b0:6e4:9af3:5df1 with SMTP id a24-20020a05683012d800b006e49af35df1mr2782874otq.23.1709324748678;
        Fri, 01 Mar 2024 12:25:48 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f10-20020a9d6c0a000000b006e454aa54d1sm806213otq.56.2024.03.01.12.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:25:48 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/3] spi: axi-spi-engine: small cleanups
Date: Fri,  1 Mar 2024 14:25:17 -0600
Message-ID: <20240301-mainline-axi-spi-engine-small-cleanups-v1-0-241dfd2a79f7@baylibre.com>
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

This series contains a few small cleanups to the axi-spi-engine driver,
mostly suggested from previous reviews.

---
David Lechner (3):
      spi: axi-spi-engine: remove p from struct spi_engine_message_state
      spi: axi-spi-engine: use __counted_by() attribute
      spi: axi-spi-engine: use struct_size() macro

 drivers/spi/spi-axi-spi-engine.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)
---
base-commit: bf790d87088a04d5f3a4659e04ff2a5a16eca294
change-id: 20240301-mainline-axi-spi-engine-small-cleanups-cd08b51cb6d4

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


