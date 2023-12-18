Return-Path: <linux-kernel+bounces-4182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74F78178E9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DF228536F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4514B5BFBF;
	Mon, 18 Dec 2023 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRMrPstA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938685A879;
	Mon, 18 Dec 2023 17:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8487C433C7;
	Mon, 18 Dec 2023 17:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702921251;
	bh=8FLxMT/12hOBAOH3xUDzESjmyuLa9nkg9wK3icSyows=;
	h=From:To:Cc:Subject:Date:From;
	b=kRMrPstAHiOsYXUjdnAErJpq942EjMDI/CjGw2oEiL8c2X/vszV6TTzXfjqvvuiYL
	 ZeTMU+bkjGyTlsPT/9vAcmG05lmemcL2wO2bf9EPRr90FZvnDZyYZhYwY8oMJ4vKDC
	 IUt02vApB93eH0e6t/EZOq5FMW7hnuuAZVZeDgqPqD/htUgBZ6KA3fMnkKXzZpLV/R
	 rM64ZqbzcceXy2nfm8BnS4npLSOk05vrr2MVhY53bH+K0aSLsezoT3yR4plz3EjRKF
	 duJdg5CfYF1mtz44d+MbMaIJJHQtRV6lKGQPHPQlPOnf8UZkAeyqoF9wTXKwWEeuBa
	 OiIUQBHFRmVJw==
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.7-rc7
Date: Mon, 18 Dec 2023 17:40:47 +0000
Message-Id: <20231218174050.A8487C433C7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.7-rc7

for you to fetch changes up to fc70d643a2f6678cbe0f5c86433c1aeb4d613fcc:

  spi: atmel: Fix clock issue when using devices with different polarities (2023-12-14 10:56:37 +0000)

----------------------------------------------------------------
spi: Fixes for v6.7

A few bigger things here, the main one being that there were changes to
the atmel driver in this cycle which made it possible to kill transfers
being used for filesystem I/O which turned out to be very disruptive,
the series of patches here undoes that and hardens things up further.

There's also a few smaller driver specific changes, the main one being
to revert a change that duplicted delays.

----------------------------------------------------------------
Benjamin Bigler (1):
      spi: spi-imx: correctly configure burst length when using dma

Louis Chauvet (1):
      spi: atmel: Fix clock issue when using devices with different polarities

Miquel Raynal (3):
      spi: atmel: Do not cancel a transfer upon any signal
      spi: atmel: Drop unused defines
      spi: atmel: Prevent spi transfers from being killed

Nam Cao (1):
      spi: cadence: revert "Add SPI transfer delays"

 drivers/spi/spi-atmel.c   | 95 ++++++++++++++++++++++++++++++++++++++++++-----
 drivers/spi/spi-cadence.c |  1 -
 drivers/spi/spi-imx.c     | 15 ++++++--
 3 files changed, 96 insertions(+), 15 deletions(-)

