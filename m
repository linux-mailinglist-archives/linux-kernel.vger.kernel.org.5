Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128CE806C0B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377458AbjLFKf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377453AbjLFKf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:35:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2460218F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701858963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WQ7x2ePi4wPqgcy9UtrNKCA+HmaOdfg4ZJ2pa42/YJE=;
        b=a3rWuPCID7jd7dlwUOn4I76Jaglg9yI4H0uDvwEqZaO2ucnKXx5BgBoN8OSRVWYHam1TAk
        sQ61OQkdzaUo1KtMMcTwBwq1UwXucMW71I5GM+0gTFsQ/3Bw3fp5otZmxCDBwwA9wtcIf3
        qBDW4bRczu3GngeLk8rxsQiYEcTpSqU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-G62fAps4PdW2LwnnG9nc_w-1; Wed,
 06 Dec 2023 05:36:01 -0500
X-MC-Unique: G62fAps4PdW2LwnnG9nc_w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45FE23C0F363;
        Wed,  6 Dec 2023 10:36:01 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA69740C6EB9;
        Wed,  6 Dec 2023 10:35:59 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Nico Pache <npache@redhat.com>
Subject: [PATCH v1] selftests/mm: cow: print ksft header before printing anything else
Date:   Wed,  6 Dec 2023 11:35:58 +0100
Message-ID: <20231206103558.38040-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doing a ksft_print_msg() before the ksft_print_header() seems to confuse
the ksft framework in a strange way: running the test on the cmdline
results in the expected output.

But piping the output somewhere else, results in some odd output,
whereby we repeatedly get the same info printed:
	# [INFO] detected THP size: 2048 KiB
	# [INFO] detected hugetlb page size: 2048 KiB
	# [INFO] detected hugetlb page size: 1048576 KiB
	# [INFO] huge zeropage is enabled
	TAP version 13
	1..190
	# [INFO] Anonymous memory tests in private mappings
	# [RUN] Basic COW after fork() ... with base page
	# [INFO] detected THP size: 2048 KiB
	# [INFO] detected hugetlb page size: 2048 KiB
	# [INFO] detected hugetlb page size: 1048576 KiB
	# [INFO] huge zeropage is enabled
	TAP version 13
	1..190
	# [INFO] Anonymous memory tests in private mappings
	# [RUN] Basic COW after fork() ... with base page
	ok 1 No leak from parent into child
	# [RUN] Basic COW after fork() ... with swapped out base page
	# [INFO] detected THP size: 2048 KiB
	# [INFO] detected hugetlb page size: 2048 KiB
	# [INFO] detected hugetlb page size: 1048576 KiB
	# [INFO] huge zeropage is enabled

Doing the ksft_print_header() first seems to resolve that and gives us
the output we expect:
	TAP version 13
	# [INFO] detected THP size: 2048 KiB
	# [INFO] detected hugetlb page size: 2048 KiB
	# [INFO] detected hugetlb page size: 1048576 KiB
	# [INFO] huge zeropage is enabled
	1..190
	# [INFO] Anonymous memory tests in private mappings
	# [RUN] Basic COW after fork() ... with base page
	ok 1 No leak from parent into child
	# [RUN] Basic COW after fork() ... with swapped out base page
	ok 2 No leak from parent into child
	# [RUN] Basic COW after fork() ... with THP
	ok 3 No leak from parent into child
	# [RUN] Basic COW after fork() ... with swapped-out THP
	ok 4 No leak from parent into child
	# [RUN] Basic COW after fork() ... with PTE-mapped THP
	ok 5 No leak from parent into child

Reported-by: Nico Pache <npache@redhat.com>
Fixes: f4b5fd6946e2 ("selftests/vm: anon_cow: THP tests")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/mm/cow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 7324ce5363c0c..6f2f839904416 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -1680,6 +1680,8 @@ int main(int argc, char **argv)
 {
 	int err;
 
+	ksft_print_header();
+
 	pagesize = getpagesize();
 	thpsize = read_pmd_pagesize();
 	if (thpsize)
@@ -1689,7 +1691,6 @@ int main(int argc, char **argv)
 						    ARRAY_SIZE(hugetlbsizes));
 	detect_huge_zeropage();
 
-	ksft_print_header();
 	ksft_set_plan(ARRAY_SIZE(anon_test_cases) * tests_per_anon_test_case() +
 		      ARRAY_SIZE(anon_thp_test_cases) * tests_per_anon_thp_test_case() +
 		      ARRAY_SIZE(non_anon_test_cases) * tests_per_non_anon_test_case());
-- 
2.41.0

