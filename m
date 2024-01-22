Return-Path: <linux-kernel+bounces-34142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8A283744B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39BCD1F292DF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC0B48CD2;
	Mon, 22 Jan 2024 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSTU3F+h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8015A487BB;
	Mon, 22 Jan 2024 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956272; cv=none; b=eGsvbOC0izbkZUWY7XO/ezxGvijzUHZRHOnsNIaWbNeclMTNlUEIDrxeWa6gnNynrelo1z4UZE8y0UPTnMdTSgUy+dHPhhTyRLGgc+5ll0wLr8zIVTZNX0qlFk6TjbYx+jNCXHTkqUHckaAkmgoUoAhO8v2LAP+cJFJLrrRiMmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956272; c=relaxed/simple;
	bh=oBgJLUj2aXKpW7e/hPKEHrVXPhS5AsGriZEEUK+OLxA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Hfin3Me95ckfBHYnch4U0J55YPFK1uwMOcVi9qsANJjXQ+5PtxSiVXIS6HIunEPNgg4H5rEipt7rHa8t4+eg7XUn9byh+K5724cQSyBfqgMIL2hdSnOQey6o3zukohMcVqx2wHd/XtqRF0r4je//nVhv0e8DWYD20Fmvqt9l8Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSTU3F+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695D0C43399;
	Mon, 22 Jan 2024 20:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705956272;
	bh=oBgJLUj2aXKpW7e/hPKEHrVXPhS5AsGriZEEUK+OLxA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cSTU3F+hsOTIk/Gp6atNQRDAgmD4KYRfKuwiI3vVcZvfcA7h9NC3UuRlUaXCGOh1Z
	 npAmSqKI5yzAFtVoL/ddtZh/4Mp88MbHBAy/Hj47HrbtMbQzpQt9DjLG6qWODOZNZl
	 tQ2vBhPoZBlhXP5oGltYIhIJr1PbGuHhyyJtrjlEZwiuHK+WOUUrlP8H3XaNmVyF3S
	 CrkEAnkeg5p0a3SHifYzp3huvUCpVlZjpRclin1hVaR3iGZR6HLt4HBkuKAaD+pHDk
	 ucmhaGx0x48317YBVsulw3foy5vTeLREHS5RuGu8ejZXAx17ZogQ7/7Ns73VFl81Wf
	 PvQst8veXN5uw==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20240122091130.27463-1-johan+linaro@kernel.org>
References: <20240122091130.27463-1-johan+linaro@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: wcd938x: fix headphones volume controls
Message-Id: <170595627015.145475.8123621699638951832.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 20:44:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Mon, 22 Jan 2024 10:11:30 +0100, Johan Hovold wrote:
> The lowest headphones volume setting does not mute so the leave the TLV
> mute flag unset.
> 
> This is specifically needed to let the sound server use the lowest gain
> setting.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd938x: fix headphones volume controls
      commit: 4d0e8bdfa4a57099dc7230952a460903f2e2f8de

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


