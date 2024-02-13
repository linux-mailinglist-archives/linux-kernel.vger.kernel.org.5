Return-Path: <linux-kernel+bounces-63967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 269848536E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4651F2698E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB6C5FDA8;
	Tue, 13 Feb 2024 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5gbgqNn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FDB5F84B;
	Tue, 13 Feb 2024 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844358; cv=none; b=dNe2mI0k2R3yKtTN9xsVU0yBHqQMc+2rnKGuwwItzcb17n+fi/HeC43BHLx0TUbp3oMy1swi6XP8BJ/rGseZrI3ZTroN4YHX7jt4Im8LORjrGxmCCAtNJzrO1L4GvHC0q6fIwdtv4TN94CcuwroHD2eJzTcoW8mMbqzzxZ/+3Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844358; c=relaxed/simple;
	bh=4a+evY0mZO8wIOkZmZjF8xeTorrvG9xu5R33q/440cc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U1rQB4GTTsXZv9p8RLmssoa7E+Cp7MUMmf4o0uYP28wAe7b3mrEpkX9aDPpjRPSRWE+1guwzteVTIAgyGM3NNtyT/gdIIckeuyJ3+ewed3L0+Zqbyjb/E1G9ab9gN6tFJwTRLp9+QMo+EPxwRFNXuBfKNrqt/hs6zpoYxGw943o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5gbgqNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86985C433C7;
	Tue, 13 Feb 2024 17:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707844357;
	bh=4a+evY0mZO8wIOkZmZjF8xeTorrvG9xu5R33q/440cc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=O5gbgqNnELJoOwNQZXjLj0clNFzyt8oKYwWxMOmLctax6JAVNisqhgXmz2FTX/G5T
	 C2e2OGYqhOrhPHZTACDV+/AdiwkDH98NvVTHqrIy+G6ZZyKBrvxHrrnhudlfCS1grv
	 v4Gsb1EUoS801fCJn3I5Vmjpke7CYey/j8AFFLmqilW/ioTEaqLxGd5NsNSL+8GGSd
	 NRAHgdt/xArWE9qiw+ezxKWwlv3tOCuZGuS9H+Z86vmwFDHB87CrTgUlrHm1DN0j1P
	 SFnFBbFPknXr6lqyU1TfmQNYNQVaZGEwMA8ABm/TMDj1CTsByX8m1yhKi+gJ18zMLn
	 M9pubAtLB5IGA==
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Mohammad Rafi Shaik <quic_mohs@quicinc.com>, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev
In-Reply-To: <20240213101105.459402-1-arnd@kernel.org>
References: <20240213101105.459402-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: q6dsp: fix event handler prototype
Message-Id: <170784435426.387832.9390509804321653971.b4-ty@kernel.org>
Date: Tue, 13 Feb 2024 17:12:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 13 Feb 2024 11:10:46 +0100, Arnd Bergmann wrote:
> clang-16 points out a mismatch in function types that was hidden
> by a typecast:
> 
> sound/soc/qcom/qdsp6/q6apm-dai.c:355:38: error: cast from 'void (*)(uint32_t, uint32_t, uint32_t *, void *)' (aka 'void (*)(unsigned int, unsigned int, unsigned int *, void *)') to 'q6apm_cb' (aka 'void (*)(unsigned int, unsigned int, void *, void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>   355 |         prtd->graph = q6apm_graph_open(dev, (q6apm_cb)event_handler, prtd, graph_id);
> sound/soc/qcom/qdsp6/q6apm-dai.c:499:38: error: cast from 'void (*)(uint32_t, uint32_t, uint32_t *, void *)' (aka 'void (*)(unsigned int, unsigned int, unsigned int *, void *)') to 'q6apm_cb' (aka 'void (*)(unsigned int, unsigned int, void *, void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>   499 |         prtd->graph = q6apm_graph_open(dev, (q6apm_cb)event_handler_compr, prtd, graph_id);
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: q6dsp: fix event handler prototype
      commit: 5b5089e2a1e753ffe9ee2bf101a9e06784ec5e1a

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


