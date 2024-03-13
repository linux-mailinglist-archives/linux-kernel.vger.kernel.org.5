Return-Path: <linux-kernel+bounces-101746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B5187AB3C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493B7288982
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAAB56776;
	Wed, 13 Mar 2024 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hz5hC/2r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8CF54BD8;
	Wed, 13 Mar 2024 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347567; cv=none; b=o+CVKJSKzZUp9b92FgeXN1oOwxet4LZ/flce5yM65SMG6swH36UlnlE+ED4UQd3VKpcQKQVk4SbVZOQtdUnDkb7aXFkXlFH7vaUvxPtSlwhL7ly1dt/DmT6XIokv6d2WHfDErqv5nj09+tQnYYGiX82ArwioOI1GOTzsxuY4sTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347567; c=relaxed/simple;
	bh=uk8EonCCvo7+0ACu2qHibduu73/AKi1DIPizZev0nR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZSVP4L1z6KAvC1pBDMoENRbB3sVkX+tAk5PxVgV/MkGDhbDh/NumG7Sin4OkLGs+9WbRJ6pSVy63buFpgxOLoChVBsLni58b1CS0z9KeP7wiFDsIRQdozBYk9juMcrUiAluX9g3s84l66Fw6ONjSkMEnclxPG6jmTYgQa/glB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hz5hC/2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA97AC433C7;
	Wed, 13 Mar 2024 16:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347567;
	bh=uk8EonCCvo7+0ACu2qHibduu73/AKi1DIPizZev0nR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hz5hC/2rv/iSFQITstTxsdKCOcUVvsNoLTkPvzPqbccNSsQveowDNKCx0XJ7BX8hJ
	 D8+x/3t71HKKuEuSUc7Ve13M1l2qJMWFmGBHjkvmddg7Cdb2NVfDP/JNfr3YqD1ftV
	 zm2QYLjpi+dujV300RjVtRH3HgwyFfiFOmXsNoLL2ux0yQH3yeu+T18PDYsHXIqd9o
	 i0zMscBzSu7NaDxmculLGqBg1EZt82Z0V3DShf63Y9lpG581M4gnE9Pga9mmHs9b59
	 PtV6SFfzQ1CnlUioK3FsXnQQsr/ZC52Etbo8ImtLSdJnJD45CmhoPt8RxbT3rdkCIA
	 r2aiu8+8doo/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 07/61] dmaengine: fsl-edma: correct max_segment_size setting
Date: Wed, 13 Mar 2024 12:31:42 -0400
Message-ID: <20240313163236.613880-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
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
index bb5221158a770..f5e216b157c75 100644
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
index 45cc419b1b4ac..d36e28b9c767a 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -10,6 +10,7 @@
  */
 
 #include <dt-bindings/dma/fsl-edma.h>
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
@@ -582,7 +583,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
 					DMAENGINE_ALIGN_32_BYTES;
 
 	/* Per worst case 'nbytes = 1' take CITER as the max_seg_size */
-	dma_set_max_seg_size(fsl_edma->dma_dev.dev, 0x3fff);
+	dma_set_max_seg_size(fsl_edma->dma_dev.dev,
+			     FIELD_GET(EDMA_TCD_ITER_MASK, EDMA_TCD_ITER_MASK));
 
 	fsl_edma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
 
-- 
2.43.0


