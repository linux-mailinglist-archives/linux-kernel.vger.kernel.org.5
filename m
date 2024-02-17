Return-Path: <linux-kernel+bounces-69688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD897858D42
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 05:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F254F1C20D8E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 04:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EB51D522;
	Sat, 17 Feb 2024 04:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PW2M3D5F"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874F61CAAD
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 04:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708145623; cv=none; b=MLHkoKA7DPU0csDWnLsnAPaoSDVMoESpwJ4TphHhp6MWD1frMOf3Q1fRnzMSBlb8knhebdrncLgsyVvP+cnqmQNRldm7pQ/Vi9/cL7dfAYTVkA8lljRuxXB0WKZDtUuaa7RAtwmb9q2MoIpj+YMz095oCdIob6Pr+A0sRNXs7RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708145623; c=relaxed/simple;
	bh=o9bi0PQaph7nLtjH/UpCrP47Rjaglgom5drD61yQXYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uXaBQZjYrqBWFODGfm1U8indtBpAqNOol8Gr0nR48pqed7kvdjT9+ZcRW4df0yRfI3DsYmwSPzeU+MHs8X7ngOHPWg1zAalJYFHsD2PsyEXL4UUZZ6UDn1elym790iJVTDozxBHLhsLIijCINcFWrVzMdDBwqi6BNEyjWIyNndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PW2M3D5F; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-296a02b7104so2069425a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 20:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708145621; x=1708750421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywnWEQ8XGtSxKO6WdLPFCCZ1X6Rmd0BoX1prDPDFNU0=;
        b=PW2M3D5F3LZqRaR4xKb4A3ZU8T+BAypqiU+1wzyWU7NPiP7oap6HxuRVhjhh505Lbe
         KQmqp+y3rMwAXV4QeSG9bPawwLCH8tPimqdsbWTDppiFRpMtG+lui74C2atTVlYx+Cug
         2AMDX958xFtua5d6pp+C+sAXcht3ta/AGZFso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708145621; x=1708750421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywnWEQ8XGtSxKO6WdLPFCCZ1X6Rmd0BoX1prDPDFNU0=;
        b=DHxKKiMCes+8SAan7pR4Xa4uuxqqdgPe3sKUSQ2f/FQCQO45ufjZn79vzAnHwsL88I
         IDcJpslsCoL5yZON91eBg04A4WTFGvJU3FO81SXExQ7bkjiGwIA9ZtJFVT9msPXkg+RR
         WlwqMF3u1ePLInc5r+9KgzDnb8B3Koab249x7+0rQfRErY6ffHD0ITUr5l1wTaVqVVss
         MS21q0mNAmG7XBCQQiT+UYTplUXmsznF8k7ewfYIExDltwg0facWr2829cCKZ8ZnQFJm
         9ImuR7eYZYY5f/VC5OAG8tBNt9SfgagXqQCX+uyb+mGhnTUsrWie/tUZfwedVRVbpGRZ
         Egcw==
X-Forwarded-Encrypted: i=1; AJvYcCV6Ms+3gZKQp8j5rB2IzRwqAdhImwfDrjeJUeFW0829fVfSRqdixOTOCgbmofeLvEIIE9o5GubS7pptMzo3ZEtVeLfFlGWw2PGaq7OP
X-Gm-Message-State: AOJu0YyYbdN3DU86YMgXswdAVjTVm+eUPCK/W9YM0/mpp3zbzlRKOcmE
	3o5nGnb/kFwH7taGnJlB29TrwXhTvg/3T/EphREaSMeS8PSR4zEsuui2jk+KNg==
X-Google-Smtp-Source: AGHT+IHARhz47PIHMyawvTQF5rNLL4xjB01X7ngu2akfWhwaqeMQhFBwOTxodRi0WcSq88ok9tiN0A==
X-Received: by 2002:a17:902:b944:b0:1d9:893f:cd06 with SMTP id h4-20020a170902b94400b001d9893fcd06mr6105079pls.60.1708145620829;
        Fri, 16 Feb 2024 20:53:40 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b001db92e7b80fsm626092plc.155.2024.02.16.20.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 20:53:39 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Puyou Lu <puyou.lu@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [PATCH v3 5/5] fortify: Improve buffer overflow reporting
