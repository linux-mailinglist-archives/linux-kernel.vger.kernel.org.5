Return-Path: <linux-kernel+bounces-165338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2198B8B6A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001841C22830
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765B012F367;
	Wed,  1 May 2024 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjyr9K85"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20C31758D;
	Wed,  1 May 2024 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714570997; cv=none; b=KCnjz/ijzXDfddP37QfQBDgIJmu3i5Y30X64uriJLfvcu4L9tKdZV+uNuigFP9S0D8pn/xpFZ0u3Yl1IGwOI7tFS9HUiYIkNG3OBOc8uWs2GArq5nWGEIEEUV3g2wpTIRP6Tk3OWGeXRQiSPbIlvGQlUkZjH83+4xtR+234HBak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714570997; c=relaxed/simple;
	bh=8s5kRpq9v7omz4cTI6onHJBvW1QqzHh21ZT4YSBdF7k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TvF03jFyFfFtMRePmAdLZZiQZs6RReqi59Zw+9v/63trKBHQujvIDBdrupjvLEg0rdMOP32SynysE/1BVgABHvK4rISRcCtWvJvkJztFfuLkMirgA+L/Z/9SupnyOaNhTtnvhM3TIYg8wyIqXIEKnzzYVET3MjbCxGIpXvQxHww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjyr9K85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD58C4AF19;
	Wed,  1 May 2024 13:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714570997;
	bh=8s5kRpq9v7omz4cTI6onHJBvW1QqzHh21ZT4YSBdF7k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kjyr9K85Re6Zf3n9S/Id7kQZR5Yr29JID3fNO4fHNxVk5U08ylMmNTPsEZRIEN0zB
	 SxbL3nPSGCY272Yx7p2+Nwqx/y/1bJTSuzixrQjfSj+hpzykP+n1SjZ9F5y4iftmZ4
	 ltLsKFZeF63cRrNzaRiwdNjKz2IU/K9NUNnJJTHIZqOIzbsNnIrDqGVyicTC36n7n+
	 /0nR5HcPpt3vA1s38/WKQSrMkCUgS9I/XeH1Bu/d77r427FiVlvbpkmePxuIQKgo3w
	 YNl2GWRMX+kMjg+FRe0vPunEq+eHFK8VH9EZJ7fljw1SxEjKHaogC03pMTHMpAu3ob
	 RxoZuI1LiqjSA==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20240426-n-const-ops-var-v2-0-e553fe67ae82@kernel.org>
References: <20240426-n-const-ops-var-v2-0-e553fe67ae82@kernel.org>
Subject: Re: [PATCH v2 00/14] ASoC: Constify local snd_sof_dsp_ops
Message-Id: <171457099304.1888704.3710450015978525893.b4-ty@kernel.org>
Date: Wed, 01 May 2024 22:43:13 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Fri, 26 Apr 2024 11:03:47 +0200, Krzysztof Kozlowski wrote:
> Changes in v2
> =============
> - Only rebase on for-next of broonie/sound.git
> - Add tags.
> - Link to v1: https://lore.kernel.org/r/20240414-n-const-ops-var-v1-0-8f53ee5d981c@kernel.org
> 
> Description
> ===========
> The core code does not modify the 'struct snd_sof_dsp_ops' passed via
> pointer in various places, so this can be made pointer to const in few
> places.  This in turn allows few drivers to have the local (usually
> static) 'struct snd_sof_dsp_ops' as const which increased code safety,
> as it is now part of rodata.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/14] ASoC: SOF: debug: Constify local snd_sof_dsp_ops
        commit: ffca099bbff1978bc9c97b076f0d35b4fe6ddf27
[02/14] ASoC: SOF: ipc3: Constify local snd_sof_dsp_ops
        commit: ee5acc1e035ec5ed5d9f0f63fda9d627220090c2
[03/14] ASoC: SOF: pcm: Constify local snd_sof_dsp_ops
        commit: a0db037df9630edad76153c7937c6f5ca04ed44f
[04/14] ASoC: SOF: Constify stored pointer to snd_sof_dsp_ops
        commit: 8bbc692d1abce5bc949dea9acba85fc686601c04
[05/14] ASoC: SOF: intel: pci-tng: Constify snd_sof_dsp_ops
        commit: 8f2b0d55abc44676b076128903a5dc730aab23c6
[06/14] ASoC: SOF: intel: hda: Constify snd_sof_dsp_ops
        commit: 6032eefc2c478243a511352dda04495c9a9fec6a
[07/14] ASoC: SOF: amd: acp: Constify snd_sof_dsp_ops
        commit: 04f2f516be09d5493d764e0020a771c46b5470d8
[08/14] ASoC: SOF: imx8: Constify snd_sof_dsp_ops
        commit: ab85c44973298b69eb32795de11ce4d426705532
[09/14] ASoC: SOF: imx8m: Constify snd_sof_dsp_ops
        commit: 66d49ab5fb51bb8d1b4c2c9c8fa0fbe8e4c8ca1c
[10/14] ASoC: SOF: imx8ulp: Constify snd_sof_dsp_ops
        commit: 232e0da9fa778233358586617bd22173bcac6bcc
[11/14] ASoC: SOF: intel: bdw: Constify snd_sof_dsp_ops
        commit: 936cc56044a87ae7fbd0e4098a7daefa0f2f4e8e
[12/14] ASoC: SOF: intel: byt: Constify snd_sof_dsp_ops
        commit: 48d5f1800d0cbda0212c5a58177918c419a24f8a
[13/14] ASoC: SOF: mediatek: mt8186: Constify snd_sof_dsp_ops
        commit: fe80673f59da01776a1402e4b508a66fca43a24d
[14/14] ASoC: SOF: mediatek: mt8195: Constify snd_sof_dsp_ops
        commit: 8b6d678fede700db6466d73f11fcbad496fa515e

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


