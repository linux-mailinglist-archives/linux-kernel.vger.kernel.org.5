Return-Path: <linux-kernel+bounces-167453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2288BA9C7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2BE1F25AD6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E6415357D;
	Fri,  3 May 2024 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IwMjDbm/"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0439E153BD8
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727948; cv=none; b=VOhrtUCc5OWu5jMlujTbDBkIURa5klzanqNxQRHqbg80uoJ4dNRrC3+gnxFKzb05X+U8TbB65R9JpoTFZGaU4So8NtuSwa3Ye7IOqB6IsXPCDsaq5yajEb1ksmJWecLvf2wz7QUE4hJ14eMObEWjtje0g/jYDiMwPaAd2K+r2t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727948; c=relaxed/simple;
	bh=eO1aD3GYThTWX8reEG9IHaYxayASI5pIn3ZwxQRjfeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lbdp4fIIOnelIGHqVMf8cXsz5m5ZRgjfgIuErDOQeVpGDQz9QIiOeg69mTq1BXuhOjxH9wIagNw/wzO1/A8ifSVe5+NXZsFHOEjP/eAX36Ytes97kk9yspQtCOBWM4Ro+iNJCtAq5ECUB2vf7KWsNR8lqrubEq9EdBvlJxMZISM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IwMjDbm/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f3e3d789cdso6496654b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 02:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714727946; x=1715332746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NlFlAwd7AfzOKAUbFYigEp0/QoNwrE2imVLFTnbDxc=;
        b=IwMjDbm/hX23VewTatSdy1IiTXYPJ2dKM9Q3QgfqVwsU/O3g8PvK8ZWI8KiVrQc721
         laVvRAEBVyLUH2nsfE4143F62KA2ei35TwpB4PDhzMNn4Gl4BKf6Oj/0zMJN4azRFA2B
         knB+MnrNF97nHgYR1Kv8sEO2QZWlZL8wnsMtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714727946; x=1715332746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NlFlAwd7AfzOKAUbFYigEp0/QoNwrE2imVLFTnbDxc=;
        b=Ov/1h0Cy7NA9TdtpazpML2QXqq/ecqDxRrfLT7v7F24peKHnMtzb2tvgZJo6Aw7S+7
         6vt8ZpraadFeQiclNDlv6aXX1muEhL7mY9Fbx6q2xEfKGvmtJjBHAimlPqkAJuSBp5xx
         mbaqFh/0mF6JxVND3qZ+zooIuEm9Q4lTI1kKnrxwGMAnhTuO46zYyjTzdc3O/BIQHXGD
         aMO73r29bQPRC5eC6EGdrjl6fEq1fwV7awSbZfki7H5Q1IA6qg6pjhlJco0NZW9PuZgM
         wUugCROme2iWEGKiV71SlhzUVewUA4Hg/pfLn4kJfk7/bRgyYm8NtGnOkEZ0gHb9FtQs
         mhcA==
X-Gm-Message-State: AOJu0YyJRZ9IBJXoFCOjPAiQfnI7vb9LijJmTQkoXiM2Is7Bq5pqC7Zn
	vn9sFOoSUaSGpM3pSO4Nln0+bGSOLOZSvclRXkNelIJpzF9GdohOP13uQdbA9Q==
X-Google-Smtp-Source: AGHT+IEss/I5uy/yYKBxcXXnNraFRQZ56Afeli3+NlY5upIAcfp/ukWooVoWmDX0bG0NTr8rjslCnA==
X-Received: by 2002:a05:6300:8089:b0:1a7:3d2a:7383 with SMTP id ap9-20020a056300808900b001a73d2a7383mr2348105pzc.18.1714727946298;
        Fri, 03 May 2024 02:19:06 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:dc60:24a3:e365:f27c])
        by smtp.gmail.com with ESMTPSA id j6-20020aa78d06000000b006ecec1f4b08sm2621938pfe.118.2024.05.03.02.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 02:19:06 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 13/14] zram: add dictionary support to zstd backend
Date: Fri,  3 May 2024 18:17:38 +0900
Message-ID: <20240503091823.3616962-14-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240503091823.3616962-1-senozhatsky@chromium.org>
References: <20240503091823.3616962-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for pre-trained zstd dictionaries [1]
Dictionary is loaded once (per-config) and then loaded to Cctx
and Dctx by reference, so we don't allocate extra memory.

The patch is a little non-trivial, as it seems that noone
ever attempted to use dictionaries in the linux kernel
port of zstd.

It also uses GFP_KERNEL gfp in Cctx customAlloc(). We probably
would want to do something about it. Either make sure that we
always (somehow) fully setup all Cctx contexts from non-atomic
context before we attempt to use them, come up with some sort
of custom allocator or stop calling zcomp_compress() from atomic
context.

