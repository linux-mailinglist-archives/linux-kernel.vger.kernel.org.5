Return-Path: <linux-kernel+bounces-69687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDEB858D43
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 05:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00CD1C212F5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 04:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAC51D537;
	Sat, 17 Feb 2024 04:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I/grpy16"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD2E1CA9B
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 04:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708145623; cv=none; b=U9wiBRdFSPzNVDGu/NPROkh7XU9PmHL7iC0XYuEXL+Q/zkq4gj1voP39kiy/ZW63isvCPhlHNG+PuH8biUW6X31iEZTC9J5pDgV/WfapPM6DRIHEE/DQ3zjNQUvwY3aZWn09Sg6MpWfie4CO+vrgwuRORQ0zQqFhSeYPUkum78w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708145623; c=relaxed/simple;
	bh=n2yHX3VFuSqd5a58ECahq9aQe9ZQtPrH7dJ9V/EutHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o2fuQn533M2IuzLJf5iEm9c58FeEA9Rp7UfiIgudJT8/QJDDHEgleKp7D3+HuY/au6ld610+VwMuOSjEKx3cfJKFOdVMRl1YlIF0wen3FqQSSuTsKr+3Q7uVg61pXLS5PD0ooOyo/NUFkKfsxCcsY5ktOQx1Cl57/c7oDf+ioRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I/grpy16; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7c457b8ef7cso94629639f.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 20:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708145620; x=1708750420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8fMfE+BGQPs5FLgU3mkDOSE9IZHFwdxz/Ne820XXmM=;
        b=I/grpy16LJZQtu1siFzazt3x4uF8lvSJt6o8SZa+Ydkv0r/vOeSelmro1Y2kUmOqN2
         s7HJFlahEvLhcJDKU/XGWCGSNlT7HbBbAzTQZ6g8FBf17Ew6axR0jxgnM0cW/49biEhq
         dbTvgxCcEZM/XFC9S4qCJE+1bMBcv9cqtueqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708145620; x=1708750420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8fMfE+BGQPs5FLgU3mkDOSE9IZHFwdxz/Ne820XXmM=;
        b=aIYJ93txuRBsl6CycFzM76ZKkeleNRfvWhCMLhfnvG0VnDMxVgOu2uBhKO1EhaIggZ
         C3pi48HSxeEFKqJXMSmXORTXa2+y9VaGDLQbnPzjUSJaEQ6QElTPXAshKsMmAZg4/OkM
         SqI90yHs7ok6XC9jQIcwV9l1sjT0FWXV+V35TSRdYPoAZT2khZqglSeTOJOo8H+H1L+2
         xvPtsYylT4faGwFT/AgnEX7omy1yNwViR38jRRHWGss3wPRb0FG4IugB8WPiShIFKr9b
         vzJiV7CWVR0HX0ege0I0E8CF2WJ8ICXO+A3ooetWsy6jk/xk/XS0ayjkN/dcoPjoxdDw
         //9w==
X-Forwarded-Encrypted: i=1; AJvYcCU4dsfI21N1ARqpqMAgoToUmDmOfMMxxW6oZgbHUW+SbXGie2+rAfgz0pgpDHN7lA3Km+WRCfJx4r1wPBrr9ULjtJCtkBtrLzfx1tqE
X-Gm-Message-State: AOJu0Yy6Snm6h4r0bZR6VBU5MiFQrGVVT8RpdTOZHHgm8Ugbmq3uq1yz
	veySQpXU998AAItI4QwkN7URvZ4CPD7FhvexTlMD22lTnSrorHjmPm4cP5N/cw==
X-Google-Smtp-Source: AGHT+IHVeWos57ZfEeCp/MRitQebVxI73Wz20Ea0zLTJBqPrMjRujXAdp662KTLd5qXK+RXjF8iaBQ==
X-Received: by 2002:a05:6e02:690:b0:365:12e:4ef1 with SMTP id o16-20020a056e02069000b00365012e4ef1mr5858702ils.5.1708145620002;
        Fri, 16 Feb 2024 20:53:40 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902c71200b001d9af77893esm634181plp.58.2024.02.16.20.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 20:53:36 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	kunit-dev@googlegroups.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Puyou Lu <puyou.lu@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] fortify: Add KUnit tests for runtime overflows
