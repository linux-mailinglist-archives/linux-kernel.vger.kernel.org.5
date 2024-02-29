Return-Path: <linux-kernel+bounces-87532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34D986D593
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9792128C074
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7877374C14;
	Thu, 29 Feb 2024 20:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z/YtPWOV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8484874BF3;
	Thu, 29 Feb 2024 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240033; cv=none; b=QtLslsxsrDCbF0xY9RJL0nFDQGgD+T87ECUs/DnFA81nVta8LAohuss1e87OZ6Vtjbvv/ypHtwY/5Ow8NTcQPhihUdBtXYZLLSCK+mAsmGRCjK+4QIq2nPChN0ZTxukpZGfVlorSqOag991x72ItvY5Vd5VuwL3jUf7kdM2qoO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240033; c=relaxed/simple;
	bh=0PxrJHwdEBMibCHCJYxfY6Zu7U4zXuDyCEcHb9i/My8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r/CuuHIee0xYM5dqpA3dCsgWvc4XYB2veZXSiVPIKChRGWsW7+Bf1U/+uP3lNJlwm8cS2bVi78CT2UgSXT/xC2GPI8Q5N7OwvhaRMJpuVT8MUB16aioK20viKbmyMfw8pVs15b6dbzaW8Ov2bU+We4ZxhrhCiJNPC7XWkC4OodQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z/YtPWOV; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709240031; x=1740776031;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0PxrJHwdEBMibCHCJYxfY6Zu7U4zXuDyCEcHb9i/My8=;
  b=Z/YtPWOVYbgLYvhVZOGDH3rRxdOTgyGSldVGcKoV9BaUsOiHVyGhGXkj
   kZO8HFq9V+MUtKUzdcaFNwW90+RNOs0JgrPORCBHdtbU3a2MREJKCM7RP
   qSltt26DS2uz0t85tjhHaFJv+6jVdVpIBd2MUUhmltYVsVrkmeCHelm8E
   QJOySRNpymqIAaeGtskoxN63bcrcyhDBaPkQmMullhpuFX+OKpLF9N/Ae
   Irt70LWE1tOEDGSHRxoxJRIWhTuEa4hF62mgzpWy0kqtSZ92+QW1h7eSv
   dL8yJBqipZeJUP6q4cHutnxFYbz4OIwZNSDmXkIIELtjQJfaPSdAQNHnQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3919290"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3919290"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 12:53:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="937036397"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="937036397"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Feb 2024 12:53:48 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 247203BC; Thu, 29 Feb 2024 22:53:47 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v1 1/1] lib/string_helpers: Add flags param to string_get_size()
Date: Thu, 29 Feb 2024 22:52:30 +0200
Message-ID: <20240229205345.93902-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kent Overstreet <kent.overstreet@linux.dev>

The new flags parameter allows controlling
 - Whether or not the units suffix is separated by a space, for
   compatibility with sort -h
 - Whether or not to append a B suffix - we're not always printing
   bytes.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

My vesrion of https://lore.kernel.org/r/20240212213922.783301-2-surenb@google.com
Enjoy!

 include/linux/string_helpers.h | 10 ++++--
 lib/string_helpers.c           | 29 ++++++++-------
 lib/test-string_helpers.c      | 65 ++++++++++++++++++++++++++++------
 3 files changed, 78 insertions(+), 26 deletions(-)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 58fb1f90eda5..e93fbb5b0c01 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -17,14 +17,18 @@ static inline bool string_is_terminated(const char *s, int len)
 	return memchr(s, '\0', len) ? true : false;
 }
 
-/* Descriptions of the types of units to
- * print in */
+/* Descriptions of the types of units to print in */
 enum string_size_units {
 	STRING_UNITS_10,	/* use powers of 10^3 (standard SI) */
 	STRING_UNITS_2,		/* use binary powers of 2^10 */
+	STRING_UNITS_MASK	= BIT(0),
+
+	/* Modifiers */
+	STRING_UNITS_NO_SPACE	= BIT(30),
+	STRING_UNITS_NO_BYTES	= BIT(31),
 };
 
-int string_get_size(u64 size, u64 blk_size, enum string_size_units units,
+int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 		    char *buf, int len);
 
 int parse_int_array_user(const char __user *from, size_t count, int **array);
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 6bbafd6a10d9..69ba49b853c7 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -25,7 +25,7 @@
  * string_get_size - get the size in the specified units
  * @size:	The size to be converted in blocks
  * @blk_size:	Size of the block (use 1 for size in bytes)
- * @units:	units to use (powers of 1000 or 1024)
+ * @units:	Units to use (powers of 1000 or 1024), whether to include space separator
  * @buf:	buffer to format to
  * @len:	length of buffer
  *
