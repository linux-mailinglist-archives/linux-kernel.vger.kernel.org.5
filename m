Return-Path: <linux-kernel+bounces-44903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4868428DB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24CEA1F2A7F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B753086AC9;
	Tue, 30 Jan 2024 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntb4WJpa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA08886AC4;
	Tue, 30 Jan 2024 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631005; cv=none; b=qApUstkmy8aHjSDrKNHBJnolMnoj2Iytm64oHefUJdWA6/1FeefPxGaebOxFf2ktcqpoPljrX7Yhq/PGAjD1huzVfsPoSiwzQLAT1WtYJLAAxpI28i/gGM+bJb6KdRrG2NtgqFLaKCWGOXeDPj5blSXY8rx0pF2X/cbknlTD0M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631005; c=relaxed/simple;
	bh=/NjfqjGJigrfpu5TUJIQztR9ZCv06LXIa3Mte/WCioU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dyxoyL3R0C0Qs4UiepClOdpyPKLnpRHWjeKi3ILqpV0RApQ5RWYXe93O9WWUtKQe/tf2KxnbzfHUq2CaWvCAkK4+JNgzzlpmsyS2NwUYjn58j1PejwSZ2sTTm/oY9Bcd+7OrG8757s+vCwacujjloHq/0Be0pWT6MtvUluhvHPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntb4WJpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E6DC433F1;
	Tue, 30 Jan 2024 16:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706631005;
	bh=/NjfqjGJigrfpu5TUJIQztR9ZCv06LXIa3Mte/WCioU=;
	h=From:To:Cc:Subject:Date:From;
	b=ntb4WJpaZzYkRxd87lbmJfTXlaj9YSWFCf8btUK7hV/EeuEj9mhBF2YyIpGK+uG/D
	 t1wwamVGtWxWb+bHWn10OhUCDmaieJwrE+D5ViINS5VaK1OoTHaFrVHPCRlGH2bL7N
	 ht+n15MnnBTNyURgRL3c7o3f5lf/3oPbhymycmH+/BZOkjDS3z/C3f9vO/9BEkpdUy
	 U/X+6oWFZ3G9RqoTjzjcByFpvqwpJqNi8Tiw5lxmaldY93EBlQqbDwjnG0m8VHtDcY
	 VF9j08zwTK7FJ15dUU9/Ew09TY1scz8mC+2EhbWuR3eV6h0FL+dMa/WtJOewcGtNsb
	 Wksm6Rx3ejdMg==
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
	Juergen Quade <quade@hsnr.de>,
	David Laight <David.Laight@aculab.com>
Subject: [PATCH v3 1/1] lib/vsprintf: Implement spprintf() to catch truncated strings
Date: Tue, 30 Jan 2024 16:09:53 +0000
Message-ID: <20240130160953.766676-1-lee@kernel.org>
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
spprintf() comes in, since it takes the best parts of both of the
aforementioned variants.  It has the testability of truncation of
snprintf() and returns the number of Bytes *actually* written, similar
to scnprintf(), making it a very programmer friendly alternative.

Here's some examples to show the differences:

  Success: No truncation - all 9 Bytes successfully written to the buffer

    ret = snprintf (buf, 10, "%s", "123456789");  // ret = 9
    ret = scnprintf(buf, 10, "%s", "123456789");  // ret = 9
    ret = spprintf (buf, 10, "%s", "123456789");  // ret = 9

  Failure: Truncation - only 9 of 10 Bytes written; '-' is truncated

    ret = snprintf (buf, 10, "%s", "123456789---"); // ret = 12

      Reports: "12 Bytes would have been written if buf was large enough"
      Issue: Too easy for programmers to assume ret is Bytes written

    ret = scnprintf(buf, 10, "%s", "123456789---"); // ret = 9

      Reports: "9 Bytes actually written"
      Issue: Not testable - returns 9 on success AND failure (see above)

    ret = spprintf (buf, 10, "%s", "123456789---"); // ret = 10

      Reports: "Data provided is too large to fit in the buffer"
      Issue: No tangible impact: No way to tell how much data was lost

Since spprintf() only reports the total size of the buffer, it's easy to
test if they buffer overflowed since if we include the compulsory '\0',
only 9 Bytes additional Bytes can fit, so the return of 10 informs the
caller of an overflow.  Also, if the return data is plugged straight
into an additional call to spprintf() after the occurrence of an
overflow, no out-of-bounds will occur:

    int size = 10;
    char buf[size];
    char *b = buf;

    ret = spprintf(b, size, "1234");
    size -= ret;
    b += ret;
    // ret = 4  size = 6  buf = "1234\0"

    ret = spprintf(b, size, "5678");
    size -= ret;
    b += ret;
    // ret = 4  size = 2  buf = "12345678\0"

    ret = spprintf(b, size, "9***");
    size -= ret;
    b += ret;
    // ret = 2  size = 0  buf = "123456789\0"

