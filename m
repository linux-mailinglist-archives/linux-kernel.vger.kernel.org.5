Return-Path: <linux-kernel+bounces-43467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFC6841445
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774901F22F13
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28FE152E04;
	Mon, 29 Jan 2024 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SQK3wD0T"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3047605A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 20:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560153; cv=none; b=SUIhbMGnxRwWHpo9VsYjVlNvI8zR3wfjhTPaUO3biBigUk21ydPWMvAmwbcJtGoQDQjSjQSrisWC3RrCsdIqpeY8Sd7OdPlSANMdkb3ukQW3GWU8CLcqydcEbsstQaBOXNs8RXDZaXsbAk73WvcFuwT8390nv1akFbBSnyWU5Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560153; c=relaxed/simple;
	bh=tXy4xQ2kacaBozMPbfsCpwvJ6haeLTL5rU9zhmjNRhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GOQe2csySEpqHf8LU1tY7lvqlMlqm4hBAmeBlVI34RQ9jhxHKjV9o+13K5zHG25Fsgd6nglwnSbWcaXJxgu4pz1aHf8DziPUjIzb/H+W1HMQ8bYpNOvUGjtoT5ezslzVRQoF7ujhSFSucNSe6TUh593grPfWz3QGX9YK45mefDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SQK3wD0T; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e1352dd653so484953a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706560150; x=1707164950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NAmaslHwzSDAfTrzdx10Kky4yB8faOBeb7X7c1JV820=;
        b=SQK3wD0TYh/dmlGPm81OMv1ZDRopgMzXpng8G4e4ckFMi7K/o7xvq/VilnFWTSjY0c
         7cSTyFGRVX2wjVpyKkZCJfw7TT0dipYY3c9UTgIx1qQmb0jOgF0PdiAz4dwuR2mv94qM
         5t5FvRUVwi1bFFIdEetUctBBwSytGW/+JBo4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706560150; x=1707164950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAmaslHwzSDAfTrzdx10Kky4yB8faOBeb7X7c1JV820=;
        b=fU4E/bsbPQLoumOSEWW0mSmAR/loqR5Ti8aySteYrGz3kopGx1FL4gJRsmpJ4bEDkc
         T9WcvJ61N/vmcii1/FYABoAerQPaYMyXy+7HDfb3ybFHATMaVo6/YOCP6Z+xuSocdbV/
         PoTDG/4F2RlBrGxbBv+id2CQddCXgbdeoPxorxakpdlUfYI5StLpBa/H6bFDM0erQqTD
         8i0vFZJg9PF+Sk/0ZktTyyRivNR7T853+jeg03RB8jWJWNP6wD8OJvqZMMUBIG6nS2xU
         RY4IXdYQEe7D5h6aUfFm9aRP6Vw7KFmqFPJ2zO2WMpbrhheQ552/5dKL5Mb51TZToVSc
         pOcg==
X-Gm-Message-State: AOJu0YxHFUrmKWbZ0lzNzW50auWZ0tJ5Wo2FmXx15BopnNnVEyjjRL8e
	dHIh0O1zv1LjqlAuW4Vc70AhYLFwz1jYZLDQD+XCPGeNDgPs+0sYo2oc6lNw0oB9xHdYFfXR7v0
	=
X-Google-Smtp-Source: AGHT+IGBV7PI3DksPECDDGdtUCxoJJV95ddL5HiaF24j8VZ2IZnzCXajijC6v/GeaFVMOtk9V6Oilg==
X-Received: by 2002:a05:6359:459c:b0:176:5c72:8e6b with SMTP id no28-20020a056359459c00b001765c728e6bmr4764001rwb.0.1706560150083;
        Mon, 29 Jan 2024 12:29:10 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ka13-20020a056a00938d00b006da73b90fe4sm6486393pfb.14.2024.01.29.12.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 12:29:09 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC] string: Allow 2-argument strscpy()
