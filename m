Return-Path: <linux-kernel+bounces-165384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BC08B8C17
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D151F23F10
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F32433A8;
	Wed,  1 May 2024 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kgZWwbJG"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DF71EB44
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 14:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714574706; cv=none; b=ObxFNtGkQdzNM0UuXoindfSIhdZar4x9ntrkgzgsw89dQY6I1g967BR+yzuBINi5VU39cIu5Tx/rk43iQUkkPGM4sIvs+f6pqbBMllkpaExb+n6cpyW2yBk51dTzrBfyXbkBHfv9b/z4BQ6U3fFUMG/VTObR28TMmE4vt22idKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714574706; c=relaxed/simple;
	bh=OVCEA+sMHIn5t+AmYPlgxoh+k+aWKCTPEhOiftVsSw4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=P54UWZBgsepkQ9Q9q9e1AXUv113j6c6sXdjePvV5YwEDV6uWyhubJi9SGnmCnKv/vGXS3rrGnuf6lChnKIQOxlXGzO0rRxtGKxkSvA+JAsfIHamCiIUFZgqhYLoflOsmJIQWUm1ZTWV19TuhCeqHQqFFtWveuuwjMYX66gdntBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kgZWwbJG; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57255e89facso6451112a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 07:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714574703; x=1715179503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=19fONahm4CwkvcFuKCjkaG9ywwBvaJs3VMjRkYN1PAE=;
        b=kgZWwbJGmyhgPBISUGTPFpfiDJYMIzjRKujJ6vhK6fR8gAZ3F1M43V1HvqYor66iUH
         bYvl007S20AvuYBj2qtS8hmf68adwXFZZrxZ/jP6hF0fYT8kwLZBoXi+ZaTkAaHSTy/+
         coBoTG2ew4powGY+ThlABkgHHGTiMOC7Jrj2gYviR4iubf6o/qrSjcpPpn0jnQfbmYdN
         y3YHuQcTWh8G54LMBXK9G62/4RVQmHtPjMMf0h6TKpngfx3kgbFEh2vK3fQN9/evYlEc
         Om0NLe9EaHU2WvONVn+7Klba8I2pfIUBNS5I9WvXIH7dSPShJtu6x9kUBVno5YL/d3t+
         jG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714574703; x=1715179503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19fONahm4CwkvcFuKCjkaG9ywwBvaJs3VMjRkYN1PAE=;
        b=T1Pt/eIP6hvK20vx0GasVCo0hGhvyU+0H7Y9UGPGiSGvIuk/abYwfaNIrE/upNqm6Q
         Wcb7bXVCajM3UmcMJ0dLjwy9Q65KHFmNRslgA25he5ZnR+GPNbjOuBeMf7ebq3GTec0U
         8jlwa57pd+0tLunB7MU9g3Zeb+R9eGFfwS1QFAKagsAIYRyEB5U5/T3CZUawrxGlB4fC
         1o1foLeB6f5PA4D1kSvdS/QwjiK/DPzxLQPueIfCl15GRV764lhK77ecMhSC2UpdWvF8
         ak9zf3zdSFSvk9ivyaGndVaZ5QL8sgjGWQQ17qhydi53ArTTRRSuipaM4X+hfOFgWbZ6
         +Zsg==
X-Forwarded-Encrypted: i=1; AJvYcCVIoY3Nl/m1DVKXLlJFq58KR208Slv5jL9MHWOkWH+k9YcgHUO3apkHS8QOIFa3lmR4Tm7AliTfkAn9jeDl5NmBOu7fMOfTMuz69T+m
X-Gm-Message-State: AOJu0Yz/81TpU4l0tdoemLqXgHG3qw9W63mjiKXA2QtNh4OoN0eeZKDg
	23d9vkAehRp5J7fBlUjz3jaqVEYkvqzHrWdQjn4zIKdtF+yQgs60e596SEyxXzA=
X-Google-Smtp-Source: AGHT+IFWw4+HYpsJ1jIgKWLbzvy0AN2twDF2ubXy00OLPY7mv44CBJ1BKi+rmI9iBBALYYUDnnI0BA==
X-Received: by 2002:a17:906:a0d4:b0:a51:fec0:23ec with SMTP id bh20-20020a170906a0d400b00a51fec023ecmr1764739ejb.25.1714574702588;
        Wed, 01 May 2024 07:45:02 -0700 (PDT)
Received: from hackbox.lan ([62.231.100.236])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906c00700b00a51bf97e63esm16343266ejz.190.2024.05.01.07.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:45:02 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
To: Mike Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: imx@lists.linux.dev,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-clk@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] clk: imx: Updates for v6.10
Date: Wed,  1 May 2024 17:44:45 +0300
Message-Id: <20240501144445.892045-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/clk-imx-6.10

for you to fetch changes up to f5072cffb35c122ec85d91ef327fa8814f04297b:

  clk: imx: imx8mp: Convert to platform remove callback returning void (2024-05-01 14:40:49 +0300)

----------------------------------------------------------------
i.MX clocks changes for 6.10

- Add PM runtime support to i.MX8MP Audiomix
- Add i.MX95 BLK CTL clock driver
- Add DT schema for i.MX95 Display Master Block Control
- Convert to platform remove callback returning void for i.MX8MP
  Audiomix

----------------------------------------------------------------
Fabio Estevam (1):
      clk: imx: imx8mp: Switch to RUNTIME_PM_OPS()

Peng Fan (4):
      dt-bindings: clock: add i.MX95 clock header
      dt-bindings: clock: support i.MX95 BLK CTL module
      dt-bindings: clock: support i.MX95 Display Master CSR module
      clk: imx: add i.MX95 BLK CTL clk driver

Shengjiu Wang (1):
      clk: imx: imx8mp: Add pm_runtime support for power saving

Uwe Kleine-König (1):
      clk: imx: imx8mp: Convert to platform remove callback returning void

 .../bindings/clock/nxp,imx95-blk-ctl.yaml          |  56 +++
 .../clock/nxp,imx95-display-master-csr.yaml        |  64 +++
 drivers/clk/imx/Kconfig                            |   7 +
 drivers/clk/imx/Makefile                           |   1 +
 drivers/clk/imx/clk-imx8mp-audiomix.c              | 155 +++++++-
 drivers/clk/imx/clk-imx95-blk-ctl.c                | 438 +++++++++++++++++++++
 include/dt-bindings/clock/nxp,imx95-clock.h        |  28 ++
 7 files changed, 728 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/nxp,imx95-display-master-csr.yaml
 create mode 100644 drivers/clk/imx/clk-imx95-blk-ctl.c
 create mode 100644 include/dt-bindings/clock/nxp,imx95-clock.h

