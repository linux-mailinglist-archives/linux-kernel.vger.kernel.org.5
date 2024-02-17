Return-Path: <linux-kernel+bounces-69686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B19D5858D41
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 05:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68E162827BF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 04:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFCF1CD2A;
	Sat, 17 Feb 2024 04:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IjTYoksW"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1021C69D
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 04:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708145621; cv=none; b=BIIlBprayIFCLSIN8TuQjqQebLyVviXtV93t97qe+6ljUrmbwlpux7PY/ZPhyAy/tz6YWYXOZTx35dvxKbzQil/AjyIvDAhujWfXUOfPz4AeAfl4s0X8iuzBN6smcCH2yhMRLw9RGMPzlhte45jWKcBtyyY1H0elgrD5Hj/vbvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708145621; c=relaxed/simple;
	bh=YoMI2eAU7bea6ne283y1TtKCLsonFYrY3DXQAfqNLjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HwAXCpQ7B0Go8J/QdYoYTWGFN8iPAdfau+DNMwupxR+d/rdBqTy6NFi5Bj7J7e+BkN2ECkvc9Nl/86WFwv8Nx4t9z+a5sAGEjk4f2SNOSlhbIrti9QPwfeU17tXzTDOlWyQTgfYV+WWi+XdEw2smfHjHi0hp7LFcTkX+YB+hj8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IjTYoksW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d944e8f367so25941995ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 20:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708145619; x=1708750419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQ5gV9CXUyFtitKBx8YkJF+WHLIxVIqL5lNg3JpCqzI=;
        b=IjTYoksWNjGW4FpT1FbnV0/u4yvyzbND0NBlMgWn0j2ucjmWdkOujmPi7eu+SXgK0D
         DF7n1KKZOs99xl4kZtIgRP2/Swx7jCYU4rinNaPhbJeznm4mA+YZIRrQQ4PAQdyRsy6U
         Tl9lMNXP1SiqxfxY9gxXbv583oJHYE6+HdTls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708145619; x=1708750419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQ5gV9CXUyFtitKBx8YkJF+WHLIxVIqL5lNg3JpCqzI=;
        b=LDm/sGkGVkqhnY89Zk4EtFxanbgBVnLcjwGiy5SKSY+hKSz+2F6rWQUzgerVdf8WE/
         prHOWfczjcyIOfWZEzp+VvtRGNyaoBH99Odj7B/pgIR4zEetN381YVQSqebkEtK4EuAF
         fyIiTm14J2CBahC+grBBUB+TOYuyUVpX+wGHq4DjyIncT/VbslXo7G4eb50vWTpSQLBk
         aT+woVJylnYqEQ5DHAy136nZhmOBjfzq6mlBn7DHB+4Qbon0soDWctjvoAj9oAg5U5AV
         cOmEWWQPHMpI6TsQRdyAJ8lMA5feeg4Jm55UVYbviHTv4l0RpsiN8vudWrs0pUhuMo3B
         7DSw==
X-Forwarded-Encrypted: i=1; AJvYcCWRk8y+zQ4to01FzWHZ+A0sRNZDUaqWaH7/WT/DmIXLjOKja11gZW+SdmXAPd9t6Oay2XviUQDrMHl7RQr8X9diHmMYHnj6ykkWwE8H
X-Gm-Message-State: AOJu0Yym07ETqqoDklVLUPpmbm9CjhHqTRm7A9px3vcQPh2t1S2brxIx
	CEiU+QKMTaEacJf0jKI8kbODbQMdja+sqKC8qou+SBcbgo9lGUdef+MHguBWdw==
