Return-Path: <linux-kernel+bounces-101942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0884687ACEC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D431C2042B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD42E626D8;
	Wed, 13 Mar 2024 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CahHFGXW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0134350A88;
	Wed, 13 Mar 2024 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348149; cv=none; b=QA0O96Ze4HAJ3w9XWEZ4IUJbTgoVDUgo+hMT3Yk1A9Ik1BM2ziaSTh6tRKB3b2f4kWLjRlr9Gv4Dl5iocPwPjSMua95jZAS5wC46OrE61y6dUcD5FHDockIAf5av8DZv8AczsEhMwBT/KQBbvlW156csGvA687jknacCvDUOLgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348149; c=relaxed/simple;
	bh=BKKvaSPOJcIzN9AKZ4t/6eH1vXhiFpdAhQlKssnCZxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaDbcuqk+qV4sNvbXYCAgpdBswYsXb4HogOR2D97RKgbXWP5rPtGCaV4HaaVNHzBgmI8X3nTFTSFoMYHMkHt8zHEDRLcBFRkuG7BeG9rFT7uO91PDoIEL1jLP77GB0qoh5bxGtLYTv0okJJ4HvmJo7esCoXTdpjzTkmAUVoG0o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CahHFGXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F54FC43390;
	Wed, 13 Mar 2024 16:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348148;
	bh=BKKvaSPOJcIzN9AKZ4t/6eH1vXhiFpdAhQlKssnCZxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CahHFGXWtHcL18LsOZS2utOmDNW+yieTLJvMpSaT/6wqC/8HTMB1/2aTfT1FiR4dC
	 8WTku8vWfOR+xptNQ4onOoIIuwNc4l/0UbXaSIkuE09Q/fQ+KwghKln+UfoE/kFH4B
	 wYxacbZIR6/I6vYx6eDnGhVOjGJbHN8HEm+OpGGOoJDsEb8uxLMNAnWo/JVgkg+0ht
	 aZW4Myt1nzp3aWeVEw7h8sNmolv8THsCYC2aYfdYrG7PNVlwwVoq5tHXJUSYSMgRO8
	 jbwllfsFWUsdY36BRpqhICZHfXUDCbCaKxMXPgEoaGWhW0LqfqPcF8o13bAn5vrb3L
	 xGesmZuznfTcQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe Kerello <christophe.kerello@foss.st.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 02/76] mmc: mmci: stm32: fix DMA API overlapping mappings warning
Date: Wed, 13 Mar 2024 12:41:09 -0400
Message-ID: <20240313164223.615640-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christophe Kerello <christophe.kerello@foss.st.com>

[ Upstream commit 6b1ba3f9040be5efc4396d86c9752cdc564730be ]

Turning on CONFIG_DMA_API_DEBUG_SG results in the following warning:

DMA-API: mmci-pl18x 48220000.mmc: cacheline tracking EEXIST,
overlapping mappings aren't supported
WARNING: CPU: 1 PID: 51 at kernel/dma/debug.c:568
add_dma_entry+0x234/0x2f4
Modules linked in:
CPU: 1 PID: 51 Comm: kworker/1:2 Not tainted 6.1.28 #1
Hardware name: STMicroelectronics STM32MP257F-EV1 Evaluation Board (DT)
Workqueue: events_freezable mmc_rescan
Call trace:
add_dma_entry+0x234/0x2f4
debug_dma_map_sg+0x198/0x350
__dma_map_sg_attrs+0xa0/0x110
dma_map_sg_attrs+0x10/0x2c
sdmmc_idma_prep_data+0x80/0xc0
mmci_prep_data+0x38/0x84
mmci_start_data+0x108/0x2dc
mmci_request+0xe4/0x190
__mmc_start_request+0x68/0x140
mmc_start_request+0x94/0xc0
mmc_wait_for_req+0x70/0x100
mmc_send_tuning+0x108/0x1ac
sdmmc_execute_tuning+0x14c/0x210
mmc_execute_tuning+0x48/0xec
mmc_sd_init_uhs_card.part.0+0x208/0x464
mmc_sd_init_card+0x318/0x89c
mmc_attach_sd+0xe4/0x180
mmc_rescan+0x244/0x320

DMA API debug brings to light leaking dma-mappings as dma_map_sg and
dma_unmap_sg are not correctly balanced.

If an error occurs in mmci_cmd_irq function, only mmci_dma_error
function is called and as this API is not managed on stm32 variant,
dma_unmap_sg is never called in this error path.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
Fixes: 46b723dd867d ("mmc: mmci: add stm32 sdmmc variant")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240207143951.938144-1-christophe.kerello@foss.st.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/mmci_stm32_sdmmc.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index 11ae0cb479239..e3201a621870a 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -200,6 +200,8 @@ static int sdmmc_idma_start(struct mmci_host *host, unsigned int *datactrl)
 	struct scatterlist *sg;
 	int i;
 
+	host->dma_in_progress = true;
+
 	if (!host->variant->dma_lli || data->sg_len == 1 ||
 	    idma->use_bounce_buffer) {
 		u32 dma_addr;
@@ -238,9 +240,30 @@ static int sdmmc_idma_start(struct mmci_host *host, unsigned int *datactrl)
 	return 0;
 }
 
+static void sdmmc_idma_error(struct mmci_host *host)
+{
+	struct mmc_data *data = host->data;
+	struct sdmmc_idma *idma = host->dma_priv;
+
+	if (!dma_inprogress(host))
+		return;
+
+	writel_relaxed(0, host->base + MMCI_STM32_IDMACTRLR);
+	host->dma_in_progress = false;
+	data->host_cookie = 0;
+
+	if (!idma->use_bounce_buffer)
+		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+			     mmc_get_dma_dir(data));
+}
+
 static void sdmmc_idma_finalize(struct mmci_host *host, struct mmc_data *data)
 {
+	if (!dma_inprogress(host))
+		return;
+
 	writel_relaxed(0, host->base + MMCI_STM32_IDMACTRLR);
+	host->dma_in_progress = false;
 
 	if (!data->host_cookie)
 		sdmmc_idma_unprep_data(host, data, 0);
@@ -566,6 +589,7 @@ static struct mmci_host_ops sdmmc_variant_ops = {
 	.dma_setup = sdmmc_idma_setup,
 	.dma_start = sdmmc_idma_start,
 	.dma_finalize = sdmmc_idma_finalize,
+	.dma_error = sdmmc_idma_error,
 	.set_clkreg = mmci_sdmmc_set_clkreg,
 	.set_pwrreg = mmci_sdmmc_set_pwrreg,
 	.busy_complete = sdmmc_busy_complete,
-- 
2.43.0


