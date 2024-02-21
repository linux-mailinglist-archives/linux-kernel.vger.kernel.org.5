Return-Path: <linux-kernel+bounces-73877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A454485CCEC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0E12859BF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E3220E4;
	Wed, 21 Feb 2024 00:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nc4sd3uJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A6B1851;
	Wed, 21 Feb 2024 00:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476521; cv=none; b=DwSr34VIaViUQ++FjqC/vUi0+W8RFr6BEiG2ZVrHJ1PetIbNBwh7+Ubj+Vq1WTzRD64UjUlrPOth5ycaU+CRgJIebUeF+0fHtQWagdqJ8iDyi8gfKnjJ07/Mlft75B45CMFmCHOPWQSOsdWBld0b43o8XSUZ2bYEM2pWeuHlOCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476521; c=relaxed/simple;
	bh=DXWb3JIW51S9y/tgAfifd8KHZKDXHhmRDrzi/Q5S8OQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bDeTDOefKn6VecpLxjXxD8lxrlHr4EsVjt9Y2pNpBOpUTwNynaYfd01j7AgH5ojLSZW41bGSb+16y9BEcBxXuQbMyc1w8hPEak1thJNHVzS6TQbOqSXxhjPJi7DOIVZGD2rkoYPHnGcy5edymFeRW5TxlB8JPa++hd/S/xXWCpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nc4sd3uJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EA7C433C7;
	Wed, 21 Feb 2024 00:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708476520;
	bh=DXWb3JIW51S9y/tgAfifd8KHZKDXHhmRDrzi/Q5S8OQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nc4sd3uJRoHNhXOr/pEh95WfTcoQ7sqwlCySGsemOwOR8l/8QxNk1/7BmEBJSI8dZ
	 30bwTKsG0lQSm3tF+4Ddi9eAs1en63atZUO0fsuz8DwGXyYmoi3urkfADRptU7tUkv
	 qiHKgG8cbrz2o1urDQOfrL6hGO+kqm50aEX/KfRcOBVm8/B+NIvJf17phhlPqC52Wd
	 ZECFMT/BNV6HUxl4+cOb64B4vkJUrdhFIdxuO7vLEoZ897iJMdsLRMYvpidc1L9fBd
	 wCMFbpEK46eoA5TZDqRRu3+424jo+ksdtaOLD3iQzBQ58P7ThCAQpyT+xodYvbZ3ok
	 39llGxo4Oi7JA==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, 
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240219093900.644574-1-arnd@kernel.org>
References: <20240219093900.644574-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: SOF: amd: fix soundwire dependencies
Message-Id: <170847651728.70487.17607622069906765960.b4-ty@kernel.org>
Date: Wed, 21 Feb 2024 00:48:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Mon, 19 Feb 2024 10:38:45 +0100, Arnd Bergmann wrote:
> The soundwire-amd driver has a bit of a layering violation requiring
> the SOF driver to directly call into its exported symbols rather than
> through an abstraction.
> 
> The SND_SOC_SOF_AMD_SOUNDWIRE Kconfig symbol tries to deal with the
> dependency by selecting SOUNDWIRE_AMD in a complicated set of conditions,
> but gets it wrong for a configuration involving SND_SOC_SOF_AMD_COMMON=y,
> SND_SOC_SOF_AMD_ACP63=m, and SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE=m
> SOUNDWIRE_AMD=m, which results in a link failure:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: amd: fix soundwire dependencies
      commit: a3d543b9e6599fbbb9efc1876919627960c5e97a

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