Date: Fri, 16 Feb 2024 20:48:28 -0800
Message-Id: <20240217045335.1526675-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217043535.make.664-kees@kernel.org>
References: <20240217043535.make.664-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11459; i=keescook@chromium.org;
 h=from:subject; bh=o9bi0PQaph7nLtjH/UpCrP47Rjaglgom5drD61yQXYI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl0DqcWSD5g8bWqw5Np2W+346suamMHJeWtUZ8p
 TdB8pK3rSGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdA6nAAKCRCJcvTf3G3A
 JgE4D/9m0K1cswkGbu1+lS3yfX+30qR+82N7kQbHh4UkbEoYbKLfZM90+18eewHgou7+48MEg23
 qjJbbTuKatJQjEZntkXXchY6oI2NR5IMHnL7Rg8/QCGEOBr3iSn0pzsbN95kCX5+9zR9byw4qPe
 mtCYhckX38QdRAxxQZGUFpdEGjF7VcQ9YQ8BXPHzNFHfxr6gFeb3HQ9Zq1tc2HN2+bd3YIpHdkg
 kr+4AjBo5pssrXXhSoUehYYWrUgfCuQ8cd3jLPLrjXxiD0L7A1GUO0ppP1lWxUJAt5ISEscBxWL
 Bpzhh+rlyW/74e9JVDH1DMO8aI6Kc/4t2149NAH1e+pidkGxbt11FpfV9yrDjn4SajAmIp5unVT
 KXLboyvtY5ED8Hcy2t4coe3OUgX3gZpR5OZFKJgMt0DWLB/jgMB5TK39Jp4zABnIThXLCg3ibew
 WhgEw9p2Fm2bBgxFoU0/NQo4rudSBCqYZnJQ8ATfmuuyPMwYUnyRnOF7KPQNun4gZxOfgSgQdYX
 ZLJB1BEO3d+jCN1X9aWMHb32nNU61rdcmHfNK9/cMlUJw1H+aTnPYz+kWv3MbDHwRCCO8RNTpsB
 s0k8aYFA6JCA5SVlRC+Rt5T51tmV42na5BcHOF2nVgAQyKMbyJQfm46z6wt3scIUlYhVTUaMAmy 5yU7tIvgBucRKCA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Improve the reporting of buffer overflows under CONFIG_FORTIFY_SOURCE to
help accelerate debugging efforts. The calculations are all just sitting
in registers anyway, so pass them along to the function to be reported.

For example, before:

  detected buffer overflow in memcpy

and after:

  memcpy: detected buffer overflow: 4096 byte read of buffer size 1

Link: https://lore.kernel.org/r/20230407192717.636137-10-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/boot/compressed/misc.c |  2 +-
 arch/x86/boot/compressed/misc.c |  2 +-
 include/linux/fortify-string.h  | 56 ++++++++++++++++++---------------
 lib/fortify_kunit.c             |  4 +--
 lib/string_helpers.c            |  9 +++---
 5 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index d93e2e466f6a..6c41b270560e 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -154,7 +154,7 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 		putstr(" done, booting the kernel.\n");
 }
 
-void __fortify_panic(const u8 reason)
+void __fortify_panic(const u8 reason, size_t avail, size_t size)
 {
 	error("detected buffer overflow");
 }
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index c9971b9dbb09..1844da203da9 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -496,7 +496,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	return output + entry_offset;
 }
 
-void __fortify_panic(const u8 reason)
+void __fortify_panic(const u8 reason, size_t avail, size_t size)
 {
 	error("detected buffer overflow");
 }
diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index fbfb90479b8f..6aeebe0a6777 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -16,8 +16,8 @@
 					 FIELD_PREP(GENMASK(7, 1), func))
 
 #ifndef fortify_panic
-# define fortify_panic(func, write, retfail)	\
-	 __fortify_panic(FORTIFY_REASON(func, write))
+# define fortify_panic(func, write, avail, size, retfail)	\
+	 __fortify_panic(FORTIFY_REASON(func, write), avail, size)
 #endif
 
 #define FORTIFY_READ		 0
@@ -48,8 +48,8 @@ enum fortify_func {
 	EACH_FORTIFY_FUNC(MAKE_FORTIFY_FUNC)
 };
 
-void __fortify_report(const u8 reason);
-void __fortify_panic(const u8 reason) __cold __noreturn;
+void __fortify_report(const u8 reason, const size_t avail, const size_t size);
+void __fortify_panic(const u8 reason, const size_t avail, const size_t size) __cold __noreturn;
 void __read_overflow(void) __compiletime_error("detected read beyond size of object (1st parameter)");
 void __read_overflow2(void) __compiletime_error("detected read beyond size of object (2nd parameter)");
 void __read_overflow2_field(size_t avail, size_t wanted) __compiletime_warning("detected read beyond size of field (2nd parameter); maybe use struct_group()?");
