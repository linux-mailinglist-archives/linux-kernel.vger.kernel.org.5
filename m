Return-Path: <linux-kernel+bounces-168150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412608BB44F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717171C228D7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE48158A3B;
	Fri,  3 May 2024 19:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iGGlUw49"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC6A57CAD
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714765525; cv=none; b=sHUTGqb543GZYqWOVoz4qq09neDv5/7zc8WjOB2XnvdwAY9DK728BwhE7oMeWkMcO7yRXdMZrMDv7y1NuNVdcVrtl5wwZUKiHypZQVb/XHQkEa8FFWBXZ9e1ARbPmolgPWP5P0QKxQv0dimmzdldryEVLH6xVuQoVf4zbTQYm98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714765525; c=relaxed/simple;
	bh=7VvvDmGNTombj2P/zeQa22gthcNvO5+oP6yHr7dKhY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PjbDVuE+H/wyS1lPcTZwcXwEcRQUIJAh9klgG2trNBEMywr8NIOLV12unwVYbW5zdh4HtTduWmdScFGPFJwbveZf+qxe9BRdpuZXkglaM6i4RuBjd+kPh4EdjbSgnDWH0VdZH1U6cu9RU/jOUd0FvEjQsSMvNG2llf6baMKgY3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iGGlUw49; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c70b652154so5752804b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 12:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714765522; x=1715370322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6FFzQiTw1LygBBk9VXhXQOHEICb9VgUAjrTiljBLyRY=;
        b=iGGlUw49GVXF7g5Fc/7DraKi1pTGeny24ktDd+y6Vr3Id8FD/wOS3TmRAdeRQmIPN/
         CXoA3N2DL0NIWcWPiesAJJWTYfifCd0l4ro+1wPO7mqlD4q6BFed4Iv7kUdbCI08HWjD
         uMTwHJkEUSEGqVqvs9Jy6c1R2HEqANrJMys96MQtMzNMYVKKL+3FqFOhRH86Stzb5Awy
         kVCEBe0eCjkjewdaSGAJJ4qbaVuwGqZ3C80lBwDuUYYztHlOZNydF0LWl3Q3TqvcnL/R
         3PfOuAWzOb8rNQU/DqxvUC0ZyMx2ujWi+L9ti58sYApoFpXHUZf4BjlY0jcQouTcRPqj
         T/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714765522; x=1715370322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6FFzQiTw1LygBBk9VXhXQOHEICb9VgUAjrTiljBLyRY=;
        b=vSubf0qLwPqP3ZkUfze0ldU3jaFAI7VJgOeBfk5OGXk8CPaoI2h1wYC4K50WJr65Gr
         UqFd8pG9XfNHOc912hF7JNjP0tSIX5JSXj2g34MXWuxGjqDBRTDpDVl7nVZDtIY8oeL+
         9VXol1n09GvGjz+3Js7a1/xBritvUCX/0UA7THv0KRq2RNpIf9Wo3htnwlU8bZC6mT9q
         f8D+Fia+VJzeS4n4THVr1MvmsvM/qmGN41/DrlimUPWVgtsNGqlfZo5l4z+6jRn6s7+n
         dVR2DgVP1FoxCBL4cvoyNnIrszvyhAptK3hayZCsk67eSto3sltz9TQlEBUNUp1ABD1a
         3x/g==
X-Forwarded-Encrypted: i=1; AJvYcCW0z2L/QWIGjpOPPqbeSIGj3hHE3HyMnQx8RWgki+yfgQQscSoQuAgrjmUbp8op9z5KIEfRAqQ+phbegBZNvBjtIcDcJ8CeCYUMq/zD
X-Gm-Message-State: AOJu0YwyIMsvK3yOKW9gUacGrOOaxb1aFm8F2gx/PKWgGDyU7OB7/YIl
	lZ1h1BOMJPlLLzH+pfrzM3W6TffaClOhSFydBb35r+KNjaWHDL8cqRxoZLU+zm0=
X-Google-Smtp-Source: AGHT+IFvkST9EFfa2pNqRBCEOc3Dn75TAUp6KGLuURX24X1rRpjvL8atYQgNXKlUuDrEzU/jUqPzKQ==
X-Received: by 2002:a05:6808:638d:b0:3c4:ebc4:dfa with SMTP id ec13-20020a056808638d00b003c4ebc40dfamr3938782oib.41.1714765522178;
        Fri, 03 May 2024 12:45:22 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id b6-20020aca2206000000b003c5f99a436fsm609129oic.15.2024.05.03.12.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 12:45:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ad9467: fix scan type sign
Date: Fri,  3 May 2024 14:45:05 -0500
Message-ID: <20240503-ad9467-fix-scan-type-sign-v1-1-c7a1a066ebb9@baylibre.com>
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

According to the IIO documentation, the sign in the scan type should be
lower case. The ad9467 driver was incorrectly using upper case.

Fix by changing to lower case.

Fixes: 4606d0f4b05f ("iio: adc: ad9467: add support for AD9434 high-speed ADC")
Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad9467.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index e85b763b9ffc..8f5b9c3f6e3d 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -243,11 +243,11 @@ static void __ad9467_get_scale(struct ad9467_state *st, int index,
 }
 
 static const struct iio_chan_spec ad9434_channels[] = {
-	AD9467_CHAN(0, 0, 12, 'S'),
+	AD9467_CHAN(0, 0, 12, 's'),
 };
 
 static const struct iio_chan_spec ad9467_channels[] = {
-	AD9467_CHAN(0, 0, 16, 'S'),
+	AD9467_CHAN(0, 0, 16, 's'),
 };
 
 static const struct ad9467_chip_info ad9467_chip_tbl = {

---
base-commit: 827dca3129708a8465bde90c86c2e3c38e62dd4f
change-id: 20240503-ad9467-fix-scan-type-sign-425daca1bb83

