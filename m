Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F40F75C33F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGUJly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjGUJln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:41:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3032F35AF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689932492; x=1721468492;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H304vXECtyRsfk6v2x0l77glnv4jXjPUELnt58/Aiuk=;
  b=lo0szhqcHjsMP8+UCN31TfNCpyBJOOBKdCB247nJv/fMwmiYrVMgr9/l
   SzzFD/o9WgQGVsSrCPsv5Iha9MsidRYI0Q1n7E399CFVYXkUhNZpotbjK
   hI/vA9H1Z0JlrES761DH1JRWntRsbMyf7/lscmD31/WGK5oSXQZisNaIx
   Dh6Gms6cV4T+JwccSa7hJSjRwAU9wS2Kb89E/SFFp+e9I04JR/Qa+wQdC
   KY7Nq+cuLFqjmA58kaRxIBRMms3xweSpjnVd/hytRNs8ygftwdisPzycb
   Y8A8MByNRwv7RIYHsJD5aVK39BFpot2aTP4Kcv1QKeZZFF6GqzVhJ3sUD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="397874271"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="397874271"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 02:40:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="898660994"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="898660994"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by orsmga005.jf.intel.com with ESMTP; 21 Jul 2023 02:40:32 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, minchan@kernel.org, yuzhao@google.com,
        willy@infradead.org, david@redhat.com, ryan.roberts@arm.com,
        shy828301@gmail.com
Cc:     fengwei.yin@intel.com
Subject: [RFC PATCH v2 0/4] fix large folio for madvise_cold_or_pageout()
Date:   Fri, 21 Jul 2023 17:40:39 +0800
Message-Id: <20230721094043.2506691-1-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current madvise_cold_or_pageout_pte_range() has two problems to deal
with large folio:
  - Using folio_mapcount() with large folio prevent large folio from
    picking up.
  - always try to split large folio to normal 4K page.

Try to address these two problems by:
  - Use folio_estimated_sharers() with large folio. With assumption that
    the estimated result of whether the large folio is shared or not is
    enough here.

  - If the large folio is in the range, don't split it. Leave to page
    reclaim as page reclaim can support swap large folio out as whole in
    the future.

  - Only split the large folio if it crosses the boundaries of the
    range. If folio splitting fails, just skip the folio as madvise allows
    some pages in the range are ignored.

Patch1 uses folio_estimated_sharers() to replace folio_mapcount().
Patch2 uses API pmdp_clear_flush_young_notify() to clear A bit of page
       table. It also notifies the mm subscripter about the A bit clearing.
Patch3 introduce help function to check whether the folio crosses range
       boundary.
Patch4 avoid splitting large folio if folio is in the range.

Changes from V1:
  - Split patch1 out as Yu's suggestion
  - Split patch2 out as Yu's suggestion
  - Handle cold case correctly (cold operation was broken in V1 patch)
  - rebase the patchset to latest mm-unstable

Testing done:
  - mm selftest without new regression.

V1's link:
https://lore.kernel.org/linux-mm/20230713150558.200545-1-fengwei.yin@intel.com/

Yin Fengwei (4):
  madvise: not use mapcount() against large folio for sharing check
  madvise: Use notify-able API to clear and flush page table entries
  mm: add functions folio_in_range() and folio_within_vma()
  madvise: avoid trying to split large folio always in cold_pageout

 mm/internal.h |  42 ++++++++++++++++
 mm/madvise.c  | 136 +++++++++++++++++++++++++++++++-------------------
 2 files changed, 127 insertions(+), 51 deletions(-)

-- 
2.39.2