@@ -39,11 +39,12 @@
 int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 		    char *buf, int len)
 {
+	enum string_size_units units_base = units & STRING_UNITS_MASK;
 	static const char *const units_10[] = {
-		"B", "kB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"
+		"", "k", "M", "G", "T", "P", "E", "Z", "Y",
 	};
 	static const char *const units_2[] = {
-		"B", "KiB", "MiB", "GiB", "TiB", "PiB", "EiB", "ZiB", "YiB"
+		"", "Ki", "Mi", "Gi", "Ti", "Pi", "Ei", "Zi", "Yi",
 	};
 	static const char *const *const units_str[] = {
 		[STRING_UNITS_10] = units_10,
@@ -68,7 +69,7 @@ int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 
 	/* This is Napier's algorithm.  Reduce the original block size to
 	 *
-	 * coefficient * divisor[units]^i
+	 * coefficient * divisor[units_base]^i
 	 *
 	 * we do the reduction so both coefficients are just under 32 bits so
 	 * that multiplying them together won't overflow 64 bits and we keep
@@ -78,12 +79,12 @@ int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 	 * precision is in the coefficients.
 	 */
 	while (blk_size >> 32) {
-		do_div(blk_size, divisor[units]);
+		do_div(blk_size, divisor[units_base]);
 		i++;
 	}
 
 	while (size >> 32) {
-		do_div(size, divisor[units]);
+		do_div(size, divisor[units_base]);
 		i++;
 	}
 
@@ -92,8 +93,8 @@ int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 	size *= blk_size;
 
 	/* and logarithmically reduce it until it's just under the divisor */
-	while (size >= divisor[units]) {
-		remainder = do_div(size, divisor[units]);
+	while (size >= divisor[units_base]) {
+		remainder = do_div(size, divisor[units_base]);
 		i++;
 	}
 
@@ -103,10 +104,10 @@ int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 	for (j = 0; sf_cap*10 < 1000; j++)
 		sf_cap *= 10;
 
-	if (units == STRING_UNITS_2) {
+	if (units_base == STRING_UNITS_2) {
 		/* express the remainder as a decimal.  It's currently the
 		 * numerator of a fraction whose denominator is
-		 * divisor[units], which is 1 << 10 for STRING_UNITS_2 */
+		 * divisor[units_base], which is 1 << 10 for STRING_UNITS_2 */
 		remainder *= 1000;
 		remainder >>= 10;
 	}
@@ -128,10 +129,12 @@ int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 	if (i >= ARRAY_SIZE(units_2))
 		unit = "UNK";
 	else
-		unit = units_str[units][i];
+		unit = units_str[units_base][i];
 
-	return snprintf(buf, len, "%u%s %s", (u32)size,
-			tmp, unit);
+	return snprintf(buf, len, "%u%s%s%s%s", (u32)size, tmp,
+			(units & STRING_UNITS_NO_SPACE) ? "" : " ",
+			unit,
+			(units & STRING_UNITS_NO_BYTES) ? "" : "B");
 }
 EXPORT_SYMBOL(string_get_size);
 
diff --git a/lib/test-string_helpers.c b/lib/test-string_helpers.c
index 9a68849a5d55..dce67698297b 100644
--- a/lib/test-string_helpers.c
+++ b/lib/test-string_helpers.c
@@ -3,6 +3,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/array_size.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -500,21 +501,65 @@ static __init void test_string_get_size_check(const char *units,
 	pr_warn("expected: '%s', got '%s'\n", exp, res);
 }
 
+static __init void __strchrcut(char *dst, const char *src, const char *cut)
+{
+	const char *from = src;
+	size_t len;
+
+	do {
+		len = strcspn(from, cut);
+		memcpy(dst, from, len);
+		dst += len;
+		from += len;
+	} while (*from++);
+	*dst = '\0';
+}
+
+static __init void __test_string_get_size_one(const u64 size, const u64 blk_size,
+					      const char *exp_result10,
+					      const char *exp_result2,
+					      enum string_size_units units,
+					      const char *cut)
+{
+	char buf10[string_get_size_maxbuf];
+	char buf2[string_get_size_maxbuf];
+	char exp10[string_get_size_maxbuf];
+	char exp2[string_get_size_maxbuf];
+	char prefix10[64];
+	char prefix2[64];
+
+	sprintf(prefix10, "STRING_UNITS_10 [%s]", cut);
+	sprintf(prefix2, "STRING_UNITS_2 [%s]", cut);
+
+	__strchrcut(exp10, exp_result10, cut);
+	__strchrcut(exp2, exp_result2, cut);
+
+	string_get_size(size, blk_size, STRING_UNITS_10 | units, buf10, sizeof(buf10));
+	string_get_size(size, blk_size, STRING_UNITS_2 | units, buf2, sizeof(buf2));
+
+	test_string_get_size_check(prefix10, exp10, buf10, size, blk_size);
+	test_string_get_size_check(prefix2, exp2, buf2, size, blk_size);
+}
+
 static __init void __test_string_get_size(const u64 size, const u64 blk_size,
 					  const char *exp_result10,
 					  const char *exp_result2)
 {
-	char buf10[string_get_size_maxbuf];
-	char buf2[string_get_size_maxbuf];
+	struct {
+		enum string_size_units units;
+		const char *cut;
+	} get_size_test_cases[] = {
+		{ 0, "" },
+		{ STRING_UNITS_NO_SPACE, " " },
+		{ STRING_UNITS_NO_SPACE | STRING_UNITS_NO_BYTES, " B" },
+		{ STRING_UNITS_NO_BYTES, "B" },
+	};
+	int i;
 
-	string_get_size(size, blk_size, STRING_UNITS_10, buf10, sizeof(buf10));
-	string_get_size(size, blk_size, STRING_UNITS_2, buf2, sizeof(buf2));
-
-	test_string_get_size_check("STRING_UNITS_10", exp_result10, buf10,
-				   size, blk_size);
-
-	test_string_get_size_check("STRING_UNITS_2", exp_result2, buf2,
-				   size, blk_size);
+	for (i = 0; i < ARRAY_SIZE(get_size_test_cases); i++)
+		__test_string_get_size_one(size, blk_size, exp_result10, exp_result2,
+					   get_size_test_cases[i].units,
+					   get_size_test_cases[i].cut);
 }
 
 static __init void test_string_get_size(void)
-- 
2.43.0.rc1.1.gbec44491f096


