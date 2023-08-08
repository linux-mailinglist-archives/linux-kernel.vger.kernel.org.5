Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35CF7749B7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbjHHUB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjHHUBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:01:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88527810DE;
        Tue,  8 Aug 2023 11:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691518667; x=1723054667;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f91rR6f/4Edvrb7hPV3707WcDUjqWofH1o8H8I62aAs=;
  b=hIX7P10whAD6hILEHhMj5Gy2SlW/H9qZDZpGiCSAxPmTF1IR+lHMv9g2
   fNXcoyZJeXerb7GdGMl8KrD/K1IVEO2b1zmvaEmGScEtTFBOXHsstcl/w
   3OmrDkZH6zzqoD1b2bQMkr4cb5cDak/SKQoBRLremnpLZH9G+0WDfzW1U
   AUDeNwAWBGdvoWiYMlpfTdavxMsaeVxWwxC2+jnCN5pEHJZBI0ssAZMJQ
   +soi1Fi4aYLUrICZLJF6eGaUBnDdm9PEZhSnVXqUaPslNZGt7Oxazy1Qd
   3GN3H1Fe3FXlIrv210vnPc4tr0KRNQJgKe8csjKRt2ZaMvuF/r/lzI4G/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437268539"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="437268539"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 10:44:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="801407277"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="801407277"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga004.fm.intel.com with ESMTP; 08 Aug 2023 10:44:09 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] platform/x86: ISST: Reduce noise for missing numa information in logs
Date:   Tue,  8 Aug 2023 10:43:59 -0700
Message-Id: <20230808174359.50602-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On platforms with no numa support and with several CPUs, logs have lots
of noise for message "Fail to get numa node for CPU:.."

Change pr_info() to pr_info_once() as one print is enough to show the
issue.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 1f59ac55c5f7..a95004e3d80b 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -335,8 +335,8 @@ static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn
 
 		node = dev_to_node(&_pci_dev->dev);
 		if (node == NUMA_NO_NODE) {
-			pr_info("Fail to get numa node for CPU:%d bus:%d dev:%d fn:%d\n",
-				cpu, bus_no, dev, fn);
+			pr_info_once("Fail to get numa node for CPU:%d bus:%d dev:%d fn:%d\n",
+				     cpu, bus_no, dev, fn);
 			continue;
 		}
 
-- 
2.41.0

