Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782E57BEA50
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346689AbjJITG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378250AbjJITGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:06:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B992B0;
        Mon,  9 Oct 2023 12:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696878364; x=1728414364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x3EM3wsMZCAxSPsPzrPUYZJcR0jXfkuECNMP363NeKM=;
  b=S4nIWI4CZfCspuTWIPaEeb4Z2Q5RoYXKQD9Ad1BWdTe8RoIb2B+wis0a
   jnk5UBOmk07SXHBhpIwP2BYtzL89w9niX1jWuOepDMj2GTUdblMM+4JR1
   /rqaNTG0VEPDxUmy/7EYVWxlLwIP41b6ZUcWZWqwqQGnGT+NfUKfr9pBQ
   GXktCM9KkyNNUbVugWfbvgHicDGsOd5m3yrzSYQHhuHyFoJ2HOUhNCkIX
   BV/5Wb0p9gmNTZWRwgoxBK+B/4mTi70Z+mVCNXM/GWn4au2zSXMt6Gsz7
   YBU1QUPeLyABgUTpUzjuHylEipYWhtAYcwcE7ku0CXwkWVC3+NQzfMjdv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="415213783"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="415213783"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 12:06:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="823445855"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="823445855"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga004.fm.intel.com with ESMTP; 09 Oct 2023 12:06:01 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 6/7] thermal: int340x: processor_thermal: Enable power floor support
Date:   Mon,  9 Oct 2023 12:05:37 -0700
Message-Id: <20231009190538.2488792-7-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009190538.2488792-1-srinivas.pandruvada@linux.intel.com>
References: <20231009190538.2488792-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable power floor feature support for Meteor Lake processors.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
- No change

 .../intel/int340x_thermal/processor_thermal_device_pci.c        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 4c2194f19ed2..d7495571dd5d 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -409,7 +409,7 @@ static const struct pci_device_id proc_thermal_pci_ids[] = {
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_REQ) },
 	{ PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_DLVR |
-	  PROC_THERMAL_FEATURE_WT_HINT) },
+	  PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR) },
 	{ PCI_DEVICE_DATA(INTEL, ARL_S_THERMAL, PROC_THERMAL_FEATURE_RAPL |
 	  PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_WT_HINT) },
 	{ PCI_DEVICE_DATA(INTEL, RPL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
-- 
2.40.1

