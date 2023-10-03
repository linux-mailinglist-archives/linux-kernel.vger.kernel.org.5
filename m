Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E69F7B6E8B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbjJCQcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239961AbjJCQcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:32:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB2EAC;
        Tue,  3 Oct 2023 09:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696350758; x=1727886758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bpCe5F6Deb5HmkgRu6OwyVxAqzVowHxGy4Bqa5oyCR8=;
  b=SjLNEMTiu/6ZiLv4TW/XyNdUgdBX9RQYzOWBCnDqJp8AWto2Gspp1qeM
   Z87Jxz9p3D+wcD2RQSzBCn9BUXPfHu7kwaRQl1g77Te6GjPQkpwnyza+j
   leVIDT6gFwD/BzGrLftI1r/rMznFaarjcm1cLQFDXj2Tm5tOiLV+yNCG0
   eD9uosiEU8tUx7JuJ/w2XS3vn7+iS27jMazVzUCPKUYXWBW29dxYGYsCt
   qEfyd0AYdFd7BrCjA2uK/NVLUvXNyIJC6qKnu45AsAsLEpt7cwiGyoihN
   0+aFlFbwjTwIUOi6XCzrtWax7fahOxTvV3Dx7ULUbQYkAoKvageLwXPCw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="381799122"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="381799122"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 09:32:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082069901"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="1082069901"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga005.fm.intel.com with ESMTP; 03 Oct 2023 09:32:37 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 2/4] platform/x86: ISST: Allow level 0 to be not present
Date:   Tue,  3 Oct 2023 09:32:32 -0700
Message-Id: <20231003163234.1856669-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231003163234.1856669-1-srinivas.pandruvada@linux.intel.com>
References: <20231003163234.1856669-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that SST level 0 or base level is not present in some
configurations. So don't set level 0 mask in level_en_mask by default.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v2:
No change, just added Reviewed by

 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index a672a1c814af..ac5c6a812592 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -364,9 +364,6 @@ static int sst_main(struct auxiliary_device *auxdev, struct tpmi_per_power_domai
 	/* Read PP header */
 	*((u64 *)&pd_info->pp_header) = readq(pd_info->sst_base + pd_info->sst_header.pp_offset);
 
-	/* Force level_en_mask level 0 */
-	pd_info->pp_header.level_en_mask |= 0x01;
-
 	mask = 0x01;
 	levels = 0;
 	for (i = 0; i < 8; ++i) {
-- 
2.41.0

