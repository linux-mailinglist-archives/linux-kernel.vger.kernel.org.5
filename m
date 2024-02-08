Return-Path: <linux-kernel+bounces-58352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A09984E50E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1041C21429
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509E47F7EA;
	Thu,  8 Feb 2024 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2xljUBT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843AB149E04;
	Thu,  8 Feb 2024 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707409997; cv=none; b=TRRjDkIIETVuYyVXvs1MuVk9YHPQ2T5fA1/t6EMtCIQndXwnEKxeecZb/QnNkpQl/3abgUZf5cs+70ybt034lmU0vB5/Ete3acfjcY+yA0U8aI+KYQY8YqpyB2DpwkwfwYZeqxc6k+mlUZFHjlQ2PLphDXDuZHxxyKVrtC0HaaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707409997; c=relaxed/simple;
	bh=3jJWRkwsN1BS9FlYVR/Lplms+dTkyzJpgsOPO1wPTO4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aK7ei0UuCSdkQc0iYjDdnx8RSba+RxlxnXTGoi9MNWrUOI4VKCl783WdpecF6otfySeuiPWmD5kQ359urfKus4G2TmEX/DZyu9lgCvbNih8/SDusf+WwGnpycHmLf1RNtUUtgEksZIeXVnmInK30n3f6252l7kpP/3HNgKS4EhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2xljUBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842B4C433C7;
	Thu,  8 Feb 2024 16:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707409997;
	bh=3jJWRkwsN1BS9FlYVR/Lplms+dTkyzJpgsOPO1wPTO4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Q2xljUBT8wWy7mNndmrb6Rd8dsfg9aoaCmtl6UA7D0/d5oS4UuFcE47j4fZum5Ie+
	 n6JciT/jx3PlHGLNIXJagzMJQDGd2Kt8t0njPc/GlxaGOzb0KqAYB61CPITHQ7ljSS
	 1u9NH1lvviVUjf1pLK/XVf0F53KU2wpC9WYB+4z3Rv7gwFMAl3/UFk59gvsUSVqyoV
	 xWvcD/VEYE0qpjuCPVQkiT5zulZp92SOUypKWGuSrK98sLc2ptz8uKecOvu3lTJH5N
	 nAw0Djx3f5BVD7sa0vBU99cftQXS+MYK6lPyCAOayxw5e7XJQ4mYbnbYOoC4pK8/mp
	 +LLAOfujIW+fg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20240206-axi-spi-engine-round-2-1-v1-0-ea6eeb60f4fb@baylibre.com>
References: <20240206-axi-spi-engine-round-2-1-v1-0-ea6eeb60f4fb@baylibre.com>
Subject: Re: [PATCH 0/2] spi: axi-spi-engine: performance improvements
Message-Id: <170740999510.1643259.684443512140632243.b4-ty@kernel.org>
Date: Thu, 08 Feb 2024 16:33:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Tue, 06 Feb 2024 14:31:26 -0600, David Lechner wrote:
> While researching potential performance improvements in the core SPI
> code, we found a few low-hanging opportunities for improvements in the
> AXI SPI Engine driver.
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: axi-spi-engine: remove use of ida for sync id
      commit: 531860e12da76a444e0ecfd37a9d786e7986957a
[2/2] spi: axi-spi-engine: move msg finalization out of irq handler
      commit: abb4b46c43689dd1f4d80c41e49127ca0ede75b3

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


