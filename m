Return-Path: <linux-kernel+bounces-147671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1E38A7789
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441E2283398
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707F47FBB4;
	Tue, 16 Apr 2024 22:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xl1LWWpw"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5959C84E15
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 22:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713305414; cv=none; b=u8zcQoeb4NpKWOxqg41LEOp4hTOQ9mUz/xR42XDud4QSPrEYCo/YFQrAd3NUy0MDXiISonFkSoq5rE2mBPXZ3CFxihno8u42TNaXXsaFgnZ7pz/GRkWCjkVce3s1LWR55EogDkphxnsvyvvXULgmiX+bQliNKo/5SmoE1/QbOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713305414; c=relaxed/simple;
	bh=8NXDtHH8ESFrFF212SeskdsTuZM6saoB/YlA1jmZHxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9lyPx0XXoqS8uX5eqiEDcMzIBwbJ2TLJ0M8DQNEq4edyj2hd69PCsgt5ZDsfSdA43bT8FQxMR2StEaHGlAore54dE1fOh3aeAgtBfsM26q/MXPZtpwkSLGrQdSBdCvJSKaooTV2Sk8nyJUD602BNyaubdIjf0SnvUyCbQhE+sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xl1LWWpw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e51398cc4eso46143205ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713305411; x=1713910211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxVHDOvUhVBVzAOb5wpvBaQ8ZT8i2HrkTBsI4fhOGcg=;
        b=Xl1LWWpwbChGOjg6qjjBXMLkrtJGRy/8TqIVfY1EsQ6Svw/VgwM0TZTTKjnTHWLw4v
         U0kbRdc9MqWhsBUdtl81peMlb18W8ct0lTqJJHfGGaf8l4SenzJhpA/FkI7HxAFlnsSX
         Zh/jjf28EtH4XtS1E3Gnp8PLHZ+1MouVoXhow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713305411; x=1713910211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxVHDOvUhVBVzAOb5wpvBaQ8ZT8i2HrkTBsI4fhOGcg=;
        b=tMvXt+7BXjHRZSSd+BltLxgYYCEBafa2mmIuUObkkP8WgmWX+Ox54Rj4mnESQEmKF0
         YdTG3l5ynE55bdMMw0jC0mo06JaL+VoIXWHy25AoL1cBijnvOlEgQkwvhEuyXijn4uAX
         S0hZ81mXBtisQrmJNslK6HtVMFSFZX34fDbFVPQXbYl2LVmquJ+IxiSyHIlHS4PbG/bJ
         6rvj8TDasJpCmiDTjSUdVMS6Y6Yb48KzCvE4ltKzrr29VC/wTeGD2AJU0zX9y42Ikado
         SMG80Jvamw/uA2tyVWteJ/HrW9VYHqx/k0+v7WaSd70bhHiKAZWN8zCmqhHyGXhL8Q7L
         hwlw==
X-Forwarded-Encrypted: i=1; AJvYcCVcDt7izC3XUez9mffzRF+dN9oxRBRaAxyAWrGl4C3ED5fexLWe/k8wB26znjFuhwSi8DRF+q+0eXunGnYdZ6vtr5Do980+rlFLQxKg
X-Gm-Message-State: AOJu0YylKu0lX5YEbM7x0a6fXD2ZSBKzs5oazNNTwBffjFfnXT3uJCQQ
	YsHSoSiGsR2e0Cf3BFWltgkv6tDkKkyF299nOpBOB3lp3+ctdG8CoOmVb7kTIQ==
X-Google-Smtp-Source: AGHT+IFOSdcgQyk6biwC2aPuWcLWnlux4DGUDewTmrRbyQvQfiiI+29eaaKEia9vvpDMeLIYZhwYKQ==
X-Received: by 2002:a17:903:1245:b0:1e7:8686:c37b with SMTP id u5-20020a170903124500b001e78686c37bmr7826165plh.22.1713305411466;
        Tue, 16 Apr 2024 15:10:11 -0700 (PDT)
