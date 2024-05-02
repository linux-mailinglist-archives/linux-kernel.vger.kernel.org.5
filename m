Return-Path: <linux-kernel+bounces-166852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0F18BA0DD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7862288846
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F78117B519;
	Thu,  2 May 2024 19:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6LxMgyN"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EAD1635A2
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 19:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714676557; cv=none; b=NZ3Pe4YHDxwQ9yjBk3bQ62F0TnDd0PclcEpsijqQf67OdDPLYBUIWwEyqKO/tRhGFl6mlK4GcGzfUhQf6rYis9HKZG8DPR0aj87wJlc7braL53chfj+s7YtYJGwQnSsvmXHtXjKyqndI4DSewLxEI5t5nOC7fOmRHfuPSKOrcn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714676557; c=relaxed/simple;
	bh=98jStbeoB0+s7xM+AeYYTBiMnjWT7Biqyj3FGw4vpOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuATdCy6acZG60LwelSH83r6B4Ns1MhfWZMl0/mOIsCzgl/cssWymiPu1C0pUEwNuMtZR3M/SZBeet8aQwlWArSfWOoz24JgeqTNJKsY2si6T1fSBraRKHOswFmvgfx3mHYln2hTlANADkljq1J1sL3Go+sDJ0NRo8JGkVDKJzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6LxMgyN; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-43ab2b2f11bso14845411cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 12:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714676554; x=1715281354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7eQcQPlLfPoF1F7OxifffHm/SsC0VJeyg2xs0tjwD8=;
        b=d6LxMgyNGFwnVleo2zx9VHl1++t2yYDfJ8dg5iq1pHYmPz5sFAmamdW5dDogWpOVfg
         o2hHiphlgcE04Jjnl9Gtb27UNoovZVmo0JFJpMh5Lsbn5mM5nrnjTEIyFCC+vgvc3WQd
         xAsI4wOTpy8tBQvf99gEqk/mVGb+lCq2Blgarkfy48gSrLBkbHAUARsDG+aBnNNRLC86
         AD8gDnsWT538m3oU686g8a8ZA5zLRopah2E6dNzzIlH6lZfwwbtpjG3F5tRRxMVpZv6P
         +f1LLZeO/kC0L/PLMY6NfV0kzZqk9p+T8HttvvYbTPbNh6VxKS2mwXCHoeMBWJzcndO2
         pE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714676554; x=1715281354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7eQcQPlLfPoF1F7OxifffHm/SsC0VJeyg2xs0tjwD8=;
        b=UMm+gedJsZuyVBkAvGmxG9KAWXcJXEQe8vVOMRNPdxg5ncCvjYJEoadhEL390fgPGO
         jOYmSmM0jGNJtx3rsHGUUvo71p2pQAmJ8oDdOlfa9lFcFN7xScjzx5mA80GpTiPvHx5q
         DT3o1BsrDFRgjLdJhFKP9xK/Dhc928DFV12+HqULHiJkToKp3i2X4X2Z5bE9G29ZQwIz
         fUXc+G675ESFGVtl44y3TH5frHO91xDzdftmsaLPbnXzz4whcqmukfhJjqbNVPyMYS0J
         S8IPaqp3VaQr20y3LD6b6SNYDazSP0KIY0yIhavX7ryD6eFpPX2WnzyhVY6JYGFlc7yX
         D2jA==
X-Forwarded-Encrypted: i=1; AJvYcCXedjICqBRZFtU1NwZBlPbXcDQebGHYHyxv2N5xWVbPVFDQ8FWC4uUZnvkiKIycAj66NS6tMh3TUlQUWrly6HFjt5xqDRBSgo4uvA+i
X-Gm-Message-State: AOJu0YwwoZZO0lsarjB6gQ0kOFjK7bR3M+/iTpYyrlW72/XQGAjwCwqd
	1XfUk6TKXK2ZPdM8pKt2nc+su1vSoK4a8DR6Yu5jZymtAp/mjLhN
X-Google-Smtp-Source: AGHT+IG+vh405FIs2xF2Ei9F+WVe3rZDH8UmyV2+XlPjV5yMR1Q0m/xNIXBzcVWijqXvA2+J6ynj8w==
X-Received: by 2002:ac8:7d83:0:b0:439:a719:702e with SMTP id c3-20020ac87d83000000b00439a719702emr485958qtd.54.1714676554441;
        Thu, 02 May 2024 12:02:34 -0700 (PDT)
Received: from localhost (fwdproxy-nao-000.fbsv.net. [2a03:2880:23ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id bb20-20020a05622a1b1400b0043cc0583dd3sm602970qtb.50.2024.05.02.12.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 12:02:34 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v2 1/1] selftests: cgroup: add tests to verify the zswap writeback path
Date: Thu,  2 May 2024 19:58:37 +0100
Message-ID: <20240502190223.3975970-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240502190223.3975970-1-usamaarif642@gmail.com>
References: <20240502190223.3975970-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initate writeback with the below steps and check using
memory.stat.zswpwb if zswap writeback occurred:
1. Allocate memory.
2. Reclaim memory equal to the amount that was allocated in step 1.
   This will move it into zswap.
3. Save current zswap usage.
4. Move the memory allocated in step 1 back in from zswap.
5. Set zswap.max to half the amount that was recorded in step 3.
6. Attempt to reclaim memory equal to the amount that was allocated,
   this will either trigger writeback if its enabled, or reclamation
   will fail if writeback is disabled as there isn't enough zswap
   space.

Suggested-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 tools/testing/selftests/cgroup/test_zswap.c | 125 +++++++++++++++++++-
 1 file changed, 124 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index f0e488ed90d8..cd864ab825d0 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -50,7 +50,7 @@ static int get_zswap_stored_pages(size_t *value)
 	return read_int("/sys/kernel/debug/zswap/stored_pages", value);
 }
 
