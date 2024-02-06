Return-Path: <linux-kernel+bounces-54874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BE884B4A7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DAF286052
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A98134CF3;
	Tue,  6 Feb 2024 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fu/Luobd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93863134CE1;
	Tue,  6 Feb 2024 12:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221357; cv=none; b=lxAb1rDD8GfN8MxA1QthOoss7PdmrGiym5gO+P+0CW1+MaoEaW6TovCxwovc/4NScDoFvNHEcVDqMeXaJ13hXJxxaGEko8tCnYqtSHp3QUN6afVmily2IhMZZoTFBkYK5MqO2ewWIZhrqrvKe/CNxAQ9VqfzZLLnnrkOTgY1F5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221357; c=relaxed/simple;
	bh=lgnDT6IX8ujr8/X8b2kq1ukegHZdLHErPgmImXn6Cog=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iIXb8YS5wKtgq5yhsgFyywvfA3Gzfj78R1QBQNhYOWov7Zfo3+mXFfeb+nDYFFqfUwutW/Xnb6eDtu/dKYKQkQyUobsx1Ow77xn8xYLIDTGGUS8IClNQfKFxh8LWI7Omewl5wtesKMoLRsx4RzekcLK5IG7FzkXcP5P2BWp+meo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fu/Luobd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5A6C433C7;
	Tue,  6 Feb 2024 12:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707221357;
	bh=lgnDT6IX8ujr8/X8b2kq1ukegHZdLHErPgmImXn6Cog=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Fu/Luobdvz2M8E+75ha/tnKhqTJwCAX+GGDs8FB5MyuX7Tys3j5jIz8mHgfUwAYZJ
	 Ze48vql7vnc6nQbkeigXafDQpy5wjPnlzD0d9o+pnu3YrJUwtYX3FcaT+IFt/LkZTn
	 KNJn2PCw6BlgXHwMK6arMqo9njZSR4wQ/FR75LmyBBCQELbQRxEQxsz3v8yQdQloeW
	 u9ETCHBithWqBxLxILvjvUZG6Jev9+Zf1u3bKtuLYHcJbcGI9fAf7mjTuTVaDBltoG
	 +ZNGeqKPTrklaZS5tlq2GnJ86oZncbqtMr+X0sXKn/YCWU7vRX6SfGYf/jmmcDTdMK
	 leLl2NrvGqegg==
From: Mark Brown <broonie@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126220024.3926403-2-dlechner@baylibre.com>
References: <20240126220024.3926403-2-dlechner@baylibre.com>
Subject: Re: [PATCH] spi: bcm2835: implement ctlr->max_transfer_size
Message-Id: <170722135486.992289.5399586153021617257.b4-ty@kernel.org>
Date: Tue, 06 Feb 2024 12:09:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 26 Jan 2024 16:00:23 -0600, David Lechner wrote:
> The core SPI code will handle splitting transfers if needed as long
> as ctlr->max_transfer_size is implemented. It does this in
> __spi_pump_transfer_message() immediately before calling
> ctlr->prepare_message. So effectively, this change does not
> alter the behavior of the driver.
> 
> Also, several peripheral drivers make use of spi_max_transfer_size(),
> so this should improve compatibility with those drivers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm2835: implement ctlr->max_transfer_size
      commit: 2733092baa3e8a1f05fd16088808be17c98990b4

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


