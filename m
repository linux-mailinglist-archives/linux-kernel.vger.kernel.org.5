Return-Path: <linux-kernel+bounces-116209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD3B8895B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4971F312C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B583BDFCB;
	Mon, 25 Mar 2024 03:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQn61eP0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C022853F5;
	Sun, 24 Mar 2024 23:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323829; cv=none; b=D9vbQEDn/tTvSOfqMiEsJd73xYeYFU0j6o8R1IOgSPq3+9jhJ+YOeTqUvPRwap+Qo0RRnf8Txku3pUXMBd/k0gY7fYIPly/8RP5OTTCWBhAPlFjGvOVuYGHc96FnO2J+M6rDEgLbInRuKEs5ZT2Mf3Z0JC1aVZW3pqW6WKSY4w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323829; c=relaxed/simple;
	bh=RdXCrAiJHu1NYvt4KGF+CTCIYXQKUHk4h5FLZoZ/CwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iz7srCoxWmK2DfDk/cuLW6O31sy0UA2zgTC8gkhhD4Cc7FCqshQDHsMbRdBQZI47ZU3dJwx5keUOXnEMEEHP3uQY//WRnMAFoIawRKxPh6TjFqz+XRo0E0gv3IVn7/IZhuxCoawucOJSE6hjdfFCn28sKneovyHFWMqZ1ZWyD7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQn61eP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7CBC433A6;
	Sun, 24 Mar 2024 23:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323829;
	bh=RdXCrAiJHu1NYvt4KGF+CTCIYXQKUHk4h5FLZoZ/CwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BQn61eP0qwc+SdC270mdJoTSQyC5pl41dz0PHRilJHaVmC/dsCjF8Zcobg7/97f1M
	 rcgGdhMJx5liGmBXjfaEnU0Br+6pULP8V01x9559buN1JiHpx1kfmaK+NkfzHa6URP
	 ene4tiufIm4jJBb06B8mhaWFap8AdvLkWa7HrJ+c5kuambfuTO2M5/0EK25hXTHGLG
	 mK9fZBLzXOfnSC5cIK4pS7eWEyhTVbyX5gS5XAhsGp+DquAsiA13zEI4WO6TWEBdA6
	 Ou/kyw5CZbehaIN3RhoIrNbDZs5ap+l2U8LhbtGa+7hAaTp4GHcp8vptLXZS1a3CTO
	 ebBwQsEjRZf/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	kernel test robot <lkp@intel.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 208/238] remoteproc: stm32: Fix incorrect type in assignment for va
Date: Sun, 24 Mar 2024 19:39:56 -0400
Message-ID: <20240324234027.1354210-209-sashal@kernel.org>
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

From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

[ Upstream commit 32381bbccba4c21145c571701f8f7fb1d9b3a92e ]

The sparse tool complains about the attribute conversion between
a _iomem void * and a void *:

stm32_rproc.c:122:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
stm32_rproc.c:122:12: sparse:     expected void *va
stm32_rproc.c:122:12: sparse:     got void [noderef] __iomem *

Add '__force' to explicitly specify that the cast is intentional.
This conversion is necessary to cast to virtual addresses pointer,used,
by the remoteproc core.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312150052.HCiNKlqB-lkp@intel.com/
Fixes: 13140de09cc2 ("remoteproc: stm32: add an ST stm32_rproc driver")
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Link: https://lore.kernel.org/r/20240117135312.3381936-2-arnaud.pouliquen@foss.st.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/stm32_rproc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 8f7fb1baed10d..d11949ae3ba0d 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -118,7 +118,7 @@ static int stm32_rproc_mem_alloc(struct rproc *rproc,
 	void *va;
 
 	dev_dbg(dev, "map memory: %pad+%zx\n", &mem->dma, mem->len);
-	va = ioremap_wc(mem->dma, mem->len);
+	va = (__force void *)ioremap_wc(mem->dma, mem->len);
 	if (IS_ERR_OR_NULL(va)) {
 		dev_err(dev, "Unable to map memory region: %pad+0x%zx\n",
 			&mem->dma, mem->len);
@@ -135,7 +135,7 @@ static int stm32_rproc_mem_release(struct rproc *rproc,
 				   struct rproc_mem_entry *mem)
 {
 	dev_dbg(rproc->dev.parent, "unmap memory: %pa\n", &mem->dma);
-	iounmap(mem->va);
+	iounmap((__force __iomem void *)mem->va);
 
 	return 0;
 }
-- 
2.43.0


