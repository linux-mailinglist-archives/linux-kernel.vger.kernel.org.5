Return-Path: <linux-kernel+bounces-71995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8233385AD9A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C679C282C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA1E53E16;
	Mon, 19 Feb 2024 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ei9Rce7K"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364CA53E13
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708377603; cv=none; b=DBIlNbKgb3vBzR7O/zrhXJ9YFLgGgzMNYt3cC28qOqCZwYNGIvVGX0rfqodn/5McirVqZaa0LTPVTioKpHuNQ6Jl+Hw73FafxO2FT/fHZMd/Z3sujEj3rixafuoR1a7PMcMUyD2lgkNWd8kPqm1DsEeXb68d1g0xCQKYvgk6oX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708377603; c=relaxed/simple;
	bh=DgQ2fXzVj6rzCYfQy6bc1ZxdYWeW5jg3gg+WwPIZre4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eS6qgQy/TmL3vXfCkmdteN95+5PZTQMjeurcmUVusT1oKwFlKF0BJscd2Itm1djglAgGHawpbGs0CxmpJVQbJg5t8reD8iv0AjHNKaR6vM2XgDnCQcFM5Gi0D3WxNiGH3lgoJXBsLsQFC4rFKWgqY1FFTe9WME3x6esJBbcv6Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ei9Rce7K; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dc09556599so6708995ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708377601; x=1708982401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wxEqpQi/TVfPO8koWPr1g27ez4NagydW/9mU4Hd8GmM=;
        b=Ei9Rce7K8CXViY5/2RxRPfa0Cn5NnyiARg8cS5geTY6ul+9wSCu0FUbs/pff7DM/ZE
         vafGqNZ5+jjrFAdI0V6GU2tnK1QzY7wa7uWMt2YkHlJaGXSKxxdHkXRd13sMUV+2dJdy
         rMmgeqRqkgF7MdryC6DWnoDw4kB50FfB8HWCzK/uIZq3M66GWNzWoUU7WgcIddS/TFQA
         vDPT7ThC3MvaBqtcbB6nWcFxE9aEgQbl4IHWjOGQLOBJWYUek4jYRZ4orhcTlvYF5H9Q
         GZmztfTPext9oc7M8/pkaAspRNnz6jIegATjOL4lqBn9Zpm86gd15sUUJjFFOk3Nf17o
         f2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708377601; x=1708982401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxEqpQi/TVfPO8koWPr1g27ez4NagydW/9mU4Hd8GmM=;
        b=SPQ0JCvT2tXnGC1w8dWPqsuhFxhM/M3nO1QgOBCuPegkfh0CqzLeg+/p30h06Lwdgg
         1CjAHiR+eX2LQbRoJbAxe2awRXRsnAgxEMOZIh9+FfmWI2QIhXdkQBDDaee9+YFLinMu
         nhU8a1T5mZBzUITPT7y+uE1VIMkWiyAqHgMHFqs7rXD/UPw7LD+Cu+U/6TBS8K2as1Vz
         6KMJOqUkdLR92AZvZiokgA6Qq3LYcciaGRYMnFwBaU2DccL2CnojclBasZCYI5QNBQ+K
         RetW6m58OLVH05z3fJKKqDzYJmnDnO6/sNoyjlJ9q4zqz/BpHamXOrRijVSuQ/brYGuL
         lKiA==
X-Gm-Message-State: AOJu0YyveUJV/THdxgwGYEJK2y+cy4kQX5+lb2ycvIUoPSen+CUMfU0T
	JH7dOQi57W0LC7vWzdfVQER5ZRDCWovoAtktrtP0FwgXbYnIJc9FpiF0NUoXTi8=
X-Google-Smtp-Source: AGHT+IG0ivqZcyUbHYdBD0UEK+njjVj6pKBuqsBlmG/eq0/vJGhEObBt2x788f5FBxVjAaZoCKNIuA==
X-Received: by 2002:a17:902:ec90:b0:1db:c564:5938 with SMTP id x16-20020a170902ec9000b001dbc5645938mr10379108plg.60.1708377601099;
        Mon, 19 Feb 2024 13:20:01 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:dd49:f5c6:f613:4a7e])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902c70300b001d92a2b258esm4834386plp.118.2024.02.19.13.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 13:20:00 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	senozhatsky@chromium.org,
	zhouchengming@bytedance.com,
	yosryahmed@google.com
Cc: linux-kernel@vger.kernel.org,
	v-songbaohua@oppo.com
Subject: [PATCH v3] mm: zswap: increase reject_compress_poor but not reject_compress_fail if compression returns ENOSPC
Date: Tue, 20 Feb 2024 10:19:35 +1300
Message-Id: <20240219211935.72394-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

We used to rely on the returned -ENOSPC of zpool_malloc() to increase
reject_compress_poor. But the code wouldn't get to there after commit
744e1885922a ("crypto: scomp - fix req->dst buffer overflow") as the
new code will goto out immediately after the special compression case
happens. So there might be no longer a chance to execute zpool_malloc
now. We are incorrectly increasing zswap_reject_compress_fail instead.
Thus, we need to fix the counters handling right after compressions
return ENOSPC. This patch also centralizes the counters handling for
all of compress_poor, compress_fail and alloc_fail.

Fixes: 744e1885922a ("crypto: scomp - fix req->dst buffer overflow")
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 -v3:
  * rebase on top of mm-unstable according to Yosry and Andrew
  * collect review and ack tags of Nhat, Yosry and Chengming, thanks!

 mm/zswap.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 62fe307521c9..51de79aa8659 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1021,12 +1021,12 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 {
 	struct crypto_acomp_ctx *acomp_ctx;
 	struct scatterlist input, output;
+	int comp_ret = 0, alloc_ret = 0;
 	unsigned int dlen = PAGE_SIZE;
 	unsigned long handle;
 	struct zpool *zpool;
 	char *buf;
 	gfp_t gfp;
-	int ret;
 	u8 *dst;
 
 	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
@@ -1057,26 +1057,18 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 	 * but in different threads running on different cpu, we have different
 	 * acomp instance, so multiple threads can do (de)compression in parallel.
 	 */
-	ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
+	comp_ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
 	dlen = acomp_ctx->req->dlen;
-	if (ret) {
-		zswap_reject_compress_fail++;
+	if (comp_ret)
 		goto unlock;
-	}
 
 	zpool = zswap_find_zpool(entry);
 	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
 	if (zpool_malloc_support_movable(zpool))
 		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
-	ret = zpool_malloc(zpool, dlen, gfp, &handle);
-	if (ret == -ENOSPC) {
-		zswap_reject_compress_poor++;
-		goto unlock;
-	}
-	if (ret) {
-		zswap_reject_alloc_fail++;
+	alloc_ret = zpool_malloc(zpool, dlen, gfp, &handle);
+	if (alloc_ret)
 		goto unlock;
-	}
 
 	buf = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
 	memcpy(buf, dst, dlen);
@@ -1086,8 +1078,15 @@ static bool zswap_compress(struct folio *folio, struct zswap_entry *entry)
 	entry->length = dlen;
 
 unlock:
+	if (comp_ret == -ENOSPC || alloc_ret == -ENOSPC)
+		zswap_reject_compress_poor++;
+	else if (comp_ret)
+		zswap_reject_compress_fail++;
+	else if (alloc_ret)
+		zswap_reject_alloc_fail++;
+
 	mutex_unlock(&acomp_ctx->mutex);
-	return ret == 0;
+	return comp_ret == 0 && alloc_ret == 0;
 }
 
 static void zswap_decompress(struct zswap_entry *entry, struct page *page)
-- 
2.34.1


