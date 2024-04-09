Return-Path: <linux-kernel+bounces-137616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C309089E4A0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 517F7B230B3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFF2158A06;
	Tue,  9 Apr 2024 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Duc5iDp5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0CA13E3E8;
	Tue,  9 Apr 2024 20:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695422; cv=none; b=fCGY9ioiK7aF1WyUEiT3Dhk1HeTWvhBHbm0aprE4YF+e2jX+T2NU+E4vriR2HVucF1vhYcN5qPj3YN1AouoORNlWYWbq85lc/l4jvXc4YKLbkQkvJ0GA5c3+hcPq0TDzMufRdj4UfnqkFFV8XJy3EkYicTsmbgLo0PoLO56lja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695422; c=relaxed/simple;
	bh=zgb9xqkfmIfMBSO3HULJQLwocp3IQYBjZjtX9h+GnmE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j4qZu5a28W1u3RNMgQ5uJCAAXRdPAOmLtnl2PsXMSeU7GOR1WUOCOAp6q7W7aRQZ3kmIz+MbIKTyI9/Q2FWH4OddJGEfvvTXr/eXsQMFx0vMk4OB5FqHzTyjDKt/9HlK1sylIgwFoYVNzwqigVeCCeZF/iiE+R8sX7yvjUK1EJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Duc5iDp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CC6C433C7;
	Tue,  9 Apr 2024 20:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712695422;
	bh=zgb9xqkfmIfMBSO3HULJQLwocp3IQYBjZjtX9h+GnmE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Duc5iDp5S24/UJmZaJ8NTV5ssdUeldIB19Ifprzm/YDaoWmqKcXGSQpcwG0KYYGmh
	 E7/TAwXBNivt16SX8Rqc4Y9gMSy1rt/Egmvsxy3GjiMOSVQkaOp9BZMMxDnngVV/Cj
	 GJqQH1/BZ5Krpqeg88yAZr2+X8XVJ5kL1gq3r145C6JYu50gtM8DTX5LTBQpH5tNUx
	 ZxT8r9PgNC7XSB0B8Y9xJBYeClh/X0hqtzUD0N4Es8KYOdefqdQSWCPnyKWJGq/HYV
	 sYT9n5Uu5s06mfXALoDYdj9bV8mTpKlNSiUeqW/eF/Qu9D3EILIdeWL0gL9AXN0xEw
	 QkMs2+XhU248w==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, Dragan Simic <dsimic@manjaro.org>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <90ae761a5b99640ece48363a7099ac2cf402bd37.1712684592.git.dsimic@manjaro.org>
References: <90ae761a5b99640ece48363a7099ac2cf402bd37.1712684592.git.dsimic@manjaro.org>
Subject: Re: [PATCH] ASoC: pcm: perform power-down delay checks a bit
 faster
Message-Id: <171269542042.178415.9248384379060261944.b4-ty@kernel.org>
Date: Tue, 09 Apr 2024 21:43:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 09 Apr 2024 19:56:36 +0200, Dragan Simic wrote:
> When checking whether the power-down delay should be ignored for a specific
> PCM runtime, there's no need to keep going through all DAI link components
> after any of them is found to be configured to use the power-down delay.
> 
> While there, fix a small typo in one of the comment blocks.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: pcm: perform power-down delay checks a bit faster
      commit: f78bf2c933c9cb3b61215378664f83c5abd25374

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


