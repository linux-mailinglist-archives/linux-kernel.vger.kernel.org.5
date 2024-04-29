Return-Path: <linux-kernel+bounces-162961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DF68B62C3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400F928411B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E8213C3DE;
	Mon, 29 Apr 2024 19:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JReQKlvC"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA5F13AA48
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419827; cv=none; b=g8AF+s5/pyJ71OlpXasb1LwjV8/3gBj87t4387E4f3lRN80f95jbevDShRjclFClZODsPSxZZ7rp8Gdek0p57EokV9B5Ey/Pegs91BQF1wqWQmtkXlJuYrQvKgrR1yJqXFP7hDtlzWzTv5zVCINJSJ8KD9LHt7zIK8p9rb1lclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419827; c=relaxed/simple;
	bh=kSRrwFAd7C9JQFKV2ouSVZifzUjd6M3hXT4sWuG0DIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gZ0hbDTMzd4nVeKtbFfBALZPFp+YfKAQdUy4nreWTVDb9bfUetVOnkY6N70sRcFv5EBGfhq3YUskbuXFd6mef2ZqNOqv0dWJoDcT7gZQxuz90wa1F9GrycCniktQ8ohorOBHAzcAGJ0FCn9v0hdPdhbb/xg5a5O30yf907UEZWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JReQKlvC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so33302835ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714419825; x=1715024625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gA3odFjA56eyxJJ+Tkfmb0e2e9r2EQ/K83DUbh1Jiwo=;
        b=JReQKlvC25ygeC5SOoM//jW80mGuJM99m8YEx1YkEnO57TPCn0VTcgEC5GNh1aj+gK
         G6wehgmXv3RV8Pcn5uEd07wbgSnppum8MqWtwC7KsdqA5GPFjD1jOLaUntTwhRcQ/PHP
         aHcKeTtfGDZwQOD4uqvCxy4n/qUunO8wgh3ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419825; x=1715024625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gA3odFjA56eyxJJ+Tkfmb0e2e9r2EQ/K83DUbh1Jiwo=;
        b=kssSQZXIjiWRTWFyG4qvm39oaXCNJJxJeeM4sWTsj7NgoPia/22NZp7kqLlPMzwmwt
         z8lAL7E/hquFp9hVEPz4aRfa7/JGmSl+klstdSrQ726PIvfbhchLadH+tL6rNyCoqemE
         L7eYO1TOoVWUvCynOgm/PFbqnar7I2ocKjyOdF5RgbVIpIHwgbqnL3GXeb0uBQ3oQs7v
         RvdfIqRRljCy/5+D65g5mbHKTaEF+I9maWYL3aGMmid4BNuoPRm31VmevGjB7Sw5omeV
         OzZWOLA0MlIDizMbVjlJI369cJk8GwDTF8t1NnTbCMAZpzafnXRoadL9lahVHUp3sDgB
         ABhw==
X-Forwarded-Encrypted: i=1; AJvYcCUVZn2e0qkRGC9AMiNzNv5AsiLPdKzDIPX68GYPrQoQhEYNu5PbrQG0wlswuBVyV6uVTUoNcwnZJYhxLqMw84d0zbL9H7yXc+Pkxvbk
X-Gm-Message-State: AOJu0YwaDHeBHjKWsLTf+DQ8PDSEcxA8qK66cvPrDZ1McSGatVOZPhFE
	WOIJcoEthtTL2p0WWZxj8o6xsWPyvIVilOc2LxB6QZMOhMqFaMrKhaXAowMCMnX5f/2kRBX+4Q0
	=
X-Google-Smtp-Source: AGHT+IEkmPKWaTr8pczDUXHETCniPvsmQ+rzfKOTPy/2xp3y56kfC3BugREtIfP6PpUUHrB3SGkBJA==
X-Received: by 2002:a17:903:2301:b0:1dd:dcd3:662c with SMTP id d1-20020a170903230100b001dddcd3662cmr1077006plh.4.1714419825311;
        Mon, 29 Apr 2024 12:43:45 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ky14-20020a170902f98e00b001e8d1a6d2acsm18694097plb.267.2024.04.29.12.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:43:43 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] kunit/fortify: Add memcpy() tests
