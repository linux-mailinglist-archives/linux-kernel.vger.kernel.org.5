Return-Path: <linux-kernel+bounces-71210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDED885A1FF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD4C1C216B2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995A22C877;
	Mon, 19 Feb 2024 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1CBuO4/R"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE7E2C6B7
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342339; cv=none; b=brRaNLZSELHYgeKfHahqR77el4nFXxHYWAoPibsYLyA8AR+Z+9LyGw7u8jL5xdMixGLWp1Ncuwhsp78JrdqxC+whBilltPxiJrE60zbZjY/0l7PoXRXAqiV2Z8qwFAfwSdSgs4AfX0W6E9OoCV6Nt1/VnLEcEbv6rVdmkGNMMbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342339; c=relaxed/simple;
	bh=gbOcFoOzr/7EnXJW4o3Q4MK/WjQw3an8g42KJ/FDXq0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dWnNCEahr9x8vVr7c57bfYGs5WevppKaE3T2XUv2PYe24jZGYjYIycJBFilR61eHt4bd2VQxmbwj2Yal99oq4zOL9qLVzAdW6pTg6jcTlwuHwSZYDYPy8h+uuHLKawi0I25f6GXaVVawa7niCtSAsmtWl7lOED9usUnl+Bukoxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1CBuO4/R; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so9078676276.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708342337; x=1708947137; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F9Y8XdXv1kzTQtopo89RJ5Qe87rOsaXFYORvSusUYec=;
        b=1CBuO4/RaSaveKbljUHIAOCDxj/ECCZPoV05Nyx8PjY8XX1kzUwc/LdjpFt0nn5Hgs
         XGlsKm01jj37E+1hAluCfcL1mfXj0X3BaBq3yIplBNgszrAFmtfsnB8joFgpTm+DRvZg
         ESidV1mMet/f6+9XSQe38TBfug8KvBeDjUPnCFY7LWt3/jCm2NzY2UcdGvfUNZoa0SRJ
         xvdj4lF8dwCQy275dRLCRwZ4o7fw67gvhtR0pjuVs5d7sIH/AYmmSonWfZwGL6itZQi3
         xuVv+K6aU7Jq5DtLHg6IiVuwppSIzJNgBtlcl2C/zNSqt1HAm8MDX01Ei9trJU0V+DcB
         0QiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708342337; x=1708947137;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F9Y8XdXv1kzTQtopo89RJ5Qe87rOsaXFYORvSusUYec=;
        b=bCf1LKEatFDCEI8r3CA+hTiVRr/NHPqW5sRlSlaBfdplS7/JB6K7l1I8AQFrPXWBYR
         eiTHI7B0QyxtapoAr6LmzlnEGDDEStY2mpeLkF5ZliUnYfit4yaV3Lg89o9b9k8xMqL4
         c6MFShif8bgYq+f2HbhThJpkQzFhxb9rWx10g1oUy7VnwwQvaQ6kWkMOP+08gxQbmrb1
         QjB3nPD/KfmtmprMnEwAvNQ0UK9NvPZBgaTcgxXQYUfjAg4rVJD4upPnme1qIJj1pn6Y
         FzvndHM9OTjyJvN9ikwCVrOWiwGjBgLruKIo+00TSE78TrnarqL7dqOoIQRIM5CNhWew
         4EaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwNsDMX4D9I7ilw6s/wsYkj7Zc0tNvDbPfY1PZx5fImZX3uB8FtlaNwiaPIsnnFagk3P99DBN6dVz+a+8KbhQF+nPNoiY6EBbOwTtD
X-Gm-Message-State: AOJu0YzZ9NxlBAKzsikKlaMynltBFHvprY8jaPEGUge5HUz/5z/nWjno
	ZHC2Ep3h9PWVtPjCtTJYQE40KWoNakrA7alp55w7Mt/Itjex43HwQC7lFdDTlZUm3lJyeM/gvdw
	/K/YDPI5lqg==
X-Google-Smtp-Source: AGHT+IFrFQSwNuSWu6/Y6yp6TLKb1ES+/eMj+OGcS+zU6Jh3xmGly/67ECjCQIexHldo+hDW4MAPEIU45QbnUA==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:ced3:0:b0:dc2:3441:897f with SMTP id
 x202-20020a25ced3000000b00dc23441897fmr3248186ybe.6.1708342337288; Mon, 19
 Feb 2024 03:32:17 -0800 (PST)
