Return-Path: <linux-kernel+bounces-100550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BE4879972
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F92A1F22A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B473137C3B;
	Tue, 12 Mar 2024 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuVBQ3lW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FDA273FC;
	Tue, 12 Mar 2024 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710262640; cv=none; b=hGHswftbv79Jf1ajjct2g/F1pHbdBsWc/bU8d4HK4y+pl6B5bhtL9Bdgs1yeoyLxaeZQ9Ylxa1DStmxUO1VQvxLHEhXPSXj2p6D6LSj87YLpKq88jk4CX4QTvWJ0hBLTgEuh8D2Y7EUPHTUOrAlzJkWrTP7Fm20+J6HlL2QyAT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710262640; c=relaxed/simple;
	bh=PoMYnCgPakbjiaIG4AGm3MpS8jEc7BheNhqUZ/bRjdM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VAkS4tmUhyVHrVvmaRpMcTcRp4pVenMoajL4Zxz3jlH2tj7cHvvJ796nFwP8f7+sS+PK0y6Is6GbZDM2GKvtyvysvC84NBSlOehSLmR3+jEQd1v6l/Go0GKzCs1p/L63n5B9GsI9cQvjLGOfFP0Ue9T5bR09btfy+ZsMHkf321w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuVBQ3lW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4ADC433F1;
	Tue, 12 Mar 2024 16:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710262640;
	bh=PoMYnCgPakbjiaIG4AGm3MpS8jEc7BheNhqUZ/bRjdM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IuVBQ3lWf5x6beNTTHw+NBaFEpnOMVIoNQqY01RMGZkaGcsE1qid1HNtGrnitnlVo
	 1IgFQnkrQd38DUFGVjqBiKy3TjKoj4z5mDkZiFUeGXi2T+6IKB2GRuoqr12R7xvvfZ
	 gVs8v8CDOzy3xQSzD14ywyRpkoa9WS9gHw+PbctiyeH/caQnzEDpXwx3tMP6AbvA7l
	 hL3ICWvq4hHdLsBHyGNQbFwSuRwzCqqy9s3UEJcWsa38fuW/6OIFQt6rdkkHORvycX
	 olzERaPLmo8kQNzCQPcNFmjYL1yQK+ogGVKNhgJNFUMCUZ6mx+a2r8h/u+FU7aJbpv
	 /FwDOFL8QOG8w==
From: Mark Brown <broonie@kernel.org>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, 
 Janne Grunau <j@jannau.net>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, regressions@lists.linux.dev
In-Reply-To: <20240311-spi-cs-delays-regression-v1-1-0075020a90b2@jannau.net>
References: <20240311-spi-cs-delays-regression-v1-1-0075020a90b2@jannau.net>
Subject: Re: [PATCH] spi: Restore delays for non-GPIO chip select
Message-Id: <171026263882.57722.2234727273926926410.b4-ty@kernel.org>
Date: Tue, 12 Mar 2024 16:57:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Mon, 11 Mar 2024 23:53:17 +0100, Janne Grunau wrote:
> SPI controller with integrated chip select handling still need to adhere
> to SPI device's CS setup, hold and inactive delays. For controller
> without set_cs_timing spi core shall handle the delays to avoid
> duplicated delay handling in each controller driver.
> Fixes a regression for the out of tree SPI controller and SPI HID
> transport on Apple M1/M1 Pro/Max notebooks.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Restore delays for non-GPIO chip select
      commit: aa0162dc0dd95c3bf248e3c78068760094e8f64b

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


