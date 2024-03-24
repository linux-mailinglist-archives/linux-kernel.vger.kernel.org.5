Return-Path: <linux-kernel+bounces-114906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 636EF889288
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE7A29BCFC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DCB2D21E4;
	Mon, 25 Mar 2024 00:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/cb5YnT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F5527DDF1;
	Sun, 24 Mar 2024 23:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323570; cv=none; b=E4G4YAWzU3GMl79z8JrNEbwJLabo9R3nzrGjbVn1S8JrS19LfrgWGCFe7QwFw8PpThDXIwtc7fXQUdfa0z+oNaC6xVuwOt35xXPNOEMRTEXnHHm8RafxmipRb+BPL5IB24ol8vC6G4tGopaXSq98ZFuZq4sL41Ui27q9fQF3xnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323570; c=relaxed/simple;
	bh=V0KHfi5Eu26IG7zqr9NK5aqOgMsMTtmS1HPLHYXn0Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quWrqVdQLhkXC5q1wUngqdSw/Aa4mayms1yuTsGE8HhJPTFgIiTWLeYGmv9EF/rNvUSgoFv08V4LSXH+6gRIdzyY9qBohhqo3z9iKxGuUw0t/yy98tI2UOkw7laLE9NTLVrzST1qxdhyfECHpovDFXStEupB5iQh0aZzb0uRZqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/cb5YnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1871C43390;
	Sun, 24 Mar 2024 23:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323569;
	bh=V0KHfi5Eu26IG7zqr9NK5aqOgMsMTtmS1HPLHYXn0Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X/cb5YnT91XJfLpGIbZmMZP+I/xF2DL+R38bKrxfL2JjbogSb2zueSZLONwk/e2OS
	 /iYREZEI+RwgjWa1euJTN6nEspCsMnh/O8AzvHWMdbaLZMpTTUwEmSMvFUdMF45V1s
	 eDIqiq/KQ5MiadAfbe0JE+/Axr6gsOVD8WyNxIW4K7Cf24CPG+KW/pzCQ7cPFNgoZy
	 Ewl9UwhJ1Jb73SHfkXyZCQORpMKUitJkZZ9K1KEqofMHdNdChDHnAXy17IzlrxLSwK
	 K+SRxEA1hnUglofxl+EBn0DcOsJwz5HI5PxnD0/UElLifP7ONsH59d1qFU8qUQt9Eb
	 DHmpqBTYwtb6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	kernel test robot <lkp@intel.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 276/317] remoteproc: stm32: Fix incorrect type in assignment for va
Date: Sun, 24 Mar 2024 19:34:16 -0400
Message-ID: <20240324233458.1352854-277-sashal@kernel.org>
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
index 43715594bd801..e48dce98936ad 100644
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


