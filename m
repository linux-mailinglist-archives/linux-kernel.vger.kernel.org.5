Return-Path: <linux-kernel+bounces-165740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63DC8B9071
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9903B2194F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832A31635A8;
	Wed,  1 May 2024 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k08JWQVf"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B4942A96
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594411; cv=none; b=O1kha1kVBOBwHCxDJ9euiMNQmxC7pEv6gHds/vrtXtFPY8KT7yvp5ms2t6YEUjLvkoDJqlO0jfa+KcIjRl5sBG5x9fXeND2EHJ0fBc4l4bZvlTMXK6DAyHt7LLXNIHK8c+/1Jg35SGQlRchz2FVRMxBJvzYKjHX0vDcw1IrERys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594411; c=relaxed/simple;
	bh=rkNzy9U73z8jvrL5sUQ+lp32dbo34t1vmGN/vpd0fWQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jwKMYeHwXQvwJNBAoe2GX3wGRbmvhAEONTaLH8EB8M8bXUmBoDtwwdRfts11DC3oeEFpXBJC+ftNJNj/TRDKr1KVas7dCD+5LjZgCNHmhUEvVhPS+d6KaKOiJYwpUEj3JTfvjBV56xRqiHq97uAWHx9dZNSNQD0I6vmyR1Gg3d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k08JWQVf; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-ddaf2f115f2so11174914276.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 13:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714594409; x=1715199209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pAz4UtE9TtuqKUTxLs4RS/mVM2NOpMppCAL8lNzqroU=;
        b=k08JWQVft8gjvszzlt62zIhsy6UPMevWQP+zIa4kMnznTuh4C6QMtjqB05o3dtJTaV
         2phUXX+Y06dA8VoN6wtTgj1D1wJbwCcmegunrEXz91+QZdHFrJuXQbw11elaCe75eked
         WY6W422r+msePMu4iM3y5VtLmlPJ3nf5BKLELdWYIUwtGPgowZfRCMPjSG3IZNuBnwVC
         vM4jgoUQPGWx0eHQIPNMhsC4XaQKXBo/vRFzXe2MYaUfxrIzyAtkziLru1hDUULzDKsN
         p+TPcs+KS10dNxt5nCOPixIOLM7mynkOFheTsq+iK9dvkxXyu9U86VO/EX2ftw+fQoI3
         LonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714594409; x=1715199209;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pAz4UtE9TtuqKUTxLs4RS/mVM2NOpMppCAL8lNzqroU=;
        b=kEicf/NCRYCEmUGJ7nTE/+VT5wGSa949bXBZ2HxFYhoswfI5BX8KwyalmLifHIkWD6
         fCKM1AI2rw7kHv+1+ZqN4cmviX8cMhzHFO3nkIld07you0xyl21D2M4OXgaWu3oGdlQL
         3o1Ytn5gGl3NzEnDktL9uMq0coQ8ifuK7bHVeZrPyljPvoZ0U6EX7FzSbcq/nEru6xyO
         QZYGoMLFzTNdwZqd79ekohDRhQ/vqR70aJijIqjr0Ue3+2izuw2Avqp8HlaIVzt/LXnP
         IHsR8syiMgEIYUAJ9VSnBWlufWzEgxALUquLSNQjiApL0bYHKREiG8ezgNqg03U+0APl
         6Lqw==
X-Forwarded-Encrypted: i=1; AJvYcCXXooynONWbb2pNHTplvrrXGo6aahnqA1OD3A6HsNLPb+wUyt0HqJfN1e3rcD0ab6gQVXxPXPItcr2XLWd+/Y7QXJkngSS1hdza7/3V
X-Gm-Message-State: AOJu0YyTI6pBTDroDVXHSkeMsKFiZvewI6Z94Y43MBJXlZPKPGEDr2Ue
	ddH9w5WnzSZpgBfPzDvHppOoa6+/deLTiS0Mv5hxedvnaqUeJg54AngSgCfeF88DYpdVc6INFfZ
	ioorRP02her9Neg==
X-Google-Smtp-Source: AGHT+IHqI+ChrQt9eDkX7OntryvFzGWOZwa5AHoNSRjrZhppIPW4IvMdH+fS/OJP2+KxJpifU59LGhWMlLyMdo0=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a25:6809:0:b0:de5:5304:3206 with SMTP id
 d9-20020a256809000000b00de553043206mr381300ybc.11.1714594409532; Wed, 01 May
 2024 13:13:29 -0700 (PDT)
Date: Wed,  1 May 2024 20:13:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240501201319.586289-1-tjmercier@google.com>
Subject: [PATCH] iommu/dma: Respect SWIOTLB force_bounce
From: "T.J. Mercier" <tjmercier@google.com>
To: tjmercier@google.com, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>
Cc: isaacmanjarres@google.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

iommu_dma_map_page and iommu_dma_map_sg conditionally use SWIOTLB, but
checking if force_bounce is set for the device is not part of that
condition. Check if devices have requested to force SWIOTLB use as part
of deciding to take the existing SWIOTLB paths.

Fixes: 861370f49ce4 ("iommu/dma: force bouncing if the size is not cacheline-aligned")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 drivers/iommu/dma-iommu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index e4cb26f6a943..755d66b49dff 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -606,7 +606,8 @@ static bool dev_use_swiotlb(struct device *dev, size_t size,
 {
 	return IS_ENABLED(CONFIG_SWIOTLB) &&
 		(dev_is_untrusted(dev) ||
-		 dma_kmalloc_needs_bounce(dev, size, dir));
+		 dma_kmalloc_needs_bounce(dev, size, dir) ||
+		 is_swiotlb_force_bounce(dev));
 }
 
 static bool dev_use_sg_swiotlb(struct device *dev, struct scatterlist *sg,
@@ -632,7 +633,7 @@ static bool dev_use_sg_swiotlb(struct device *dev, struct scatterlist *sg,
 				return true;
 	}
 
-	return false;
+	return is_swiotlb_force_bounce(dev);
 }
 
 /**
-- 
2.45.0.rc0.197.gbae5840b3b-goog


