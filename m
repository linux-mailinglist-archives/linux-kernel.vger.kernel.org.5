Return-Path: <linux-kernel+bounces-165947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1973B8B93B4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 577AAB22589
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D29F1B815;
	Thu,  2 May 2024 03:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHSqB5GW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8B3D527;
	Thu,  2 May 2024 03:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714622223; cv=none; b=rKvqvgb2GEG+gjnTwIVjZlP21NMbQ6rl0/opvQmBWoZHjBHFblyp7AlDJiZBQ6HpdGZmMGfmFzQntWKQofcbf36ZOGiH5Qclyk/ezxicoPqynNRbuQ7mSelZu7+sdOmtKtNwKX6VEJ3KTBWysRSMVB39eRTSm0hXejUKeXN4XDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714622223; c=relaxed/simple;
	bh=av6cRvs/KdC58mw6iPdJqlAqSCE0u9jK5NqajQSe7AE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qmzTEx35Gv2pice9JWWOJP7Oaq4lAzxwPDquhOhj6HSRwBTNEu6z8jhP1tQtj9gFmFObdiK9K2fcoIcBlUHtjyBvi+ERUgoHXs/Z3IFIlZUNJDltegWG79cq9YFLEtD1EXb2Pd95Rf1ehgqpIx8j3ekINHRReD+4BLEzWVMAoOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHSqB5GW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D87C116B1;
	Thu,  2 May 2024 03:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714622222;
	bh=av6cRvs/KdC58mw6iPdJqlAqSCE0u9jK5NqajQSe7AE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BHSqB5GWTTS3H4MRAe1L87Pd8arWNCTpAZVxcJBElbJJgX8TRkg+FzdrbjNg5NeST
	 sB2UBk/Z7D6aUNcRxnXCze3G+Zl/oUlTU8yw9d/XF5Mfaa4EQcdu535TNVP+6fkGSq
	 5cE2RbcCd6NMXRZLzLV1ujLeGNfywAW2D5Kug/r7pJYMIBueIRa3fcEt+cbokJgU2F
	 49RW+nLO31PTekd9eGShH34TV4fBKDPfIuhqdwNERlizvZ+9fprKg+bZROIfqJdh0q
	 dHb7ae6oIJKKzoOUoFFyE9pywyzetPIwgMYtJBYqeqFxVPHjbX090BUdq96pwOYHot
	 USejzBTTl8wzg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20240429112843.67628-1-wsa+renesas@sang-engineering.com>
References: <20240429112843.67628-1-wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 0/8] spi: use 'time_left' instead of 'timeout' with
 wait_for_*() functions
Message-Id: <171462222116.1904471.13111668910715356522.b4-ty@kernel.org>
Date: Thu, 02 May 2024 12:57:01 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 29 Apr 2024 13:28:33 +0200, Wolfram Sang wrote:
> There is a confusing pattern in the kernel to use a variable named 'timeout' to
> store the result of wait_for_*() functions causing patterns like:
> 
>         timeout = wait_for_completion_timeout(...)
>         if (!timeout) return -ETIMEDOUT;
> 
> with all kinds of permutations. Use 'time_left' as a variable to make the code
> obvious and self explaining.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/8] spi: armada-3700: use 'time_left' variable with wait_for_completion_timeout()
      commit: 7dbbbb1206dd0b695b9a76d3b758c8a689f1aa52
[2/8] spi: fsl-lpspi: use 'time_left' variable with wait_for_completion_timeout()
      commit: eef51e99f7b9ecc903a3a9ad9e7ca84dc35c3f52
[3/8] spi: imx: use 'time_left' variable with wait_for_completion_timeout()
      commit: eaeac043ab842d2e84616ff0412eec0121c1758c
[4/8] spi: pic32-sqi: use 'time_left' variable with wait_for_completion_timeout()
      commit: a7c79e50a26cb619400ccc6294dbd7d8c24a0341
[5/8] spi: pic32: use 'time_left' variable with wait_for_completion_timeout()
      commit: e66480aed4a194f278da1e46ec45221b3983216f
[6/8] spi: sun4i: use 'time_left' variable with wait_for_completion_timeout()
      commit: 34bed8a33f3a4f69b0ef584ef49f04a671a4a5c2
[7/8] spi: sun6i: use 'time_left' variable with wait_for_completion_timeout()
      commit: 83a3f1ba60d6e2f73c9dd2627a8ce41867dbc46b
[8/8] spi: xlp: use 'time_left' variable with wait_for_completion_timeout()
      commit: 594aa75d6bdda85b5fd027a5056d8cd1345c1db3

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


