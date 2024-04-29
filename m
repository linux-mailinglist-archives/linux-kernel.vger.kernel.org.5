Return-Path: <linux-kernel+bounces-161686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE748B4F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 04:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59AF61C20D00
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965348BEA;
	Mon, 29 Apr 2024 02:39:47 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5C379DE;
	Mon, 29 Apr 2024 02:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714358387; cv=none; b=Bb4bnVDcGmFf56AbLFtfGc7dzNzyAfnPfkAWCg06bunc58kkdBgPgQEDmYFuKChxcyvNPWpk/tkiDYk07yv8x8nCM1U0F3QhdjSbF6LVcVoBO2/8VUp0vcLopES8GCn3gNa0PLJEB+Cwl+htctPsz0C2W+eQO247OG04N27bXl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714358387; c=relaxed/simple;
	bh=/Ut9n6JDnIQSvBAqdGVqX11aL0csFLr0zkITRrdN7Ak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BQ+v3RJAhv/CRLEy8OW6qFUNrLk3wi0twc8LJm2pL+jLkwziKVhpsT7prCQIoByX68pM+gvwgAzLJyi5+FjA1Sz1k1xqUhKkzRjBRqFp4IE7bbMvknqilwRYwd6G9fgPLCxsf3WHotrQtWUOgaNalJRyBam5WBBLr3yEEswv4bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowABHN5hTCC9mT+wNAQ--.11237S2;
	Mon, 29 Apr 2024 10:39:15 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: inki.dae@samsung.com,
	sw0312.kim@samsung.com,
	kyungmin.park@samsung.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	krzk@kernel.org,
	alim.akhtar@samsung.com,
	m.szyprowski@samsung.com
Cc: dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] drm/exynos: Add check for dma_set_max_seg_size
Date: Mon, 29 Apr 2024 10:38:33 +0800
Message-Id: <20240429023833.1869154-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABHN5hTCC9mT+wNAQ--.11237S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XryxXF1xWFW7Cw4fWrWxJFb_yoWDJFX_uF
	18XFn3Wr1v9rWqv3ZFyFZ3ZryjvF97Za1fuFZ2q3WfXFy7CrZxt3y7Zr17Zry7XFWUAFnr
	A3WUA3y3AF1xXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VU1sYFtUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Add check for the return value of dma_set_max_seg_size() and return
the error if it fails in order to catch the error.

Fixes: ddfd4ab6bb08 ("drm/exynos: Fix dma_parms allocation")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/gpu/drm/exynos/exynos_drm_dma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dma.c b/drivers/gpu/drm/exynos/exynos_drm_dma.c
index e2c7373f20c6..0f942186f3ff 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dma.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dma.c
@@ -51,7 +51,10 @@ static int drm_iommu_attach_device(struct drm_device *drm_dev,
 		return -EINVAL;
 	}
 
-	dma_set_max_seg_size(subdrv_dev, DMA_BIT_MASK(32));
+	ret = dma_set_max_seg_size(subdrv_dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
 	if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)) {
 		/*
 		 * Keep the original DMA mapping of the sub-device and
-- 
2.25.1


