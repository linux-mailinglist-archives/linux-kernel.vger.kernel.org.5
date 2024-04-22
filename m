Return-Path: <linux-kernel+bounces-154309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 025618ADA8C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966871F21F0B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06896181BBD;
	Mon, 22 Apr 2024 23:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRt9Mb0D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B3915885B;
	Mon, 22 Apr 2024 23:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830284; cv=none; b=drCG/tiq01l+NTRHgG7JpnMMry3hsk2vSZmwrPFBuGp0wkqOjKUTYgavEiNJ38ISm9UKlEPwaa5s30umycqrXAWnFYCLAL3WsDVD+9+LYSUBNYKc4XamCGOtUy3EeqIQAlJNzXmGRtZ5hf4QqluvfDM/UPUJoPRQ/e7h/8Vg3YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830284; c=relaxed/simple;
	bh=ej6Ld74lMeOwzNfWedf8EsdWgF5p/GNnWO/zfutqak8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eefooUnUNp0LnoYY3/8u0yRFI8oQXokzkB1UBfv0bOLjNXDRAV8uutdYxUNW544Ax7oT8uKFoOhiqdMTHQPd6ZhdzIUEaDRBHp7RbggZ0qchg6DiUQCkLzbLiamn0wuqe0JOjpY5OBgks9rJd+Qu3jrrJWdGH23o+6dVFui0GnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRt9Mb0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CFDC3277B;
	Mon, 22 Apr 2024 23:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830283;
	bh=ej6Ld74lMeOwzNfWedf8EsdWgF5p/GNnWO/zfutqak8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KRt9Mb0DapG9hVyP+QR3Dfe9cArOqt5zujGDN/NSI73SLM2+2DhT+ByNmO+LClQ1q
	 xHKnYCX2C/lUAETTnnTcGUD5o0NWUsusOHaReZCMXnTxkjq1egJxZe5W0PBMb89xau
	 CsyKwXFlIaMgUliOegu1PLgRkOJ12ldm874K+LUEjieICAJDcQEHSgbw5SRGQg8me2
	 oypqN5bpsTlEU+mwFjq8Bzc5BBrHfVZtKDRymxL5h6yY0p7ANRsyQ40kilwlRbmVdT
	 TP75XnRJ+kzZrB9yx1RSxeAMdhgmrP/4tz6IRkxaZRydSBJCcR6EDV9jUuAh082pIj
	 oJL9vG4usgcfA==
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
Subject: [PATCH AUTOSEL 6.1 19/19] iommu: mtk: fix module autoloading
Date: Mon, 22 Apr 2024 19:18:33 -0400
Message-ID: <20240422231845.1607921-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231845.1607921-1-sashal@kernel.org>
References: <20240422231845.1607921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.87
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
index 0ba2a63a9538a..576163f88a4a5 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1570,6 +1570,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8195-iommu-vpp",   .data = &mt8195_data_vpp},
 	{}
 };
+MODULE_DEVICE_TABLE(of, mtk_iommu_of_ids);
 
 static struct platform_driver mtk_iommu_driver = {
 	.probe	= mtk_iommu_probe,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index a978220eb620e..5dd06bcb507f6 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -602,6 +602,7 @@ static const struct of_device_id mtk_iommu_v1_of_ids[] = {
 	{ .compatible = "mediatek,mt2701-m4u", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, mtk_iommu_v1_of_ids);
 
 static const struct component_master_ops mtk_iommu_v1_com_ops = {
 	.bind		= mtk_iommu_v1_bind,
-- 
2.43.0