Date: Fri, 16 Feb 2024 20:48:27 -0800
Message-Id: <20240217045335.1526675-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217043535.make.664-kees@kernel.org>
References: <20240217043535.make.664-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=26692; i=keescook@chromium.org;
 h=from:subject; bh=n2yHX3VFuSqd5a58ECahq9aQe9ZQtPrH7dJ9V/EutHI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl0DqcQlF1eBHKyO8mBCYFrGEs5iP7hA+zlY5eC
 0qQa/Z0BOSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdA6nAAKCRCJcvTf3G3A
 Jq24EACDywTBm/wdQrUjt5zHqxfG7oFi0zRC+57NC3oiddVIzY0QKZlwooIHe/ZuHoTvSdPHBP1
 UxU2L8jB33B8EXf8ODljClojC1/7hGyXFIfE0WpHH4o51rHPwuxeVGTtIl79UShxNZysKG6b/Ep
 Y7C3/ZsjFLx3FbIiSUmwoYsUGBw7Vgf/qsT2OYqc0N2B7kB72kzlknqbgdG4xvoZIBJ4/VrVDc6
 rLB0H4NekcQpxxwwVvDFy8+R9z7bOIUXwIavNwAYctDeq9DjeBgM6RrbkJvN2uDhTKC9i65aqUy
 y4JKHhfZKgJZpV3UW4B3mW0e+YScDLleamYibB7uUpwfZvThRKdFJtj6SDMkai8PrknlTvPbfM0
 /NafXU6hBLmrvklJH0j50NMPkcHt+uNhKG8iwLRCZOTU244nCiX/8FqsnPTM+wsJXOD/yB7FpyF
 GVlKid3BYZsL83S+AlHpfKnTUjUdwccMG+QQBLmtN+qkj//nL3Bd6GGbuML8UPFCSt43nyFR+Sw
 +fq6yINitr2KUEXm5WoJFVnUv5+9vMH4eDqdP355rNaq7eY12WcOVGvM4GN/jeDCiTfE7B1celV
 jzNjHTd4NbrdSwiRxhdcak2gDJNL+wPwF+rZrzgDkeaRDlcoCQouxm8vgqy/LJQ6SUexceNjWB5 kRfZl0O4ZUxTckA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

With fortify overflows able to be redirected, we can use KUnit to
exercise the overflow conditions. Add tests for every API covered by
CONFIG_FORTIFY_SOURCE, except for memset() and memcpy(), which are
special-cased for now.

Note that this makes the LKDTM FORTIFY_STR* tests obsolete, but those
can be removed separately.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: linux-hardening@vger.kernel.org
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: kunit-dev@googlegroups.com
---
 lib/Makefile        |   1 +
 lib/fortify_kunit.c | 607 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 606 insertions(+), 2 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index bc36a5c167db..9d0e2af8100a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -402,6 +402,7 @@ obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
 CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
 obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
 CFLAGS_fortify_kunit.o += $(call cc-disable-warning, unsequenced)
+CFLAGS_fortify_kunit.o += $(call cc-disable-warning, stringop-overread)
 CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 obj-$(CONFIG_STRCAT_KUNIT_TEST) += strcat_kunit.o
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index 4ba7d02fdd78..f0accebeca02 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Runtime test cases for CONFIG_FORTIFY_SOURCE that aren't expected to
- * Oops the kernel on success. (For those, see drivers/misc/lkdtm/fortify.c)
+ * Runtime test cases for CONFIG_FORTIFY_SOURCE. For testing memcpy(),
+ * see FORTIFY_MEM_* tests in LKDTM (drivers/misc/lkdtm/fortify.c).
  *
  * For corner cases with UBSAN, try testing with:
  *
@@ -346,6 +346,594 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
 } while (0)
 DEFINE_ALLOC_SIZE_TEST_PAIR(devm_kmalloc)
 
