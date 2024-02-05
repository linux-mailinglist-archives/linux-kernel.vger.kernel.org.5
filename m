Return-Path: <linux-kernel+bounces-52617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E34849A73
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE9328113D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902C422F0E;
	Mon,  5 Feb 2024 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="htpe0+ww"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB141CA8D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136531; cv=none; b=tB2/QeFsjKF6Ao1A3SsI+8BRPEpaF7EBjrF6cZ0hZOTlFGTKcwxLjT8LdOebg+Q1ezODagwTzfpoabvxxkDn4nwjtV1KCGXWmppaqzf0hBr0XwqvI1R4bFOsrd8Z6I6mHbXcSQ3WKeabnCZtD6v9jz4NEsBKqtyNtEinRJgzwD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136531; c=relaxed/simple;
	bh=mJaVHVptIigPFzZ/zR9JERbMLBqYYNcKpf70/6AE0qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D+hTb/0n1XoiGggAH8IBKB5JTxlehMTv1+bify4beOpXfK6JVjakI62IrU8jl1SSMocLN8Dcnsp8rDdZT+6TSLq5GPuhW/rxR1e1AmqasKGOQgPDJHY4TGI6vct7/5GqLI1gP4nXJRBj0pHaSW/qQFdx87EXWZJ+SBb3ugp8VZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=htpe0+ww; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d74045c463so33461385ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707136529; x=1707741329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBM9WxTj4Xh4iFKbJAS9nYsTd9tTRHElbt7v/kERb54=;
        b=htpe0+wwzmD3Td7ZdFLPmXsoewp9HjDWEK0jFxt7Xy15b1u9y1nRwuRPXCMMwC2TEs
         IapY5DBQ4lE6Gsy8lsej9UbOJTCWI8K5MLxVvyd6fMa50ph8yEd13AqA/umdQ4kus4E2
         FAs7JYyM1A/HukuB+s5oe1NOt/6Wit1Sjaksk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707136529; x=1707741329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBM9WxTj4Xh4iFKbJAS9nYsTd9tTRHElbt7v/kERb54=;
        b=Nqzsm2uanzSjCn6Xsmj/0ggILqs88lhcmSNy6BNB4+OlAygyil6e/5dSDTrCl5u+M4
         0enjdGVPi4QIVjMZf+5tbvoPzx4rndPffaRUl6YThDF+9VXpLoAHl04tmqmQdyUmE0Gv
         yRF2c+fE4+WPwcKWPXJSwXNEYNcB9kFAVIrhk16MJffrC+BZCZLUqUTPuiBfkhZdQ9Sf
         vZU87cH/6VNCT5XmpztvEdd1kQzMH7hutn/n7Kvdzadj89l6ymoFENZ6/BAdkb/W81xD
         6yURuWvDfWgKu/yfT7u5e9/xREjoX7cgG5ugZBDVdmwRjppkVuDohvNcNugm5A+byPd/
         dtHw==
X-Gm-Message-State: AOJu0YzMHcdaE0dOCAh1m7IluL/+AxQv1a+NOOeAApobOWDh6nZBqXRu
	FSTXxjPS8NIUeCH2LiOpDR4ZILGHWqCRdWNU8mpmfHnvLyyFAmZ0Km+Rxz0o7Q==
X-Google-Smtp-Source: AGHT+IFTTqqrWRJgFFkuhIFSdxjlp5gIlB3CMmmYW9dZei/xGuN95raXdDCg689tZTBtii8Fqz2Myw==
X-Received: by 2002:a17:903:22cd:b0:1d9:4d3f:cbf6 with SMTP id y13-20020a17090322cd00b001d94d3fcbf6mr10142104plg.48.1707136529264;
        Mon, 05 Feb 2024 04:35:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUEpbF+H7yLOzWQv3G1vKnFCs8F/5pEM6MLM7TrUj9SdzHZsyLibhM5xXVRRyDcejgeQiWnpb8oJnfnXihVhQW2C798wt69vVsErM1ODCVO9CidizGakcPoqklr/hbJT5aEqQLPiBy8xxlAZNBcDUDfzc0s3Pfr1Voeq2FEdi4diDaOMNaUkXS+L3GIfnkmJCCIIzzieh1FnIT+dKhDrR3tqjz0QS3fq4n5tVEJtag7FX/Sfl3Q4e8gJlXFzkSQfpCrDmfw1HHCwJe3wT/nQAHqHvq8euSoxQ2CFSIO8u/QcDZsTJvA/HZmQvl+B2LkQ6Ofh6Zd8MwUXbERl5/oxxJLIHe5H7DxrOHUYspbu6FIjz8kpQsjH1Hmazh1HGtwXwN3B1fXigaPI6/nIYz41yL3pZ1tfclMwv2lhAQj723qoZKcTsmAGgqXlvKYDS7ehwWPssK5Ha35kfr7EANSZyN8
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iy5-20020a170903130500b001d944e8f0fdsm6204478plb.32.2024.02.05.04.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:35:26 -0800 (PST)
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
Subject: [PATCH v2 2/4] string: Allow 2-argument strscpy()
Date: Mon,  5 Feb 2024 04:35:22 -0800
Message-Id: <20240205123525.1379299-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205122916.it.909-kees@kernel.org>
References: <20240205122916.it.909-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6105; i=keescook@chromium.org;
 h=from:subject; bh=mJaVHVptIigPFzZ/zR9JERbMLBqYYNcKpf70/6AE0qw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwNYLWD0Xozo5J+xTTvfw+MfKqBkxQCUARxBeI
 UMtcoHx5rmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcDWCwAKCRCJcvTf3G3A
 JtCJD/4hwxxn2am+sHHbObqVTYQbb4y+Jpm7wgzrqcFhv4UmfzqMvuqRRqoxDHzkJsp1hacbVTJ
 K6hWg4adcpeNJMYH4H1Xt+YxwDSMUPO+6BDZo3zQZBXI088Sa/2uw52X5hUPd5dC0S2erW8Z9nh
 +6XajX+dBTtbFwYc1D7NhWxp5gplKA2PfhmX1mE6JecX79snifY2o+UN5MNw9u/ar2U6AzIdiaH
 FvSCjNAVhyNZmbkSdMV5qtiscZ6iXAbFmAtkaYYOthNgTmG9JPJGYqkoW43tKeVp+66jx7eylHy
 2GChRBCMIlIUK/8zXwevu4wRzpXfVVVeLQlRj/B2G60XFIFt7kpWjZ1dPCDtXqbK4L3b9ZmF22F
 zgvbGcoG35MgHtijYSTg2K+6noY77qzG8OXVGYY6vE8V1sukn+PG6DV/rBCSxRuysrWi/RjwroS
 T02QCvY4jfm5ucmnz8tFBRfo1uaBzqSaBkKYdbS2mZo4u34kJrsBf4r2YI2Ab2yWkLFGPoWbJzz
 zujgvMOu4Y5t5ZoBK5QYH3X1SARTmWRJVERp8KUnUq4OHfPRMc2l0IqJXX/e1myzDyZzKeDbMh4
 JSujIp/sfCzqdgCpxSvSn/z4eiFlJg0f6h92lMxovebpoLXQgUHfMfkjr/XYJP9t92yCCR/KoLL cfiYj2mSD9fbCcA==
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
 include/linux/string.h         | 35 +++++++++++++++++++++++++++++++++-
 lib/string.c                   |  4 ++--
 4 files changed, 40 insertions(+), 24 deletions(-)

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
index 03f59cf7fe72..a21371aa2fd6 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -67,9 +67,42 @@ extern char * strcpy(char *,const char *);
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


