Return-Path: <linux-kernel+bounces-45211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CA7842D10
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7AD31C24F65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABBC71B20;
	Tue, 30 Jan 2024 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKBCFOwA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7744D64CE9;
	Tue, 30 Jan 2024 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643540; cv=none; b=Om2Z+8+S0t2rSlOpNhfj3rXwA9FLwx8fZFhXqUxAxeNDZ7UlNRhlo4aC6nigm/exh426yxg7T8gocrCycf8ip/rKDuqRxXYgjJc21x+kkcG0Niz3HFIS3T7dyZxvMZuvFCL7brFw9C88lKzkanMi1DeixWJa1lKDR2ixM5An7Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643540; c=relaxed/simple;
	bh=eNOi/RYquLuTBNkdWDnsEHK6yj1AwsBSWULSmaTaQfM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oCvNPIg8GJz4qMvL8upa/gCAuJ8hkRdxo1JnsEfg3ao911TnrpuS+KpAv9cnd8Fgzwo3iVkjpRzb/nFMvSVoi1uhIjAa2c3qAlQevPG+xkITnlJYaPGXxilwzO+5zQaSet4Kl386fXiVEBXqobcKtP8YGZm+DqAgDUfDClHjesc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKBCFOwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E8BC433C7;
	Tue, 30 Jan 2024 19:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706643539;
	bh=eNOi/RYquLuTBNkdWDnsEHK6yj1AwsBSWULSmaTaQfM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eKBCFOwAX3y+OFAJBgd3vkHmTnvVujB8N8RFdLLPBGaOu1NB7EhiTFyqzgk3gG03Z
	 KO3USKZ6h7dRBUSpQOgkHFk2l4ctmSN+4xSoh93L8Hb8jGMj5FTYuFntTaPZCPR/+t
	 2JiMPfw8GE+Jo+wrkjLz2Jw17ZzQqXP8NMHhbbY9HarDHKsjVXmXMv1N3Z63BQyCLx
	 uUUjWVjeOvWeKCPM8SdPeIgSH9U6RRqnbt//biofK4usb/JwTXfFijHIcbH5eQCPXj
	 5m35k6vyqhAlo+tqpM93d1JIZmBDxRoncJ8Uv6ubnxQNrrYZ7+dE6CehoUSPsHjQGT
	 rt1AGA6BcMPwA==
From: Mark Brown <broonie@kernel.org>
To: linux-renesas-soc@vger.kernel.org, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240130094053.10672-1-wsa+renesas@sang-engineering.com>
References: <20240130094053.10672-1-wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH] spi: sh-msiof: avoid integer overflow in constants
Message-Id: <170664353878.52280.1228459435232323428.b4-ty@kernel.org>
Date: Tue, 30 Jan 2024 19:38:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 30 Jan 2024 10:40:53 +0100, Wolfram Sang wrote:
> cppcheck rightfully warned:
> 
>  drivers/spi/spi-sh-msiof.c:792:28: warning: Signed integer overflow for expression '7<<29'. [integerOverflow]
>  sh_msiof_write(p, SIFCTR, SIFCTR_TFWM_1 | SIFCTR_RFWM_1);
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: sh-msiof: avoid integer overflow in constants
      commit: 6500ad28fd5d67d5ca0fee9da73c463090842440

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


