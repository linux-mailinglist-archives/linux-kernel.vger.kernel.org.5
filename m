Return-Path: <linux-kernel+bounces-154290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A01B8ADA59
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28CAEB26370
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F779174EC1;
	Mon, 22 Apr 2024 23:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8pyL2i1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7BF17108F;
	Mon, 22 Apr 2024 23:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830234; cv=none; b=qs9kVKpunI2xPCFCMEso0y+98StreUkbqV9OocWbUsNlAXFV2x1IQXjtXIvjFDNxtOaqeJ6rfFc/r0+32mSfgg71KvTc2j7y2tAsbdCFy3A6WxmkqxMZACixy1+kfiHVTyZqhpShGkajcOmFA3xdzDZ/xw/rPKaNwj45ZZg18b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830234; c=relaxed/simple;
	bh=65ektcJxj9Rrw0TFcZac08x3l77hf5zTMlc2nDRY7HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjYfxCeW105lti4q5Slsk/HrKnc4PRGX9MJdwRKRqT+yWV9fBo58Du7AHZQmzI40/0GcADnHa0vCaP4ofPF+fVZX7HLc/RdZnaenZTn36NKpN8KjWSppz9QxNPbOFeBAJfk621CCQhh1jKpgHQREz80T0DK+MRQPjGDYmmC48nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8pyL2i1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E5FC113CC;
	Mon, 22 Apr 2024 23:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830233;
	bh=65ektcJxj9Rrw0TFcZac08x3l77hf5zTMlc2nDRY7HI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b8pyL2i11eKGlMtYagYvO8PDiHRcWMm40gXxz7HhjR7jCtfutzeB5WqQN3/nxftPw
	 jd076UXm0ONL7GjcaFbVeVhmSw9UuaMcAjftIltKWOjSSJIFlAAJeM5hPdoNiK9Qvh
	 LKYN9eNdHVDFGx7i2OAaweKj48wMVhgcP43G1qliiKAXyz0Kt9x9/6IqXuFk/TLaJM
	 ioHg9hCQIebOW6k20U6qfa/G5OnALbTmCV7lGwnTArHtnyZNb9IptQJBCrd+w9quOV
	 /mSBi5nfX4iMTfpE1LyHKdIlcnhOUKiDN+5vhnwSueLHLxgz8Eu/UFyBukjQ/Qj22u
	 EK0/Uk7lRhUdg==
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
Subject: [PATCH AUTOSEL 6.6 29/29] iommu: mtk: fix module autoloading
Date: Mon, 22 Apr 2024 19:17:10 -0400
Message-ID: <20240422231730.1601976-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231730.1601976-1-sashal@kernel.org>
References: <20240422231730.1601976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
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
index fab6c347ce578..de698463e94ad 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1773,6 +1773,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8365-m4u", .data = &mt8365_data},
 	{}
 };
+MODULE_DEVICE_TABLE(of, mtk_iommu_of_ids);
 
 static struct platform_driver mtk_iommu_driver = {
 	.probe	= mtk_iommu_probe,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 8a0a5e5d049f4..f1754efcfe74e 100644
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
2.43.0


