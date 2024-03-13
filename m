Return-Path: <linux-kernel+bounces-102025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C36487ADB5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06089281084
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB38465BBD;
	Wed, 13 Mar 2024 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOvDcFll"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23CA55C2A;
	Wed, 13 Mar 2024 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348405; cv=none; b=qNxgfVzgc/IIH9w6xHro0aQxtQNXUbk1jp0x0u8wcXjwkdFCRygOxnbHf+tdo2I18G+uh8beozOwe5nd0S/1O5m0Cu26l1pnSPJsvPmO9hKqLXNK2gfO9FG+lXlcJmD7CQeQdak2Zpgbj8fMF3QUmL46tpPJFqMKLQvVo0RGdkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348405; c=relaxed/simple;
	bh=IdN3gYeyWAVlGPzwpeyM5dTBSOISdvZ318vw8Bk+/9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmRYdHyFVevk+EFi5mMIWELidaq9QsSIJ74Hznz94MmauBI7Dqtw9ZWGZfykdfgh+nI9puthJTMh3Ha+1TR/BYf/oTgocFLmiAiOWSVVStnANQuAZpSXJlpuFrsfyXL3NWeidEnlSJbzuwnOSYcjvsTVvB/mi6rrIAJtclO7ZZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOvDcFll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB5AC433F1;
	Wed, 13 Mar 2024 16:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348404;
	bh=IdN3gYeyWAVlGPzwpeyM5dTBSOISdvZ318vw8Bk+/9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TOvDcFllyPZAcFhdLE9F8bol1gzsuIoKSKp6To1SY4Ye6fARhMPvEgYlVBsetaCqn
	 jzE8ARLm59mJG/lOcqOqUgYSa/2Nm4fnt/qWo3ans0nSHa080JyXastjxWSRQeF5yi
	 t3jZEvscQbReREMo3sIyv640ZE9CRUkS1iJFJ0XAQwrcIjOU5UmHHl0+n/5hQ1ACiL
	 mTMjv/nhvsmBohkBRg1LwmAvXRFdmjQydeC6kq2d4hT+k8XDAp1xavmeX96JaW/mF0
	 KiOoHxKVBaPtaaz+jR3uK2Lao+A0ABdjg01YJMzJkZFMsUvKeFkUe8esAUiSPDk67R
	 RbeA6PWODNwDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yann Gautier <yann.gautier@foss.st.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 01/73] mmc: mmci: stm32: use a buffer for unaligned DMA requests
Date: Wed, 13 Mar 2024 12:45:28 -0400
Message-ID: <20240313164640.616049-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Yann Gautier <yann.gautier@foss.st.com>

[ Upstream commit 970dc9c11a17994ab878016b536612ab00d1441d ]

