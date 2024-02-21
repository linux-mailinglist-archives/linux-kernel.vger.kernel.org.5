Return-Path: <linux-kernel+bounces-73883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBF285CD19
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30DCE28699E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE214432;
	Wed, 21 Feb 2024 00:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzIIh7bf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAA8882D;
	Wed, 21 Feb 2024 00:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476701; cv=none; b=qgTDQ5fv7zKOicVaf2PjYhXyY3XGuOoUAUyG6x97VR+bNUxSNMpoVdbPhqQ/prZdbL4FWcqTjrlzDQKHqwzMQ2xz7aN8mRc4EdBhOjXRPW5rt6nKQfhCrg9yncQCDixkboNJv1TAlJaaSwHqdgZdCvjzWxQ2h9LgWQeoNjrsGGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476701; c=relaxed/simple;
	bh=cus2iwaXW84ognaMM49j+z1rlDGkGcW+6/WiXWamahE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TX/xwu5EJKC8hjXGngEMdPRQxHX6EZ6eEXKC3DzDRN78Zh8acdKHBHm3931YqwauOPldNLV4st8ubylyPGOuXyAZf+KKdpLN0ewq8PbnyewQqpyePnI8Xnx3DnqeASCggpVGJGfhOw7NLYzCxJluHbBF3zOXZ9wVOJ8a2Em7PGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzIIh7bf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782D1C433C7;
	Wed, 21 Feb 2024 00:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708476700;
	bh=cus2iwaXW84ognaMM49j+z1rlDGkGcW+6/WiXWamahE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dzIIh7bfuiptnNznsNXeH5o9LEzfqNAuZ1GtMgqCzwm+qCK0ujePcwDTcEPseDAzc
	 hRFu8ZfTOIi3gMWB+RBMLu4b/c/TQOT16GUBjE3N7FyqypPQD7xvubFsfji6fbAy73
	 sR6OgHJriElGDgOsW6akpmfO34tSdgLQnK9A8Dy4u0EPtjJyj94ruKsLq3JQx3nXIG
	 m1vI8DvDr7wIc4c/F+POFL4cv4t/xM2pVh3k1OWhpKMi3y6YUfCmMoJbGJ+srpmwaF
	 bUT/q9rwF7kVyNM6Du2wxAqzrEky/8W4LvteznpAeTEYHbB2mgRSxtYys8eI4VYTWk
	 FXPN6ekcM3xKg==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240216140535.1434933-1-rf@opensource.cirrus.com>
References: <20240216140535.1434933-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l56: Must clear HALO_STATE before issuing
 SYSTEM_RESET
Message-Id: <170847669920.72316.9216524053259588241.b4-ty@kernel.org>
Date: Wed, 21 Feb 2024 00:51:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Fri, 16 Feb 2024 14:05:35 +0000, Richard Fitzgerald wrote:
> The driver must write 0 to HALO_STATE before sending the SYSTEM_RESET
> command to the firmware.
> 
> HALO_STATE is in DSP memory, which is preserved across a soft reset.
> The SYSTEM_RESET command does not change the value of HALO_STATE.
> There is period of time while the CS35L56 is resetting, before the
> firmware has started to boot, where a read of HALO_STATE will return
> the value it had before the SYSTEM_RESET. If the driver does not
> clear HALO_STATE, this would return BOOT_DONE status even though the
> firmware has not booted.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Must clear HALO_STATE before issuing SYSTEM_RESET
      commit: e33625c84b75e4f078d7f9bf58f01fe71ab99642

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


