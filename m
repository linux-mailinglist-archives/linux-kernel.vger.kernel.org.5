Return-Path: <linux-kernel+bounces-61036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45211850C81
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 01:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1AA81F222A3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE3F20EB;
	Mon, 12 Feb 2024 00:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSCKBd5+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB9A1848;
	Mon, 12 Feb 2024 00:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707699457; cv=none; b=OlzqeHFZXki1ppwvCRqYHfQGyMNEJ0KhWVF1jw2UWPdc8zxIc9Am/XOSK9j9A9XovIi0FO76jlz3lCE2E9D2JDFIZfCC42uKJ7XFQF2JKOuyzaK6gA0rXxYGILZ7i/irGsxSMB1DU3jYnbFEk1EDP7NQhvAjtHfqqcrF2HvByDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707699457; c=relaxed/simple;
	bh=f1+XyZlGrkT91LtV4ti8zMhmwsUmUGP8D88gDMSdFOk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=McXXKvst3EiX1mxlRiuJ9b0ExrrkjrnP16ZxOQJHso9qwP2EIYLwW4Az4n+V+lC+DofWt2PL6Fg13xXR7wdUk6Ier7zv94swLNTzyWlftKmPPOMGapy7CsTghjb9dsiR/OMf7BdL6fa3o/10hxzffz6MBA0HZxL3NuinL0S6wgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSCKBd5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3B8C433F1;
	Mon, 12 Feb 2024 00:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707699456;
	bh=f1+XyZlGrkT91LtV4ti8zMhmwsUmUGP8D88gDMSdFOk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fSCKBd5+MW3VHjBWqmao4HSGz5LYVXb1FOKCI4jzwfV+v0yBvgoIDolIFeNBsOh9R
	 PqejjxzdJOP7c5VX8iU7Bi/G3mn0SlWjc1SSOa9Hb9E6V6yJOcfW7ZXX+oWpPLlyZj
	 sjhaNWbnsGHJpCq/L09QNcfpzbH69JWSJCbefNV9eEu9wjLDhk9CKExHmMajvYeSgs
	 zQQY/jWdtj/pJ3ms+miSHK9f1idQFhg3WPrXoPSLqvw6ttgjUKNpYZM0jhWI7Kx6T6
	 sSSGjzBWm2BCUZr3/T5ZHvS2avksNdJQ2Guhrd+zM1150zkjPmiWEEMrzUuZeAUWbU
	 wOvf3bcXj9YbQ==
From: Mark Brown <broonie@kernel.org>
To: Oder Chiou <oder_chiou@realtek.com>, 
 Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Shuming Fan <shumingf@realtek.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lvc-project@linuxtesting.org
In-Reply-To: <1707645514-21196-1-git-send-email-khoroshilov@ispras.ru>
References: <1707645514-21196-1-git-send-email-khoroshilov@ispras.ru>
Subject: Re: [PATCH] ASoC: rt5645: Fix deadlock in
 rt5645_jack_detect_work()
Message-Id: <170769945366.2475236.12473268972923112116.b4-ty@kernel.org>
Date: Mon, 12 Feb 2024 00:57:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Sun, 11 Feb 2024 12:58:34 +0300, Alexey Khoroshilov wrote:
> There is a path in rt5645_jack_detect_work(), where rt5645->jd_mutex
> is left locked forever. That may lead to deadlock
> when rt5645_jack_detect_work() is called for the second time.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5645: Fix deadlock in rt5645_jack_detect_work()
      commit: 6ef5d5b92f7117b324efaac72b3db27ae8bb3082

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


