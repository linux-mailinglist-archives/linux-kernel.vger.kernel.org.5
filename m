Return-Path: <linux-kernel+bounces-30603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48921832198
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C281B1F23376
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22DF28E13;
	Thu, 18 Jan 2024 22:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IM23bUrS"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6EE28E03
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 22:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705617192; cv=none; b=kXD71sgl+aJ4Yhk/kWb0n9ql/+U30zcqSfo9V3NGxHH5YbLpYPAqZ1Q908LWx83PX1ZmN59JBElbjwDVMKAYZWoLnpJ9nr5jZ+K6Ua7gLciONJFgJg8IW/FjkfQjM6ivpVMQtiBdIjBsYnVV8g6oPuCNNWnRQQo7GnNtcdpKmVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705617192; c=relaxed/simple;
	bh=crANgfQt67bGX2lxqY7x3JZCkqhUlYce7AWKQIf+OAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=razwz79NNPKdzQh3OmZ2MmYVUT44EV0LoYdvgQM0LQtBjvIk8XPMWBvO5zXDS8KmYUiSkikrJJXi/AErFE5nKt9Raen+Roze9c6sH1j4NJi7ehKxHR7M6dRKsbzLeVaIAPCM822bsyQ6loLEZL88D5npgAiVH31ZgWSsuzIOmEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IM23bUrS; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cf6d5117f9so129937a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 14:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705617190; x=1706221990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NS+NewJEOQ6x/xZM39Is+rJ8SCHFd5oF3nIVMv043cc=;
        b=IM23bUrSRp1/2aztcmL4SR6eGkGzXHcoV77BHo2EvAHuPWFVyLzmWryqGoBNdvAOrn
         kdj3XLx92ODZO5GxzD54XaBF/A+ddZPEuQGqV2jRDUEnzLQTJdVTo4ODF4qY2iggawxM
         y///KVNSGaRvXmmDAthtakJKsYaKoF2N2dJRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705617190; x=1706221990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NS+NewJEOQ6x/xZM39Is+rJ8SCHFd5oF3nIVMv043cc=;
        b=Na2RPOS4LBCfc0sPiKLx5c9mLMR6mSMVlk2oHmjHzSPQ0au2+v5ijP3T8apgMr1vp4
         Gp/+egd6rHe7FHFhG498K/5K6mheQy51Yb1pgllrMR+ShWXlHgxvF0Qpl/nRNLMfMM3N
         jjbKo6s+oKCAjRr+WAZPJeykXRmjgIdKqy6cDKlNxE5s6E/EG7LgnH+f4xLgRE9bu/PR
         kOx4bB6QcSI4kvvdsUsagD3j6+OtK+ar86WNESgTGk4yzmPuNQFEIZ+fqkY926p03/gl
         3h9i0D4gd45lU7/KacLjPpYlTdaQTuKxSmnrJI5fcALg6T+lad04kGc2sk1DGzWEV6DP
         6fEg==
X-Gm-Message-State: AOJu0Yxc6viQLoYXVrN+EUNLSr4sOBNhj+qfDXPIJuPw2J05qth1tI1G
	U1kc1L2t7cIJCOkbEj0g43cMcX+8L0ANA1Imlswq5wq6b/qtgeDtyOjD1Zf3aQ==
X-Google-Smtp-Source: AGHT+IHXejpOwb3JifOKuaLHIBn7yidGlTNA8jXFev5ToxY130E6KCDlTQ+dhfwRowMRsbBUUakuQg==
X-Received: by 2002:a17:90a:1341:b0:28f:faa6:c6eb with SMTP id y1-20020a17090a134100b0028ffaa6c6ebmr1281655pjf.17.1705617189944;
        Thu, 18 Jan 2024 14:33:09 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sn8-20020a17090b2e8800b0028afdb88d08sm2410524pjb.23.2024.01.18.14.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 14:33:09 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] string: Remove strlcpy()
