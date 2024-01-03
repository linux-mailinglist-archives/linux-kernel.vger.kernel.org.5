Return-Path: <linux-kernel+bounces-15356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B50A2822A97
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B6C1C2323B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13EC1864D;
	Wed,  3 Jan 2024 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0RGhNyF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB1818625;
	Wed,  3 Jan 2024 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-595ac2b6c59so920878eaf.2;
        Wed, 03 Jan 2024 01:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704275447; x=1704880247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Spb8sXhq6BQgZHawgszBp/yoNsRKTOzDWAXTsmTatzQ=;
        b=S0RGhNyFR7clISnCqdo9DeCZh1DBZmfSOtPWA2QtAOK7SuC8DUK77nawxsQN1daiAM
         Ys3k8LzZrlfza6QsQLsPUQfn5YhZEGD22tn/p+8dKj4uTW+mQOneoLAhGL7qb6QxtEf1
         y7tuaJlen53L0FYJB/OR40/hrDTiiB7K+yO8ovZasAPSejIOTlDKrI3ccM8E7mc9jLtx
         y3j9RbJISQSkIUgMR1heqe/hgPSh/tKtKOyyRkleZNB/Q+ElOja3Tr4sGRQABe+43+c/
         wrMz2BAVYLmWNcqtjAcN9TLjcBtKgP4DG1Rlb1M8KzmdWnYfI/1Jq0PEvZGeN8K+JsCm
         D9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704275447; x=1704880247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Spb8sXhq6BQgZHawgszBp/yoNsRKTOzDWAXTsmTatzQ=;
        b=E87ZtfuLoV2nDr2fpciIc1OXpXO3HkDdMVFkUSwgUQqeeHCPUje2Awl8ra5SnvDXst
         NDd5klZXyp/2IG96BHCM+m24+TnW8lJ2OzHaeUfvrsVRTMi9d+5z0RzregIGnQSnLz96
         FEV0DFFTe+PEfAXdqh7k00DinRMsCZ9MGK4YTjNEdMVUARIrcUvvIkHRW73n3JVq36mp
         las5TAZSF3kOQD7kfeTfL+g7pNAgv0ZxrAEJB88CyYWeFULAoB6O5mYI6FhuX/rWL7SV
         GxjgWBt5Ldxga1ml/tZEfuzKce+jZ9Yjwn5EI2wD46lQNyKwqHwiw/iphiQO7K8DqQRX
         vaNA==
X-Gm-Message-State: AOJu0Yw/4QlamqbFL/ukPLTvno/oJfs2LZlxa935a5GROoRQDqtjM6Vf
	7BYc8llFAAfX3mw4GIT79EY=
X-Google-Smtp-Source: AGHT+IGWL4R/FI9TYmsj+r7+/K6fqa31rQlyfEGBvFn+SUDBIfMJqSQf7Q/5XUbHS6iSKuuDD2GKeA==
X-Received: by 2002:a05:6358:7f1e:b0:172:e3f6:12c0 with SMTP id p30-20020a0563587f1e00b00172e3f612c0mr17022730rwn.46.1704275446906;
        Wed, 03 Jan 2024 01:50:46 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:a7d6:f37a:9130:cd96])
        by smtp.gmail.com with ESMTPSA id a34-20020a631a22000000b005c65e82a0cbsm21823483pga.17.2024.01.03.01.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 01:50:46 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	akpm@linux-foundation.org,
	ddstreet@ieee.org,
	sjenning@redhat.com,
	vitaly.wool@konsulko.com,
	linux-crypto@vger.kernel.org
Cc: chriscli@google.com,
	chrisl@kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	yosryahmed@google.com,
	zhouchengming@bytedance.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH 3/3] crypto: scompress: remove memcpy if sg_nents is 1
Date: Wed,  3 Jan 2024 22:50:06 +1300
Message-Id: <20240103095006.608744-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103095006.608744-1-21cnbao@gmail.com>
References: <20240103095006.608744-1-21cnbao@gmail.com>
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
 crypto/scompress.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/crypto/scompress.c b/crypto/scompress.c
index 442a82c9de7d..d1bb40ef83a2 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -117,6 +117,7 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 	struct crypto_scomp *scomp = *tfm_ctx;
 	void **ctx = acomp_request_ctx(req);
 	struct scomp_scratch *scratch;
+	void *src, *dst;
 	int ret;
 
 	if (!req->src || !req->slen || req->slen > SCOMP_SCRATCH_SIZE)
@@ -131,13 +132,26 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
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
+	if (req->dst && sg_nents(req->dst) == 1) {
+		dst = kmap_local_page(sg_page(req->dst)) + req->dst->offset;
+	} else {
+		dst = scratch->dst;
+	}
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
@@ -146,10 +160,17 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 				goto out;
 			}
 		}
-		scatterwalk_map_and_copy(scratch->dst, req->dst, 0, req->dlen,
-					 1);
+		if (dst == scratch->dst) {
+			scatterwalk_map_and_copy(scratch->dst, req->dst, 0,
+						 req->dlen, 1);
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


