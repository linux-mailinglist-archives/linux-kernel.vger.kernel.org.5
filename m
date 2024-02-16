Return-Path: <linux-kernel+bounces-67984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 900E48573EE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6941F24D43
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 03:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A89FC05;
	Fri, 16 Feb 2024 03:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX0IYrqJ"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02327FBE5
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 03:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708052758; cv=none; b=QFtIsyalXAxhTs/8ds/VDL6SHHnTAqK82HbbqyMfxzxMbEZc1qeUHp6ZI8pmU5WKzgtrXaabz6gMuwdxhHVeEkuenZnAoSffR5Bw173n5WLmzpNCLf3anuX3eYkbKgYcpUkSd3XHWHmrP+A6xQ1NZG3WG29MGckmRyN+PVlmZHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708052758; c=relaxed/simple;
	bh=8dqe4bC0acMyEVaUnbbYMP4IvFDUFr77j4xc05dO4WU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lf75XfL/PXhjBOJqyZPgHYSCyqwztqgJTSePdYmfGa7UE7iLCO9ysTQ775SViAonJES4N+RsBgGCrjqhpcYPebveGZVIWpi6sUtippz+0bXEZl8jonJVqNLOnhK8D8K/tySYcRLIYgi7ok7xn4eTgl+i0/0RywJ6EsgWaghlQZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HX0IYrqJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e104196e6eso1661996b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708052756; x=1708657556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I7PSTWVmaYWH42bBGC9KPcBO882rqj+Igdtxrd/WR4k=;
        b=HX0IYrqJr+6dhxkxlZUEZ0tNL9F8cn/SZ79MKBIShu3jIOrx4EgOBW3qb1PufNJN8/
         2e/c4jaAxyKjpDqUJzZdj+jF8dx+9SW0ZRhJwdDQT0wBmjAiWF3hXFh9l8F8mmvZJhF1
         /Bt4EmUqQ0FlzPcgQ8wtCH9PpmcBO/u5mgKmcy5fXDpPzja+K3YjdukBm2GnAxKN+sxQ
         L2sVfW8L3YMfGQtHNP1LUVkWVKA8mwuJI9yP5xgbIVsl7zS9f6LABiPngvXXvAuIlzTI
         K/HXm8dAAA9pSTBJAVGrYQEIkGtF7CB6wGGnKAo/hXcWVTUuiOI4C5e9M00+sTjUqb9t
         wHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708052756; x=1708657556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7PSTWVmaYWH42bBGC9KPcBO882rqj+Igdtxrd/WR4k=;
        b=O3s7Sie7FaznULonOfgCR6iUR4gpvAIaUWKmzqE+pZk2VKqqjxlDLTt1pIq/ZUzhJt
         /KP+TGKYITwSDbApDw4ir1TTu9hvwvGtvWzDNRhdbEEvfn+P16aIUHZXlHckRmbATuMd
         bJTxycI2x9XEKo4dylWx3jXxc9qQ1oenFkAi0/xPeBqueN4L4UhLmldrR6Bv+fU/J0cA
         oTFRZAWXMQTJvX2LpcjocD3fhyRTZzkZ9Do4lHHEfRYFK3m+0jTY29U7wUUdLnI+HyZ/
         6iz36M8Z2wD6hsJT9v2JFYIQsK8KIo1RW9AqLpojNwobrlSvc+MCcZ55iw/ZVy1njePd
         iRQQ==
X-Gm-Message-State: AOJu0Yyw/o0sSPsXaVGxdMNOOFinzH0fmsiwQibxEIHFJAI3ezUk8w8/
	/rt6AcUVO1i/c3YvyvYSyv2jyTI+82Rk3kFDpXrQRR0B1f3QVpXf
X-Google-Smtp-Source: AGHT+IG/Jyyl1szf73bIkO4ooPyYiVveqIprdngc3VwOxDhtbiHy2HZn3gG5Y8dH1/cckeRAeAjZvg==
X-Received: by 2002:a05:6a00:22c9:b0:6e0:fb6e:124e with SMTP id f9-20020a056a0022c900b006e0fb6e124emr4794443pfj.26.1708052756168;
        Thu, 15 Feb 2024 19:05:56 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:f28b:3925:777f:45d4])
        by smtp.gmail.com with ESMTPSA id lc25-20020a056a004f5900b006e0eece1ca4sm2017757pfb.4.2024.02.15.19.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 19:05:55 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	yosryahmed@google.com
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] mm: zswap: increase reject_compress_poor but not reject_compress_fail if compression returns ENOSPC
Date: Fri, 16 Feb 2024 16:05:39 +1300
Message-Id: <20240216030539.110404-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

My commit fc8580edbaa6 ("mm: zsmalloc: return -ENOSPC rather than -EINVAL
in zs_malloc while size is too large") wanted to depend on zs_malloc's
returned ENOSPC to distinguish the case that compressed data is larger
than the original data from normal compression cases. The commit, for
sure, was correct and worked as expected but the code wouldn't run to
there after commit 744e1885922a ("crypto: scomp - fix req->dst buffer
overflow") as Chengming's this patch makes zswap_store() goto out
immediately after the special compression case happens. So there is
no chance to execute zs_malloc() now. We need to fix the count right
after compressions return ENOSPC.

Fixes: fc8580edbaa6 ("mm: zsmalloc: return -ENOSPC rather than -EINVAL in zs_malloc while size is too large")
Cc: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/zswap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 6319d2281020..9a21dbe8c056 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1627,7 +1627,10 @@ bool zswap_store(struct folio *folio)
 	dlen = acomp_ctx->req->dlen;
 
 	if (ret) {
-		zswap_reject_compress_fail++;
+		if (ret == -ENOSPC)
+			zswap_reject_compress_poor++;
+		else
+			zswap_reject_compress_fail++;
 		goto put_dstmem;
 	}
 
-- 
2.34.1


