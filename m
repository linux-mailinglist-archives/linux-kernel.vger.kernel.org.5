Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882ED7FA94D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjK0Swo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjK0Swm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:52:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2264D5A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701111168; x=1732647168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2N32HLIztMEKcqTYWVW9WXnQpGFYXa8KEDFLkMLSGiU=;
  b=IwiI9jsK5zpNcnZR7hLRSbf9NHn2IS0m4ZPnK3Z+ApULVI5qDRwiT9Je
   jpe+/YtsYmaUcUFGow8qr02DSofVqTPx71tmyL9Ei41jRBO7CHyLzWoMG
   bG0oNR94cp5tA30pMSiDkK2+vVkJvpUTwpqYGR/h1L7DmKX3SWzv5nf3T
   sP8XBTZVBd2+zRY2Jngb/UnjwqTDY447Z/dLVt1q5CwUj+CMtABSkDoe/
   9d4zWfgXLII+Efu5gEvXwIknyXeREMNpiUdW7EYqW7vpMOZxnDHHjqjcm
   O7jyl2MrFFTx8O/2V2O8VrCeTPc2HYtUE6Ix0LIflU1lJNSZHFZ/Za5HJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="457099429"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="457099429"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 10:52:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="772021666"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="772021666"
Received: from jfdev013vml03.jf.intel.com ([10.165.161.72])
  by fmsmga007.fm.intel.com with ESMTP; 27 Nov 2023 10:52:47 -0800
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     kan.liang@linux.intel.com, kyle.meyer@hpe.com,
        alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH v2 1/2] perf/x86/intel/uncore: Fix NULL pointer dereference issue in upi_fill_topology()
Date:   Mon, 27 Nov 2023 10:52:45 -0800
Message-Id: <20231127185246.2371939-2-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231127185246.2371939-1-alexander.antonov@linux.intel.com>
References: <20231127185246.2371939-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Antonov <alexander.antonov@linux.intel.com>

Get logical socket id instead of physical id in discover_upi_topology()
to avoid out-of-bound access on 'upi = &type->topology[nid][idx];' line
that leads to NULL pointer dereference in upi_fill_topology()

Fixes: f680b6e6062e ("perf/x86/intel/uncore: Enable UPI topology discovery for Icelake Server")
Reported-by: Kyle Meyer <kyle.meyer@hpe.com>
Tested-by: Kyle Meyer <kyle.meyer@hpe.com>
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 8250f0f59c2b..49bc27ab26ad 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5596,7 +5596,7 @@ static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, i
 	struct pci_dev *ubox = NULL;
 	struct pci_dev *dev = NULL;
 	u32 nid, gid;
-	int i, idx, ret = -EPERM;
+	int i, idx, lgc_pkg, ret = -EPERM;
 	struct intel_uncore_topology *upi;
 	unsigned int devfn;
 
@@ -5614,8 +5614,13 @@ static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, i
 		for (i = 0; i < 8; i++) {
 			if (nid != GIDNIDMAP(gid, i))
 				continue;
+			lgc_pkg = topology_phys_to_logical_pkg(i);
+			if (lgc_pkg < 0) {
+				ret = -EPERM;
+				goto err;
+			}
 			for (idx = 0; idx < type->num_boxes; idx++) {
-				upi = &type->topology[nid][idx];
+				upi = &type->topology[lgc_pkg][idx];
 				devfn = PCI_DEVFN(dev_link0 + idx, ICX_UPI_REGS_ADDR_FUNCTION);
 				dev = pci_get_domain_bus_and_slot(pci_domain_nr(ubox->bus),
 								  ubox->bus->number,
@@ -5626,6 +5631,7 @@ static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, i
 						goto err;
 				}
 			}
+			break;
 		}
 	}
 err:
-- 
2.25.1

