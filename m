Return-Path: <linux-kernel+bounces-64534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2246854001
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E41228EE82
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D559663103;
	Tue, 13 Feb 2024 23:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqh09BEg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245A263100;
	Tue, 13 Feb 2024 23:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866625; cv=none; b=N7rb301o1BFYRAmI3kumz9RxudLQcdBJMWY3omgg8a0JzLfjl6NuLkbEphKlJ/Xq5jTUhQqLEL3L2rn8MEKKBguym8EMI8NH8pJ9dLDklbrJrUpaHpJtb7n9GfKYQVK9/PPq/9Vd3VLG0nWwL1KOJxwWAQJTJalsA3fyu7gmGL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866625; c=relaxed/simple;
	bh=cVB0ouQDPy5ygm5QzJjPDylrMnOO/mLpWOWbxzBzNww=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Kuivu9zuEbd5E1RW2vGEOvmynk2jLhX9OnWgY1dhseQ1pWU2UOUJWTN1mcNyillM2h8YQZfcnnJz07sf01tIByERpcr5bsdRQcv0dtvxdUo5eYP3YSZFR0Qt7eNOWAz2tHy6wF52WHiHbFPQpgJR98RN15KQZ1S0IEPeEaZI7FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqh09BEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9501CC433C7;
	Tue, 13 Feb 2024 23:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707866624;
	bh=cVB0ouQDPy5ygm5QzJjPDylrMnOO/mLpWOWbxzBzNww=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aqh09BEgg0yQXxTYlV2WyI6pjKy7CkoypAwcJyEvfQLdWiASXnK6+Snq6zfzrvoJL
	 0q8KSjT5rULNQJn+Sx9NHcBKb6ERq9ihrX6A9lr7ALCvImXcEXRyemEXrNvXnnsJcv
	 mjC2e7AntJkusUy5EI/UVbJvi5l2lzhkSBwsoYLkXL+iogi6Llgn9TgcDYqWRAPyZS
	 cmNis6tjfNbR0ysXSBBkf977KYLJthJodqyK+tBT3a12oiUBnXEcZM5tR09wh0Kqwm
	 HMAl9XIhSTOynMK5t3BEsSZms1FIkuB0GBGY354uOdvgUWl8EC7dbFNdOBhlNsOuNQ
	 effzgn9xXB7dg==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240209111840.1543630-1-rf@opensource.cirrus.com>
References: <20240209111840.1543630-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l56: Workaround for ACPI with broken
 spk-id-gpios property
Message-Id: <170786662332.1076782.7482522938030150798.b4-ty@kernel.org>
Date: Tue, 13 Feb 2024 23:23:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Fri, 09 Feb 2024 11:18:40 +0000, Richard Fitzgerald wrote:
> The ACPI in some SoundWire laptops has a spk-id-gpios property but
> it points to the wrong Device node. This patch adds a workaround to
> try to get the GPIO directly from the correct Device node.
> 
> If the attempt to get the GPIOs from the property fails, the workaround
> looks for the SDCA node "AF01", which is where the GpioIo resource is
> defined. If this exists, a spk-id-gpios mapping is added to that node
> and then the GPIO is got from that node using the property.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Workaround for ACPI with broken spk-id-gpios property
      commit: 0db0c1770834f39e11a2902e20e1f11a482f4465

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