X-Google-Smtp-Source: AGHT+IHo/CpnUIhHhGpwVHk9PNkkWEtmaoORDj0R7rY+5O0VnwoD/QQmQLbi8y37SaKfdcYNSNQREg==
X-Received: by 2002:a17:902:dad2:b0:1da:1d91:7131 with SMTP id q18-20020a170902dad200b001da1d917131mr8574310plx.57.1708145618863;
        Fri, 16 Feb 2024 20:53:38 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902c64300b001d93ba1120dsm625287pls.200.2024.02.16.20.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 20:53:36 -0800 (PST)
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
Subject: [PATCH v3 1/5] fortify: Split reporting and avoid passing string pointer
Date: Fri, 16 Feb 2024 20:48:24 -0800
Message-Id: <20240217045335.1526675-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217043535.make.664-kees@kernel.org>
References: <20240217043535.make.664-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12013; i=keescook@chromium.org;
 h=from:subject; bh=YoMI2eAU7bea6ne283y1TtKCLsonFYrY3DXQAfqNLjo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl0Dqc1uepxbmeD9CO9ZPH176i41FVAe9bBqFpA
 ZKOI9Cg7oKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdA6nAAKCRCJcvTf3G3A
 Jr3AD/9XaSs0pbudKqxbrv8zV31XF1AVf1DPO/73+eJuGkjqNKLlqoagd8eBj+vNzUEhvt5HsCj
 x9tykiOGBGlBORBoMDLeuxhB/dcVIoUtOXaufi/ff5fn4lb1A+jfbkHGHFM4tpCoUDjxE5qdpJa
 ETavEnAb1Xr7H90OkxvJy5b/b/t5+OmaAulRK+3xf3lWNNk4QlRJqGDjn7Z6rC+UOty51iBu76o
 YaFHyKwc0AOTb3dAedKPD7qmv9REtVIQhgebOPlmwi/5hX1f57rPYcTYAaHJQykIlhPH1TEvs4r
 dIyCuvgVbN0MRc5d3vAtjkXGT59hpkXOmJUwp0Vqi/Pa1bjvKXlOSL1w4OW/iRpyUM4PDmjCfg8
 0dCZMbsVMTS4Cm749NE1vdQ3fzsaybO5o1y7/ZFUpn6iYaGGwADbuxRY5Qgtzwb6ctSy5bxuF2i
 UsGaDvv8jkUEpZgKuwpvAXwmM5uIVp6OD+trbLyBfHGy6Js7uAeSgT8Gc5FI6IWgTWRsaAJWdmt
 OXgpvGzYyzE0Gwks1IUUpPayDh5n2AOsDpuxX63SuP21mMF52tU4/jKNLby5PSULpkoDrwkqAJI
 Efy5AwFNXu4z2yb2t8uuit+XCXMXM3SFsDLIzZWOochiK0yJgSYY/NLCoYAu+qCEue2ujuhVxM5 lXsFMxtgtqaiqJw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for KUnit testing and further improvements in fortify
failure reporting, split out the report and encode the function and access
failure (read or write overflow) into a single u8 argument. This mainly
ends up saving a tiny bit of space in the data segment. For a defconfig
with FORTIFY_SOURCE enabled:

$ size gcc/vmlinux.before gcc/vmlinux.after
   text  	  data     bss     dec    	    hex filename
26132309        9760658 2195460 38088427        2452eeb gcc/vmlinux.before
26132386        9748382 2195460 38076228        244ff44 gcc/vmlinux.after

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: linux-hardening@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Puyou Lu <puyou.lu@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
---
 arch/arm/boot/compressed/misc.c |  2 +-
 arch/x86/boot/compressed/misc.c |  2 +-
 include/linux/fortify-string.h  | 81 ++++++++++++++++++++++++---------
 lib/string_helpers.c            | 23 ++++++++--
 tools/objtool/noreturns.h       |  2 +-
 5 files changed, 83 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 6b4baa6a9a50..d93e2e466f6a 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -154,7 +154,7 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 		putstr(" done, booting the kernel.\n");
 }
 
-void fortify_panic(const char *name)
+void __fortify_panic(const u8 reason)
 {
 	error("detected buffer overflow");
 }
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index b99e08e6815b..c9971b9dbb09 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -496,7 +496,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	return output + entry_offset;
 }
 
-void fortify_panic(const char *name)
+void __fortify_panic(const u8 reason)
 {
 	error("detected buffer overflow");
 }
diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 06b3aaa63724..4f6767dcd933 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_FORTIFY_STRING_H_
 #define _LINUX_FORTIFY_STRING_H_
 
+#include <linux/bitfield.h>
 #include <linux/bug.h>
 #include <linux/const.h>
 #include <linux/limits.h>
@@ -9,7 +10,44 @@
 #define __FORTIFY_INLINE extern __always_inline __gnu_inline __overloadable
 #define __RENAME(x) __asm__(#x)
 
