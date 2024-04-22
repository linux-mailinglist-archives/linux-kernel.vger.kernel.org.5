Return-Path: <linux-kernel+bounces-154319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1809C8ADAB4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C6DBB27167
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420FE1A0AE1;
	Mon, 22 Apr 2024 23:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZeHeSjQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8140319DF76;
	Mon, 22 Apr 2024 23:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830311; cv=none; b=ZRT2LYJwxlNy+zWHG9II1QG+mKl4uuLu/84fZLLMylviNT6MYa13QS+m+Uctc55AtXKgdvJ9e8Nz4/tqEWDrDLIZvUj2tn7tm+McDuGs59fVM2M4/SNHb/n6DTjbtf/8tcxM/mcpInrP5FDbR3HoHZ5nOrnJT7R5QenRuicXXxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830311; c=relaxed/simple;
	bh=i1qI41SgWsD0p/gzHp7ffpMwE2vMBIHK3+jdxiiH38I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jwkv3zngfH7Am+a3cqC+1Zz2XvvrKXTTVunUxVp8+6rIHFt5aSp7NgX3CyqYnVb7Rkxz1C34pQHtRCRT5zK7uuuH2PymHLr5oXaszzBCMjK13NFnpCGvMqZUkGBqniw1J65v9cvCPaoFbgfbqdbXT64N/zjFEE7t6QRev5iDY20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZeHeSjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BCCC113CC;
	Mon, 22 Apr 2024 23:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830310;
	bh=i1qI41SgWsD0p/gzHp7ffpMwE2vMBIHK3+jdxiiH38I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MZeHeSjQc/RpBM4+bh0g4KoS/KAESqVX62B04WYj9toEBx2jgiv3vPUq0JgDQsLIW
	 83kOvCEgzPQDf44WPepTt/pLM3GY9QDj1Fsx3iVYBSm9a1ZONjcb+G4mZg+MpJks/W
	 2FcpYbWzqsI5j36Jn01eyBCwF/DFa4gntLZAZlgXZc9wm6uW5db9LsH7m+/eqZbbWk
	 L6tBTxCJAjC7RxyXjKgahGUp4bA0cu1urjp7bNnk9H8dYhZNO66ji8Rld6VNOqNz+i
	 qGacrPQvyP+o12EC02U8vzF7bJ6NsbWovFbpNFicRs80LPFZTv60F3XIngpHDuVUmU
	 4HkTmz5g/q57g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	yong.wu@mediatek.com,
	joro@8bytes.org,
	will@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 10/10] iommu: mtk: fix module autoloading
Date: Mon, 22 Apr 2024 19:19:23 -0400
Message-ID: <20240422231929.1611680-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231929.1611680-1-sashal@kernel.org>
References: <20240422231929.1611680-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.156
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzk@kernel.org>

[ Upstream commit 7537e31df80cb58c27f3b6fef702534ea87a5957 ]

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/20240410164109.233308-1-krzk@kernel.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/mtk_iommu.c    | 1 +
 drivers/iommu/mtk_iommu_v1.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 2ae46fa6b3dee..04ac40d11fdff 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1101,6 +1101,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8192-m4u", .data = &mt8192_data},
 	{}
 };
+MODULE_DEVICE_TABLE(of, mtk_iommu_of_ids);
 
 static struct platform_driver mtk_iommu_driver = {
 	.probe	= mtk_iommu_probe,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index fe1c3123a7e77..3a52f6a6ecb32 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -576,6 +576,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2701-m4u", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, mtk_iommu_v1_of_ids);
 
 static const struct component_master_ops mtk_iommu_com_ops = {
 	.bind		= mtk_iommu_bind,
-- 
2.43.0


