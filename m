Return-Path: <linux-kernel+bounces-128936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 156F9896206
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463F51C23649
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8DE18659;
	Wed,  3 Apr 2024 01:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8k8wso+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF2514006
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 01:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712107978; cv=none; b=aD0PjHgTcAvjOijyY7DiwitKJOZhAoI3tNJwNpo7naeHpn3vVv9pHg4DtSw5em0521/AZNQQp+vmkI+lAg4JuzlkCLPjAoLbtV4mWcbhlHlY5fIr2Wj+m3QRXNSFXSpboctYF2bcFEOLuQR/CnlzZKhDqccFZKACKMV7hoGDTD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712107978; c=relaxed/simple;
	bh=tDJsFCuEB0R3BpJAyJuzqy8CPWr5VO5Dk1p5YV+4YIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyqEY7egodU+QAK2LBrBffI42A1uziKvlZvq1IKTCI6pkxm8gjx8Ym1pXXzJ2GuDtDX0C/9hg8XXlrCDPmSZXm+zEG8Tr6E+yOWLC5xHqp2AEtX939+XJSGDWzi6zyKPxPvaWjiyunamSDeP5ABkco8S0Ycwh5j3gyqIYRShx0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8k8wso+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712107976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UqFcRORApCbbLwHiV/NvWvcvg5AC7kP7mUGUslgtJS8=;
	b=U8k8wso+Rv9yjf3YePfq8jUy8L8k71NsR1nmCb2etojMeFe8PviOzb8eqyxdZBunDahESU
	V3hpftv8sFJifCvX2q1ZJmykHgs+nUHX/3Q2vGQdwEGB/QYP4zHsMIGHG24KDuSQPU62XK
	6Bl+Sjg+t/VkNt5pf/IQUGkGsoIp3JY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-0VQIcHcdMuq1trLK6-LZGA-1; Tue, 02 Apr 2024 21:32:54 -0400
X-MC-Unique: 0VQIcHcdMuq1trLK6-LZGA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-69925f44915so937356d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 18:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712107974; x=1712712774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqFcRORApCbbLwHiV/NvWvcvg5AC7kP7mUGUslgtJS8=;
        b=Pw2lj4yCt0sn/Dr0U+haK0fZSWkWhILdPfywBBdky60t5rm2kpIfQPM9opHG3yWQKm
         fGBKcxmOnkG0QDgDP+wlw3LwAf7m2ZQz0IAvWIc4I0fcySg1+WIZa220o01pV4WmBaMP
         mgYQM3tWGPbNZ8vOfcRhBlJAGy6aU7TwZylYxSV9DKlyTtYoacDU3imjX3y1SyleoJ9t
         yLHGcE0fzoUv+SSXmSzhdW52a0219yrR8WoBfZDzCLIIyL7CHSV71ju0n6yH3SP2iyFQ
         B+2/qBYkaIJJs3vmk/CJOYoSQGq5ApCORwmv4WkpNUNQnfS8CCFPByn+eBw383w7OM0c
         fK+A==
X-Forwarded-Encrypted: i=1; AJvYcCXXQdoycVgu+pl2nCuBjkemQMToFJt1QtURR8aWsYhgTQngzGxU+OZRXt7YQFmT428Wg8loxZ2OD18dReVnFafU4YfNcw/+UjF+1GLN
X-Gm-Message-State: AOJu0YwSEzu12u0jMrVXsxG9LLoMJQD2jwwlMT15xu8zNv5VP2JF2AsY
	c6VnFgicAHbhx9MT1ftiXuGbhVhbWeeePfMqwjxRuBZg14OJ40/lN00k85opgcqcmbdoHsmSAlX
	G805qwkGI7JfmInIhXqy4g6rnTp2UgdTrXFuP7CLFHmVEkYcsBIO/zolJ1dY/MA==
X-Received: by 2002:a05:6214:946:b0:698:ff21:99f6 with SMTP id dn6-20020a056214094600b00698ff2199f6mr9007652qvb.3.1712107973810;
        Tue, 02 Apr 2024 18:32:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdeiJvxhuNcK+1vYTZU0OZ0cczYLrBalyCYqNCwtKHKX2kkX+lMyBxEcKCdgdQrvrdhUD2Gg==
X-Received: by 2002:a05:6214:946:b0:698:ff21:99f6 with SMTP id dn6-20020a056214094600b00698ff2199f6mr9007637qvb.3.1712107973351;
        Tue, 02 Apr 2024 18:32:53 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id qm18-20020a056214569200b0068ff8bda6c7sm6031687qvb.92.2024.04.02.18.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 18:32:53 -0700 (PDT)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
	peterx@redhat.com,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Ryan Roberts <ryan.roberts@arm.com>,
	loongarch@lists.linux.dev
Subject: [PATCH 2/3] fixup! mm/gup: handle huge pmd for follow_pmd_mask()
Date: Tue,  2 Apr 2024 21:32:48 -0400
Message-ID: <20240403013249.1418299-3-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403013249.1418299-1-peterx@redhat.com>
References: <20240403013249.1418299-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

Allow follow_pmd_mask() to take hugetlb tail pages.  The old warnings do
not help now as hugetlb now allows it to happen, so drop them.

Reported-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 91d70057aea0..d60b63fcfc82 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -775,8 +775,6 @@ static struct page *follow_huge_pmd(struct vm_area_struct *vma,
 	assert_spin_locked(pmd_lockptr(mm, pmd));
 
 	page = pmd_page(pmdval);
-	VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
-
 	if ((flags & FOLL_WRITE) &&
 	    !can_follow_write_pmd(pmdval, page, vma, flags))
 		return NULL;
@@ -805,7 +803,6 @@ static struct page *follow_huge_pmd(struct vm_area_struct *vma,
 
 	page += (addr & ~HPAGE_PMD_MASK) >> PAGE_SHIFT;
 	ctx->page_mask = HPAGE_PMD_NR - 1;
-	VM_BUG_ON_PAGE(!PageCompound(page) && !is_zone_device_page(page), page);
 
 	return page;
 }
-- 
2.44.0


