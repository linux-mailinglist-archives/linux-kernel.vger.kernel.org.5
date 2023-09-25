Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD44E7AE052
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 22:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjIYUbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 16:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYUbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 16:31:32 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249E010C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 13:31:26 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qksDy-0006Gb-07;
        Mon, 25 Sep 2023 16:30:34 -0400
From:   riel@surriel.com
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@meta.com, linux-mm@kvack.org,
        akpm@linux-foundation.org, muchun.song@linux.dev,
        mike.kravetz@oracle.com, leit@meta.com, willy@infradead.org
Subject: [PATCH v3 0/3] hugetlbfs: close race between MADV_DONTNEED and page fault
Date:   Mon, 25 Sep 2023 16:28:49 -0400
Message-ID: <20230925203030.703439-1-riel@surriel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3: fix compile error w/ lockdep and test case errors with patch 3
v2: fix the locking bug found with the libhugetlbfs tests.

Malloc libraries, like jemalloc and tcalloc, take decisions on when
to call madvise independently from the code in the main application.

This sometimes results in the application page faulting on an address,
right after the malloc library has shot down the backing memory with
MADV_DONTNEED.

Usually this is harmless, because we always have some 4kB pages
sitting around to satisfy a page fault. However, with hugetlbfs
systems often allocate only the exact number of huge pages that
the application wants.

Due to TLB batching, hugetlbfs MADV_DONTNEED will free pages outside of
any lock taken on the page fault path, which can open up the following
race condition:

       CPU 1                            CPU 2

       MADV_DONTNEED
       unmap page
       shoot down TLB entry
                                       page fault
                                       fail to allocate a huge page
                                       killed with SIGBUS
       free page

Fix that race by extending the hugetlb_vma_lock locking scheme to also
cover private hugetlb mappings (with resv_map), and pulling the locking 
from __unmap_hugepage_final_range into helper functions called from
zap_page_range_single. This ensures page faults stay locked out of
the MADV_DONTNEED VMA until the huge pages have actually been freed.

The third patch in the series is more of an RFC. Using the
invalidate_lock instead of the hugetlb_vma_lock greatly simplifies
the code, but at the cost of turning a per-VMA lock into a lock
per backing hugetlbfs file, which could slow things down when
multiple processes are mapping the same hugetlbfs file.


