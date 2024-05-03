Return-Path: <linux-kernel+bounces-167447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04F28BA9B7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C65DAB2316A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09283152789;
	Fri,  3 May 2024 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J9QTQ/B/"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CEA152190
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727935; cv=none; b=uL4gTlKcUTXtS1YomZ+pEO4RzIC6ribv89NlVm6xW1GPfOcjB3uSqhxWOGHJBrRVWHba7l7KgYRJVjKkBII+xhEiJK+6L8OGXkmbJfJPOIrkZyL5h6CslxU//MbcQ8WC2m6nRtou8r7l1sEKnVT1OSHzdtaMl4KZoRI1Isjwnpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727935; c=relaxed/simple;
	bh=HavFm53SyNwKHu2r7DaiECAhewcs+p7d7Tk8OFwhfg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hykbBvuBUCN9GLyUD2JGyCvhLQGOeT+t2pI8mjZsrpWMN3V5mP3W5eWIBLDp9Kt3qw/4vJbWqOx6uzGeon1GEzmF6/zuVw93Dm9RY5z9Y8RRMm8D3ac2xuLFCFZOBUWUyRVQUXZ7FmSqaQLJV94IF+Ju8dV0LyBr/UO63IIVBTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J9QTQ/B/; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f44bcbaae7so360525b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 02:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714727932; x=1715332732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7mw/f9+e6QmK/dXzyr5OJ2nwO3O6lt6K2kT9/oX6Mw=;
        b=J9QTQ/B/8yuwEWCMa3SoViXlMphl5s+9W1mAQQ5ZQXY6acwf3Iqm068DfheA+KDokK
         z3TeVvc/XJaIw0dvh1mLb9mT3xYRnNQ7F9hwNwD8LtRb9q1t2P9aWQgJ4CKCuwDokZtC
         k5H6ZhxxXr/E/I51M0Pnuzqx0V5Kitu43QuIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714727932; x=1715332732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7mw/f9+e6QmK/dXzyr5OJ2nwO3O6lt6K2kT9/oX6Mw=;
        b=c7rEJfF2qiT5KdcSh5xEAhkXpVlIxM77mvweX8iY8G7HmTwGKMWDNax/tDeKRqGhy+
         8EMUb4P5jq4xIMuoDS20IwYPc0znTr155O7ZQY7idKH/FFjn0iwcxFfxJORIkM2h2kys
         GwRP7d/3CjuxWI/YMk7RN08q6jeAlRhIRuIDE1NzpMRvN/6OMb5tSlhx0G4fUlxWy/Oa
         IAg9CLY+Q99o7G4OwoU/uPXIrNGcNug7s+a0Gmhiwv3HcTLnmvNIFcl0ZRhHk6TLYFRT
         Dv29Nx98+kpcvtOuwh3QFbJqRUEdQwAx/v0OruUZKxaMjtpr+uF3X+866wBixKOilxKn
         qOdw==
X-Gm-Message-State: AOJu0Yx6DEOtJodhXN3qLVQus5rUEJxZjMg88Wj9kcCtraz1zp7OT9jv
	jBCwRGZjknd6ez26g5dNrTClRW4ANLaa6HIu3Mwidh11dMRtuuWpeaUttAXfPA==
X-Google-Smtp-Source: AGHT+IEBbR1rQRFf3Ph3wwjmpiiez6SSRvPKu7VXClGnjwH+shf/geHutn5dpVF739mOajIRz67jDg==
X-Received: by 2002:a05:6a20:2d27:b0:1ae:84b3:bb62 with SMTP id g39-20020a056a202d2700b001ae84b3bb62mr2815071pzl.12.1714727932288;
        Fri, 03 May 2024 02:18:52 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:dc60:24a3:e365:f27c])
        by smtp.gmail.com with ESMTPSA id j6-20020aa78d06000000b006ecec1f4b08sm2621938pfe.118.2024.05.03.02.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 02:18:52 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 07/14] zram: add zlib compression backend support
