Return-Path: <linux-kernel+bounces-82224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C4B8680BC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89AE1C29C79
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026EB130E4F;
	Mon, 26 Feb 2024 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIsnQmVD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324BF130E3C;
	Mon, 26 Feb 2024 19:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974994; cv=none; b=W6++xQ7b77GF5K/K81oMTgWoNHtTJygR+85PIGhK37niPTic2CZk0JrYFOZvfwJHlK7jkNWPkemRjV9EuwlsaqTHJc0sEDXtMkGuG22yjH0ViFhBJZ57heTR+qtiNGTlSlq2N/GP9f5/yB+bywy2euAIFBD2IKb1ZTb8Ibfx+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974994; c=relaxed/simple;
	bh=SbNCXSNgmsHvZE9a2LpECzn1pLI8U+O6zKu8IEb7FC0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Oc1ylSY+R3QewzXgqJ8aBVBwgCtk06YTqVDSrjl1rVaPp9lM0jqwMv5FhAHX9wb20LTwYys44Ulth5buChEEnyTLPJZR5WLMwmLjcjsQ2UUwvMjWdlpoUM2vAQVlMUwzYQEY+QtXFzPjtq9NrFsldZI23zYGKaiNAa3PcXHeqHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIsnQmVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D98C433F1;
	Mon, 26 Feb 2024 19:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708974993;
	bh=SbNCXSNgmsHvZE9a2LpECzn1pLI8U+O6zKu8IEb7FC0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MIsnQmVDw/trVh09qDNojxvjYpsL03Abgycr+6i8gxKHJQ2+p7hYTIkhhGt+zGdxZ
	 GX5Pal9Wugiq54uqjJuPA+s+XvZc4zKK8WN9kr+BSzta3JBokdfEiOFEjw5Cl+v9OU
	 vXsBMXBarSnIvdFeGpgCRj3pgIXW3/WXBF+OGELbRJvRzzgBED4xFg/wTKPmfDDlEP
	 Y7kjz8B9/n6PYRs4xUVhaMrliNQcA5/n9rn7f7+T+s4BusEFOFiOlZXyipdARz/SdZ
	 DZsTIWpdTuL1dviT0qsVPKNV4Mg2qcM1I9a3MzhqGkjOPHcWVqq/ltyn8mPr7xtaNC
	 xvvXJ1cDcT8Zw==
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Martin Sperl <kernel@martin.sperl.org>, 
 David Jander <david@protonic.nl>, Jonathan Cameron <jic23@kernel.org>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
In-Reply-To: <20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
References: <20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
Subject: Re: (subset) [PATCH v2 0/5] spi: add support for pre-cooking
 messages
Message-Id: <170897499057.117217.2960696908311224436.b4-ty@kernel.org>
Date: Mon, 26 Feb 2024 19:16:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Mon, 19 Feb 2024 16:33:17 -0600, David Lechner wrote:
> This is a follow-up to [1] where it was suggested to break down the
> proposed SPI offload support into smaller series.
> 
> This takes on the first suggested task of introducing an API to
> "pre-cook" SPI messages. This idea was first discussed extensively in
> 2013 [2][3] and revisited more briefly 2022 [4].
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: add spi_optimize_message() APIs
      commit: 7b1d87af14d9ae902ed0c5dc5fabf4eea5abdf02
[2/5] spi: move splitting transfers to spi_optimize_message()
      commit: fab53fea21a909e4e0656764a8ee7c356fe89d6f
[3/5] spi: stm32: move splitting transfers to optimize_message
      commit: c2bcfe7c6edf418d5adf731a7d60a8abd81e952f
[4/5] spi: axi-spi-engine: move message compile to optimize_message
      commit: 7dba2adb063bcf7a293eacb88980e0975b1fb1fd

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


