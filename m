Return-Path: <linux-kernel+bounces-82043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D148867E27
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F3B28F7EE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531E4130E3D;
	Mon, 26 Feb 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9+ZnGMh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E4712BE9F;
	Mon, 26 Feb 2024 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968028; cv=none; b=nQpbiLdYHOeQxAYFp4U7+j/JEz4PTc4dQvGz/Whp7o75z7eAINiDoEmbDer2vGsJA027knaNxwPI8NCaJGetFPOdKq6QntqjhuDZmWKBF5yyXADHupFbMg4BmK5SNCw8YhtnStI5/eRsHNwRbTNfm0Dr6V4lR5MTCJKMtPLYlIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968028; c=relaxed/simple;
	bh=nYrXyuWOkS6zdHWlq6i1e4OrZlpxjmsrtwPb0T4RU4w=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TmpwDQh/F2OelKDtFC39zM+jdrQiNJMWrl6OqpJMpvt09Gsi0Zl7QakdIQwQuPLcm9fbcK8V968AJs/xChgVBT9nCDKs2tE5vnVZnCiV4edUO5lGprTuDf7/UDFv/5uIxkLg05/tU8Yy5nfqYUjJztH1hLCyeexzNMg3KWLHKvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9+ZnGMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624FEC433C7;
	Mon, 26 Feb 2024 17:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708968028;
	bh=nYrXyuWOkS6zdHWlq6i1e4OrZlpxjmsrtwPb0T4RU4w=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=U9+ZnGMh7KVEtFXTkLLsUTbqjIfeTyotQ+HHAHkZU7Jq0I73LAG7CqUE8mj2wCOfj
	 8skjBiCQPIu/ThRao7ETfFx55yZdc1PlCzT2u3oua/vm7dH1I3NA4il+1KGmTuIknr
	 z17CO/fLHpH9gEOgBVrFYWKA+m8Nwy8T39KCVRbHWsWNKZVsegM692n5xSd4io0Y0l
	 1WeEwhVktMNpH0CikUKY/w8xV20ZojnXU6j+qCNizCin//Hhz4tpinrRoyuoDz++8t
	 NY9RssSBSvSADYVoSA3VZ9taoeDFM9jrM2cn8lcypXRaZ5595q8R2iokoIFffmv+6F
	 aEfuvIm2SS2oQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240129143534.109196-1-krzysztof.kozlowski@linaro.org>
References: <20240129143534.109196-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 0/2] ASoC: codecs: tx-macro: correct TX SMIC MUXn
 widgets on SM8350+
Message-Id: <170896802613.63378.9584283021927878510.b4-ty@kernel.org>
Date: Mon, 26 Feb 2024 17:20:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Mon, 29 Jan 2024 15:35:32 +0100, Krzysztof Kozlowski wrote:
> Changelog in individual patches.
> 
> v2:
> https://lore.kernel.org/alsa-devel/20240125153110.410295-1-krzysztof.kozlowski@linaro.org/
> 
> v1:
> https://lore.kernel.org/all/20230717140138.201745-1-krzysztof.kozlowski@linaro.org/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: codecs: tx-macro: split widgets per different LPASS versions
      commit: 051e887264b3e161cf2c1e163321b31191bf78a4
[2/2] ASoC: codecs: tx-macro: correct TX SMIC MUXn widgets on SM8350+
      commit: d34f0c8ee2e30b8a1470ce635289591148552a93

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


