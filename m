Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9537A42AF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240284AbjIRHeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240478AbjIRHdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:33:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB7E12E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695022403; x=1726558403;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LismrfeNewiy95Gm2WxPWMqPvAHx57HKqPCYg8Zeheg=;
  b=Uw+Gk7Yvfbq4lyqhnMIVuBePmXhbAg81D2JmlTIAcJ6USPK0jleI0GXa
   aNygnApu+/mMmf6GnnwiNG0HobPgMqMDS0yC3ku91s/bmH4hfURUpqlLz
   5Z1HgXzCenEbD5SOuTZoWvVKPCjYu626TjVDHsfRd9C16GJpqKLXpmnd2
   t5fvKapr8g+73wW+2Pt808J2Vncug2hMYOIHdR0UiWHtveRVt5iV8GqGJ
   rbbpae5/AjsvJs/+ZnHLyOkTAlDARySQd+BEbEtCNYJ+qpuWIvOouxMJs
   MqpDfvSj3cGylVd5MKArOSlzlJjPJWV2jY09h8x+q8Ua41t83eIw0oqHL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="443664568"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="443664568"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 00:33:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="775030619"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="775030619"
Received: from fyin-dev.sh.intel.com ([10.239.159.24])
  by orsmga008.jf.intel.com with ESMTP; 18 Sep 2023 00:33:19 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, yuzhao@google.com, willy@infradead.org,
        hughd@google.com, yosryahmed@google.com, ryan.roberts@arm.com,
        david@redhat.com, shy828301@gmail.com
Cc:     fengwei.yin@intel.com
Subject: [PATCH v3 0/3] support large folio for mlock
Date:   Mon, 18 Sep 2023 15:33:15 +0800
Message-Id: <20230918073318.1181104-1-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu mentioned at [1] about the mlock() can't be applied to large folio.

I leant the related code and here is my understanding:
- For RLIMIT_MEMLOCK related, there is no problem. Because the
  RLIMIT_MEMLOCK statistics is not related underneath page. That means
  underneath page mlock or munlock doesn't impact the RLIMIT_MEMLOCK
  statistics collection which is always correct.

- For keeping the page in RAM, there is no problem either. At least,
  during try_to_unmap_one(), once detect the VMA has VM_LOCKED bit
  set in vm_flags, the folio will be kept whatever the folio is
  mlocked or not.

So the function of mlock for large folio works. But it's not optimized
because the page reclaim needs scan these large folio and may split
them.

This series identified the large folio for mlock to four types:
  - The large folio is in VM_LOCKED range and fully mapped to the
    range

  - The large folio is in the VM_LOCKED range but not fully mapped to
    the range

  - The large folio cross VM_LOCKED VMA boundary

  - The large folio cross last level page table boundary

For the first type, we mlock large folio so page reclaim will skip it.

For the second/third type, we don't mlock large folio. As the pages
not mapped to VM_LOACKED range are mapped to none VM_LOCKED range,
if system is in memory pressure situation, the large folio can be
picked by page reclaim and split. Then the pages not mapped to
VM_LOCKED range can be reclaimed.

For the fourth type, we don't mlock large folio because locking one
page table lock can't prevent the part in another last level page
table being unmapped. Thanks to Ryan for pointing this out.


To check whether the folio is fully mapped to the range, PTEs needs
be checked to see whether the page of folio is associated. Which
needs take page table lock and is heavy operation. So far, the
only place needs this check is madvise and page reclaim. These
functions already have their own PTE iterator.


patch1 introduce API to check whether large folio is in VMA range.
patch2 make page reclaim/mlock_vma_folio/munlock_vma_folio support
       large folio mlock/munlock.
patch3 make mlock/munlock syscall support large folio.

testing done:
  - kernel selftest. No extra failure introduced

v2 was post here [2].

Yu also mentioned a race which can make folio unevictable after munlock
during RFC v2 discussion [3]:
We decided that race issue didn't block this series based on:
  - That race issue was not introduced by this series

  - We had a looks-ok fix for that race issue. Need to wait
    for mlock_count fixing patch as Yosry Ahmed suggested [4]

ChangeLog from V2:
  - Rebase to latest mm-unstable branch
  - Add comment to function folio_within_range() per Ryan's suggestions
  - Change function name folio_in_range() to folio_within_range() per
    Ryan's suggestions
  - No real code change

ChangeLog from V1:
  - Remove the PTE check from folio_in_range() and reuse the page
    table iterator (in madvise and folio_referenced_one) to check
    whether fully mapped or not in callers

  - Avoid mlock the folio which cross last level page table. Thanks
    to Ryan for pointing this out.

  - Drop pte_none() check when iterate page table because we only
    care pte_present() case.

  - move folio_test_large() out of  m(un)lock_vma_folio()


ChangeLog from RFC v2:
  - Removed RFC

  - dropped folio_is_large() check as suggested by both Yu and Huge

  - Besides the address/pgoff check, also check the page table
    entry when check whether the folio is in the range. This is
    to handle mremap case that address/pgoff is in range, but
    folio can't be identified as in range.

  - Fixed one issue in page_add_anon_rmap() and page_add_anon_rmap()
    introdued by RFC v2. As these two functions can be called multiple
    times against one folio. And remove_rmap() may not be called same
    times. Which can bring imbalanced mlock_count. Fix it by skip
    mlock large folio in these two functions.

[1] https://lore.kernel.org/linux-mm/CAOUHufbtNPkdktjt_5qM45GegVO-rCFOMkSh0HQminQ12zsV8Q@mail.gmail.com/
[2] https://lore.kernel.org/linux-mm/20230809061105.3369958-1-fengwei.yin@intel.com/
[3] https://lore.kernel.org/linux-mm/CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com/
[4] https://lore.kernel.org/linux-mm/CAJD7tkZJFG=7xs=9otc5CKs6odWu48daUuZP9Wd9Z-sZF07hXg@mail.gmail.com/

Yin Fengwei (3):
  mm: add functions folio_in_range() and folio_within_vma()
  mm: handle large folio when large folio in VM_LOCKED VMA range
  mm: mlock: update mlock_pte_range to handle large folio

 mm/internal.h | 73 ++++++++++++++++++++++++++++++++++++++++++++-------
 mm/mlock.c    | 66 ++++++++++++++++++++++++++++++++++++++++++++--
 mm/rmap.c     | 66 ++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 182 insertions(+), 23 deletions(-)

-- 
2.39.2

