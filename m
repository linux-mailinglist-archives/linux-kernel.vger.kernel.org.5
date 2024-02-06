Return-Path: <linux-kernel+bounces-54604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2639084B16D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B648A1F2387E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFAD12D156;
	Tue,  6 Feb 2024 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJg8G6RI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CB32C6A6;
	Tue,  6 Feb 2024 09:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212262; cv=none; b=DEcliJZDUFE+C9lIJV6uUzHsWRbAhD3UKGFEZ396BGjaixV99wlgXQQcniVpPyKyy8O79Qwb2J00p1UgHPnVcT1y8+FYgc9H0oTiukPU4WOdGXAFE/kIjlaKB/5L3ZGeGd8bBF0GUwjrTbBfyajIC4tjt+WDk4IuPmz6kCHXhIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212262; c=relaxed/simple;
	bh=ccaULkaRAC2eSQxVh6heBueyM5IiUSlYYH2ALCR0lvE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Nyz/dxsmktmwowpFDq26sbFbqSNNbDh6x54ho8rPD8U41f8zg42S3Qky+1gPnq2C4xMjSoGCg842Rc+WQQgajvVh2QnmYe8vuGv/r8EBHtl3meT8+UH/ZIW/qIxGFN8u1E8aMRrLeX2B+JA6AiF5QdEoZ7JDGU4ASEtiwwVskQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJg8G6RI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CB3C433C7;
	Tue,  6 Feb 2024 09:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707212262;
	bh=ccaULkaRAC2eSQxVh6heBueyM5IiUSlYYH2ALCR0lvE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rJg8G6RI1FiggDWJjU5+sZv6hks9EnsA34kKPtWd2zTypzptetolhiiehCXs9zS6N
	 vQLUJdJJhqFwKWkzz9p4ZAIvUalJmTt6oYtduY4EF01hzAAPcvlnib9mof0epZcyW4
	 nybLdmFMZcQNLLWK1QdA4bu2U5WUsDACUkN6AgPksu+5ETw9GUD672kM/SZyh1OVIK
	 GYOSEkZMkPw3no480acGYEvZoQfGc2FmpmaP1lQbTL5f/Oto6gNSO/RENWvVhn+xz2
	 5c6pP84AxjpAVrXBmkfe3xDZDqlMYxHuFEoj4Dx1Laad1VMKtUcf87MKhMql13Dmcw
	 QLlL2Yi4rNuwg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Syed Saba Kareem <Syed.SabaKareem@amd.com>, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, 
 Vinod Koul <vkoul@kernel.org>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240204212207.3158914-1-arnd@kernel.org>
References: <20240204212207.3158914-1-arnd@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: SOF: amd: fix SND_AMD_SOUNDWIRE_ACPI
 dependencies
Message-Id: <170721225780.850647.13647776973714432704.b4-ty@kernel.org>
Date: Tue, 06 Feb 2024 09:37:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Sun, 04 Feb 2024 22:22:01 +0100, Arnd Bergmann wrote:
> The snd-amd-sdw-acpi.ko module is under CONFIG_SND_SOC_AMD_ACP_COMMON but
> selected from SoF, which causes build failures in some randconfig builds
> that enable SOF but not ACP:
> 
> WARNING: unmet direct dependencies detected for SND_AMD_SOUNDWIRE_ACPI
>   Depends on [n]: SOUND [=m] && SND [=m] && SND_SOC [=m] && SND_SOC_AMD_ACP_COMMON [=n] && ACPI [=y]
>   Selected by [m]:
>   - SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE [=m] && SOUND [=m] && SND [=m] && SND_SOC [=m] && SND_SOC_SOF_TOPLEVEL [=y] && SND_SOC_SOF_AMD_TOPLEVEL [=m] && ACPI [=y]
> ERROR: modpost: "amd_sdw_scan_controller" [sound/soc/sof/amd/snd-sof-amd-acp.ko] undefined!
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: amd: fix SND_AMD_SOUNDWIRE_ACPI dependencies
      commit: 69f8336e2913f12795fa0ec986bf63a8461ebfb9
[2/2] ASoC: fix SND_SOC_WCD939X dependencies
      commit: b4956275bf88a5708200713707c6c293648d39a9

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


