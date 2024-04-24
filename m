Return-Path: <linux-kernel+bounces-156500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F27A8B0368
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38DC282C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4902A1581F2;
	Wed, 24 Apr 2024 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RVoIN6Uq"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B901581E2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713944574; cv=none; b=bRRy2tl89yB8ObGyuzA5Y6xG/hGSeC+M9mwawWPf2oPY/f/KiFtpfSaQgde7UO83OkNf0ibX4soMYfi9Ql2HblnLzXLbJIMjYoUZbQFwIeqFR9x/7y4JVsgxVJXGX1sjjQE1EN1z+EdLZh2PC9FkuL9qGnJa+s71AlbpgpHlyWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713944574; c=relaxed/simple;
	bh=KEOY/H38r2q4LMqOZqaCRp80aSw3OHhkx+jVNw2tNvc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=loOSBoG9bZrfU0Bmpac+NJlDw8RZd22IYjMrxKwuL5wRsvGpXUosEwcyW9uosMajh7ZLh2CO7O8Mvn6Embt8Kc0DH8BHQrd6Iu81ldD3h4gWXSoNbC0FjAC7Gf/Fufd0CRXdxwXy7mLLhpDgTpEX/Q919fpLehD9P+GFdSRx7oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RVoIN6Uq; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61ab173fe00so128958207b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 00:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713944571; x=1714549371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zl0sYd+valIIqLNedoYvnicwykqmWgTtyjDljuZmiec=;
        b=RVoIN6UqYxyAd44cFqI4HdBfPPfIJNwdxG9tps4jglVmL9AYADYK8f0VP8KPPxHtjD
         xVmvSgIaUQWgZujAklMzOANFcLXv5IwX0BS/cRPwdYe5t4MachnUvaiOUxtjOM6SMmX4
         3s39ErUlGb4zOgJTIi7rHwg+l378U4KKdalhkU2ZZ7hh4/i9t8p0cheuxblFAXqrhAbe
         f1wUjTjkrJ5B43u0RwswtYzosthTKGdFjyrBUfv7hT5zJ+71pUpUweZtbSsdhCqT9fcf
         DHei9J68gt9snSxlGnSvQxuPn34inQg/QfRnDRmFQq8gEZ5q7WjE6JwOJk3KdOQhl1Fh
         4qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713944571; x=1714549371;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zl0sYd+valIIqLNedoYvnicwykqmWgTtyjDljuZmiec=;
        b=uZfQlJdczEsbNhuxvVf4TOcNCJNhvE6HeTO8cuN/3VeHKFrlLS92NdjH08hcBhQ2Jo
         7XaXbK4Pwxpug58tXFp8ALyrNcPkgRSoXZcpmNqzErsIaK7XzWK2yCEdyl2BQNfLTfo6
         SHW3FrYRHO/8V8us/LqbkZis9m+qTQLpetC1mRUVUvXWmgYsET3rBrXNLAitnAA5m/1H
         1BO+q8k9wfHUtqNzSxC7uvPZFycpQ/NrqbxLL66nnY8ZM+pWoR8Jtdtl5e6i/iXEd9nh
         te6oIFPIlaHoVQBQXV1Gw+KKpoPTf8WWBIT1Ev23NonLlsBUZZzf9Y6YGAx5mhmhbc0N
         EXXA==
X-Forwarded-Encrypted: i=1; AJvYcCWGW0qeaIEzoHraOpGgzrBFxz1e7oLWIfUTWLYmhKkK/wfiy0JDV8/abB4OFcf8S+LkszdHA+ssULy8gp4D2E18AnD8csjkNOJWq9Tf
X-Gm-Message-State: AOJu0YxS6DQyCIBvfEnkniw5+w3U5ufoHffDD9HWohBwFxkxc1APvwO+
	xk7R6gh6WwCXhwQkOTAYGoLTXV65S2Nguath/MMr5zEFa8Aku237n9Btgfb9HNEdbIRbKbcv1DR
	bFVNPJomrAw==
