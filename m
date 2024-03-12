Return-Path: <linux-kernel+bounces-100487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A23879880
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97B91C217A8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BBB7D3E9;
	Tue, 12 Mar 2024 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1T7oukG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA097D06B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259379; cv=none; b=gnVKgjB30EaTXr6/hRi/q1XAUYBfMOPEtEsBjejpndB+PoLfvSJuhbdtiP2opei5oZjSXV29hDdJcf60ZzRegC4SyccvWiEuax6p2ItsgS0iVHmHEyZYt2CByvQ8nuvZRWrgLGAYz2sxpE/Ms5Ojw1/OT5kEJlYSd7THo5+g5+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259379; c=relaxed/simple;
	bh=pwMFmbIDCPsXo4BRsEAWi66m1VWYMC9FeL3IOqfEDyk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GT+nPRT/w0lP6PwFweInQgvnEuEolwSRn7EwkB2s0RmMHWWMYHh/ORwW0rZk7OYLNbfkM9OvwlpZyKfdu2RMcOH8EicYpqkj+D6bbC//WySZVKHqt+e49yZsjqDBqfpxiRnr/blX5zAmDo4RyWeKdUcem4HAhZ3CxAQsXCNCgMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1T7oukG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDD7C433C7;
	Tue, 12 Mar 2024 16:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710259379;
	bh=pwMFmbIDCPsXo4BRsEAWi66m1VWYMC9FeL3IOqfEDyk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=m1T7oukGBK/pcIzD8xs43UY2H6/Vy8thhFPPM3GgyV350LMSQOzLXWuFm8amX5XiU
	 tHaVOvnMwdlme9rA5V1u9JzaqfI3/c+C0w733HSewADsKQ4SY+WxHuzjZgbeAsHL6E
	 CNj7hUoVd+gN8dHjLhqCxUmR3YXSOLJkQ+tYwwSbrbRRtZb1Euc8/aR6TWgSWvw27W
	 2AF2R7z4kpI7viJbf5tyOTQh+KcVQjDktJuHiO/r/REi+MaDDU+k5CRgFJm7A829KG
	 JBLQyCdggbK4yH9vZXaFEiHw6zlPksRrHfV+t4kq/HQBHO/Frdh9XMHkbdxLTurrUi
	 GzqauEYancNHA==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
Cc: thomas.petazzoni@bootlin.com, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20240312091638.1266167-1-kory.maincent@bootlin.com>
References: <20240312091638.1266167-1-kory.maincent@bootlin.com>
Subject: Re: [PATCH] regulator: core: Propagate the regulator state in case
 of exclusive get
Message-Id: <171025937812.47123.5734574115512793768.b4-ty@kernel.org>
Date: Tue, 12 Mar 2024 16:02:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 12 Mar 2024 10:16:38 +0100, Kory Maincent wrote:
> Previously, performing an exclusive get on an already-enabled regulator
> resulted in inconsistent state initialization between child and parent
> regulators. While the child's counts were updated, its parent's counters
> remained unaffected.
> 
> Consequently, attempting to disable an already-enabled exclusive regulator
> triggered unbalanced disables warnings from its parent regulator.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: Propagate the regulator state in case of exclusive get
      commit: e4ead3cdfd798092288f3a06b405cf98ded6fa10

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


