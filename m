Return-Path: <linux-kernel+bounces-69327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F4C858770
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175361C2431C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC2C139595;
	Fri, 16 Feb 2024 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ywx5Ixl9"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DD81487EF
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115986; cv=none; b=oyIlP8t2yiXjH34HlIxOD9YyH/6x4H/bOMwQK5JK7crtwc7mQ5yJABb1wRx40hJK0W3mfD6vKvj8J3BPSuNRmYXcAgZrQVvT+YDGVnND5WGMVRW6umMRtVgLtfd8xDN3aVFfJ8D1Y21hitMceqAJ1bi89fsIQhKuVk+Gp3pwNTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115986; c=relaxed/simple;
	bh=UAarzlLZNnS7Vm2NrmTERcnGSEK4P42ieUXek0iNry4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nQhJ9J7ATJPG+jmZZMior2MFgy4oX+qbyWYI8WdstgfchQ8mYrA/oRsF04y1677eb33DP78kVN5oa2QuG94iCkP04IsN9FBBCpowPnF3qodwcMfwltBQvBT/CpHwfJLfrRiI2Nruf1+fBo/cWmX8uCznpjCfOmFS+JaRG9jkStk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ywx5Ixl9; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29041136f73so2007037a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708115984; x=1708720784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mz+jKxxKsBo4Xcua4thlFKQreFCbjzfEWLASDxnfABk=;
        b=Ywx5Ixl9bXtTcCASeu84XxBcf3wA0L7eho+458DKGDy9teqUCWOzU4/Q38r0gWn5LG
         VNS9MhOV5XgDKlakUnJ69U+vZukqhyNj3VmPUrygB8gqs+0fEVAAkf/iFr2YW8zOwjwc
         v3WYFlURkDp5LzilGRZndC/laUDUZArJZGGnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115984; x=1708720784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mz+jKxxKsBo4Xcua4thlFKQreFCbjzfEWLASDxnfABk=;
        b=RgBROSrbyWIt8aQ/rDTCaCmD+b99BoUpsrB1SfVnp33O6oZlUBotG0AFm/+ZKDZn05
         imabH+CZ8m3dLhIT2nM5/b2Ge1qlo0sx+aDz+rPwy/pbKR5BnuDnruvCr4rgf/Nw01TA
         7i8NYJTgziK+0wOzeU/XE0Hj20GzhOkJv+gy4rYFz/vR/wDtfyi6truVejojQO21US/a
         5atSVbfsz2JkIowLjFwdzuel+iAdcAW2bbLSqa2nTX7elf5yXxxYej21zs4gs0G91w/M
         CgvvR20JIlwKW0mCrdV4Fx4GxnQGF4pibt7kwjlBN71GYOJ94tnBN8DqXeyzv9sqeG5t
         EF0w==
X-Forwarded-Encrypted: i=1; AJvYcCUT/1aKW2kjXdiKwKe4f2oZRT5+HoIToxg7UD6FMgLG1nQjWkyD86Q5d8UWmBzU3O387bQWpPopnvEWU5xyTNIXBKdzfy8VgBz1Vr5r
X-Gm-Message-State: AOJu0YyBtKK7yyTwC24D3mLGt97n+/7BDYh8AIzJivkXyntHFyzQ9P5h
	A3n6HIpxLK4S64X08U00PCUtkJTKxSd8ANyQhf3KGykqBuqp7lINcJCikQYlRg==
X-Google-Smtp-Source: AGHT+IGYgl3gQl4Cmde6i17y1uUfnj2tUICkxVuF2V/VMYxqsgOJ37h8BbLRRpI6ZiyO945kOuIkHg==
X-Received: by 2002:a17:90b:1953:b0:296:359a:22f0 with SMTP id nk19-20020a17090b195300b00296359a22f0mr6062420pjb.36.1708115983834;
        Fri, 16 Feb 2024 12:39:43 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mp14-20020a17090b190e00b002993f72ed02sm422428pjb.34.2024.02.16.12.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:39:43 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fortify: Include more details when reporting overflows
