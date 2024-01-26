Return-Path: <linux-kernel+bounces-40191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E6A83DC07
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3BF01F28630
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCFE1B81B;
	Fri, 26 Jan 2024 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkWuuKvO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9025F134A6;
	Fri, 26 Jan 2024 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279735; cv=none; b=BgnaYTcEw3fBRWZElhdjeTUoO94op191u8mDj6HBkWMnEc83n47je1M8Y4IPti+MULxL8IZuwZ3IW2iIH18NJobCMqjGkTo8sPiiX5zg/GPxU7M8W2Aa7QkMd8KXnTuXAa69kcnmK0AgAIkkcshuah65KqvDGUXMrvZ6JRy76O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279735; c=relaxed/simple;
	bh=wLiIzYIhleVyS3ZVSkO9myhj/MpErH5be7lV5PedklI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fNw6NONS0sBrBLgWpPGXZR8vz5tQ3GAwhtoypJQV/wGLmqIgoEp224PlsAXlXSowwxD8KrxkjnGFdc6KMh/fwrU3dnfFlIc7F7j6CcwX9jgi1dhSfMA0Suj2WnioH/N0dO42diGP2ke2wqFaR05yYCfpE4gc7F4qvlnn8hsIIGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkWuuKvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095CAC43390;
	Fri, 26 Jan 2024 14:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706279735;
	bh=wLiIzYIhleVyS3ZVSkO9myhj/MpErH5be7lV5PedklI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WkWuuKvO0EVVyqdOkVXXtJbEQzRvi29m7dTop9sXA165hVao6tAfDW4XPsKnwVY0b
	 xtysDIuvSscM6jC8QMlxENeep34q8vdt73xL53ONoCnaVNmb6rcJ2vjGbMdNpFfAjX
	 WsdvuHWB0PFV4dzfLDE2JHBMhG0uJtpTGKf64gVm61eHcqkK7F2JHycn+bTZxi6ux2
	 V9AlELRqaZVyiDR73Nat3CfjxWWJVfqKaUbZAhefCBoEWJ/xnuAvqs/rvsEe4KkyIU
	 XFljPZs7CTd3RAMWCl+0SVMRVqZ5eNHkRgjUIY4s1EtSfw4sqI6GZF6pxytuhwKUmg
	 tLwPeVyv9Lz3w==
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: David Jander <david@protonic.nl>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240125205312.3458541-2-dlechner@baylibre.com>
References: <20240125205312.3458541-2-dlechner@baylibre.com>
Subject: Re: [PATCH] spi: fix finalize message on error return
Message-Id: <170627973371.36139.11882822858180324422.b4-ty@kernel.org>
Date: Fri, 26 Jan 2024 14:35:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Thu, 25 Jan 2024 14:53:09 -0600, David Lechner wrote:
> In __spi_pump_transfer_message(), the message was not finalized in the
> first error return as it is in the other error return paths. Not
> finalizing the message could cause anything waiting on the message to
> complete to hang forever.
> 
> This adds the missing call to spi_finalize_current_message().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fix finalize message on error return
      commit: 8c2ae772fe08e33f3d7a83849e85539320701abd

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