-void fortify_panic(const char *name) __noreturn __cold;
+#define FORTIFY_REASON_DIR(r)		FIELD_GET(BIT(0), r)
+#define FORTIFY_REASON_FUNC(r)		FIELD_GET(GENMASK(7, 1), r)
+#define FORTIFY_REASON(func, write)	(FIELD_PREP(BIT(0), write) | \
+					 FIELD_PREP(GENMASK(7, 1), func))
+
+#define fortify_panic(func, write)	\
+	__fortify_panic(FORTIFY_REASON(func, write))
+
+#define FORTIFY_READ		 0
+#define FORTIFY_WRITE		 1
+
+#define EACH_FORTIFY_FUNC(macro)	\
+	macro(strncpy),			\
+	macro(strnlen),			\
+	macro(strlen),			\
+	macro(strscpy),			\
+	macro(strlcat),			\
+	macro(strcat),			\
+	macro(strncat),			\
+	macro(memset),			\
+	macro(memcpy),			\
+	macro(memmove),			\
+	macro(memscan),			\
+	macro(memcmp),			\
+	macro(memchr),			\
+	macro(memchr_inv),		\
+	macro(kmemdup),			\
+	macro(strcpy),			\
+	macro(UNKNOWN),
+
+#define MAKE_FORTIFY_FUNC(func)	FORTIFY_FUNC_##func
+
+enum fortify_func {
+	EACH_FORTIFY_FUNC(MAKE_FORTIFY_FUNC)
+};
+
+void __fortify_report(const u8 reason);
+void __fortify_panic(const u8 reason) __cold __noreturn;
 void __read_overflow(void) __compiletime_error("detected read beyond size of object (1st parameter)");
 void __read_overflow2(void) __compiletime_error("detected read beyond size of object (2nd parameter)");
 void __read_overflow2_field(size_t avail, size_t wanted) __compiletime_warning("detected read beyond size of field (2nd parameter); maybe use struct_group()?");
@@ -143,7 +181,7 @@ char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__write_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strncpy, FORTIFY_WRITE);
 	return __underlying_strncpy(p, q, size);
 }
 
@@ -174,7 +212,7 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
 	/* Do not check characters beyond the end of p. */
 	ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
 	if (p_size <= ret && maxlen != ret)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strnlen, FORTIFY_READ);
 	return ret;
 }
 
@@ -210,7 +248,7 @@ __kernel_size_t __fortify_strlen(const char * const POS p)
 		return __underlying_strlen(p);
 	ret = strnlen(p, p_size);
 	if (p_size <= ret)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strlen, FORTIFY_READ);
 	return ret;
 }
 
@@ -261,7 +299,7 @@ __FORTIFY_INLINE ssize_t sized_strscpy(char * const POS p, const char * const PO
 	 * p_size.
 	 */
 	if (len > p_size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strscpy, FORTIFY_WRITE);
 
 	/*
 	 * We can now safely call vanilla strscpy because we are protected from:
@@ -319,7 +357,7 @@ size_t strlcat(char * const POS p, const char * const POS q, size_t avail)
 
 	/* Give up if string is already overflowed. */
 	if (p_size <= p_len)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_READ);
 
 	if (actual >= avail) {
 		copy_len = avail - p_len - 1;
@@ -328,7 +366,7 @@ size_t strlcat(char * const POS p, const char * const POS q, size_t avail)
 
 	/* Give up if copy will overflow. */
 	if (p_size <= actual)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strlcat, FORTIFY_WRITE);
 	__underlying_memcpy(p + p_len, q, copy_len);
 	p[actual] = '\0';
 
@@ -357,7 +395,7 @@ char *strcat(char * const POS p, const char *q)
 	const size_t p_size = __member_size(p);
 
 	if (strlcat(p, q, p_size) >= p_size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strcat, FORTIFY_WRITE);
 	return p;
 }
 
@@ -393,7 +431,7 @@ char *strncat(char * const POS p, const char * const POS q, __kernel_size_t coun
 	p_len = strlen(p);
 	copy_len = strnlen(q, count);
 	if (p_size < p_len + copy_len + 1)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strncat, FORTIFY_WRITE);
 	__underlying_memcpy(p + p_len, q, copy_len);
 	p[p_len + copy_len] = '\0';
 	return p;
@@ -434,7 +472,7 @@ __FORTIFY_INLINE void fortify_memset_chk(__kernel_size_t size,
 	 * lengths are unknown.)
 	 */
 	if (p_size != SIZE_MAX && p_size < size)
-		fortify_panic("memset");
+		fortify_panic(FORTIFY_FUNC_memset, FORTIFY_WRITE);
 }
 
 #define __fortify_memset_chk(p, c, size, p_size, p_size_field) ({	\
@@ -488,7 +526,7 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 					 const size_t q_size,
 					 const size_t p_size_field,
 					 const size_t q_size_field,