Received: from localhost (15.4.198.104.bc.googleusercontent.com. [104.198.4.15])
        by smtp.gmail.com with UTF8SMTPSA id d10-20020a170902ceca00b001e41e968a61sm10246065plg.223.2024.04.16.15.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 15:10:11 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	usama.anjum@collabora.com
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jannh@google.com,
	sroettger@google.com,
	pedro.falcato@gmail.com,
	dave.hansen@intel.com,
	linux-hardening@vger.kernel.org,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	deraadt@openbsd.org,
	corbet@lwn.net,
	Liam.Howlett@oracle.com,
	surenb@google.com,
	merimus@google.com,
	rdunlap@infradead.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH 1/1] selftest mm/mseal: style change
Date: Tue, 16 Apr 2024 22:09:44 +0000
Message-ID: <20240416220944.2481203-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
In-Reply-To: <20240416220944.2481203-1-jeffxu@chromium.org>
References: <20240416220944.2481203-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

remove "assert" from testcase.
remove "return 0"

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Suggested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/mseal_test.c | 124 +++++++++++++++++-------
 tools/testing/selftests/mm/seal_elf.c   |   3 -
 2 files changed, 91 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 06c780d1d8e5..4a326334726d 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -12,9 +12,7 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <assert.h>
 #include <fcntl.h>
-#include <assert.h>
 #include <sys/ioctl.h>
 #include <sys/vfs.h>
 #include <sys/stat.h>
@@ -189,7 +187,6 @@ static void __write_pkey_reg(u64 pkey_reg)
 
 	asm volatile(".byte 0x0f,0x01,0xef\n\t"
 			: : "a" (eax), "c" (ecx), "d" (edx));
-	assert(pkey_reg == __read_pkey_reg());
 #endif
 }
 
@@ -214,7 +211,6 @@ static void set_pkey(int pkey, unsigned long pkey_value)
 	unsigned long mask = (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE);
 	u64 new_pkey_reg;
 
-	assert(!(pkey_value & ~mask));
 	new_pkey_reg = set_pkey_bits(__read_pkey_reg(), pkey, pkey_value);
 	__write_pkey_reg(new_pkey_reg);
 }
@@ -224,7 +220,6 @@ static void setup_single_address(int size, void **ptrOut)
 	void *ptr;
 
 	ptr = sys_mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-	assert(ptr != (void *)-1);
 	*ptrOut = ptr;
 }
 
@@ -234,24 +229,21 @@ static void setup_single_address_rw(int size, void **ptrOut)
 	unsigned long mapflags = MAP_ANONYMOUS | MAP_PRIVATE;
 
 	ptr = sys_mmap(NULL, size, PROT_READ | PROT_WRITE, mapflags, -1, 0);
-	assert(ptr != (void *)-1);
 	*ptrOut = ptr;
 }
 
-static void clean_single_address(void *ptr, int size)
+static int clean_single_address(void *ptr, int size)
 {
 	int ret;
-
 	ret = munmap(ptr, size);
-	assert(!ret);
+	return ret;
 }
 
-static void seal_single_address(void *ptr, int size)
+static int seal_single_address(void *ptr, int size)
 {
 	int ret;
-
 	ret = sys_mseal(ptr, size);
-	assert(!ret);
+	return ret;
 }
 
 bool seal_support(void)
@@ -290,6 +282,7 @@ static void test_seal_addseal(void)
 	unsigned long size = 4 * page_size;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	ret = sys_mseal(ptr, size);
 	FAIL_TEST_IF_FALSE(!ret);
@@ -305,6 +298,7 @@ static void test_seal_unmapped_start(void)
 	unsigned long size = 4 * page_size;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	/* munmap 2 pages from ptr. */
 	ret = sys_munmap(ptr, 2 * page_size);
@@ -332,6 +326,7 @@ static void test_seal_unmapped_middle(void)
 	unsigned long size = 4 * page_size;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	/* munmap 2 pages from ptr + page. */
 	ret = sys_munmap(ptr + page_size, 2 * page_size);
