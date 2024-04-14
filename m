Return-Path: <linux-kernel+bounces-144264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7A78A43C7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9931F2208B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EE51350CC;
	Sun, 14 Apr 2024 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5AXTzk9"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FED6205E10
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713111909; cv=none; b=HsCBiYb82qKU+sTpQpnf7gTgCPxN9n9U8DWK68WRyyrXtBD1PMsVd+i1rzx7bRus85yO3UdkZSI4zQ4V2sHPojtSOQcSRLFryyXwxD2wqpqIsG6lzKfj4xtmVbNLdHvqA1Q8A64UcIJ+0W8qVi7OqtiyZUjHklFR1pghsHus1Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713111909; c=relaxed/simple;
	bh=x9zY+X01BxCJYs60384+4AxqPsLSpqAW3M0zfApyxdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T11rTHhVNAbzXPbQWm7u34iSTE7mFx93uXqaEAQiVquWFUR6uY0Its671BmGiQEWe08kwdR7AURYtIACCceZOuKQZ2CVWzP4S7H0cc4EyK9UEfFFgpm3zgrOtPcL6ClO3AJONXvWzFWVTk7At91H+rKdpvEHjSMI5E6Jrsxm8Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5AXTzk9; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4715991c32so307737966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713111906; x=1713716706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OVsG3JCtQo4tlTQt5Af4gG7a1SS2UAv4W4YMU6rXC8Y=;
        b=J5AXTzk9MNS79TK5+ViYN3eUc7aLCSi93UFaXSiXncuYG0TtLTkVYJz9uLC7ptLS+0
         2/wrsS7hkp1vJzIYACLpZlFE2Vse1ypK6shJs90Nts5yUB+NOMZB26MQKpADDAsJpP6l
         3fdmO1vP8+4mOWCB9wsbZURRnTn6Uy1kRZXfhtIKc6DPEVnH9Y33c84hxLl5wV8hgREm
         rr4gYu0MytWodlmlqbsJyn4cnt+7L6Sy7I1MAYe7bLCX9xzAbv/VMpY0yGDb1CdTdt44
         bgeAh5PHdAr/Lc3v3RRawRQ+SFPfkNcNAuBN0bEroXFVmo7JEUyCiKExYsVs85iRvNuW
         9xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713111906; x=1713716706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OVsG3JCtQo4tlTQt5Af4gG7a1SS2UAv4W4YMU6rXC8Y=;
        b=Rlmx7CewBmaTXin1mJ2kZc7M+5CqKsU9Pv+i8jKypwynw1hDXhYhO3s0lcfu9fRCPr
         eO8DklHiU0uNTbFlOp1aA902U2/XesZwqWUv9X9j9CW6Ib5gWP/elky1R2W0sVkg2uOO
         yLPQ+1i8fKQNIVIPvZ/WtJfgrTIsIsvDoB2Xf42R9Js+7AvMTAQ/FAZMXn3EXeg9xRJq
         dpRSYIJNddxJNKR0J3EqcoBQpoVpsobh1uJV+ktfPUwtt//yA3DoN+gQexhnNNAKM68A
         gHOWk6bwhwNkMlgMschlH1nQIhxmuln2RtOAHNCIkjtGXCyHJS0tuGje4K8qOkakVqPh
         FIbg==
X-Forwarded-Encrypted: i=1; AJvYcCWq9Jra/TsRetx2MFxUmlIjvUg9q7Ufxh+IAo5VMjptM5VnLVb5JPez/iNdOExsendNqeTq0Odgk8OJyBDTyq+MHPfQWh460kaNuEZ2
X-Gm-Message-State: AOJu0YzareQolv+49YhDmA0JjpJ8I5olFKM0opvAR2jursWZWeqL0oEu
	QX6n/T4iWK2Xzte3DZWgFgyJmaZ0F+ga/TTbSCPux1d6zr7TivS7
X-Google-Smtp-Source: AGHT+IH9g+mcCrogr0CIRidhtrDFP5KjqkCIgE/JGUqj2zc3wRYfBX9PYIONiFkO0uvOTfch9T1big==
X-Received: by 2002:a17:906:2932:b0:a51:969e:ba0 with SMTP id v18-20020a170906293200b00a51969e0ba0mr4631415ejd.44.1713111905479;
        Sun, 14 Apr 2024 09:25:05 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id b18-20020a1709063f9200b00a523cf3293fsm2920181ejj.59.2024.04.14.09.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 09:25:04 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] iommu/intel: Use try_cmpxchg64{,_local}() in iommu.c
Date: Sun, 14 Apr 2024 18:23:11 +0200
Message-ID: <20240414162454.49584-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace this pattern in iommu.c:

    cmpxchg64{,_local}(*ptr, 0, new) != 0

.. with the simpler and faster:

    !try_cmpxchg64{,_local}(*ptr, &tmp, new)

The x86 CMPXCHG instruction returns success in the ZF flag, so this change
saves a compare after the CMPXCHG.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/intel/iommu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 50eb9aed47cc..311073494f50 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -865,7 +865,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 			break;
 
 		if (!dma_pte_present(pte)) {
-			uint64_t pteval;
+			uint64_t pteval, tmp;
 
 			tmp_page = alloc_pgtable_page(domain->nid, gfp);
 
@@ -877,7 +877,8 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 			if (domain->use_first_level)
 				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US | DMA_FL_PTE_ACCESS;
 
-			if (cmpxchg64(&pte->val, 0ULL, pteval))
+			tmp = 0ULL;
+			if (!try_cmpxchg64(&pte->val, &tmp, pteval))
 				/* Someone else set it while we were thinking; use theirs. */
 				free_pgtable_page(tmp_page);
 			else
@@ -2128,8 +2129,8 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 		/* We don't need lock here, nobody else
 		 * touches the iova range
 		 */
-		tmp = cmpxchg64_local(&pte->val, 0ULL, pteval);
-		if (tmp) {
+		tmp = 0ULL;
+		if (!try_cmpxchg64_local(&pte->val, &tmp, pteval)) {
 			static int dumps = 5;
 			pr_crit("ERROR: DMA PTE for vPFN 0x%lx already set (to %llx not %llx)\n",
 				iov_pfn, tmp, (unsigned long long)pteval);
-- 
2.42.0