-					 const char *func)
+					 const u8 func)
 {
 	if (__builtin_constant_p(size)) {
 		/*
@@ -532,9 +570,10 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	 * (The SIZE_MAX test is to optimize away checks where the buffer
 	 * lengths are unknown.)
 	 */
-	if ((p_size != SIZE_MAX && p_size < size) ||
-	    (q_size != SIZE_MAX && q_size < size))
-		fortify_panic(func);
+	if (p_size != SIZE_MAX && p_size < size)
+		fortify_panic(func, FORTIFY_WRITE);
+	else if (q_size != SIZE_MAX && q_size < size)
+		fortify_panic(func, FORTIFY_READ);
 
 	/*
 	 * Warn when writing beyond destination field size.
@@ -567,7 +606,7 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	const size_t __q_size_field = (q_size_field);			\
 	WARN_ONCE(fortify_memcpy_chk(__fortify_size, __p_size,		\
 				     __q_size, __p_size_field,		\
-				     __q_size_field, #op),		\
+				     __q_size_field, FORTIFY_FUNC_ ##op), \
 		  #op ": detected field-spanning write (size %zu) of single %s (size %zu)\n", \
 		  __fortify_size,					\
 		  "field \"" #p "\" at " FILE_LINE,			\
@@ -634,7 +673,7 @@ __FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_memscan, FORTIFY_READ);
 	return __real_memscan(p, c, size);
 }
 
@@ -651,7 +690,7 @@ int memcmp(const void * const POS0 p, const void * const POS0 q, __kernel_size_t
 			__read_overflow2();
 	}
 	if (p_size < size || q_size < size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_memcmp, FORTIFY_READ);
 	return __underlying_memcmp(p, q, size);
 }
 
@@ -663,7 +702,7 @@ void *memchr(const void * const POS0 p, int c, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_memchr, FORTIFY_READ);
 	return __underlying_memchr(p, c, size);
 }
 
@@ -675,7 +714,7 @@ __FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_memchr_inv, FORTIFY_READ);
 	return __real_memchr_inv(p, c, size);
 }
 
@@ -688,7 +727,7 @@ __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_kmemdup, FORTIFY_READ);
 	return __real_kmemdup(p, size, gfp);
 }
 
@@ -725,7 +764,7 @@ char *strcpy(char * const POS p, const char * const POS q)
 		__write_overflow();
 	/* Run-time check for dynamic size overflow. */
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(FORTIFY_FUNC_strcpy, FORTIFY_WRITE);
 	__underlying_memcpy(p, q, size);
 	return p;
 }
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 606c3099013f..9291dc74ae01 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -1008,10 +1008,27 @@ EXPORT_SYMBOL(__read_overflow2_field);
 void __write_overflow_field(size_t avail, size_t wanted) { }
 EXPORT_SYMBOL(__write_overflow_field);
 
-void fortify_panic(const char *name)
+static const char * const fortify_func_name[] = {
+#define MAKE_FORTIFY_FUNC_NAME(func)	[MAKE_FORTIFY_FUNC(func)] = #func
+	EACH_FORTIFY_FUNC(MAKE_FORTIFY_FUNC_NAME)
+#undef  MAKE_FORTIFY_FUNC_NAME
+};
+
+void __fortify_report(const u8 reason)
+{
+	const u8 func = FORTIFY_REASON_FUNC(reason);
+	const bool write = FORTIFY_REASON_DIR(reason);
+	const char *name;
+
+	name = fortify_func_name[umin(func, FORTIFY_FUNC_UNKNOWN)];
+	WARN(1, "%s: detected buffer %s overflow\n", name, str_read_write(!write));
+}
+EXPORT_SYMBOL(__fortify_report);
+
+void __fortify_panic(const u8 reason)
 {
-	pr_emerg("detected buffer overflow in %s\n", name);
+	__fortify_report(reason);
 	BUG();
 }
-EXPORT_SYMBOL(fortify_panic);
+EXPORT_SYMBOL(__fortify_panic);
 #endif /* CONFIG_FORTIFY_SOURCE */
diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index 1685d7ea6a9f..3a301696f005 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -6,6 +6,7 @@
  *
  * Yes, this is unfortunate.  A better solution is in the works.
  */
+NORETURN(__fortify_panic)
 NORETURN(__kunit_abort)
 NORETURN(__module_put_and_kthread_exit)
 NORETURN(__reiserfs_panic)
@@ -22,7 +23,6 @@ NORETURN(do_exit)
 NORETURN(do_group_exit)
 NORETURN(do_task_dead)
 NORETURN(ex_handler_msr_mce)
-NORETURN(fortify_panic)
 NORETURN(hlt_play_dead)
 NORETURN(hv_ghcb_terminate)
 NORETURN(kthread_complete_and_exit)
-- 
2.34.1