Date: Fri,  3 May 2024 18:17:32 +0900
Message-ID: <20240503091823.3616962-8-senozhatsky@chromium.org>
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
 drivers/block/zram/Kconfig           |  12 +++
 drivers/block/zram/Makefile          |   9 +-
 drivers/block/zram/backend_deflate.c | 130 +++++++++++++++++++++++++++
 drivers/block/zram/backend_deflate.h |  10 +++
 drivers/block/zram/zcomp.c           |   4 +
 5 files changed, 161 insertions(+), 4 deletions(-)
 create mode 100644 drivers/block/zram/backend_deflate.c
 create mode 100644 drivers/block/zram/backend_deflate.h

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index d0f791a8c7bd..7155a23d66de 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -42,6 +42,13 @@ config ZRAM_BACKEND_ZSTD
 	select ZSTD_COMPRESS
 	select ZSTD_DECOMPRESS
 
+config ZRAM_BACKEND_DEFLATE
+	bool "deflate compression support"
+	depends on ZRAM
+	default n
+	select ZLIB_DEFLATE
+	select ZLIB_INFLATE
+
 choice
 	prompt "Default zram compressor"
 	default ZRAM_DEF_COMP_LZORLE
@@ -67,6 +74,10 @@ config ZRAM_DEF_COMP_ZSTD
 	bool "zstd"
 	depends on ZRAM_BACKEND_ZSTD
 
+config ZRAM_DEF_COMP_DEFLATE
+	bool "deflate"
+	depends on ZRAM_BACKEND_DEFLATE
+
 endchoice
 
 config ZRAM_DEF_COMP
@@ -76,6 +87,7 @@ config ZRAM_DEF_COMP
 	default "lz4" if ZRAM_DEF_COMP_LZ4
 	default "lz4hc" if ZRAM_DEF_COMP_LZ4HC
 	default "zstd" if ZRAM_DEF_COMP_ZSTD
+	default "deflate" if ZRAM_DEF_COMP_DEFLATE
 	default "unset-value"
 
 config ZRAM_WRITEBACK
diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
index 053fe35e346b..91c07595d8b4 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -1,9 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_ZRAM_BACKEND_LZO)		+= backend_lzorle.o backend_lzo.o
-obj-$(CONFIG_ZRAM_BACKEND_LZ4)		+= backend_lz4.o
-obj-$(CONFIG_ZRAM_BACKEND_LZ4HC)	+= backend_lz4hc.o
-obj-$(CONFIG_ZRAM_BACKEND_ZSTD)		+= backend_zstd.o
+obj-$(CONFIG_ZRAM_BACKEND_LZO)			+= backend_lzorle.o backend_lzo.o
+obj-$(CONFIG_ZRAM_BACKEND_LZ4)			+= backend_lz4.o
+obj-$(CONFIG_ZRAM_BACKEND_LZ4HC)		+= backend_lz4hc.o
+obj-$(CONFIG_ZRAM_BACKEND_ZSTD)			+= backend_zstd.o
+obj-$(CONFIG_ZRAM_BACKEND_DEFLATE)		+= backend_deflate.o
 
 zram-y	:=	zcomp.o zram_drv.o
 
diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
new file mode 100644
index 000000000000..949d402ea3dd
--- /dev/null
+++ b/drivers/block/zram/backend_deflate.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/zlib.h>
+
+#include "backend_deflate.h"
+
+/* Use the same value as crypto API */
+#define DEFLATE_DEF_WINBITS		11
+#define DEFLATE_DEF_MEMLEVEL		MAX_MEM_LEVEL
+
+struct deflate_ctx {
+	struct z_stream_s cctx;
+	struct z_stream_s dctx;
+	s32 level;
+};
+
+static void deflate_destroy(void *ctx)
+{
+	struct deflate_ctx *zctx = ctx;
+
+	if (zctx->cctx.workspace) {
+		zlib_deflateEnd(&zctx->cctx);
+		vfree(zctx->cctx.workspace);
+	}
+	if (zctx->dctx.workspace) {
+		zlib_inflateEnd(&zctx->dctx);
+		vfree(zctx->dctx.workspace);
+	}
+	kfree(zctx);
+}
+
+static void *deflate_create(void)
+{
+	struct deflate_ctx *ctx;
+	size_t sz;
+	int ret;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	/* @FIXME: using a hardcoded Z_DEFAULT_COMPRESSION for now */
+	ctx->level = Z_DEFAULT_COMPRESSION;
+	sz = zlib_deflate_workspacesize(-DEFLATE_DEF_WINBITS, MAX_MEM_LEVEL);
+	ctx->cctx.workspace = vzalloc(sz);
+	if (!ctx->cctx.workspace)
+		goto error;
+
+	ret = zlib_deflateInit2(&ctx->cctx, ctx->level, Z_DEFLATED,
+				-DEFLATE_DEF_WINBITS, DEFLATE_DEF_MEMLEVEL,
+				Z_DEFAULT_STRATEGY);
+	if (ret != Z_OK)
+		goto error;
+
+	sz = zlib_inflate_workspacesize();
+	ctx->dctx.workspace = vzalloc(sz);
+	if (!ctx->dctx.workspace)
+		goto error;
+
+	ret = zlib_inflateInit2(&ctx->dctx, -DEFLATE_DEF_WINBITS);
+	if (ret != Z_OK)
+		goto error;
+
+	return ctx;
+
+error:
+	deflate_destroy(ctx);
+	return NULL;
+}
+
+static int deflate_compress(void *ctx, const unsigned char *src,
+			    unsigned char *dst, size_t *dst_len)
+{
+	struct deflate_ctx *zctx = ctx;
+	struct z_stream_s *deflate;
+	int ret;
+
+	deflate = &zctx->cctx;
+	ret = zlib_deflateReset(deflate);
+	if (ret != Z_OK)
+		return -EINVAL;
+
+	deflate->next_in = (u8 *)src;
+	deflate->avail_in = PAGE_SIZE;
+	deflate->next_out = (u8 *)dst;
+	deflate->avail_out = *dst_len;
+
+	ret = zlib_deflate(deflate, Z_FINISH);
+	if (ret != Z_STREAM_END)
+		return -EINVAL;
+
+	*dst_len = deflate->total_out;
+	return 0;
+}
+
+static int deflate_decompress(void *ctx, const unsigned char *src,
+			      size_t src_len, unsigned char *dst)
+{
+	struct deflate_ctx *zctx = ctx;
+	struct z_stream_s *inflate;
+	int ret;
+
+	inflate = &zctx->dctx;
+
+	ret = zlib_inflateReset(inflate);
+	if (ret != Z_OK)
+		return -EINVAL;
+
+	inflate->next_in = (u8 *)src;
+	inflate->avail_in = src_len;
+	inflate->next_out = (u8 *)dst;
+	inflate->avail_out = PAGE_SIZE;
+
+	ret = zlib_inflate(inflate, Z_SYNC_FLUSH);
+	if (ret != Z_STREAM_END)
+		return -EINVAL;
+
+	return 0;
+}
+
+struct zcomp_backend backend_deflate = {
+	.compress	= deflate_compress,
+	.decompress	= deflate_decompress,
+	.create_ctx	= deflate_create,
+	.destroy_ctx	= deflate_destroy,
+	.name		= "deflate",
+};
diff --git a/drivers/block/zram/backend_deflate.h b/drivers/block/zram/backend_deflate.h
new file mode 100644
index 000000000000..49cef8fc1e77
--- /dev/null
+++ b/drivers/block/zram/backend_deflate.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef __BACKEND_DEFLATE_H__
+#define __BACKEND_DEFLATE_H__
+
+#include "zcomp.h"
+
+extern struct zcomp_backend backend_deflate;
+
+#endif /* __BACKEND_DEFLATE_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index c16eb038f608..9fc5477a6259 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -20,6 +20,7 @@
 #include "backend_lz4.h"
 #include "backend_lz4hc.h"
 #include "backend_zstd.h"
+#include "backend_deflate.h"
 
 static struct zcomp_backend *backends[] = {
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
@@ -34,6 +35,9 @@ static struct zcomp_backend *backends[] = {
 #endif
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_ZSTD)
 	&backend_zstd,
+#endif
+#if IS_ENABLED(CONFIG_ZRAM_BACKEND_DEFLATE)
+	&backend_deflate,
 #endif
 	NULL
 };
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