@@ -183,7 +183,7 @@ char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__write_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_strncpy, FORTIFY_WRITE, p);
+		fortify_panic(FORTIFY_FUNC_strncpy, FORTIFY_WRITE, p_size, size, p);
 	return __underlying_strncpy(p, q, size);
 }
 
@@ -214,7 +214,7 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
 	/* Do not check characters beyond the end of p. */
 	ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
 	if (p_size <= ret && maxlen != ret)
-		fortify_panic(FORTIFY_FUNC_strnlen, FORTIFY_READ, ret);
+		fortify_panic(FORTIFY_FUNC_strnlen, FORTIFY_READ, p_size, ret + 1, ret);
 	return ret;
 }
 
@@ -250,7 +250,7 @@ __kernel_size_t __fortify_strlen(const char * const POS p)
 		return __underlying_strlen(p);
 	ret = strnlen(p, p_size);
 	if (p_size <= ret)
-		fortify_panic(FORTIFY_FUNC_strlen, FORTIFY_READ, ret);
+		fortify_panic(FORTIFY_FUNC_strlen, FORTIFY_READ, p_size, ret + 1, ret);
 	return ret;
 }
 
@@ -300,8 +300,8 @@ __FORTIFY_INLINE ssize_t sized_strscpy(char * const POS p, const char * const PO
 	 * Generate a runtime write overflow error if len is greater than
 	 * p_size.
 	 */
-	if (len > p_size)
-		fortify_panic(FORTIFY_FUNC_strscpy, FORTIFY_WRITE, -E2BIG);
+	if (p_size < len)
+		fortify_panic(FORTIFY_FUNC_strscpy, FORTIFY_WRITE, p_size, len, -E2BIG);
 
 	/*
 	 * We can now safely call vanilla strscpy because we are protected from:
@@ -359,7 +359,7 @@ size_t strlcat(char * const POS p, const char * const POS q, size_t avail)
 
 	/* Give up if string is already overflowed. */
 	if (p_size <= p_len)
-		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_READ, wanted);
+		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_READ, p_size, p_len + 1, wanted);
 
 	if (actual >= avail) {
 		copy_len = avail - p_len - 1;
@@ -368,7 +368,7 @@ size_t strlcat(char * const POS p, const char * const POS q, size_t avail)
 
 	/* Give up if copy will overflow. */
 	if (p_size <= actual)
-		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_WRITE, wanted);
+		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_WRITE, p_size, actual + 1, wanted);
 	__underlying_memcpy(p + p_len, q, copy_len);
 	p[actual] = '\0';
 
@@ -395,9 +395,10 @@ __FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, 2)
 char *strcat(char * const POS p, const char *q)
 {
 	const size_t p_size = __member_size(p);
+	const size_t wanted = strlcat(p, q, p_size);
 
-	if (strlcat(p, q, p_size) >= p_size)
-		fortify_panic(FORTIFY_FUNC_strcat, FORTIFY_WRITE, p);
+	if (p_size <= wanted)
+		fortify_panic(FORTIFY_FUNC_strcat, FORTIFY_WRITE, p_size, wanted + 1, p);
 	return p;
 }
 
@@ -426,14 +427,15 @@ char *strncat(char * const POS p, const char * const POS q, __kernel_size_t coun
 {
 	const size_t p_size = __member_size(p);
 	const size_t q_size = __member_size(q);
-	size_t p_len, copy_len;
+	size_t p_len, copy_len, total;
 
 	if (p_size == SIZE_MAX && q_size == SIZE_MAX)
 		return __underlying_strncat(p, q, count);
 	p_len = strlen(p);
 	copy_len = strnlen(q, count);
-	if (p_size < p_len + copy_len + 1)
-		fortify_panic(FORTIFY_FUNC_strncat, FORTIFY_WRITE, p);
+	total = p_len + copy_len + 1;
+	if (p_size < total)
+		fortify_panic(FORTIFY_FUNC_strncat, FORTIFY_WRITE, p_size, total, p);
 	__underlying_memcpy(p + p_len, q, copy_len);
 	p[p_len + copy_len] = '\0';
 	return p;
@@ -474,7 +476,7 @@ __FORTIFY_INLINE bool fortify_memset_chk(__kernel_size_t size,
 	 * lengths are unknown.)
 	 */
 	if (p_size != SIZE_MAX && p_size < size)
-		fortify_panic(FORTIFY_FUNC_memset, FORTIFY_WRITE, true);
+		fortify_panic(FORTIFY_FUNC_memset, FORTIFY_WRITE, p_size, size, true);
 	return false;
 }
 
@@ -574,9 +576,9 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	 * lengths are unknown.)
 	 */
 	if (p_size != SIZE_MAX && p_size < size)