Date: Thu, 18 Jan 2024 14:33:05 -0800
Message-Id: <20240118223301.work.079-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6755; i=keescook@chromium.org;
 h=from:subject:message-id; bh=crANgfQt67bGX2lxqY7x3JZCkqhUlYce7AWKQIf+OAM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlqachcMCXxul2mhPAlA0aWlVXhKWpsrCdv0bu8
 3fqeMgzikGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZamnIQAKCRCJcvTf3G3A
 JtemD/48vMjc6VzB011m8v5Uk/7IrtP+JDTQIRQnO5iTVzeWriCeAfC3sZiqRdt7nXWs4KrBdsN
 0Z6OkXPfQdcGUlb77fAY7Xlt8fZBkq3tnEH7S2pxjOEZ6T+NjLhLsp2locPc4AavQ3CZ65q1uHu
 J2XhoLYMY408Yr+Gf5Qlz1KCo4qAUuTeEOuDDjkgJuuPjFesaVxZfKtYIOGk4TpckU5WN/F4JN2
 P1q2nmBhPdTuFLSVbUtoONZ7jmBTMgtCAYhDE4y//I4QsUJA4bQQQAhwOPRKnNJOKzr9uPtZqv3
 yFS3eAPAR49p2R5uuY8neUPQlkmuHIuv7m8tWxO97McyrhO3bPTv2kICkzbhoJaGuFKO5iDv8tU
 ipLlUstpMqN+6JmayeINx9yRPWGKnfXpQnwfuEi6409OYzXoQqv8fMvue5UU/XGaCU7uZekmONl
 FO4YNRBr6OtbnIzI4Qsw28KjDkmE5HqL8AUkbfcoQN5U6P9YRsgoyjxu3PBpNQT+WEMBe2axhZU
 h5QHBr7OzL1taYywrWxrAjkyZzDeUWapDr1RRdaJ+0gp5S4teQhZVkBwVeh3KOG0/kKzox8Fvvo
 NtNv/mjJZ3qPIlGfqQ+YlodLIoWd3vJtunN0ZpcutmO+rGDY3/5KoKWzhEbvpJMk1YSrsigr7Ow
 ApElw/M fgYkMomg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

With all the users of strlcpy() removed[1] from the kernel, remove the
API, self-tests, and other references. Leave mentions in Documentation
(about its deprecation), and in checkpatch.pl (to help migrate host-only
tools/ usage). Long live strscpy().

Link: https://github.com/KSPP/linux/issues/89 [1]
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This is on top of Linus's tree with:
https://lore.kernel.org/all/20240110235438.work.385-kees@kernel.org/
I'll send this as a PR to Linus shortly now that the tree is strlcpy()-free...
---
 include/linux/fortify-string.h                | 51 -------------------
 include/linux/string.h                        |  3 --
 lib/nlattr.c                                  |  2 +-
 lib/string.c                                  | 15 ------
 lib/test_fortify/write_overflow-strlcpy-src.c |  5 --
 lib/test_fortify/write_overflow-strlcpy.c     |  5 --
 6 files changed, 1 insertion(+), 80 deletions(-)
 delete mode 100644 lib/test_fortify/write_overflow-strlcpy-src.c
 delete mode 100644 lib/test_fortify/write_overflow-strlcpy.c

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 79ef6ac4c021..89a6888f2f9e 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -214,51 +214,6 @@ __kernel_size_t __fortify_strlen(const char * const POS p)
 	return ret;
 }
 
