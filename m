Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9A180FB5C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbjLLX1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjLLX1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:27:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E92F2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702423624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZwFQ3GQCbPFAax8NUohZK89OPMuLW9MEl5mvS51Lzts=;
        b=Qb6rEPepNg/r1A/4ycL+MxCwfAeoRRx9JRESXZNnMHwx51B0+PdWmNQ1gs11C6mIFP/YGl
        6OaZ3/ufSM9dfytM3RZLMTH6JCADT5ye200VAi0CO0gnL5HTa5zF4pDoDh31uN4xNCUmVE
        aJYaLugb7REp/xMQ9Z/JoT9Z/r82mBQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-6YG-K_zxMJKQP8zTqBW2aQ-1; Tue, 12 Dec 2023 18:27:03 -0500
X-MC-Unique: 6YG-K_zxMJKQP8zTqBW2aQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4552A80BEC1;
        Tue, 12 Dec 2023 23:27:02 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.22.34.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 800551121306;
        Tue, 12 Dec 2023 23:27:01 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Cc:     akpm@linux-foundation.org, vincenzo.frascino@arm.com,
        dvyukov@google.com, andreyknvl@gmail.com, glider@google.com,
        ryabinin.a.a@gmail.com
Subject: [PATCH] kunit: kasan_test: disable fortify string checker on kmalloc_oob_memset
Date:   Tue, 12 Dec 2023 16:26:59 -0700
Message-ID: <20231212232659.18839-1-npache@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

similar to commit 09c6304e38e4 ("kasan: test: fix compatibility with
FORTIFY_SOURCE") the kernel is panicing in kmalloc_oob_memset_*.

This is due to the `ptr` not being hidden from the optimizer which would
disable the runtime fortify string checker.

kernel BUG at lib/string_helpers.c:1048!
Call Trace:
[<00000000272502e2>] fortify_panic+0x2a/0x30
([<00000000272502de>] fortify_panic+0x26/0x30)
[<001bffff817045c4>] kmalloc_oob_memset_2+0x22c/0x230 [kasan_test]

Hide the `ptr` variable from the optimizer to fix the kernel panic.
Also define a size2 variable and hide that as well. This cleans up
the code and follows the same convention as other tests.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/kasan/kasan_test.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 8281eb42464b..5aeba810ba70 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -493,14 +493,17 @@ static void kmalloc_oob_memset_2(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 128 - KASAN_GRANULE_SIZE;
+	size_t size2 = 2;
 
 	KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
 
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	OPTIMIZER_HIDE_VAR(ptr);
 	OPTIMIZER_HIDE_VAR(size);
-	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 1, 0, 2));
+	OPTIMIZER_HIDE_VAR(size2);
+	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 1, 0, size2));
 	kfree(ptr);
 }
 
@@ -508,14 +511,17 @@ static void kmalloc_oob_memset_4(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 128 - KASAN_GRANULE_SIZE;
+	size_t size2 = 4;
 
 	KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
 
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	OPTIMIZER_HIDE_VAR(ptr);
 	OPTIMIZER_HIDE_VAR(size);
-	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 3, 0, 4));
+	OPTIMIZER_HIDE_VAR(size2);
+	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 3, 0, size2));
 	kfree(ptr);
 }
 
@@ -523,14 +529,17 @@ static void kmalloc_oob_memset_8(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 128 - KASAN_GRANULE_SIZE;
+	size_t size2 = 8;
 
 	KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
 
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	OPTIMIZER_HIDE_VAR(ptr);
 	OPTIMIZER_HIDE_VAR(size);
-	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 7, 0, 8));
+	OPTIMIZER_HIDE_VAR(size2);
+	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 7, 0, size2));
 	kfree(ptr);
 }
 
@@ -538,14 +547,17 @@ static void kmalloc_oob_memset_16(struct kunit *test)
 {
 	char *ptr;
 	size_t size = 128 - KASAN_GRANULE_SIZE;
+	size_t size2 = 16;
 
 	KASAN_TEST_NEEDS_CHECKED_MEMINTRINSICS(test);
 
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	OPTIMIZER_HIDE_VAR(ptr);
 	OPTIMIZER_HIDE_VAR(size);
-	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 15, 0, 16));
+	OPTIMIZER_HIDE_VAR(size2);
+	KUNIT_EXPECT_KASAN_FAIL(test, memset(ptr + size - 15, 0, size2));
 	kfree(ptr);
 }
 
-- 
2.43.0