Date: Fri, 16 Feb 2024 12:39:41 -0800
Message-Id: <20240216203935.work.829-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12427; i=keescook@chromium.org;
 h=from:subject:message-id; bh=UAarzlLZNnS7Vm2NrmTERcnGSEK4P42ieUXek0iNry4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlz8gN5oedJPqvQfhNkOccc+veejVyk7cBAz9F5
 7Wuj4LaUR2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZc/IDQAKCRCJcvTf3G3A
 JvWBD/9Skuyw4/sVIKVPI7E9tVZ64SFo4cL+4tfHfA/+pcODVsEXe4k13ZTUeSYzBHI/wV2GJG0
 nMBFWhsQoWDncv5I5gOooFbFgnrhxRMYIJ7LvlcnmeEnmoRlb2ph+KkO3qIdp/4bng696KHSG8n
 tgPMXYiae2g1vXKoIJe7ho5P1mVaY6xpE83kSAVRVZseVIMBkEOs+K8cgpZ6vQzLgkATe1f8E7h
 uiAZl1WccvX1yRU79fOc0rxIbv0St/H+/8dn+wr6ypx12ZOdk/sAv620dhbSKfKzhCUh020HYlm
 7xdG4zICyipCTagwPh0FuaBZg9afrhduV6qjGEuZW0IYaFm0nT8Np1tOmv3QBQIEftfFcUTjJWC
 4BnLsZHXNW6k/MQnzoYVxORG+o3WoAsGTXMZ7tQxWTBX4MOPo7UrR61dfaexQ5vxqSMstqcrhxI
 c/iZVmSswL/SfO6RXiw72PoXa7SLjbeBTDQEn+EqEGkrvvD3hRkC7WkDbIUVhKsxe0tk0ijdPfL
 OTP4IRshOqVHgBRppsy3523VGm7qOsC7uFoUtbMF+m1+L08qGCbB4xrhHGQjYiHzscwLaCGI0lY
 fdIcZ4vUO9OlTKjqqZHZCa58OlLg27njf+maH/ozsUZMXP8R9LaEaCAZs0dtctsAdGl/NRTDvSZ
 6EltVg A4aHpMbcw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When a memcpy() would exceed the length of an entire structure, no
detailed WARN would be emitted, making debugging a bit more challenging.
Similarly, other buffer overflow reports would have no size information
reported.

Always warn for memcpy() overflows, but distinguish between the two
cases in the message before continuing (warn-only) or blocking the copy
(hard-fail). Additionally add size information to existing overflow
reports.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: linux-hardening@vger.kernel.org
---
 arch/arm/boot/compressed/misc.c |  2 +-
 arch/arm/boot/compressed/misc.h |  2 +-
 arch/x86/boot/compressed/misc.c |  2 +-
 include/linux/fortify-string.h  | 96 ++++++++++++++++++++-------------
 lib/string_helpers.c            |  5 +-
 5 files changed, 64 insertions(+), 43 deletions(-)

diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 6b4baa6a9a50..c8b978c0cc5a 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -154,7 +154,7 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 		putstr(" done, booting the kernel.\n");
 }
 
-void fortify_panic(const char *name)
+void fortify_panic(const char *name, size_t avail, size_t size)
 {
 	error("detected buffer overflow");
 }
diff --git a/arch/arm/boot/compressed/misc.h b/arch/arm/boot/compressed/misc.h
index 6da00a26ac08..efe3d40d3e61 100644
--- a/arch/arm/boot/compressed/misc.h
+++ b/arch/arm/boot/compressed/misc.h
@@ -10,7 +10,7 @@ void __div0(void);
 void
 decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 		  unsigned long free_mem_ptr_end_p, int arch_id);
-void fortify_panic(const char *name);
+void fortify_panic(const char *name, size_t avail, size_t size);
 int atags_to_fdt(void *atag_list, void *fdt, int total_space);
 uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt);
 int do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x));
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index b99e08e6815b..c382419f1e4e 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -496,7 +496,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	return output + entry_offset;
 }
 
-void fortify_panic(const char *name)
+void fortify_panic(const char *name, size_t avail, size_t size)
 {
 	error("detected buffer overflow");
 }
diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 06b3aaa63724..d278671dcd44 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -9,7 +9,7 @@
 #define __FORTIFY_INLINE extern __always_inline __gnu_inline __overloadable
 #define __RENAME(x) __asm__(#x)
 
-void fortify_panic(const char *name) __noreturn __cold;
+void fortify_panic(const char *name, size_t avail, size_t size) __noreturn __cold;
 void __read_overflow(void) __compiletime_error("detected read beyond size of object (1st parameter)");
 void __read_overflow2(void) __compiletime_error("detected read beyond size of object (2nd parameter)");
 void __read_overflow2_field(size_t avail, size_t wanted) __compiletime_warning("detected read beyond size of field (2nd parameter); maybe use struct_group()?");
@@ -143,7 +143,7 @@ char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__write_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(__func__, p_size, size);
 	return __underlying_strncpy(p, q, size);
 }
 
