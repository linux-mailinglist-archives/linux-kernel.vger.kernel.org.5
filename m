Return-Path: <linux-kernel+bounces-120272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B729088D525
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92ED1C24ED6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635BD22F03;
	Wed, 27 Mar 2024 03:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CddTe2Yz"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0821E22616
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711511169; cv=none; b=LwX15wFOSOKs5QDYx4HX/VeJjS5dmbrsZmhghy3VSXefbXJnIx6jwumeZZteLn3Bit/lhlTc/KrkqmI5T2nSiAHi5LHWGF1659wVh0SY02pW/X7atHEvdqMwnTFo1OUECZ5XYTUEiIpLLhzYuYvRTEMVQqpNuvknCgoyLzr4v98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711511169; c=relaxed/simple;
	bh=ZeAFsxPtacnd3+C+1rJ30gAV/hVdWc3kQmPPpMzcr04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ltT9zLKk5KjMzD2R4YglCA43xehctfKUB7Q2eoql60fuFyXKmT8Zd3H5QaRU4/MKqmQ5igp/BUCXZ/CduePj+wT9BJHHRlBbtGoyX2NNYp3yDk7dhaAVkImgiZnISjQkmnqTDlHRrWl4Bni24IpoknVLKIYe3LrgEwMh0Fblvjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CddTe2Yz; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29dfad24f36so4229852a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711511167; x=1712115967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KNqU8sxkAGV2sIPTWHyuNFg/2BkpL0OA+B81hrWr0ZA=;
        b=CddTe2YzH4t6oiMHeRXojUikZYpl57n8ZORzDx/05v8WnBcVCAYfFmX1Y/TJDgrqSx
         MrE1+jcG/r9xTAqWzKQ3+HXmacMf342XM4DSHFgkO4zB7oYUZcSdouxfh1vCTVmPxvPn
         qRzlTNhHMkyaaxWfNFtnXfwXGgQgQ418SUEEdgoEl5mhzlAQt74stSXOUzK9NDDV8kY7
         aAubHuvts0Z2hsrE/o9Dz0BIUzlwFTlCfD88RXopGQ+dfXDEZEbzWbu5/e7OCkPZdyqj
         jFEgp3RQgCU5jodw019zHt35/xQrrgKuiu9XzFyt4wX3gnKEAbf7jzpXRvZY7SA0+OXv
         iS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711511167; x=1712115967;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNqU8sxkAGV2sIPTWHyuNFg/2BkpL0OA+B81hrWr0ZA=;
        b=a6BVG5X9+7pMZokNBQT+4P2MuS+mo+HPxqkMi59WX/43Ojh2W7JQIBh3ha1MThCEef
         AkMobb/8ikZqNv2ViYxDJGCj8bFI2l2t7gOC9ObRLU/PaIHwj1Yhe0lGKuq3scYGPGZR
         AlZKEuP5qz7ai6ypr9rYgjkOrUCKI8WEuzBFBTOV+ZZK9lbO1zEpBxh+7zakl+xy6faN
         tOGQsYOWpAvRpHhPQVlvjgbdQlMI8RBAR5+1IipI/nunOob9jMkFn1WXKr8kDMoPUG9/
         jitntr8bHq3jFls3XUZVktFc4aYd0/QeL6cIPH4G1zB6Uq5XR6YLjheU3nuajaEsqmMb
         a/8g==
X-Forwarded-Encrypted: i=1; AJvYcCWP/ywKG385w+j+WLGZYsaMeW/QGMw39PwrDP0G/ediKvFr82PQv9EfEC+4DoA4Z7oBczB987JYLJkM/wJUAYqAS5hqzpuPt8gAMXVO
X-Gm-Message-State: AOJu0YyajI7SnO1GDQq4lYHQisjxHJYSk6JwZr4GovHNQYXGcBJKkcZN
	wjkKv/w+BFvd3iuyZHVfkt+B7MneEoOM13kRfWRdjZ2FKIv+2GCt
X-Google-Smtp-Source: AGHT+IFni7awmeeUlQh91WaJ34jqzPWLRRorhThWvS+SZRo4JHZ/K8HkM4/wAg69Vd1NoLiIDpvN8g==
X-Received: by 2002:a17:90b:4b0b:b0:29b:a9b2:f98c with SMTP id lx11-20020a17090b4b0b00b0029ba9b2f98cmr1538518pjb.24.1711511167137;
        Tue, 26 Mar 2024 20:46:07 -0700 (PDT)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id c16-20020a17090ad91000b0029c741ca894sm440382pjv.29.2024.03.26.20.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 20:46:06 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: hch@lst.de,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	petrtesarik@huaweicloud.com,
	konrad.wilk@oracle.com,
	chanho61.park@samsung.com,
	bumyong.lee@samsung.com,
	dominique.martinet@atmark-techno.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: will@kernel.org,
	petr@tesarici.cz,
	roberto.sassu@huaweicloud.com