@@ -363,6 +358,7 @@ static void test_seal_unmapped_end(void)
 	unsigned long size = 4 * page_size;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	/* unmap last 2 pages. */
 	ret = sys_munmap(ptr + 2 * page_size, 2 * page_size);
@@ -391,6 +387,7 @@ static void test_seal_multiple_vmas(void)
 	unsigned long size = 4 * page_size;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	/* use mprotect to split the vma into 3. */
 	ret = sys_mprotect(ptr + page_size, 2 * page_size,
@@ -421,6 +418,7 @@ static void test_seal_split_start(void)
 	unsigned long size = 4 * page_size;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	/* use mprotect to split at middle */
 	ret = sys_mprotect(ptr, 2 * page_size, PROT_READ | PROT_WRITE);
@@ -445,6 +443,7 @@ static void test_seal_split_end(void)
 	unsigned long size = 4 * page_size;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	/* use mprotect to split at middle */
 	ret = sys_mprotect(ptr, 2 * page_size, PROT_READ | PROT_WRITE);
@@ -469,7 +468,9 @@ static void test_seal_invalid_input(void)
 	int ret;
 
 	setup_single_address(8 * page_size, &ptr);
-	clean_single_address(ptr + 4 * page_size, 4 * page_size);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+	ret = clean_single_address(ptr + 4 * page_size, 4 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
 
 	/* invalid flag */
 	ret = syscall(__NR_mseal, ptr, size, 0x20);
@@ -502,6 +503,7 @@ static void test_seal_zero_length(void)
 	int ret;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	ret = sys_mprotect(ptr, 0, PROT_READ | PROT_WRITE);
 	FAIL_TEST_IF_FALSE(!ret);
@@ -551,6 +553,7 @@ static void test_seal_twice(void)
 	unsigned long size = 4 * page_size;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	ret = sys_mseal(ptr, size);
 	FAIL_TEST_IF_FALSE(!ret);
@@ -570,9 +573,12 @@ static void test_seal_mprotect(bool seal)
 	int ret;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
-	if (seal)
-		seal_single_address(ptr, size);
+	if (seal) {
+		ret = seal_single_address(ptr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
 
 	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
 	if (seal)
@@ -591,9 +597,12 @@ static void test_seal_start_mprotect(bool seal)
 	int ret;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
-	if (seal)
-		seal_single_address(ptr, page_size);
+	if (seal) {
+		ret = seal_single_address(ptr, page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
 
 	/* the first page is sealed. */
 	ret = sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
@@ -618,9 +627,12 @@ static void test_seal_end_mprotect(bool seal)
 	int ret;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
-	if (seal)
-		seal_single_address(ptr + page_size, 3 * page_size);
+	if (seal) {
+		ret = seal_single_address(ptr + page_size, 3 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
 
 	/* first page is not sealed */
 	ret = sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
@@ -645,9 +657,12 @@ static void test_seal_mprotect_unalign_len(bool seal)
 	int ret;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
-	if (seal)
-		seal_single_address(ptr, page_size * 2 - 1);
+	if (seal) {
+		ret = seal_single_address(ptr, page_size * 2 - 1);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
 
 	/* 2 pages are sealed. */
 	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
@@ -671,8 +686,11 @@ static void test_seal_mprotect_unalign_len_variant_2(bool seal)
 	int ret;
 
 	setup_single_address(size, &ptr);
-	if (seal)
-		seal_single_address(ptr, page_size * 2 + 1);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+	if (seal) {
+		ret =  seal_single_address(ptr, page_size * 2 + 1);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
 
 	/* 3 pages are sealed. */
 	ret = sys_mprotect(ptr, page_size * 3, PROT_READ | PROT_WRITE);
@@ -696,13 +714,16 @@ static void test_seal_mprotect_two_vma(bool seal)
 	int ret;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	/* use mprotect to split */
 	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
 	FAIL_TEST_IF_FALSE(!ret);
 
-	if (seal)
-		seal_single_address(ptr, page_size * 4);
+	if (seal) {
+		ret = seal_single_address(ptr, page_size * 4);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
 
 	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
 	if (seal)
@@ -728,14 +749,17 @@ static void test_seal_mprotect_two_vma_with_split(bool seal)
 	int ret;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	/* use mprotect to split as two vma. */
 	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
 	FAIL_TEST_IF_FALSE(!ret);
 
 	/* mseal can apply across 2 vma, also split them. */
-	if (seal)
-		seal_single_address(ptr + page_size, page_size * 2);
+	if (seal) {
+		ret = seal_single_address(ptr + page_size, page_size * 2);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
 
 	/* the first page is not sealed. */
 	ret = sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
@@ -772,10 +796,13 @@ static void test_seal_mprotect_partial_mprotect(bool seal)
 	int ret;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	/* seal one page. */
-	if (seal)
-		seal_single_address(ptr, page_size);
+	if (seal) {
+		ret = seal_single_address(ptr, page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
 
 	/* mprotect first 2 page will fail, since the first page are sealed. */
 	ret = sys_mprotect(ptr, 2 * page_size, PROT_READ | PROT_WRITE);
@@ -795,6 +822,7 @@ static void test_seal_mprotect_two_vma_with_gap(bool seal)
 	int ret;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	/* use mprotect to split. */
 	ret = sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
@@ -837,6 +865,7 @@ static void test_seal_mprotect_split(bool seal)
 	int ret;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	/* use mprotect to split. */
 	ret = sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
@@ -873,6 +902,7 @@ static void test_seal_mprotect_merge(bool seal)
 	int ret;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	/* use mprotect to split one page. */
 	ret = sys_mprotect(ptr, page_size, PROT_READ | PROT_WRITE);
@@ -906,6 +936,7 @@ static void test_seal_munmap(bool seal)
 	int ret;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	if (seal) {
 		ret = sys_mseal(ptr, size);
@@ -936,6 +967,7 @@ static void test_seal_munmap_two_vma(bool seal)
 	int ret;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	/* use mprotect to split */
 	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
@@ -976,6 +1008,7 @@ static void test_seal_munmap_vma_with_gap(bool seal)
 	int ret;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	ret = sys_munmap(ptr + page_size, page_size * 2);
 	FAIL_TEST_IF_FALSE(!ret);
@@ -1007,6 +1040,7 @@ static void test_munmap_start_freed(bool seal)
 	int prot;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	/* unmap the first page. */
 	ret = sys_munmap(ptr, page_size);
@@ -1045,6 +1079,8 @@ static void test_munmap_end_freed(bool seal)
 	int ret;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
 	/* unmap last page. */
 	ret = sys_munmap(ptr + page_size * 3, page_size);
 	FAIL_TEST_IF_FALSE(!ret);
@@ -1074,6 +1110,8 @@ static void test_munmap_middle_freed(bool seal)
 	int prot;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
 	/* unmap 2 pages in the middle. */
 	ret = sys_munmap(ptr + page_size, page_size * 2);
 	FAIL_TEST_IF_FALSE(!ret);
@@ -1116,6 +1154,7 @@ static void test_seal_mremap_shrink(bool seal)
 	void *ret2;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	if (seal) {
 		ret = sys_mseal(ptr, size);
@@ -1144,6 +1183,7 @@ static void test_seal_mremap_expand(bool seal)
 	void *ret2;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 	/* ummap last 2 pages. */
 	ret = sys_munmap(ptr + 2 * page_size, 2 * page_size);
 	FAIL_TEST_IF_FALSE(!ret);
@@ -1175,8 +1215,11 @@ static void test_seal_mremap_move(bool seal)
 	void *ret2;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 	setup_single_address(size, &newPtr);
-	clean_single_address(newPtr, size);
+	FAIL_TEST_IF_FALSE(newPtr != (void *)-1);
+	ret = clean_single_address(newPtr, size);
+	FAIL_TEST_IF_FALSE(!ret);
 
 	if (seal) {
 		ret = sys_mseal(ptr, size);
@@ -1205,6 +1248,7 @@ static void test_seal_mmap_overwrite_prot(bool seal)
 	void *ret2;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	if (seal) {
 		ret = sys_mseal(ptr, size);
@@ -1232,6 +1276,7 @@ static void test_seal_mmap_expand(bool seal)
 	void *ret2;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 	/* ummap last 4 pages. */
 	ret = sys_munmap(ptr + 8 * page_size, 4 * page_size);
 	FAIL_TEST_IF_FALSE(!ret);
@@ -1262,6 +1307,7 @@ static void test_seal_mmap_shrink(bool seal)
 	void *ret2;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	if (seal) {
 		ret = sys_mseal(ptr, size);
@@ -1290,7 +1336,9 @@ static void test_seal_mremap_shrink_fixed(bool seal)
 	void *ret2;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 	setup_single_address(size, &newAddr);
+	FAIL_TEST_IF_FALSE(newAddr != (void *)-1);
 
 	if (seal) {
 		ret = sys_mseal(ptr, size);
@@ -1319,7 +1367,9 @@ static void test_seal_mremap_expand_fixed(bool seal)
 	void *ret2;
 
 	setup_single_address(page_size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 	setup_single_address(size, &newAddr);
+	FAIL_TEST_IF_FALSE(newAddr != (void *)-1);
 
 	if (seal) {
 		ret = sys_mseal(newAddr, size);
@@ -1348,7 +1398,9 @@ static void test_seal_mremap_move_fixed(bool seal)
 	void *ret2;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 	setup_single_address(size, &newAddr);
+	FAIL_TEST_IF_FALSE(newAddr != (void *)-1);
 
 	if (seal) {
 		ret = sys_mseal(newAddr, size);
@@ -1375,6 +1427,7 @@ static void test_seal_mremap_move_fixed_zero(bool seal)
 	void *ret2;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	if (seal) {
 		ret = sys_mseal(ptr, size);
@@ -1406,6 +1459,7 @@ static void test_seal_mremap_move_dontunmap(bool seal)
 	void *ret2;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	if (seal) {
 		ret = sys_mseal(ptr, size);
@@ -1434,6 +1488,7 @@ static void test_seal_mremap_move_dontunmap_anyaddr(bool seal)
 	void *ret2;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	if (seal) {
 		ret = sys_mseal(ptr, size);
@@ -1469,6 +1524,7 @@ static void test_seal_merge_and_split(void)
 
 	/* (24 RO) */
 	setup_single_address(24 * page_size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
 	/* use mprotect(NONE) to set out boundary */
 	/* (1 NONE) (22 RO) (1 NONE) */
@@ -1700,9 +1756,12 @@ static void test_seal_discard_ro_anon(bool seal)
 	int ret;
 
 	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
-	if (seal)
-		seal_single_address(ptr, size);
+	if (seal) {
+		ret = seal_single_address(ptr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
 
 	ret = sys_madvise(ptr, size, MADV_DONTNEED);
 	if (seal)
@@ -1832,5 +1891,4 @@ int main(int argc, char **argv)
 	test_seal_discard_ro_anon_on_pkey(true);
 
 	ksft_finished();
-	return 0;
 }
diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selftests/mm/seal_elf.c
index 61a2f1c94e02..7143dc4f1b10 100644
--- a/tools/testing/selftests/mm/seal_elf.c
+++ b/tools/testing/selftests/mm/seal_elf.c
@@ -12,9 +12,7 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <assert.h>
 #include <fcntl.h>
-#include <assert.h>
 #include <sys/ioctl.h>
 #include <sys/vfs.h>
 #include <sys/stat.h>
@@ -179,5 +177,4 @@ int main(int argc, char **argv)
 	test_seal_elf();
 
 	ksft_finished();
-	return 0;
 }
-- 
2.44.0.683.g7961c838ac-goog