@@ -174,7 +174,7 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const POS p, __kernel_size
 	/* Do not check characters beyond the end of p. */
 	ret = __real_strnlen(p, maxlen < p_size ? maxlen : p_size);
 	if (p_size <= ret && maxlen != ret)
-		fortify_panic(__func__);
+		fortify_panic(__func__, p_size, ret + 1);
 	return ret;
 }
 
@@ -210,7 +210,7 @@ __kernel_size_t __fortify_strlen(const char * const POS p)
 		return __underlying_strlen(p);
 	ret = strnlen(p, p_size);
 	if (p_size <= ret)
-		fortify_panic(__func__);
+		fortify_panic(__func__, p_size, ret + 1);
 	return ret;
 }
 
@@ -261,7 +261,7 @@ __FORTIFY_INLINE ssize_t sized_strscpy(char * const POS p, const char * const PO
 	 * p_size.
 	 */
 	if (len > p_size)
-		fortify_panic(__func__);
+		fortify_panic(__func__, p_size, len);
 
 	/*
 	 * We can now safely call vanilla strscpy because we are protected from:
@@ -319,7 +319,7 @@ size_t strlcat(char * const POS p, const char * const POS q, size_t avail)
 
 	/* Give up if string is already overflowed. */
 	if (p_size <= p_len)
-		fortify_panic(__func__);
+		fortify_panic(__func__, p_size, p_len + 1);
 
 	if (actual >= avail) {
 		copy_len = avail - p_len - 1;
@@ -328,7 +328,7 @@ size_t strlcat(char * const POS p, const char * const POS q, size_t avail)
 
 	/* Give up if copy will overflow. */
 	if (p_size <= actual)
-		fortify_panic(__func__);
+		fortify_panic(__func__, p_size, actual + 1);
 	__underlying_memcpy(p + p_len, q, copy_len);
 	p[actual] = '\0';
 
@@ -355,9 +355,10 @@ __FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, 2)
 char *strcat(char * const POS p, const char *q)
 {
 	const size_t p_size = __member_size(p);
+	const size_t size = strlcat(p, q, p_size);
 
-	if (strlcat(p, q, p_size) >= p_size)
-		fortify_panic(__func__);
+	if (size >= p_size)
+		fortify_panic(__func__, p_size, size + 1);
 	return p;
 }
 
@@ -386,14 +387,15 @@ char *strncat(char * const POS p, const char * const POS q, __kernel_size_t coun
 {
 	const size_t p_size = __member_size(p);
 	const size_t q_size = __member_size(q);
-	size_t p_len, copy_len;
+	size_t p_len, copy_len, size;
 
 	if (p_size == SIZE_MAX && q_size == SIZE_MAX)
 		return __underlying_strncat(p, q, count);
 	p_len = strlen(p);
 	copy_len = strnlen(q, count);
-	if (p_size < p_len + copy_len + 1)
-		fortify_panic(__func__);
+	size = p_len + copy_len + 1;
+	if (p_size < size)
+		fortify_panic(__func__, p_size, size);
 	__underlying_memcpy(p + p_len, q, copy_len);
 	p[p_len + copy_len] = '\0';
 	return p;
@@ -434,7 +436,7 @@ __FORTIFY_INLINE void fortify_memset_chk(__kernel_size_t size,
 	 * lengths are unknown.)
 	 */
 	if (p_size != SIZE_MAX && p_size < size)
-		fortify_panic("memset");
+		fortify_panic("memset", p_size, size);
 }
 
 #define __fortify_memset_chk(p, c, size, p_size, p_size_field) ({	\
@@ -482,13 +484,17 @@ __FORTIFY_INLINE void fortify_memset_chk(__kernel_size_t size,
  * B = can perform run-time bounds checking (currently unimplemented)
  * V = vulnerable to run-time overflow (will need refactoring to solve)
  *
+ * Return 0 if buffer size checks pass (or cannot be evaluated).
+ * Return 1 if a cross-field overflow is detected within the dest structure.
+ * Return 2 if an overflow beyond the end of the dest structure is detected.
+ * Return 3 if an overflow beyond the end of the source structure is detected.
  */
-__FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
-					 const size_t p_size,
-					 const size_t q_size,
-					 const size_t p_size_field,
-					 const size_t q_size_field,
-					 const char *func)
+__FORTIFY_INLINE int fortify_memcpy_chk(__kernel_size_t size,
+					const size_t p_size,
+					const size_t q_size,
+					const size_t p_size_field,
+					const size_t q_size_field,
+					const char *func)
 {
 	if (__builtin_constant_p(size)) {
 		/*
@@ -532,9 +538,10 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	 * (The SIZE_MAX test is to optimize away checks where the buffer
 	 * lengths are unknown.)
 	 */
-	if ((p_size != SIZE_MAX && p_size < size) ||
-	    (q_size != SIZE_MAX && q_size < size))
-		fortify_panic(func);
+	if (p_size != SIZE_MAX && p_size < size)
+		return 2;
+	if (q_size != SIZE_MAX && q_size < size)
+		return 3;
 
 	/*
 	 * Warn when writing beyond destination field size.
@@ -553,9 +560,9 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	 */
 	if (p_size_field != 0 && p_size_field != SIZE_MAX &&
 	    p_size != p_size_field && p_size_field < size)
-		return true;
+		return 1;
 
-	return false;
+	return 0;
 }
 
 #define __fortify_memcpy_chk(p, q, size, p_size, q_size,		\
@@ -565,13 +572,24 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	const size_t __q_size = (q_size);				\
 	const size_t __p_size_field = (p_size_field);			\
 	const size_t __q_size_field = (q_size_field);			\
-	WARN_ONCE(fortify_memcpy_chk(__fortify_size, __p_size,		\
-				     __q_size, __p_size_field,		\
-				     __q_size_field, #op),		\
-		  #op ": detected field-spanning write (size %zu) of single %s (size %zu)\n", \
-		  __fortify_size,					\
-		  "field \"" #p "\" at " FILE_LINE,			\
-		  __p_size_field);					\
+	int rc;								\
+	rc = fortify_memcpy_chk(__fortify_size, __p_size,		\
+				__q_size, __p_size_field,		\
+				__q_size_field, #op);			\
+	WARN_ONCE(rc,							\
+		#op ": detected %s-spanning %s (size %zu) of %s (size %zu)\n", \
+		rc == 1 ? "field" : "struct",				\
+		rc == 3 ? "read" : "write",				\
+		__fortify_size,						\
+		rc < 3 ?						\
+			"destination \"" #p "\" at " FILE_LINE :	\
+			"source \"" #q "\" at " FILE_LINE,		\
+		rc == 3 ? __q_size :					\
+			(rc == 2 ? __p_size : __p_size_field));		\
+	if (rc == 2)							\
+		fortify_panic(#op " write", __p_size, __fortify_size);	\
+	if (rc == 3)							\
+		fortify_panic(#op " read", __q_size, __fortify_size);	\
 	__underlying_##op(p, q, __fortify_size);			\
 })
 
@@ -634,7 +652,7 @@ __FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(__func__, p_size, size);
 	return __real_memscan(p, c, size);
 }
 
@@ -650,8 +668,10 @@ int memcmp(const void * const POS0 p, const void * const POS0 q, __kernel_size_t
 		if (__compiletime_lessthan(q_size, size))
 			__read_overflow2();
 	}
-	if (p_size < size || q_size < size)
-		fortify_panic(__func__);
+	if (p_size < size)
+		fortify_panic(__func__, p_size, size);
+	if (q_size < size)
+		fortify_panic(__func__, q_size, size);
 	return __underlying_memcmp(p, q, size);
 }
 
@@ -663,7 +683,7 @@ void *memchr(const void * const POS0 p, int c, __kernel_size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(__func__, p_size, size);
 	return __underlying_memchr(p, c, size);
 }
 
@@ -675,7 +695,7 @@ __FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(__func__, p_size, size);
 	return __real_memchr_inv(p, c, size);
 }
 
@@ -688,7 +708,7 @@ __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp
 	if (__compiletime_lessthan(p_size, size))
 		__read_overflow();
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(__func__, p_size, size);
 	return __real_kmemdup(p, size, gfp);
 }
 
@@ -725,7 +745,7 @@ char *strcpy(char * const POS p, const char * const POS q)
 		__write_overflow();
 	/* Run-time check for dynamic size overflow. */
 	if (p_size < size)
-		fortify_panic(__func__);
+		fortify_panic(__func__, p_size, size);
 	__underlying_memcpy(p, q, size);
 	return p;
 }
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 606c3099013f..0661c563101e 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -1008,9 +1008,10 @@ EXPORT_SYMBOL(__read_overflow2_field);
 void __write_overflow_field(size_t avail, size_t wanted) { }
 EXPORT_SYMBOL(__write_overflow_field);
 
-void fortify_panic(const char *name)
+void fortify_panic(const char *name, size_t avail, size_t size)
 {
-	pr_emerg("detected buffer overflow in %s\n", name);
+	pr_emerg("detected buffer overflow in %s (%zu > %zu)\n",
+		 name, size, avail);
 	BUG();
 }
 EXPORT_SYMBOL(fortify_panic);
-- 
2.34.1


