Return-Path: <linux-kernel+bounces-56705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A855784CDDB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4787C1F22D0C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9117F7E6;
	Wed,  7 Feb 2024 15:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqBteE4V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396DD7E77F;
	Wed,  7 Feb 2024 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707319278; cv=none; b=bGLlLos8D9i1BBhrs+ZyELKdmeMvOc2ysbK5WuxNwESS14WQPHcxqcF0c2eJ/YI5DwM0sDy3qjdpsbZuqNuCtavifh34Ugms32TdyG3hkJBbpdkrFClx9fHH179L6rPZzz4TI18RenjIdr/sBRZdzgQEG+RqAchX1o5uP6gPmAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707319278; c=relaxed/simple;
	bh=G/nJs42QSxBHIw7VLRbyxA32VFnZ1LCXl9jq296Ee+M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aaI/dDbaH35HCbrpiEaMz63yjUUSahf4avTUqh2P/SA1ycKUSgse7aPlshetHel2ojeihHalrUYieHtORqqDU//hcc0HXgEivcpJFh8BiLNhKpWQhFVPTsSkhJUOMzoSAApf7zZMbZ4zNe/LT4fmL8yiJsVc7tNpobZLcwZ24Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqBteE4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D03C433C7;
	Wed,  7 Feb 2024 15:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707319277;
	bh=G/nJs42QSxBHIw7VLRbyxA32VFnZ1LCXl9jq296Ee+M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AqBteE4VCBRnqMDjHLeEAuRUl6X5DlM2b4SEZk9IcJs68QVblBkvEamDC1UWi1CzI
	 /TtyxHBeuFAW6vLpHOE082b4T/AfZ5nTX/FTMmcAs1vrsIat5LCraku5cprtFu6WKf
	 PUIIS/1Si9Uc2wqccagfZ6kLudgtfkfpzr5TnwQZCYccwVjPZoYKps3Af+X76kf20m
	 nNyUt+Uxy4lwljpPrhGXvKinxKkTmnMEYdH6utj98d9RrRiPVis3eNxL0tm7TkSYG/
	 3sFqPDMEdiVvYdp8rog+GKYWfV3jkfNiR+pAswVMuGx82NhWYvqYH5zEiXaCo/yW4j
	 naOiat9SGYTYg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Cc: Alain Volmat <alain.volmat@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240206200648.1782234-1-dlechner@baylibre.com>
References: <20240206200648.1782234-1-dlechner@baylibre.com>
Subject: Re: [PATCH] spi: drop gpf arg from __spi_split_transfer_maxsize()
Message-Id: <170731927648.1061486.14426168465610494014.b4-ty@kernel.org>
Date: Wed, 07 Feb 2024 15:21:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Tue, 06 Feb 2024 14:06:46 -0600, David Lechner wrote:
> The __spi_split_transfer_maxsize() function has a gpf argument to allow
> callers to specify the type of memory allocation that needs to be used.
> However, this function only allocates struct spi_transfer and is not
> intended to be used from atomic contexts so this type should always be
> GFP_KERNEL, so we can just drop the argument.
> 
> Some callers of these functions also passed GFP_DMA, but since only
> struct spi_transfer is allocated and not any tx/rx buffers, this is
> not actually necessary and is removed in this commit.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: drop gpf arg from __spi_split_transfer_maxsize()
      commit: c0c0293cf7a0f21ef461956d44e4add718574f3f

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


