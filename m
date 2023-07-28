Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87257664EB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjG1HLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbjG1HL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:11:26 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55CD3582
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690528259; x=1722064259;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NsuT7YdSl7sZxCcl3/RIBxZPQqeQjrB0Z6lwmBqdqLo=;
  b=CVFpFyDKeYyYVgOuO8dq1LvqMNCgXoJtbOiJJsIGWSH2w+JPiWfBsjQw
   wX5eSTVSuRDRRQMT1iMClBlveY/yITZ+cmSVr6EsziDgkUXoW0FjhHw4S
   cda1gEllMSXCNy7NLmFwr+ZXLTOG1O/uIefSQ8KHe3gbBoHa7AD48O1xb
   XnZ2cfpPfpo3GPAPLb50FDs3P58UNzfOl1fiUhfyRJMFC+UZj4xTZqmWO
   X9AC3ZeIxIVL5E25hTIM31eYe18psID7rAPKi0oP39qCzNvlWVUPUwudc
   g4SjBxqAV+Gf6kvAeDFjah+Fu7uLhSzYvQ/jr+/J71ATsYtjgBBg0GPQ4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="368543767"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="368543767"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 00:10:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="757039048"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="757039048"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by orsmga008.jf.intel.com with ESMTP; 28 Jul 2023 00:10:54 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, yuzhao@google.com, willy@infradead.org,
        david@redhat.com, ryan.roberts@arm.com, shy828301@gmail.com,
        hughd@google.com
Cc:     fengwei.yin@intel.com
Subject: [PATCH 0/3] support large folio for mlock
Date:   Fri, 28 Jul 2023 15:09:26 +0800
Message-Id: <20230728070929.2487065-1-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu mentioned at [1] about the mlock() can't be applied to large folio.

I leant the related code and here is my understanding:
- For RLIMIT_MEMLOCK related, there is no problem. Becuase the
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

This series identified the large folio for mlock to two types:
  - The large folio is in VM_LOCKED VMA range

  - The large folio cross VM_LOCKED VMA boundary

For the first type, we mlock large folio so page relcaim will skip it.
For the second type, we don't mlock large folio. It's allowed to be
picked by page reclaim and be split. So the pages not in VM_LOCKED VMA
range are allowed to be reclaimed/released.

patch1 introduce API to check whether large folio is in VMA range.
patch2 make page reclaim/mlock_vma_folio/munlock_vma_folio support
       large folio mlock/munlock.
patch3 make mlock/munlock syscall support large folio.

testing done:
  - kernel selftest. No extra failure introduced

RFC v2 was post here [2].

Yu also mentioned a race which can make folio unevictable after munlock
during RFC v2 discussion [3]:
We decided that race issue didn't block this series based on:
  - That race issue was not introduced by this sereis

  - We had a looks-ok fix for that race issue. Need to wait
    for mlock_count fixing patch as Yosry Ahmed suggested [4]

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
[2] https://lore.kernel.org/linux-mm/20230712060144.3006358-1-fengwei.yin@intel.com/
[3] https://lore.kernel.org/linux-mm/CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com/
[4] https://lore.kernel.org/linux-mm/CAJD7tkZJFG=7xs=9otc5CKs6odWu48daUuZP9Wd9Z-sZF07hXg@mail.gmail.com/

Yin Fengwei (3):
  mm: add functions folio_in_range() and folio_within_vma()
  mm: handle large folio when large folio in VM_LOCKED VMA range
  mm: mlock: update mlock_pte_range to handle large folio

 mm/internal.h | 87 +++++++++++++++++++++++++++++++++++++++++++++------
 mm/mlock.c    | 57 +++++++++++++++++++++++++++++++--
 mm/rmap.c     | 27 +++++++++++-----
 3 files changed, 153 insertions(+), 18 deletions(-)

-- 
2.39.2

