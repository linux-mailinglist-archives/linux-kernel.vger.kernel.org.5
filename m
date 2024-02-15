Return-Path: <linux-kernel+bounces-67185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDF58567B1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F050E1F29ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3CD1350D0;
	Thu, 15 Feb 2024 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaXK9VJD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EDF134CFC
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011038; cv=none; b=bzS7mdHHufibRlavLs60bzAsUbghs3WSxp8Uc9wYmEgsGevwT9FjKOuPulnXL1KHoocvfe2qdsDF3VXOlc6mgx1ab+AHTV9NOoaGeIh6fM/652qSRkZ3AwuBF8ftA75X36esxvm1CgJDRCMq6ww+BTOlUuZPI/3jRpz+kvhuiC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011038; c=relaxed/simple;
	bh=DbE0ieED+HtfD8QG3lqb3hQnxTvX/FWkbK6tlbU4Buc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZLvZT5LdSwlJBwtQwO5XFluWuo1s7JR5CITLA7Lko69Qp1gZzCUIFciwVOwIUjmx83feT3OReKWl5g4+YR+IYuhXv1fkqrAUOyoso7RkmBJpO2o+iiUZzAcFhi/GGZQ1GhlZqvXC8GJBtfKU/XbZy8uLFM0XAE4SNtwv+me0eIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaXK9VJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6088FC43399;
	Thu, 15 Feb 2024 15:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708011038;
	bh=DbE0ieED+HtfD8QG3lqb3hQnxTvX/FWkbK6tlbU4Buc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XaXK9VJDPssYLaTCCqex2Bm6lc8B0zXIRpnh+Xtl3AjJOtK/HRTSiswDcy4v6REiI
	 cDIzDRg1ZGumA5yXad94yDVJAywjBZp96KBNAV536cTvbLGTxmCdSJu1Jvx6DSeM6d
	 U97E/f+2GTWF6C0que44obmKt/Q6qJBRDstBS2faKzhBviV90PasMzMa1WCdb3x5e0
	 ahgnJqha53UfuIt3CB6JqZ307QMaMA/xDBcgQkbAzIjQI8KdxTWnDP7PxxmnqlMIc0
	 gP7wsUq58qLxEt/8AO9cIlFIdlGG7XaiU6KKiiqkgzhnS/Ii9vOOFcMhn3muPHy4go
	 liXZEvJioj2Vg==
From: Mark Brown <broonie@kernel.org>
To: J Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5e8781d31c983caf6bdabe36c5552077422cb8da.1708002575.git.geert+renesas@glider.be>
References: <5e8781d31c983caf6bdabe36c5552077422cb8da.1708002575.git.geert+renesas@glider.be>
Subject: Re: [PATCH v2] regulator: lp87565: Use bitfield helpers
Message-Id: <170801103713.74704.11455835771424834467.b4-ty@kernel.org>
Date: Thu, 15 Feb 2024 15:30:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Thu, 15 Feb 2024 14:10:50 +0100, Geert Uytterhoeven wrote:
> Use the FIELD_PREP() helper, instead open-coding the same operation.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: lp87565: Use bitfield helpers
      commit: 5319aaa9bb121b4a4fddabf207eae9c57dc62e19

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


