Return-Path: <linux-kernel+bounces-113932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C75F2888770
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D10028A34C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AF4216908;
	Sun, 24 Mar 2024 23:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6s2ya4o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B22712C809;
	Sun, 24 Mar 2024 22:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321056; cv=none; b=D7iBI/jWCjXm+MttmKUzL77LlGtKsimsJPeo17imEuMk29+3q01ZEzBTTgVNoOdw2vqh0jmth/qXEAj5LxQ2yP2XN49LQ1r+HQ6ts6PY7hxM7MvfCNymPQzXR28HIs32MCSJZ+8Sn5CxaGggFNYIG8qJuQDxnMAG8Xrcl/2KxXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321056; c=relaxed/simple;
	bh=AMkb6V5/8OzM2qunQBvo0Q2DSac62dcJLz4Z4OClx3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qbr2b/KqGBYjukUlTO28U1w4H/n7b164l5pXxFz9ZPF4cf2fDZVwWfJl+gyNk6pWVCTq9mtm6HIW9WSezbIYj7LkF4RfhWvRJe7iKOsC3Q7qL83kgowpOsvkjiS79oEE5bZlvRYaApERSssYT9Fq0TPQJBHnOiQkYu/q7kugaNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6s2ya4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AADC433F1;
	Sun, 24 Mar 2024 22:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321055;
	bh=AMkb6V5/8OzM2qunQBvo0Q2DSac62dcJLz4Z4OClx3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K6s2ya4okzdODZY7T+oqsDP+yE51mKVQ0SuobDKTguNO5eCUrZ99lE0mF78o/IcUL
	 8IbtHRhX36TAvDQjcx6AxcZQukq/1xCqj8bmv7rkMw7bTsJZZIWFASAkpmVqDrQ3pi
	 BWGcUm/5hrvSWY921dpyo4z8ewQQ9tBpIfRAFTMRQ8TDxkl0yVE260gNaVBRF1YEto
	 hg44II+AAjiEzLLcjvTUEG3Lm549S4SzKBqB+nz99Bcuiaj3HPxBFOSUjAfxLNQOb+
	 H+kIJsoTXuzfNMtVByjh9mTSuegrOgfigj9IwoYAkGDXQeksxcIe/6YxHSR3HQ7hbE
	 cTY2Lv6BylRcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	kernel test robot <lkp@intel.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 619/713] remoteproc: stm32: Fix incorrect type in assignment for va
Date: Sun, 24 Mar 2024 18:45:45 -0400
Message-ID: <20240324224720.1345309-620-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 4f469f0bcf8b2..2c28635219ebf 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -120,7 +120,7 @@ static int stm32_rproc_mem_alloc(struct rproc *rproc,
 	void *va;
 
 	dev_dbg(dev, "map memory: %pad+%zx\n", &mem->dma, mem->len);
-	va = ioremap_wc(mem->dma, mem->len);
+	va = (__force void *)ioremap_wc(mem->dma, mem->len);
 	if (IS_ERR_OR_NULL(va)) {
 		dev_err(dev, "Unable to map memory region: %pad+0x%zx\n",
 			&mem->dma, mem->len);
@@ -137,7 +137,7 @@ static int stm32_rproc_mem_release(struct rproc *rproc,
 				   struct rproc_mem_entry *mem)
 {
 	dev_dbg(rproc->dev.parent, "unmap memory: %pa\n", &mem->dma);
-	iounmap(mem->va);
+	iounmap((__force __iomem void *)mem->va);
 
 	return 0;
 }
-- 
2.43.0


