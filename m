Return-Path: <linux-kernel+bounces-125251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5563B8922CB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5F5EB22050
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC65218AF8;
	Fri, 29 Mar 2024 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dg9vyq4C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224AC13249F;
	Fri, 29 Mar 2024 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711733729; cv=none; b=ehmPAa2/E6J/SAWfOYA9VbZ5SIqIDNIlwiE3lAMpecMnrDXsVCY+mj1o2yBTG2tr6Sd6QMpgUMsCbrHUQ7Cotq3CpHV4fUQg4Rs1EodYewutpZoUYdutg/ZSB3UOXzzHRhM9LQJ5spyVOr+0VR09i0IaEhGDfNXMlGU71Mx5EEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711733729; c=relaxed/simple;
	bh=IKp5hVryh+AhRCHQEkLVpXkjg9FXgRVlJMTHmJin/sw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DUfqktNV8rFCYZ/sbwpl80EdaJKSmrQjFp9vnd6woJBn4nLeotjM1UkILBLd7WIS3/Tdi03Z5ABSxaKwwLk/HXGpLhn5k84dLw0NjeMeVw8fwW3rfYbprhy036MApE5ttIvoLlFH6OlWOpRFNAu36snxsiBaKGuar9zFkdbPCMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dg9vyq4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABF0C433F1;
	Fri, 29 Mar 2024 17:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711733728;
	bh=IKp5hVryh+AhRCHQEkLVpXkjg9FXgRVlJMTHmJin/sw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dg9vyq4CAACubfsARV5FqqZOVaoCSo5AIk6xvHC7VcmZQKN5RxfultGE3tRqXKq7Z
	 L1ctud3gpB/s5Dz/RAiyTW4xeLlXy8BM41Ce4UaXZFBhlgUnI/n7o8Mdx0jAbyS0eD
	 dPlIOGGaPbYGjK92cBPsEKjLeMf7a82kCQb4tyERAHpUIilVDPBODOcb2EjLe6Mwkw
	 +PiHzhAlu3g3aUpqxrUfbCSauYQrV1NEdyVcY/GCqgkeXFQ9ChqEqKxASzCfAL3g00
	 46A2+r0fjG8T3gOU3W0gewDA8jsmZPj8kNjsfzeOjSwHmY0Mk7xpOszDkw3LE8JZEz
	 GkwcvhSAU26uQ==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com, 
 Basavaraj.Hiregoudar@amd.com, venkataprasad.potturu@amd.com, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Syed Saba Kareem <Syed.SabaKareem@amd.com>, 
 Jarkko Nikula <jarkko.nikula@bitmer.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20240329053815.2373979-1-Vijendar.Mukunda@amd.com>
References: <20240329053815.2373979-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH V2] ASoC: amd: acp: fix for acp_init function error
 handling
Message-Id: <171173372430.1605169.8973753810276675106.b4-ty@kernel.org>
Date: Fri, 29 Mar 2024 17:35:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 29 Mar 2024 11:08:12 +0530, Vijendar Mukunda wrote:
> If acp_init() fails, acp pci driver probe should return error.
> Add acp_init() function return value check logic.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: fix for acp_init function error handling
      commit: 2c603a4947a1247102ccb008d5eb6f37a4043c98

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


