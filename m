Return-Path: <linux-kernel+bounces-104699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C6187D289
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD7ACB23C67
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179D745C06;
	Fri, 15 Mar 2024 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojoOWoPM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA972D7A8;
	Fri, 15 Mar 2024 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710522793; cv=none; b=i9bATmwB4/iCXhr+8m8nqkJxV+HSH+niXnAU61HiHATyN0mFjQK3FK/5TAv4z+wd/U4v+FXWEmnPevAon4tVeTh5brDoxBnQHFV0YgkYT+zZlBQ4hBAcwLUk1dCX/082ISKH48vrQLEv3Uae5h3H7B3wmt76mr3Vz4fb39mW9kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710522793; c=relaxed/simple;
	bh=bux1e6Dc/9IxUoMYOK9iP4ti4i1eDiNvOx/+YMftFOg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Bx3rmM8XpAVTWYYodIeZmifcMgjzmKS+wylZBGaL8sL1iDknwvbZOR5Q6YPVUdalgWFi+6ckpAsfSSYTNPEjYpaOMp7MBtqKAnEU5NshcZeSBwgDMJbwERWszY7ccjCOmW7CjRNugwmobSEzqcmelvRXKDPZVxKUeBWREstLuzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojoOWoPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD07C433F1;
	Fri, 15 Mar 2024 17:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710522792;
	bh=bux1e6Dc/9IxUoMYOK9iP4ti4i1eDiNvOx/+YMftFOg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ojoOWoPMuw2D8HPVkPxIsx3OJnWAERmH4qU+mxR9PkhXTBBd2Xo5fL4sO6e/SHt0S
	 RQqRwNky4zx83qNwcmT3z/TxgOl1+/WCV+iP11fPTScXJaz0tpzlVBSkM23mjYoRGa
	 C7j0uVG53TNt9/JMh0sP6QKB7zRiezdINsW2zni151CTsiJZYKHPWOLI9AZ8OgqpCu
	 QcAnAshKY7EyGZnc2rtUjObIby3JqCS/2zguuBm4+G/9JgIYwLxJa8SSpp5v+b+GFL
	 W8SvHQwndlaCDHkGIDJaAj+FeS7MpST3tEI+bGjKyDOt2AMlshMPEeJ/A87I1bm2ki
	 qphGktogSD6yA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, 
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Michael Walle <michael@walle.cc>, 
 "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240313171050.3505620-1-florian.fainelli@broadcom.com>
References: <20240313171050.3505620-1-florian.fainelli@broadcom.com>
Subject: Re: [PATCH] spi: Fix error code checking in spi_mem_exec_op()
Message-Id: <171052279110.52555.12215764049151524815.b4-ty@kernel.org>
Date: Fri, 15 Mar 2024 17:13:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Wed, 13 Mar 2024 10:10:49 -0700, Florian Fainelli wrote:
> After commit cff49d58f57e ("spi: Unify error codes by replacing -ENOTSUPP with
> -EOPNOTSUPP"), our SPI NOR flashes would stop probing with the following
> visible in the kernel log:
> 
> [    2.196300] brcmstb_qspi f0440920.qspi: using bspi-mspi mode
> [    2.210295] spi-nor: probe of spi1.0 failed with error -95
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Fix error code checking in spi_mem_exec_op()
      commit: 29895ce18311ddd702973ddb3a6c687db663e0fb

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


