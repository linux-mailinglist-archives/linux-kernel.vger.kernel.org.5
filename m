Return-Path: <linux-kernel+bounces-34139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7EF83743F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A19290D12
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED75A482C2;
	Mon, 22 Jan 2024 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gI/lmstp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBF0481BA;
	Mon, 22 Jan 2024 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956265; cv=none; b=RQ5XR/HmVGqZrk5TDqSgyiKpmn9s661duc5nekzzDuTXpyTQlv2npLhzxWKNmEGmQWlElhaFA8uldn2QCV0ICebwIxETu8zHX9YfiyehcWe+iCi84+2H6iIBTxvHRrZcUULvJDVlWNOve0vCYeivqTW/sUsc67iY+r02H/Tqxzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956265; c=relaxed/simple;
	bh=oDkDT6iAXlV0QIqN+s4z7Li/nnh1PW76mppCWWK9Ehk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qT/Az4viXBsoo9miKeYfadMEHrGBElTnX2jGfXbywWV5GZqM0yTTssZcimSnlM5ucJ1tBuZPWvnuv//UsnlVjQn82dsn+ee3UK8CoTx2La4Tc25Xelmb8w4q/qzz5HUK0LokLnznaqqFLrGUeEc3idTQerrOos1cY9j7WShuX9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gI/lmstp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1BFC43394;
	Mon, 22 Jan 2024 20:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705956265;
	bh=oDkDT6iAXlV0QIqN+s4z7Li/nnh1PW76mppCWWK9Ehk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gI/lmstp97c7THLe+3ZeoFa1fdCoCYuCqw3e2APufzr4P/JzjRHnd6oVP9vxDuENT
	 CVHAv/jEAh7HF4zj8nTkoYQ5ljYDADdVe5Lm6WGDTASMC6prANqpFavK4NMYfpFF2d
	 JULnpC0DgFoHeWBvUkzgUN1f1Uv2X3/2gBhu/oOE5DGJ3RperrqaIh0sRJnC1p5mot
	 DkfzHwzUGtQVNOxJnh1VBWrUEnTB+/DvDlFDKcaKBmBkTuZlbGlSPkEzASUVJIB+8S
	 R5P19Dn6H3HQSIGIKRJ1dJgQ4cNsfh2L4MoGD3BhZlFA/9QMZiWQsX06APuTbR5aUO
	 o813355Aa2dyg==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: stable@vger.kernel.org
In-Reply-To: <20240117151208.1219755-1-krzysztof.kozlowski@linaro.org>
References: <20240117151208.1219755-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/3] ASoC: codecs: wcd938x: handle deferred probe
Message-Id: <170595626282.145475.12611674756831880298.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 20:44:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Wed, 17 Jan 2024 16:12:06 +0100, Krzysztof Kozlowski wrote:
> WCD938x sound codec driver ignores return status of getting regulators
> and returns EINVAL instead of EPROBE_DEFER.  If regulator provider
> probes after the codec, system is left without probed audio:
> 
>   wcd938x_codec audio-codec: wcd938x_probe: Fail to obtain platform data
>   wcd938x_codec: probe of audio-codec failed with error -22
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: codecs: wcd938x: handle deferred probe
      commit: 086df711d9b886194481b4fbe525eb43e9ae7403
[2/3] ASoC: codecs: wcd938x: skip printing deferred probe failuers
      commit: 22221b13d0c20a9791dec33121df73fe0b2ac226
[3/3] ASoC: codecs: wcd934x: drop unneeded regulator include
      commit: 35314e39dabcfb256832654ad0e856a9fba744bd

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


