Return-Path: <linux-kernel+bounces-167445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF8D8BA9B3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B585328250F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC0E1509BC;
	Fri,  3 May 2024 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gs2lgwwa"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E75A1514E9
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727930; cv=none; b=Z330juR2yT90joaKfzsLIyqzWQALCqtuLLJSrZoPFYowhE6eH0Eyw1Ytwd5qfGAJwMOD50P8VRp5bfRHhRIVH/lGR3c9TU1vo35V4n9/CYFRATJVIBCwSvkW2RmG+vICyvU0ASHeFQmdWV7qXsr+y275WFCyEM09RcPyrrZcgN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727930; c=relaxed/simple;
	bh=UiQnMZLw8RwVg3ced8tmphDbv+yDA/RRNiSvmNQXoHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5+V99g76MmdQThZdtY4J/EtoebeKuoKRsJx4aKbnvFqtHawsw9aeaWoc0rjFvPjO6jrY8SKS4a2FMv79u3q4qlBSv9SMoV1R1hdvTlUuGs8Afl6s4X19LitCpS67lX+RE6/fLioYgzp3mJhsLn0ia2wdw3ua/hzdB+0B/GLlH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gs2lgwwa; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f45020ac2cso72047b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 02:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714727928; x=1715332728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaKaXBAH/caXTF/rNTkmiQFfbGJZCn5VHOotq+7w/ag=;
        b=Gs2lgwwaqn/Ki4MpP2/mhCOB9YJJhXYaCI0hZgu29EeYEtxSnOMAg2VsfjR03CDu+N
         WxC5CjXpLrik4aUO17v2apK+Y/QLGGD/rbd56t/O71vN0poFWAjBu5Exqdh8ZgSOTV5y
         +4kB6V13UkH2jD7xbIoAsUX+lCphrY3m8iZTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714727928; x=1715332728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaKaXBAH/caXTF/rNTkmiQFfbGJZCn5VHOotq+7w/ag=;
        b=lqBdxchmdxsdQAaaOEptOkZtEM+LkR9nl/8bRzys/uszt61gcXjV6pBnqGefQwvO+5
         HPfkuefPwSB5MkNO/N/9NkaZklRDAs8ZTVaasP1tAX91NOsfmw3dYtqTcjIpqLaAkmlX
         uPjDRwJdb0Dnl0lSzZxyFq9R/T5g13aJTyEyV8vo76DAonNBNAZsfg2aWk0izUNAVkab
         sBtOfly95+KXoLlKkvAYPg3hZu8maXklOeMDwjm14izFjuk2iseaexXJrRYKHAJd/mKm
         mWRwLJxrNDl0KDBZXc8w2NxxBHTmq1cePShKbsBEdx0xj0OS4q8TQgDoiYE7yy/grDaY
         LTmA==
X-Gm-Message-State: AOJu0YwJwLHLaR3fyYcD3PIlO1GCNwsMSi7UDH7AZ96lqgzyNeSPjYMr
	CeeySRv2wrK5laBz2y9FGmA4l+OI3K1iJ0UTFPhAIsaOaY9mtSr3cI983ZmNDQ==
X-Google-Smtp-Source: AGHT+IEXkK9SHy1BKRvW2n1Hi/ESqZBt2nZsW5pDeC0ramDvrL6DtEsic/ibTfkToMn0IEsKMSRBew==
X-Received: by 2002:a05:6a00:a15:b0:6ed:21d5:b03a with SMTP id p21-20020a056a000a1500b006ed21d5b03amr2462707pfh.23.1714727927743;
        Fri, 03 May 2024 02:18:47 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:dc60:24a3:e365:f27c])
        by smtp.gmail.com with ESMTPSA id j6-20020aa78d06000000b006ecec1f4b08sm2621938pfe.118.2024.05.03.02.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 02:18:47 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 05/14] zram: add zstd compression backend support
Date: Fri,  3 May 2024 18:17:30 +0900
Message-ID: <20240503091823.3616962-6-senozhatsky@chromium.org>
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

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig        | 12 ++++
 drivers/block/zram/Makefile       |  1 +
 drivers/block/zram/backend_zstd.c | 97 +++++++++++++++++++++++++++++++
 drivers/block/zram/backend_zstd.h | 10 ++++
 drivers/block/zram/zcomp.c        |  4 ++
 5 files changed, 124 insertions(+)
 create mode 100644 drivers/block/zram/backend_zstd.c
 create mode 100644 drivers/block/zram/backend_zstd.h

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 8a775fd66eb9..d0f791a8c7bd 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -35,6 +35,13 @@ config ZRAM_BACKEND_LZ4HC
 	select LZ4HC_COMPRESS
 	select LZ4_DECOMPRESS
 
+config ZRAM_BACKEND_ZSTD
+	bool "zstd compression support"
+	depends on ZRAM
+	default n
+	select ZSTD_COMPRESS
+	select ZSTD_DECOMPRESS
+
 choice
 	prompt "Default zram compressor"
 	default ZRAM_DEF_COMP_LZORLE
@@ -56,6 +63,10 @@ config ZRAM_DEF_COMP_LZ4HC
 	bool "lz4hc"
 	depends on ZRAM_BACKEND_LZ4HC
 
