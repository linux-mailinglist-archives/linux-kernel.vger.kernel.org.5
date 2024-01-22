Return-Path: <linux-kernel+bounces-34146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFCE837461
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08544B25BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15504A9AC;
	Mon, 22 Jan 2024 20:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9XOiQN5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0496B4A99B;
	Mon, 22 Jan 2024 20:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956282; cv=none; b=ZP6GGp3g7kUTQspY6HR8Wy0yCK8tzmcv4XpVxOxmlF5xQmdTYjB8+NzhZKMQgqjR80XHpH5OWTte8vZufsP3syTn8NrTZHvOJAadWzD6soo1h88m8nnqsq0aBk03qxdXdD+je4ltN3oJfYlReoJece/pEEs8yrnJYtrQ8lqdfJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956282; c=relaxed/simple;
	bh=dt5C1IAu6gWee39W5ANHJTbSfbM7H6/2F0kZ9c8AxPw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dCriP83UOhu+uyIc1bang5laejpM1i0HyH4tVjpztt6uExOos2SnAAQN2iqhzJgoI+6aKZMMwICvubLWOPRo/UgTT5bsCshh7Xvt0wX125XXvsHj8QFq0LLEBk5IMNVIA7IQhNP0HQ1dZh9VrElToqPY7xRbvnYgVoTsH9wexeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9XOiQN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7B5C43394;
	Mon, 22 Jan 2024 20:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705956281;
	bh=dt5C1IAu6gWee39W5ANHJTbSfbM7H6/2F0kZ9c8AxPw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=N9XOiQN5vt0NGWHxNtRbl73Z2V5PcnE36LQA7oJz6wqXDOWsCo15Yk6o8RCaleRRa
	 dGkrQSUIaZ/po8iaAYm5AmeCqMYSIypJ3FjWbZuVGQ0A0bauE5mVdJiDe95nnFC0je
	 arepL7QdE753biMbtMpcreuEzfHseSJ3xOXAxWTaTCIhwQek8wEm+luNoH5CIsJcLJ
	 IcFrYv9Ai2o4NmlQTVeso/DsUXo8DFkLre1gBuhaw8tUpVinVHlz5sAZNl7rae/8tl
	 //EgDEN3m0871eIrkTPJS8HAD3W4f3P5xokBcEY+xIbIw8HHhEweLPtmgdhH0smgAB
	 Ty9jZdXM1KhrQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>, 
 Dmitry Rokosov <ddrokosov@sberdevices.ru>
In-Reply-To: <20240113224628.377993-1-martin.blumenstingl@googlemail.com>
References: <20240113224628.377993-1-martin.blumenstingl@googlemail.com>
Subject: Re: [RFC PATCH v2 0/3] regulator: pwm-regulator: Fixes for
 disabled PWMs at boot
Message-Id: <170595627996.145638.15681759676659435096.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 20:44:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Sat, 13 Jan 2024 23:46:25 +0100, Martin Blumenstingl wrote:
> This is the second version of an attempt to fix booting mainline Linux
> on Meson8b Odroid-C1.
> This series is an update to an RFC patch that I sent some time ago [0]
> and incorporates a lot of the feedback from that v1.
> 
> The main changes since v1 [0] are:
> - new patch checking the voltage limits in pwm_regulator_get_voltage()
> - updated calculation for disabled regulators in+
>   pwm_regulator_get_voltage() utilizing above limit checking
> - new pwm_regulator_init_boot_on() to preserve the output voltage when
>   pwm_regulator_enable() later enables the PWM output without and
>   preceding pwm_regulator_set_voltage().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: pwm-regulator: Add validity checks in continuous .get_voltage
      commit: c92688cac239794e4a1d976afa5203a4d3a2ac0e
[2/3] regulator: pwm-regulator: Calculate the output voltage for disabled PWMs
      commit: 6a7d11efd6915d80a025f2a0be4ae09d797b91ec
[3/3] regulator: pwm-regulator: Manage boot-on with disabled PWM channels
      commit: b3cbdcc191819b75c04178142e2d0d4c668f68c0

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


