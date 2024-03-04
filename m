Return-Path: <linux-kernel+bounces-91228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F21C870B7E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2BA5281A1F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDD37AE56;
	Mon,  4 Mar 2024 20:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urV1QK1b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F7B7A711
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583896; cv=none; b=NPVfjSgsBxFw7wd0R6zTDSx4Sa147F3c9AAkIRm32fRfJSJvyAWvl5ElaabUlSZPWdJPVmbwwu3O2u0s1bntWa8OvFEQJaC3XWOL2OVNOY7EFquuKBYkxqoYwhxWThVCUdMUiKzYXvAP8Tp3n0edhTPhvnPbCLoEGKcvNxhdAb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583896; c=relaxed/simple;
	bh=xMXokZllKK+ml5HlNA/6WSs1zG9HzzZQ9XGcCwTTw8s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O4cnE96G77Krsz1OtEotjNGnZ00VaHKiaJJ9SBzVWyyXTU1MBHVBHKiAqgmYV4G2oAL6BRvDsgUYjrZM33KPJZ6moKdAp2VqIG3i2s8OFn6pU3GEKBfYgrXmLyfXvJkFuEKn3apNmghGrEb+StvvCsWhdFd8ViAAaSApIbZztkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urV1QK1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5087C433F1;
	Mon,  4 Mar 2024 20:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709583896;
	bh=xMXokZllKK+ml5HlNA/6WSs1zG9HzzZQ9XGcCwTTw8s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=urV1QK1b0xMfOJ1RhOHniLxGkKVM6kEy/w4/ZR9LwX50Z/woMuQbcYMjsAlrey4Dl
	 Fpc4tQLCLP92rLvmEFFotnduj5R25rKi4eq8TYzVJSrwhJAYQUjmOmyoz2SGhM8EZK
	 78mlKpN4xzhKh6bWLd6AZdLYzlOY8OT3PLDJYoRodvyTg6lF+IXiVbBqEoSy23r3ln
	 /6BjEEJun7SFMgSPYsCqX5XeEQ4EOFkQ+ZTLS9mvtGdTfPNtwqGxddEpxuUp/sj6zW
	 2K8zIIVQKdQypMm6yIcdz0HG8ZCMCFXk+Bsma8u/fhtAnncwpC1gMFJaoFR6srJlN2
	 OZ20EgLCPSFFA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 shengfei Xu <xsf@rock-chips.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Quentin Schulz <foss+kernel@0leil.net>
Cc: linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240223-rk806-regulator-ranges-v1-0-3904ab70d250@theobroma-systems.com>
References: <20240223-rk806-regulator-ranges-v1-0-3904ab70d250@theobroma-systems.com>
Subject: Re: [PATCH 0/2] regulator: rk808: fix regulator ranges on RK806
Message-Id: <170958389453.755725.8219793459949047424.b4-ty@kernel.org>
Date: Mon, 04 Mar 2024 20:24:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Fri, 23 Feb 2024 14:11:21 +0100, Quentin Schulz wrote:
> The regulator ranges aren't really matching what they should be for the
> buck and ldo regulators on RK806. They are not wrong per-se but they are
> a bit misleading.
> 
> The only change in behavior expected is that the buck regulators
> shouldn't be able to say that 3.65V is possible.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: rk808: fix buck range on RK806
      commit: 5803b54068435be3a3254f9ecdc1ebd5c18718a8
[2/2] regulator: rk808: fix LDO range on RK806
      commit: 6717ff5533f332ef7294655629b8fa5fb8b132de

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


