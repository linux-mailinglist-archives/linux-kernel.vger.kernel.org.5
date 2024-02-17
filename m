Return-Path: <linux-kernel+bounces-69782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0413B858E80
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936E31F2213F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA19A1DA2F;
	Sat, 17 Feb 2024 10:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NvHKSIex"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E77D149E06;
	Sat, 17 Feb 2024 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708164140; cv=none; b=EwZgrY8k6UqWySZqLNGP0G6c+yqGqhd5Ois7fD9D5fkI3zX0xqN2wwWU5LGHCgUeVX1ArV3xtiiVgqvIOdU8n62a8UENrrE3t+7QCfvlHENL0VFmZoZp8Esp7fmTuguriXQ5GaG9RJaoZn7aOSfgyR88JmRdE/hI9yj/FvBXYnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708164140; c=relaxed/simple;
	bh=0JXzzlenC/WtCeYWanwZDCp1favaFop7UuuJyfLWbNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PAiSxCwZrfhFE/As2fQE/xegjxZXAe3svI9fFVc6fNSQR0Wf6pJuMf55evR76Ryket26s1FnLmJlKdmnr2Lw/o+K5PlhwhQcW4v0uLEeqDRjQ/GOPdVLmwk8u506EvzdtwAvdAAYK3QSA8j1E57UqrUkFZEtwal2npqtE9Kh8pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=NvHKSIex; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3c2efff32aso332505066b.0;
        Sat, 17 Feb 2024 02:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708164133; x=1708768933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eWhILoutvxlGO3LjyfOJc3gSpbG+WRABt+VCrcq4VDw=;
        b=NvHKSIexMsG6NsdbfdH/5laLNPVZDFkNc/rJiEk65Vt2M8B6fUuLukKlYWx2qpmPt+
         8i1Bu2G/ye/fmGNv4XHOI3HhrLBVYeIT5LWXjQHfY3VQ8l8evReZoC34v8g5XklVKk1a
         bb9X73gnDrwGmkfFFljw3LlJbMdUMjpqy/AF0s2ftbnjaLS/LE1IyN9rvKGkA/C7CImt
         8hVokAb0aFZGyUmoc/yZAPeDGbnnpMQnQVPZgArzcegnqNSdmiKDUV7pOB4W2pOWCBf3
         5jPll9zQQnAnD5uziA0kzOWjLobB1XhopgwcIglw8/kqxVf5uxGCifhEuGNyI6yfnpbF
         zFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708164133; x=1708768933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWhILoutvxlGO3LjyfOJc3gSpbG+WRABt+VCrcq4VDw=;
        b=Ev16DfJVrGFG4Rm22X4dzXn5KB6MvY6BNbGRzTrU7durTOrYDTB1LRw5be4li+6FIJ
         GH9GdEaR/RclNO9xhSbkum+B8nAQIIbhERfQwE8qYCps+uZHQjvDB0PvVyFHIj4RESR2
         2Xs0+MxecXx/ucVvuGTiri7gIQQBG0IqP2IfC0bom4SeeokB5thqoj2pzUchysgqT+kF
         pzdrtKF4O4g6LRCkH7Sfurw+Meha+YSQsHvcwlnhrLU6dIVzN1HW5VsrTyUhTE8Uaojb
         VQTz19e5pgsEm5aYazpRuaOuk7G2RhbTe4OxY4kAHNTgMaVYJtkNqahdcmi2Zo8POc6M
         gPvA==
X-Forwarded-Encrypted: i=1; AJvYcCUw17FMrPMNL9P3RIJVtH10YZSG8t3ZLRYfLcSAyYc986fjpspC3zp8K7NDtJO28SAXsUtmP2wqv2/2agYLmGHGoQi1sayUuYYfcqMO5Q3nlNpaY3z38YuF/SttWPXRGLEeR0iCVYOJ
X-Gm-Message-State: AOJu0YwE6dkKSgcXKyvfrgE7xp/jPRBuJNaJRCxg6AEvLfp+geLTTvxP
	NFaXP3k3fP1OIc7Rng0HzCkdEiUFRjgiLYmPqUWzd/lolKtW6/a8fJh1gT0l
X-Google-Smtp-Source: AGHT+IFuYu924WylpLiYh6yX/5RoYWsiWz6/8ykDj34FpmqRbFWVMcDvgeqHxLpBjFAD1OYBPATGXg==
X-Received: by 2002:a17:906:79a:b0:a3e:39a6:d39a with SMTP id l26-20020a170906079a00b00a3e39a6d39amr329817ejc.39.1708164132597;
        Sat, 17 Feb 2024 02:02:12 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c18b-3d00-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c18b:3d00::e63])
        by smtp.googlemail.com with ESMTPSA id vu2-20020a170907a64200b00a3d2e690abfsm832444ejc.122.2024.02.17.02.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 02:02:12 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	ulf.hansson@linaro.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 0/2] mmc: meson-mx-sdhc: two small cleanups
Date: Sat, 17 Feb 2024 11:01:58 +0100
Message-ID: <20240217100200.1494980-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Ulf,

here are two small cleanups for the meson-mx-sdhc driver.

The first one is resolves a TODO comment from when the driver was
originally introduced where devm_clk_hw_get_clk() was not available
yet. Nowadays it is and we can and should use it.

The second one removes an incorrect .card_hw_reset callback from the
driver's mmc_host_ops. This part has never been correct as we're
resetting the host controller, not the card. It didn't seem to cause
any issues so far, which is why I don't think that it's -stable
material.



Martin Blumenstingl (2):
  mmc: meson-mx-sdhc: Use devm_clk_hw_get_clk() for clock retrieval
  mmc: meson-mx-sdhc: Remove .card_hw_reset callback

 drivers/mmc/host/meson-mx-sdhc-clkc.c | 43 ++++++++++++++-------------
 drivers/mmc/host/meson-mx-sdhc-mmc.c  | 13 ++++----
 2 files changed, 28 insertions(+), 28 deletions(-)

-- 
2.43.2


