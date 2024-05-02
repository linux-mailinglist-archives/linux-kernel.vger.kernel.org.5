Return-Path: <linux-kernel+bounces-165948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FDD8B93B8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8411C218EC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5261CD02;
	Thu,  2 May 2024 03:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4uBsHfv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C969D527;
	Thu,  2 May 2024 03:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714622228; cv=none; b=tTAKz/+WOZyb8h4kwmeWSCyOY3ywzw7l1s53a9urHNZzTK9uyXpiE/O7q8njvw5QAEQzVmRbp8DZmE2tRXsViSWkGbnQwz2OsNd4uNqZ5f4dP5FoLIrySY7V5Ua5AM9GKQMcBVvSliUhIeFDZSwAJujyGOZgt1sCABGKB87ZjiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714622228; c=relaxed/simple;
	bh=GhLrb4LsugJQdErEM1U3FioSUcGebSzbtNTOsJjlJe4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NyxhD/CZLilmQiTN0JjGbFUS1w9OjahbhGtZKiNfUUV/BC7bjEdPkbAAjGfIjnmBWW7Q2YkqJXtzTE9NVQyb9LtgbRoxfVVX7Yr9OcPPDFhQ18s4zoJEgyKWNJPrMnsbXcR/vh+N0nUvr+PuYzvQe6udGpFMj3S7nfzudMIv9XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4uBsHfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0964C4AF4D;
	Thu,  2 May 2024 03:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714622227;
	bh=GhLrb4LsugJQdErEM1U3FioSUcGebSzbtNTOsJjlJe4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=h4uBsHfvJ70gB5079HVXd1JVMXmwd4oeFaHxkutp2sUdk77EGI7ruVtyss9OVDqT3
	 QARmiCfSHZFhcyA9BOqIB1qO0gTPUiRdyPwKgpPZf3Bqyf06T9zUam+Q1U4L20wuMO
	 36ApLDr/oOoA0l/4D5r2Pr/4RlZN1Nv2v3xhfHncs6dAGjaWF7hSTdacRF9Lp/WF7j
	 Q304t34WpWbaG47iBOzK0jx9ZZFJGzzVrAjpeLlvI6/f1KA2AxsDbJCTwbqk9FaseM
	 drOrMnCYezj1Y6ZWcaEOVgvRIELSS0lPK8dSiMc9qm42X9QwZ2Eqborw9owLEP7mZz
	 Lev8AaSUdZNNw==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Chen-Yu Tsai <wens@csie.org>, imx@lists.linux.dev, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, Samuel Holland <samuel@sholland.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
In-Reply-To: <20240430114142.28551-1-wsa+renesas@sang-engineering.com>
References: <20240430114142.28551-1-wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v2 0/8] spi: use 'time_left' instead of 'timeout' with
 wait_for_*() functions
Message-Id: <171462222567.1904471.14171309243632895183.b4-ty@kernel.org>
Date: Thu, 02 May 2024 12:57:05 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 30 Apr 2024 13:41:32 +0200, Wolfram Sang wrote:
> There is a confusing pattern in the kernel to use a variable named 'timeout' to
> store the result of wait_for_*() functions causing patterns like:
> 
>         timeout = wait_for_completion_timeout(...)
>         if (!timeout) return -ETIMEDOUT;
> 
> with all kinds of permutations. Use 'time_left' as a variable to make the code
> obvious and self explaining.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/8] spi: armada-3700: use 'time_left' variable with wait_for_completion_timeout()
      commit: 7dbbbb1206dd0b695b9a76d3b758c8a689f1aa52
[2/8] spi: fsl-lpspi: use 'time_left' variable with wait_for_completion_timeout()
      commit: eef51e99f7b9ecc903a3a9ad9e7ca84dc35c3f52
[3/8] spi: imx: use 'time_left' variable with wait_for_completion_timeout()
      commit: eaeac043ab842d2e84616ff0412eec0121c1758c
[4/8] spi: pic32-sqi: use 'time_left' variable with wait_for_completion_timeout()
      commit: a7c79e50a26cb619400ccc6294dbd7d8c24a0341
[5/8] spi: pic32: use 'time_left' variable with wait_for_completion_timeout()
      commit: e66480aed4a194f278da1e46ec45221b3983216f
[6/8] spi: sun4i: use 'time_left' variable with wait_for_completion_timeout()
      commit: 34bed8a33f3a4f69b0ef584ef49f04a671a4a5c2
[7/8] spi: sun6i: use 'time_left' variable with wait_for_completion_timeout()
      commit: 83a3f1ba60d6e2f73c9dd2627a8ce41867dbc46b
[8/8] spi: xlp: use 'time_left' variable with wait_for_completion_timeout()
      commit: 594aa75d6bdda85b5fd027a5056d8cd1345c1db3

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