+config ZRAM_DEF_COMP_ZSTD
+	bool "zstd"
+	depends on ZRAM_BACKEND_ZSTD
+
 endchoice
 
 config ZRAM_DEF_COMP
@@ -64,6 +75,7 @@ config ZRAM_DEF_COMP
 	default "lzo" if ZRAM_DEF_COMP_LZO
 	default "lz4" if ZRAM_DEF_COMP_LZ4
 	default "lz4hc" if ZRAM_DEF_COMP_LZ4HC
+	default "zstd" if ZRAM_DEF_COMP_ZSTD
 	default "unset-value"
 
 config ZRAM_WRITEBACK
diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
index 815b45471c7d..053fe35e346b 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -3,6 +3,7 @@
 obj-$(CONFIG_ZRAM_BACKEND_LZO)		+= backend_lzorle.o backend_lzo.o
 obj-$(CONFIG_ZRAM_BACKEND_LZ4)		+= backend_lz4.o
 obj-$(CONFIG_ZRAM_BACKEND_LZ4HC)	+= backend_lz4hc.o
+obj-$(CONFIG_ZRAM_BACKEND_ZSTD)		+= backend_zstd.o
 
 zram-y	:=	zcomp.o zram_drv.o
 
diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
new file mode 100644
index 000000000000..4da49626f110
--- /dev/null
+++ b/drivers/block/zram/backend_zstd.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/zstd.h>
+
+#include "backend_zstd.h"
+
+struct zstd_ctx {
+	zstd_cctx *cctx;
+	zstd_dctx *dctx;
+	void *cctx_mem;
+	void *dctx_mem;
+	s32 level;
+};
+
+static void zstd_destroy(void *ctx)
+{
+	struct zstd_ctx *zctx = ctx;
+
+	vfree(zctx->cctx_mem);
+	vfree(zctx->dctx_mem);
+	kfree(zctx);
+}
+
+static void *zstd_create(void)
+{
+	zstd_parameters params;
+	struct zstd_ctx *ctx;
+	size_t sz;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	ctx->level = ZSTD_defaultCLevel();
+	params = zstd_get_params(ctx->level, 0);
+	sz = zstd_cctx_workspace_bound(&params.cParams);
+	ctx->cctx_mem = vzalloc(sz);
+	if (!ctx->cctx_mem)
+		goto error;
+
+	ctx->cctx = zstd_init_cctx(ctx->cctx_mem, sz);
+	if (!ctx->cctx)
+		goto error;
+
+	sz = zstd_dctx_workspace_bound();
+	ctx->dctx_mem = vzalloc(sz);
+	if (!ctx->dctx_mem)
+		goto error;
+
+	ctx->dctx = zstd_init_dctx(ctx->dctx_mem, sz);
+	if (!ctx->dctx)
+		goto error;
+
+	return ctx;
+
+error:
+	zstd_destroy(ctx);
+	return NULL;
+}
+
+static int zstd_compress(void *ctx, const unsigned char *src,
+			 unsigned char *dst, size_t *dst_len)
+{
+	struct zstd_ctx *zctx = ctx;
+	const zstd_parameters params = zstd_get_params(zctx->level, 0);
+	size_t ret;
+
+	ret = zstd_compress_cctx(zctx->cctx, dst, *dst_len,
+				 src, PAGE_SIZE, &params);
+	if (zstd_is_error(ret))
+		return -EINVAL;
+	*dst_len = ret;
+	return 0;
+}
+
+static int zstd_decompress(void *ctx, const unsigned char *src, size_t src_len,
+			   unsigned char *dst)
+{
+	struct zstd_ctx *zctx = ctx;
+	size_t ret;
+
+	ret = zstd_decompress_dctx(zctx->dctx, dst, PAGE_SIZE, src, src_len);
+	if (zstd_is_error(ret))
+		return -EINVAL;
+	return 0;
+}
+
+struct zcomp_backend backend_zstd = {
+	.compress	= zstd_compress,
+	.decompress	= zstd_decompress,
+	.create_ctx	= zstd_create,
+	.destroy_ctx	= zstd_destroy,
+	.name		= "zstd",
+};
diff --git a/drivers/block/zram/backend_zstd.h b/drivers/block/zram/backend_zstd.h
new file mode 100644
index 000000000000..75d2d2c02768
--- /dev/null
+++ b/drivers/block/zram/backend_zstd.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef __BACKEND_ZSTD_H__
+#define __BACKEND_ZSTD_H__
+
+#include "zcomp.h"
+
+extern struct zcomp_backend backend_zstd;
+
+#endif /* __BACKEND_ZSTD_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index f04f5844a23c..c16eb038f608 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -19,6 +19,7 @@
 #include "backend_lzorle.h"
 #include "backend_lz4.h"
 #include "backend_lz4hc.h"
+#include "backend_zstd.h"
 
 static struct zcomp_backend *backends[] = {
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
@@ -30,6 +31,9 @@ static struct zcomp_backend *backends[] = {
 #endif
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZ4HC)
 	&backend_lz4hc,
+#endif
+#if IS_ENABLED(CONFIG_ZRAM_BACKEND_ZSTD)
+	&backend_zstd,
 #endif
 	NULL
 };
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


