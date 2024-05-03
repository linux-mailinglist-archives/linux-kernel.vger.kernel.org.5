Return-Path: <linux-kernel+bounces-167444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7228BA9B0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A391F24073
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D80B1514E5;
	Fri,  3 May 2024 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rda2xC4z"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365A31509A1
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727927; cv=none; b=gJ/czeQP/lUD4dXuQnwuBucvTgHts3xi38w0+tnePL7GmbBuQ2leXO7lFcljuWBld4vq/wWn/rcZawT56EpCMpjoOYnMpKvgEdYa7HROPMZFsVkL2JPnzyfbdSAcvN8EtUmgVZqCTOq6nZTItCr0s2rkd3kFTgXDEPyvcQFn134=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727927; c=relaxed/simple;
	bh=41WGShYHYQ8vBwtm0qoCyiFMZwVAWOWL3iNh5+RpFK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3ibTuQlSC5Pir1TT+IOkqOW4WTcJBEPzP2HX4xyD2XseJ/rEKo43CjfoWniMh+V+eeIWBxjbo9dfJdSbdxomffQvd68efs4nRGLbuURUqr2o07MmQbKXT67NWhqq0P6lXjOYVyAFi8QkFM3tyJDXGeIUe5eatgSRJeAojuFKz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Rda2xC4z; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6edb76d83d0so7800372b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 02:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714727925; x=1715332725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7PfZsfM+KAkHMFzQDzf1KFOCZ0ztSCuLUJnOMeN/zg=;
        b=Rda2xC4zzY3NEUxcjnoO2+S0kV+n87O5ocHnvHRwZigxFip0AfihlLZkaNXf2yCtsz
         O7orGrMClUxUnQeKuejARwowwSrc5rdAUvz/ieAX8DFhXNeFRCchkYoE7DpbssNSgiR8
         zyGt0Vb1KXoJKb/p8n2bCyyN1cowBnbfgBeQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714727925; x=1715332725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7PfZsfM+KAkHMFzQDzf1KFOCZ0ztSCuLUJnOMeN/zg=;
        b=e9Z+54wKvQ+I9ByZtS9XAfAMDou9gMlOpgvGbkbrm1P6jikXzRqLRgfFTm8O5okzJa
         gnkAt8jkMb6TWLH9sIRyG0PilF1WZCqKEDO1h4/mAO6lwk9Y2Nb37t4rYEmFeOjw4fUg
         MC7V48t7w8wnRy4LP3Fajswt8vEaEy7nti/XcUOSU9PF42icy1V8eNCr9Bh2lvM7EIHb
         ONbqvW49H2k6Ch/p0hlDh+hiAnuSdhtr0SOMoQALohKw8yv7UHW5pAXtbFO1t0erBRqn
         J6mmOEgzBvW2bcI5MhIFu3BIgR0JduMG/zskmr908HQXPaAY7Ti0u2H0N/IMFJ1IdNOs
         pmaA==
X-Gm-Message-State: AOJu0Yyp5U3WG8Jk3OFMeH24oCI7VVlDI7uvX4JaSfJhaib5i0JFCfpg
	HZLNrJvbo0QwYW87FiWQBLmXP+UwiKCFf5nfeEPOWgBfgZQ131TkAjczJ88xiw==
X-Google-Smtp-Source: AGHT+IGYDjEyHh33sVMrjW6dkor3Yv3bjKBgj6DbpVaT8/FuQR7czjo8jql5dr2swcGEFrNBroht+A==
X-Received: by 2002:a05:6a00:1704:b0:6f3:854c:dee0 with SMTP id h4-20020a056a00170400b006f3854cdee0mr2304565pfc.21.1714727925445;
        Fri, 03 May 2024 02:18:45 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:dc60:24a3:e365:f27c])
        by smtp.gmail.com with ESMTPSA id j6-20020aa78d06000000b006ecec1f4b08sm2621938pfe.118.2024.05.03.02.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 02:18:45 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 04/14] zram: add lz4hc compression backend support
Date: Fri,  3 May 2024 18:17:29 +0900
Message-ID: <20240503091823.3616962-5-senozhatsky@chromium.org>
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
 drivers/block/zram/Kconfig         | 12 +++++
 drivers/block/zram/Makefile        |  5 ++-
 drivers/block/zram/backend_lz4hc.c | 72 ++++++++++++++++++++++++++++++
 drivers/block/zram/backend_lz4hc.h | 10 +++++
 drivers/block/zram/zcomp.c         |  4 ++
 5 files changed, 101 insertions(+), 2 deletions(-)
 create mode 100644 drivers/block/zram/backend_lz4hc.c
 create mode 100644 drivers/block/zram/backend_lz4hc.h

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 02d20a30bf6c..8a775fd66eb9 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -28,6 +28,13 @@ config ZRAM_BACKEND_LZ4
 	select LZ4_COMPRESS
 	select LZ4_DECOMPRESS
 
