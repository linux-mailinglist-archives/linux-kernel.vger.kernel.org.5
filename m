Return-Path: <linux-kernel+bounces-122880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3394888FED4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6508DB22252
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8B37E772;
	Thu, 28 Mar 2024 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="afww3YBh"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3840F657C5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711628394; cv=none; b=RpLsI0M6y9fzl+zV6BY312Gbv5Xz9d5vEalz8b/c+2bFM3gDhOfg8s39qpiOeovWabZ/APnkSsYAQ5XNyq1Z/3l/fZF0JTs2fBM0lkCiWVvr4vhhEwxa8UYZ8QoafX+Vo64lzSfffr7iRNQxrUJIHv22htkMPH/jxbEfKnpMZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711628394; c=relaxed/simple;
	bh=8OC7F9NrLDAVSOLY/GxL9SqlSdsWf60EqN4CyPvbhBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XP/AbnhPnVkwHfY3JKFIQif+dqmlqWG6MOMYxUZz9KxcYWI37BPqJedV9Qbg0M4MuBPlPYK3KINH1FJG3OWxAeDnJfuKB5w9JLkS5h7MsSjoUSy9Tl91t12LY/LaduEio7VSMGBAD79wkrOpnJt1/ieFYaJsKkoNggERWlAuT6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=afww3YBh; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513d23be0b6so882416e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711628390; x=1712233190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WJ59ZV3KPsH61i+BFxMy2xWaK2/DKTLO7TLG1i3fEPc=;
        b=afww3YBhCIsTndJMvbQBOAh68Bm9jscthsoQxxvIaRuTRADXLYHjA9oBmb5jHQRTN3
         vA3dhe/rKNJ6q7ESxNk7Fj69aBV/Wd5zfDoMR0EgkFa1JAo72Gb40sGScpm1mHyZNb55
         K5g2nrQd+Y9r41KwfOjRjblU1iMPeqZRYuwfSPSVEihzPvIg+Z2VJnk92s5BZyMF9H3B
         cc7xi9VRUz0y48dAg6YNV8mtJXRTp0AYoBF8Dkpx3JmG0yoBKaicQ6+vinwOGQfJpVtc
         g4e2hjapVbfJ00H1tf9dEu/3VgZpiuWUotdNmKZ7hQ/tdDPAb+RLaDKdgDIC+SknbfB9
         TUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711628390; x=1712233190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJ59ZV3KPsH61i+BFxMy2xWaK2/DKTLO7TLG1i3fEPc=;
        b=nVJuQr4qmdjEkWqVt31E4N0xDL+Gziy3FhkARnwllLtOLNKLJHMZExW0UdSIIlfUke
         YCC1kQlmvxQ1ozuOzNXHvzv2UXsVkYGCa/OKWKQ5npVAuw/2dL2lYB31GKXaVe06QTik
         Gzd7cqxvyubs0O1TZdctYMY5LxgEnAHW31B88nfN6T+xz4/gMxrZUzTsSwcM6lN/ItEa
         1LMFQtomKtJ0+NArxsRSRAf3s8EAeXz5hD0mfJxQXAcHvAl3/249weckmXGrh4mbECyg
         Q1bZU47Bu0KCYazguRfNRAeIIOjov1IVSD0abRnsAlHWF1hEfZNlu7yvRZUw3YpWXeAk
         qOvg==
X-Forwarded-Encrypted: i=1; AJvYcCUHlI7RO+qHbhHrzEsJSvp9NO8RJthYvoDsEs1x2GMuhUnXOMpaMsu0sSIipb7/gfAUgUmYdTKAvVkmE23NgL6G2UwD+HJJVB0aklZT
X-Gm-Message-State: AOJu0YwhUxmwCAydAf2AI5+nehCYeyDwm2xZq1d3aLkVWByNJe/Fk4tz
	3zO7GQVc+xhphRevg5R5y5fhUn5OM+OoDaAp6JwTQ4vdb+eQgEIWujGCiztkAZw=
X-Google-Smtp-Source: AGHT+IE5kTiwn0boBAb+g9bwIMv2CFjPpN/NZUh/cWHgxep/P4SsFHtV0a7s/GhSXkBxUMdOr7WB5w==
X-Received: by 2002:a05:651c:2320:b0:2d6:90e4:1ced with SMTP id bi32-20020a05651c232000b002d690e41cedmr2267038ljb.22.1711628390399;
        Thu, 28 Mar 2024 05:19:50 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id bd9-20020a05651c168900b002d494896784sm209411ljb.55.2024.03.28.05.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 05:19:50 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.9-rc2
Date: Thu, 28 Mar 2024 13:19:47 +0100
Message-Id: <20240328121947.2533033-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.9-rc2. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.9-rc1

for you to fetch changes up to 03749309909935070253accab314288d332a204d:

  sdhci-of-dwcmshc: disable PM runtime in dwcmshc_remove() (2024-03-25 13:12:46 +0100)

----------------------------------------------------------------
MMC core:
 - Fix regression for the mmc ioctl

MMC host:
 - sdhci-of-dwcmshc: Fixup PM support in ->remove_new()
 - sdhci-omap: Re-tune when device became runtime suspended

----------------------------------------------------------------
Liming Sun (1):
      sdhci-of-dwcmshc: disable PM runtime in dwcmshc_remove()

Mikko Rapeli (2):
      mmc: core: Initialize mmc_blk_ioc_data
      mmc: core: Avoid negative index with array access

Romain Naour (1):
      mmc: sdhci-omap: re-tuning is needed after a pm transition to support emmc HS200 mode

 drivers/mmc/core/block.c            |  4 ++--
 drivers/mmc/host/sdhci-of-dwcmshc.c | 28 +++++++++++++++++-----------
 drivers/mmc/host/sdhci-omap.c       |  3 +++
 3 files changed, 22 insertions(+), 13 deletions(-)

