Return-Path: <linux-kernel+bounces-55104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5BF84B7B9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FD81C240E5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A50133414;
	Tue,  6 Feb 2024 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BJUtpPFq"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6D6132C03
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229348; cv=none; b=L1Ndox8ScJCInT5955VcDT6Wn9GAR5evu9wOdLl6kY5RpdlFkz2SpmMt+AboDdJEB9vHmwN1MCKQWGT2bJjPyMP8JRuiA0T1EGQJ+JErHzRNdGUK+suckhZkWDisMUjHTUim602i+vEG50RUv9d6xmNcj75OE0fmxtghtAQwZD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229348; c=relaxed/simple;
	bh=a/ZO1lSBIKe/G4XEwpv5qSlhJSYeuazlBFOqiXEjlLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cx5oz3EByAy4UvTDDTQuoUyRc4JINGTFiaMxK57L2nwbNqVCLFIcj6Sn4rFWoKEGr+Ix8+iIgLs8opwoy5rvwg3VgKx4DaYOcRWMToEg6xYohzsL7f7GAb7+xovZft1Jrqiokv2wOeh2QugFyZF9slR3RZNjNL266sAQciBRO8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BJUtpPFq; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e05d41828aso331718b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 06:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707229345; x=1707834145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Omntykkn9bEUOrKw198xOVlbqlgc0dP4ZEJ9JLlKKos=;
        b=BJUtpPFqc4UMmPvlO/qYlO98BucOMxePYukiA99KQSsw35jV9Hp8lF4ohEEaxw8VMB
         p55IkMtU2HSni14GJwI/ftAE4wUJKNdkPqKzFECfEwGJnq30P0PksquIlDQNp6r1D8uR
         /ELRAlLUEZB4IEFxbZ0ldaHBb8HjAY9PnU7uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229345; x=1707834145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Omntykkn9bEUOrKw198xOVlbqlgc0dP4ZEJ9JLlKKos=;
        b=YFSvemoZJXJ4a9oR+PMHsug7U5FTM6f8lnkUDL2O92pkVWagpVWNLnWdKzUt5csCgy
         We3kyEoUAAFhpSuKlr8U64f0L5E10c3ny4/5fYdjBnL8/wE3aRNvg6GusnlMMlYR1+mu
         ZXsNN38668tX8pyWESLj9i+IUJHrZOC5ABvy7hMpQNKLrhsGeRtyR320U1PKFoHhklmp
         1UHNDTccYXFcGEnmMjVMqtS0oUdkvjWHPKyhs+yVvSo/EtjNUCYVrR2Fxiy9PPz+PVfN
         qBprqWhMJ+0uMycNibp7I1bLw/+uY09z/xoHUJwfoOMWgUA6QmgQxglvKv78YdD6YVp3
         BxrQ==
X-Gm-Message-State: AOJu0Yx9j+poF9UThi0ggs9WDv8H3kfBCITze4t/mlhlOdOToZMOtI14
	zFYRMLktpSvDsI6qgy0r6lKu917srGT2yWQjaKgun+eblX7ft/Ht9x/VnoDX7g==
