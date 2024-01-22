Return-Path: <linux-kernel+bounces-34136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CF6837432
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6D11F23996
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAFB47773;
	Mon, 22 Jan 2024 20:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbJZySkp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7684E482C0;
	Mon, 22 Jan 2024 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956255; cv=none; b=e7nn0xLo3zX/gAMmqEsHu7A3Cx5j/vK7yhYhuYzFeVzvcqKORnvJ/cDbTUWiW3hmxL5mb5qV6MuzGUKaLp3muFmBMZjahh9YLD6xQ5II3tFDIQK/SXnjpUj5ZzsAQnV37q8Spnc7/OxAWU/UP1iYLUaLNfRyyR1XaMPLk1cAbqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956255; c=relaxed/simple;
	bh=jP30lAx8kMXkg0eWAT8+e0vfehU+8oEqT+be6BiK5j8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fSm4XKWCN1vRu4IwWGQeP955xei8zEZWlw7nM4a0FcISqzy530qR7OUAJMw5AQFJmqdHe4UXViAs+AKlmJZuH6i1Bb0foOvTCbgiURwi5paYHimHieH4xPwOW5lAyaXiVLReqT14sRrWblLqQL8vu2i7onIz4jfcPhmLswV2KyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbJZySkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6614C433C7;
	Mon, 22 Jan 2024 20:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705956255;
	bh=jP30lAx8kMXkg0eWAT8+e0vfehU+8oEqT+be6BiK5j8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JbJZySkp7+mBwZvUK6oOtNcqB9fuLRH6BA+jpdkh7Gxyd5VdU7cZ/r5onQQ/fq7sd
	 CTM44adcuaXzgkRZz1sMAx9qzCUKX+aGkOVFxtK/rnYRayWKL36GQUd+CexLazoU0Y
	 0qF8/E/MUziz8YXjrvJDMRN63zH9S4CmI6Fg5LtnSbaN3pa2xqIZyp92Uld375KEHK
	 9GWIT2gNsiYL+WbHZATaraf02EBXWZhz2tSvm7T/Xkr7a5m/BEAj6NI4FbPPMd63Zd
	 XF24TalYJ1sr5jjmzU+Pjjzg4iEYWoQ05YTCUHwDP7inI3123uNpyvcGnHFFPFtEqY
	 jhLt78GUK+0Ag==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, 
 Emil Velikov <emil.velikov@collabora.com>, 
 Syed Saba Kareem <Syed.SabaKareem@amd.com>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>, 
 Mastan Katragadda <Mastan.Katragadda@amd.com>, 
 Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 sound-open-firmware@alsa-project.org, kernel@collabora.com
In-Reply-To: <20231219030728.2431640-1-cristian.ciocaltea@collabora.com>
References: <20231219030728.2431640-1-cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v2 0/8] Improve SOF support for Steam Deck OLED
Message-Id: <170595625065.145475.12588005064775574769.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 20:44:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Tue, 19 Dec 2023 05:07:18 +0200, Cristian Ciocaltea wrote:
> This patch series is a continuation of [1] to provide several fixes and
> improvements to the SOF drivers targeting the Vangogh platform, as found on
> Valve's Steam Deck OLED.  The previous series only handled the legacy ACP
> drivers.
> 
> Also note that, since v2, this patch series requires an updated SOF
> topology to provide a correct DAI link ID for the BT codec.  The binary
> file should be located under:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/8] ASoC: amd: acp: Drop redundant initialization of machine driver data
      commit: f0f1021fc9cb88ebdc241b6121107399ee4f2eb7
[2/8] ASoC: amd: acp: Make use of existing *_CODEC_DAI macros
      commit: 68ab29426d88294d16170919a6a6e764f375113f
[3/8] ASoC: amd: acp: Add missing error handling in sof-mach
      commit: d0ada20279db2649a7549a2b8a4a3379c59f238d
[4/8] ASoC: amd: acp: Update MODULE_DESCRIPTION for sof-mach
      commit: a4832a94688000662d4ebb8a1c05f086a9c98826
[5/8] ASoC: SOF: amd: Fix memory leak in amd_sof_acp_probe()
      commit: 222be59e5eed1554119294edc743ee548c2371d0
[6/8] ASoC: SOF: amd: Optimize quirk for Valve Galileo
      commit: a13f0c3c0e8fb3e61fbfd99c6b350cf9be0c4660
[7/8] ASoC: SOF: core: Skip firmware test for custom loaders
      commit: 369b997a1371aeecd0a1fb0f9f4ef3747a1d07a4
[8/8] ASoC: SOF: amd: Compute file paths on firmware load
      commit: d9cacc1a2af2e1cd781b5cd2a3e57fbde64f5a2d

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


