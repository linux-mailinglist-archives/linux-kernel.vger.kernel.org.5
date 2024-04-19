Return-Path: <linux-kernel+bounces-151559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B32668AB079
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532471F26350
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C509A12BF2D;
	Fri, 19 Apr 2024 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="My8WQcq0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ABB82D62
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536047; cv=none; b=g9IjnMl16ataVPVBA8+RtnazGxJL7gpulgwbZVIulChKDNip55uAwa7q6ldQtj5npXJgOsXjO2hf6Y39xHEcrDqkG013Zm8sUeOCXgeupy67W4NB4dVwFW6GjavPkSFhon09lKvVSS/JuKaFsfMWeG8pfsP0HIA/jorD8Ijvfqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536047; c=relaxed/simple;
	bh=M+lJ0VdAf2ZefRXeZ/D49skD9XSYKgj9KYPgzdBpWgc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qnLMQMf4M+F9OFhGroFKnZKHO0v3x6JmNZLorTDhJJ8SfbuXPIDJGOp8cjaEjs0XSMkFOKK26b9a5kNXyqBaSb1T0hPC9pLzmuQQCzXOEqndOcBj1jl3bM7/QM+VDGUEcNZ3MbVWIDfgUtb/EXzC4EjusVhFEY2lx6qPHNShUUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=My8WQcq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A721C072AA;
	Fri, 19 Apr 2024 14:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713536046;
	bh=M+lJ0VdAf2ZefRXeZ/D49skD9XSYKgj9KYPgzdBpWgc=;
	h=From:To:Cc:Subject:Date:From;
	b=My8WQcq0uC3ZYNtLepMk8+NCns5Bru5mbIgVr1uw2m9SC2epkBYBam6ObJicWkJs7
	 dCVvmFhey3xsQUDFBSCptkxloKmZK/hMa8YRkw/dpAZ3zVx6+pNygENE3liHj+bLhn
	 JxZdMelnVoh39Vvb4snrC8nQaET4XxtSHuhmPxEy74Ud86BMSuknhsTxD1OFvvfTYj
	 yLQG7u+m7pOo/uJt8Y3d6KQDWZyyWhrHE+irm+h044civ5jGa7ycRl2RX5ZUrOan8U
	 z2wTsk26LGoal4D0ivd0zeDp1p/WsA3LrTafhiMDpdeOT9wNpybUkWW4A83STIoj+S
	 jMvtrmSUEpwRg==
From: Michael Walle <mwalle@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Ricardo Ribalda <ribalda@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2 0/6] mtd: spi-nor: spring cleaning
Date: Fri, 19 Apr 2024 16:12:43 +0200
Message-Id: <20240419141249.609534-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's time for some spring cleaning. Remove the oddball xilinx
flashes with non-power-of-2 page sizes.
Remove the .setup() callback, only the default callback is ever
used and it is unlikely there is need for a custom setup.

Finally, the last patch is a proposal how to deprecate flashes,
which are just detected by their id. We cannot really find out if
there are boards out there which are using a particular flash. Thus,
as a first step, we can print a warning during kernel startup. As a
second step we might introduce a kernel config option to actually
disable the flashes which has the deprecated flag.

v2:
 - remove convert_addr, I've left page_size in the info, that might
   still come in handy for future flashes as they are getting
   bigger, although let's hope they have SFDP support..
 - simplify the fast read flag handling
 - reword the commit message of the .setup() callback removal patch
 - introduce .deprecation_version and simplify the checking

Michael Walle (6):
  mtd: spi-nor: Remove support for Xilinx S3AN flashes
  mtd: spi-nor: get rid of non-power-of-2 page size handling
  mtd: spi-nor: remove .setup() callback
  mtd: spi-nor: get rid of SPI_NOR_NO_FR
  mtd: spi-nor: simplify spi_nor_get_flash_info()
  mtd: spi-nor: introduce support for displaying deprecation message

 drivers/mtd/spi-nor/Makefile   |   1 -
 drivers/mtd/spi-nor/core.c     | 208 ++++++++++++++-------------------
 drivers/mtd/spi-nor/core.h     |  15 +--
 drivers/mtd/spi-nor/everspin.c |  19 ++-
 drivers/mtd/spi-nor/xilinx.c   | 169 ---------------------------
 5 files changed, 105 insertions(+), 307 deletions(-)
 delete mode 100644 drivers/mtd/spi-nor/xilinx.c

-- 
2.39.2


