Return-Path: <linux-kernel+bounces-147789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 494A78A79B2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3161F235DE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4150F4404;
	Wed, 17 Apr 2024 00:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJhc9nax"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FCB3D72;
	Wed, 17 Apr 2024 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312731; cv=none; b=jtiNeLKXyMR6rn60bi6H1zTu/+XxN6qBpHxD8tWibOMc81ySvu4w9GKPI1ZkH3rFrPzabqduvJfLrAfIwZ+q1OwdmdvVViVfhKW+ep/F6bPklik0p1EAi4Bw2anhmb8sf33MuRoqfmiuRZzR544qye/LgP7RgvcEcwQRWYx3iBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312731; c=relaxed/simple;
	bh=VEfUnptLW3E5iQ/IsA7FKaUJ4bl24r1+Io0s4KjAbkQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qwa+vEBijhYyG1UyWTEO+AqDRy/oKNHPdt08ius5ev1MnzfKjxB2h3JdDOaejjW63dCZBTvREPtW7VqXyCkYbnF1+Wz2Ga0hE9mfBZdfG1qSB1pEKtJOUMu2XGEI25Sh4n8R03oihkyGtCxLyxO3ii5Uco/U5cx6OsOKv+zwEpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJhc9nax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348B9C3277B;
	Wed, 17 Apr 2024 00:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713312730;
	bh=VEfUnptLW3E5iQ/IsA7FKaUJ4bl24r1+Io0s4KjAbkQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=NJhc9nax/pZv5CXc3R23R+aCh5i+yISYeS309pq4RU/xqwYzZ9L+kvAyCkoU88r7V
	 Fcti4GUmqAtThAaSf/RzDACZwgwp1XpRR8YLeDfYmm02ADjRbCkuzSG8NpFeD2p51n
	 menOMF4D2yuwJuSMMnBIXX5qb7GCR6qdfNc6rdKw9O3WzUtyh7VwOoE9rAtPaPT9yn
	 mIBsSA/NszOlss95hi5Q4iC3VgTul+Jbh5zwbNlPJ6G+dUAEUWLiJZEwwyKsT/MSDF
	 TEoQ+DUN2wrp/93mHucppQ1Qnm5g0/YYTva1xqpAxksH3MJX8RfTpOhV1c/BPbZoKs
	 2RAjlSiyabVmA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240415193340.1279360-1-andriy.shevchenko@linux.intel.com>
References: <20240415193340.1279360-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/2] spi: More refacroings after multi-CS support
Message-Id: <171331272967.1685839.10527900004929143033.b4-ty@kernel.org>
Date: Wed, 17 Apr 2024 09:12:09 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 15 Apr 2024 22:31:18 +0300, Andy Shevchenko wrote:
> A couple of additional refactorings on top of the multi-CS support.
> One is to make sure that the comment and the code are not disrupted
> if additional changes come in the future and second one is f or the
> sake of deduplication. In both cases it also makes indentation level
> smaller in the affected pieces of the code.
> 
> No functional changes intended.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: Extract spi_toggle_csgpiod() helper for better maintanance
      commit: e81582c080ddec3359bc6726291e62a1ba8b7350
[2/2] spi: Introduce spi_for_each_valid_cs() in order of deduplication
      commit: d707530b1ea518e23c7aa7b50ee79231f2964da0

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


