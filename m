Return-Path: <linux-kernel+bounces-115046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B22B888CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2411C2A441
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917AE2EE7CF;
	Mon, 25 Mar 2024 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZbqh28v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15082853EF;
	Sun, 24 Mar 2024 23:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323829; cv=none; b=UYNv8i1bV7z92Eumg4nvlvZCy+X5Tt/kdqyqZWPMfTgydq7USjWF15uKGVpMHwyBr6XwTToKTwUZ1791WGHk6QMJqiQfa6zDy3Ea0IeROWSfgMrvbUQnFbgCX39cZuRsKrQ6FVa9jvfVWkgnRf3Qydp5v5pFDsVVrTRM/wlVlMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323829; c=relaxed/simple;
	bh=CX/s0lG8wv92EBpeE2scDwH0eIWJbUMNS7rOrrAQdI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+e82Zi4G5RxDXu4LgUVVXQLItrNzUS3RnERxZZNcFzdS4VVGNmEJ1VVNWd0IfddD+A2k5Znk6GrRg4561cfZBPo5gg+BlqoS7Q6O0bhRS4PNUrU6M9XbqHqCpHzwxPxkpV1yWmBTivBQdxr3ekPV8Ky/R9P6+MEUPlai8n/Bnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZbqh28v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E5FC43390;
	Sun, 24 Mar 2024 23:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323827;
	bh=CX/s0lG8wv92EBpeE2scDwH0eIWJbUMNS7rOrrAQdI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JZbqh28v6rv4YCrJB4frPZrTgNNowswju7dF1jzp88GMnUFJG0MjhujvZ43kTiuFe
	 nd1KE1EQWRh/6ILf9F8VooS+ZQ4j0vkIk7E6GhXaihHZdK3MhFwRfKCXqR4BNlpG4+
	 /EaEqGSpPXKGB7msqy/q37AdAtOSdbzh30WujcOuyh7M7XdXDZcGi4pCS+4cz+2rEP
	 h4jQok0iu0LiLtv9Qxf1Ovi1sFkRyw/xAaAuMfsWmlZ1gG6yYVSKGUObI7Db39wmvn
	 QGxbiX8hxhQJm/Q+dbQ2nX4tAD0A89At+bq0ALujuXruziT6cwVR599OPJQYyUdZs2
	 Suk2a9y83ATtA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Arnaud Pouliquen <arnaud.pouliquen@st.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 206/238] remoteproc: stm32: Move resource table setup to rproc_ops
Date: Sun, 24 Mar 2024 19:39:54 -0400
Message-ID: <20240324234027.1354210-207-sashal@kernel.org>
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

From: Mathieu Poirier <mathieu.poirier@linaro.org>

[ Upstream commit 8a471396d21ca499d89d4071b2b670258f009ffa ]

Move the setting of the resource table installed by an external
entity to rproc_ops::get_loaded_rsc_table().  This is to support
scenarios where a remote processor has been attached to but is
detached at a later stage.  To re-attach the remote processor,
the address of the resource table needs to be available
at a later time than the platform driver's probe() function.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Link: https://lore.kernel.org/r/20210312162453.1234145-7-mathieu.poirier@linaro.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Stable-dep-of: 32381bbccba4 ("remoteproc: stm32: Fix incorrect type in assignment for va")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/stm32_rproc.c | 141 +++++++++++++++----------------
 1 file changed, 68 insertions(+), 73 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 5f12553f0b6d7..b410684c3aa90 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -553,6 +553,73 @@ static void stm32_rproc_kick(struct rproc *rproc, int vqid)
 	}
 }
 