-static int get_cg_wb_count(const char *cg)
+static long get_cg_wb_count(const char *cg)
 {
 	return cg_read_key_long(cg, "memory.stat", "zswpwb");
 }
@@ -248,6 +248,127 @@ static int test_zswapin(const char *root)
 	return ret;
 }
 
+/*
+ * Initate writeback with the following steps:
+ * 1. Allocate memory.
+ * 2. Reclaim memory equal to the amount that was allocated in step 1.
+      This will move it into zswap.
+ * 3. Save current zswap usage.
+ * 4. Move the memory allocated in step 1 back in from zswap.
+ * 5. Set zswap.max to half the amount that was recorded in step 3.
+ * 6. Attempt to reclaim memory equal to the amount that was allocated,
+      this will either trigger writeback if its enabled, or reclamation
+      will fail if writeback is disabled as there isn't enough zswap space.
+ */
+static int initiate_writeback(const char *cgroup, void *arg)
+{
+	char *test_group = arg;
+	size_t memsize = MB(4);
+	int ret = -1;
+	bool wb_enabled = cg_read_long(test_group, "memory.zswap.writeback");
+	long zswap_usage;
+
+	if (cg_write(test_group, "memory.max", "8M"))
+		return ret;
+
+	/* Allocate random memory to enusre high zswap memory usage */
+	char *mem = (char *)malloc(memsize);
+
+	if (!mem)
+		return ret;
+	for (int i = 0; i < memsize; i++)
+		mem[i] = rand() % 128;
+
+	/* Try and reclaim allocated memory */
+	if (cg_write(test_group, "memory.reclaim", "4M")) {
+		ksft_print_msg("Failed to reclaim all of the requested memory\n");
+		goto out;
+	}
+
+	zswap_usage = cg_read_long(test_group, "memory.zswap.current");
+
+	/* zswpin */
+	for (int i = 0; i < memsize; i++) {
+		if (mem[i] < 0 || mem[i] > 127) {
+			ksft_print_msg("invalid memory\n");
+			ret = -1;
+		}
+	}
+
+	if (cg_write_numeric(test_group, "memory.zswap.max", zswap_usage/2))
+		goto out;
+
+	/*
+	 * If writeback is enabled, trying to reclaim memory now will trigger a
+	 * writeback as zswap.max is half of what was needed when reclaim ran the first time.
+	 * If writeback is disabled, memory reclaim will fail as zswap is limited and
+	 * it can't writeback to swap.
+	 */
+	ret = cg_write(test_group, "memory.reclaim", "4M");
+	if (!wb_enabled && ret)
+		ret = 0;
+out:
+	free(mem);
+	return ret;
+}
+
+/* Test to verify the zswap writeback path */
+static int test_zswap_writeback(const char *root, bool wb)
+{
+	int ret = KSFT_FAIL;
+	char *test_group;
+	long zswpwb_before, zswpwb_after;
+
+	test_group = cg_name(root,
+		wb ? "zswap_writeback_enabled_test" : "zswap_writeback_disabled_test");
+	if (!test_group)
+		goto out;
+	if (cg_create(test_group))
+		goto out;
+	if (cg_write(test_group, "memory.zswap.writeback", wb ? "1" : "0"))
+		return ret;
+
+	zswpwb_before = get_cg_wb_count(test_group);
+	if (zswpwb_before < 0) {
+		ksft_print_msg("failed to get zswpwb_before\n");
+		goto out;
+	}
+
+	if (cg_run(test_group, initiate_writeback, (void *) test_group))
+		goto out;
+
+	/* Verify that zswap writeback occurred only if writeback was enabled */
+	zswpwb_after = get_cg_wb_count(test_group);
+	if (wb) {
+		if (zswpwb_after <= zswpwb_before) {
+			ksft_print_msg("writeback enabled and zswpwb_after <= zswpwb_before\n");
+			goto out;
+		}
+	} else {
+		if (zswpwb_after != zswpwb_before) {
+			ksft_print_msg("writeback disabled and zswpwb_after != zswpwb_before\n");
+			goto out;
+		}
+	}
+
+	ret = KSFT_PASS;
+
+out:
+	cg_destroy(test_group);
+	free(test_group);
+	return ret;
+}
+
+static int test_zswap_writeback_enabled(const char *root)
+{
+	return test_zswap_writeback(root, true);
+}
+
+static int test_zswap_writeback_disabled(const char *root)
+{
+	return test_zswap_writeback(root, false);
+}
+
 /*
  * When trying to store a memcg page in zswap, if the memcg hits its memory
  * limit in zswap, writeback should affect only the zswapped pages of that
@@ -425,6 +546,8 @@ struct zswap_test {
 	T(test_zswap_usage),
 	T(test_swapin_nozswap),
 	T(test_zswapin),
+	T(test_zswap_writeback_enabled),
+	T(test_zswap_writeback_disabled),
 	T(test_no_kmem_bypass),
 	T(test_no_invasive_cgroup_shrink),
 };
-- 
2.43.0


