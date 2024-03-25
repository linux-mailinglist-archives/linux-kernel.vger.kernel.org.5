Return-Path: <linux-kernel+bounces-117620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC1088B3C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4F1CB396DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAA43DAC06;
	Mon, 25 Mar 2024 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLwbbKKR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877513DABF6;
	Mon, 25 Mar 2024 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388652; cv=none; b=TeLtyBp/A+lM4UNiLW+gv8COrLlcQWnWIisttg8smhw2WZvqoLYWh4uP/oGOt4qkd0o4NpSS+SWbLye61WSVg+RkgxFi2wyHriPiL5hy3vyMzlLP2RAYsE265zA9LA2aHGpH9NO6CMi+hPEnyDh6Uo1egvhMgepxEf0kuYYjeuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388652; c=relaxed/simple;
	bh=rwbT+Rd3okr1qwfVbwVcY3pmiq1BxSNd33xG79KtlE8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ubK9nIM23QOG1DB98Cw2K/Ya3JubdgeFUKrg8ZxvDAXpB2mGQC3shR1fg9E6Mu8YlMa0m3cg6Ei4rzvN0sDJzUnu4FxbS1rbMLWNNS3qXx0ReykLz3xD6XOVpIvdaDEIigNLK8LTk7L2QRvfp+S0Mx79LewDssMA3QGHbrcel1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLwbbKKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3FFC433F1;
	Mon, 25 Mar 2024 17:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711388652;
	bh=rwbT+Rd3okr1qwfVbwVcY3pmiq1BxSNd33xG79KtlE8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kLwbbKKRSG24OfQv4aAskaKKW3cI7i4aJ5xQQ7aWR+6/oM++s8Mc83D8aJwGKZS73
	 CAMw/nWjpAlhXDnLj7wM78qsf9i11kbmI9hYKwOqG3PEEIJjnYbuTk6ESHtUqEPbSa
	 vO08va9UmZ9HQSBZ9Sv0fBbm5IC6UY8Yi8zhr+OFfauqxDdziOF30800m32EFZVS4o
	 q3jNVDMsoeoWfWkbPiDanzRTnLnJsNFUm3EUu95lSHKmEZTizlztZV7w4biGTnQEp1
	 myIG/5mLWuYaQ1zFZqQzHyI6aI0htamKAe+ZWtnbPYeBNkk5yQsxU20y88sn+mPWk/
	 fhHfANJFvAmNA==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240314141642.2943605-1-alexander.stein@ew.tq-group.com>
References: <20240314141642.2943605-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH 1/1] ASoC: fsl: fsl_ssi: Add dev_err_probe if PCM DMA
 init fails
Message-Id: <171138864957.327140.15499315160101216810.b4-ty@kernel.org>
Date: Mon, 25 Mar 2024 17:44:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 14 Mar 2024 15:16:42 +0100, Alexander Stein wrote:
> This happens especially if this driver is built-in, but SDMA driver
> is configured as module.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: fsl_ssi: Add dev_err_probe if PCM DMA init fails
      commit: 3ca49e7f9475ac06614edf1bfece123eafbdf8f3

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