+static int stm32_rproc_da_to_pa(struct rproc *rproc,
+				u64 da, phys_addr_t *pa)
+{
+	struct stm32_rproc *ddata = rproc->priv;
+	struct device *dev = rproc->dev.parent;
+	struct stm32_rproc_mem *p_mem;
+	unsigned int i;
+
+	for (i = 0; i < ddata->nb_rmems; i++) {
+		p_mem = &ddata->rmems[i];
+
+		if (da < p_mem->dev_addr ||
+		    da >= p_mem->dev_addr + p_mem->size)
+			continue;
+
+		*pa = da - p_mem->dev_addr + p_mem->bus_addr;
+		dev_dbg(dev, "da %llx to pa %#x\n", da, *pa);
+
+		return 0;
+	}
+
+	dev_err(dev, "can't translate da %llx\n", da);
+
+	return -EINVAL;
+}
+
+static struct resource_table *
+stm32_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
+{
+	struct stm32_rproc *ddata = rproc->priv;
+	struct device *dev = rproc->dev.parent;
+	phys_addr_t rsc_pa;
+	u32 rsc_da;
+	int err;
+
+	/* The resource table has already been mapped, nothing to do */
+	if (ddata->rsc_va)
+		goto done;
+
+	err = regmap_read(ddata->rsctbl.map, ddata->rsctbl.reg, &rsc_da);
+	if (err) {
+		dev_err(dev, "failed to read rsc tbl addr\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (!rsc_da)
+		/* no rsc table */
+		return ERR_PTR(-ENOENT);
+
+	err = stm32_rproc_da_to_pa(rproc, rsc_da, &rsc_pa);
+	if (err)
+		return ERR_PTR(err);
+
+	ddata->rsc_va = devm_ioremap_wc(dev, rsc_pa, RSC_TBL_SIZE);
+	if (IS_ERR_OR_NULL(ddata->rsc_va)) {
+		dev_err(dev, "Unable to map memory region: %pa+%zx\n",
+			&rsc_pa, RSC_TBL_SIZE);
+		ddata->rsc_va = NULL;
+		return ERR_PTR(-ENOMEM);
+	}
+
+done:
+	/* Assuming the resource table fits in 1kB is fair */
+	*table_sz = RSC_TBL_SIZE;
+	return (struct resource_table *)ddata->rsc_va;
+}
+
 static const struct rproc_ops st_rproc_ops = {
 	.start		= stm32_rproc_start,
 	.stop		= stm32_rproc_stop,
@@ -561,6 +628,7 @@ static const struct rproc_ops st_rproc_ops = {
 	.load		= rproc_elf_load_segments,
 	.parse_fw	= stm32_rproc_parse_fw,
 	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
+	.get_loaded_rsc_table = stm32_rproc_get_loaded_rsc_table,
 	.sanity_check	= rproc_elf_sanity_check,
 	.get_boot_addr	= rproc_elf_get_boot_addr,
 };
@@ -704,75 +772,6 @@ static int stm32_rproc_get_m4_status(struct stm32_rproc *ddata,
 	return regmap_read(ddata->m4_state.map, ddata->m4_state.reg, state);
 }
 
-static int stm32_rproc_da_to_pa(struct platform_device *pdev,
-				struct stm32_rproc *ddata,
-				u64 da, phys_addr_t *pa)
-{
-	struct device *dev = &pdev->dev;
-	struct stm32_rproc_mem *p_mem;
-	unsigned int i;
-
-	for (i = 0; i < ddata->nb_rmems; i++) {
-		p_mem = &ddata->rmems[i];
-
-		if (da < p_mem->dev_addr ||
-		    da >= p_mem->dev_addr + p_mem->size)
-			continue;
-
-		*pa = da - p_mem->dev_addr + p_mem->bus_addr;
-		dev_dbg(dev, "da %llx to pa %#x\n", da, *pa);
-
-		return 0;
-	}
-
-	dev_err(dev, "can't translate da %llx\n", da);
-
-	return -EINVAL;
-}
-
-static int stm32_rproc_get_loaded_rsc_table(struct platform_device *pdev,
-					    struct rproc *rproc,
-					    struct stm32_rproc *ddata)
-{
-	struct device *dev = &pdev->dev;
-	phys_addr_t rsc_pa;
-	u32 rsc_da;
-	int err;
-
-	err = regmap_read(ddata->rsctbl.map, ddata->rsctbl.reg, &rsc_da);
-	if (err) {
-		dev_err(dev, "failed to read rsc tbl addr\n");
-		return err;
-	}
-
-	if (!rsc_da)
-		/* no rsc table */
-		return 0;
-
-	err = stm32_rproc_da_to_pa(pdev, ddata, rsc_da, &rsc_pa);
-	if (err)
-		return err;
-
-	ddata->rsc_va = devm_ioremap_wc(dev, rsc_pa, RSC_TBL_SIZE);
-	if (IS_ERR_OR_NULL(ddata->rsc_va)) {
-		dev_err(dev, "Unable to map memory region: %pa+%zx\n",
-			&rsc_pa, RSC_TBL_SIZE);
-		ddata->rsc_va = NULL;
-		return -ENOMEM;
-	}
-
-	/*
-	 * The resource table is already loaded in device memory, no need
-	 * to work with a cached table.
-	 */
-	rproc->cached_table = NULL;
-	/* Assuming the resource table fits in 1kB is fair */
-	rproc->table_sz = RSC_TBL_SIZE;
-	rproc->table_ptr = (struct resource_table *)ddata->rsc_va;
-
-	return 0;
-}
-
 static int stm32_rproc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -812,10 +811,6 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 		ret = stm32_rproc_parse_memory_regions(rproc);
 		if (ret)
 			goto free_resources;
-
-		ret = stm32_rproc_get_loaded_rsc_table(pdev, rproc, ddata);
-		if (ret)
-			goto free_resources;
 	}
 
 	rproc->has_iommu = false;
-- 
2.43.0


