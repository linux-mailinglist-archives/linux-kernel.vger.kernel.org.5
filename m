Return-Path: <linux-kernel+bounces-34147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40687837463
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681291C26708
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1535C4B5B3;
	Mon, 22 Jan 2024 20:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeH383TZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5973A4A9BC;
	Mon, 22 Jan 2024 20:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956283; cv=none; b=S59h/aecpv4FnFGe9Tc57h4XTygJ86Mi6Kv6Z5NBb47fPACSanPvk7kOAnRLM2zA2cBinm7njt09YITeSCcIBi0Pnmb033Detjm0u7gOusNmTSfgk64beIPY1IgmjehbVrszFB4mlcJAdUjKL0r+P6+u1kWE/cRoeS0avbtKHxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956283; c=relaxed/simple;
	bh=+SdJMHOe0PeCELiFYXNyu7qz9O7e0yR2He2ajEYYGZc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YYixHvAMijqu3BEml99O22RhrmbY8zwI7ldhsstRFwQLSL9N5F6bDJ/KUeRjNjbENuFfQjdhjjY4zoDJ8B8rfXqsuZ1oH1SPajF8SDTzvb2nxTuIlPTBcbdYRp+2PygZ7RmrUHGCQtP2cWjV7HpENpiwklLbhXv8noYqUnc3Hx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeH383TZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51ADBC433C7;
	Mon, 22 Jan 2024 20:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705956283;
	bh=+SdJMHOe0PeCELiFYXNyu7qz9O7e0yR2He2ajEYYGZc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jeH383TZijRjDC5SHd+O41N/5Frb9YgGomNcBFoE/ZugU1vXS9omdla5N2gXWQR+m
	 PdAfqm2z0ZxFYWyxTcE+m6whiq6hzPveySg64xU9ZB9bmRPaXrwKE3RDPxQL6bPHom
	 7UZPCnZe4G97q4ID1UhRF7v5g9i6q6boh79fi12rptSsftNOAvdc4K7R18a+JOtnrI
	 PuPXiNe2anya0yKogB77x6OXeaU4OtBl3eL9sJe84542aXfuboaTLbpmAvHI1yGj4S
	 /+NtPgda1ZWRZOd7CW5xUP/5fL7YqQxokQvLep3S33ZB1iJKM0i75VoIh7z1nD+fEo
	 1C+Yhd3Daw1sw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <3f990a7b80d72c31371735b24ed08acbb8392c80.1705748586.git.christophe.jaillet@wanadoo.fr>
References: <3f990a7b80d72c31371735b24ed08acbb8392c80.1705748586.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] regulator: fixed-helper: Save a few bytes of memory
 when registering a 'nfc_llc' engine
Message-Id: <170595628204.145638.3810647512019655166.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 20:44:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Sat, 20 Jan 2024 12:03:26 +0100, Christophe JAILLET wrote:
> regulator_register_always_on() calls pass a string literal as the 'name'
> parameter.
> 
> So kstrdup_const() can be used instead of kfree() to avoid a memory
> allocation in such cases.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: fixed-helper: Save a few bytes of memory when registering a 'nfc_llc' engine
      commit: 4c716711a5c5e89202facc9ca816bc89d4b8c745

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


