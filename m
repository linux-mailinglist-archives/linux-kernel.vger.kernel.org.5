Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA48F773644
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjHHCKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjHHCKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:10:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F471705;
        Mon,  7 Aug 2023 19:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691460639; x=1722996639;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uG3NDhRuxMTWT3J/vbhAok1ojRTKKVWwCGRMvfusbWg=;
  b=DcCY8Bn9iHb5VsmXZA25CMrZDFlZ6g2R15J4fM825oa8AdoVmmf7MaOG
   qMj3CB11vvBap5fLTZEBYFNOWa28WBWy3vtoG0M41D1IkpUqEo/diM/Ro
   1PHeTPaCcPmn2hQnnyaLJuP8Zc5BIVTyFYv5wIfOeB2r8e9g/QM7JBJOz
   /D735laJ1QTvbD8etAJDItBT9TzRuGNripRDz//qvMzm5j1ca5pckwR5a
   zUGCBDb8C89DS8TbDJdtooeXY7a2U4XLnOLQA3v+7xcz9HDfZvTn2bKAX
   ZS134BT9366UIwBmav4NZ9a88Sq/oeVYx/lOhcf7xdgJQtudx6gylzmp8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="360786307"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="360786307"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 19:10:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="1061813239"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="1061813239"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by fmsmga005.fm.intel.com with ESMTP; 07 Aug 2023 19:10:35 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, vishal.moola@gmail.com,
        wangkefeng.wang@huawei.com, minchan@kernel.org, yuzhao@google.com,
        david@redhat.com, ryan.roberts@arm.com, shy828301@gmail.com
Cc:     fengwei.yin@intel.com
Subject: [PATCH v2 0/3] don't use mapcount() to check large folio sharing
Date:   Tue,  8 Aug 2023 10:09:14 +0800
Message-Id: <20230808020917.2230692-1-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(),
folio_mapcount() is used to check whether the folio is shared. But it's
not correct as folio_mapcount() returns total mapcount of large folio.

Use folio_estimated_sharers() here as the estimated number is enough.


This patchset will fix the cases:
User space application call madvise() with MADV_FREE, MADV_COLD and
MADV_PAGEOUT for specific address range. There are THP mapped to the
range. Without the patchset, the THP is skipped. With the patch, the
THP will be split and handled accordingly.

David reported the cow self test skip some cases because of
MADV_PAGEOUT skip THP:
https://lore.kernel.org/linux-mm/9e92e42d-488f-47db-ac9d-75b24cd0d037@intel.com/T/#mbf0f2ec7fbe45da47526de1d7036183981691e81
and I confirmed this patchset make it work again.


Changelog from v1:
  - Avoid two Fixes tags make backport harder. Thank Andrew for pointing
    this out.

  - Add note section to mention this is a temporary fix which is fine
    to reduce user-visble effects. For long term fix, we should wait for
    David's solution. Thank Ryan and David for pointing this out.

  - Spell user-visible effects out. Then people could decide whether
    these patches are necessary for stable branch. Thank Andrew for
    pointing this out.

V1:
https://lore.kernel.org/linux-mm/9e92e42d-488f-47db-ac9d-75b24cd0d037@intel.com/T/#med74caad0cbd0049641cfddc5b9fe793b4b50276  

Yin Fengwei (3):
  madvise:madvise_cold_or_pageout_pte_range(): don't use mapcount()
    against large folio for sharing check
  madvise:madvise_free_huge_pmd(): don't use mapcount() against large
    folio for sharing check
  madvise:madvise_free_pte_range(): don't use mapcount() against large
    folio for sharing check

 mm/huge_memory.c | 2 +-
 mm/madvise.c     | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.39.2