+config ZRAM_BACKEND_LZ4HC
+	bool "lz4hc compression support"
+	depends on ZRAM
+	default n
+	select LZ4HC_COMPRESS
+	select LZ4_DECOMPRESS
+
 choice
 	prompt "Default zram compressor"
 	default ZRAM_DEF_COMP_LZORLE
@@ -45,6 +52,10 @@ config ZRAM_DEF_COMP_LZ4
 	bool "lz4"
 	depends on ZRAM_BACKEND_LZ4
 
+config ZRAM_DEF_COMP_LZ4HC
+	bool "lz4hc"
+	depends on ZRAM_BACKEND_LZ4HC
+
 endchoice
 
 config ZRAM_DEF_COMP
@@ -52,6 +63,7 @@ config ZRAM_DEF_COMP
 	default "lzo-rle" if ZRAM_DEF_COMP_LZORLE
 	default "lzo" if ZRAM_DEF_COMP_LZO
 	default "lz4" if ZRAM_DEF_COMP_LZ4
+	default "lz4hc" if ZRAM_DEF_COMP_LZ4HC
 	default "unset-value"
 
 config ZRAM_WRITEBACK
diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
index 1be5d2657960..815b45471c7d 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_ZRAM_BACKEND_LZO)	+= backend_lzorle.o backend_lzo.o
-obj-$(CONFIG_ZRAM_BACKEND_LZ4)	+= backend_lz4.o
+obj-$(CONFIG_ZRAM_BACKEND_LZO)		+= backend_lzorle.o backend_lzo.o
+obj-$(CONFIG_ZRAM_BACKEND_LZ4)		+= backend_lz4.o
+obj-$(CONFIG_ZRAM_BACKEND_LZ4HC)	+= backend_lz4hc.o
 
 zram-y	:=	zcomp.o zram_drv.o
 
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
new file mode 100644
index 000000000000..5c437623aa65
--- /dev/null
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -0,0 +1,72 @@
+#include <linux/kernel.h>
+#include <linux/lz4.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+#include "backend_lz4hc.h"
+
+struct lz4hc_ctx {
+	void *mem;
+	s32 level;
+};
+
+static void lz4hc_destroy(void *ctx)
+{
+	struct lz4hc_ctx *zctx = ctx;
+
+	vfree(zctx->mem);
+	kfree(zctx);
+}
+
+static void *lz4hc_create(void)
+{
+	struct lz4hc_ctx *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	ctx->mem = vmalloc(LZ4HC_MEM_COMPRESS);
+	if (!ctx->mem) {
+		lz4hc_destroy(ctx);
+		return NULL;
+	}
+
+	/* @FIXME: using a hardcoded LZ4HC_DEFAULT_CLEVEL for now */
+	ctx->level = LZ4HC_DEFAULT_CLEVEL;
+	return ctx;
+}
+
+static int lz4hc_compress(void *ctx, const unsigned char *src,
+			unsigned char *dst, size_t *dst_len)
+{
+	struct lz4hc_ctx *zctx = ctx;
+	int ret;
+
+	ret = LZ4_compress_HC(src, dst, PAGE_SIZE, *dst_len,
+			      zctx->level, zctx->mem);
+	if (!ret)
+		return -EINVAL;
+	*dst_len = ret;
+	return 0;
+}
+
+static int lz4hc_decompress(void *ctx, const unsigned char *src,
+			  size_t src_len, unsigned char *dst)
+{
+	int dst_len = PAGE_SIZE;
+	int ret;
+
+	ret = LZ4_decompress_safe(src, dst, src_len, dst_len);
+	if (ret < 0)
+		return -EINVAL;
+	return 0;
+}
+
+struct zcomp_backend backend_lz4hc = {
+	.compress	= lz4hc_compress,
+	.decompress	= lz4hc_decompress,
+	.create_ctx	= lz4hc_create,
+	.destroy_ctx	= lz4hc_destroy,
+	.name		= "lz4hc",
+};
diff --git a/drivers/block/zram/backend_lz4hc.h b/drivers/block/zram/backend_lz4hc.h
new file mode 100644
index 000000000000..29c428a850e2
--- /dev/null
+++ b/drivers/block/zram/backend_lz4hc.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef __BACKEND_LZ4HC_H__
+#define __BACKEND_LZ4HC_H__
+
+#include "zcomp.h"
+
+extern struct zcomp_backend backend_lz4hc;
+
+#endif /* __BACKEND_LZ4HC_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 902bdaf7e299..f04f5844a23c 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -18,6 +18,7 @@
 #include "backend_lzo.h"
 #include "backend_lzorle.h"
 #include "backend_lz4.h"
+#include "backend_lz4hc.h"
 
 static struct zcomp_backend *backends[] = {
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
@@ -26,6 +27,9 @@ static struct zcomp_backend *backends[] = {
 #endif
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZ4)
 	&backend_lz4,
+#endif
+#if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZ4HC)
+	&backend_lz4hc,
 #endif
 	NULL
 };
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


