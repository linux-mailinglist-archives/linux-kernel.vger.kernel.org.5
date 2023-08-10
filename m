Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7900D777520
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbjHJJ7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbjHJJ6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:58:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510E330DA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691661505; x=1723197505;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FHmKEFi3g2q87hPqZ6nb5nTBLxi8mKfOBDkOrkOGWGM=;
  b=WWbT+VMakvIVEbD/0aAV5hUDZnUtHdO1aLAG3T+TpnjKOaf0jhGgV2A3
   reBGD11+Sh5hMONv/ENp73PnAAFy4nL2zwmRgxzlpeIJj2slC3zbtJUxO
   MrurNJ5vwWxjoO9PVamPcbWlXRLTWGSzzrEc2lmQcvctEHMTKOCjUO2GE
   Ptnxej+sY659wCh1Im006YIbjK6DQ6771TKPzfFLkPwlp8AsUt3iEt01i
   hvjTCed+n/Z+m5iwM3/xtrHfOktClAZPv7Fn0N55wvpHviwOT7N/q9krh
   adjEV8p67l4L3W/nfkPAWCbXIOO2pjgv+UojQBLE5Fee5blr1NRiz0NUc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="368812120"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="368812120"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 02:58:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="767226945"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="767226945"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by orsmga001.jf.intel.com with ESMTP; 10 Aug 2023 02:58:09 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org
Cc:     fengwei.yin@intel.com
Subject: [PATCH] zswap: don't warn if none swapcache folio is passed to zswap_load
Date:   Thu, 10 Aug 2023 17:56:52 +0800
Message-Id: <20230810095652.3905184-1-fengwei.yin@intel.com>
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

With mm-unstable branch, if trigger swap activity and it's possible
see following warning:
[  178.093511][  T651] WARNING: CPU: 2 PID: 651 at mm/zswap.c:1387 zswap_load+0x67/0x570
[  178.095155][  T651] Modules linked in:
[  178.096103][  T651] CPU: 2 PID: 651 Comm: gmain Not tainted 6.5.0-rc4-00492-gad3232df3e41 #148
[  178.098372][  T651] Hardware name: QEMU Standard PC (i440FX + PIIX,1996), BIOS 1.14.0-2 04/01/2014
[  178.101114][  T651] RIP: 0010:zswap_load+0x67/0x570
[  178.102359][  T651] Code: a0 78 4b 85 e8 ea db ff ff 48 8b 00 a8 01 0f 84 84 04 00 00 48 89 df e8 d7 db ff ff 48 8b 00 a9 00 00 08 00 0f 85 c4
[  178.106376][  T651] RSP: 0018:ffffc900011b3760 EFLAGS: 00010246
[  178.107675][  T651] RAX: 0017ffffc0080001 RBX: ffffea0004a991c0 RCX:ffffc900011b37dc
[  178.109242][  T651] RDX: 0000000000000000 RSI: 0000000000000001 RDI:ffffea0004a991c0
[  178.110916][  T651] RBP: ffffea0004a991c0 R08: 0000000000000243 R09:00000000c9a1aafc
[  178.112377][  T651] R10: 00000000c9657db3 R11: 000000003c9657db R12:0000000000014b9c
[  178.113698][  T651] R13: ffff88813501e710 R14: ffff88810d591000 R15:0000000000000000
[  178.115008][  T651] FS:  00007fb21a9ff700(0000) GS:ffff88813bc80000(0000) knlGS:0000000000000000
[  178.116423][  T651] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  178.117421][  T651] CR2: 00005632cbfc81f6 CR3: 0000000131450002 CR4:0000000000370ee0
[  178.118683][  T651] DR0: 0000000000000000 DR1: 0000000000000000 DR2:0000000000000000
[  178.119894][  T651] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:0000000000000400
[  178.121087][  T651] Call Trace:
[  178.121654][  T651]  <TASK>
[  178.122109][  T651]  ? zswap_load+0x67/0x570
[  178.122658][  T651]  ? __warn+0x81/0x170
[  178.123119][  T651]  ? zswap_load+0x67/0x570
[  178.123608][  T651]  ? report_bug+0x167/0x190
[  178.124150][  T651]  ? handle_bug+0x3c/0x70
[  178.124615][  T651]  ? exc_invalid_op+0x13/0x60
[  178.125192][  T651]  ? asm_exc_invalid_op+0x16/0x20
[  178.125753][  T651]  ? zswap_load+0x67/0x570
[  178.126231][  T651]  ? lock_acquire+0xbb/0x290
[  178.126745][  T651]  ? folio_add_lru+0x40/0x1c0
[  178.127261][  T651]  ? find_held_lock+0x2b/0x80
[  178.127776][  T651]  swap_readpage+0xc7/0x5c0
[  178.128273][  T651]  do_swap_page+0x86d/0xf50
[  178.128770][  T651]  ? __pte_offset_map+0x3e/0x290
[  178.129321][  T651]  ? __pte_offset_map+0x1c4/0x290
[  178.129883][  T651]  __handle_mm_fault+0x6ad/0xca0
[  178.130419][  T651]  handle_mm_fault+0x18b/0x410
[  178.130992][  T651]  do_user_addr_fault+0x1f1/0x820
[  178.132076][  T651]  exc_page_fault+0x63/0x1a0
[  178.132599][  T651]  asm_exc_page_fault+0x22/0x30

It's possible that swap_readpage() is called with none swapcache folio
in do_swap_page() and trigger this warning. So we shouldn't assume
zswap_load() always takes swapcache folio.

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
 mm/zswap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 1e17f11a7896..7300b98d4a03 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1384,7 +1384,6 @@ bool zswap_load(struct folio *folio)
 	bool ret;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
-	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
 
 	/* find */
 	spin_lock(&tree->lock);
-- 
2.39.2

