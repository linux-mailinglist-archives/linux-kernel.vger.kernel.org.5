Return-Path: <linux-kernel+bounces-114415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 046B4888A61
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8CFFB29AEA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EC2176A04;
	Sun, 24 Mar 2024 23:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ra433hU+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0846421AFE5;
	Sun, 24 Mar 2024 23:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321828; cv=none; b=NE+SOumho6IdzkJpRes7oeKkpqgvgeCTpj9XIET1Xe1iiOykHKDUJqZ63jsXYBa7pMeK98Ev5IJl3mL3ynRYXQxcKckxWbcRFC39iv65GO98Vg6GRdohGRBw7YvJb9bPbxHi2M9Qdu5PEhzC1VpUQA+l7MyDL4HOYHeb/iAwxWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321828; c=relaxed/simple;
	bh=gxkkXHJh6G7hXQBGcJNrYNwlOVNKzUkdQoZBt3MSqoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQygwLjlNHYpjDmJfdyIgT+qmqmJoXEizPRmWMQQzUFZwH1g2Xj2ZrEY6fEM3x/FssEj/CdAqD0AhXxbjAsyepRilVgZDTaVpBcdkdig1xBRn//uBhGyAu0fTwMEsR0L0OgHLdSPhkdAw6wxLwqsTZwcjN1L7srY265cub93LFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ra433hU+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323CEC433F1;
	Sun, 24 Mar 2024 23:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321826;
	bh=gxkkXHJh6G7hXQBGcJNrYNwlOVNKzUkdQoZBt3MSqoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ra433hU+erN2p2yCFJlo2lvfqCNDC7J4lP/mXOK5JoXmootTLl8Z/rrIW7crkJcB2
	 tSclnURBGwMbzNMUq2yd8fNzRjSz5tTvvDnhtRrNCbUJuqjVzRV2AnOiuCiLdOJDij
	 WJtMS4cBrMnQZrZIwCMmAec/92OyPo65MHNt/bNe3e/85bBu0jcX5ZhTQ6Ii0QW36A
	 smt3uEYat58JjP8h/PWxhNFbkc6cEZYS+W4VfzZ6OaL2zbybqppCUfPrg+JCmgbDbe
	 8bxyc8nmLRpv+G9saCp7AerQi/VFJg2V+EoQ0niobSN/FG1uFhKwEvaEm2aYuM9yfc
	 i/spkIFHeHJLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	kernel test robot <lkp@intel.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 555/638] remoteproc: stm32: Fix incorrect type in assignment for va
Date: Sun, 24 Mar 2024 18:59:52 -0400
Message-ID: <20240324230116.1348576-556-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 9d9b13530f78a..11bbd6018e984 100644
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


