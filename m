Return-Path: <linux-kernel+bounces-52616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB5D849A72
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BE01F20F2B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD00620DC8;
	Mon,  5 Feb 2024 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L4VxypKJ"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632541C6B2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136530; cv=none; b=Gc2u4YbSprJCYfhQQmt3n2MQPlZj9PN3xF9sUiUbsB2DYOEeTXyl1Q+g+T33PPUA1cAi8tXNsed/HhI4IIvpynP+TOhQ3ygPckD1uL+mwDody8dsCSg9iH+soUhYYEEOMij/Ks18gVYFgKlAuJKay3aWL2L95VExTDdUsBP2IH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136530; c=relaxed/simple;
	bh=TEqXeG3EE5r0HJJI2aXfyZ+mDUoPdveS85d+Fo7JBf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LPiV94GvPd1yXB2OK0PealigD8a7pgiYJFV/IEWmsCu9R14DMZ9/5Hc4fxQl04p8yIx+2dEc8GMFI/f2zxaC2hsNEkMl6JoURLYhlXpUU5IUFUC3pqGwIoAwvjZ9rYo1jZuBkyxVVwzD+kZ4c3zD0jHfZdIHQXrMHrWoWyrqOoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L4VxypKJ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e038bdf6b1so738630b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707136528; x=1707741328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FH86lG6MyR7uXWPlPZaZQtj5zclv3S/IDeQNDhD0wsU=;
        b=L4VxypKJ7KRXVpUCrAk89VOHjkk462r/l9kQsHKwYwuuEVGsndX6FCzgGt7B5sA7zA
         xHYna+NdYFR9Nunfiz0FwpyIItLQk9yEhuBhj1ZammQoC1LoykfJzlo9f/rx9mJQZJ+0
         l2yKO0XY/9l96hib65YzYdmMa0NZKlfOnl7P8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707136528; x=1707741328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FH86lG6MyR7uXWPlPZaZQtj5zclv3S/IDeQNDhD0wsU=;
        b=lDYwtaQwkt9zKo6F4dspDaX8PoUeCr4IKeMlbLoLwHDCwqlNqaavB2T1IC69XoB2eu
         oNCtYuSKfkh7j8WIYe/DeHnERYRXpuiIhonTYEyCh6DuhMhOrcrDImKJ2KzP5JbJR0vm
         oosR1HCwvlTcQs5fWvpZGstPsDp5gdpiGXOsqQ+5IlMItUN16ZIRAFbWurJuE6lHo7Be
         l/6ldqX4wpmscSCzJvcYNR3pak9N+Sl76C731TBx31WJGpVeExNi5qEvxRC2+nGpCuQh
         TPGLDF64x75e/L7rIaw7cVR4DzoGcuGp9QpY2DnjLncdE2pcEEft4rFw7BKWzKVtU/fY
         NcAw==
X-Gm-Message-State: AOJu0YwsvpOSBX4l2c51RPaoSUfFVYiDjoH1T0gKgQ53fL3IrmRk0WBZ
	+YjGOjf6piL86/rsYEA2/sXVcL7QjfWrRqp88Yome+ebwyvENB4SklYoj1SVbQ==
X-Google-Smtp-Source: AGHT+IFlfffgYQK5YYez78+IfsArDP07cdit0XksGG6AD/xQaqmTxf1lIWlhL3nllltxLu/AYqTxfA==
X-Received: by 2002:aa7:87d3:0:b0:6e0:4e58:f21b with SMTP id i19-20020aa787d3000000b006e04e58f21bmr761630pfo.15.1707136528648;
        Mon, 05 Feb 2024 04:35:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWwHha8YxvP2aoIRIZZ8PXriiDHebzEwEPdQS1GCiUmNtMp7csrX2Vw+AKCDxmAxF83WOZEXOVnTruJgzWNTBTfEcH8if2KGpE7zm4SbpGoDOFecCGttc6XrjLdg+cwsWTIBGQh5Rag9UuMLglMTn4D74UUHRXvOc9Lgxs2hHtrGRIksJx1ww110fVmUquqOsQMM6L2QFLzpfH8nI0wGJAuw5Xbe4J2yH9Zc/aKfbVbhNvsAMXOxtfmY+qPqxqsh1/x8z6/VrRBthvrmE5xAbFTX0XoD6rJILJyX5/84ez76SejdmlFWiwS/CfnQ+rizfNNf09XD4CkbEEAICIoGTB+wpJtmAlY8zC5RTRIH9/ypAT7vPEwWXPaQZnPL3l/gXTt2ZjvKM/gh6wI2WUCCrkx5DUphblH+z9OfbXszwBmF4xlPjUvePU6T0W/RaCdgw+0iIb4zBpJ7rkGof6jWgeKjfRGG3D9MPokDa17rA8H6FNyR6Z7cIqpEbhw
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j32-20020a632320000000b005cd821a01d4sm6877508pgj.28.2024.02.05.04.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:35:26 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-hardening@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Justin Stitt <justinstitt@google.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH v2 1/4] string: Redefine strscpy_pad() as a macro
Date: Mon,  5 Feb 2024 04:35:21 -0800
Message-Id: <20240205123525.1379299-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205122916.it.909-kees@kernel.org>
References: <20240205122916.it.909-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3873; i=keescook@chromium.org;
 h=from:subject; bh=TEqXeG3EE5r0HJJI2aXfyZ+mDUoPdveS85d+Fo7JBf4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwNYLoPV5NTQ5GwRGCijGU/aLTVRbyEZipneuU
 MRho0SleAeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcDWCwAKCRCJcvTf3G3A
 JjLlD/977C+XMdrLxO0tkJtnq9nO/lyXGwJ3l1LW0AnI2sQrcE8MvllgCnv8jv/II3aTMd2vN9I
 xgwhNpMJ4NRgwd/aQT3EcXg7gegX4oXTTo5Cr44s9gCAMWcNouxVQLVO1OFC83tBUNnkVXxNVnN
 PaATkrRl3yMdrcA2BEP7vtPJ239fB/ZzU0a4wGgIJ/A1+AvNy4L4M2GIYQf0vowoT2g769325Qw
 u0uXMqpFubwmpTBbFKkQPUb/lNkZKSq87HnXXOmTSFyqvZEa5mrXoTl10VCF86rmQyIN1fwj7GL
 QbQVjt9Bou0wk8qUR0pkjoRA4q+z95bzhsx4vftom9CzgugBJzNdo0tzZ/4rM/iRIdwanBfUcvg
 loh2poV/udgDFcMlOiP8J/gM8ty7rRlFIEsc/ZIwTz9qFXFDgQzneRVBfq/pQ5wVAHBHmM3Msts
 hnz3lXsTCSCyJusPtxPVqqwh1wO/3fIxp+SPqjbTzBucFtG2by68KAuQShhC8LtCFqG690T5h2b
 mQIU2FZgmjwEzErgF37A6wSigJ1+eQRblZsMQrMVIZej/ALqfadFztxgiF5Qc4SfC8p8YiWUbPN
 7s/9oP/Imsnzy24+O1UMvEaRTX4bAVV1nMq05nP7DuB9/Jk4AMp/bY24MWR+3XEdB4leJ4KJbVp fhcKDnAmLXTx9Aw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for making strscpy_pad()'s 3rd argument optional, redefine
