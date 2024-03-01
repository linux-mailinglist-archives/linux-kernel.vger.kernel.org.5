Return-Path: <linux-kernel+bounces-89018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A08486E98E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBDF1C257FB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D8F3AC14;
	Fri,  1 Mar 2024 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqKaiAwv"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38AC3A1C2;
	Fri,  1 Mar 2024 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321286; cv=none; b=HnpXMiC/P0aI0bgKcFOBXOfj8GZ+nDhKIYZZh/T2YtIAIy03afTDmjS5dvKPPPqDJvIXfj95ryM7rL4Bl0MVwWZXRnGuPtcx71v0CL2iquxkBmeUhLmXB+l6py2dsS3s2EU0zXIcG7TjNRahppkS9zHgkYkCkU2EvVe+ow3Jn88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321286; c=relaxed/simple;
	bh=VwQqaS3zX8w/3VsDz5uvUiPA4BKW7TU34ZySU1bRSYc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bNT5WYvwBKXNVy4quZEfK6PV8tTgCrX17HPzRZZb1XlCCOgTDiI5ENzQVhb89QNE6R5nj8Psr4RZi9lM94Dzpl+mNvIfIUyoGr2FvOCoxB3un/6RsfuauKDjwoF8gW5yUyJtdyytr4EnAWu0yIjtSUUGeY3VhGFh9getUBAzQYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqKaiAwv; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so2113875a12.1;
        Fri, 01 Mar 2024 11:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709321284; x=1709926084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UW9jD9DMPk/GO8LUNjlgcg/uFBWw75GPz41GiFaM26o=;
        b=SqKaiAwvvVFFD8OUGlaAIyYCKV5bq22oS7KqYiAKkI+fpOtfacBmWWuAeog7HZobDw
         /3874ss/+YMv5yJm9B5HQiliXXP2SUHaUzvoVSl14yJSqA6yAepdk8d5hM3Cb+CCLIu0
         nMGtZCbjOz3Eh684ChaT8yjfD60FOHlDUpJ55fzyq253D2X2H5F/ZAuAyY3ZpuzpoMii
         xZihDWwJyh/I3DIsRFAuDQMWHa0UzBgL6MNhF6t3HJ9c9j1e2a5CYa8BVYwUSS0oAmsX
         Mo47j+AiPOpt5JGCFdrEe+EkgsfNqT+sjVhegNr8uhuhiGa/6xRq0h3snjJ2fJivPXUN
         KAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709321284; x=1709926084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UW9jD9DMPk/GO8LUNjlgcg/uFBWw75GPz41GiFaM26o=;
        b=LjKTChIGq+DYN0M7k0Y7dQKRMNj3TGuhICm14q+9q17vGk7vQzGHIOKRux4vK5N3QG
         zqOSkMY+20XJKgHqe/paCqBI1nPiGkjVtwd4WIOHy96/Gx58+QjCqHHIf7tx4ckeipQv
         YgLbOkBjHWJwRARVw7RKl8/3icQSo1yXTPlj3uAawXXVyBWI52LVV2KyZ54Kvh6Vreuf
         btyOZ20sNNt6nGTvcNrkGA5N329/0xC1LrlojR1n5MeqOHnMDRLtf2Pc2CsAdxjqvT40
         AI2y0Jl/Rut00YRXSWoWrzxLEGuuv6/lEEPjxT8ilZQblnTLs+HmOcnESmQ8UA+2eOCl
         AJ0A==
X-Forwarded-Encrypted: i=1; AJvYcCVNexS17/kUi2JTMr1qTvTgf72Y3Y4KRztBqqLhMC9STGBP2Hl3ibY81CxqOHExerR38XYaVbp+6fDJr/17cLC3odgKpql6EBEeL4oDssYNZQhTDL3lHIMapBZrulyueEbVCakQPz3ffacN
X-Gm-Message-State: AOJu0Yy1G7veG4GvkPRAwnwA225my6m4CAhfmkdSK0jM9MUtd/JveRh+
	f47hMbv+t30v4ge9SHLUKFAQ3Y8igjDsc22nK2NLbnqWfoLGNt9e
