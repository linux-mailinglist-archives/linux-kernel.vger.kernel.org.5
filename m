Return-Path: <linux-kernel+bounces-118995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1D288C261
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE09D1C3FBE1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0961C75816;
	Tue, 26 Mar 2024 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJ0oeA00"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC8E757FD;
	Tue, 26 Mar 2024 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456761; cv=none; b=VYMkqB5dB7RuWK7cAzljMK1QIBdGyOHzGou425OLp+vqs53eIpSwb1dbtYT3x2VYzkB79PrtHaOibK/DLVAlkAH70qjTuk0/mpxa8IhlKv2rEf9uNLv45m1mDZVgE1VCZXIXr1G5P8B/u2wCKK2rUl76JKQIA8GchrgA02h6YE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456761; c=relaxed/simple;
	bh=PXg37FMYYIv59/UvnQPnxU1WEtd7bp9EloMy+GxZ9uk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=etXx0HPGzJNNVoP7r6zSLLxFSANDUQxMO2+7ntShY5t3NjKmc7DrcMBLvoLA2X0NI+2HAPiTWxRFH9kcjVS214CiyJ8/pZg3rB/G+h/HOtxPmL8i/er/I1r8Mf/N90SX+vmICZp2iHcm5rg/vYF0Z7J96e7QCClGdkaqY9o1nc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJ0oeA00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC71C433B1;
	Tue, 26 Mar 2024 12:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711456760;
	bh=PXg37FMYYIv59/UvnQPnxU1WEtd7bp9EloMy+GxZ9uk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VJ0oeA00Dy6D4/oyk8A7RjMFSduq6qQKDPswRblrrexx3by2Fk8ZR2vFcKslr8d5y
	 5IZuFVQuDvVYMAAVJslW+yWTCVFrw0VGoFGIBSaIAXJ6Viw2tOKeRwlKQNYqVh03ZD
	 cmc4qsQxPTO4amIvvZS/n6oWuNG/vCE3XEPMV3gMHxeqitkiBe5jR6zG0q2sHvzvxV
	 xPx2gv1KWf9EUbQ8j36RoZyFUGid8EDOSC2TD16ng9XB1+vepGWAl80tKcURDI518O
	 JQtT5hbMDXDhoePRguflgQduNO+I8dGrFUrzTsJDkviw94D4nFzQvVcZ+m9jEm7wy3
	 W9LkyAN/5Oikg==
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
In-Reply-To: <20240315-spi-remove-is_dma_mapped-v1-1-ca876f9de1c5@baylibre.com>
References: <20240315-spi-remove-is_dma_mapped-v1-1-ca876f9de1c5@baylibre.com>
Subject: Re: [PATCH] spi: remove struct spi_message::is_dma_mapped
Message-Id: <171145675823.65249.1099257779521752838.b4-ty@kernel.org>
Date: Tue, 26 Mar 2024 12:39:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Fri, 15 Mar 2024 17:29:43 -0500, David Lechner wrote:
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


