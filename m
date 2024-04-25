Return-Path: <linux-kernel+bounces-158271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CB48B1DB4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61602867A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D02085293;
	Thu, 25 Apr 2024 09:18:49 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08C784FBC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036728; cv=none; b=oXt9IpFEcTBjaHEzIwT8fAutLxYZ3aLZQCQ0hEnd0hEHfX5lkk8jzUSCquMCuCXZsoxBJHINYw1gfZNRj+S1mAoymDUXl9RCZ3FIVUNEbhip2AeyvwACZ6bgsEV8MdabR4DKtfMSd7QHf3lXeGARj3AAlg5GaZFR3FNrtuXyz9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036728; c=relaxed/simple;
	bh=nLZE1rziuB8Cd4inrqdYD6bDm7SjRGECbSDY54hucVM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c5OoMqejgJH4+vFq7VZJWvZcEUtawqWF6svahgfe47tmOet0rU3f1lVmn9Itse3FFPz/d0MrjnPdf+rj68PtsF45HFKu7qBqIeqarqgnou5nqqm4quQgSXcyJGm3RmHVZo9Mn+h345+8L75BfZ/gwnMB/6YBFgfsnGrcZFaLDeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowABnbBjhHypmRq4sAA--.4146S2;
	Thu, 25 Apr 2024 17:18:26 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	heiko@sntech.de,
	jeffy.chen@rock-chips.com
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] iommu/rockchip: Add missing check for of_find_device_by_node
Date: Thu, 25 Apr 2024 17:18:13 +0800
Message-Id: <20240425091813.965003-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnbBjhHypmRq4sAA--.4146S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XryxKFW5XrWxuF13XF45trb_yoWfGFc_W3
	48uFnxWr4vyrs0kw12q34xWrZFkasIvrnrZrWjkw1SyFyDWr1xXw10vr4kJFW7Wr1jyF9r
	Kryj93yfCryUWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUjMmh5UUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Add check for the return value of of_find_device_by_node() and return
the error if it fails in order to avoid NULL pointer dereference.

Fixes: 5fd577c3eac3 ("iommu/rockchip: Use OF_IOMMU to attach devices automatically")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/iommu/rockchip-iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 4b369419b32c..1225c1df6ef6 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1152,6 +1152,8 @@ static int rk_iommu_of_xlate(struct device *dev,
 		return -ENOMEM;
 
 	iommu_dev = of_find_device_by_node(args->np);
+	if (!iommu_dev)
+		return -ENODEV;
 
 	data->iommu = platform_get_drvdata(iommu_dev);
 	data->iommu->domain = &rk_identity_domain;
-- 
2.25.1