-/* Defined after fortified strlen() to reuse it. */
-extern size_t __real_strlcpy(char *, const char *, size_t) __RENAME(strlcpy);
-/**
- * strlcpy - Copy a string into another string buffer
- *
- * @p: pointer to destination of copy
- * @q: pointer to NUL-terminated source string to copy
- * @size: maximum number of bytes to write at @p
- *
- * If strlen(@q) >= @size, the copy of @q will be truncated at
- * @size - 1 bytes. @p will always be NUL-terminated.
- *
- * Do not use this function. While FORTIFY_SOURCE tries to avoid
- * over-reads when calculating strlen(@q), it is still possible.
- * Prefer strscpy(), though note its different return values for
- * detecting truncation.
- *
- * Returns total number of bytes written to @p, including terminating NUL.
- *
- */
-__FORTIFY_INLINE size_t strlcpy(char * const POS p, const char * const POS q, size_t size)
-{
-	const size_t p_size = __member_size(p);
-	const size_t q_size = __member_size(q);
-	size_t q_len;	/* Full count of source string length. */
-	size_t len;	/* Count of characters going into destination. */
-
-	if (p_size == SIZE_MAX && q_size == SIZE_MAX)
-		return __real_strlcpy(p, q, size);
-	q_len = strlen(q);
-	len = (q_len >= size) ? size - 1 : q_len;
-	if (__builtin_constant_p(size) && __builtin_constant_p(q_len) && size) {
-		/* Write size is always larger than destination. */
-		if (len >= p_size)
-			__write_overflow();
-	}
-	if (size) {
-		if (len >= p_size)
-			fortify_panic(__func__);
-		__underlying_memcpy(p, q, len);
-		p[len] = '\0';
-	}
-	return q_len;
-}
-
 /* Defined after fortified strnlen() to reuse it. */
 extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
 /**
@@ -272,12 +227,6 @@ extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
  * @p buffer. The behavior is undefined if the string buffers overlap. The
  * destination @p buffer is always NUL terminated, unless it's zero-sized.
  *
- * Preferred to strlcpy() since the API doesn't require reading memory
- * from the source @q string beyond the specified @size bytes, and since
- * the return value is easier to error-check than strlcpy()'s.
- * In addition, the implementation is robust to the string changing out
- * from underneath it, unlike the current strlcpy() implementation.
- *
  * Preferred to strncpy() since it always returns a valid string, and
  * doesn't unnecessarily force the tail of the destination buffer to be
  * zero padded. If padding is desired please use strscpy_pad().
diff --git a/include/linux/string.h b/include/linux/string.h
index ce137830a0b9..ab148d8dbfc1 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -66,9 +66,6 @@ extern char * strcpy(char *,const char *);
 #ifndef __HAVE_ARCH_STRNCPY
 extern char * strncpy(char *,const char *, __kernel_size_t);
 #endif
-#ifndef __HAVE_ARCH_STRLCPY
-size_t strlcpy(char *, const char *, size_t);
-#endif
 #ifndef __HAVE_ARCH_STRSCPY
 ssize_t strscpy(char *, const char *, size_t);
 #endif
diff --git a/lib/nlattr.c b/lib/nlattr.c
index dc15e7888fc1..07c4cc8c8d79 100644
--- a/lib/nlattr.c
+++ b/lib/nlattr.c
@@ -758,7 +758,7 @@ EXPORT_SYMBOL(nla_find);
  * @dstsize: Size of destination buffer.
  *
  * Copies at most dstsize - 1 bytes into the destination buffer.
- * Unlike strlcpy the destination buffer is always padded out.
+ * Unlike strscpy the destination buffer is always padded out.
  *
  * Return:
  * * srclen - Returns @nla length (not including the trailing %NUL).
diff --git a/lib/string.c b/lib/string.c
index be26623953d2..6891d15ce991 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -103,21 +103,6 @@ char *strncpy(char *dest, const char *src, size_t count)
 EXPORT_SYMBOL(strncpy);
 #endif
 
-#ifndef __HAVE_ARCH_STRLCPY
-size_t strlcpy(char *dest, const char *src, size_t size)
-{
-	size_t ret = strlen(src);
-
-	if (size) {
-		size_t len = (ret >= size) ? size - 1 : ret;
-		__builtin_memcpy(dest, src, len);
-		dest[len] = '\0';
-	}
-	return ret;
-}
-EXPORT_SYMBOL(strlcpy);
-#endif
-
 #ifndef __HAVE_ARCH_STRSCPY
 ssize_t strscpy(char *dest, const char *src, size_t count)
 {
diff --git a/lib/test_fortify/write_overflow-strlcpy-src.c b/lib/test_fortify/write_overflow-strlcpy-src.c
deleted file mode 100644
index 91bf83ebd34a..000000000000
--- a/lib/test_fortify/write_overflow-strlcpy-src.c
+++ /dev/null
@@ -1,5 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-#define TEST	\
-	strlcpy(small, large_src, sizeof(small) + 1)
-
-#include "test_fortify.h"
diff --git a/lib/test_fortify/write_overflow-strlcpy.c b/lib/test_fortify/write_overflow-strlcpy.c
deleted file mode 100644
index 1883db7c0cd6..000000000000
--- a/lib/test_fortify/write_overflow-strlcpy.c
+++ /dev/null
@@ -1,5 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-#define TEST	\
-	strlcpy(instance.buf, large_src, sizeof(instance.buf) + 1)
-
-#include "test_fortify.h"
-- 
2.34.1


