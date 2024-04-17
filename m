Return-Path: <linux-kernel+bounces-147817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8408A7A09
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D081F22912
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B9D184F;
	Wed, 17 Apr 2024 01:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaP22WSH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E596FA8;
	Wed, 17 Apr 2024 01:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713316067; cv=none; b=msznVla24ZHC/C2xRTEscY0e2m15WKiwU+15b8awnksEu91lFi7eh5wTjNB8HkBjIX/Zn/HfaYMAAVqmlPOEG4jOHBbsygcEP0lHYlCawZEyPcV9qrs1urnWUIAZv2r38QbXVWSr4SDRc5aNPBAw5NSxHnxiGCAGbZNEiXDq+js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713316067; c=relaxed/simple;
	bh=PqaHR/bHt9hKVQUfh175qxpXqBSt6Cu+r6+m3wImr+0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ybh3zGJHLZ4jI5TWdf9hXuXyotos5BYHTEq9X9M+o342G+FBJwsv28bLG0BlyYBdtOGAb+Jk4uBn/NiJR/DQq6IycynabU2APKEftWHvqDZNYslsIXMo3tDVkkLN60uJwS1eqoYfy886Xwl68/U/0jk9lLzQ8hrU59jySNYHiL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaP22WSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB06C113CE;
	Wed, 17 Apr 2024 01:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713316066;
	bh=PqaHR/bHt9hKVQUfh175qxpXqBSt6Cu+r6+m3wImr+0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YaP22WSH2mFF16qmU38TX/WfL40595sQMUWuh4SjGjdDwDI9syN8U72AZSWGZX9sj
	 CPRQghPIneIqYVv4x6Cb84PJfP0o0hrudvZ7rmfgkgUHVcVor0qjheufH31W8vEX8K
	 30oyOFpWVMcggnnPvtaNlk5azFoz8wIJnpcqGp1Lm0+MUIdnX8JSO1IALZ2RwarEJ9
	 w4Fpv6IO/u+XyNqVZqXowT2Y5Cgb7aY9jTNFz21NHsktiWUboix2pM241AcvC3YYVm
	 Sn6Ax1nBXGXg0J+6EgTk2MxlZjteCZUEyNFTF8lG1rgSMp/nLCfTpQC1N5y64X3fXd
	 uoWm9iilI0Eug==
From: Mark Brown <broonie@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: wenst@chromium.org, lgirdwood@gmail.com, robh@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com, 
 trevor.wu@mediatek.com, maso.huang@mediatek.com, 
 xiazhengqiao@huaqin.corp-partner.google.com, arnd@arndb.de, 
 kuninori.morimoto.gx@renesas.com, shraash@google.com, amergnat@baylibre.com, 
 nicolas.ferre@microchip.com, u.kleine-koenig@pengutronix.de, 
 dianders@chromium.org, frank.li@vivo.com, allen-kh.cheng@mediatek.com, 
 eugen.hristev@collabora.com, claudiu.beznea@tuxon.dev, 
 jarkko.nikula@bitmer.com, jiaxin.yu@mediatek.com, alpernebiyasak@gmail.com, 
 ckeepax@opensource.cirrus.com, zhourui@huaqin.corp-partner.google.com, 
 nfraprado@collabora.com, alsa-devel@alsa-project.org, 
 shane.chien@mediatek.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 kernel@collabora.com
In-Reply-To: <20240416071410.75620-1-angelogioacchino.delregno@collabora.com>
References: <20240416071410.75620-1-angelogioacchino.delregno@collabora.com>
Subject: Re: (subset) [PATCH v5 00/18] ASoC: Cleanup MediaTek soundcard
 machine drivers
Message-Id: <171331605897.1695927.18052173831276369230.b4-ty@kernel.org>
Date: Wed, 17 Apr 2024 10:07:38 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 16 Apr 2024 09:13:52 +0200, AngeloGioacchino Del Regno wrote:
> Changes in v5:
>  - Cleaned up MT8186 soundcard migration commit which erroneously
>    had leftovers from development
>  - Changed the mtk_pcm_constraints_data structure to hold pointers
>    to snd_pcm_hw_constraint_list, as to really reuse the const data
>  - Tested again on all of the listed MTK platforms.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/18] ASoC: mediatek: Add common machine soundcard driver probe mechanism
        commit: bce93a162505f0bc0499888ace2f66bd56fb94b3
[02/18] ASoC: mediatek: common: Constify struct mtk_sof_priv
        commit: f8782f776db33066a9b1cd14d319142c4175561f
[03/18] ASoC: mediatek: mt8188: Migrate to mtk_soundcard_common_probe
        commit: aad45b8aa973a863dee2f256cea8c527acaaf56e
[04/18] ASoC: mediatek: mt8195: Migrate to mtk_soundcard_common_probe
        commit: 6718e1ed93cc28f0faefe21b7d21679ff0b04020
[05/18] ASoC: mediatek: mt8192: Migrate to mtk_soundcard_common_probe
        commit: 2d72cbb56327205ae04a9376c5b78a35b6347294
[06/18] ASoC: mediatek: mt8186: Migrate to mtk_soundcard_common_probe
        commit: 44a53c8ec9cad02ce7dfd55094e8d7aeb48eb73c
[07/18] ASoC: mediatek: Add common snd_soc_ops .startup() callback
        commit: fe071237dee6d617e5cb0eb4856b23576a877479
[08/18] ASoC: mediatek: mt8195: Migrate to the common mtk_soundcard_startup
        commit: 386fe4ceaf196360ef96cbd68d045ed2730251a7
[09/18] ASoC: mediatek: mt8192: Migrate to the common mtk_soundcard_startup
        commit: 94142cc1ffd959aa8e83857515a75779e8ba8064
[10/18] ASoC: mediatek: mt8186-rt1019: Migrate to the common mtk_soundcard_startup
        commit: f103ce4ff6932b6991e1922d1a39c29971ab2938
[11/18] ASoC: mediatek: Add common mtk_afe_component_probe callback
        commit: 9d9b182876a249b393158e9f43c255aeee4ef898
[12/18] ASoC: mediatek: Use common mtk_afe_pcm_platform with common probe cb
        commit: 1d2a6b3b5189b6c3e51f29e050aa9b2337b774e8
[13/18] ASoC: mediatek: mt8186: Unify mt8186-mt6366 machine drivers
        commit: 6ed619b348bf0a490e70dea7a330cf44dc81c16d
[14/18] ASoC: dt-bindings: mt8195: Document audio-routing and dai-link subnode
        commit: dc7a31300a8f28af282974512c2d403ada0658b5
[15/18] ASoC: dt-bindings: mt8192: Document audio-routing and dai-link subnode
        commit: 5a50483c47b8cf3066eb151fa21e195f3dfab5a8
[16/18] ASoC: dt-bindings: mt8186: Document audio-routing and dai-link subnode
        commit: 787f190cd1cd3123555e33a3400f3e919ec94a81

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


