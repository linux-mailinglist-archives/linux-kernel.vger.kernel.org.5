Return-Path: <linux-kernel+bounces-151280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE96C8AAC5A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5461C20F02
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1719D7CF17;
	Fri, 19 Apr 2024 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNp4CEeH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5E47BB19;
	Fri, 19 Apr 2024 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521020; cv=none; b=avm6J7GN8JjcHYR2rPqxqQGhmazlCcKSCptTPdeaWQMqnTTMH/Pe07u7O2ATITw5/qCYIom13evbj8qJtLjlnZFa86iJU9L2pFF0/WkNOem0eHY1HJJi4gf+qgHNQVSHY9gzLZ7TJ90MXRYN39YUl09mP99YBG6jl1wttZSs8ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521020; c=relaxed/simple;
	bh=Y+l/5wzPKHUbS5RS+cGf0Dhxvzxyf8nHK5sorhrqVPs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T8sZLULXlw0I+xPtMuUhLsA3cTkcyIEMnFyEftac1bCCzAIsts1sb8TwkClfLI8MiQBUx7V/YY32EzHisaWVN54UdIXh+dRDK4sQIBOAJFS+x0KGmQyxC72a6jr4ZbMLJ/dtehxL79HMAIsswKqhqEQcY0VEyO+6h20e7AyyFAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNp4CEeH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F597C072AA;
	Fri, 19 Apr 2024 10:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713521019;
	bh=Y+l/5wzPKHUbS5RS+cGf0Dhxvzxyf8nHK5sorhrqVPs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qNp4CEeH/RtTaj6c0/jyji1DErFEvmLvA92sY4so1y3KYC/ks7SaahgVq73vRFfyC
	 721AQNRNvig2459UGf0y2hfBSiI8S4ZTmo0TFB3FPM1YXjF0yPIre5DIcPdG1CYM6T
	 qjW/w/UfrCQ0cIqi0SB/B0BrNySAkVpRI5zIC0mJ521c4v2z89/mulx2bQlvKzpx90
	 n8XT6DHr8MlWaTGFXevMdeE0iFjSWWbIWxrS8fHQxJ4i/gOpDBVQhEzrGiF/0iBdpB
	 tuhx4c9SXceMAev1iGFrAd5kHh/e4NvtB5GwdNeIhZ11qwgiKcxe8S0Mruu2+Y13BP
	 Gi5DtPBR0WmGQ==
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
Cc: Joao Paulo Goncalves <joao.goncalves@toradex.com>, 
 Jai Luthra <j-luthra@ti.com>, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20240417184138.1104774-1-jpaulo.silvagoncalves@gmail.com>
References: <20240417184138.1104774-1-jpaulo.silvagoncalves@gmail.com>
Subject: Re: [PATCH] ASoC: ti: davinci-mcasp: Fix race condition during
 probe
Message-Id: <171352101774.1723702.5403683019757123784.b4-ty@kernel.org>
Date: Fri, 19 Apr 2024 19:03:37 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 17 Apr 2024 15:41:38 -0300, Joao Paulo Goncalves wrote:
> When using davinci-mcasp as CPU DAI with simple-card, there are some
> conditions that cause simple-card to finish registering a sound card before
> davinci-mcasp finishes registering all sound components. This creates a
> non-working sound card from userspace with no problem indication apart
> from not being able to play/record audio on a PCM stream. The issue
> arises during simultaneous probe execution of both drivers. Specifically,
> the simple-card driver, awaiting a CPU DAI, proceeds as soon as
> davinci-mcasp registers its DAI. However, this process can lead to the
> client mutex lock (client_mutex in soc-core.c) being held or davinci-mcasp
> being preempted before PCM DMA registration on davinci-mcasp finishes.
> This situation occurs when the probes of both drivers run concurrently.
> Below is the code path for this condition. To solve the issue, defer
> davinci-mcasp CPU DAI registration to the last step in the audio part of
> it. This way, simple-card CPU DAI parsing will be deferred until all
> audio components are registered.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: davinci-mcasp: Fix race condition during probe
      commit: d18ca8635db2f88c17acbdf6412f26d4f6aff414

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


