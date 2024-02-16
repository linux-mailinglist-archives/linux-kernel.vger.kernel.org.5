Return-Path: <linux-kernel+bounces-68047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8D385754A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1C5CB21003
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB6F1401C;
	Fri, 16 Feb 2024 04:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9laoRfr"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB7E10788;
	Fri, 16 Feb 2024 04:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708056553; cv=none; b=ds4+6ILfTv//s4UdI/tGzrhhL5fJOY/rTrp4Yq56sm3VrRxWsmNeiw58361ByPERofQyg45ZgTMZeW4JZVbbKO+u/NOLPwG9PwIQjSGfzTUHzbs70K5dCDx9u43dow8lVk13epXkRGsrPfEpoMFsh5ArzoZ8dsDqeVKiO832kA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708056553; c=relaxed/simple;
	bh=OXsYoToIjgeSRYAs9X9E0bo5WCdOjPMMPVgmJGURH78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qznwB3oiexBQtinZgQY/92Z+Mzt1VMTj3KjhU9rdwrjKv/SorVpy/9hUeA5CHZVe2jSiIA4NlmTCchawOKiypF34rtM7wbtJeAdenB6ObItRxsW1etKUK3ECldC5ssYLhWiR6nP0dDQ51wZdCBKKI8hl3vr2imO/dHx4xvJO9IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9laoRfr; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-296e22f85abso1300705a91.3;
        Thu, 15 Feb 2024 20:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708056551; x=1708661351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kW/qQndLj7MYeSMYgAPMliKXg25U647vW1M3U8+Bgew=;
        b=W9laoRfrE/T09iHCVRLFbI8zka3kijD7BoRxno6o/kmTi5KhiwxvnaQS2u5W0kR0+r
         bWjFe0SbynejbmGc0u7uMk+uNY2apLeN2MGRsAbaUuBoHs+s2/be0wPOgum3OtKi9ZMW
         /pSvlZ+0z7Dmrl5Boq2Xq5pTbNdZiDeIoHj83W+2A4AQ8dUpou7EPLxesGAStGoEca5u
         1oTRXuJVqAI1PymDnaKtT6y4WHfli+1dekEofu7PlIQ7fLm3MqbKfFDnlKS5pDhszCnY
         dTegKOKgCHdqAQ4OmPq0Kpmhkrdr7fzNJFSea2s2KhiBBej2VjO4JXgaP/u54YbVv5dk
         NfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708056551; x=1708661351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kW/qQndLj7MYeSMYgAPMliKXg25U647vW1M3U8+Bgew=;
        b=amcm23+UC2DIrWlqd0A9BVlBbwES5CS1z13WZPIuEtNYR5yfEMfwLlpgiW3QQD3QUc
         8Z8cmPIdJ3BjULee8alGPVyub8x7KqIr4BS+u3wQUjcyMylOEbg+5YqMonHutSX2os+9
         nLIcHc3Fx0NW3xB3+nATjbMLWw8MLDuyF5XUAbod9DISHXLGoUnd9QHXMWqTBz2lidsf
         dr2d7N2UyrnFlUXtj6KDdh3yLnHnABOdf8Vj7ciEWBLr51olAt8WToxiAxSWgF/ahZN4
         huRpDDWdLdyAlBOqCy8f2gCgER1suCPl7N2lbly+J4UAURU6ZzlqJHLLE0Bl5ReOmqSp
         N1wg==
X-Forwarded-Encrypted: i=1; AJvYcCVBd6BzBsEMbIYRqVw8bTpUa6WkuVChWD6h/a+Xv5hwdrlTzx30vOyRLV0Pw4ZtvOuPLdsIeu9mi5MPAckBG0ikuNFWwZxeH5Bl7cftSDOu8ltTR3RXv81kMyLF8Y7ac75l+KgdhEllRlh1
X-Gm-Message-State: AOJu0YzSWeuntVGnFEGf9SdF0zTzN6OOIDEaQVfJORfKBG7JI/1iJpGz
	6hKU0Bvuy5ff4TYXZHP8bpPuId3yIZQBoZjd49oSlIC7I/A3/CgN
X-Google-Smtp-Source: AGHT+IGAI6evbaJJ5nvBvX/krSGwKcXuM/Fjm1hRJ4n+X39jOxzqtqrVSivqkrRIltKTg3jrBP8pEQ==
X-Received: by 2002:a17:90a:eac1:b0:298:d1d3:9ef4 with SMTP id ev1-20020a17090aeac100b00298d1d39ef4mr3368864pjb.27.1708056551160;
        Thu, 15 Feb 2024 20:09:11 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:f28b:3925:777f:45d4])
        by smtp.gmail.com with ESMTPSA id pt12-20020a17090b3d0c00b00298ff26e4c8sm2321393pjb.26.2024.02.15.20.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 20:09:10 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	davem@davemloft.net,
	hannes@cmpxchg.org,
	herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	yosryahmed@google.com,
	zhouchengming@bytedance.com
Cc: chriscli@google.com,
	chrisl@kernel.org,
	ddstreet@ieee.org,
	linux-kernel@vger.kernel.org,
	sjenning@redhat.com,
	vitaly.wool@konsulko.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH v2 3/3] crypto: scompress: remove memcpy if sg_nents is 1
Date: Fri, 16 Feb 2024 17:08:15 +1300
Message-Id: <20240216040815.114202-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216040815.114202-1-21cnbao@gmail.com>
References: <20240216040815.114202-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

while sg_nents is 1 which is always true for the current kernel
as the only user - zswap is the case, we should remove two big
memcpy.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 crypto/scompress.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/crypto/scompress.c b/crypto/scompress.c
index b108a30a7600..50a487eac792 100644
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
+	if (sg_nents(req->src) == 1) {
+		src = kmap_local_page(sg_page(req->src)) + req->src->offset;
+	} else {
+		scatterwalk_map_and_copy(scratch->src, req->src, 0,
+					 req->slen, 0);
+		src = scratch->src;
+	}
+
+	if (req->dst && sg_nents(req->dst) == 1)
+		dst = kmap_local_page(sg_page(req->dst)) + req->dst->offset;
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
@@ -152,10 +165,19 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
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
+	if (src != scratch->src)
+		kunmap_local(src);
+	if (dst != scratch->dst)
+		kunmap_local(dst);
+
 	spin_unlock(&scratch->lock);
 	return ret;
 }
-- 
2.34.1


