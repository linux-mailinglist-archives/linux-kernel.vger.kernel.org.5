Return-Path: <linux-kernel+bounces-38185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8328583BC2C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A2C1F28705
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFEB1B94C;
	Thu, 25 Jan 2024 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnCs+A+E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892FA10A26;
	Thu, 25 Jan 2024 08:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706171991; cv=none; b=WFtwsGur654Ez3HPL/EFDEPnXRhZWWKXDGCNH3yyS1oz1uFqUgY10EHldhfrYZRwi8xA1bgawgegsK9GLUg6BesozUzrL9YMLt09NjWhfujwE0j6uCjm498mLYi1dn2BNp2OGcTz24vYUCl6qyyZk4GvglHF0FyIu2nyuO6rMo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706171991; c=relaxed/simple;
	bh=RXkzfLL2N29dPptHVKrmwqbEGL7heXtbJrtQhxkKk0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ndY6KCGN1Nfyy6lU7E1ToAzA4heGBwvh8+q7mjxrt8RSb2ZrZv0VJ+AdcNLR0NL3ha2Qw5doA+ydHmuntZSUU4oIYaJDNf3T5U/p/42xOc0wD+x2ByhV7o2QRU5rq7lGTppOAtfaG/a6/AMGheo2XhCT+uGORObnqlN2yMg6X44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnCs+A+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC2BC433C7;
	Thu, 25 Jan 2024 08:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706171991;
	bh=RXkzfLL2N29dPptHVKrmwqbEGL7heXtbJrtQhxkKk0g=;
	h=From:To:Cc:Subject:Date:From;
	b=UnCs+A+EpFG9LpwtaYIUgkbVwmlBBkZcIrSEoSynknHHHhNVrw2zZ9nKGLEnieHJi
	 /KXqOFBzs+OougVY0dzDqWU8hxGYOlH8Fb0ZTCgF0x2K1Jnib7dcp1ELeeQKtewM9Q
	 Zkmv3gkxv4WMPF3oCUAVJoF3Hllm4b/RPlBVL6z5f54aIuhlrKEMoIsfZTbds70MNT
	 OCyqxrpOfN4qWQi1IK1ewK3swEYqDtYZzoTgGeDal72PA7FGqgEN5bDlI+uz7d+bmC
	 iWNK74Dh/uMjI2PKeVQbOKotojpwFrLaD8Zw+UGH98QLZT+toU0adIdLAHWX/nLJtD
	 x2owy8+O+1i1A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Crutcher Dunnavant <crutcher+kernel@datastacks.com>,
	Juergen Quade <quade@hsnr.de>
Subject: [PATCH 1/1] lib/vsprintf: Implement ssprintf() to catch truncated strings
Date: Thu, 25 Jan 2024 08:39:21 +0000
Message-ID: <20240125083921.1312709-1-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is an ongoing effort to replace the use of {v}snprintf() variants
with safer alternatives - for a more in depth view, see Jon's write-up
on LWN [0] and/or Alex's on the Kernel Self Protection Project [1].

Whist executing the task, it quickly became apparent that the initial
thought of simply s/snprintf/scnprintf/ wasn't going to be adequate for
a number of cases.  Specifically ones where the caller needs to know
whether the given string ends up being truncated.  This is where
ssprintf() [based on similar semantics of strscpy()] comes in, since it
takes the best parts of both of the aforementioned variants.  It has the
testability of truncation of snprintf() and returns the number of Bytes
*actually* written, similar to scnprintf(), making it a very programmer
friendly alternative.

Here's some examples to show the differences:

  Success: No truncation - all 9 Bytes successfully written to the buffer

    ret = snprintf (buf, 10, "%s", "123456789");  // ret = 9
    ret = scnprintf(buf, 10, "%s", "123456789");  // ret = 9
    ret = ssprintf (buf, 10, "%s", "123456789");  // ret = 9

  Failure: Truncation - only 9 of 10 Bytes written; '-' is truncated

    ret = snprintf (buf, 10, "%s", "123456789-"); // ret = 10

      Reports: "10 Bytes would have been written if buf was large enough"
      Issue: Programmers need to know/remember to check ret against "10"

    ret = scnprintf(buf, 10, "%s", "123456789-"); // ret = 9

      Reports: "9 Bytes actually written"
      Issue: Returns 9 on success AND failure (see above)

    ret = ssprintf (buf, 10, "%s", "123456789-"); // ret = -E2BIG

      Reports: "Data provided is too large to fit in the buffer"
      Issue: No tangible impact: No way to tell how much data was lost