+/*
+ * We can't have an array at the end of a structure or else
+ * builds without -fstrict-flex-arrays=3 will report them as
+ * being an unknown length. Additionally, add bytes before
+ * and after the string to catch over/underflows if tests
+ * fail.
+ */
+struct fortify_padding {
+	unsigned long bytes_before;
+	char buf[32];
+	unsigned long bytes_after;
+};
+/* Force compiler into not being able to resolve size at compile-time. */
+static volatile int unconst;
+
+static void strlen_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	int i, end = sizeof(pad.buf) - 1;
+
+	/* Fill 31 bytes with valid characters. */
+	for (i = 0; i < sizeof(pad.buf) - 1; i++)
+		pad.buf[i] = i + '0';
+	/* Trailing bytes are still %NUL. */
+	KUNIT_EXPECT_EQ(test, pad.buf[end], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* String is terminated, so strlen() is valid. */
+	KUNIT_EXPECT_EQ(test, strlen(pad.buf), end);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+
+	/* Make string unterminated, and recount. */
+	pad.buf[end] = 'A';
+	end = sizeof(pad.buf);
+	KUNIT_EXPECT_EQ(test, strlen(pad.buf), end);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+}
+
+static void strnlen_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	int i, end = sizeof(pad.buf) - 1;
+
+	/* Fill 31 bytes with valid characters. */
+	for (i = 0; i < sizeof(pad.buf) - 1; i++)
+		pad.buf[i] = i + '0';
+	/* Trailing bytes are still %NUL. */
+	KUNIT_EXPECT_EQ(test, pad.buf[end], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* String is terminated, so strnlen() is valid. */
+	KUNIT_EXPECT_EQ(test, strnlen(pad.buf, sizeof(pad.buf)), end);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	/* A truncated strnlen() will be safe, too. */
+	KUNIT_EXPECT_EQ(test, strnlen(pad.buf, sizeof(pad.buf) / 2),
+					sizeof(pad.buf) / 2);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+
+	/* Make string unterminated, and recount. */
+	pad.buf[end] = 'A';
+	end = sizeof(pad.buf);
+	/* Reading beyond with strncpy() will fail. */
+	KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end + 1), end);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+	KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end + 2), end);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+
+	/* Early-truncated is safe still, though. */
+	KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end), end);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+
+	end = sizeof(pad.buf) / 2;
+	KUNIT_EXPECT_EQ(test, strnlen(pad.buf, end), end);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+}
+
+static void strcpy_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	char src[sizeof(pad.buf) + 1] = { };
+	int i;
+
+	/* Fill 31 bytes with valid characters. */
+	for (i = 0; i < sizeof(src) - 2; i++)
+		src[i] = i + '0';
+
+	/* Destination is %NUL-filled to start with. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_before, 0);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Legitimate strcpy() 1 less than of max size. */
+	KUNIT_ASSERT_TRUE(test, strcpy(pad.buf, src)
+				== pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Only last byte should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	src[sizeof(src) - 2] = 'A';
+	/* But now we trip the overflow checking. */
+	KUNIT_ASSERT_TRUE(test, strcpy(pad.buf, src)
+				== pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
+	/* Trailing %NUL -- thanks to FORTIFY. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* And we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	src[sizeof(src) - 1] = 'A';
+	/* And for sure now, two bytes past. */
+	KUNIT_ASSERT_TRUE(test, strcpy(pad.buf, src)
+				== pad.buf);
+	/*
+	 * Which trips both the strlen() on the unterminated src,
+	 * and the resulting copy attempt.
+	 */
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+	/* Trailing %NUL -- thanks to FORTIFY. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* And we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+}
+
+static void strncpy_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	char src[] = "Copy me fully into a small buffer and I will overflow!";
+
+	/* Destination is %NUL-filled to start with. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_before, 0);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Legitimate strncpy() 1 less than of max size. */
+	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src,
+					sizeof(pad.buf) + unconst - 1)
+				== pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Only last byte should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* Legitimate (though unterminated) max-size strncpy. */
+	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src,
+					sizeof(pad.buf) + unconst)
+				== pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* No trailing %NUL -- thanks strncpy API. */
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* But we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Now verify that FORTIFY is working... */
+	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src,
+					sizeof(pad.buf) + unconst + 1)
+				== pad.buf);
+	/* Should catch the overflow. */
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* And we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* And further... */
+	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src,
+					sizeof(pad.buf) + unconst + 2)
+				== pad.buf);
+	/* Should catch the overflow. */
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* And we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+}
+
+static void strscpy_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	char src[] = "Copy me fully into a small buffer and I will overflow!";
+
+	/* Destination is %NUL-filled to start with. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_before, 0);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Legitimate strscpy() 1 less than of max size. */
+	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src,
+				      sizeof(pad.buf) + unconst - 1),
+			-E2BIG);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Keeping space for %NUL, last two bytes should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* Legitimate max-size strscpy. */
+	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src,
+				      sizeof(pad.buf) + unconst),
+			-E2BIG);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* A trailing %NUL will exist. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+
+	/* Now verify that FORTIFY is working... */
+	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src,
+				      sizeof(pad.buf) + unconst + 1),
+			-E2BIG);
+	/* Should catch the overflow. */
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* And we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* And much further... */
+	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src,
+				      sizeof(src) * 2 + unconst),
+			-E2BIG);
+	/* Should catch the overflow. */
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	/* And we will not have gone beyond. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+}
+
+static void strcat_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	char src[sizeof(pad.buf) / 2] = { };
+	char one[] = "A";
+	char two[] = "BC";
+	int i;
+
+	/* Fill 15 bytes with valid characters. */
+	for (i = 0; i < sizeof(src) - 1; i++)
+		src[i] = i + 'A';
+
+	/* Destination is %NUL-filled to start with. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_before, 0);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Legitimate strcat() using less than half max size. */
+	KUNIT_ASSERT_TRUE(test, strcat(pad.buf, src) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Legitimate strcat() now 2 bytes shy of end. */
+	KUNIT_ASSERT_TRUE(test, strcat(pad.buf, src) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Last two bytes should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* Add one more character to the end. */
+	KUNIT_ASSERT_TRUE(test, strcat(pad.buf, one) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Last byte should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* And this one char will overflow. */
+	KUNIT_ASSERT_TRUE(test, strcat(pad.buf, one) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
+	/* Last byte should be %NUL thanks to FORTIFY. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* And adding two will overflow more. */
+	KUNIT_ASSERT_TRUE(test, strcat(pad.buf, two) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+	/* Last byte should be %NUL thanks to FORTIFY. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+}
+
+static void strncat_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	char src[sizeof(pad.buf)] = { };
+	int i, partial;
+
+	/* Fill 31 bytes with valid characters. */
+	partial = sizeof(src) / 2 - 1;
+	for (i = 0; i < partial; i++)
+		src[i] = i + 'A';
+
+	/* Destination is %NUL-filled to start with. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_before, 0);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Legitimate strncat() using less than half max size. */
+	KUNIT_ASSERT_TRUE(test, strncat(pad.buf, src, partial) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Legitimate strncat() now 2 bytes shy of end. */
+	KUNIT_ASSERT_TRUE(test, strncat(pad.buf, src, partial) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Last two bytes should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* Add one more character to the end. */
+	KUNIT_ASSERT_TRUE(test, strncat(pad.buf, src, 1) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Last byte should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* And this one char will overflow. */
+	KUNIT_ASSERT_TRUE(test, strncat(pad.buf, src, 1) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
+	/* Last byte should be %NUL thanks to FORTIFY. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* And adding two will overflow more. */
+	KUNIT_ASSERT_TRUE(test, strncat(pad.buf, src, 2) == pad.buf);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+	/* Last byte should be %NUL thanks to FORTIFY. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Force an unterminated destination, and overflow. */
+	pad.buf[sizeof(pad.buf) - 1] = 'A';
+	KUNIT_ASSERT_TRUE(test, strncat(pad.buf, src, 1) == pad.buf);
+	/* This will have tripped both strlen() and strcat(). */
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 3);
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	/* But we should not go beyond the end. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+}
+
+static void strlcat_test(struct kunit *test)
+{
+	struct fortify_padding pad = { };
+	char src[sizeof(pad.buf)] = { };
+	int i, partial;
+	int len = sizeof(pad.buf) + unconst;
+
+	/* Fill 15 bytes with valid characters. */
+	partial = sizeof(src) / 2 - 1;
+	for (i = 0; i < partial; i++)
+		src[i] = i + 'A';
+
+	/* Destination is %NUL-filled to start with. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_before, 0);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Legitimate strlcat() using less than half max size. */
+	KUNIT_ASSERT_EQ(test, strlcat(pad.buf, src, len), partial);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Legitimate strlcat() now 2 bytes shy of end. */
+	KUNIT_ASSERT_EQ(test, strlcat(pad.buf, src, len), partial * 2);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Last two bytes should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* Add one more character to the end. */
+	KUNIT_ASSERT_EQ(test, strlcat(pad.buf, "Q", len), partial * 2 + 1);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
+	/* Last byte should be %NUL */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+
+	/* And this one char will overflow. */
+	KUNIT_ASSERT_EQ(test, strlcat(pad.buf, "V", len * 2), len);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
+	/* Last byte should be %NUL thanks to FORTIFY. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* And adding two will overflow more. */
+	KUNIT_ASSERT_EQ(test, strlcat(pad.buf, "QQ", len * 2), len + 1);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+	/* Last byte should be %NUL thanks to FORTIFY. */
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Force an unterminated destination, and overflow. */
+	pad.buf[sizeof(pad.buf) - 1] = 'A';
+	KUNIT_ASSERT_EQ(test, strlcat(pad.buf, "TT", len * 2), len + 2);
+	/* This will have tripped both strlen() and strlcat(). */
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	/* But we should not go beyond the end. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+
+	/* Force an unterminated source, and overflow. */
+	memset(src, 'B', sizeof(src));
+	pad.buf[sizeof(pad.buf) - 1] = '\0';
+	KUNIT_ASSERT_EQ(test, strlcat(pad.buf, src, len * 3), len - 1 + sizeof(src));
+	/* This will have tripped both strlen() and strlcat(). */
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 3);
+	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 3);
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
+	/* But we should not go beyond the end. */
+	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
+}
+
+static void memscan_test(struct kunit *test)
+{
+	char haystack[] = "Where oh where is my memory range?";
+	char *mem = haystack + strlen("Where oh where is ");
+	char needle = 'm';
+	size_t len = sizeof(haystack) + unconst;
+
+	KUNIT_ASSERT_PTR_EQ(test, memscan(haystack, needle, len),
+				  mem);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	/* Catch too-large range. */
+	KUNIT_ASSERT_PTR_EQ(test, memscan(haystack, needle, len + 1),
+				  NULL);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+	KUNIT_ASSERT_PTR_EQ(test, memscan(haystack, needle, len * 2),
+				  NULL);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+}
+
+static void memchr_test(struct kunit *test)
+{
+	char haystack[] = "Where oh where is my memory range?";
+	char *mem = haystack + strlen("Where oh where is ");
+	char needle = 'm';
+	size_t len = sizeof(haystack) + unconst;
+
+	KUNIT_ASSERT_PTR_EQ(test, memchr(haystack, needle, len),
+				  mem);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	/* Catch too-large range. */
+	KUNIT_ASSERT_PTR_EQ(test, memchr(haystack, needle, len + 1),
+				  NULL);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+	KUNIT_ASSERT_PTR_EQ(test, memchr(haystack, needle, len * 2),
+				  NULL);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+}
+
+static void memchr_inv_test(struct kunit *test)
+{
+	char haystack[] = "Where oh where is my memory range?";
+	char *mem = haystack + 1;
+	char needle = 'W';
+	size_t len = sizeof(haystack) + unconst;
+
+	/* Normal search is okay. */
+	KUNIT_ASSERT_PTR_EQ(test, memchr_inv(haystack, needle, len),
+				  mem);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	/* Catch too-large range. */
+	KUNIT_ASSERT_PTR_EQ(test, memchr_inv(haystack, needle, len + 1),
+				  NULL);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+	KUNIT_ASSERT_PTR_EQ(test, memchr_inv(haystack, needle, len * 2),
+				  NULL);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+}
+
+static void memcmp_test(struct kunit *test)
+{
+	char one[] = "My mind is going ...";
+	char two[] = "My mind is going ... I can feel it.";
+	size_t one_len = sizeof(one) + unconst - 1;
+	size_t two_len = sizeof(two) + unconst - 1;
+
+	/* We match the first string (ignoring the %NUL). */
+	KUNIT_ASSERT_EQ(test, memcmp(one, two, one_len), 0);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	/* Still in bounds, but no longer matching. */
+	KUNIT_ASSERT_EQ(test, memcmp(one, two, one_len + 1), -32);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+
+	/* Catch too-large ranges. */
+	KUNIT_ASSERT_EQ(test, memcmp(one, two, one_len + 2), INT_MIN);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+
+	KUNIT_ASSERT_EQ(test, memcmp(two, one, two_len + 2), INT_MIN);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+}
+
+static void kmemdup_test(struct kunit *test)
+{
+	char src[] = "I got Doom running on it!";
+	char *copy;
+	size_t len = sizeof(src) + unconst;
+
+	/* Copy is within bounds. */
+	copy = kmemdup(src, len, GFP_KERNEL);
+	KUNIT_EXPECT_NOT_NULL(test, copy);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	kfree(copy);
+
+	/* Without %NUL. */
+	copy = kmemdup(src, len - 1, GFP_KERNEL);
+	KUNIT_EXPECT_NOT_NULL(test, copy);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	kfree(copy);
+
+	/* Tiny bounds. */
+	copy = kmemdup(src, 1, GFP_KERNEL);
+	KUNIT_EXPECT_NOT_NULL(test, copy);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
+	kfree(copy);
+
+	/* Out of bounds by 1 byte. */
+	copy = kmemdup(src, len + 1, GFP_KERNEL);
+	KUNIT_EXPECT_NULL(test, copy);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 1);
+	kfree(copy);
+
+	/* Way out of bounds. */
+	copy = kmemdup(src, len * 2, GFP_KERNEL);
+	KUNIT_EXPECT_NULL(test, copy);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 2);
+	kfree(copy);
+
+	/* Starting offset causing out of bounds. */
+	copy = kmemdup(src + 1, len, GFP_KERNEL);
+	KUNIT_EXPECT_NULL(test, copy);
+	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 3);
+	kfree(copy);
+}
+
 static int fortify_test_init(struct kunit *test)
 {
 	if (!IS_ENABLED(CONFIG_FORTIFY_SOURCE))
@@ -373,6 +961,21 @@ static struct kunit_case fortify_test_cases[] = {
 	KUNIT_CASE(alloc_size_kvmalloc_dynamic_test),
 	KUNIT_CASE(alloc_size_devm_kmalloc_const_test),
 	KUNIT_CASE(alloc_size_devm_kmalloc_dynamic_test),
+	KUNIT_CASE(strlen_test),
+	KUNIT_CASE(strnlen_test),
+	KUNIT_CASE(strcpy_test),
+	KUNIT_CASE(strncpy_test),
+	KUNIT_CASE(strscpy_test),
+	KUNIT_CASE(strcat_test),
+	KUNIT_CASE(strncat_test),
+	KUNIT_CASE(strlcat_test),
+	/* skip memset: performs bounds checking on whole structs */
+	/* skip memcpy: still using warn-and-overwrite instead of hard-fail */
+	KUNIT_CASE(memscan_test),
+	KUNIT_CASE(memchr_test),
+	KUNIT_CASE(memchr_inv_test),
+	KUNIT_CASE(memcmp_test),
+	KUNIT_CASE(kmemdup_test),
 	{}
 };
 
-- 
2.34.1


