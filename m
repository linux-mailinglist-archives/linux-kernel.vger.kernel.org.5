Return-Path: <linux-kernel+bounces-165341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 896728B8B7B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE0A1C22464
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239FD12EBD3;
	Wed,  1 May 2024 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPSqO9SA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6610650A77;
	Wed,  1 May 2024 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714571612; cv=none; b=L7bsDc66kM7W6qjBSTF7vdU4SWI0r8CjLUsRDqLZQd08Qi/xeTKFC1UkKrw21XkqfreijfEhib8vyvdMBavpLYeEWwRTYOl3l/8xQDzk3Eo16D02zxqgzceXwc/uE/4xCIkH4W0OjeyZb88qYQSuUa2JcQtmRlM5/jt3Xap4S4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714571612; c=relaxed/simple;
	bh=ogGN1CSAXwPbhMIYqiPfxTqJzxX1ZSV0pCZcbe3qHEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MBe2ko3dqUQqfljHzZ6/7qa5Ic+s5+2j53u7dyk5IUy9nfsmBJzg5dgEvoEReEfup2OeRJJYzvfQvAv6ko5P0ONikL3VRFD9/nI5IrGmzUjH4wtxAxOdshxAt6oH+0nduBhifwJyVkaLOeeL/zcZ9vRtnllaaBf6BWJMFPKAjk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPSqO9SA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28154C072AA;
	Wed,  1 May 2024 13:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714571612;
	bh=ogGN1CSAXwPbhMIYqiPfxTqJzxX1ZSV0pCZcbe3qHEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oPSqO9SATCegMTdo7ZmYyVUXldX3K8ZAi3gbZ5lkUhtZrRKQ2OwCFRyQzyCPZKAPU
	 yu+c3TwDvhOypRDPY9acnNqf45eCF77EMHGdGsE6YF7pTIzPHmOgSqcfhvqQm0AYtZ
	 tHQSHx9otPqe28C21joxq6CVDXE5xcJyXtXSCcZ4chQ0MTfIjcQGdZXDtWgpG9t1lu
	 B9flD2JYwQPA2Qh1AiaVHz392kYVKZEDkkpjCFRhBZJGUQDhcP0NUMl5I4LvTbPPjU
	 ipLzkVJQjMtkhczoYiRfeH61cEwUs8YtOLXfjZCluKeP5Hp8p+aSQ8NJT2ru3fHmcz
	 ZGVtZlWy6Llxw==
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240430201530.2138095-3-dlechner@baylibre.com>
References: <20240430201530.2138095-3-dlechner@baylibre.com>
Subject: Re: [PATCH] spi: use spi_valid_{tx,rx}buf() in stats function
Message-Id: <171457161096.1895134.6406701144807353881.b4-ty@kernel.org>
Date: Wed, 01 May 2024 22:53:30 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 30 Apr 2024 15:15:27 -0500, David Lechner wrote:
> There are macros spi_valid_txbuf() and spi_valid_rxbuf() for determining
> if an xfer actually intended to send or receive data.
> 
> These checks were hard-coded in spi_statistics_add_transfer_stats(). We
> can make use of the macros instead to make the code more readable and
> more robust against potential future changes in case the definition of
> what valid means changes.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: use spi_valid_{tx,rx}buf() in stats function
      commit: 52267fe8456a2a05f70b29d68292eec789c960b9

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


