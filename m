Return-Path: <linux-kernel+bounces-70561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB93585992A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16662B2119C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6106745D8;
	Sun, 18 Feb 2024 19:51:40 +0000 (UTC)
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E9D7319A
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708285900; cv=none; b=dLvai4KIONbkN59Nk3zgFL2bQEuzeIAJr94bxDDZf7ZXnfFo+EQ3Noi62PKAiN/DNoJ1SGDU2v6vs92szg+omCJ/EqTH7PhkZ9mbYooD0kzofuBwtomvE3vRw3BFzHPr98jf7INK+YmPVV0hx3AO4wi5itouSDdpnEh32UgHJxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708285900; c=relaxed/simple;
	bh=9RVmOlD4OgrvSuTTroVq8lj5KRTmT9fr3g11wmsxIZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdUqKgOBMwh+cHWGnGIIwF/WUwcXtSdTSqjGK/t/tLzQakldjxD4ysSXdqQ4hzEo7IVvSGh6g02c/8dM9KP0uwjPm1BctI/VHn26vEpIlw4ZVWEMtOpXCpXZ4e4DcgKUZ1re/fDE0GHEyuFySLGZE5rN/rz/+dTmrbJD78p+aKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar; spf=pass smtp.mailfrom=sdfg.com.ar; arc=none smtp.client-ip=49.12.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdfg.com.ar
Received: from lindsay.fibertel.com.ar
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Sun, 18 Feb 2024 19:51:36 +0000
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org,
	Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH v3 4/4] selftests/nolibc: Add tests for strlcat() and strlcpy()
Date: Sun, 18 Feb 2024 16:51:06 -0300
Message-ID: <20240218195110.1386840-5-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240218195110.1386840-1-rodrigo@sdfg.com.ar>
References: <20240218195110.1386840-1-rodrigo@sdfg.com.ar>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've verified that the tests matches libbsd's strlcat()/strlcpy()
implementation.

Please note that as strlcat()/strlcpy() are not part of the libc, the
tests are only compiled when using nolibc.

Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 40 ++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 6ba4f8275ac4..d373fc14706c 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -600,6 +600,25 @@ int expect_strne(const char *expr, int llen, const char *cmp)
 	return ret;
 }
 
+#define EXPECT_STRBUFEQ(cond, expr, buf, val, cmp)				\
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_str_buf_eq(expr, buf, val, llen, cmp); } while (0)
+
+static __attribute__((unused))
+int expect_str_buf_eq(size_t expr, const char *buf, size_t val, int llen, const char *cmp)
+{
+	llen += printf(" = %lu <%s> ", expr, buf);
+	if (strcmp(buf, cmp) != 0) {
+		result(llen, FAIL);
+		return 1;
+	}
+	if (expr != val) {
+		result(llen, FAIL);
+		return 1;
+	}
+
+	result(llen, OK);
+	return 0;
+}
 
 /* declare tests based on line numbers. There must be exactly one test per line. */
 #define CASE_TEST(name) \
@@ -991,6 +1010,14 @@ int run_stdlib(int min, int max)
 	for (test = min; test >= 0 && test <= max; test++) {
 		int llen = 0; /* line length */
 
+		/* For functions that take a long buffer, like strlcat()
+		 * Add some more chars after the \0, to test functions that overwrite the buffer set
+		 * the \0 at the exact right position.
+		 */
+		char buf[10] = "test123456";
+		buf[4] = '\0';
+
+
 		/* avoid leaving empty lines below, this will insert holes into
 		 * test numbers.
 		 */
@@ -1007,6 +1034,19 @@ int run_stdlib(int min, int max)
 		CASE_TEST(strchr_foobar_z);    EXPECT_STRZR(1, strchr("foobar", 'z')); break;
 		CASE_TEST(strrchr_foobar_o);   EXPECT_STREQ(1, strrchr("foobar", 'o'), "obar"); break;
 		CASE_TEST(strrchr_foobar_z);   EXPECT_STRZR(1, strrchr("foobar", 'z')); break;
+#ifdef NOLIBC
+		CASE_TEST(strlcat_0);          EXPECT_STRBUFEQ(1, strlcat(buf, "bar", 0), buf, 3, "test"); break;
+		CASE_TEST(strlcat_1);          EXPECT_STRBUFEQ(1, strlcat(buf, "bar", 1), buf, 4, "test"); break;
+		CASE_TEST(strlcat_5);          EXPECT_STRBUFEQ(1, strlcat(buf, "bar", 5), buf, 7, "test"); break;
+		CASE_TEST(strlcat_6);          EXPECT_STRBUFEQ(1, strlcat(buf, "bar", 6), buf, 7, "testb"); break;
+		CASE_TEST(strlcat_7);          EXPECT_STRBUFEQ(1, strlcat(buf, "bar", 7), buf, 7, "testba"); break;
+		CASE_TEST(strlcat_8);          EXPECT_STRBUFEQ(1, strlcat(buf, "bar", 8), buf, 7, "testbar"); break;
+		CASE_TEST(strlcpy_0);          EXPECT_STRBUFEQ(1, strlcpy(buf, "bar", 0), buf, 3, "test"); break;
+		CASE_TEST(strlcpy_1);          EXPECT_STRBUFEQ(1, strlcpy(buf, "bar", 1), buf, 3, ""); break;
+		CASE_TEST(strlcpy_2);          EXPECT_STRBUFEQ(1, strlcpy(buf, "bar", 2), buf, 3, "b"); break;
+		CASE_TEST(strlcpy_3);          EXPECT_STRBUFEQ(1, strlcpy(buf, "bar", 3), buf, 3, "ba"); break;
+		CASE_TEST(strlcpy_4);          EXPECT_STRBUFEQ(1, strlcpy(buf, "bar", 4), buf, 3, "bar"); break;
+#endif
 		CASE_TEST(memcmp_20_20);       EXPECT_EQ(1, memcmp("aaa\x20", "aaa\x20", 4), 0); break;
 		CASE_TEST(memcmp_20_60);       EXPECT_LT(1, memcmp("aaa\x20", "aaa\x60", 4), 0); break;
 		CASE_TEST(memcmp_60_20);       EXPECT_GT(1, memcmp("aaa\x60", "aaa\x20", 4), 0); break;
-- 
2.43.0


