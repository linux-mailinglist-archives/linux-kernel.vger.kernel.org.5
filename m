Return-Path: <linux-kernel+bounces-104700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1677587D28B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1985283C27
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E64248CCC;
	Fri, 15 Mar 2024 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V464N85d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AD8482C6;
	Fri, 15 Mar 2024 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710522795; cv=none; b=O0l9zvDs+VvUu+y6Env5RRVAnoP1TSEbWu+IwypFt4aqASI1uHptl4x4FEUVvTyi6ECDT4OD94eeKyv6yrdblXCOD5hDFPSpFpfmDuffrF5TJdTIbs2FmdTErtLKXAucE7aFFWtjD6TLqqW0r+PeR0jACD+t1Ftur7hJniIi3Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710522795; c=relaxed/simple;
	bh=iB8D8Y0+Ezt7I2UeHv7PGYugxc5Vspqc9YQ8G9EVEKY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MiLey0S1b9mkz3JWgQk7fuIfCqUWMd5QlxszZ+UrnFi0QNsMgLp2KeMBH3004LGskAGjykBKcG4cnjON1i8Sikz1l397ZGIpD9Sj9dpYlVcyW2eSxUiWA0iVknoJWIYGtcdQslp39wmX0JepNSwMr8kSl5dzh9ZsdiY7ZLaF2gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V464N85d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6102AC43390;
	Fri, 15 Mar 2024 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710522795;
	bh=iB8D8Y0+Ezt7I2UeHv7PGYugxc5Vspqc9YQ8G9EVEKY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=V464N85doIrRipUDaQLp4ix7/VEDNieWgyRAweCkj4TB8qHUmHeS6WoPiGDpexuzJ
	 5SZmCizeN+1XijOy/hCUyTggdS4VUBpvxlrLPK5YtBnW52WxiH/wHfCtgv1PA+xJMm
	 8Slm5GU1uCP9YqH0ZCs5p4XrVOT2wDYTqoh/m0l9/OmHWknq3If6oVAIYueCuBzYIJ
	 l2iYZG9AUnfIn/ZyemC1W+teHe2x79UbD7apNPBzPR+OZuuEpxV+4fjQWbxkUJVyP+
	 vrADjH3CcTfClkqmVcgOJnhH91m2L/i56dNef+tCLUtKFXt8PmRHjtGWwVKqGwfChN
	 TrzsNDYIJft1w==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, 
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
 Michael Walle <michael@walle.cc>, 
 "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20240313194530.3150446-1-florian.fainelli@broadcom.com>
References: <20240313194530.3150446-1-florian.fainelli@broadcom.com>
Subject: Re: [PATCH v2] spi: Fix error code checking in spi_mem_exec_op()
Message-Id: <171052279309.52555.176747967230384513.b4-ty@kernel.org>
Date: Fri, 15 Mar 2024 17:13:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Wed, 13 Mar 2024 12:45:30 -0700, Florian Fainelli wrote:
> After commit cff49d58f57e ("spi: Unify error codes by replacing -ENOTSUPP with
> -EOPNOTSUPP"), our SPI NOR flashes would stop probing with the following
> visible in the kernel log:
> 
> [    2.196300] brcmstb_qspi f0440920.qspi: using bspi-mspi mode
> [    2.210295] spi-nor: probe of spi1.0 failed with error -95
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Fix error code checking in spi_mem_exec_op()
      commit: 29895ce18311ddd702973ddb3a6c687db663e0fb

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


