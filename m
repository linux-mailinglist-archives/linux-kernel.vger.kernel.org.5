Return-Path: <linux-kernel+bounces-8429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051F581B706
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 744E8B23E42
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36B073167;
	Thu, 21 Dec 2023 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOlzTnpc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF4F1DA3B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d409bcb0e7so2171005ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 05:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703164183; x=1703768983; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFdPKwapUY8zXC6g2+4yINCWjhBF8Q1sAwMk78Pp4YA=;
        b=AOlzTnpcOWYiUg3cd/umtIytcVQblL3iIgy3W4kbo42A+5xd5V1MSasOuwiruuPlqd
         3Po6jmjOXpguoQ5rg28GjE9AsKhuT5nur4Ea4B0EIAFCMroCc9mPca6bruLyfxqqREfn
         yetpYHNfkihteoXXZQYKURutkoP+jz3VOUGZk0Q09YaKO0SoHakbCpvfFvvGpIP5Bv7N
         MnLkheJLv0QyBWs1P73KC/QE9CKsnyEuK5/wuGERa2TcVU5gQ8znmXk/GkrJsmScnG92
         c2a8QYV8IVWvNpx26Eu99YW1HvvQ8sqSaeWJ48YthyGPKbGJG6mykGhL4tFunYnzY6zR
         0IAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703164183; x=1703768983;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFdPKwapUY8zXC6g2+4yINCWjhBF8Q1sAwMk78Pp4YA=;
        b=Tb5cNspS+yIHkTFRoo+Am3bMyuQFfMgKbfH3mHLSIJyQHGNfshvJZIMqzougPIHytm
         O2lQ7+bVsXoE4HXOxY0Y4arb5zmdzFHPUD4lw55UXOmBHsIgrhLCEWiTaeSQMU2yZlVq
         Vr9JMLW+G65hDaxSOpqcJd46wPu02psPenirUqt85P+MYghHCaf7C88S0/xVNEL5b9uV
         Hy8ABDzMkxmeALEtHpdTDrq/u/QDywGfzf97wJ4qPcKqHQM5iK1LlB1bSd6/3Nkt/yiA
         CGdVctHy7bs5TqDnGxz9k/fBSSsYpFtQEv+JK9szeBy80HfArKSaeQm+XrumGYKmySU3
         Pr2Q==
X-Gm-Message-State: AOJu0YxCfo5Q7cUdJb7A8r3Fz9mc9hlcjFylBkBQACpr8cX+Oy7EIUGa
	YQVL1jNf9X93ePXCIrYdPs8=
X-Google-Smtp-Source: AGHT+IHxikQkAfJUnrBZukWIyXgqkntOuH/6pPTjsNIrTV1trFZyvhr3wWSZk/ahniOVhD+h6fxBbQ==
X-Received: by 2002:a17:903:1206:b0:1cf:d07c:2806 with SMTP id l6-20020a170903120600b001cfd07c2806mr13248914plh.25.1703164182801;
        Thu, 21 Dec 2023 05:09:42 -0800 (PST)
