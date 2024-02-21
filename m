Return-Path: <linux-kernel+bounces-73885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0610C85CD1F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9231F235A4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176D879C6;
	Wed, 21 Feb 2024 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeyY+Xjl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F0C53AC
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476710; cv=none; b=oVlR0ZRrC16EGX98aQIL+Y8vDkR7/7Z5DCWQ2VDPwFqFKOvPATFviMUyzf7kHhtuRCbGsF9a+EmUgsYqoDRCqeJuI0EkRGN6Z1TxmhZBQL/8yRCvp9IkCVeneOzzERbkPgKADnolLwwiecCKkpq7Jz2n/x3uugUo7DM3rQLSPXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476710; c=relaxed/simple;
	bh=nlIT2t06hQVPRoTAGC9D0vfv50qdpn2mrFNlAxhx9jk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ey9q9S9z2ll1xqZ8PJwXa4Q0i6S7OttSAgVqnuIc0/Ceh87RZyzGoCp2UH1TyURQ8YA/zB0PkHBKmN+y5yhucm3a8+mkCCCZCUZgqNNbUagHX4x7VXmzVszJc92l16vgAip7CmRahmL5rA9GrpqTvkWXbd18p+542jdUBOVG9EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeyY+Xjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256D2C43394;
	Wed, 21 Feb 2024 00:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708476710;
	bh=nlIT2t06hQVPRoTAGC9D0vfv50qdpn2mrFNlAxhx9jk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VeyY+XjlgK//Rd14FLsWmw3ZhXNhQEwRpPnh6UVjqhl1v3PL5aJSf4M5kZ9R9pi5x
	 zfBBNAvb7qaaEDeptbBD8KJv2esXRMjIDY4ErkOVKUgMWecFs1JmwEU6w/quMTQxcD
	 LHOiVVyu9JxRCaWeceyQRHnP+ocPsTnYZa7SvXvyDj9kCGrprg5VrxHjq8bUpFne7Y
	 g04s4uj4XIg0ksIUStmbet8kxIiqk+J0mLX63IwvI/m+BwQisptH/FsDT5u3DqVMVB
	 cEf3FbSfRSa/B5ohCs/pe28Vqz7Fxfx0NFjuZHs7IMIQENKmdAU9LNm/2P9q3TtJel
	 tEb8wwu/BsOlA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de
In-Reply-To: <20240216071829.1513748-2-u.kleine-koenig@pengutronix.de>
References: <20240216071829.1513748-2-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] regulator: pwm-regulator: Use dev_err_probe() for
 error paths in .probe()
Message-Id: <170847670888.72396.7095798944877030601.b4-ty@kernel.org>
Date: Wed, 21 Feb 2024 00:51:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-a684c

On Fri, 16 Feb 2024 08:18:30 +0100, Uwe Kleine-König wrote:
> One error path already used the dev_err_probe() helper. Make use of it
> in the other error paths, too, for consistent output. This results in a
> more compact source code and symbolic output of the error code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: pwm-regulator: Use dev_err_probe() for error paths in .probe()
      commit: 6037733963b8d4cd9ff9c1cabd3017ac5c1af1af

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


