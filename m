Return-Path: <linux-kernel+bounces-123958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474E6891055
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0107C1C24CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C31F17984;
	Fri, 29 Mar 2024 01:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3W4jUL7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF907CA7A;
	Fri, 29 Mar 2024 01:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711675741; cv=none; b=LbNaAVXZoyi8eTyEFMciAJzPb5aGdLJRjj/9LElawsWF/19k8tZWzc7HzwzEMCQXMTStxJENF2QnEeSplFLz3ESdqcIABRhMeqi1QE8bSw7/02yk2Ox+NZTRu0lIwtjDzj6Ejra6RoMSdOgoAXFZ2iyzTaXA2EFNpIqbUmc3x9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711675741; c=relaxed/simple;
	bh=7t0PTh6b0EevDtSDEGqSKuK6+zZPZ8N6STed1+/KM08=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e5kWXmSBAiZ0cB2nT96kfeaKvjeGqNjY7whsYQ2vKUNLZOI+i4xsYwqog3enmGSfBqDo4LHSQlQWLqib5r/LWt1JoEx6Gco2BSzqrP2WN4ti7ofDYIznC8qYRo/7Sv8xQe84zj6N8zi5HCOTzjn9U/d+U2/4/NXIyFPfBU7y6nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3W4jUL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D49C433C7;
	Fri, 29 Mar 2024 01:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711675741;
	bh=7t0PTh6b0EevDtSDEGqSKuK6+zZPZ8N6STed1+/KM08=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=f3W4jUL7arEsqVSbPJ+FcX5/0YwYo7t3mecM+/fKurUi8EKyaGIKWez7Z+oLgeoWA
	 QjNrvCgda0lQluF4t4Qodc/Mt4tZUzRhkzqDfwPnfvGD2oy8F2Rm7GdTqJtcD/cvZt
	 6kkO7c9fwBiJk7x5Ad5Urp6hhlRWgdiRogZjNWTo0C//tOmLPAH3hAxjivlZ6uxVSK
	 a64YxxECcTFJWqE1fbD7W5OmE4+fKk/XrVDCBdg9WAEWOQt9mQjMQe/hZVQyK6/snM
	 j+4VnZzCRM7PLJFsa+LtQJhSJC42YP1w/5F6F7Mo83hRcZBOmjT54vULKYJABa/Cjg
	 9IQ8YarbZHtIQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Aleksandr Mishin <amishin@t-argos.ru>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lvc-project@linuxtesting.org
In-Reply-To: <20240328173337.21406-1-amishin@t-argos.ru>
References: <20240328173337.21406-1-amishin@t-argos.ru>
Subject: Re: [PATCH] ASoC: kirkwood: Fix potential NULL dereference
Message-Id: <171167573947.187137.5081956001742920616.b4-ty@kernel.org>
Date: Fri, 29 Mar 2024 01:28:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 28 Mar 2024 20:33:37 +0300, Aleksandr Mishin wrote:
> In kirkwood_dma_hw_params() mv_mbus_dram_info() returns NULL if
> CONFIG_PLAT_ORION macro is not defined.
> Fix this bug by adding NULL check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: kirkwood: Fix potential NULL dereference
      commit: ea60ab95723f5738e7737b56dda95e6feefa5b50

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


