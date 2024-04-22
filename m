Return-Path: <linux-kernel+bounces-154261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEC38ADA03
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44AB61F214BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5B715ECCB;
	Mon, 22 Apr 2024 23:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJP5k6EA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D8C15E81B;
	Mon, 22 Apr 2024 23:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830150; cv=none; b=XZNBPyKpcq3/MYDMwYr9Q7W/9CO0AY7wktwUpdcEljUNDxk0f+/lKUT3D321xLkBA66zy48d3hoqvCnb0KlQ1nkjBsosPLIewlcfLasG1eIyI52rTQ/34AbkrpGoQl/jLuK3n3upj+ZmARnG+ARLtfVnu3DxFHpSe1UclBrKD5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830150; c=relaxed/simple;
	bh=2FqeOWFJ5RPwBVKKuybfSkJp8Q6nO5EybaaGdKCY5uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwzuHIRoqUT5OL3D68OnBCnuyPSMPBlTBMmn5Jm676Qvq9S9fiRvuxtBE4aLQgPU04DYKIBJlxA+icwnauaGMfFt1nQG7PKKcRKmwu4O7yI1GVUYKPzHU/dNiDmTPFr1Ql6uKRUd5DzjPfAQ7fp9mHtNtmJZ6SriCQBtdQgBVBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJP5k6EA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53202C2BD11;
	Mon, 22 Apr 2024 23:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830149;
	bh=2FqeOWFJ5RPwBVKKuybfSkJp8Q6nO5EybaaGdKCY5uA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UJP5k6EAjEKcTbL0hiszQgyiJZH7hC2+XbOQijSLIHMbP0QZUFtfzHM9lzrxJs6Ue
	 hmRV8nDzw8ihO6eVaTgZfGZ7MKsZd7t/QhqAE1iN0PUiq8sobbkZRZvmuyvZljuypX
	 MK5f5uCdwzE9Jw1RshIvjdu78pxA/xXAlcD2miQ4K5YunRdPTIZg5BP2DxCrRlMsTX
	 RIFoeMe8QziJ63p750cvTP9qsa5ZScpqW5o7tfnwvIHxkRXrkaYuvkDPv3Zhybl9x6
	 GMY4jGZyM+W9Pt4divDiDtUeEUhJcB7saNMcW58Tdyx3m4gdGKoZiBXZfwrBQ06fHz
	 H9l3/7V4pJZgw==
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
Subject: [PATCH AUTOSEL 6.8 43/43] iommu: mtk: fix module autoloading
Date: Mon, 22 Apr 2024 19:14:29 -0400
Message-ID: <20240422231521.1592991-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
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
index 7abe9e85a5706..51d0eba8cbdf3 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1789,6 +1789,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8365-m4u", .data = &mt8365_data},
 	{}
 };
+MODULE_DEVICE_TABLE(of, mtk_iommu_of_ids);
 
 static struct platform_driver mtk_iommu_driver = {
 	.probe	= mtk_iommu_probe,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 25b41222abaec..32cc8341d3726 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -599,6 +599,7 @@ static const struct of_device_id mtk_iommu_v1_of_ids[] = {
 	{ .compatible = "mediatek,mt2701-m4u", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, mtk_iommu_v1_of_ids);
 
 static const struct component_master_ops mtk_iommu_v1_com_ops = {
 	.bind		= mtk_iommu_v1_bind,
-- 
2.43.0