-		fortify_panic(func, FORTIFY_WRITE, true);
+		fortify_panic(func, FORTIFY_WRITE, p_size, size, true);
 	else if (q_size != SIZE_MAX && q_size < size)
-		fortify_panic(func, FORTIFY_READ, true);
+		fortify_panic(func, FORTIFY_READ, p_size, size, true);
 
 	/*
 	 * Warn when writing beyond destination field size.
@@ -676,7 +678,7 @@ __FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_memscan, FORTIFY_READ, NULL);
+		fortify_panic(FORTIFY_FUNC_memscan, FORTIFY_READ, p_size, size, NULL);
 	return __real_memscan(p, c, size);
 }
 
@@ -692,8 +694,10 @@ int memcmp(const void * const POS0 p, const void * const POS0 q, __kernel_size_t
 		if (__compiletime_lessthan(q_size, size))
 			__read_overflow2();
 	}
-	if (p_size < size || q_size < size)
-		fortify_panic(FORTIFY_FUNC_memcmp, FORTIFY_READ, INT_MIN);
+	if (p_size < size)
+		fortify_panic(FORTIFY_FUNC_memcmp, FORTIFY_READ, p_size, size, INT_MIN);
+	else if (q_size < size)
+		fortify_panic(FORTIFY_FUNC_memcmp, FORTIFY_READ, q_size, size, INT_MIN);
 	return __underlying_memcmp(p, q, size);
 }
 
@@ -705,7 +709,7 @@ void *memchr(const void * const POS0 p, int c, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_memchr, FORTIFY_READ, NULL);
+		fortify_panic(FORTIFY_FUNC_memchr, FORTIFY_READ, p_size, size, NULL);
 	return __underlying_memchr(p, c, size);
 }
 
@@ -717,7 +721,7 @@ __FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_memchr_inv, FORTIFY_READ, NULL);
+		fortify_panic(FORTIFY_FUNC_memchr_inv, FORTIFY_READ, p_size, size, NULL);
 	return __real_memchr_inv(p, c, size);
 }
 
@@ -730,7 +734,7 @@ __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_kmemdup, FORTIFY_READ, NULL);
+		fortify_panic(FORTIFY_FUNC_kmemdup, FORTIFY_READ, p_size, size, NULL);
 	return __real_kmemdup(p, size, gfp);
 }
 
@@ -767,7 +771,7 @@ char *strcpy(char * const POS p, const char * const POS q)
 		__write_overflow();
 	/* Run-time check for dynamic size overflow. */
 	if (p_size < size)
-		fortify_panic(FORTIFY_FUNC_strcpy, FORTIFY_WRITE, p);
+		fortify_panic(FORTIFY_FUNC_strcpy, FORTIFY_WRITE, p_size, size, p);
 	__underlying_memcpy(p, q, size);
 	return p;
 }
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index f0accebeca02..493ec02dd5b3 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -17,8 +17,8 @@
 
 /* Redefine fortify_panic() to track failures. */
 void fortify_add_kunit_error(int write);
-#define fortify_panic(func, write, retfail) do {			\
-	__fortify_report(FORTIFY_REASON(func, write));			\
+#define fortify_panic(func, write, avail, size, retfail) do {		\
+	__fortify_report(FORTIFY_REASON(func, write), avail, size);	\
 	fortify_add_kunit_error(write);					\
 	return (retfail);						\
 } while (0)
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 5e53d42e32bb..5419282e12bd 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -1016,20 +1016,21 @@ static const char * const fortify_func_name[] = {
 #undef  MAKE_FORTIFY_FUNC_NAME
 };
 
-void __fortify_report(const u8 reason)
+void __fortify_report(const u8 reason, const size_t avail, const size_t size)
 {
 	const u8 func = FORTIFY_REASON_FUNC(reason);
 	const bool write = FORTIFY_REASON_DIR(reason);
 	const char *name;
 
 	name = fortify_func_name[umin(func, FORTIFY_FUNC_UNKNOWN)];
-	WARN(1, "%s: detected buffer %s overflow\n", name, str_read_write(!write));
+	WARN(1, "%s: detected buffer overflow: %zu byte %s of buffer size %zu\n",
+		 name, size, str_read_write(!write), avail);
 }
 EXPORT_SYMBOL(__fortify_report);
 
-void __fortify_panic(const u8 reason)
+void __fortify_panic(const u8 reason, const size_t avail, const size_t size)
 {
-	__fortify_report(reason);
+	__fortify_report(reason, avail, size);
 	BUG();
 }
 EXPORT_SYMBOL(__fortify_panic);
-- 
2.34.1