Date: Mon, 19 Feb 2024 11:31:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240219113149.2437990-1-joychakr@google.com>
Subject: [PATCH v1 0/1] nvmem: Handle actual amount of data read/written by suppliers
From: Joy Chakraborty <joychakr@google.com>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Vladimir Zapolskiy <vz@mleia.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Heiko Stuebner <heiko@sntech.de>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Vincent Shih <vincent.sunplus@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Rafal Milecki <rafal@milecki.pl>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, 
	Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"

This Patch series stems from discussions in patchset,
"[PATCH v2] nvmem: rmem: Fix return value of rmem_read()"
(https://lore.kernel.org/all/20240206042408.224138-1-joychakr@google.com/).
Where we come across the fact that currently the nvmem suppliers do not
actually let the core know how much data has been actually read or written.
Instead they are expected to return 0 for success and the core assumes that
the amount of data written is equal to what the core has requested.

On addition this patchset will also add some guards and checks based on the
count of data returned by the nvmem supplier.
---
V1 Changes : Change read/write callback prototype to ssize_t and
supplier changes to accomodate the same with core checks and bounds.
---

Joy Chakraborty (1):
  nvmem: Change return type of reg read/write to ssize_t

 drivers/nvmem/apple-efuses.c        |  5 +-
 drivers/nvmem/bcm-ocotp.c           |  8 ++--
 drivers/nvmem/brcm_nvram.c          |  8 +++-
 drivers/nvmem/core.c                | 73 +++++++++++++----------------
 drivers/nvmem/imx-iim.c             |  4 +-
 drivers/nvmem/imx-ocotp-ele.c       |  4 +-
 drivers/nvmem/imx-ocotp-scu.c       |  8 ++--
 drivers/nvmem/imx-ocotp.c           |  6 +--
 drivers/nvmem/jz4780-efuse.c        |  5 +-
 drivers/nvmem/lan9662-otpc.c        |  8 ++--
 drivers/nvmem/layerscape-sfp.c      |  7 ++-
 drivers/nvmem/lpc18xx_eeprom.c      | 10 ++--
 drivers/nvmem/lpc18xx_otp.c         |  4 +-
 drivers/nvmem/meson-efuse.c         | 10 +++-
 drivers/nvmem/meson-mx-efuse.c      |  4 +-
 drivers/nvmem/microchip-otpc.c      |  4 +-
 drivers/nvmem/mtk-efuse.c           |  4 +-
 drivers/nvmem/mxs-ocotp.c           |  5 +-
 drivers/nvmem/nintendo-otp.c        |  4 +-
 drivers/nvmem/qcom-spmi-sdam.c      |  8 ++--
 drivers/nvmem/qfprom.c              | 10 ++--
 drivers/nvmem/qoriq-efuse.c         |  4 +-
 drivers/nvmem/rave-sp-eeprom.c      | 12 ++---
 drivers/nvmem/rmem.c                |  2 +-
 drivers/nvmem/rockchip-efuse.c      | 11 +++--
 drivers/nvmem/rockchip-otp.c        | 13 ++---
 drivers/nvmem/sc27xx-efuse.c        |  3 +-
 drivers/nvmem/sec-qfprom.c          |  4 +-
 drivers/nvmem/snvs_lpgpr.c          | 13 +++--
 drivers/nvmem/sprd-efuse.c          |  8 ++--
 drivers/nvmem/stm32-bsec-optee-ta.c |  8 ++--
 drivers/nvmem/stm32-bsec-optee-ta.h | 12 ++---
 drivers/nvmem/stm32-romem.c         | 16 +++----
 drivers/nvmem/sunplus-ocotp.c       |  4 +-
 drivers/nvmem/sunxi_sid.c           | 11 +++--
 drivers/nvmem/u-boot-env.c          |  4 +-
 drivers/nvmem/uniphier-efuse.c      |  4 +-
 drivers/nvmem/vf610-ocotp.c         |  5 +-
 drivers/nvmem/zynqmp_nvmem.c        |  2 +-
 include/linux/nvmem-provider.h      |  4 +-
 40 files changed, 180 insertions(+), 159 deletions(-)

-- 
2.44.0.rc0.258.g7320e95886-goog


