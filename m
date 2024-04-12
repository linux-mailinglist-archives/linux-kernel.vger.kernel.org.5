Return-Path: <linux-kernel+bounces-142748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0088A2FB9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB221C23BAA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F8884A45;
	Fri, 12 Apr 2024 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJ/P3h0p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993CE83CCE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929454; cv=none; b=Hx7nrCN7FYjWRBAUTG3rxRKd2suqWQkT7ev+kusqCxPmW2eOiYHhEu19FRV9G717Agj4EgBpkGcu3XSLSPrkG7SfdAgaxME6OHBqD/3ao3+lCokkc1xDwjGGzQZXor9icjAMKz8rMWc92HgADP+PnmUSCGHEIh4Z8VQFIRGr46o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929454; c=relaxed/simple;
	bh=dH6kXU4exatPA4peUu+lOUSnRh3/aQHQ5G1AbXpcFrc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kPwSrYmgzhTw4M1hoDw4W2tsOzx/C7NIRJ3Ij/PsDt1YduoB54YFS8wdUmnv69wvZuCqW1a/TxvS5/vqq86WE+SD+4GeKXhQU+9Jox0MElOfZ4k2O+J1nf3yInyn+2uVpGltLeG4/XTbvE4rg21N1QQeRZzNv0V52TEi9BBpHk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJ/P3h0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2F9C113CC;
	Fri, 12 Apr 2024 13:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712929454;
	bh=dH6kXU4exatPA4peUu+lOUSnRh3/aQHQ5G1AbXpcFrc=;
	h=From:To:Cc:Subject:Date:From;
	b=MJ/P3h0p8+ZnVxiAh2aIei0Sd9ALNNQmHSRwaCNdZEe3+eOKT0l3VQo1NjeeMJnwK
	 Uhe86otqAywWgxchhW7oqJassj4d2X31Xyn/OnPtgg+8PU1p2UB6AyN8Wkjt5GfiNi
	 +6b5Et4XyqFuvSkCHPF1Z0/Pw/AFOvfV10ZjdKg8tbVmPT/Hf1pODYmF1QyBl7AWCt
	 iUTIvcHNzuI7gOT7t/oDg1o9vKyTgFhhCcZU0YFG/48lisYFUxnh40g5xHOuzGohpE
	 08rxj4b0LIRVN6Z7XkA0f/C3tgfYk66rZjlxJYDhnXyo+V/O+l8PnnJkASqCw/tCry
	 buFTMDGEF59XA==
From: Michael Walle <mwalle@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v1 0/6] mtd: spi-nor: spring cleaning
Date: Fri, 12 Apr 2024 15:43:59 +0200
Message-Id: <20240412134405.381832-1-mwalle@kernel.org>
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

Michael Walle (6):
  mtd: spi-nor: Remove support for Xilinx S3AN flashes
  mtd: spi-nor: get rid of non-power-of-2 page size handling
  mtd: spi-nor: get rid of SPI_NOR_NO_FR
  mtd: spi-nor: remove .setup() callback
  mtd: spi-nor: simplify spi_nor_get_flash_info()
  mtd: spi-nor: introduce support for displaying deprecation message

 drivers/mtd/spi-nor/Makefile   |   1 -
 drivers/mtd/spi-nor/core.c     | 202 +++++++++++++++------------------
 drivers/mtd/spi-nor/core.h     |   9 +-
 drivers/mtd/spi-nor/everspin.c |  19 +++-
 drivers/mtd/spi-nor/xilinx.c   | 169 ---------------------------
 5 files changed, 110 insertions(+), 290 deletions(-)
 delete mode 100644 drivers/mtd/spi-nor/xilinx.c

-- 
2.39.2


