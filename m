Return-Path: <linux-kernel+bounces-75784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0F985EEE2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044A828316C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B7E1428E;
	Thu, 22 Feb 2024 02:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/EWDyal"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CAD17548;
	Thu, 22 Feb 2024 02:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708567598; cv=none; b=RTT4Vzg4j8mX2aR8C2ymLg1/AG9Shuaz2TRvzb8yTe+A/XECwR5G0smq9GiCsyEc2t5DlIgMY6CrdrgzvQztAnMi9CJajV7R6PxlG4mrqFAu0IP2GR8klhHOyB38g6iU924x5RzoMUrXI7soPzCHggZ6S9XK8SvaJmUdnYWuf58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708567598; c=relaxed/simple;
	bh=Hgwue3VsYVuGAHidF8xeWMBthAFTNIHrbSPwF1lYYYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D1dzXI3DAb4efQUl2lsTnXG5a0GrbuD0Nl0Hbu21MhXQsxpqD0CnyP/rarpjbz7P7AcQnmtLqz29wbOrFTIaRgRvIAgmLeCCiyLGRdPh2z+60pXfQJTQ65jTqTYrdLfOK6Na078sDsp3e06aOK5mYguXieesQc583qMezgjh+uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/EWDyal; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-299540b4d18so3182486a91.1;
        Wed, 21 Feb 2024 18:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708567596; x=1709172396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w64efItMlr6vgLfvpO0/b9Hh1Adb3EB97Cl6D2DGNWI=;
        b=T/EWDyalSUo5nA2o13oq7qtrKgyZR7TSPb+LqN0FjeujB9sQkfcKJ3kwL3kRUAJt9R
         TY4U4e8O6uD9gnG3h1wMQLE+wwBgDt03pk+RqNbZ0Fi6XfhxaevbEZXS9hN7/D0qoOeb
         3fNzjrEOqvBHLDY8HdzOq3phMfjq95yEEvvi0bL4dOgx68WTElaiIObEdUK1RXj+jYfL
         pAIuwmzFln9dz06/CsU7in8jXinFmKuKztcCbU6RdRBqp6oHesqYiwWd1jV9hURzCMzM
         aSQkvrBjzccvm6TPyt4uD1sCMPEc4eVZQtZoW3xC3B3Q2dnLdxdiJ3PWEZ7Yy6n0Z52G
         Txbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708567596; x=1709172396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w64efItMlr6vgLfvpO0/b9Hh1Adb3EB97Cl6D2DGNWI=;
        b=imPxQOFQCWsD5PEtz2lGzu8uX+i7BAxRTSIHo+aAcDjcT1S2a4z81GG4rK79V7S8mv
         QQmijE/g8NSb5x5yRBarqkTpKgNVNz1hDZFmTH6wHiT3vnlQ30habAbxSUeaPUn8t6br
         l1iAi0xIR13b2kXTkKBG06OfqQ0DgmUI3mxKAlE/5W3fU2kiZbuY5GpRILUVT18txuSC
         QQ8T2zAQedGfTDwSuU1x+9Kz/mb3Yf8Pq3brPdat8Xd3ZqCPjrRvgXlSDdKPSpR8X4h5
         OQ8m4FNcPuuR6GxZyE62I0oOZsV1TdrKqD4XzvwBQVXz6QTkQrDd2frXA2CCHQNbrEV8
         PoyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQsm/CG2YjLpuLVn/JkyourYbmKiZIilq8ArmD9w4JOk4/UL18/vqcKTpe+FL8uiiUr0BNa6ZjpbMiKe6QnUOKJlnbhGrSTXl2C4PUBzZbOnPvzmJ9g9Rt+lL5n4mGmbtzRvp5sppEfAPA
X-Gm-Message-State: AOJu0Yy0b8mgBfuqoXaemJ+50Il5DxvBjkaxDF9mkt3ZpUTVyJescVp+
	h9MwyF/4EiE7HMH6bLQNXWswjSzvz2vlS1j7XuwiGwuXcK/4fdYm
X-Google-Smtp-Source: AGHT+IHNRKbWdWip2xaJ4rSh42cE64zDUSUW22jkBDR/euxKv6s1FFY19/CL0X5rGWFrZG5EezLb7Q==
X-Received: by 2002:a17:90b:344f:b0:299:2038:11e5 with SMTP id lj15-20020a17090b344f00b00299203811e5mr15017066pjb.27.1708567596274;
        Wed, 21 Feb 2024 18:06:36 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:3b18:a2e2:f00b:c965])
        by smtp.gmail.com with ESMTPSA id sl6-20020a17090b2e0600b00298ca3a93f1sm2650070pjb.4.2024.02.21.18.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 18:06:35 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	linux-crypto@vger.kernel.org
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	hannes@cmpxchg.org,
	chriscli@google.com,
	chrisl@kernel.org,
	sjenning@redhat.com,
	vitaly.wool@konsulko.com,
	Barry Song <v-songbaohua@oppo.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v6] crypto: scompress: remove memcpy if sg_nents is 1 and pages are lowmem
Date: Thu, 22 Feb 2024 15:06:17 +1300
Message-Id: <20240222020617.31041-1-21cnbao@gmail.com>
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
 -v6:
  * separate it from zswap & crypto series[1] according to Herbert;
  * make sure the code is still safe when buffers cross two pages
    to address Herbert's comment
[1] https://lore.kernel.org/linux-mm/20240220064414.262582-1-21cnbao@gmail.com/

 crypto/scompress.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/crypto/scompress.c b/crypto/scompress.c
index b108a30a7600..185d2359f28b 100644
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
@@ -152,8 +165,12 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 			ret = -ENOSPC;
 			goto out;
 		}
-		scatterwalk_map_and_copy(scratch->dst, req->dst, 0, req->dlen,
-					 1);
+		if (dst == scratch->dst) {
+			scatterwalk_map_and_copy(scratch->dst, req->dst, 0,
+						 req->dlen, 1);
+		} else {
+			flush_dcache_page(sg_page(req->dst));
+		}
 	}
 out:
 	spin_unlock(&scratch->lock);
-- 
2.34.1