X-Google-Smtp-Source: AGHT+IHAgakRN1GMcYnGCFXgcp0S6jDEiv/2+gY/KRM4h43j6n7j458O2RZcU7HXGWBkkYoEbxUyhX44RKGCPA==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:6902:154f:b0:de5:1f88:ae4e with SMTP
 id r15-20020a056902154f00b00de51f88ae4emr651015ybu.2.1713944570760; Wed, 24
 Apr 2024 00:42:50 -0700 (PDT)
Date: Wed, 24 Apr 2024 07:42:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424074242.519895-1-joychakr@google.com>
Subject: [PATCH v2 0/1] nvmem: Handle actual amount of data read/written by suppliers
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
	manugautam@google.com, Joy Chakraborty <joychakr@google.com>
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
V2 Changes : Rebase on for-next.
---
V1 Changes : Change read/write callback prototype to ssize_t and
supplier changes to accomodate the same with core checks and bounds.
---

Joy Chakraborty (1):
  nvmem: Change return type of reg read/write to ssize_t

 drivers/nvmem/apple-efuses.c        |  7 +--
 drivers/nvmem/bcm-ocotp.c           | 12 ++---
 drivers/nvmem/brcm_nvram.c          | 10 ++--
 drivers/nvmem/core.c                | 83 +++++++++++++----------------
 drivers/nvmem/imx-iim.c             |  6 +--
 drivers/nvmem/imx-ocotp-ele.c       |  4 +-
 drivers/nvmem/imx-ocotp-scu.c       | 12 ++---
 drivers/nvmem/imx-ocotp.c           | 10 ++--
 drivers/nvmem/jz4780-efuse.c        |  7 +--
 drivers/nvmem/lan9662-otpc.c        | 12 ++---
 drivers/nvmem/layerscape-sfp.c      | 11 ++--
 drivers/nvmem/lpc18xx_eeprom.c      | 14 ++---
 drivers/nvmem/lpc18xx_otp.c         |  6 +--
 drivers/nvmem/meson-efuse.c         | 22 +++++---
 drivers/nvmem/meson-mx-efuse.c      |  6 +--
 drivers/nvmem/microchip-otpc.c      |  6 +--
 drivers/nvmem/mtk-efuse.c           |  6 +--
 drivers/nvmem/mxs-ocotp.c           |  7 +--
 drivers/nvmem/nintendo-otp.c        |  6 +--
 drivers/nvmem/qcom-spmi-sdam.c      | 12 ++---
 drivers/nvmem/qfprom.c              | 14 ++---
 drivers/nvmem/qoriq-efuse.c         |  6 +--
 drivers/nvmem/rave-sp-eeprom.c      | 18 +++----
 drivers/nvmem/rmem.c                |  4 +-
 drivers/nvmem/rockchip-efuse.c      | 19 +++----
 drivers/nvmem/rockchip-otp.c        | 19 +++----
 drivers/nvmem/sc27xx-efuse.c        |  3 +-
 drivers/nvmem/sec-qfprom.c          |  4 +-
 drivers/nvmem/snvs_lpgpr.c          | 17 +++---
 drivers/nvmem/sprd-efuse.c          |  8 +--
 drivers/nvmem/stm32-bsec-optee-ta.c | 12 ++---
 drivers/nvmem/stm32-bsec-optee-ta.h | 20 +++----
 drivers/nvmem/stm32-romem.c         | 26 ++++-----
 drivers/nvmem/sunplus-ocotp.c       |  4 +-
 drivers/nvmem/sunxi_sid.c           | 15 +++---
 drivers/nvmem/u-boot-env.c          |  6 +--
 drivers/nvmem/uniphier-efuse.c      |  6 +--
 drivers/nvmem/vf610-ocotp.c         |  7 +--
 drivers/nvmem/zynqmp_nvmem.c        | 13 ++---
 include/linux/nvmem-provider.h      |  4 +-
 40 files changed, 253 insertions(+), 231 deletions(-)

-- 
2.44.0.769.g3c40516874-goog


