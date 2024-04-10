Return-Path: <linux-kernel+bounces-139001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 212A989FD58
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34A2CB259DC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD01C17B502;
	Wed, 10 Apr 2024 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRjlNMBW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F165953361;
	Wed, 10 Apr 2024 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767276; cv=none; b=FxIJJ85kPDMfM0Ny+AGndHMFPZ3be9BvUddHJEouekAT49asdf0/AOr6CDQyinUBygC5bvbuXPF/uwttjfeshQp/yZUBCGouhfM/qcM1fl7nSXdSbsKVEWbBnvuPAkWWK7PoRjvY+u98sP+OAN1lK87w1C1mTUZs48KB0utApAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767276; c=relaxed/simple;
	bh=UaluD4a0SUmWueDVbNI4ShgReWWH+xE4Os/5Mmqe5rY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IcPIyjEKZwzg7SXs+OKyBQPkEZwgjItFTTFDFguE7dMEZPQy8NYbgxNNeqj+4Yr7Vp07+tbko0APlUrSEsj9UB1xs2BDoJkMLPdz/M05eOQuxkAQMd5O+L4P0pkj+PjscJZuZa79+MlLwZWYv+wxcONAo6jPQLS4UUdi/+9SWKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRjlNMBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A653C433F1;
	Wed, 10 Apr 2024 16:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712767275;
	bh=UaluD4a0SUmWueDVbNI4ShgReWWH+xE4Os/5Mmqe5rY=;
	h=From:To:Cc:Subject:Date:From;
	b=gRjlNMBWXV6EELqLlFpjjSSZiUkO+oNkOId39OpfP8dGNqAJJNkLaXL8GPCuCPnJo
	 rnkIJ4cjyHPzkMgk47yfHBeKrGFVXXMRT8Ab8AyEqiiU4aGI9ugWz4d7SprwyPZEo3
	 mTBfClS7dRuSFfIE5JqNssENrSF3hmII8SMM4xH0szzt8UZZS2oJqczbMb2uSZoK1x
	 3MhxoC+++yVt3AVP0/afD/alpHFJ61Jv67JUaRhMLLl/BIR+xugKzXgdXwIrThCN+F
	 PNuV5KVR5mHeNS6B+/kJKFtajePVkU7x31dGrudr0kxydBMuHxJBCWs9YUf0rLtYg5
	 Y+6so0qeFCcWQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] iommu: mtk: fix module autoloading
Date: Wed, 10 Apr 2024 18:41:09 +0200
Message-Id: <20240410164109.233308-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iommu/mtk_iommu.c    | 1 +
 drivers/iommu/mtk_iommu_v1.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index b8c47f18bc26..6a2707fe7a78 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1790,6 +1790,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8365-m4u", .data = &mt8365_data},
 	{}
 };
+MODULE_DEVICE_TABLE(of, mtk_iommu_of_ids);
 
 static struct platform_driver mtk_iommu_driver = {
 	.probe	= mtk_iommu_probe,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index a9fa2a54dc9b..d6e4002200bd 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -600,6 +600,7 @@ static const struct of_device_id mtk_iommu_v1_of_ids[] = {
 	{ .compatible = "mediatek,mt2701-m4u", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, mtk_iommu_v1_of_ids);
 
 static const struct component_master_ops mtk_iommu_v1_com_ops = {
 	.bind		= mtk_iommu_v1_bind,
-- 
2.34.1


