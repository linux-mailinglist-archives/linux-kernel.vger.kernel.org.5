Return-Path: <linux-kernel+bounces-94199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8F0873B3F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9018B1F24119
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46567135A4E;
	Wed,  6 Mar 2024 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nnn+lCzg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9271350EF;
	Wed,  6 Mar 2024 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740462; cv=none; b=baHCQ/0wq0iD1DuVCjVEmKI/EbGlrDIf4brPCIq1gYjSJj1SM52xQTDVBRipzhfETA9VvKg6d03hddrARJW3tMD1JX3h9xbb1CiJtyGPZdxAayC6GYuH7BURWwQ/TjObfG8PUuTma4AJrQNDVx//diCd168s6wspg3QiU00PE7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740462; c=relaxed/simple;
	bh=QA/aKryvrm59TLPorBsymx+woVTJLVgY9zv5V0F3bU0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=avXYo5MYuGW1e4gDERMdexuzIZ4X3ccbjZdQCk3koflBCi9EndwvKI5jJlXkPmVoyqP07YKpnqZZvjg4FRrHovGJjqVbQjsCvMbwmCFKvxspgUjZw68wWXWyLla4Qpfp2lT21GdbRGQcOLneo7EhOdHAHkFFhpxVH4cWxjObwA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nnn+lCzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9FCC433F1;
	Wed,  6 Mar 2024 15:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709740462;
	bh=QA/aKryvrm59TLPorBsymx+woVTJLVgY9zv5V0F3bU0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Nnn+lCzgK2O0834H3DjRpkECGzxGhTGpjdqCmxV8l4JW/MmZrBBD48eM3XLgMQ3mn
	 salDfOTZczGTQH/nNcVXmFOX7QEkFijfgfEuItCJaHceEGm3r71A9zVWzrGd7YmtFP
	 jZ3dDx1RRP1I0WctktE4IyyJOnhjntiny+sW/bhLM42Vl1Ln/pgbXQFG/pRkDYWjVW
	 Ny2TKAcKClFQf3s943jqGteHH2XVAaLx/BTe7NnVvBacvxE2igcL7f512vc05jsvmJ
	 BH6rm/MBFQi3drNGqxDx+sNR19xQimQUOG+PhY3uYLrB4DgxMvE8gfs0dttBY1atcn
	 9uO53qEmQx3dw==
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <19f62cc2-bdcf-46f7-a5c5-971ef05e1ea7@moroto.mountain>
References: <19f62cc2-bdcf-46f7-a5c5-971ef05e1ea7@moroto.mountain>
Subject: Re: [PATCH] regulator: lp8788-buck: fix copy and paste bug in
 lp8788_dvs_gpio_request()
Message-Id: <170974046063.173132.14907640215703299478.b4-ty@kernel.org>
Date: Wed, 06 Mar 2024 15:54:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Wed, 06 Mar 2024 16:52:29 +0300, Dan Carpenter wrote:
> "gpio2" as intended here, not "gpio1".
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: lp8788-buck: fix copy and paste bug in lp8788_dvs_gpio_request()
      commit: e6f0b08a036734552628ab788ecb528ca53814ab

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


