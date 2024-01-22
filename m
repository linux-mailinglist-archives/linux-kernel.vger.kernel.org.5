Return-Path: <linux-kernel+bounces-34223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9510E8375D1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C809B1C23C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EED2487B7;
	Mon, 22 Jan 2024 22:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dg2QNuDH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B427E482D6;
	Mon, 22 Jan 2024 22:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961230; cv=none; b=KraznILeHe+6X4IhNfyK6EDvfBYcwwQm17IKO1M/HCWTl/ng9dJml99NHtmE9uGlOsqXEV9xZvuJUa9vHvmAtQhBvCR6OxtX5P++V1lnNS15CdP639x4IAQ54ub4jO/j97ntxMh5CvMX51i9RGhudia70ctjLBTvewrN2/TXAWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961230; c=relaxed/simple;
	bh=H5hagg5HrRD6NfB5woLTtgzbD7Eep2L5vDl5XgLIRsc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CIp59PNvToVL7jik0oF5gC7ik7ja1pjhqWx3t5f+gMTLwrfttMwYG2UTSoDZs+w5Ko0Uj6REjLAPxB4V+K6jmQhoxbmLzhIkFi/S2V9XaN6klmSimKrWcOOfhbHUsJ7qLlZLbgR3KGO0ve9X8sTEtRcn97GQMzKWT/6dB0DVZmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dg2QNuDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B59C43390;
	Mon, 22 Jan 2024 22:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705961230;
	bh=H5hagg5HrRD6NfB5woLTtgzbD7Eep2L5vDl5XgLIRsc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Dg2QNuDHzaWegSH/RXuV+sF6cYRVIH8WcW5i9MCNFGn6nv1IElGteqSvYZ6uE39LJ
	 NhmbunD5pggwDy2KvUAyNpd2EIaWFeM3PrKqK7nAvPDPnYP4egibKTWsXk5zu/07+i
	 6xx2Gq2fZc2AnnPZJpW9RBQ7/IFOoD7N2kxpSxea5CJoeJabFbm+r6iWLCGp7LyEgo
	 /vwxxXBwlIY0w7dPQ3ulmNEEDqCLNYJb/EbmXUoBv+2+WrMeq88byctuN0yyegUkY3
	 oLnq7peV830axQ8x7tFu1I1O0PMOR8tH7AefEJSkZxIz8ezVLxYCs7C780FwQ1i4se
	 owJEkkNnqUsMQ==
From: Mark Brown <broonie@kernel.org>
To: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Kamal Dasu <kdasu.kdev@gmail.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240109210033.43249-1-kamal.dasu@broadcom.com>
References: <20240109210033.43249-1-kamal.dasu@broadcom.com>
Subject: Re: [PATCH] spi: bcm-qspi: fix SFDP BFPT read by usig mspi read
Message-Id: <170596122857.165612.9945878918825356537.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 22:07:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Tue, 09 Jan 2024 16:00:32 -0500, Kamal Dasu wrote:
> SFDP read shall use the mspi reads when using the bcm_qspi_exec_mem_op()
> call. This fixes SFDP parameter page read failures seen with parts that
> now use SFDP protocol to read the basic flash parameter table.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm-qspi: fix SFDP BFPT read by usig mspi read
      commit: f9540ac18bb4afd13d3a09275693793cb18d4afb

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