[1] https://github.com/facebook/zstd/blob/dev/programs/zstd.1.md#dictionary-builder

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_zstd.c | 119 ++++++++++++++++++++++++------
 1 file changed, 96 insertions(+), 23 deletions(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index b2fb94902bef..6220c154e54e 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -12,23 +12,47 @@ struct zstd_ctx {
 	zstd_dctx *dctx;
 	void *cctx_mem;
 	void *dctx_mem;
+	ZSTD_customMem cctx_cmem;
+	ZSTD_customMem dctx_cmem;
+	ZSTD_CDict *cdict;
+	ZSTD_DDict *ddict;
 	s32 level;
 };
 
+/*
+ * Cctx allocator.customAlloc() is called from zcom_compress(), which is
+ * called under local-lock (per-CPU compression stream), so we need to
+ * use GFP_ATOMIC here.
+ */
+static void *zstd_cctx_alloc(void *opaque, size_t size)
+{
+	return kvzalloc(size, GFP_ATOMIC);
+}
+
+static void *zstd_dctx_alloc(void *opaque, size_t size)
+{
+	return kvzalloc(size, GFP_KERNEL);
+}
+
+static void zstd_ctx_free(void *opaque, void *address)
+{
+	kvfree(address);
+}
+
 static void zstd_destroy(void *ctx)
 {
 	struct zstd_ctx *zctx = ctx;
 
 	vfree(zctx->cctx_mem);
 	vfree(zctx->dctx_mem);
+	ZSTD_freeCDict(zctx->cdict);
+	ZSTD_freeDDict(zctx->ddict);
 	kfree(zctx);
 }
 
 static void *zstd_create(struct zcomp_config *config)
 {
-	zstd_parameters params;
 	struct zstd_ctx *ctx;
-	size_t sz;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -39,24 +63,64 @@ static void *zstd_create(struct zcomp_config *config)
 	else
 		ctx->level = ZSTD_defaultCLevel();
 
-	params = zstd_get_params(ctx->level, PAGE_SIZE);
-	sz = zstd_cctx_workspace_bound(&params.cParams);
-	ctx->cctx_mem = vzalloc(sz);
-	if (!ctx->cctx_mem)
-		goto error;
-
-	ctx->cctx = zstd_init_cctx(ctx->cctx_mem, sz);
-	if (!ctx->cctx)
-		goto error;
-
-	sz = zstd_dctx_workspace_bound();
-	ctx->dctx_mem = vzalloc(sz);
-	if (!ctx->dctx_mem)
-		goto error;
-
-	ctx->dctx = zstd_init_dctx(ctx->dctx_mem, sz);
-	if (!ctx->dctx)
-		goto error;
+	ctx->cctx_cmem.customAlloc = zstd_cctx_alloc;
+	ctx->cctx_cmem.customFree = zstd_ctx_free;
+	ctx->dctx_cmem.customAlloc = zstd_dctx_alloc;
+	ctx->dctx_cmem.customFree = zstd_ctx_free;
+
+	if (config->dict_sz == 0) {
+		zstd_parameters params;
+		size_t sz;
+
+		params = zstd_get_params(ctx->level, PAGE_SIZE);
+		sz = zstd_cctx_workspace_bound(&params.cParams);
+		ctx->cctx_mem = vzalloc(sz);
+		if (!ctx->cctx_mem)
+			goto error;
+
+		ctx->cctx = zstd_init_cctx(ctx->cctx_mem, sz);
+		if (!ctx->cctx)
+			goto error;
+
+		sz = zstd_dctx_workspace_bound();
+		ctx->dctx_mem = vzalloc(sz);
+		if (!ctx->dctx_mem)
+			goto error;
+
+		ctx->dctx = zstd_init_dctx(ctx->dctx_mem, sz);
+		if (!ctx->dctx)
+			goto error;
+	} else {
+		ZSTD_compressionParameters params;
+
+		ctx->cctx = ZSTD_createCCtx_advanced(ctx->cctx_cmem);
+		if (!ctx->cctx)
+			goto error;
+
+		ctx->dctx = ZSTD_createDCtx_advanced(ctx->dctx_cmem);
+		if (!ctx->dctx)
+			goto error;
+
+		params = ZSTD_getCParams(ctx->level, PAGE_SIZE,
+					 config->dict_sz);
+
+		ctx->cdict = ZSTD_createCDict_advanced(config->dict,
+						       config->dict_sz,
+						       ZSTD_dlm_byRef,
+						       ZSTD_dct_auto,
+						       params,
+						       ctx->cctx_cmem);
+		if (!ctx->cdict)
+			goto error;
+
+		ctx->ddict = ZSTD_createDDict_advanced(config->dict,
+						       config->dict_sz,
+						       ZSTD_dlm_byRef,
+						       ZSTD_dct_auto,
+						       ctx->dctx_cmem);
+		if (!ctx->ddict)
+			goto error;
+	}
 
 	return ctx;
 
@@ -72,8 +136,12 @@ static int zstd_compress(void *ctx, const unsigned char *src,
 	const zstd_parameters params = zstd_get_params(zctx->level, PAGE_SIZE);
 	size_t ret;
 
-	ret = zstd_compress_cctx(zctx->cctx, dst, *dst_len,
-				 src, PAGE_SIZE, &params);
+	if (!zctx->cdict)
+		ret = zstd_compress_cctx(zctx->cctx, dst, *dst_len,
+					 src, PAGE_SIZE, &params);
+	else
+		ret = ZSTD_compress_usingCDict(zctx->cctx, dst, *dst_len,
+					       src, PAGE_SIZE, zctx->cdict);
 	if (zstd_is_error(ret))
 		return -EINVAL;
 	*dst_len = ret;
@@ -86,7 +154,12 @@ static int zstd_decompress(void *ctx, const unsigned char *src, size_t src_len,
 	struct zstd_ctx *zctx = ctx;
 	size_t ret;
 
-	ret = zstd_decompress_dctx(zctx->dctx, dst, PAGE_SIZE, src, src_len);
+	if (!zctx->ddict)
+		ret = zstd_decompress_dctx(zctx->dctx, dst, PAGE_SIZE,
+					   src, src_len);
+	else
+		ret = ZSTD_decompress_usingDDict(zctx->dctx, dst, PAGE_SIZE,
+						 src, src_len, zctx->ddict);
 	if (zstd_is_error(ret))
 		return -EINVAL;
 	return 0;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