X-Google-Smtp-Source: AGHT+IHMzySS9z0jHhKmT3HF2YtAsllf7EXbueCkq/F4877UCb8uzulSuynH0AShEq45YQ0nXlKzcA==
X-Received: by 2002:a17:90a:c284:b0:299:8dac:e2eb with SMTP id f4-20020a17090ac28400b002998dace2ebmr2496209pjt.29.1709321284007;
        Fri, 01 Mar 2024 11:28:04 -0800 (PST)
Received: from localhost.localdomain ([2407:7000:8942:5500:fae4:3bff:fecb:410])
        by smtp.gmail.com with ESMTPSA id bf3-20020a17090b0b0300b0029b178a7068sm2667851pjb.50.2024.03.01.11.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 11:28:03 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	linux-crypto@vger.kernel.org
Cc: akpm@linux-foundation.org,
	chrisl@kernel.org,
	sjenning@redhat.com,
	vitaly.wool@konsulko.com,
	linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v7] crypto: scompress: remove memcpy if sg_nents is 1 and pages are lowmem
Date: Sat,  2 Mar 2024 08:27:45 +1300
Message-Id: <20240301192745.14987-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

while sg_nents is 1, which is always true for the current kernel
as the only user - zswap is this case, we might have a chance to
remove memcpy, thus improve the performance.
Though sg_nents is 1, its buffer might cross two pages. If those
pages are highmem, we have no cheap way to map them to contiguous
virtual address because kmap doesn't support more than one page
(kmap single higmem page could be still expensive for tlb) and
vmap is expensive.
So we also test and enure page is not highmem in order to safely
use page_to_virt before removing the memcpy. The good news is
that in the most majority of cases, we are lowmem, and we are
always lowmem in those modern and popular hardware.

Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 -v7:
 * fix the problem pointed out by Herbert - flush all pages if dst
   is longer than one page.

 crypto/scompress.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/crypto/scompress.c b/crypto/scompress.c
index b108a30a7600..60bbb7ea4060 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -117,6 +117,7 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 	struct crypto_scomp *scomp = *tfm_ctx;
 	void **ctx = acomp_request_ctx(req);
 	struct scomp_scratch *scratch;
+	void *src, *dst;
 	unsigned int dlen;
 	int ret;
 
@@ -134,13 +135,25 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 	scratch = raw_cpu_ptr(&scomp_scratch);
 	spin_lock(&scratch->lock);
 
-	scatterwalk_map_and_copy(scratch->src, req->src, 0, req->slen, 0);
+	if (sg_nents(req->src) == 1 && !PageHighMem(sg_page(req->src))) {
+		src = page_to_virt(sg_page(req->src)) + req->src->offset;
+	} else {
+		scatterwalk_map_and_copy(scratch->src, req->src, 0,
+					 req->slen, 0);
+		src = scratch->src;
+	}
+
+	if (req->dst && sg_nents(req->dst) == 1 && !PageHighMem(sg_page(req->dst)))
+		dst = page_to_virt(sg_page(req->dst)) + req->dst->offset;
+	else
+		dst = scratch->dst;
+
 	if (dir)
-		ret = crypto_scomp_compress(scomp, scratch->src, req->slen,
-					    scratch->dst, &req->dlen, *ctx);
+		ret = crypto_scomp_compress(scomp, src, req->slen,
+					    dst, &req->dlen, *ctx);
 	else
-		ret = crypto_scomp_decompress(scomp, scratch->src, req->slen,
-					      scratch->dst, &req->dlen, *ctx);
+		ret = crypto_scomp_decompress(scomp, src, req->slen,
+					      dst, &req->dlen, *ctx);
 	if (!ret) {
 		if (!req->dst) {
 			req->dst = sgl_alloc(req->dlen, GFP_ATOMIC, NULL);
@@ -152,8 +165,17 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 			ret = -ENOSPC;
 			goto out;
 		}
-		scatterwalk_map_and_copy(scratch->dst, req->dst, 0, req->dlen,
-					 1);
+		if (dst == scratch->dst) {
+			scatterwalk_map_and_copy(scratch->dst, req->dst, 0,
+						 req->dlen, 1);
+		} else {
+			int nr_pages = DIV_ROUND_UP(req->dst->offset + req->dlen, PAGE_SIZE);
+			int i;
+			struct page *dst_page = sg_page(req->dst);
+
+			for (i = 0; i < nr_pages; i++)
+				flush_dcache_page(dst_page + i);
+		}
 	}
 out:
 	spin_unlock(&scratch->lock);
-- 
2.34.1


