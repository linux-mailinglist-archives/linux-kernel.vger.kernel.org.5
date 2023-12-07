Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7715E807E1B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442990AbjLGBp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjLGBp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:45:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755E819E;
        Wed,  6 Dec 2023 17:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701913533; x=1733449533;
  h=from:to:cc:subject:date:message-id;
  bh=KiFqkDFxamxUcRrbdcfuGE7EYU7NwqcueANUY2UM/s4=;
  b=DCv1hmmT5u7iHdRD3T4RZL8nio79GM35ANZ0jCvl4zsiwvVW178DMnt3
   pS0GYldCX0/7PFkFaYfkqFz7ZGuGYWeI2WKDCgl6Bu7u/o6cOvutKdYeK
   bpuG0mmILCZms86zpjYszkZRji/XwGFB6LnJVEawEVBMnG4zVbDf+SL+G
   erY1+yNphe8UgjkpB1+wZFSCEPOt8LgJvKl+b2cjrz6QcHvFGFJbdZ7Rv
   2Ih7k1u8y2O1iXNTqEO1vus6TZEtbIOBKpR5Cz6JK4FWfwiZ32HMI1lnY
   8h5GiV4A4tBWkAOaVE9CBW/OLQVBkAuzmecuPsvDsxN6/HHwp2g+LBteE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="374328473"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="374328473"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 17:45:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="805839984"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="805839984"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 17:45:30 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] EDAC/skx_common: Filter out the invalid address
Date:   Thu,  7 Dec 2023 09:45:12 +0800
Message-Id: <20231207014512.78564-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decoding an invalid address with certain firmware decoders could
cause a #PF (Page Fault) in the EFI runtime context, which could
subsequently hang the system. To make {i10nm,skx}_edac more robust
against such bogus firmware decoders, filter out invalid addresses
before allowing the firmware decoder to process them.

Suggested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/skx_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index ce3e0069e028..9c5b6f8bd8bd 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -648,6 +648,10 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 	memset(&res, 0, sizeof(res));
 	res.mce  = mce;
 	res.addr = mce->addr & MCI_ADDR_PHYSADDR;
+	if (!pfn_to_online_page(res.addr >> PAGE_SHIFT)) {
+		pr_err("Invalid address 0x%llx in IA32_MC%d_ADDR\n", mce->addr, mce->bank);
+		return NOTIFY_DONE;
+	}
 
 	/* Try driver decoder first */
 	if (!(driver_decode && driver_decode(&res))) {
-- 
2.17.1

