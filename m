Return-Path: <linux-kernel+bounces-94641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D6C87428F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F5C1C22A54
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A621BDF4;
	Wed,  6 Mar 2024 22:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXPHWPOn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A766214265;
	Wed,  6 Mar 2024 22:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709763250; cv=none; b=Y7Ezt7vUewkgZ625wMufGnz7/BnX4CVJe2+mLk9kO90q3dOpO+kVtopEafwd5tuYtqHxfOq2pqpwYUmVfP4BtPyI9YWYoU6/Eqay3pYMo1P0/IFGrXvoc4BYmVRR3qlTi1SDzoewDfeNqmyseFUQDeP/02mU4FF5msO1vviGlGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709763250; c=relaxed/simple;
	bh=y4aiI8uw01JgY58CkLCf6+9qTKtnK0PgA5SudODPqz4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m7wVIdXxGBemR8VfItQKPNmArXHlaLs1U9x6x1Se6qUO5d1xH7XFr/viF7zZhDTJ8NtOAsu1/oFQ9ip3vNWDzog7/+rz1dfuUknA/WuTwMAB1YxH+zg015c35PMT7SPJSP6FfxHu4vTwd9qFBbifisSVXlQ6SpMeUNCeO3EKmsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXPHWPOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62834C433C7;
	Wed,  6 Mar 2024 22:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709763250;
	bh=y4aiI8uw01JgY58CkLCf6+9qTKtnK0PgA5SudODPqz4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NXPHWPOnE3cm6tMAno2nWrFebVkO8KeqNB3SyOnswvoUSe3CvMqtQ21Ao7VbtGBAA
	 oET0pWg24JBQuyVOlpSHVyMQiUThpYCt2OxE/phdYBqDUWodOylWpOiLEHk3iM1/HZ
	 P/Y1Ha5FrJoxld57PNqI6g+5Xoblo/oSJla6bd2g39as/lb+esm2uCq8w2sQNwCheH
	 c+43Md+sbwp3oYYXn6Oup4qb1OvzigTPiFyYRhr+UrdQDj79EDEt6ooXR7S3sDZCn6
	 mbT+JIdyJouwOGzmO5oUU1WzFacR/FGwMr+N5bPAeIcJzVK8epTzp3RojeEZ9G9HXk
	 qzTjc0XYNVejw==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20240306161004.2205113-1-ckeepax@opensource.cirrus.com>
References: <20240306161004.2205113-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] spi: cs42l43: Don't limit native CS to the first chip
 select
Message-Id: <170976324914.264698.13380179442559514263.b4-ty@kernel.org>
Date: Wed, 06 Mar 2024 22:14:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Wed, 06 Mar 2024 16:10:04 +0000, Charles Keepax wrote:
> As the chip selects can be configured through ACPI/OF/swnode, and
> the set_cs() callback will only be called when a native chip select
> is being used, there is no reason for the driver to only support the
> native chip select as the first chip select. Remove the check that
> introduces this limitation.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cs42l43: Don't limit native CS to the first chip select
      commit: 177cddaa5bdfcbc4c3d4594bb44ed8338765fc29

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


