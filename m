Return-Path: <linux-kernel+bounces-64404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C442A853DEC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F6B28EBA6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A916312C;
	Tue, 13 Feb 2024 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2bfxdz5C"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950B26216E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861500; cv=none; b=QP4FM7jJqCLd3NmS7slq0OKJJcXjEkcMblkk/axB9huUfueX3TUxPRKpnbp1ijX0owLZECNF8p/sPaCdwAxgAzoPJ0mBl0ByRhgiufQ4l1Mk1XGVT0anlf41AkjD3Wt0iDQu3855N1pUgO20eAbjr7O5XY2LhmvEebOVpHoE5RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861500; c=relaxed/simple;
	bh=fG6Q1QiFR6PmovjVj2fEe8hauDiQX9AI9JtszF3W1lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m8Sx/w4eAoUEa/1ZnrlFQ3U4a6f3PI4K1B7PwmUYGR4skwT0f/hR/LXIhTBIaajgrLDoEIP7XL1hajLtxvLZ0izSZ2uObiN93L7P612MwSnIkoyFlffRZDCGwSsiHJ/4tT1UyXjRwdFANfwN36Y6z07YRP1Fyr0u4BM3pxRGZao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2bfxdz5C; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33b66a7f859so1827273f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707861496; x=1708466296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JTFkdUvqDHeua3DO9ZE8KGhtt+pXkN0o9OOhcSIs5kI=;
        b=2bfxdz5ClgCidhARiGwYjsbfpSDOvEV3mtqi862tqWxyU4Ba4grASYjQl/8bDqYEMV
         3aAcsuS+DrDmJyCcFIkY/IDIpSjpAT7+ditmjlNRMOJ0qg2ZJPSj9w3bKefuyOV4u6h4
         r43HIdv6wYyathKIyiyOGBchzhrj578JXBKV7sSBjwj+mxD35aPP6QcV02hhPiMCwAq/
         MgpCjqFu+yztAJ8bupAyUkaoNvDqTXe8jgocBtFU9qVqk9/h4Oxj08U9HfHwfL7SVeKs
         RRvG0vEY/5kYw3oHiuESVKQc5RnD41WQlXjq/PONl43KHtgPsDqrrZRXZ9btpTdwZ9Xv
         bTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861496; x=1708466296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JTFkdUvqDHeua3DO9ZE8KGhtt+pXkN0o9OOhcSIs5kI=;
        b=oWknQDXBZriK+2EXD4lcUOuKUN16SG7bWpykSBVsL+hwpsn85p3wxovzYWdah1BQhr
         rkyWa4nOkIglwcZi5aBzORUKByW7z79Vp1cEO1DuRFMarNVf0+erSf7E2x3SmZkVs1Rx
         uNGGC+MTJypiKlOMElKC5hsJBdPVhoxOqRRFoR1QXbyOSMNAtUWoZdzOmCv1b+lih5Kb
         R5PR2zS0TK1jAaJChUIQ+QjvtllcEDpRBw1jSl50o5HlODeasRYEIEKYR9pFe809DZAS
         PRFGtzYQH2gXvNBk/aDbRH8+rByYPBNH1nCV/ceL8ZsD0xSQRwXObHpyl6YfJshYfVUo
         RDdA==
X-Forwarded-Encrypted: i=1; AJvYcCXlrl32dWkzw5ZZ7ZR6EIuOZVgstmo9dZ+grFBTghmiBZMvTKYYav196OITJpYcz0uIqK7zjf6X0CQJBw/ORDrJ0BRWmbCphykN49kL
X-Gm-Message-State: AOJu0YwMY5VUEAdV6WbkuJ6VLenzNZZq+WWg4gyBLfrdcR2Bo25LmwXT
	nFnYQ4UFiCi1l+ud1fc7BowtZ1PG0E8i5uOCTlMQq7M/ADJbwVCXtrfv0mFY6vU=
X-Google-Smtp-Source: AGHT+IEvF9YysnB+h9yQmXedxh2DZ1klO9I/GaHAGPGFJ/xyzrf4xPser0a/xrJw7KqwTxEY1n/K1Q==
X-Received: by 2002:a05:6000:1e84:b0:33c:dec9:a269 with SMTP id dd4-20020a0560001e8400b0033cdec9a269mr403220wrb.57.1707861495863;
        Tue, 13 Feb 2024 13:58:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDhr6+e+5qjE0+9Mw4cEpFjAFXBxy7lvahl/dXNLc4oKDO+uMl+AqZFDqC/VhnfJ2IXWUNIqwOxedeeZ+wjrmUZc1Fe2gpVedxuJNN5OlaRbtIaAP4oPoW3QmhRzlxky9J/Ovv/Es2NvK6bzgsP/Tz2sps2oihr/qvKiqyZ5Puv+B1RAWJlXgOguK7mCZFVDtV7zwLXtxQCQjqUPKqv5+cGOqetxhWGEWgpxTM52qr2B+WyDUin1UvGQp45l7cJ4Ke8Q53c4b9lNfJQctutivgKWXGXWKQMnX/AVO73GxFgBsfY7iFPj8RbGDNOqID4sWqOubeVd93IM/Mh0BJ5J6oe9GTFDwiIjZcu1bQwWUY6Yfi9wBaSaiM8gs6eM3zYjxPRzeQ7AwLqQ3iu0FUPuXcfBHtuWVL0yqORytKv6KuGmrqsva+lnxTYKgm54WQtmUuURzwV3QouQiA4wtrTdk3uSf0AptwXWMXM3R/iCUWSJqBDAMf7Mu1BmnvnJdz6t/rDMkViAkdhWAQVIthhnjPAMyFqW4BFbsWCWbJgM9TfxNzdN9tCCAyTJYO8zqP6+2ZX1fda/Wmf1xc0uoCeB4M5wYHHTNAKcEdLnk1cT38hgOq7mc=
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:af6b:4350:776e:dcda])
        by smtp.googlemail.com with ESMTPSA id r3-20020adfca83000000b0033cdbe335bcsm2415244wrh.71.2024.02.13.13.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:58:15 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 0/2] ASoC: meson: aiu: fix function pointer type mismatch
Date: Tue, 13 Feb 2024 22:58:02 +0100
Message-ID: <20240213215807.3326688-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

This patchset fixes 2 -Wcast-function-type-strict warning in amlogic
audio drivers with clang 16.

Changes since v1: [0]
* use devm_clk_get_enabled() instead of adding a dedicated helper in each
  driver.
* Split the patch, 1 per fixed commit to make it easier for stable.

[0]: https://lore.kernel.org/lkml/20240213101220.459641-1-arnd@kernel.org/

Jerome Brunet (2):
  ASoC: meson: aiu: fix function pointer type mismatch
  ASoC: meson: t9015: fix function pointer type mismatch

 sound/soc/meson/aiu.c   | 19 ++++---------------
 sound/soc/meson/aiu.h   |  1 -
 sound/soc/meson/t9015.c | 20 ++++----------------
 3 files changed, 8 insertions(+), 32 deletions(-)

-- 
2.43.0


