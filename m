Return-Path: <linux-kernel+bounces-35250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A48838E92
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E3A1F24505
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFA45DF0C;
	Tue, 23 Jan 2024 12:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wlc52oS6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9427A5F540;
	Tue, 23 Jan 2024 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706013125; cv=none; b=LSFqvGoAqNNtGpbrI5MBbY5OwjAuV1lq2U0nwTs80uUE7rZbkG2RVmOr3C9t+/XVe4tqIxpTuk0aNg65KV+cEt07Q7UQ6hAdlWmmBodYzMynZa47ghCVDzelY6pJHt2GsVU9VqQ4xn8JL6FDgzFutR70XbA4ovLPvw2V9/9zung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706013125; c=relaxed/simple;
	bh=d4c8ZHsXz70kQqHT+wAs67wpSpeSuJtNg6++BZ/o6sI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q2/BmOKLaM5P7mqM6omShpJ1FplfxXRZcGmLd47UUAfQ64IutvYZ41SIcYCknWlT4Kpeay6uS8wkeS4Iw9Zi21kfmvp0Y8uBiDZNLyyDTD6eRNnt1/anzaxcOMtu0LBe0SXPOU1XUTkLp/0Ur9fjcsgdziIysfxrH82e5kBMpQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wlc52oS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469B8C433F1;
	Tue, 23 Jan 2024 12:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706013125;
	bh=d4c8ZHsXz70kQqHT+wAs67wpSpeSuJtNg6++BZ/o6sI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Wlc52oS6+s8GcWNgx7vWTuHU4SAxi/gQYyGslKJr1BqcbHnwCKGCCB3BVduBMe3/+
	 ZiWBIBtpr71gbg4lCodlRQonDSeYb20dG7hu1k9/SFPV7qvhMeiVX8vwERXMUayldv
	 vtep65X456exwJwase9LYTq+vX0E7EocOthJdUk1gbdxLdzviMsSqw31fqqAOsE+lw
	 H7o2YAxYIMwHoFvuqyrYRShk5TiPzIQWSDJ8t9XZAOvw+5kgfVig/AT+2O5l0GkHfN
	 W1uOWGHULnyIsPj0gzyIcj7z/yXWY6pL7vhbAPqRKun5amZ5zH0sV9TXFZPOG1utuw
	 yW0P0VX93JpDg==
From: Mark Brown <broonie@kernel.org>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, git@amd.com
In-Reply-To: <20231218090652.18403-1-amit.kumar-mahapatra@amd.com>
References: <20231218090652.18403-1-amit.kumar-mahapatra@amd.com>
Subject: Re: [PATCH] spi: spi-cadence: Reverse the order of interleaved
 write and read operations
Message-Id: <170601312400.19682.11415116408445396292.b4-ty@kernel.org>
Date: Tue, 23 Jan 2024 12:32:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Mon, 18 Dec 2023 14:36:52 +0530, Amit Kumar Mahapatra wrote:
> In the existing implementation, when executing interleaved write and read
> operations in the ISR for a transfer length greater than the FIFO size,
> the TXFIFO write precedes the RXFIFO read. Consequently, the initially
> received data in the RXFIFO is pushed out and lost, leading to a failure
> in data integrity. To address this issue, reverse the order of interleaved
> operations and conduct the RXFIFO read followed by the TXFIFO write.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-cadence: Reverse the order of interleaved write and read operations
      commit: 8715c23b6540d142b955efe64f91b8bc2d3cf623

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


