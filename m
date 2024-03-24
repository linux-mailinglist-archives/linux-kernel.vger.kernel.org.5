Return-Path: <linux-kernel+bounces-116210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA114889D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5390428ACBE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1003BDFAD;
	Mon, 25 Mar 2024 03:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acJe5k3v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6E02853F6;
	Sun, 24 Mar 2024 23:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323830; cv=none; b=tYIEaEJVw8iN2dLOlTq96PlwQGCu8+lgMABUOCkBzmwdzAICZKZYuLEPUyWb+sC7/w/mNjWJhVQwIGssOfepNxcPx+N6S2qXe7Gf1QvvPnAUmmJv07Nk6Fh9SBwBt1C1lIkHq5y9tTvnE9sOD3a2lwxeZ1KL9ZvoWlCAuKxnP3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323830; c=relaxed/simple;
	bh=gso14qdhcLYmuzqsGSlhn50akIu/WBnOxsTxJ7leCmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RipyKd0kFIHw/4PQPDlaxrF7JUMndFxuNKNyhmKkdN2H+Ky5ycI5ZBFu/N/dXlzUW4ts0KO8Gu0b66Wehl4YKKtKUwvFfaosO2JKJ0h3CCKb4/pPlthyDuG/qlDul39+fBJQZODwl+3Kamvp1u8eQZCjOiPUQMgYTgO0dxR29zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acJe5k3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12454C433C7;
	Sun, 24 Mar 2024 23:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323828;
	bh=gso14qdhcLYmuzqsGSlhn50akIu/WBnOxsTxJ7leCmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=acJe5k3vIVk8c2/o9YIk3j/XPrusln6ohXTU4oHd29bx43C4lrLng05RU0OOc8bjA
	 xl9CowsvXQu6hdk+JjrG9MrTpiLm2C4qQv0s+EJr079Bz+7/azHaSO7Llrb5XJUah9
	 lzFRK+bqhDpbW83fVqop2Im7L9b/f3OxOa7zITWzMMUSUrONebwMsWPPUyGfzvk2HA
	 c153AtUWbS5D4UEYiFrTUA5tYZgsul5ImBNr2k1B3W6QmrUI7Yzt02HsTcR2og+xK0
	 5qGJJz3OgLidKwOwvZQ/kiHRrBNNdEIHjRco6oaClOAOpGk91CkdaMVQa7vmCD/GkI
	 DrKm69u7q9H7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 207/238] remoteproc: stm32: use correct format strings on 64-bit
Date: Sun, 24 Mar 2024 19:39:55 -0400
Message-ID: <20240324234027.1354210-208-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index d99548fb5ddef..6dbf6ed10ea49 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -249,7 +249,7 @@ config ST_SLIM_REMOTEPROC
 
 config STM32_RPROC
 	tristate "STM32 remoteproc support"
-	depends on ARCH_STM32
+	depends on ARCH_STM32 || COMPILE_TEST
 	depends on REMOTEPROC
 	select MAILBOX
 	help
diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index b410684c3aa90..8f7fb1baed10d 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -117,10 +117,10 @@ static int stm32_rproc_mem_alloc(struct rproc *rproc,
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
@@ -608,7 +608,7 @@ stm32_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
 
 	ddata->rsc_va = devm_ioremap_wc(dev, rsc_pa, RSC_TBL_SIZE);
 	if (IS_ERR_OR_NULL(ddata->rsc_va)) {
-		dev_err(dev, "Unable to map memory region: %pa+%zx\n",
+		dev_err(dev, "Unable to map memory region: %pa+%x\n",
 			&rsc_pa, RSC_TBL_SIZE);
 		ddata->rsc_va = NULL;
 		return ERR_PTR(-ENOMEM);
-- 
2.43.0


