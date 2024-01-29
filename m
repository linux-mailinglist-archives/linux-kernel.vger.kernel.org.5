Return-Path: <linux-kernel+bounces-42467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BB18401B9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADCA8283098
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A9755E51;
	Mon, 29 Jan 2024 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTEbrwvs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB0555C3D;
	Mon, 29 Jan 2024 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520599; cv=none; b=Nr46yAkAyPlDKzQk2hNUZdgnOtC7qtWYze59Y7Qmc8UzPvrxSb6JLiNsyPi133/URlHcJtcGbp6br3zVgoM8L4d/P4heCycidRpEDN12Nh/zwN9XceQh41d3bpOzHj/fGDBRtGdyIkS4Yi9ZT4bGvPpF1OP59wRynkXWWmjqc9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520599; c=relaxed/simple;
	bh=FOtCAJxhqeqAJLlTKWeIWwK177ZkAY+IT7ykxd5EE7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mta4I1MaEw6jzeoWAJbI77sGyLHCIon7JAQXzwmeMD4wZvWpR6zc3z+ApRRZGhvpYTuVNNj8ojztl18ie/nhpdjMoUkGTiuXANAHzVCq5Zl7E9n5eqnbuReit7qJZY7b0/Cr5eC2r3XBIkbAPcgRybXQvn8K5l49N2mhXyP6EBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTEbrwvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE6FC433C7;
	Mon, 29 Jan 2024 09:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706520599;
	bh=FOtCAJxhqeqAJLlTKWeIWwK177ZkAY+IT7ykxd5EE7Y=;
	h=From:To:Cc:Subject:Date:From;
	b=dTEbrwvsPV7z6s9KHhBScmxDK3HquF62ChUtssgNFZJqZ0j7nnoKoVsAneaQzLnc/
	 0iUrwrEWVe1q4TGfthBkIdRVanYruzqoVwu/jiZ33hYbV/tga0lB8DevRNgqu69eSM
	 FImm57SNIuBWSZxXt2AzqOrBi79kBK6+qiMq/gEqw7idxInrBG11UdBoZoXtX1ezpX
	 gZhcpXFQtIwayp2mbxuh5BpZpWuH38dtE/5IgSQeMhKteFCGsxWElx8tvXTBi/e0KL
	 BjGgixHzA00j5Hx2Jknlkm++umMyA8UUyWGlsWRM1Y3UB5fx6KZ9U7RQjm9Aa8TTi0
	 FFVO6T5GQC97Q==
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
Subject: [PATCH v2 1/1] lib/vsprintf: Implement ssprintf() to catch truncated strings
Date: Mon, 29 Jan 2024 09:29:52 +0000
Message-ID: <20240129092952.1980246-1-lee@kernel.org>
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
Changelog:

v1 => v2:
 - Address Rasmus Villemoes's review comments:
   - Remove explicit check for zero sized buffer (-E2BIG is appropriate)
   - Remove unreachable branch in vssprintf()

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
index 552738f14275a..e2b51fc625564 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2936,6 +2936,34 @@ int vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
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
+ * truncated.
+ *
+ * If you're not already dealing with a va_list consider using ssprintf().
+ *
+ * See the vsnprintf() documentation for format string extensions over C99.
+ */
+int vssprintf(char *buf, size_t size, const char *fmt, va_list args)
+{
+	int i;
+
+	i = vsnprintf(buf, size, fmt, args);
+
+	if (likely(i < size))
+		return i;
+
+	return -E2BIG;
+}
+EXPORT_SYMBOL(vssprintf);
+
 /**
  * snprintf - Format a string and place it in a buffer
  * @buf: The buffer to place the result into
@@ -2987,6 +3015,29 @@ int scnprintf(char *buf, size_t size, const char *fmt, ...)
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
+ * the trailing '\0' or -E2BIG if the string was truncated.
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


