Return-Path: <linux-kernel+bounces-114904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D375E888BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112851C29BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BA72D21EB;
	Mon, 25 Mar 2024 00:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5sxSb0+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE1327DDE8;
	Sun, 24 Mar 2024 23:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323569; cv=none; b=ezDHbgRRJV1nPtGDyjDRGu9CfpHvsvBEAwYy22mw8NrMxBy5zXsT/5GAuTh9YFQ+Je2IXXtUlNg0H+aqc391Bvum5ULQWSh2+A90wvDj/bX+CQfWAX9RrX6TlPDXBTsLxJhGHiiNi5kGUJL1wgrMtXrmq+2IlSkVdv2l584VOow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323569; c=relaxed/simple;
	bh=tMMlTpa/czaupUylr0uuF5+uGMG/CO/yyVada6/zEWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXYvOZDWZKm0dUWFc05T2XjwyoIggbIOE1RcgMcGeTp32UORyg8WX1WgnNZICOHYplZUydCh5+aSlDxgLlA142WzNLRCOcbqfwC2B3OPiQTMiwmz4z4x6C9s4+ZW1seRh0fx2BOVz8xNZtA1rOYnpS/5yTtlpR/vLVZpXI9Fre0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5sxSb0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45EAC433C7;
	Sun, 24 Mar 2024 23:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323568;
	bh=tMMlTpa/czaupUylr0uuF5+uGMG/CO/yyVada6/zEWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d5sxSb0+HMMpRLBfKDLpgvT1kkDM5jAG8PEbd1KSllQYcUv3hYZZJSfRnYs3jkTcq
	 WySwTCSQh9Flf5dDhXYwfm/C9pojUQB0hh1aHRAl76i8QYRyyggzvFhB/vbyrWX7Qd
	 l5jNiU6cssA9pUFsoAvkfErjhhG8UYusUPak32ETP05rTgqA4a42ox+LlDsInaV9I0
	 ixWyVmAh4bugZBBcEduF93s6XzBtuxBo9bYmcpPFHW5AADnxIWGHnZ9D4y5EOFE4wD
	 2Oac+57cheFKOB2Ua5cb5qG9yBKVCHqBrClR53YFuoMDmtTFUC1ABJ1zeIiuA3aNsv
	 y/lOlL8FfYaYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 275/317] remoteproc: stm32: use correct format strings on 64-bit
Date: Sun, 24 Mar 2024 19:34:15 -0400
Message-ID: <20240324233458.1352854-276-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 9a6eedc3994a5..d89460429257e 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -276,7 +276,7 @@ config ST_SLIM_REMOTEPROC
 
 config STM32_RPROC
 	tristate "STM32 remoteproc support"
-	depends on ARCH_STM32
+	depends on ARCH_STM32 || COMPILE_TEST
 	depends on REMOTEPROC
 	select MAILBOX
 	help
diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index aba3df1d1bf52..43715594bd801 100644
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