it as a macro. This also has the benefit of allowing greater FORITFY
introspection, as it couldn't see into the strscpy() nor the memset()
within strscpy_pad().

Cc: Andy Shevchenko <andy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/string.h | 33 +++++++++++++++++++++++++++++++--
 lib/string_helpers.c   | 34 ----------------------------------
 2 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index ab148d8dbfc1..03f59cf7fe72 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -70,8 +70,37 @@ extern char * strncpy(char *,const char *, __kernel_size_t);
 ssize_t strscpy(char *, const char *, size_t);
 #endif
 
-/* Wraps calls to strscpy()/memset(), no arch specific code required */
-ssize_t strscpy_pad(char *dest, const char *src, size_t count);
+/**
+ * strscpy_pad() - Copy a C-string into a sized buffer
+ * @dest: Where to copy the string to
+ * @src: Where to copy the string from
+ * @count: Size of destination buffer
+ *
+ * Copy the string, or as much of it as fits, into the dest buffer. The
+ * behavior is undefined if the string buffers overlap. The destination
+ * buffer is always %NUL terminated, unless it's zero-sized.
+ *
+ * If the source string is shorter than the destination buffer, zeros
+ * the tail of the destination buffer.
+ *
+ * For full explanation of why you may want to consider using the
+ * 'strscpy' functions please see the function docstring for strscpy().
+ *
+ * Returns:
+ * * The number of characters copied (not including the trailing %NULs)
+ * * -E2BIG if count is 0 or @src was truncated.
+ */
+#define strscpy_pad(dest, src, count)	({			\
+	char *__dst = (dest);						\
+	const char *__src = (src);					\
+	const size_t __count = (count);					\
+	ssize_t __wrote;						\
+									\
+	__wrote = strscpy(__dst, __src, __count);			\
+	if (__wrote >= 0 && __wrote < __count)				\
+		memset(__dst + __wrote + 1, 0, __count - __wrote - 1);	\
+	__wrote;							\
+})
 
 #ifndef __HAVE_ARCH_STRCAT
 extern char * strcat(char *, const char *);
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 7713f73e66b0..606c3099013f 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -825,40 +825,6 @@ char **devm_kasprintf_strarray(struct device *dev, const char *prefix, size_t n)
 }
 EXPORT_SYMBOL_GPL(devm_kasprintf_strarray);
 
-/**
- * strscpy_pad() - Copy a C-string into a sized buffer
- * @dest: Where to copy the string to
- * @src: Where to copy the string from
- * @count: Size of destination buffer
- *
- * Copy the string, or as much of it as fits, into the dest buffer.  The
- * behavior is undefined if the string buffers overlap.  The destination
- * buffer is always %NUL terminated, unless it's zero-sized.
- *
- * If the source string is shorter than the destination buffer, zeros
- * the tail of the destination buffer.
- *
- * For full explanation of why you may want to consider using the
- * 'strscpy' functions please see the function docstring for strscpy().
- *
- * Returns:
- * * The number of characters copied (not including the trailing %NUL)
- * * -E2BIG if count is 0 or @src was truncated.
- */
-ssize_t strscpy_pad(char *dest, const char *src, size_t count)
-{
-	ssize_t written;
-
-	written = strscpy(dest, src, count);
-	if (written < 0 || written == count - 1)
-		return written;
-
-	memset(dest + written + 1, 0, count - written - 1);
-
-	return written;
-}
-EXPORT_SYMBOL(strscpy_pad);
-
 /**
  * skip_spaces - Removes leading whitespace from @str.
  * @str: The string to be stripped.
-- 
2.34.1


