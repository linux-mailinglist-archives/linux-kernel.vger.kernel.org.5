Return-Path: <linux-kernel+bounces-114655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E4F888B93
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2610A1F27DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3E82ADE01;
	Sun, 24 Mar 2024 23:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4t+Kg4U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8892365BF;
	Sun, 24 Mar 2024 23:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322304; cv=none; b=G8iIlMo4nyVLmqFccRwvsGdU9DumitTbwQAq4W9XXA29ZMLNnGir3QWL9EurgwX74K736Q480Zh6B/vDPTwDgcKxgFp5EvXzAv2A05/ss/bLvPVYLkTVw4i9eTyQK5eVc8Qq8jR10Ll/zPDS1HIWqyEtkt0xuCpJs45a/ke931w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322304; c=relaxed/simple;
	bh=c5HtwREgdbx3pjbaaaxDoZl/rJ5CeduvwI9/zEFsZ0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rzln+1mOLjuSuHUed7/iCFtPrOoKo1ZohyLzXZGx1dYGwYu2xYrOJ0dbrAdKML4DimUk7rNXIaZZHVso50n/xJ2RffEQI+WMy+L9HFJuLgCO/1KrEzT1ELahXtETOLTw1DQgEv1VFK6TgX1I651/cc9VFiTVse1QHBST1yT4QE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4t+Kg4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E78EC43390;
	Sun, 24 Mar 2024 23:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322303;
	bh=c5HtwREgdbx3pjbaaaxDoZl/rJ5CeduvwI9/zEFsZ0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p4t+Kg4UXeGtg6n1JZzCRtypQwuoB777703YHzDi3SoaICxT1KStv7BW+jN6nzwYe
	 33ST/i1I3qURkl/G/ALnlk4GxvKzbUtSVsyMNjX1tH0od5x0Bw84c/hF+xr+GEDdg/
	 7zEsd5phpwvnXCn53iApAU2k38Ppg9xOy0JXk+flMlKIVpyAQz6ztyfgbCZC6xMBoi
	 sO0IfsLJa9+8QFZ3JQN0XcXq0/dZl+xJBqKH5Bdf9ylys7ofCXifOyLj9LKtULqRjc
	 1vLMKJfiz+j0bmtkkJdcGSQm/aGKJh5FbvVNciCK4Rn1sZHeIYMSbPrNOC2MpCx58A
	 G2rSDkKJbfrRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 386/451] remoteproc: stm32: use correct format strings on 64-bit
Date: Sun, 24 Mar 2024 19:11:02 -0400
Message-ID: <20240324231207.1351418-387-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 03bd158e1535e68bcd2b1e095b0ebcad7c84bd20 ]

With CONFIG_ARCH_STM32 making it into arch/arm64, a couple of format
strings no longer work, since they rely on size_t being compatible
with %x, or they print an 'int' using %z:

drivers/remoteproc/stm32_rproc.c: In function 'stm32_rproc_mem_alloc':
drivers/remoteproc/stm32_rproc.c:122:22: error: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'size_t' {aka 'long unsigned int'} [-Werror=format=]
drivers/remoteproc/stm32_rproc.c:122:40: note: format string is defined here
  122 |         dev_dbg(dev, "map memory: %pa+%x\n", &mem->dma, mem->len);
      |                                       ~^
      |                                        |
      |                                        unsigned int
      |                                       %lx
drivers/remoteproc/stm32_rproc.c:125:30: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'size_t' {aka 'long unsigned int'} [-Werror=format=]
drivers/remoteproc/stm32_rproc.c:125:65: note: format string is defined here
  125 |                 dev_err(dev, "Unable to map memory region: %pa+%x\n",
      |                                                                ~^
      |                                                                 |
      |                                                                 unsigned int
      |                                                                %lx
drivers/remoteproc/stm32_rproc.c: In function 'stm32_rproc_get_loaded_rsc_table':
drivers/remoteproc/stm32_rproc.c:646:30: error: format '%zx' expects argument of type 'size_t', but argument 4 has type 'int' [-Werror=format=]
drivers/remoteproc/stm32_rproc.c:646:66: note: format string is defined here
  646 |                 dev_err(dev, "Unable to map memory region: %pa+%zx\n",
      |                                                                ~~^
      |                                                                  |
      |                                                                  long unsigned int
      |                                                                %x

Fix up all three instances to work across architectures, and enable
compile testing for this driver to ensure it builds everywhere.

Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Stable-dep-of: 32381bbccba4 ("remoteproc: stm32: Fix incorrect type in assignment for va")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/Kconfig       | 2 +-
 drivers/remoteproc/stm32_rproc.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 1660197866531..d93113b6ffaa1 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -313,7 +313,7 @@ config ST_SLIM_REMOTEPROC
 
 config STM32_RPROC
 	tristate "STM32 remoteproc support"
-	depends on ARCH_STM32
+	depends on ARCH_STM32 || COMPILE_TEST
 	depends on REMOTEPROC
 	select MAILBOX
 	help
diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 8746cbb1f168d..e432febf4337b 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -118,10 +118,10 @@ static int stm32_rproc_mem_alloc(struct rproc *rproc,
 	struct device *dev = rproc->dev.parent;
 	void *va;
 
-	dev_dbg(dev, "map memory: %pa+%x\n", &mem->dma, mem->len);
+	dev_dbg(dev, "map memory: %pad+%zx\n", &mem->dma, mem->len);
 	va = ioremap_wc(mem->dma, mem->len);
 	if (IS_ERR_OR_NULL(va)) {
-		dev_err(dev, "Unable to map memory region: %pa+%x\n",
+		dev_err(dev, "Unable to map memory region: %pad+0x%zx\n",
 			&mem->dma, mem->len);
 		return -ENOMEM;
 	}
@@ -627,7 +627,7 @@ stm32_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
 
 	ddata->rsc_va = devm_ioremap_wc(dev, rsc_pa, RSC_TBL_SIZE);
 	if (IS_ERR_OR_NULL(ddata->rsc_va)) {
-		dev_err(dev, "Unable to map memory region: %pa+%zx\n",
+		dev_err(dev, "Unable to map memory region: %pa+%x\n",
 			&rsc_pa, RSC_TBL_SIZE);
 		ddata->rsc_va = NULL;
 		return ERR_PTR(-ENOMEM);
-- 
2.43.0


