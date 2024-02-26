Return-Path: <linux-kernel+bounces-82044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3223C867E35
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C541DB25D62
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1436712DDB5;
	Mon, 26 Feb 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMWuQ3+X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5922F130E4A;
	Mon, 26 Feb 2024 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968031; cv=none; b=hMcnPuRLdbbLRvsNc4RTJN6PqYW/c20OET4J7dQ4dBSVK+to/xfgN9AGE/68sqEfr2elwoJElnfZ/Dpi76c7XQSjmxW9XCgkVbrGKQWrqlE2F0c9DYq9FVNwB96kosDbe2qqixJ/hAn/0BYWWAYE20bbfML8BfCYHEDKQNoTI7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968031; c=relaxed/simple;
	bh=Eb5QJZq20bhjsWqs2X9DC4ThP+eO9VDbT7OG3VuTb/Q=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DYkOh99SQ7sApTO5k+ytD6UKg1e7wrUF8fEGMsxFf+zl0jR2pmySqSjg5loyOJqE2L/N7QhBz1IkdCGw7BmwVlR3czRRJe05uXsBPT6IXQeXBdTxharyQ5hNtu89PSP/565KnPowVrD67pYSNlehbamGXsH7FxlLswJaEBLauqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMWuQ3+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A27C433F1;
	Mon, 26 Feb 2024 17:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708968030;
	bh=Eb5QJZq20bhjsWqs2X9DC4ThP+eO9VDbT7OG3VuTb/Q=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=NMWuQ3+X9U+UU071H9oZjSARYzYtXPb2wvlLaLxsZxBNmP7W5sy1J7+iVZuWQwXbX
	 FtuMB+ZDhjbo5/QnSzftpuX30iM6VdledqHi8Z9b9IFkH5KZvAdVtvfmTzhCSeBVPT
	 f3Y5jieMz3/vrVHhEf93yV86zlxU4Rbu6YHwvdcWc6qf7xpLftjqRREbu9prwXA+Oi
	 cAiRrbW6YFfuBBt8zd45do6huU6pHf8n6Vw4ttLS/Ggmms8vXGcYMRfbspxqG1eVmJ
	 s74pKs5xVdwh2K5fErULACNxCvaD/lyqxG7dXsAFD6wiuSsOPt1o6LGLIMobqCNiwf
	 zgH5TyXiVwvTA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240226115925.53953-1-krzysztof.kozlowski@linaro.org>
References: <20240226115925.53953-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 0/2] ASoC: codecs: tx-macro: correct TX SMIC MUXn
 widgets on SM8350+
Message-Id: <170896802827.63378.739994533029521366.b4-ty@kernel.org>
Date: Mon, 26 Feb 2024 17:20:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Mon, 26 Feb 2024 12:59:23 +0100, Krzysztof Kozlowski wrote:
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


