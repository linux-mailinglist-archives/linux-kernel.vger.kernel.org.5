Return-Path: <linux-kernel+bounces-65265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9DD854A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4F10B2134F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4810354745;
	Wed, 14 Feb 2024 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sX/UcCP3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA8854677;
	Wed, 14 Feb 2024 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707916928; cv=none; b=FxYNFdvb7RVMcvVDQ3P6TNE79wd3lqLWyB9XlCBzOPpvNvn3QNIqkM+oAPR3bta28LVdkblCRWR5+DyoQCxjP8Lfu3aicuaZl+WiMkfQzedxamZvbJITYwACh8sdnJHzevAnZPhK4M5lIOaeWb8LCYwLD+vdEBUlBMZ0tP6KYbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707916928; c=relaxed/simple;
	bh=3BhU0aZnn35CAZKdM6PG56ZetB26JCBoUcsKfsvxGTk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=En1i5SMv8g7EsX9DZ8/RLxNTgQsDSOQYKM5+Svw6a5izv1iqw81JaAh0zPB2lOqWomgeNJqbLzfkCDm+DhS+pf/Sv/GhhyW/323UV0fr418hkzJKVBPbg7oNK6XAPJx1oRmXkY1Sa+zA7AbbXBkMT+vnNNt+HEeK24qneBjWLlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sX/UcCP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6E5C43390;
	Wed, 14 Feb 2024 13:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707916928;
	bh=3BhU0aZnn35CAZKdM6PG56ZetB26JCBoUcsKfsvxGTk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sX/UcCP3s3y2QCF0191UjJyD2CJK84+XSRUiI1nfqhs8x6EgXD4u/hDmD6bigwF0/
	 j4AjeSgE3JEtXKxEFmPBtkU8LZVYahLjimx/yREgHv32imHWfpSwWWpju+eb1e06kd
	 0f5MrjyH0sPnMVLVopaWMcRaet7EWXbGXir6Vi4F1W+jyDvOUE7z4uF2BpAN9JxIUe
	 iux4t/Hw7uSnQzEdn2E37Z0Nf5bJUGDU0uyQb1vVPmQGo/5OW7xy2xejDh9ixeJnrI
	 U2CE6YqI+unaEX68jDwd/JNsVxnsOHKrkBbcsNSwIGwOkG0xbFae2+1zSCxzB0hXD9
	 b73jVOR6qSvnA==
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <20240213215807.3326688-1-jbrunet@baylibre.com>
References: <20240213215807.3326688-1-jbrunet@baylibre.com>
Subject: Re: [PATCH v2 0/2] ASoC: meson: aiu: fix function pointer type
 mismatch
Message-Id: <170791692451.143237.6316282376548391909.b4-ty@kernel.org>
Date: Wed, 14 Feb 2024 13:22:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 13 Feb 2024 22:58:02 +0100, Jerome Brunet wrote:
> This patchset fixes 2 -Wcast-function-type-strict warning in amlogic
> audio drivers with clang 16.
> 
> Changes since v1: [0]
> * use devm_clk_get_enabled() instead of adding a dedicated helper in each
>   driver.
> * Split the patch, 1 per fixed commit to make it easier for stable.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: meson: aiu: fix function pointer type mismatch
      commit: 98ac85a00f31d2e9d5452b825a9ed0153d934043
[2/2] ASoC: meson: t9015: fix function pointer type mismatch
      commit: 5ad992c71b6a8e8a547954addc7af9fbde6ca10a

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


