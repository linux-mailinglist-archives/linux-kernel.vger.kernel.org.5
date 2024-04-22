Return-Path: <linux-kernel+bounces-154344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 257568ADB00
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10671F23EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BF3201267;
	Mon, 22 Apr 2024 23:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWKfYzqP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A674D201257;
	Mon, 22 Apr 2024 23:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830372; cv=none; b=SIdcdKcOguGNGiqdcV1vsEu0Zf1wKqJlKWgBsfrwF37pFYj+7W6BaLqCRGhm193GYioB12FrwXeZ9+iC6JdP53Sj9EHdvC5WaDDOxRLjESRUUGaVKkaj+NfRvDG7lHhSxK+WpQ5T7/iQ86NsPzz0lSnydBSXzcrfsOMWs9Ht84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830372; c=relaxed/simple;
	bh=h1CmKPJ1Sae/CFF9eC+XbaOrI2RMfb8SzeJvTVCkKG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mh0Yh/+7gc3g6djSxf879/46nhJX3LDlGw8s1jyXliCQBseFW/y0AKm0miucNGYAgafpWHfjxwQTxq7Sgeq5FeJXxa6VVJHgFcq6yPn/J7QWpo+r7SjXUqYGkoglcQ2cOaAC/h7S16kZk9pQIg9pH5On4azEYURuy2RUWuz16Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWKfYzqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27049C4AF0A;
	Mon, 22 Apr 2024 23:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830372;
	bh=h1CmKPJ1Sae/CFF9eC+XbaOrI2RMfb8SzeJvTVCkKG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eWKfYzqPH46fKf9bM+TB3ZDCUy9602NXtm2u+5AaqsDu6D6YBMOpwM5Wuw/9LStPx
	 uv1OKU3JmIKH5laPyoOrxXJtoZDIW+5PEvVsOUHpnh5fjCHGKxt8/e6Sddlw7Qwsjw
	 Yygc7TvKFKwniaPBnhXXTNBEU2mETW3Avx9ErMMPLGoxd7F6cUfVGbdKgOEMNQmtFp
	 3NU1M0CtEzQmRdctiekyKExVT1+3a7/3pc1zrlMqeIbmdxgL0hRciPR3QLP3T87YH+
	 r2AAF1Cs/Q2iupYhR/9U+6VhTxXiEFPWMbuTbloe/hOC7KbmQtvDKCIS3FHFJ6Ep8t
	 zw0TvQ6+LH9Aw==
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
Subject: [PATCH AUTOSEL 4.19 7/7] iommu: mtk: fix module autoloading
Date: Mon, 22 Apr 2024 19:20:39 -0400
Message-ID: <20240422232040.1616527-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422232040.1616527-1-sashal@kernel.org>
References: <20240422232040.1616527-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.312
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
index 7304ad88f1263..93a47302d6cfc 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -761,6 +761,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8173-m4u", .data = (void *)M4U_MT8173},
 	{}
 };
+MODULE_DEVICE_TABLE(of, mtk_iommu_of_ids);
 
 static struct platform_driver mtk_iommu_driver = {
 	.probe	= mtk_iommu_probe,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 94b16cacb80fc..709a2ab1d4cf7 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -541,6 +541,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2701-m4u", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, mtk_iommu_v1_of_ids);
 
 static const struct component_master_ops mtk_iommu_com_ops = {
 	.bind		= mtk_iommu_bind,
-- 
2.43.0