Subject: [PATCH 1/1] swiotlb: Fix swiotlb_bounce() to do partial sync's correctly
Date: Tue, 26 Mar 2024 20:45:48 -0700
Message-Id: <20240327034548.1959-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

In current code, swiotlb_bounce() may do partial sync's correctly in
some circumstances, but may incorrectly fail in other circumstances.
The failure cases require both of these to be true:

1) swiotlb_align_offset() returns a non-zero "offset" value
2) the tlb_addr of the partial sync area points into the first
"offset" bytes of the _second_ or subsequent swiotlb slot allocated
for the mapping

Code added in commit 868c9ddc182b ("swiotlb: add overflow checks
to swiotlb_bounce") attempts to WARN on the invalid case where
tlb_addr points into the first "offset" bytes of the _first_
allocated slot. But there's no way for swiotlb_bounce() to distinguish
the first slot from the second and subsequent slots, so the WARN
can be triggered incorrectly when #2 above is true.

Related, current code calculates an adjustment to the orig_addr stored
in the swiotlb slot. The adjustment compensates for the difference
in the tlb_addr used for the partial sync vs. the tlb_addr for the full
mapping. The adjustment is stored in the local variable tlb_offset.
But when #1 and #2 above are true, it's valid for this adjustment to
be negative. In such case the arithmetic to adjust orig_addr produces
the wrong result due to tlb_offset being declared as unsigned.

Fix these problems by removing the over-constraining validations added
in 868c9ddc182b. Change the declaration of tlb_offset to be signed
instead of unsigned so the adjustment arithmetic works correctly.

Tested with a test-only hack to how swiotlb_tbl_map_single() calls
swiotlb_bounce(). Instead of calling swiotlb_bounce() just once
for the entire mapped area, do a loop with each iteration doing
only a 128 byte partial sync until the entire mapped area is
sync'ed. Then with swiotlb=force on the kernel boot line, run a
variety of raw disk writes followed by read and verification of
all bytes of the written data. The storage device has DMA
min_align_mask set, and the writes are done with a variety of
original buffer memory address alignments and overall buffer
sizes. For many of the combinations, current code triggers the
WARN statements, or the data verification fails. With the fixes,
no WARNs occur and all verifications pass.

Fixes: 5f89468e2f06 ("swiotlb: manipulate orig_addr when tlb_addr has offset")
Fixes: 868c9ddc182b ("swiotlb: add overflow checks to swiotlb_bounce")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
This patch is built against the 6.9-rc1 tree plus Petr Tesarik's
"swiotlb: extend buffer pre-padding to alloc_align_mask" patch
that's in-flight.

 kernel/dma/swiotlb.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index d7a8cb93ef2d..d57c8837c813 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -863,27 +863,23 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	size_t alloc_size = mem->slots[index].alloc_size;
 	unsigned long pfn = PFN_DOWN(orig_addr);
 	unsigned char *vaddr = mem->vaddr + tlb_addr - mem->start;
-	unsigned int tlb_offset, orig_addr_offset;
+	int tlb_offset;
 
 	if (orig_addr == INVALID_PHYS_ADDR)
 		return;
 
-	tlb_offset = tlb_addr & (IO_TLB_SIZE - 1);
-	orig_addr_offset = swiotlb_align_offset(dev, 0, orig_addr);
-	if (tlb_offset < orig_addr_offset) {
-		dev_WARN_ONCE(dev, 1,
-			"Access before mapping start detected. orig offset %u, requested offset %u.\n",
-			orig_addr_offset, tlb_offset);
-		return;
-	}
-
-	tlb_offset -= orig_addr_offset;
-	if (tlb_offset > alloc_size) {
-		dev_WARN_ONCE(dev, 1,
-			"Buffer overflow detected. Allocation size: %zu. Mapping size: %zu+%u.\n",
-			alloc_size, size, tlb_offset);
-		return;
-	}
+	/*
+	 * It's valid for tlb_offset to be negative. This can happen when the
+	 * "offset" returned by swiotlb_align_offset() is non-zero, and the
+	 * tlb_addr is pointing within the first "offset" bytes of the second
+	 * or subsequent slots of the allocated swiotlb area. While it's not
+	 * valid for tlb_addr to be pointing within the first "offset" bytes
+	 * of the first slot, there's no way to check for such an error since
+	 * this function can't distinguish the first slot from the second and
+	 * subsequent slots.
+	 */
+	tlb_offset = (tlb_addr & (IO_TLB_SIZE - 1)) -
+		     swiotlb_align_offset(dev, 0, orig_addr);
 
 	orig_addr += tlb_offset;
 	alloc_size -= tlb_offset;
-- 
2.25.1


