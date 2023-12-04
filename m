Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5912B803003
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbjLDKVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343768AbjLDKVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:21:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C51685
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:21:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FE0416F2;
        Mon,  4 Dec 2023 02:21:54 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28D103F6C4;
        Mon,  4 Dec 2023 02:21:04 -0800 (PST)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 05/10] selftests/mm/kugepaged: Restore thp settings at exit
Date:   Mon,  4 Dec 2023 10:20:22 +0000
Message-Id: <20231204102027.57185-6-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204102027.57185-1-ryan.roberts@arm.com>
References: <20231204102027.57185-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, the saved thp settings would be restored upon a signal or at
the natural end of the test suite. But there are some tests that
directly call exit() upon failure. In this case, the thp settings were
not being restored, which could then influence other tests.

Fix this by installing an atexit() handler to do the actual restore. The
signal handler can now just call exit() and the atexit handler is
invoked.

Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/khugepaged.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index 030667cb5533..fc47a1c4944c 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -374,18 +374,22 @@ static void pop_settings(void)
 	write_settings(current_settings());
 }
 
-static void restore_settings(int sig)
+static void restore_settings_atexit(void)
 {
 	if (skip_settings_restore)
-		goto out;
+		return;
 
 	printf("Restore THP and khugepaged settings...");
 	write_settings(&saved_settings);
 	success("OK");
-	if (sig)
-		exit(EXIT_FAILURE);
-out:
-	exit(exit_status);
+
+	skip_settings_restore = true;
+}
+
+static void restore_settings(int sig)
+{
+	/* exit() will invoke the restore_settings_atexit handler. */
+	exit(sig ? EXIT_FAILURE : exit_status);
 }
 
 static void save_settings(void)
@@ -415,6 +419,7 @@ static void save_settings(void)
 
 	success("OK");
 
+	atexit(restore_settings_atexit);
 	signal(SIGTERM, restore_settings);
 	signal(SIGINT, restore_settings);
 	signal(SIGHUP, restore_settings);
-- 
2.25.1

