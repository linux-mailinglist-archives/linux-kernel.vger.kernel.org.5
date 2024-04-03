Return-Path: <linux-kernel+bounces-129847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B66897131
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831C21C22C0B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61491482F2;
	Wed,  3 Apr 2024 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgd0zo/M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FD4148827;
	Wed,  3 Apr 2024 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151167; cv=none; b=oTkdz9DA/5TgMABMqfTc/FbyimevTs1VwErtjc1ay6VopEVyY6Jb12sCTXD85Ig4Sq3tgAx++UQLkLSGnSRrLpB35of4+z5CSiIE7nUC5qBXSXhdc/70CCsDUhZJtyvmEZtB/nZUWhqQA2ZkQMPud2cvSkTukeBXL4ZNmeJCJ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151167; c=relaxed/simple;
	bh=ccyW+m/awCz99YrFeZTPcM+kp2UTwWHzYX81pUpJB/8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MZN51TuZx1fFtDnMR/VHPetmeq5mM3P2/zA35vJeiO2Ikz6ksfFBdn+Tb/B1gJVsU8CuZDt7eyZaBKtuWTejufMi4Obk8+PLrHT5zgjIPuMCPwnwJMsTvkoUHiNjbEu8sXsBbNIw56wbth9zlzvI3i2bxUh2jNtfLtR6xYAcb28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgd0zo/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3844C433C7;
	Wed,  3 Apr 2024 13:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712151166;
	bh=ccyW+m/awCz99YrFeZTPcM+kp2UTwWHzYX81pUpJB/8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dgd0zo/M24Prp8NtKnQVOt6UOClD0L152vlfD//z2uJTJUqQz9ur9Nuh+vYVPBXUE
	 zsaHOGGCsHtD9hc7OA1ll/JwZv00VTP8skJ4HWoZJwA6zp/hE6SD1Am6hIOCq1Ei9f
	 Pw2zgYqXjuQZX6nvrJiUeQzd+ZFdlQS5eELwvVnIWpI+V+Vu3aZZhQUTeZBXCa94QR
	 GBCJcXqqVmPfM0s1R2nNU8Tl1lsZ3AWWF9doHxRSEybq2v4t8eFgq0mkKh5IDa8/Sq
	 aWp/SlRIomA2ZHEN8yzXHzY7P/Ru/90PIjub0fEODxxzCbnkzMFdxUffO3CnlldvvS
	 fPYD7HXBno5Kg==
From: Mark Brown <broonie@kernel.org>
To: Huai-Yuan Liu <qq810974084@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 baijiaju1990@outlook.com
In-Reply-To: <20240403014221.969801-1-qq810974084@gmail.com>
References: <20240403014221.969801-1-qq810974084@gmail.com>
Subject: Re: [PATCH] spi: mchp-pci1xxx: Fix a possible null pointer
 dereference in pci1xxx_spi_probe
Message-Id: <171215116560.907765.18020830177963962652.b4-ty@kernel.org>
Date: Wed, 03 Apr 2024 14:32:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 03 Apr 2024 09:42:21 +0800, Huai-Yuan Liu wrote:
> In function pci1xxxx_spi_probe, there is a potential null pointer that
> may be caused by a failed memory allocation by the function devm_kzalloc.
> Hence, a null pointer check needs to be added to prevent null pointer
> dereferencing later in the code.
> 
> To fix this issue, spi_bus->spi_int[iter] should be checked. The memory
> allocated by devm_kzalloc will be automatically released, so just directly
> return -ENOMEM without worrying about memory leaks.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mchp-pci1xxx: Fix a possible null pointer dereference in pci1xxx_spi_probe
      commit: 1f886a7bfb3faf4c1021e73f045538008ce7634e

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