Since size is now 0, further calls result in no changes of state.

    ret = spprintf(b, size, "----");
    size -= ret;
    b += ret;
    // ret = 0  size = 0  buf = "123456789\0"

[0] https://lwn.net/Articles/69419/
[1] https://github.com/KSPP/linux/issues/105
Signed-off-by: Lee Jones <lee@kernel.org>
---
Changelog:

v1 => v2:
 - Address Rasmus Villemoes's review comments:
   - Remove explicit check for zero sized buffer (-E2BIG is appropriate)
   - Remove unreachable branch in vssprintf()

v2 => v3:
  - Address session from David Laight
    - Return 'size' instead of '-E2BIG'

 include/linux/sprintf.h |  2 ++
 lib/vsprintf.c          | 51 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Crutcher Dunnavant <crutcher+kernel@datastacks.com>
Cc: Juergen Quade <quade@hsnr.de>
Cc: David Laight <David.Laight@aculab.com>

diff --git a/include/linux/sprintf.h b/include/linux/sprintf.h
index 33dcbec719254..5c4b7e612ba04 100644
--- a/include/linux/sprintf.h
+++ b/include/linux/sprintf.h
@@ -13,6 +13,8 @@ __printf(3, 4) int snprintf(char *buf, size_t size, const char *fmt, ...);
 __printf(3, 0) int vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
 __printf(3, 4) int scnprintf(char *buf, size_t size, const char *fmt, ...);
 __printf(3, 0) int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
+__printf(3, 4) int spprintf(char *buf, size_t size, const char *fmt, ...);
+__printf(3, 0) int vspprintf(char *buf, size_t size, const char *fmt, va_list args);
 __printf(2, 3) __malloc char *kasprintf(gfp_t gfp, const char *fmt, ...);
 __printf(2, 0) __malloc char *kvasprintf(gfp_t gfp, const char *fmt, va_list args);
 __printf(2, 0) const char *kvasprintf_const(gfp_t gfp, const char *fmt, va_list args);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 552738f14275a..54d4e170ded1d 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2936,6 +2936,34 @@ int vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
 }
 EXPORT_SYMBOL(vscnprintf);
 
+/**
+ * vspprintf - Format a string and place it in a buffer
+ * @buf: The buffer to place the result into
+ * @size: The size of the buffer, including the trailing null space
+ * @fmt: The format string to use
+ * @args: Arguments for the format string
+ *
+ * The return value is the number of characters which have been written into
+ * the @buf not including the trailing '\0' or the size of the buffer if the
+ * string was truncated.
+ *
+ * If you're not already dealing with a va_list consider using spprintf().
+ *
+ * See the vsnprintf() documentation for format string extensions over C99.
+ */
+int vspprintf(char *buf, size_t size, const char *fmt, va_list args)
+{
+	int i;
+
+	i = vsnprintf(buf, size, fmt, args);
+
+	if (likely(i < size))
+		return i;
+
+	return size;
+}
+EXPORT_SYMBOL(vspprintf);
+
 /**
  * snprintf - Format a string and place it in a buffer
  * @buf: The buffer to place the result into
@@ -2987,6 +3015,29 @@ int scnprintf(char *buf, size_t size, const char *fmt, ...)
 }
 EXPORT_SYMBOL(scnprintf);
 
+/**
+ * spprintf - Format a string and place it in a buffer
+ * @buf: The buffer to place the result into
+ * @size: The size of the buffer, including the trailing null space
+ * @fmt: The format string to use
+ * @...: Arguments for the format string
+ *
+ * The return value is the number of characters written into @buf not including
+ * the trailing '\0' or the size of the buffer if the string was truncated.
+ */
+int spprintf(char *buf, size_t size, const char *fmt, ...)
+{
+	va_list args;
+	int i;
+
+	va_start(args, fmt);
+	i = vspprintf(buf, size, fmt, args);
+	va_end(args);
+
+	return i;
+}
+EXPORT_SYMBOL(spprintf);
+
 /**
  * vsprintf - Format a string and place it in a buffer
  * @buf: The buffer to place the result into
-- 
2.43.0.429.g432eaa2c6b-goog