Received: from ruipeng-ThinkCentre-M730e-N010.company.local (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902c3c100b001c9d011581dsm1573435plj.164.2023.12.21.05.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 05:09:41 -0800 (PST)
From: Ruipeng Qi <ruipengqi7@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Cc: zalbassam@google.com,
	dianders@chromium.org,
	mark.rutland@arm.com,
	lecopzer.chen@mediatek.com,
	maz@kernel.org,
	arnd@arndb.de,
	yury.norov@gmail.com,
	brauner@kernel.org,
	mcgrof@kernel.org,
	maninder1.s@samsung.com,
	michael.christie@oracle.com,
	samitolvanen@google.com,
	linux-arm-kernel@lists.infradead.org,
	qiruipeng@lixiang.com
Subject: [PATCH 1/7] [RFC PATCH 1/7] osdump: Add one new os minidump module
Date: Thu, 21 Dec 2023 21:09:30 +0800
Message-Id: <20231221130930.32634-1-ruipengqi7@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: qiruipeng <qiruipeng@lixiang.com>

Osdump is a new crash dumping solution aiming at specific embedded
devices within automotive or Industrial.
 - limited memory.
 - reboot as soon as possible when system fault.

In order to reduce dump file size and speed up dump process, it has the
following features:
 - no userspace memory, just designed for solving os issues.
 - no const data, such as text segment
 - dump core os data only.
   - bss, data segments which alloc static.
   - dynamic data
     - slub data for little size data.
     - some large size data.
 - compress dump data to reduce dump file size.

consist of large massive of uncontinuous data,so use binary data format
directly.

reasemble a standard elf format file with dump file and vmlinux, and
then parse it with crash tool.

Signed-off-by: qiruipeng <qiruipeng@lixiang.com>
---
 arch/arm64/Kconfig       | 169 +++++++++++
 drivers/of/platform.c    |   1 +
 include/linux/osdump.h   |   7 +
 kernel/Makefile          |   1 +
 kernel/osdump/Makefile   |   1 +
 kernel/osdump/compr.c    | 252 ++++++++++++++++
 kernel/osdump/core.c     | 608 +++++++++++++++++++++++++++++++++++++++
 kernel/osdump/extern.h   |  13 +
 kernel/osdump/inode.c    |  77 +++++
 kernel/osdump/internal.h |  95 ++++++
 10 files changed, 1224 insertions(+)
 create mode 100644 include/linux/osdump.h
 create mode 100644 kernel/osdump/Makefile
 create mode 100644 kernel/osdump/compr.c
 create mode 100644 kernel/osdump/core.c
 create mode 100644 kernel/osdump/extern.h
 create mode 100644 kernel/osdump/inode.c
 create mode 100644 kernel/osdump/internal.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b071a00425d..6e5e96b5738e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -258,6 +258,175 @@ config ARM64
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
+config OS_MINIDUMP
+	bool "Enable os minidump module"
+	default n
+	depends on !CRASH_CORE && !SLUB_DEBUG && !SLUB_TINY
+	help
+	  Trigger os minidump when panic. It only dump parts of os core
+	  datas/segments in raw binary format to reduce its size and
+	  speed up dump process. Reasemble a standard elf format file
+	  with dump file and vmlinux, and then parse it with crash tool.
+
+	  For more details see Documentation/admin-guide/osdump.rst
+
+	  If unsure, say N.
+
+config OS_MINIDUMP_DEFLATE_COMPRESS
+	tristate "DEFLATE (ZLIB) compression"
+	depends on OS_MINIDUMP
+	select CRYPTO_DEFLATE
+	help
+	  This option enables DEFLATE (also known as ZLIB) compression
+	  algorithm support for os minidump. Enabling this option will allow
+	  mini dumps to be compressed using DEFLATE, which may reduce the size of
+	  the dump files.
+
+	  If unsure, say N.
+
+config OS_MINIDUMP_LZO_COMPRESS
+	tristate "LZO compression"
+	default y
+	depends on OS_MINIDUMP
+	select CRYPTO_LZO
+	help
+	  This option enables LZO compression algorithm support for os minidump.
+	  Enabling this option will allow mini dumps to be compressed using LZO,
+	  which may reduce the size of the dump files.
+
+	  If unsure, say Y.
+
+config OS_MINIDUMP_LZ4_COMPRESS
+	tristate "LZ4 compression"
+	depends on OS_MINIDUMP
+	select CRYPTO_LZ4
+	help
+	  This option enables LZ4 compression algorithm support for os minidump.
+	  Enabling this option will allow mini dumps to be compressed using LZ4,
+	  which may reduce the size of the dump files.
+
+	  If unsure, say N.
+
+config OS_MINIDUMP_LZ4HC_COMPRESS
+	tristate "LZ4HC compression"
+	depends on OS_MINIDUMP
+	select CRYPTO_LZ4HC
+	help
+	  This option enables LZ4HC (high compression) mode algorithm.
+	  Enabling this option will allow mini dumps to be compressed using LZ4HC,
+	  which may reduce the size of the dump files.
+
+	  If unsure, say N.
+
+config OS_MINIDUMP_842_COMPRESS
+	bool "842 compression"
+	depends on OS_MINIDUMP
+	select CRYPTO_842
+	help
+	  This option enables 842 compression algorithm support for os minidump.
+	  Enabling this option will allow mini dumps to be compressed using 842,
+	  which may reduce the size of the dump files.
+
+	  If unsure, say N.
+
+config OS_MINIDUMP_ZSTD_COMPRESS
+	bool "zstd compression"
+	depends on OS_MINIDUMP
+	select CRYPTO_ZSTD
+	help
+	  This option enables zstd compression algorithm support for os minidump.
+	  Enabling this option will allow mini dumps to be compressed using ZSTD,
+	  which may reduce the size of the dump files.
+
+	  If unsure, say N.
+
+config OS_MINIDUMP_COMPRESS
+	def_bool y
+	depends on OS_MINIDUMP
+	depends on OS_MINIDUMP_DEFLATE_COMPRESS || OS_MINIDUMP_LZO_COMPRESS ||    \
+		   OS_MINIDUMP_LZ4_COMPRESS || OS_MINIDUMP_LZ4HC_COMPRESS ||      \
+		   OS_MINIDUMP_842_COMPRESS || OS_MINIDUMP_ZSTD_COMPRESS
+
+choice
+	prompt "Default osdump.compression algorithm"
+	depends on OS_MINIDUMP_COMPRESS
+	help
+	  This option chooses the default active compression algorithm.
+	  This can be changed at boot with "osdump.compress=..." on
+	  the kernel command line.
+
+	  Currently, osdump.has support for 6 compression algorithms:
+	  deflate, lzo, lz4, lz4hc, 842 and zstd.
+
+	  The default compression algorithm is lzo.
+
+	config OS_MINIDUMP_DEFLATE_COMPRESS_DEFAULT
+		bool "deflate" if OS_MINIDUMP_DEFLATE_COMPRESS
+		help
+		  This option chooses deflate as default compression algorithm,
+		  which reduce the size of the dump files greately.
+
+		  This can be changed at boot with "osdump.compress=..." on
+		  the kernel command line.
+
+	config OS_MINIDUMP_LZO_COMPRESS_DEFAULT
+		bool "lzo" if OS_MINIDUMP_LZO_COMPRESS
+		help
+		  This option chooses lzo as default compression algorithm,
+		  which reduce the size of the dump files greately.
+
+		  This can be changed at boot with "osdump.compress=..." on
+		  the kernel command line.
+
+	config OS_MINIDUMP_LZ4_COMPRESS_DEFAULT
+		bool "lz4" if OS_MINIDUMP_LZ4_COMPRESS
+		help
+		  This option chooses lz4 as default compression algorithm,
+		  which reduce the size of the dump files greately.
+
+		  This can be changed at boot with "osdump.compress=..." on
+		  the kernel command line.
+
+	config OS_MINIDUMP_LZ4HC_COMPRESS_DEFAULT
+		bool "lz4hc" if OS_MINIDUMP_LZ4HC_COMPRESS
+		help
+		  This option chooses lz4hc as default compression algorithm,
+		  which reduce the size of the dump files greately.
+
+		  This can be changed at boot with "osdump.compress=..." on
+		  the kernel command line.
+
+	config OS_MINIDUMP_842_COMPRESS_DEFAULT
+		bool "842" if OS_MINIDUMP_842_COMPRESS
+		help
+		  This option chooses 842 as default compression algorithm,
+		  which reduce the size of the dump files greately.
+
+		  This can be changed at boot with "osdump.compress=..." on
+		  the kernel command line.
+
+	config OS_MINIDUMP_ZSTD_COMPRESS_DEFAULT
+		bool "zstd" if OS_MINIDUMP_ZSTD_COMPRESS
+		help
+		  This option chooses zstd as default compression algorithm,
+		  which reduce the size of the dump files greately.
+
+		  This can be changed at boot with "osdump.compress=..." on
+		  the kernel command line.
+
+endchoice
+
+config OS_MINIDUMP_COMPRESS_DEFAULT
+	string
+	depends on OS_MINIDUMP_COMPRESS
+	default "deflate" if OS_MINIDUMP_DEFLATE_COMPRESS_DEFAULT
+	default "lzo" if OS_MINIDUMP_LZO_COMPRESS_DEFAULT
+	default "lz4" if OS_MINIDUMP_LZ4_COMPRESS_DEFAULT
+	default "lz4hc" if OS_MINIDUMP_LZ4HC_COMPRESS_DEFAULT
+	default "842" if OS_MINIDUMP_842_COMPRESS_DEFAULT
+	default "zstd" if OS_MINIDUMP_ZSTD_COMPRESS_DEFAULT
+
+
 config CLANG_SUPPORTS_DYNAMIC_FTRACE_WITH_ARGS
 	def_bool CC_IS_CLANG
 	# https://github.com/ClangBuiltLinux/linux/issues/1507
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 126d265aa7d8..6622292633f7 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -538,6 +538,7 @@ static const struct of_device_id reserved_mem_matches[] = {
 	{ .compatible = "qcom,cmd-db" },
 	{ .compatible = "qcom,smem" },
 	{ .compatible = "ramoops" },
+	{ .compatible = "osdump" },
 	{ .compatible = "nvmem-rmem" },
 	{ .compatible = "google,open-dice" },
 	{}
diff --git a/include/linux/osdump.h b/include/linux/osdump.h
new file mode 100644
index 000000000000..600d0d4901eb
--- /dev/null
+++ b/include/linux/osdump.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_OS_MINIDUMP_H
+#define _LINUX_OS_MINIDUMP_H
+
+extern int osdump(void);
+
+#endif
diff --git a/kernel/Makefile b/kernel/Makefile
index 3947122d618b..dc2b4ba5c953 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -116,6 +116,7 @@ obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call_inline.o
 obj-$(CONFIG_CFI_CLANG) += cfi.o
 
 obj-$(CONFIG_PERF_EVENTS) += events/
+obj-$(CONFIG_OS_MINIDUMP) += osdump/
 
 obj-$(CONFIG_USER_RETURN_NOTIFIER) += user-return-notifier.o
 obj-$(CONFIG_PADATA) += padata.o
diff --git a/kernel/osdump/Makefile b/kernel/osdump/Makefile
new file mode 100644
index 000000000000..3f9cd6282653
--- /dev/null
+++ b/kernel/osdump/Makefile
@@ -0,0 +1 @@
+obj-y += core.o inode.o compr.o
diff --git a/kernel/osdump/compr.c b/kernel/osdump/compr.c
new file mode 100644
index 000000000000..08aa6b72177c
--- /dev/null
+++ b/kernel/osdump/compr.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * OS Minidump - compression driver interface parts.
+ *
+ */
+
+#if IS_ENABLED(CONFIG_OS_MINIDUMP_LZO_COMPRESS)
+#include <linux/types.h>
+#include <linux/lzo.h>
+#endif
+#if IS_ENABLED(CONFIG_OS_MINIDUMP_LZ4_COMPRESS) || IS_ENABLED(CONFIG_OS_MINIDUMP_LZ4HC_COMPRESS)
+#include <linux/lz4.h>
+#endif
+#if IS_ENABLED(CONFIG_OS_MINIDUMP_ZSTD_COMPRESS)
+#include <linux/zstd.h>
+#endif
+#include <linux/crypto.h>
+#include <linux/string.h>
+
+#include <linux/module.h>
+#include "internal.h"
+
+static char *compress = CONFIG_OS_MINIDUMP_COMPRESS_DEFAULT;
+
+module_param(compress, charp, 0444);
+MODULE_PARM_DESC(compress, "compression to use");
+
+/* Compression parameters */
+static struct crypto_comp *tfm;
+
+struct osdump_zbackend {
+	int (*zbufsize)(size_t size);
+	const char *name;
+};
+
+static void *big_oops_buf;
+size_t big_oops_buf_sz;
+EXPORT_SYMBOL_GPL(big_oops_buf_sz);
+
+#if IS_ENABLED(CONFIG_OS_MINIDUMP_DEFLATE_COMPRESS)
+static int zbufsize_deflate(size_t size)
+{
+	size_t cmpr;
+
+	switch (size) {
+	/* buffer range for efivars */
+	case 1000 ... 2000:
+		cmpr = 56;
+		break;
+	case 2001 ... 3000:
+		cmpr = 54;
+		break;
+	case 3001 ... 3999:
+		cmpr = 52;
+		break;
+		/* buffer range for nvram, erst */
+	case 4000 ... 10000:
+		cmpr = 45;
+		break;
+	default:
+		cmpr = 60;
+		break;
+	}
+
+	return (size * 100) / cmpr;
+}
+#endif
+
+#if IS_ENABLED(CONFIG_OS_MINIDUMP_LZO_COMPRESS)
+static int zbufsize_lzo(size_t size)
+{
+	return lzo1x_worst_compress(size);
+}
+#endif
+
+#if IS_ENABLED(CONFIG_OS_MINIDUMP_LZ4_COMPRESS) || IS_ENABLED(CONFIG_OS_MINIDUMP_LZ4HC_COMPRESS)
+static int zbufsize_lz4(size_t size)
+{
+	return LZ4_compressBound(size);
+}
+#endif
+
+#if IS_ENABLED(CONFIG_OS_MINIDUMP_842_COMPRESS)
+static int zbufsize_842(size_t size)
+{
+	return size;
+}
+#endif
+
+#if IS_ENABLED(CONFIG_OS_MINIDUMP_ZSTD_COMPRESS)
+static int zbufsize_zstd(size_t size)
+{
+	return ZSTD_compressBound(size);
+}
+#endif
+
+static const struct osdump_zbackend *zbackend __ro_after_init;
+
+static const struct osdump_zbackend zbackends[] = {
+#if IS_ENABLED(CONFIG_OS_MINIDUMP_DEFLATE_COMPRESS)
+	{
+		.zbufsize       = zbufsize_deflate,
+		.name           = "deflate",
+	},
+#endif
+#if IS_ENABLED(CONFIG_OS_MINIDUMP_LZO_COMPRESS)
+	{
+		.zbufsize       = zbufsize_lzo,
+		.name           = "lzo",
+	},
+#endif
+#if IS_ENABLED(CONFIG_OS_MINIDUMP_LZ4_COMPRESS)
+	{
+		.zbufsize       = zbufsize_lz4,
+		.name           = "lz4",
+	},
+#endif
+#if IS_ENABLED(CONFIG_OS_MINIDUMP_LZ4HC_COMPRESS)
+	{
+		.zbufsize       = zbufsize_lz4,
+		.name           = "lz4hc",
+	},
+#endif
+#if IS_ENABLED(CONFIG_OS_MINIDUMP_842_COMPRESS)
+	{
+		.zbufsize       = zbufsize_842,
+		.name           = "842",
+	},
+#endif
+#if IS_ENABLED(CONFIG_OS_MINIDUMP_ZSTD_COMPRESS)
+	{
+		.zbufsize       = zbufsize_zstd,
+		.name           = "zstd",
+	},
+#endif
+	{ }
+};
+
+int osdump_compress(const void *in, void *out, unsigned int size, int *left)
+{
+	int ret;
+	unsigned int outlen = size;
+
+	if (!IS_ENABLED(CONFIG_OS_MINIDUMP_COMPRESS))
+		return -EINVAL;
+
+	ret = crypto_comp_compress(tfm, in, size, big_oops_buf, &outlen);
+	if (ret) {
+		pr_err(DUMP_BANNER "crypto_comp_compress failed, ret = %d!\n", ret);
+		return ret;
+	}
+
+	if (outlen <= *left) {
+		memcpy(out, big_oops_buf, outlen);
+		*left -= outlen;
+	} else
+		*left = 0;
+
+	return outlen;
+}
+
+static void allocate_buf_for_compression(void)
+{
+	struct crypto_comp *ctx;
+	int size;
+	char *buf;
+
+	/* Skip if not built-in or compression backend not selected yet. */
+	if (!IS_ENABLED(CONFIG_OS_MINIDUMP_COMPRESS) || !zbackend)
+		return;
+
+	/* Skip if compression init already done. */
+	if (tfm)
+		return;
+
+	if (!crypto_has_comp(zbackend->name, 0, 0)) {
+		pr_err(DUMP_BANNER "Unknown compression: %s\n", zbackend->name);
+		return;
+	}
+
+	size = zbackend->zbufsize(CRYPTO_SIZE);
+	if (size <= 0) {
+		pr_err(DUMP_BANNER "Invalid compression size for %s: %d\n",
+				zbackend->name, size);
+		return;
+	}
+	size = round_down(size, PAGE_SIZE);
+
+	buf = kmalloc(size, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	ctx = crypto_alloc_comp(zbackend->name, 0, 0);
+	if (IS_ERR_OR_NULL(ctx)) {
+		kfree(buf);
+		pr_err(DUMP_BANNER "crypto_alloc_comp('%s') failed: %ld\n", zbackend->name,
+				PTR_ERR(ctx));
+		return;
+	}
+
+	/* A non-NULL big_oops_buf indicates compression is available. */
+	tfm = ctx;
+	big_oops_buf_sz = size;
+	big_oops_buf = buf;
+
+	pr_info(DUMP_BANNER "Using os minidump compression: %s\n", zbackend->name);
+}
+
+static void free_buf_for_compression(void)
+{
+	if (IS_ENABLED(CONFIG_OS_MINIDUMP_COMPRESS) && tfm) {
+		crypto_free_comp(tfm);
+		tfm = NULL;
+	}
+	kfree(big_oops_buf);
+	big_oops_buf = NULL;
+	big_oops_buf_sz = 0;
+}
+
+static void __init osdump_choose_compression(void)
+{
+	const struct osdump_zbackend *step;
+
+	if (!compress)
+		return;
+
+	for (step = zbackends; step->name; step++) {
+		if (!strcmp(compress, step->name)) {
+			zbackend = step;
+			return;
+		}
+	}
+}
+
+static int __init compr_init(void)
+{
+	osdump_choose_compression();
+
+	allocate_buf_for_compression();
+
+	return 0;
+}
+late_initcall(compr_init);
+
+static void __exit compr_exit(void)
+{
+	free_buf_for_compression();
+}
+module_exit(compr_exit);
+
+MODULE_AUTHOR("qiruipeng");
+MODULE_LICENSE("GPL");
diff --git a/kernel/osdump/core.c b/kernel/osdump/core.c
new file mode 100644
index 000000000000..0da8c2ac3fc7
--- /dev/null
+++ b/kernel/osdump/core.c
@@ -0,0 +1,608 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * OS Minidump - core implement parts.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
+#include <linux/mm.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <linux/io.h>
+#include <linux/device.h>
+#include "internal.h"
+#include <linux/slab.h>
+#include "../../mm/slab.h"
+#include <linux/nmi.h>
+#include <linux/sched.h>
+#include <linux/byteorder/generic.h>
+#include <asm/kernel-pgtable.h>
+#include <linux/osdump.h>
+#include <linux/cpu.h>
+#include "extern.h"
+
+#define OS_DUMP		"osdump"
+
+struct osdump_variables osdump_var;
+EXPORT_SYMBOL_GPL(osdump_var);
+
+static inline u64 htonll(u64 val)
+{
+	return (((u64) htonl(val)) << 32) + htonl(val >> 32);
+}
+
+static inline u64 ntohll(u64 val)
+{
+	return (((u64) ntohl(val)) << 32) + ntohl(val >> 32);
+}
+
+static int common_store(void *src, phys_addr_t phys_addr, int src_size,
+			struct osdump_variables *osdump_var, int *sum)
+{
+	void *addr = osdump_var->mem_address;
+	int size, tmp, cnt = 0;
+
+	while (src_size > 0) {
+		size  = src_size > big_oops_buf_sz ? big_oops_buf_sz : src_size;
+		tmp = size;
+		size = osdump_compress(src, osdump_var->dst, size, &osdump_var->rem);
+
+		*sum += tmp;
+		(osdump_var->meta)->start = htonl(osdump_var->dst - addr);
+		(osdump_var->meta)->size = htonl(size);
+		(osdump_var->meta)->src = htonll(phys_addr);
+		(osdump_var->dst) += size;
+		(osdump_var->meta)++;
+		cnt++;
+		src += tmp;
+		phys_addr += tmp;
+		src_size -= tmp;
+
+		if (osdump_var->meta > osdump_var->meta_end)
+			osdump_var->rem = 0;
+	}
+
+	return cnt;
+}
+
+static int stack_dump(struct osdump_variables *osdump_var)
+{
+	int cnt = 0;
+	int sum = 0;
+
+	struct task_struct *tsk;
+	struct vm_struct *area;
+	int i;
+
+	tsk = current;
+	area = tsk->stack_vm_area;
+
+	for (i = 0; i < area->nr_pages; i++) {
+		cnt += common_store(area->addr + i * PAGE_SIZE, page_to_phys(area->pages[i]),
+					PAGE_SIZE, osdump_var, &sum);
+		if (osdump_var->rem <= 0)
+			break;
+	}
+
+
+	return cnt;
+}
+
+#if CONFIG_PGTABLE_LEVELS >= 2
+static int process_pmd(pmd_t *pmd, struct osdump_variables *osdump_var, int *sum)
+{
+	int i, cnt = 0;
+	struct page *page;
+
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+
+		if (!pmd_none(*pmd)) {
+			page = pmd_page(*pmd);
+			if ((pmd_val(*pmd) & PMD_ATTRINDX_MASK) >> 2 == MT_NORMAL) {
+				if ((pmd_val(*pmd) & PMD_TYPE_MASK)  == PMD_TYPE_TABLE) {
+					cnt += common_store(page_to_virt(page), page_to_phys(page),
+								PAGE_SIZE, osdump_var, sum);
+
+				// save struct page here
+				} else if ((pmd_val(*pmd) & PMD_TYPE_MASK)  == PMD_TYPE_SECT
+						&& !(pmd_val(*pmd) & (PMD_SECT_RDONLY))) {
+					cnt += common_store(page_to_virt(page), page_to_phys(page),
+								PMD_SIZE, osdump_var, sum);
+
+				}
+				if (osdump_var->rem <= 0)
+					break;
+			}
+		}
+
+		pmd++;
+	}
+	return cnt;
+}
+#endif
+
+#if CONFIG_PGTABLE_LEVELS >= 3
+static int process_pud(pud_t *pud, struct osdump_variables *osdump_var, int *sum)
+{
+	int i, cnt = 0;
+	struct page *page;
+
+	for (i = 0; i < PTRS_PER_PUD; i++) {
+		if ((pud_val(*pud))) {
+			page = pud_page(*pud);
+
+			cnt += common_store(page_to_virt(page), page_to_phys(page),
+						PAGE_SIZE, osdump_var, sum);
+			if (osdump_var->rem <= 0)
+				break;
+
+			cnt += process_pmd(pud_pgtable(*pud), osdump_var, sum);
+			if (osdump_var->rem <= 0)
+				break;
+
+		}
+
+		pud++;
+	}
+
+	return cnt;
+}
+#endif
+
+#if CONFIG_PGTABLE_LEVELS >= 4
+static int process_p4d(p4d_t *p4d, struct osdump_variables *osdump_var, int *sum)
+{
+	int i, cnt = 0;
+	struct page *page;
+
+	for (i = 0; i < PTRS_PER_P4D; i++) {
+		if ((p4d_val(*p4d))) {
+			page = p4d_page(*p4d);
+
+			cnt += common_store(page_to_virt(page), page_to_phys(page),
+						PAGE_SIZE, osdump_var, sum);
+			if (osdump_var->rem <= 0)
+				break;
+
+			cnt += process_pud(p4d_pgtable(*p4d), osdump_var, sum);
+			if (osdump_var->rem <= 0)
+				break;
+
+		}
+
+		p4d++;
+	}
+
+	return cnt;
+}
+#endif
+
+#if CONFIG_PGTABLE_LEVELS == 5
+static int process_pgd(pgd_t *pgd, struct osdump_variables *osdump_var, int *sum)
+{
+	int i, cnt = 0;
+	struct page *page;
+
+	for (i = 0; i < PTRS_PER_PGD; i++) {
+		if ((pgd_val(*pgd))) {
+			page = pgd_page(*pgd);
+
+			cnt += common_store(page_to_virt(page), page_to_phys(page),
+						PAGE_SIZE, osdump_var, sum);
+			if (osdump_var->rem <= 0)
+				break;
+
+			cnt += process_p4d(pgd_pgtable(*pgd), osdump_var, sum);
+			if (osdump_var->rem <= 0)
+				break;
+
+		}
+
+		pgd++;
+	}
+
+	return cnt;
+}
+#endif
+
+static int ptl_dump(struct osdump_variables *osdump_var)
+{
+	int cnt = 0, sum = 0;
+
+	struct mm_struct *mm = &init_mm;
+	pgd_t *pgd = mm->pgd;
+
+	cnt += common_store(pgd, virt_to_phys(pgd), PAGE_SIZE, osdump_var, &sum);
+	if (osdump_var->rem <= 0)
+		return cnt;
+
+#if CONFIG_PGTABLE_LEVELS == 5
+	cnt += process_pgd(pgd, osdump_var, &sum);
+#elif CONFIG_PGTABLE_LEVELS == 4
+	cnt += process_p4d((p4d_t *) pgd, osdump_var, &sum);
+#elif CONFIG_PGTABLE_LEVELS == 3
+	cnt += process_pud((pud_t *) pgd, osdump_var, &sum);
+#elif CONFIG_PGTABLE_LEVELS == 2
+	cnt += process_pmd((pmd_t *) pgd, osdump_var, &sum);
+#endif
+
+	return cnt;
+}
+
+static int other_dump(struct osdump_variables *osdump_var)
+{
+	int cpu, len, sum = 0, cnt = 0;
+	void *rq;
+
+	cnt += common_store(_sdata, virt_to_phys(_sdata), _edata - _sdata, osdump_var, &sum);
+	if (osdump_var->rem <= 0)
+		return cnt;
+
+	cnt += common_store(__bss_start, virt_to_phys(__bss_start),
+				__bss_stop - __bss_start, osdump_var, &sum);
+	if (osdump_var->rem <= 0)
+		return cnt;
+
+	cnt += common_store(mem_section, virt_to_phys(mem_section), PAGE_SIZE<<1, osdump_var, &sum);
+	if (osdump_var->rem <= 0)
+		return cnt;
+
+	for_each_online_cpu(cpu) {
+		len = get_rq(cpu, &rq);
+
+		cnt += common_store(rq, virt_to_phys(rq), len, osdump_var, &sum);
+		if (osdump_var->rem <= 0)
+			return cnt;
+
+	}
+
+	return cnt;
+}
+
+static int note_dump(struct osdump_variables *osdump_var)
+{
+	int cnt = 0;
+	int sum = 0;
+
+	cnt += common_store(vmcoreinfo_note, virt_to_phys(vmcoreinfo_note),
+				get_note_size(), osdump_var, &sum);
+
+	return cnt;
+}
+
+
+struct unrecord_struct {
+	const char *name;
+	struct kmem_cache *s;
+};
+
+/*
+ * In certain scenarios, some slab objects may experience abnormally high growth,
+ * which can lead to an excessive increase in memory dump size. or some objects
+ * are unlikely to cause issues, they can be excluded from memory dumps.
+ * This exclusion helps to reduce the overall size of the dump, making crash
+ * analysis more manageable and efficient.
+ */
+static struct unrecord_struct unrecord_slab[] = {
+	[0] = {
+		.name = "dentry",
+	},
+	[1] = {
+		.name = "inode_cache",
+	},
+	[2] = {
+		.name = "ext4_inode_cache",
+	},
+	[3] = {
+		.name = "proc_inode_cache",
+	},
+	[4] = {
+		.name = "kernfs_node_cache",
+	},
+
+	[5] = {
+		.name = "UDP",
+	},
+	[6] = {
+		.name = "TCP",
+	},
+	[7] = {
+		.name = "fs_cache",
+	},
+};
+
+static int slab_dump(struct osdump_variables *osdump_var)
+{
+	int sum = 0, i;
+
+	unsigned long flags;
+	struct kmem_cache *s;
+	struct page *page;
+	struct kmem_cache_node *node;
+	struct list_head *head;
+	struct kmem_cache_cpu *c;
+	struct slab *slab;
+
+	int cnt = 0, cpu;
+	pg_data_t *pgdat;
+
+	if (!mutex_trylock(&slab_mutex)) {
+		pr_err(DUMP_BANNER "can't acquire slab_mutex, just skip dump slab!\n");
+		return 0;
+	}
+
+	list_for_each_entry(s, &slab_caches, list) {
+		for (i = 0; i < ARRAY_SIZE(unrecord_slab); i++) {
+			if (!strcmp(unrecord_slab[i].name, s->name)) {
+				unrecord_slab[i].s = s;
+				break;
+			}
+		}
+
+		if (i != ARRAY_SIZE(unrecord_slab))
+			continue;
+
+		touch_nmi_watchdog();
+		touch_all_softlockup_watchdogs();
+
+		for_each_possible_cpu(cpu) {
+			local_irq_save(flags);
+			c = per_cpu_ptr(s->cpu_slab, cpu);
+
+			slab = READ_ONCE(c->slab);
+			if (!slab) {
+				local_irq_restore(flags);
+				continue;
+			}
+
+			page = slab_page(slab);
+			cnt += common_store(page_to_virt(page), page_to_phys(page),
+					PAGE_SIZE << compound_order(page), osdump_var, &sum);
+			if (osdump_var->rem <= 0) {
+				local_irq_restore(flags);
+				goto out_ret;
+			}
+
+
+#ifdef CONFIG_SLUB_CPU_PARTIAL
+			slab = slub_percpu_partial_read_once(c);
+			while (slab) {
+				page = slab_page(slab);
+				cnt += common_store(page_to_virt(page), page_to_phys(page),
+					PAGE_SIZE << compound_order(page), osdump_var, &sum);
+				if (osdump_var->rem <= 0) {
+					local_irq_restore(flags);
+					goto out_ret;
+				}
+
+				slab = slab->next;
+			}
+#endif
+			local_irq_restore(flags);
+		}
+
+		for_each_online_pgdat(pgdat) {
+			node = s->node[pgdat->node_id];
+
+#ifdef CONFIG_SLAB
+
+			head = &node->slabs_full;
+			list_for_each_entry(slab, head, slab_list) {
+				page = slab_page(slab);
+				cnt += common_store(page_to_virt(page), page_to_phys(page),
+					PAGE_SIZE << compound_order(page), osdump_var, &sum);
+				if (osdump_var->rem <= 0)
+					goto out_ret;
+
+			}
+
+			head = &node->slabs_partial;
+			list_for_each_entry(slab, head, slab_list) {
+				page = slab_page(slab);
+				cnt += common_store(page_to_virt(page), page_to_phys(page),
+					PAGE_SIZE << compound_order(page), osdump_var, &sum);
+				if (osdump_var->rem <= 0)
+					goto out_ret;
+
+			}
+
+#elif CONFIG_SLUB
+			spin_lock_irqsave(&node->list_lock, flags);
+			head = &node->full;
+
+
+			list_for_each_entry(slab, head, slab_list) {
+				page = slab_page(slab);
+				cnt += common_store(page_to_virt(page), page_to_phys(page),
+					PAGE_SIZE << compound_order(page), osdump_var, &sum);
+				if (osdump_var->rem <= 0) {
+					spin_unlock_irqrestore(&node->list_lock, flags);
+					goto out_ret;
+				}
+			}
+
+			spin_unlock_irqrestore(&node->list_lock, flags);
+
+			spin_lock_irqsave(&node->list_lock, flags);
+			head = &node->partial;
+
+			list_for_each_entry(slab, head, slab_list) {
+				page = slab_page(slab);
+				cnt += common_store(page_to_virt(page), page_to_phys(page),
+					PAGE_SIZE << compound_order(page), osdump_var, &sum);
+				if (osdump_var->rem <= 0) {
+					spin_unlock_irqrestore(&node->list_lock, flags);
+					goto out_ret;
+				}
+			}
+
+
+			spin_unlock_irqrestore(&node->list_lock, flags);
+#endif
+
+		}
+
+	}
+
+out_ret:
+	mutex_unlock(&slab_mutex);
+
+	return cnt;
+}
+
+static int dump_mem(struct osdump_variables *osdump_var)
+{
+	int cnt = 0;
+	struct table_hdr *hdr = (struct table_hdr *)(osdump_var->mem_address);
+
+	memset(hdr, 0, sizeof(struct table_hdr));
+
+	osdump_var->rem = osdump_var->mem_size - MDUMP_HDR_SIZE;
+	osdump_var->dst = (void *)osdump_var->mem_address + MDUMP_HDR_SIZE;
+	osdump_var->meta_end = (void *)osdump_var->mem_address + MDUMP_HDR_SIZE -
+				sizeof(struct table_entry);
+	osdump_var->meta = (void *)osdump_var->mem_address + sizeof(struct table_hdr);
+
+
+	if (osdump_var->rem <= 0)
+		goto out;
+
+	cnt += note_dump(osdump_var);
+	if (osdump_var->rem <= 0)
+		goto out;
+
+	cnt += other_dump(osdump_var);
+	if (osdump_var->rem <= 0)
+		goto out;
+
+	cnt += stack_dump(osdump_var);
+	if (osdump_var->rem <= 0)
+		goto out;
+
+	cnt += slab_dump(osdump_var);
+	if (osdump_var->rem <= 0)
+		goto out;
+
+	cnt += ptl_dump(osdump_var);
+
+out:
+	hdr->count = htonl(cnt);
+	hdr->size = htonl(osdump_var->dst - (void *)osdump_var->mem_address);
+	strscpy(hdr->magic, MDUMP_MAGIC, strlen(MDUMP_MAGIC));
+	hdr->checksum = cal_checksum(hdr);
+
+	return cnt;
+}
+
+int osdump(void)
+{
+	int ret = 0;
+
+	ret = dump_mem(&osdump_var);
+	if (ret < 0) {
+		pr_err(DUMP_BANNER "dump mem failed!\n");
+		return -1;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(osdump);
+
+static void *persistent_ram_vmap(phys_addr_t start, size_t size,
+		unsigned int memtype)
+{
+	struct page **pages;
+	phys_addr_t page_start;
+	unsigned int page_count;
+	pgprot_t prot;
+	unsigned int i;
+	void *vaddr;
+
+	page_start = start - offset_in_page(start);
+	page_count = DIV_ROUND_UP(size + offset_in_page(start), PAGE_SIZE);
+
+	if (memtype)
+		prot = pgprot_noncached(PAGE_KERNEL);
+	else
+		prot = pgprot_writecombine(PAGE_KERNEL);
+
+	pages = kmalloc_array(page_count, sizeof(struct page *), GFP_KERNEL);
+	if (!pages)
+		return NULL;
+
+	for (i = 0; i < page_count; i++) {
+		phys_addr_t addr = page_start + i * PAGE_SIZE;
+
+		pages[i] = pfn_to_page(addr >> PAGE_SHIFT);
+	}
+	vaddr = vmap(pages, page_count, VM_MAP, prot);
+	kfree(pages);
+
+	/*
+	 * Since vmap() uses page granularity, we must add the offset
+	 * into the page here, to get the byte granularity address
+	 * into the mapping to represent the actual "start" location.
+	 */
+	return vaddr + offset_in_page(start);
+}
+
+static int osdump_parse_dt(struct platform_device *pdev, struct osdump_variables *pdata)
+{
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		pr_err(DUMP_BANNER "failed to locate DT /reserved-memory resource!\n");
+		return -EINVAL;
+	}
+
+	pdata->mem_address = persistent_ram_vmap(res->start, resource_size(res), 0);
+	pdata->mem_size = resource_size(res);
+
+	return 0;
+}
+
+static int osdump_probe(struct platform_device *pdev)
+{
+	struct device *dev;
+
+	dev = &pdev->dev;
+	dev->platform_data = &osdump_var;
+
+	if (dev_of_node(dev))
+		osdump_parse_dt(pdev, &osdump_var);
+
+	return 0;
+}
+
+static int osdump_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+
+static const struct of_device_id osdump_of_match[] = {
+	{ .compatible = "osdump", },
+	{}
+};
+
+static struct platform_driver osdump_driver = {
+	.probe = osdump_probe,
+	.remove = osdump_remove,
+	.driver = {
+		.name = OS_DUMP,
+		.of_match_table = osdump_of_match,
+	},
+};
+
+static int __init osdump_init(void)
+{
+	return platform_driver_register(&osdump_driver);
+}
+postcore_initcall(osdump_init);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("os minidump driver");
+MODULE_AUTHOR("qiruipeng");
diff --git a/kernel/osdump/extern.h b/kernel/osdump/extern.h
new file mode 100644
index 000000000000..da0d25ef4662
--- /dev/null
+++ b/kernel/osdump/extern.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_OS_MINIDUMP_EXTERN_H
+#define _LINUX_OS_MINIDUMP_EXTERN_H
+
+extern struct kmem_cache *task_struct_cachep;
+extern size_t big_oops_buf_sz;
+extern int osdump_compress(const void *in, void *out, int size, int *left);
+extern int get_rq(int cpu, void **rq);
+extern u32 *vmcoreinfo_note;
+extern int get_note_size(void);
+
+#endif
diff --git a/kernel/osdump/inode.c b/kernel/osdump/inode.c
new file mode 100644
index 000000000000..9356c4b8795f
--- /dev/null
+++ b/kernel/osdump/inode.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Interface for accessing the crash dump from the system's previous life.
+ */
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+struct inode_priv {
+	void *addr;
+	size_t size;
+	struct proc_dir_entry *proc_osdump;
+};
+static struct inode_priv *inode_priv;
+
+static ssize_t osdump_read(struct file *file, char __user *buf,
+		size_t count, loff_t *ppos)
+{
+	if (!inode_priv)
+		return 0;
+
+	return simple_read_from_buffer(buf, count, ppos, inode_priv->addr, inode_priv->size);
+}
+
+static const struct proc_ops osdump_proc_ops = {
+	.proc_read = osdump_read,
+	.proc_lseek = default_llseek,
+};
+
+static int __init osdump_init_fs(void)
+{
+	int ret = 0;
+	struct table_hdr *hdr;
+
+	inode_priv = kzalloc(sizeof(struct inode_priv), GFP_KERNEL);
+	if (!inode_priv)
+		return -ENOMEM;
+
+	hdr = (struct table_hdr *)osdump_var.mem_address;
+	if (!hdr_valid(hdr))
+		goto err;
+
+	inode_priv->addr = hdr;
+	inode_priv->size = ntohl(hdr->size);
+
+	inode_priv->proc_osdump = proc_create("osdump", 0400, NULL, &osdump_proc_ops);
+	if (!inode_priv->proc_osdump) {
+		ret = -ENOENT;
+		pr_err(DUMP_BANNER "osdump create inode failed!\n");
+		goto err;
+	}
+
+	return 0;
+
+err:
+	kfree(inode_priv);
+	inode_priv = NULL;
+
+	return ret;
+}
+fs_initcall(osdump_init_fs);
+
+void osdump_cleanup_fs(void)
+{
+	if (inode_priv && inode_priv->proc_osdump) {
+		proc_remove(inode_priv->proc_osdump);
+		inode_priv->proc_osdump = NULL;
+	}
+
+	kfree(inode_priv);
+	inode_priv = NULL;
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("qiruipeng");
diff --git a/kernel/osdump/internal.h b/kernel/osdump/internal.h
new file mode 100644
index 000000000000..5dc09fe37295
--- /dev/null
+++ b/kernel/osdump/internal.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef	_LINUX_OS_MINIDUMP_INTERNAL_H
+#define	_LINUX_OS_MINIDUMP_INTERNAL_H
+
+/*
+ * We only dump the data we are interested in, each of which represents
+ * a continuous region - this could be a structure or pages of data. These
+ * data are compressed first and then stored into one or several entries,
+ * each with a maximum size of 32K.
+ *
+ * We use reserved memory to store these dump data, referred to as
+ * 'dump region'. This region consists of two parts: The first part records
+ * the meta info and is thus, known as the 'meta region' and the second part
+ * stores the raw data in sequence and is known as the 'data region'.
+ *
+ * At the beginning of the meta region lies a header that records the total
+ * size and count of entries. Following the header, there's a table which
+ * holds metadata for each entry. This metadata records the physical address
+ * of the dumped data in memory, in addition to the offset and size of the
+ * data stored in the dump region.
+ *
+ * The second part of the dump region stores compressed data for each entry
+ * in an orderly manner.
+ */
+
+// fixed size for meta region.
+#define MDUMP_HDR_SIZE		(192*1024)
+#define MDUMP_MAGIC		"osdump"
+#define DUMP_BANNER		"osdump: "
+
+#define CRYPTO_SIZE		(PAGE_SIZE << 3)
+
+struct table_hdr {
+	/* entries count */
+	unsigned int count;
+	/* total size */
+	unsigned int size;
+	/* for aligned */
+	union {
+		int reserve[2];
+		struct {
+			char magic[7];
+			unsigned char  checksum;
+		};
+	};
+};
+
+struct table_entry {
+	/*  offset in dump region */
+	unsigned int start;
+	unsigned int size;
+	/* physical addr in memory */
+	unsigned long long src;
+};
+
+/*
+ * Runtime information: this struct save the runtime information used for
+ * os minidump.
+ */
+struct osdump_variables {
+	/* virtual addr for dump region */
+	void           *mem_address;
+	/* total size for dump data */
+	unsigned long   mem_size;
+	/* curr entry's metadata */
+	struct table_entry *meta;
+	/* last metadata */
+	struct table_entry *meta_end;
+	/* remain size for dump data */
+	int             rem;
+	/* addr stored  in dump region */
+	void            *dst;
+};
+
+
+extern struct osdump_variables osdump_var;
+
+static inline unsigned char cal_checksum(struct table_hdr *hdr)
+{
+	int i, len = sizeof(struct table_hdr) - 1;
+	unsigned char ch = 0, *ptr = (unsigned char *)hdr;
+
+	for (i = 0; i < len; i++)
+		ch += ptr[i];
+
+	return ch;
+}
+
+static inline bool hdr_valid(struct table_hdr *hdr)
+{
+	return !strncmp(MDUMP_MAGIC, hdr->magic, strlen(MDUMP_MAGIC)) &&
+						hdr->checksum == cal_checksum(hdr);
+}
+#endif
-- 
2.17.1


