Return-Path: <linux-kernel+bounces-129291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ED7896846
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518051F2175A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DE81292C2;
	Wed,  3 Apr 2024 08:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrlzbiVz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70E98665A;
	Wed,  3 Apr 2024 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131782; cv=none; b=X5zNDYJCZEYQ0B6J4UoO71pfdzQLfDMYoQM35Gc33nxdvi+J7+Ks1RC2icT15tCWdRCgEQ+iDwjiIMv/FYkup2JFvXuAK7lnF4kDt59c5Q6LM0LdGZhSnPzKETsD7xAVjIEjeLnL+90LcH0/W+JDKgbBskQU82JYcuIMUJpabAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131782; c=relaxed/simple;
	bh=7qsqH0LOymzYXB4GWBeD5Wb7ADrWcz+eYFLQOtLMhn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fohUacLglUdTTtHLaxI4JVEx+zPZzQzCmUWkpipUl7FtBGqY5eAo9MmrAQLJHBD6tfnL46pm3ywhSKQnPbL3HxQH4FmPqC1+8JoIwaOIkV/6UuwAnAIf9+6MuV5W/7ksZ7OBNW0YjmZ/4owjAjvZqaICrl3LHYHOFr1TgQyUWSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrlzbiVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C06C433F1;
	Wed,  3 Apr 2024 08:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131782;
	bh=7qsqH0LOymzYXB4GWBeD5Wb7ADrWcz+eYFLQOtLMhn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QrlzbiVz8QbmfIib4J3OYU4BOIrOjhCsy7HJjYd3nq1yYbaY+QP/p9/1g8S0EMgrW
	 9XdWtqndlfwLVhoRp2IULI0sKLRt1fHzqVhrBXG6/TW/3yvBf8ZIqMPEN5jteWUE7r
	 f7Du+JzXpzdXLydduMpaARcakzrnsWpVk9HbLsEXOCSc1ORaEPo/dcrQ4+5MAUnbhm
	 Cf7Fiiwa6icGeeYse5sLPeCUrnsevCa2UNW5BKkk0wFywIW6ib9G3d2A8k6KwxrLts
	 Hv0FxdSYJaDXVcPRysoRQfkKQ7zDki7ab8oWVo0s7J7aONZamdGy2612a6usR1rHPD
	 NIfIOouT+oi+g==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Michal Nazarewicz <mina86@mina86.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	Binglei Wang <l3b2w1@gmail.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>,
	iommu@lists.linux.dev
Subject: [PATCH 14/34] dma/congiguous: avoid warning about unused size_bytes
Date: Wed,  3 Apr 2024 10:06:32 +0200
Message-Id: <20240403080702.3509288-15-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When building with W=1, this variable is unused for configs with
CONFIG_CMA_SIZE_SEL_PERCENTAGE=y:

kernel/dma/contiguous.c:67:26: error: 'size_bytes' defined but not used [-Werror=unused-const-variable=]

Mark it as __maybe_unused to avoid the warning without adding more
ifdef checks to this file.

Fixes: c64be2bb1c6e ("drivers: add Contiguous Memory Allocator")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/dma/contiguous.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 055da410ac71..c53f4f633f7f 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -64,7 +64,7 @@ struct cma *dma_contiguous_default_area;
  * Users, who want to set the size of global CMA area for their system
  * should use cma= kernel parameter.
  */
-static const phys_addr_t size_bytes __initconst =
+static const phys_addr_t size_bytes __initconst __maybe_unused =
 	(phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
 static phys_addr_t  size_cmdline __initdata = -1;
 static phys_addr_t base_cmdline __initdata;
-- 
2.39.2


