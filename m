Return-Path: <linux-kernel+bounces-9025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7936F81BF63
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35BDC288F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AD0745FA;
	Thu, 21 Dec 2023 20:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UQy5FdaO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E833745CE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703189165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJl4ImE4TRrDXvrAPN+dS4cgTUzwQEr6h+ILfia+IPo=;
	b=UQy5FdaOJP3WHcVUkGmBl3aQkcqo5p6PbagnBT8wp0ljLIpod/Ojsrg7YfgnIjF56yHZRq
	Hho7BHFtctI8tiFKBQkJ21sW2wiU4BcM7mHrjBDpphYej6wGMhj1TMy2nV0GXg97lpUgq8
	tU7rBZD5CJd5flB9JqJlXxWqDy6GX1E=
From: andrey.konovalov@linux.dev
To: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 07/11] kasan: respect CONFIG_KASAN_VMALLOC for kasan_flag_vmalloc
Date: Thu, 21 Dec 2023 21:04:49 +0100
Message-Id: <3e5c933c8f6b59bd587efb05c407964be951772c.1703188911.git.andreyknvl@google.com>
In-Reply-To: <cover.1703188911.git.andreyknvl@google.com>
References: <cover.1703188911.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@google.com>

Never enable the kasan_flag_vmalloc static branch unless
CONFIG_KASAN_VMALLOC is enabled.

This does not fix any observable bugs (vmalloc annotations for the
HW_TAGS mode are no-op with CONFIG_KASAN_VMALLOC disabled) but rather
just cleans up the code.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/hw_tags.c | 7 +++++++
 mm/kasan/kasan.h   | 1 +
 2 files changed, 8 insertions(+)

diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 06141bbc1e51..80f11a3eccd5 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -57,7 +57,11 @@ enum kasan_mode kasan_mode __ro_after_init;
 EXPORT_SYMBOL_GPL(kasan_mode);
 
 /* Whether to enable vmalloc tagging. */
+#ifdef CONFIG_KASAN_VMALLOC
 DEFINE_STATIC_KEY_TRUE(kasan_flag_vmalloc);
+#else
+DEFINE_STATIC_KEY_FALSE(kasan_flag_vmalloc);
+#endif
 
 #define PAGE_ALLOC_SAMPLE_DEFAULT	1
 #define PAGE_ALLOC_SAMPLE_ORDER_DEFAULT	3
@@ -119,6 +123,9 @@ static int __init early_kasan_flag_vmalloc(char *arg)
 	if (!arg)
 		return -EINVAL;
 
+	if (!IS_ENABLED(CONFIG_KASAN_VMALLOC))
+		return 0;
+
 	if (!strcmp(arg, "off"))
 		kasan_arg_vmalloc = KASAN_ARG_VMALLOC_OFF;
 	else if (!strcmp(arg, "on"))
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 5fbcc1b805bc..dee105ba32dd 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -49,6 +49,7 @@ DECLARE_PER_CPU(long, kasan_page_alloc_skip);
 
 static inline bool kasan_vmalloc_enabled(void)
 {
+	/* Static branch is never enabled with CONFIG_KASAN_VMALLOC disabled. */
 	return static_branch_likely(&kasan_flag_vmalloc);
 }
 
-- 
2.25.1


