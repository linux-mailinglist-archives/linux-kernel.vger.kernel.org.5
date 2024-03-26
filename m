Return-Path: <linux-kernel+bounces-119311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30A988C6E6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6AD1C63D79
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D8413CAB5;
	Tue, 26 Mar 2024 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hp6Esqla"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD97613C8F1;
	Tue, 26 Mar 2024 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466873; cv=none; b=irTYZctTQ+SQBRvFvmqXZHSqgU+n6R4VZSaXV1Yazy/W6wgS3EEKTi1zxEvIIghouV4CmRGp/RmHceDkq3wWoD6esNsSgbZ0zJVd1RUUH4kTyzWXhPVdOh+crD6YceV3SnlHcLMAkUQYCbW1BWxlTPztiLsNOfASIikDs1b4luc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466873; c=relaxed/simple;
	bh=d7mywm5rWXgjpSN3I9ojlV17yktCzrZdNxZNYpgH1yQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oSnhYh7eZ5mvy7FfNy7M7hhNcyB4snPlDH2zqAHUZL/o7kGIJNW/rWwlGXsuIYWZK3G+vIKlQQaiZqCq15zLk7eg5hzzeEsBYzl9DlNmAW/jRZ1P4ufPor9veXz0BA+obhhyS8vfvUFwSd2l4fkMKk5Bzrtd5wGKoIVsdgK37f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hp6Esqla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166E3C433F1;
	Tue, 26 Mar 2024 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711466873;
	bh=d7mywm5rWXgjpSN3I9ojlV17yktCzrZdNxZNYpgH1yQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hp6Esqla1sjCT4T/dOuLOdPJZJ401oUDnrm2g7ZKzIYsSHuUajnZnSUOxJ+ajTyMC
	 RmXLnvNEpkQi3Avbi9D5focccqQ1CCFjcz7btuhY7Zrykz/t7kC0MPV4AF2VmkPWwO
	 mQplefko5AwG3GGe/5rk+J8Wv2h5jafianOzsF1IsDMBP4+vPT7ZAo3Gj5X7UM91DC
	 Qy2+BaRHT2+GOPn8/8COxnkQylaqCzcNmPWySsBZtZ+j3QycwAWhg0Oj2yyzgNQgE7
	 nNIuQXfDipaZQeQRoZujONjXeJvkictOIygpcA3TdDHmDxu8da7rV7N/9JzZ7nyfr6
	 8nZKG4LEPmu+g==
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
In-Reply-To: <20240313110147.1267793-1-angelogioacchino.delregno@collabora.com>
References: <20240313110147.1267793-1-angelogioacchino.delregno@collabora.com>
Subject: Re: (subset) [PATCH v3 00/22] SoC: Cleanup MediaTek soundcard
 machine drivers
Message-Id: <171146686681.132239.6648296431652591544.b4-ty@kernel.org>
Date: Tue, 26 Mar 2024 15:27:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 13 Mar 2024 12:01:25 +0100, AngeloGioacchino Del Regno wrote:
> Changes in v3:
>  - Added audio-routing names in enum in all yaml files
>  - Added mention of disallowing old and new properties together in
>    commit message of bindings patches
>  - Fixed validation errors with sound-card-common.yaml inclusion
>    due to missing model property in examples
>  - Removed `else` enforcing headset-codec/speaker-codecs requirement
>    if xxx-dai-link not present to avoid future commit noise as the
>    deprecated statement will disallow deprecated properties as required
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/22] ASoC: mediatek: mt8192-afe-pcm: Convert to devm_pm_runtime_enable()
        commit: 7aaaa22de56ce0dae15fd9f42a69a1d1a7a6e078
[02/22] ASoC: mediatek: mt8192-afe-pcm: Simplify with dev_err_probe()
        commit: 324c603a4efca7d1045e0bf3477ca54970eac72c
[03/22] ASoC: mediatek: Commonize ADDA rate transform functions and enums
        commit: d6c01755805d346a1382d2d81c214b2ca557487a
[04/22] ASoC: mediatek: Assign dummy when codec not specified for a DAI link
        commit: 5f39231888c63f0a7708abc86b51b847476379d8
[05/22] ASoC: mediatek: Add common machine soundcard driver probe mechanism
        (no commit info)
[06/22] ASoC: mediatek: common: Constify struct mtk_sof_priv
        (no commit info)
[07/22] ASoC: mediatek: mt8188: Migrate to mtk_soundcard_common_probe
        (no commit info)
[08/22] ASoC: mediatek: mt8195: Migrate to mtk_soundcard_common_probe
        (no commit info)
[09/22] ASoC: mediatek: mt8192: Migrate to mtk_soundcard_common_probe
        (no commit info)
[10/22] ASoC: mediatek: mt8186: Migrate to mtk_soundcard_common_probe
        (no commit info)
[11/22] ASoC: mediatek: Add common snd_soc_ops .startup() callback
        (no commit info)
[12/22] ASoC: mediatek: mt8195: Migrate to the common mtk_soundcard_startup
        (no commit info)
[13/22] ASoC: mediatek: mt8192: Migrate to the common mtk_soundcard_startup
        (no commit info)
[14/22] ASoC: mediatek: mt8186-rt1019: Migrate to the common mtk_soundcard_startup
        (no commit info)
[15/22] ASoC: mediatek: Add common mtk_afe_component_probe callback
        (no commit info)
[16/22] ASoC: mediatek: Use common mtk_afe_pcm_platform with common probe cb
        (no commit info)
[17/22] ASoC: mediatek: mt8186: Unify mt8186-mt6366 machine drivers
        (no commit info)
[18/22] ASoC: dt-bindings: mt8195: Document audio-routing and dai-link subnode
        (no commit info)
[19/22] ASoC: dt-bindings: mt8192: Document audio-routing and dai-link subnode
        (no commit info)
[20/22] ASoC: dt-bindings: mt8186: Document audio-routing and dai-link subnode
        (no commit info)

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


