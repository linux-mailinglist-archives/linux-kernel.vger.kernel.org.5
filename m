Return-Path: <linux-kernel+bounces-128571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6408D895C92
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0211F26DCD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B230F15B987;
	Tue,  2 Apr 2024 19:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3CfxOp4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03EA15CD44;
	Tue,  2 Apr 2024 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086216; cv=none; b=P0+7OqjhjMW3tYiolvOH8pi/TXP7VsJJKBjDlJYXNsSb5GRlf6vRfNChQtCLWRbb3eAY//gnUDmHkBtVIf6yhSwURW6XBFx0KgdufHN/tjiAvytPI3pGPOhQHcEqury7EAhhwovS5h9crRF9zacZfaQGorHkJiZd+dN+mvF5Mq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086216; c=relaxed/simple;
	bh=/B1xTgXdNdWckdghCJTi+LlW5CmPlZvKjbqBArDILnU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=octW9+hdJb9a02A4wjzepZ7s2gtfaoXtbvVrDN7a9QZf+YS8BSqgAy+45ozeIf35xpQtShvIgsYSN85QYj0fvANLf4ji90iMN8CLmDfgwQ2XMWkCeieBMdrnSISxoBdxfPkky8ccs3l8/kBbJ6/iqGIbNn8StmM3mweD/4qGbOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3CfxOp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E74DC433C7;
	Tue,  2 Apr 2024 19:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086215;
	bh=/B1xTgXdNdWckdghCJTi+LlW5CmPlZvKjbqBArDILnU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=m3CfxOp4vJ/A67vy/XnhphWIcPLjw5EXgEQDKBiVXPVbqAgDLqJjxNvYk/GgpZLCl
	 PbbAY6NPE/jSGfkvJuGduSAC7/rXQ+wzomOL5gq5eG6NFfrga1b6UDu/IW8AR9PLys
	 ftfi2ZDw8M6HCMJFxsBQJ6OcqCZgshaMSsw5ZYgnW4s3yomIYks7umfDn5Eyw1G8kY
	 xwLLfmtU1q00g89V41JbwKchl2XVULoHWvsv62qJARHxWQwWsbDI1uYZlrAECeruwy
	 aGsAKG4k/giI/HUAVOlTjsJ6x6a6Y9gWA+UZUx4qydZZXMfucVFTdY7bqX2wIhHRCM
	 zhF6dA3ntnNaQ==
From: Mark Brown <broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>
In-Reply-To: <20240402144523.3402063-1-andriy.shevchenko@linux.intel.com>
References: <20240402144523.3402063-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: pxa2xx: Call pxa_ssp_free() after getting
 the SSP type
Message-Id: <171208621323.89757.5152971486910904877.b4-ty@kernel.org>
Date: Tue, 02 Apr 2024 20:30:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 02 Apr 2024 17:45:23 +0300, Andy Shevchenko wrote:
> pxa_ssp_request() implies a reference counting, hence the pxa_ssp_free()
> must be called when we are done. Add missed call.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pxa2xx: Call pxa_ssp_free() after getting the SSP type
      commit: 33aa27a09e9df5860fe495032a067504d025db77

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


