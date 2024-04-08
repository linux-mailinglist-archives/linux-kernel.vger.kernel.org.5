Return-Path: <linux-kernel+bounces-134704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 095C089B5C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B65A1C209DE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF5A4C63;
	Mon,  8 Apr 2024 01:59:46 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6724685;
	Mon,  8 Apr 2024 01:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712541585; cv=none; b=EQmnlmK1ataAEW8Km/qlUdoZ4saTKAxMj+63JzbWGEYBL0P1SCljjTqJHztSZ8zylg72IzVJPex79J+/lGIvRL9aHmyZfd11rZQ+1mr/Txxm8NKPNX6yGR17QCTc6MLmv9x20t6SinaUIymGiIBx9hWg7uqtcj+dGCamJbwzGGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712541585; c=relaxed/simple;
	bh=sli3/TCFWRGVSpVR5wJVjxZdHOFloeqWexzt3SqrmLk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tHd/cNk0JLk+fhESt3LinMFGh8GUj4T5MGNCxLLXivDI4QUUxVjwXUdCBK7FF/SWZHLqOu3dbdX6+Q4tTYSS+irusY9Z36UHmrTY955HwDVeTqlEa8r1Qzn+ZDEcjtkenux8LSL6d/NJJGdbH3hqCtM0D9/JG+Xmz8OoPAgp0YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAB3HRB5TxNm0lQgAg--.10496S2;
	Mon, 08 Apr 2024 09:59:22 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: bbrezillon@kernel.org,
	arno@natisbad.org,
	schalla@marvell.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] crypto: octeontx2 - add missing check for dma_map_single
Date: Mon,  8 Apr 2024 01:59:14 +0000
Message-Id: <20240408015914.101442-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3HRB5TxNm0lQgAg--.10496S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1UWF4UJF13KFW8Zry7KFg_yoWftFb_Cr
	ZrCr17Xr1rWanFya1jvrWvqr95u34FqrWqqrs7t343KFyjvanrury2qF98A3yxWw4FgFyD
	Ar4xCrWSyr12qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbz8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Add check for dma_map_single() and return error if it fails in order
to avoid invalid dma address.

Fixes: e92971117c2c ("crypto: octeontx2 - add ctx_val workaround")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/crypto/marvell/octeontx2/cn10k_cpt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/marvell/octeontx2/cn10k_cpt.c b/drivers/crypto/marvell/octeontx2/cn10k_cpt.c
index 79b4e74804f6..6bfc59e67747 100644
--- a/drivers/crypto/marvell/octeontx2/cn10k_cpt.c
+++ b/drivers/crypto/marvell/octeontx2/cn10k_cpt.c
@@ -138,6 +138,10 @@ int cn10k_cpt_hw_ctx_init(struct pci_dev *pdev,
 		return -ENOMEM;
 	cptr_dma = dma_map_single(&pdev->dev, hctx, CN10K_CPT_HW_CTX_SIZE,
 				  DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(&pdev->dev, cptr_dma)) {
+		kfree(hctx);
+		return -ENOMEM;
+	}
 
 	cn10k_cpt_hw_ctx_set(hctx, 1);
 	er_ctx->hw_ctx = hctx;
-- 
2.25.1