Date: Mon, 29 Jan 2024 12:29:04 -0800
Message-Id: <20240129202901.work.282-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3384; i=keescook@chromium.org;
 h=from:subject:message-id; bh=tXy4xQ2kacaBozMPbfsCpwvJ6haeLTL5rU9zhmjNRhw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBluAqQjb/yEaEffuTpus0VYworpNQ2/qAcr663e
 hxOXJPsTGCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbgKkAAKCRCJcvTf3G3A
 JoMBD/97fRjBYcKsgjVB+5kZoBDBwn/Qkmsz26xpgAkAcRvKEunPlBPgoAHuj7D0h44dpc1y1Tu
 QDRaM8+ranKSunfp38P4bFrh+tQZ7XBoCzDDn/GyYW+20edRO+w9AzDRK/SJLwwaLQNTQXZgbyT
 fcYYuBJ+D7w9u50IV3GS7VwcI4sGCfe13F3Ld70zmGE1pkOoydrnCHx/MKMQPBHkE937BXrb1gj
 4zNko2F7thdJQMjQ5szeNjNm++whmDIKOFH50IW7ua7/O7tq1TYVCOYj+VVAiBIZrK/Ssj7d+Gr
 lv1hny4mVotCA+jAe3mbLoJI9eE+Qh7u9VPrMPE89BejJOgMoaZ3AWb8hH3C4VAbsFGjG1crORx
 3vDiipoqtO3lA84pRUSBbPGzp8Jr/1X56+n42vvrW6BXbOa55rukH+rg9hy4hyPYKN8GaQhACXW
 AM9d8wfV9AeI4kIbkLrs309vLqUU0EfIe0HQSzPCV/77EzTCLdcRoMgrRoJTYipigMmQJsYqkp+
 7L3OQvomXjcdX+MWy9hXGSRGoBEAeaH+Y5oWLPc1K8c4iO/vTJLuua+up01bc56eQQcOgRtcG8L
 WT1X+DG3rBzJmx/XauaaYDx30PmedeFvZSpI+Hbv0aqDJpmzsmX0Xe+w1yR45C/gpRxtJqLL9hT
 yUbMbZ4 bhORMvZA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Using sizeof(dst) is the overwhelmingly common case for strscpy().
Instead of requiring this everywhere, allow a 2-argument version to be
used that will use the sizeof() internally.

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
What do people think of this idea? It's usually very redundant to
include the 3rd argument, so this might improve readability (and
perhaps make things more robust by avoiding mistakes when the
destination name changes).
---
 include/linux/fortify-string.h | 4 ++--
 include/linux/string.h         | 9 ++++++++-
 lib/string.c                   | 4 ++--
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 89a6888f2f9e..56be4d4a5dea 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -215,7 +215,7 @@ __kernel_size_t __fortify_strlen(const char * const POS p)
 }
 
 /* Defined after fortified strnlen() to reuse it. */
-extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
+extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(sized_strscpy);
 /**
  * strscpy - Copy a C-string into a sized buffer
  *
@@ -234,7 +234,7 @@ extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
  * Returns the number of characters copied in @p (not including the
  * trailing %NUL) or -E2BIG if @size is 0 or the copy of @q was truncated.
  */
-__FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, size_t size)
+__FORTIFY_INLINE ssize_t sized_strscpy(char * const POS p, const char * const POS q, size_t size)
 {
 	/* Use string size rather than possible enclosing struct size. */
 	const size_t p_size = __member_size(p);
diff --git a/include/linux/string.h b/include/linux/string.h
index ab148d8dbfc1..0bb1c8d05f18 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -67,9 +67,16 @@ extern char * strcpy(char *,const char *);
 extern char * strncpy(char *,const char *, __kernel_size_t);
 #endif
 #ifndef __HAVE_ARCH_STRSCPY
-ssize_t strscpy(char *, const char *, size_t);
+ssize_t sized_strscpy(char *, const char *, size_t);
 #endif
 
+#define __strscpy0(dst, src, ...)	sized_strscpy(dst, src, sizeof(dst))
+
+#define __strscpy1(dst, src, size)	sized_strscpy(dst, src, size)
+
+#define strscpy(dst, src, ...)	\
+	CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
+
 /* Wraps calls to strscpy()/memset(), no arch specific code required */
 ssize_t strscpy_pad(char *dest, const char *src, size_t count);
 
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