Date: Mon, 29 Apr 2024 12:43:41 -0700
Message-Id: <20240429194342.2421639-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429194019.work.664-kees@kernel.org>
References: <20240429194019.work.664-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6800; i=keescook@chromium.org;
 h=from:subject; bh=kSRrwFAd7C9JQFKV2ouSVZifzUjd6M3hXT4sWuG0DIo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmL/hteTsDQfmMjRiGhqWOD9a5Z3jVx1AhFFPRh
 ciLfMRfszGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZi/4bQAKCRCJcvTf3G3A
 JpVAD/9dx/Q9X1ff3gFKMqjfFvIx9gdcBGuZCiPylGs2UlwMwXRjNhnGcHXZr0Sw0nqa/kjV0lh
 6UfLuHh8ajHNLxiNAbkOQZc/znlLvz/Eh8ZnkLNyPw+MVHoAWbhUrLMLinSBSUJE1ezf33yfCV+
 k7JL7phc8Zg8LEbfjG4y7L/5VPc7RYw64EzqZ3cVm9nPTMNiCscMZmqr6ZVI9pHLKFTyOYG3VPx
 yyiLJT7FsZoB6s9Pi0Vu7J4A4grAuI2JAh2u/GLegZ9Waw4CupXqa0+WZxkZ+2cDPj4acej1Ijm
 SRkzLKiJ5hZqXmDTYDLfk84DZw596qM6mbdb7ZM7LFxtye8cuiWKIDczZy5UohEfK7e5Bytze/e
 49dtjYL0DCw9mABBKN9TrB+bJ04/kMchRU72VqFK8gzrHIs8Q9KzkBft/N8fK5FCtSpUj5I9rEO
 v1S1CCs0EyW0YlqOfhos60r5ZtGvy2VqYsqZQ329LeLg1vRzze7zWhaaP5ti+9hXY73Oth6+/4L
 kRcpWCtCr1Gb9bKeU6MjN0luTCBvrFd62FxnRjSlOJHdReKdj2joQ6Fc4pf47tGV6wlgGMFAssD
 e8QYGDcIKcjc39NLTomqp6Ebwl6COn4R03BfkUZ7J5dJsxofSZCrbE/VCD9iO5VkbuMo2Hryf0B Q5wvi14asl7MSXw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Add fortify tests for memcpy() and memmove(). This can use a similar
method to the fortify_panic() replacement, only we can do it for what
was the WARN_ONCE(), which can be redefined.

Since this is primarily testing the fortify behaviors of the memcpy()
and memmove() defenses, the tests for memcpy() and memmove() are
identical.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: linux-hardening@vger.kernel.org
---
 include/linux/fortify-string.h |  6 ++-
 lib/fortify_kunit.c            | 85 ++++++++++++++++++++++++++++++++--
 2 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 6aeebe0a6777..a0bb13825109 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -15,10 +15,14 @@
 #define FORTIFY_REASON(func, write)	(FIELD_PREP(BIT(0), write) | \
 					 FIELD_PREP(GENMASK(7, 1), func))
 
+/* Overridden by KUnit tests. */
 #ifndef fortify_panic
 # define fortify_panic(func, write, avail, size, retfail)	\
 	 __fortify_panic(FORTIFY_REASON(func, write), avail, size)
 #endif
+#ifndef fortify_warn_once
+# define fortify_warn_once(x...)	WARN_ONCE(x)
+#endif
 
 #define FORTIFY_READ		 0
 #define FORTIFY_WRITE		 1
@@ -609,7 +613,7 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	const size_t __q_size = (q_size);				\
 	const size_t __p_size_field = (p_size_field);			\
 	const size_t __q_size_field = (q_size_field);			\