X-Google-Smtp-Source: AGHT+IHag8lKGOMv9bwn5PrdT4Az+ZHWyjK4bMazAVMGHh5nROO7IODg6iamTv1j2rYofXf49MHcjw==
X-Received: by 2002:a05:6a20:d90a:b0:19c:ad6b:e1c2 with SMTP id jd10-20020a056a20d90a00b0019cad6be1c2mr1789596pzb.12.1707229344720;
        Tue, 06 Feb 2024 06:22:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVkFa2eznuvH9ox7ho8IHbgQ2AjWbNHGc5Y7bK8DfaXyBVX9TTKwPIKXvYEIVFHpyhlamW7hKwVZDN+eawMuhME8k9UBiO/UsD8VoAHrHkwaXq4sx9IxuyRxqP3Sdu3HL5fY6ozbf1bvYrrG185gyT+vvw6GaZQfedx0nqPYeEOGr3AXiKg4kFba+1/CH4rpU0Sec6pbiADQTCRI6lfT1r/jq8lNe/VIzmqNkdDeGNIhf99+sCL7Drog3ESJuN56uDL7KiNH14bZMNJ/oxAhHK+g0qVWBE46H1nmOLj15boFbwLywnFAfmqrm2kC58YxT+gAS0mRquTYdtvpzbBQfWwoe/7gwUGiOcDmXU9hgV+0BKwPeBp+iIiMfPNzE6wGRNWwgG6JD+Q4FMj4HcQvcRIvsuFUf9jrSLmoYJ3p9gw496DJjuxvX2g1EJoHdf3/+JuxnvHgcWSD9/zbaoQ7emG
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o5-20020a63e345000000b005bd980cca56sm2185593pgj.29.2024.02.06.06.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:22:21 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH v3 2/4] string: Allow 2-argument strscpy()
Date: Tue,  6 Feb 2024 06:22:17 -0800
Message-Id: <20240206142221.2208763-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206142027.make.107-kees@kernel.org>
References: <20240206142027.make.107-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6328; i=keescook@chromium.org;
 h=from:subject; bh=a/ZO1lSBIKe/G4XEwpv5qSlhJSYeuazlBFOqiXEjlLw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwkCbtzgJLlfVxVgPKedChizZ0HI78tjkCrJ8U
 uoXfJpRTQaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcJAmwAKCRCJcvTf3G3A
 JipmEAC0raBrD5LoCWM8LxAB6MySIUEYaaex89+G8Wpar9TyuWzpUyBANr0d8ua6jp9tKzFe5ad
 DSlFAGyaw3fcZ1rHXqtzDjVUWgTRtd0YEcQ9uU2/jn43DUFjgCovmggJPYnT1tdDPnlQqZG413C
 lduNGIf42Bv8SVrJkgYqN38EGxHB+e6AbmiE8PvkdZkxxt++TEL/YIha2M4U8YIDjHWHmIYBqom
 bh91Ymj+vNVGB4aqIBE20TTQEnayorwIBSZ+iFT8v0/+egzLlhIv0wFx2/cZLnh24uX2pen4HEb
 SVUZrWuDc49dhRJQdaudgn7V6LECljo48cYqxdEpDYNjwPeFzqla6mr2P/VpZClmrqor464R0Cc
 B4PEgYTaDfZtEuzOHESVj6XBKzXvDg56ABA7IAd3EzrIWfhGKCh0D/C5Md+KdH3Se4sKPSGaL9k
 4jK7XBnba4U56RivyyHgm5O2MuqkL2dyb+Y76pvUey05cwRmm0RSXd/UwCyVxfE8u321RBXU/Go
 zMfSL48LiXmGEaImil8yO0dmNFhcISbWtaj9HZf/8YcnmTo3ivzUWOPSqQfWCU8HbAOqbOHbdC6
 TASSlwBs3gVDXbWxcmBqSyI++0P0n4b9oVWJ+kSMIXy0Fn2trrpJWGVcrsmOvGzBRDpEFDgHXv6 4wK12/YjUfoXK+g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Using sizeof(dst) for the "size" argument in strscpy() is the
overwhelmingly common case. Instead of requiring this everywhere, allow a
2-argument version to be used that will use the sizeof() internally. There
are other functions in the kernel with optional arguments[1], so this
isn't unprecedented, and improves readability. Update and relocate the
kern-doc for strscpy() too.

Adjust ARCH=um build to notice the changed export name, as it doesn't
do full header includes for the string helpers.

This could additionally let us save a few hundred lines of code:
 1177 files changed, 2455 insertions(+), 3026 deletions(-)
with a treewide cleanup using Coccinelle:

@needless_arg@
expression DST, SRC;
@@

        strscpy(DST, SRC
-, sizeof(DST)
        )

Link: https://elixir.bootlin.com/linux/v6.7/source/include/linux/pci.h#L1517 [1]
Reviewed-by: Justin Stitt <justinstitt@google.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/um/include/shared/user.h  |  3 ++-
 include/linux/fortify-string.h | 22 ++-------------------
 include/linux/string.h         | 36 +++++++++++++++++++++++++++++++++-
 lib/string.c                   |  4 ++--
 4 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
index 981e11d8e025..9568cc04cbb7 100644
--- a/arch/um/include/shared/user.h
+++ b/arch/um/include/shared/user.h
@@ -51,7 +51,8 @@ static inline int printk(const char *fmt, ...)
 
 extern int in_aton(char *str);
 extern size_t strlcat(char *, const char *, size_t);