In SDIO mode, the sg list for requests can be unaligned with what the
STM32 SDMMC internal DMA can support. In that case, instead of failing,
use a temporary bounce buffer to copy from/to the sg list.
This buffer is limited to 1MB. But for that we need to also limit
max_req_size to 1MB. It has not shown any throughput penalties for
SD-cards or eMMC.

Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
Link: https://lore.kernel.org/r/20220328145114.334577-1-yann.gautier@foss.st.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Stable-dep-of: 6b1ba3f9040b ("mmc: mmci: stm32: fix DMA API overlapping mappings warning")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/mmci_stm32_sdmmc.c | 88 +++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index 4cceb9bab0361..11ae0cb479239 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -43,6 +43,9 @@ struct sdmmc_lli_desc {
 struct sdmmc_idma {
 	dma_addr_t sg_dma;
 	void *sg_cpu;
+	dma_addr_t bounce_dma_addr;
+	void *bounce_buf;
+	bool use_bounce_buffer;
 };
 
 struct sdmmc_dlyb {
@@ -54,6 +57,8 @@ struct sdmmc_dlyb {
 static int sdmmc_idma_validate_data(struct mmci_host *host,
 				    struct mmc_data *data)
 {
+	struct sdmmc_idma *idma = host->dma_priv;
+	struct device *dev = mmc_dev(host->mmc);
 	struct scatterlist *sg;
 	int i;
 
@@ -61,41 +66,69 @@ static int sdmmc_idma_validate_data(struct mmci_host *host,
 	 * idma has constraints on idmabase & idmasize for each element
 	 * excepted the last element which has no constraint on idmasize
 	 */
+	idma->use_bounce_buffer = false;
 	for_each_sg(data->sg, sg, data->sg_len - 1, i) {
 		if (!IS_ALIGNED(sg->offset, sizeof(u32)) ||
 		    !IS_ALIGNED(sg->length, SDMMC_IDMA_BURST)) {
-			dev_err(mmc_dev(host->mmc),
+			dev_dbg(mmc_dev(host->mmc),
 				"unaligned scatterlist: ofst:%x length:%d\n",
 				data->sg->offset, data->sg->length);
-			return -EINVAL;
+			goto use_bounce_buffer;
 		}
 	}
 
 	if (!IS_ALIGNED(sg->offset, sizeof(u32))) {
-		dev_err(mmc_dev(host->mmc),
+		dev_dbg(mmc_dev(host->mmc),
 			"unaligned last scatterlist: ofst:%x length:%d\n",
 			data->sg->offset, data->sg->length);
-		return -EINVAL;
+		goto use_bounce_buffer;
 	}
 
+	return 0;
+
+use_bounce_buffer:
+	if (!idma->bounce_buf) {
+		idma->bounce_buf = dmam_alloc_coherent(dev,
+						       host->mmc->max_req_size,
+						       &idma->bounce_dma_addr,
+						       GFP_KERNEL);
+		if (!idma->bounce_buf) {
+			dev_err(dev, "Unable to map allocate DMA bounce buffer.\n");
+			return -ENOMEM;
+		}
+	}
+
+	idma->use_bounce_buffer = true;
+
 	return 0;
 }
 
 static int _sdmmc_idma_prep_data(struct mmci_host *host,
 				 struct mmc_data *data)
 {
-	int n_elem;
+	struct sdmmc_idma *idma = host->dma_priv;
 
-	n_elem = dma_map_sg(mmc_dev(host->mmc),
-			    data->sg,
-			    data->sg_len,
-			    mmc_get_dma_dir(data));
+	if (idma->use_bounce_buffer) {
+		if (data->flags & MMC_DATA_WRITE) {
+			unsigned int xfer_bytes = data->blksz * data->blocks;
 
-	if (!n_elem) {
-		dev_err(mmc_dev(host->mmc), "dma_map_sg failed\n");
-		return -EINVAL;
-	}
+			sg_copy_to_buffer(data->sg, data->sg_len,
+					  idma->bounce_buf, xfer_bytes);
+			dma_wmb();
+		}
+	} else {
+		int n_elem;
+
+		n_elem = dma_map_sg(mmc_dev(host->mmc),
+				    data->sg,
+				    data->sg_len,
+				    mmc_get_dma_dir(data));
 
+		if (!n_elem) {
+			dev_err(mmc_dev(host->mmc), "dma_map_sg failed\n");
+			return -EINVAL;
+		}
+	}
 	return 0;
 }
 
@@ -112,8 +145,19 @@ static int sdmmc_idma_prep_data(struct mmci_host *host,
 static void sdmmc_idma_unprep_data(struct mmci_host *host,
 				   struct mmc_data *data, int err)
 {
-	dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
-		     mmc_get_dma_dir(data));
+	struct sdmmc_idma *idma = host->dma_priv;
+
+	if (idma->use_bounce_buffer) {
+		if (data->flags & MMC_DATA_READ) {
+			unsigned int xfer_bytes = data->blksz * data->blocks;
+
+			sg_copy_from_buffer(data->sg, data->sg_len,
+					    idma->bounce_buf, xfer_bytes);
+		}
+	} else {
+		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+			     mmc_get_dma_dir(data));
+	}
 }
 
 static int sdmmc_idma_setup(struct mmci_host *host)
@@ -137,6 +181,8 @@ static int sdmmc_idma_setup(struct mmci_host *host)
 		host->mmc->max_segs = SDMMC_LLI_BUF_LEN /
 			sizeof(struct sdmmc_lli_desc);
 		host->mmc->max_seg_size = host->variant->stm32_idmabsize_mask;
+
+		host->mmc->max_req_size = SZ_1M;
 	} else {
 		host->mmc->max_segs = 1;
 		host->mmc->max_seg_size = host->mmc->max_req_size;
@@ -154,8 +200,16 @@ static int sdmmc_idma_start(struct mmci_host *host, unsigned int *datactrl)
 	struct scatterlist *sg;
 	int i;
 
-	if (!host->variant->dma_lli || data->sg_len == 1) {
-		writel_relaxed(sg_dma_address(data->sg),
+	if (!host->variant->dma_lli || data->sg_len == 1 ||
+	    idma->use_bounce_buffer) {
+		u32 dma_addr;
+
+		if (idma->use_bounce_buffer)
+			dma_addr = idma->bounce_dma_addr;
+		else
+			dma_addr = sg_dma_address(data->sg);
+
+		writel_relaxed(dma_addr,
 			       host->base + MMCI_STM32_IDMABASE0R);
 		writel_relaxed(MMCI_STM32_IDMAEN,
 			       host->base + MMCI_STM32_IDMACTRLR);
-- 
2.43.0