-	WARN_ONCE(fortify_memcpy_chk(__fortify_size, __p_size,		\
+	fortify_warn_once(fortify_memcpy_chk(__fortify_size, __p_size,	\
 				     __q_size, __p_size_field,		\
 				     __q_size_field, FORTIFY_FUNC_ ##op), \
 		  #op ": detected field-spanning write (size %zu) of single %s (size %zu)\n", \
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index bbbfc2238aa9..ad7fc85f34ac 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Runtime test cases for CONFIG_FORTIFY_SOURCE. For testing memcpy(),
- * see FORTIFY_MEM_* tests in LKDTM (drivers/misc/lkdtm/fortify.c).
+ * Runtime test cases for CONFIG_FORTIFY_SOURCE. For additional memcpy()
+ * testing see FORTIFY_MEM_* tests in LKDTM (drivers/misc/lkdtm/fortify.c).
  *
  * For corner cases with UBSAN, try testing with:
  *
@@ -18,8 +18,10 @@
 /* We don't need to fill dmesg with the fortify WARNs during testing. */
 #ifdef DEBUG
 # define FORTIFY_REPORT_KUNIT(x...) __fortify_report(x)
+# define FORTIFY_WARN_KUNIT(x...)   WARN_ONCE(x)
 #else
 # define FORTIFY_REPORT_KUNIT(x...) do { } while (0)
+# define FORTIFY_WARN_KUNIT(x...)   do { } while (0)
 #endif
 
 /* Redefine fortify_panic() to track failures. */
@@ -30,6 +32,14 @@ void fortify_add_kunit_error(int write);
 	return (retfail);						\
 } while (0)
 
+/* Redefine fortify_warn_once() to track memcpy() failures. */
+#define fortify_warn_once(chk_func, x...) do {				\
+	bool __result = chk_func;					\
+	FORTIFY_WARN_KUNIT(__result, x);				\
+	if (__result)							\
+		fortify_add_kunit_error(1);				\
+} while (0)
+
 #include <kunit/device.h>
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
@@ -818,6 +828,74 @@ static void fortify_test_strlcat(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
 }
 
+/* Check for 0-sized arrays... */
+struct fortify_zero_sized {
+	unsigned long bytes_before;
+	char buf[0];
+	unsigned long bytes_after;
+};
+
+#define __fortify_test(memfunc)					\
+static void fortify_test_##memfunc(struct kunit *test)		\
+{								\
+	struct fortify_zero_sized zero = { };			\
+	struct fortify_padding pad = { };			\
+	char srcA[sizeof(pad.buf) + 2];				\
+	char srcB[sizeof(pad.buf) + 2];				\
+	size_t len = sizeof(pad.buf) + unconst;			\
+								\
+	memset(srcA, 'A', sizeof(srcA));			\
+	KUNIT_ASSERT_EQ(test, srcA[0], 'A');			\
+	memset(srcB, 'B', sizeof(srcB));			\
+	KUNIT_ASSERT_EQ(test, srcB[0], 'B');			\
+								\
+	memfunc(pad.buf, srcA, 0 + unconst);			\
+	KUNIT_EXPECT_EQ(test, pad.buf[0], '\0');		\
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);	\
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);	\
+	memfunc(pad.buf + 1, srcB, 1 + unconst);		\
+	KUNIT_EXPECT_EQ(test, pad.buf[0], '\0');		\
+	KUNIT_EXPECT_EQ(test, pad.buf[1], 'B');			\
+	KUNIT_EXPECT_EQ(test, pad.buf[2], '\0');		\
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);	\
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);	\
+	memfunc(pad.buf, srcA, 1 + unconst);			\
+	KUNIT_EXPECT_EQ(test, pad.buf[0], 'A');			\
+	KUNIT_EXPECT_EQ(test, pad.buf[1], 'B');			\
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);	\
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);	\
+	memfunc(pad.buf, srcA, len - 1);			\
+	KUNIT_EXPECT_EQ(test, pad.buf[1], 'A');			\
+	KUNIT_EXPECT_EQ(test, pad.buf[len - 1], '\0');		\
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);	\
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);	\
+	memfunc(pad.buf, srcA, len);				\
+	KUNIT_EXPECT_EQ(test, pad.buf[1], 'A');			\
+	KUNIT_EXPECT_EQ(test, pad.buf[len - 1], 'A');		\
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);		\
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);	\
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);	\
+	memfunc(pad.buf, srcA, len + 1);			\
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);	\
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);	\
+	memfunc(pad.buf + 1, srcB, len);			\
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);	\
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);	\
+								\
+	/* Reset error counter. */				\
+	fortify_write_overflows = 0;				\
+	/* Copy nothing into nothing: no errors. */		\
+	memfunc(zero.buf, srcB, 0 + unconst);			\
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);	\
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);	\
+	/* We currently explicitly ignore zero-sized dests. */	\
+	memfunc(zero.buf, srcB, 1 + unconst);			\
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);	\
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);	\
+}
+__fortify_test(memcpy)
+__fortify_test(memmove)
+
 static void fortify_test_memscan(struct kunit *test)
 {
 	char haystack[] = "Where oh where is my memory range?";
@@ -977,7 +1055,8 @@ static struct kunit_case fortify_test_cases[] = {
 	KUNIT_CASE(fortify_test_strncat),
 	KUNIT_CASE(fortify_test_strlcat),
 	/* skip memset: performs bounds checking on whole structs */
-	/* skip memcpy: still using warn-and-overwrite instead of hard-fail */
+	KUNIT_CASE(fortify_test_memcpy),
+	KUNIT_CASE(fortify_test_memmove),
 	KUNIT_CASE(fortify_test_memscan),
 	KUNIT_CASE(fortify_test_memchr),
 	KUNIT_CASE(fortify_test_memchr_inv),
-- 
2.34.1