[0] https://lwn.net/Articles/69419/
[1] https://github.com/KSPP/linux/issues/105
Signed-off-by: Lee Jones <lee@kernel.org>
---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Crutcher Dunnavant <crutcher+kernel@datastacks.com>
Cc: Juergen Quade <quade@hsnr.de>

 include/linux/sprintf.h |  2 ++
 lib/vsprintf.c          | 58 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/linux/sprintf.h b/include/linux/sprintf.h
index 33dcbec719254..2a3db6285492a 100644
--- a/include/linux/sprintf.h
+++ b/include/linux/sprintf.h
@@ -13,6 +13,8 @@ __printf(3, 4) int snprintf(char *buf, size_t size, const char *fmt, ...);
 __printf(3, 0) int vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
 __printf(3, 4) int scnprintf(char *buf, size_t size, const char *fmt, ...);
 __printf(3, 0) int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
+__printf(3, 4) int ssprintf(char *buf, size_t size, const char *fmt, ...);
+__printf(3, 0) int vssprintf(char *buf, size_t size, const char *fmt, va_list args);
 __printf(2, 3) __malloc char *kasprintf(gfp_t gfp, const char *fmt, ...);
 __printf(2, 0) __malloc char *kvasprintf(gfp_t gfp, const char *fmt, va_list args);
 __printf(2, 0) const char *kvasprintf_const(gfp_t gfp, const char *fmt, va_list args);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 552738f14275a..01a1060ca0b0d 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2936,6 +2936,40 @@ int vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
 }
 EXPORT_SYMBOL(vscnprintf);
 
+/**
+ * vssprintf - Format a string and place it in a buffer
+ * @buf: The buffer to place the result into
+ * @size: The size of the buffer, including the trailing null space
+ * @fmt: The format string to use
+ * @args: Arguments for the format string
+ *
+ * The return value is the number of characters which have been written into
+ * the @buf not including the trailing '\0' or -E2BIG if the string was
+ * truncated. If @size is == 0 the function returns 0.
+ *
+ * If you're not already dealing with a va_list consider using ssprintf().
+ *
+ * See the vsnprintf() documentation for format string extensions over C99.
+ */
+int vssprintf(char *buf, size_t size, const char *fmt, va_list args)
+{
+	int i;
+
+	if (unlikely(!size))
+		return 0;
+
+	i = vsnprintf(buf, size, fmt, args);
+
+	if (unlikely(i >= size))
+		return -E2BIG;
+
+	if (likely(i < size))
+		return i;
+
+	return size - 1;
+}
+EXPORT_SYMBOL(vssprintf);
+
 /**
  * snprintf - Format a string and place it in a buffer
  * @buf: The buffer to place the result into
@@ -2987,6 +3021,30 @@ int scnprintf(char *buf, size_t size, const char *fmt, ...)
 }
 EXPORT_SYMBOL(scnprintf);
 
+/**
+ * ssprintf - Format a string and place it in a buffer
+ * @buf: The buffer to place the result into
+ * @size: The size of the buffer, including the trailing null space
+ * @fmt: The format string to use
+ * @...: Arguments for the format string
+ *
+ * The return value is the number of characters written into @buf not including
+ * the trailing '\0' or -E2BIG if the string was truncated. If @size is == 0
+ * the function returns 0.
+ */
+int ssprintf(char *buf, size_t size, const char *fmt, ...)
+{
+	va_list args;
+	int i;
+
+	va_start(args, fmt);
+	i = vssprintf(buf, size, fmt, args);
+	va_end(args);
+
+	return i;
+}
+EXPORT_SYMBOL(ssprintf);
+
 /**
  * vsprintf - Format a string and place it in a buffer
  * @buf: The buffer to place the result into
-- 
2.43.0.429.g432eaa2c6b-goog