-extern size_t strscpy(char *, const char *, size_t);
+extern size_t sized_strscpy(char *, const char *, size_t);
+#define strscpy(dst, src, size)	sized_strscpy(dst, src, size)
 
 /* Copied from linux/compiler-gcc.h since we can't include it directly */
 #define barrier() __asm__ __volatile__("": : :"memory")
diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 89a6888f2f9e..06b3aaa63724 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -215,26 +215,8 @@ __kernel_size_t __fortify_strlen(const char * const POS p)
 }
 
 /* Defined after fortified strnlen() to reuse it. */
-extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
-/**
- * strscpy - Copy a C-string into a sized buffer
- *
- * @p: Where to copy the string to
- * @q: Where to copy the string from
- * @size: Size of destination buffer
- *
- * Copy the source string @q, or as much of it as fits, into the destination
- * @p buffer. The behavior is undefined if the string buffers overlap. The
- * destination @p buffer is always NUL terminated, unless it's zero-sized.
- *
- * Preferred to strncpy() since it always returns a valid string, and
- * doesn't unnecessarily force the tail of the destination buffer to be
- * zero padded. If padding is desired please use strscpy_pad().
- *
- * Returns the number of characters copied in @p (not including the
- * trailing %NUL) or -E2BIG if @size is 0 or the copy of @q was truncated.
- */
-__FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, size_t size)
+extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(sized_strscpy);
+__FORTIFY_INLINE ssize_t sized_strscpy(char * const POS p, const char * const POS q, size_t size)
 {
 	/* Use string size rather than possible enclosing struct size. */
 	const size_t p_size = __member_size(p);
diff --git a/include/linux/string.h b/include/linux/string.h
index 03f59cf7fe72..79b875de615e 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_STRING_H_
 #define _LINUX_STRING_H_
 
+#include <linux/args.h>
 #include <linux/array_size.h>
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
@@ -67,9 +68,42 @@ extern char * strcpy(char *,const char *);
 extern char * strncpy(char *,const char *, __kernel_size_t);
 #endif
 #ifndef __HAVE_ARCH_STRSCPY
-ssize_t strscpy(char *, const char *, size_t);
+ssize_t sized_strscpy(char *, const char *, size_t);
 #endif
 
+/*
+ * The 2 argument style can only be used when dst is an array with a
+ * known size.
+ */
+#define __strscpy0(dst, src, ...)	\
+	sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst))
+#define __strscpy1(dst, src, size)	sized_strscpy(dst, src, size)
+
+/**
+ * strscpy - Copy a C-string into a sized buffer
+ * @dst: Where to copy the string to
+ * @src: Where to copy the string from
+ * @...: Size of destination buffer (optional)
+ *
+ * Copy the source string @src, or as much of it as fits, into the
+ * destination @dst buffer. The behavior is undefined if the string
+ * buffers overlap. The destination @dst buffer is always NUL terminated,
+ * unless it's zero-sized.
+ *
+ * The size argument @... is only required when @dst is not an array, or
+ * when the copy needs to be smaller than sizeof(@dst).
+ *
+ * Preferred to strncpy() since it always returns a valid string, and
+ * doesn't unnecessarily force the tail of the destination buffer to be
+ * zero padded. If padding is desired please use strscpy_pad().
+ *
+ * Returns the number of characters copied in @dst (not including the
+ * trailing %NUL) or -E2BIG if @size is 0 or the copy from @src was
+ * truncated.
+ */
+#define strscpy(dst, src, ...)	\
+	CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
+
 /**
  * strscpy_pad() - Copy a C-string into a sized buffer
  * @dest: Where to copy the string to
diff --git a/lib/string.c b/lib/string.c
index 6891d15ce991..2869895a1180 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -104,7 +104,7 @@ EXPORT_SYMBOL(strncpy);
 #endif
 
 #ifndef __HAVE_ARCH_STRSCPY
-ssize_t strscpy(char *dest, const char *src, size_t count)
+ssize_t sized_strscpy(char *dest, const char *src, size_t count)
 {
 	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
 	size_t max = count;
@@ -170,7 +170,7 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
 
 	return -E2BIG;
 }
-EXPORT_SYMBOL(strscpy);
+EXPORT_SYMBOL(sized_strscpy);
 #endif
 
 /**
-- 
2.34.1


