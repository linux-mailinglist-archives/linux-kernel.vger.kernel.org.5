Return-Path: <linux-kernel+bounces-101805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFC087ABC3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445E31F21386
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C09E59172;
	Wed, 13 Mar 2024 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJC7F8wm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B5458220;
	Wed, 13 Mar 2024 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347833; cv=none; b=qTBoqM74pFeuNyGMR6j10Hmnzlxuws4lIbWSaEusRNaw2qHGJeYig3FQJ8LnBGc77jOQrro/8359+HuDUeTOMeiqq6UeePpetkVFJ7VE85gGD2llRPs6zMjNTqRka3FICCaYJPL103XSsJ5wQucQizH73s2IUf0V3XLrpveFXzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347833; c=relaxed/simple;
	bh=cYwC/rXHv4uHOBT++iBoy6tpNjqK9Q56Irz9oNi4o/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pwxe4vNd0Wir/6cnlbThewsdIg7KW1sbdBaVEHTL9tt0+kKG6hcEWHBL84wQCthqdF9fnXkP7dcTaanM1bqqCKjRCJVXP4eTDh9fpd97aQTyjS8XYK9WLEw6ElB6ml+ejSbJxf50b4mxl7Iiu0FXCr0q2N/DYvEi8rHidHx9wgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJC7F8wm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDE2C433C7;
	Wed, 13 Mar 2024 16:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347833;
	bh=cYwC/rXHv4uHOBT++iBoy6tpNjqK9Q56Irz9oNi4o/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BJC7F8wmntK191Dv387edDJdkhpbpxR7d5AH7uQJKkdsZKO+zJTVL+oGy1oedcwEl
	 lOd740SvnpMq6biy2YjCcsGLnjZQxwtENm/kCbj0SPvrGaNAcC+izf5qeA1NAey19M
	 7CW00uTnLXhCp2GTaPAoFwXB21deon+yT8P7a+I2Pkh/dJLwcIg4HhbyT6x71QQ95g
	 LOllZXUrXISRFwN69kBxBVOPhvdnsFhShgxRFyt/jrF7BMo2Od6NwRMXgsjrZ4tvx5
	 DCrHqxCJ1CgvKjAn7IXfpokUmzEf0Nis6RbzWmMI6pg7nupmcIZwEVTdE1fhFeKBF4
	 b9iVXMOCTV36w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 03/60] dmaengine: fsl-edma: correct max_segment_size setting
Date: Wed, 13 Mar 2024 12:36:10 -0400
Message-ID: <20240313163707.615000-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

[ Upstream commit a79f949a5ce1d45329d63742c2a995f2b47f9852 ]

Correcting the previous setting of 0x3fff to the actual value of 0x7fff.

Introduced new macro 'EDMA_TCD_ITER_MASK' for improved code clarity and
utilization of FIELD_GET to obtain the accurate maximum value.

Cc: stable@vger.kernel.org
Fixes: e06748539432 ("dmaengine: fsl-edma: support edma memcpy")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20240207194733.2112870-1-Frank.Li@nxp.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/fsl-edma-common.h | 5 +++--
 drivers/dma/fsl-edma-main.c   | 4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 40d50cc3d75a3..92fe53faa53b1 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -30,8 +30,9 @@
 #define EDMA_TCD_ATTR_SSIZE(x)		(((x) & GENMASK(2, 0)) << 8)
 #define EDMA_TCD_ATTR_SMOD(x)		(((x) & GENMASK(4, 0)) << 11)
 
-#define EDMA_TCD_CITER_CITER(x)		((x) & GENMASK(14, 0))
-#define EDMA_TCD_BITER_BITER(x)		((x) & GENMASK(14, 0))
+#define EDMA_TCD_ITER_MASK		GENMASK(14, 0)
+#define EDMA_TCD_CITER_CITER(x)		((x) & EDMA_TCD_ITER_MASK)
+#define EDMA_TCD_BITER_BITER(x)		((x) & EDMA_TCD_ITER_MASK)
 
 #define EDMA_TCD_CSR_START		BIT(0)
 #define EDMA_TCD_CSR_INT_MAJOR		BIT(1)
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index a56c8a0f2663f..42a338cbe6143 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -10,6 +10,7 @@
  */
 
 #include <dt-bindings/dma/fsl-edma.h>
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
@@ -589,7 +590,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
 					DMAENGINE_ALIGN_32_BYTES;
 
 	/* Per worst case 'nbytes = 1' take CITER as the max_seg_size */
-	dma_set_max_seg_size(fsl_edma->dma_dev.dev, 0x3fff);
+	dma_set_max_seg_size(fsl_edma->dma_dev.dev,
+			     FIELD_GET(EDMA_TCD_ITER_MASK, EDMA_TCD_ITER_MASK));
 
 	fsl_edma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
 
-- 
2.43.0


