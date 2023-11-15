Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570EF7EC6E5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344454AbjKOPNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344433AbjKOPNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:13:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8A498
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700061208; x=1731597208;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OnPaiXAOhBiP6LV5TOJMCST2i8qrHexK4o80WvI5Yj4=;
  b=MLtaG8GqhlK1+qC/0+hn5DR5b/hMeomAjzBalbmC5Rp45QF8dqwI7hVa
   Q65vsDcch/QMu2PVRhBllEnirfAo8LKT5njN9rFGbO1D7gox7Gx/mS5PE
   i/XQwu/8RzZ2I5AqwUavGhqturXHH/7i9LPrQgjS31UIhMpqZ4Te7iec4
   fH25bHWNZnKDr2VTMs2jSTjvLpLhn5GOMpG5Edlt/hpUQHJcGrGb1UoV2
   ndfuFUiDxQVMI2VTk5w1trjqZt9V3q4tqc6DFFoqMVka2pAolQXkiaWgR
   ObEmeAhZDgrEYQHogyZNF+1l3sBjHDMcXLuBMza0R09k2kAF1A8OJ8xQl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="393747736"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="393747736"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 07:13:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="765005022"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="765005022"
Received: from jfdev013vml03.jf.intel.com ([10.165.161.72])
  by orsmga002.jf.intel.com with ESMTP; 15 Nov 2023 07:13:28 -0800
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     kyle.meyer@hpe.com, kan.liang@linux.intel.com,
        alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH] perf/x86/intel/uncore: Fix NULL pointer dereference issue in upi_fill_topology()
Date:   Wed, 15 Nov 2023 07:13:27 -0800
Message-Id: <20231115151327.1874060-1-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Antonov <alexander.antonov@linux.intel.com>

The NULL dereference happens inside upi_fill_topology() procedure in
case of disabling one of the sockets on the system.

For example, if you disable the 2nd socket on a 4-socket system then
uncore_max_dies() returns 3 and inside pmu_alloc_topology() memory will
be allocated only for 3 sockets and stored in type->topology.
In discover_upi_topology() memory is accessed by socket id from CPUNODEID
registers which contain physical ids (from 0 to 3) and on the line:

    upi = &type->topology[nid][idx];

out-of-bound access will happen and the 'upi' pointer will be passed to
upi_fill_topology() where it will be dereferenced.

To avoid this issue update the code to convert physical socket id to
logical socket id in discover_upi_topology() before accessing memory.

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

base-commit: 9bacdd8996c77c42ca004440be610692275ff9d0
-- 
2.25.1

