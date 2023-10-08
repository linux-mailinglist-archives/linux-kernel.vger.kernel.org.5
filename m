Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0767BCD23
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 10:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjJHIDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 04:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjJHIDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 04:03:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A352AB9;
        Sun,  8 Oct 2023 01:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696752223; x=1728288223;
  h=from:to:cc:subject:date:message-id;
  bh=M+CZyx661hVrmPY+4+i7MhwylTG6WH1acuVWa4jyhKE=;
  b=HvhE+kXpSDnt+SGB4d+PBaA/LXhQazCLyy74vWKzl98GN4ajBVa7IP8a
   /9ZlRyFQkBnih5USFy8ZobqczCEkAk51Bq9877aqlmIZGJnKq6CRrdVV9
   xFZ2lAkG9vga+8Jfn+BVZppz5dIyCrvspVTRFOKxR8zmzFu0SoYKQh0kk
   M+VJEV/pFnxtuth8FMVLud9G/ZS5jglyo1wi/O/33uBltDujF3GLVCxgs
   ESDZUVqm10M37Nt47nN2SxS2lO9MIsY31RIJf27NKYv2/BavQroBQwce9
   GwZdYspJnm4xpZ+a2cXjoIAPox7C6j7hWSxBjpknC2dya60yhW+RXPOlX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="383863996"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="383863996"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 01:03:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="876474391"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="876474391"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 01:03:39 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Lili Li <lili.li@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] EDAC/igen6: Fix slab-use-after-free in igen6_unregister_mci()
Date:   Sun,  8 Oct 2023 16:02:29 +0800
Message-Id: <20231008080231.51917-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When unloading the igen6_edac driver, the EDAC core wrongly kfreed
'pvt_info,' which was private data and managed by the igen6_edac
driver. This resulted in a slab-use-after-free bug. Fix it by adding
a flag to indicate whether 'pvt_info' is managed by the EDAC core.
The EDAC core will only kfree 'pvt_info' when the flag is set to true.

 BUG: KASAN: slab-use-after-free in igen6_unregister_mcis+0x74/0x1f0 [igen6_edac]
 Read of size 8 at addr ffff88810c10a350 by task modprobe/5137

 Call Trace:
  <TASK>
  dump_stack_lvl+0x4c/0x70
  print_report+0xcf/0x620
  ? __virt_addr_valid+0xfc/0x180
  ? kasan_complete_mode_report_info+0x80/0x210
  ? igen6_unregister_mcis+0x74/0x1f0 [igen6_edac]
  kasan_report+0xbf/0x100
  ? igen6_unregister_mcis+0x74/0x1f0 [igen6_edac]
  __asan_load8+0x82/0xb0
  igen6_unregister_mcis+0x74/0x1f0 [igen6_edac]
  igen6_remove+0x97/0xc0 [igen6_edac]
...
 Allocated by task 578:
  kasan_save_stack+0x2a/0x50
  kasan_set_track+0x29/0x40
  kasan_save_alloc_info+0x1f/0x30
  __kasan_kmalloc+0x88/0xa0
  kmalloc_trace+0x4e/0xb0
  igen6_probe+0xe5/0x1400 [igen6_edac]
  local_pci_probe+0x89/0xf0
  pci_device_probe+0x18e/0x450
...
 Freed by task 5137:
  kasan_save_stack+0x2a/0x50
  kasan_set_track+0x29/0x40
  kasan_save_free_info+0x32/0x50
  __kasan_slab_free+0x113/0x1b0
  slab_free_freelist_hook+0xb1/0x190
  __kmem_cache_free+0x15d/0x280
  kfree+0x7d/0x120
  mci_release+0x24a/0x280
  device_release+0x64/0x110
  kobject_put+0xfd/0x260
  put_device+0x17/0x30
  edac_mc_free+0x43/0x50
  igen6_unregister_mcis+0x18f/0x1f0 [igen6_edac]
  igen6_remove+0x97/0xc0 [igen6_edac]
  pci_device_remove+0x6a/0x100
  device_remove+0x6f/0xb0

Fixes: 0bbb265f7089 ("EDAC/mc: Get rid of silly one-shot struct allocation in edac_mc_alloc()")
Co-developed-by: Lili Li <lili.li@intel.com>
Signed-off-by: Lili Li <lili.li@intel.com>
Tested-by: Lili Li <lili.li@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/edac_mc.c | 19 +++++++++++++++----
 include/linux/edac.h   |  5 +++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 6faeb2ab3960..6a68b0225130 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -201,7 +201,14 @@ static void mci_release(struct device *dev)
 		}
 		kfree(mci->csrows);
 	}
-	kfree(mci->pvt_info);
+
+	/*
+	 * if !pvt_managed_by_edac_core, the resource, e.g. memory or MMIO-mapped
+	 * registers pointed by pvt_info is managed by the EDAC	driver. The EDAC
+	 * core shouldn't kfree it.
+	 */
+	if (mci->pvt_managed_by_edac_core)
+		kfree(mci->pvt_info);
 	kfree(mci->layers);
 	kfree(mci);
 }
@@ -369,9 +376,13 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
 	if (!mci->layers)
 		goto error;
 
-	mci->pvt_info = kzalloc(sz_pvt, GFP_KERNEL);
-	if (!mci->pvt_info)
-		goto error;
+	if (sz_pvt) {
+		mci->pvt_info = kzalloc(sz_pvt, GFP_KERNEL);
+		if (!mci->pvt_info)
+			goto error;
+
+		mci->pvt_managed_by_edac_core = true;
+	}
 
 	mci->dev.release = mci_release;
 	device_initialize(&mci->dev);
diff --git a/include/linux/edac.h b/include/linux/edac.h
index fa4bda2a70f6..6f9f4893ba77 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -567,6 +567,11 @@ struct mem_ctl_info {
 	const char *ctl_name;
 	const char *dev_name;
 	void *pvt_info;
+	/*
+	 * Indicate whether the resource pointed by pvt_info is managed by
+	 * the EDAC core.
+	 */
+	bool pvt_managed_by_edac_core;
 	unsigned long start_time;	/* mci load start time (in jiffies) */
 
 	/*
-- 
2.17.1

