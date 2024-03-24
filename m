Return-Path: <linux-kernel+bounces-114661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFD3888B9D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA6F1C29754
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43FE18AC7A;
	Sun, 24 Mar 2024 23:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ib70hQAz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EF0236CF9;
	Sun, 24 Mar 2024 23:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322306; cv=none; b=IpMFtWWNKuY+HG2oZW62vciE6Q1W61Cxkbr+zLadm58TdGO5SuSZkKoZf4PNhTzzf4HoaBgiScC5a1WNA3OXLaMrgpsHS77hOns2g/YejbkJ9uby1tJFeZL/2eHBf+g9cED3qN7cr+606UOpCWIc7yY83GvA3MNgxB9gzfO4ewk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322306; c=relaxed/simple;
	bh=3eHSTzGY+volY8I/DIfRwdW3njJqTlBMcRH+oJB3T0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mldvClSNfsFyMUBdiR2otvK1QycHPpxQ3WSmo73S3YYQeAJZ5Ll8hfO4eaUTPSX24XsIQ9YrocqONi9JWyq+sLffNB8InXAmEU11gfNxY8XU/FoiTeFJUQ3Jb3jWDEAhhjFCNcq/hDaa7nGk5KycUAYNm2D5Q5ClqoypnUIFd+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ib70hQAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A416C43394;
	Sun, 24 Mar 2024 23:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322304;
	bh=3eHSTzGY+volY8I/DIfRwdW3njJqTlBMcRH+oJB3T0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ib70hQAz8zve4ew/I7pbh4zY1OglY2Kxx5f1p9u/wrnRk8eZGj+sujza6oVCmjgsJ
	 ONfuXN6q1bdPoNuOQ47umnhMhrPOsRsPwD/QfDg1IVMX1XbjIvr2uUvR+gjvVvuQam
	 Iw8vi8aa5g6RVUvQysf5c6g27KfqJS5YUUgscGJCj4xQwAg1IV2CUaRx8Npmj6IUI9
	 ++Pj1C5Opw2QIkI+QwImBvcuGHIxx04TugguBlIx3Q6jV/mIgTen6UXR2o8dLt4IIc
	 mvOOAfHEunhJBRO2LOlR+X+2MQmZNf+N2NlPt3iqDVdy5aOAy7zO1wqrfyNdSG1Leb
	 wEtOeWmybxV/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	kernel test robot <lkp@intel.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 387/451] remoteproc: stm32: Fix incorrect type in assignment for va
Date: Sun, 24 Mar 2024 19:11:03 -0400
Message-ID: <20240324231207.1351418-388-sashal@kernel.org>
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
index e432febf4337b..722cf1cdc2cb0 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -119,7 +119,7 @@ static int stm32_rproc_mem_alloc(struct rproc *rproc,
 	void *va;
 
 	dev_dbg(dev, "map memory: %pad+%zx\n", &mem->dma, mem->len);
-	va = ioremap_wc(mem->dma, mem->len);
+	va = (__force void *)ioremap_wc(mem->dma, mem->len);
 	if (IS_ERR_OR_NULL(va)) {
 		dev_err(dev, "Unable to map memory region: %pad+0x%zx\n",
 			&mem->dma, mem->len);
@@ -136,7 +136,7 @@ static int stm32_rproc_mem_release(struct rproc *rproc,
 				   struct rproc_mem_entry *mem)
 {
 	dev_dbg(rproc->dev.parent, "unmap memory: %pa\n", &mem->dma);
-	iounmap(mem->va);
+	iounmap((__force __iomem void *)mem->va);
 
 	return 0;
 }
-- 
2.43.0


