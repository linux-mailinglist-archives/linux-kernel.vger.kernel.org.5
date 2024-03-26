Return-Path: <linux-kernel+bounces-118996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC4188C263
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CFAB1C3FC90
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A8F763E2;
	Tue, 26 Mar 2024 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dK2sYVfl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B5076041;
	Tue, 26 Mar 2024 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456763; cv=none; b=FpTid9Ik1hJKuRSv+GuqaNs84WryKd1OBfyRTIaJDO1omAAWNHXj7NdgP/HKJqLybdnjkTz/M/2k2rjE7w1Espa8saEE1Ln30kL0OXVykTwaeleguWWpMTTCjLd3OTbtO8U8kvgi6U8p8sZQAYDEyoIGivbkAnbyV87wAhNUAzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456763; c=relaxed/simple;
	bh=vpnXs1APoMjL9qXI9crs4MSSn43RNV7PTsUN91XUNNE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jq0MT5Q6pAzh+V+nuYstDqkNJIJBtos75J6so6y+Dl3dxTSD2orTBCbvkOtfuYbDIi1UokgsLdTTjXrfjwiJr+wstLGS2U6GV/Ol04+qnyi1+G7ZLQix1w967ZpWv0KNk6Dqpr5mRiLVw2fIMiicyUhi6Mk4rFIJcTizf1xSV1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dK2sYVfl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52989C433F1;
	Tue, 26 Mar 2024 12:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711456763;
	bh=vpnXs1APoMjL9qXI9crs4MSSn43RNV7PTsUN91XUNNE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dK2sYVflQVM+Pda1kO14JPs9gYqmGytOzd3aBbTNQyfyggzfrqguqzDhcGzU7Nv5N
	 8ol2P8pfLeaxPe+XbeF8hR5ZRtQL3NdGOhnPk0fXQTNkOl0UYSC1ZXV6k4KT/I16a9
	 ZsUyDrOn3zOekgzEfX1H0IQfq/OTo4vFIbcBoD0VT29bjRs3l+sHKaG7cGGzkEAing
	 BvKSpjn/c3yYnvDz99466MBkTOjLQf0j6ekjqsHNyYv3sudAdYqF9zMojAOYnZQu0Q
	 9nOYreO9ZDIMQTEfHFGtiYf8miXgSIllHRXTRSYZLsQffkybdaiQ2esuJMj1sut18P
	 Ic5gkFPYWJklA==
From: Mark Brown <broonie@kernel.org>
To: Ryan Wanner <ryan.wanner@microchip.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 David Lechner <dlechner@baylibre.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240325-spi-remove-is_dma_mapped-v2-1-d08d62b61f1c@baylibre.com>
References: <20240325-spi-remove-is_dma_mapped-v2-1-d08d62b61f1c@baylibre.com>
Subject: Re: [PATCH v2] spi: remove struct spi_message::is_dma_mapped
Message-Id: <171145676106.65249.12081850863906507008.b4-ty@kernel.org>
Date: Tue, 26 Mar 2024 12:39:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 25 Mar 2024 14:22:53 -0500, David Lechner wrote:
> There are no more users of the deprecated is_dma_mapped in struct
> spi_message so it can be removed.
> 
> References in documentation and comments are also removed.
> 
> A few similar checks if xfer->tx_dma or xfer->rx_dma are not NULL are
> also removed since these are now guaranteed to be NULL because they
> were previously set only if is_dma_mapped was true.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: remove struct spi_message::is_dma_mapped
      commit: 9b163e0d330debbf7dcc14b2c3e2dc19a3b50a1d

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


