Return-Path: <linux-kernel+bounces-95983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C158755A0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5EAD1C22710
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D61131731;
	Thu,  7 Mar 2024 17:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQshEQcU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57283130E53;
	Thu,  7 Mar 2024 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834186; cv=none; b=QOApOjEnVXx9DdeG1GfnYIn/NqvcE6D/sfP6atecqGbll5D2Se5W4juU935uIjj8Ns+atX4omasHVDFegYvO9/pXKHQ5n+BrUYoxRv+oQ140vjiWN9p4IkGI8lpjJJLe9FNe6iwnyj3M3YIVeHRg7DVdfg+R57Pk96KFIouEVYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834186; c=relaxed/simple;
	bh=B2FgKktTSONugKYQnhC/4pEKRPCpJzFpvs+S9ffQIpI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=koxuQK8MDDnQMOzteinWxBECNj+UQIvFQfftqz4sUKdrr+7kBOK5mXJTNV1WCC2PEfhUpQHgUMRjz+n098b1Ylx8VYUPCZtXtHGKkDOhIeFDRwr2Xciwo9NKSQsHwb3GziLe8HhtWjgZnfnrD8g8snQNkt8lM7JXsXOuYL1t310=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQshEQcU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A04C433F1;
	Thu,  7 Mar 2024 17:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709834185;
	bh=B2FgKktTSONugKYQnhC/4pEKRPCpJzFpvs+S9ffQIpI=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=qQshEQcUc/foFOA2Z8fIim8m77X8c352TvdZ6Yxd9yGxjcFZ9okYN2TCJf8FPArML
	 KhAu8WF9g4OQJbTAh12nxvtwWe9Wpyl2c3EeyRCLUeBaC4ESBUukOE7cvbt8EkK6pe
	 /wtglXP2gBWKEwcHwmQeSUo//UOxsGeWoR+MsujUsM0Ynn4v6GfaEMcTO2McnoMG/t
	 n7OqgRD/lBNtI/YS1iKKHDpOLFx8kwUARKPHRNdcPaxxc/syBnoXj06yJUxNaLNW7L
	 X6bDeYsGCyDBtmXWnDfW5rxV4JVvAdtxWEr7r/zsB/tvG45B2+SkdmLyhuMKV1z7Fx
	 1Ddb2oYl54gkg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240307150256.3789138-1-andriy.shevchenko@linux.intel.com>
References: <20240307150256.3789138-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/3] spi: Add more consistency to CS handle
Message-Id: <170983418500.101661.7369058564166082695.b4-ty@kernel.org>
Date: Thu, 07 Mar 2024 17:56:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Thu, 07 Mar 2024 17:00:58 +0200, Andy Shevchenko wrote:
> There are the following issues with the current code:
> - inconsistent use of 0xFF and -1 for invalid chip select pin
> - inconsistent plain or BIT() use with a hard-to-understand comment
> - wrong types used for last_cs_* fields
> 
> Fix all of these here.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: Consistently use BIT for cs_index_mask
      commit: 1209c5566f9b244bd047478b7fc90318c9a310f0
[2/3] spi: Fix types of the last chip select storage variables
      commit: 14fe5a98fb24192f73639590d9d3cdb5640d48db
[3/3] spi: Introduce SPI_INVALID_CS and is_valid_cs()
      commit: be84be4a35fa99cca7e81e6dd21516a324cca413

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


