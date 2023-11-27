Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444FE7FA94F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjK0Swq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjK0Swm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:52:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE29ED53
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701111168; x=1732647168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ved484hMflg1uejnWxZA/HJTIWezl+O92VCJjsNlJzY=;
  b=R9qrFL/S256HsN+Uvv5OxZQeT2e+QAcXau8pnxju9UONZtR1olidKiSa
   ZHwKMt8pwZNuKE1/M9JACVQ3r4lcLY2Va7euHaYmvqsJp2oO99mAjLkJ5
   b1p/Ho/v6gQme4y1PVfvrnILdPVjVGLg+MK9nXFxJ5+EKMIorCYYZAWOs
   GuoGYy32s4UzSBwugzERIy2pzArj+O/855Hr3i1z0Q78MnnviCH/15ZBw
   nAqOjQ5dCrkKnQnLUmgtEBltwoXbUbknEzqc+IsVBDYKjgcmVbBzYeePc
   eJbIA8N0VxmnhaNvYvtnOuLvKzp+JpChRpKTD2qzTiqXacZ1Ch05tDH49
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="457099432"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="457099432"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 10:52:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="772021668"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="772021668"
Received: from jfdev013vml03.jf.intel.com ([10.165.161.72])
  by fmsmga007.fm.intel.com with ESMTP; 27 Nov 2023 10:52:47 -0800
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     kan.liang@linux.intel.com, kyle.meyer@hpe.com,
        alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH v2 2/2] perf/x86/intel/uncore: Factor out topology_gidnid_map()
Date:   Mon, 27 Nov 2023 10:52:46 -0800
Message-Id: <20231127185246.2371939-3-alexander.antonov@linux.intel.com>
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

The same code is used for retrieving package ID procedure from GIDNIDMAP
register. Factor out topology_gidnid_map() to avoid code duplication.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 77 +++++++++++++++-------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 49bc27ab26ad..3d918147a8a2 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1396,6 +1396,29 @@ static int upi_nodeid_groupid(struct pci_dev *ubox_dev, int nodeid_loc, int idma
 	return ret;
 }
 
+static int topology_gidnid_map(int nodeid, u32 gidnid)
+{
+	int i, die_id = -1;
+
+	/*
+	 * every three bits in the Node ID mapping register maps
+	 * to a particular node.
+	 */
+	for (i = 0; i < 8; i++) {
+		if (nodeid == GIDNIDMAP(gidnid, i)) {
+			if (topology_max_die_per_package() > 1)
+				die_id = i;
+			else
+				die_id = topology_phys_to_logical_pkg(i);
+			if (die_id < 0)
+				die_id = -ENODEV;
+			break;
+		}
+	}
+
+	return die_id;
+}
+
 /*
  * build pci bus to socket mapping
  */
@@ -1435,22 +1458,7 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 				break;
 			}
 
-			/*
-			 * every three bits in the Node ID mapping register maps
-			 * to a particular node.
-			 */
-			for (i = 0; i < 8; i++) {
-				if (nodeid == GIDNIDMAP(config, i)) {
-					if (topology_max_die_per_package() > 1)
-						die_id = i;
-					else
-						die_id = topology_phys_to_logical_pkg(i);
-					if (die_id < 0)
-						die_id = -ENODEV;
-					map->pbus_to_dieid[bus] = die_id;
-					break;
-				}
-			}
+			map->pbus_to_dieid[bus] = topology_gidnid_map(nodeid, config);
 			raw_spin_unlock(&pci2phy_map_lock);
 		} else {
 			segment = pci_domain_nr(ubox_dev->bus);
@@ -5596,7 +5604,7 @@ static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, i
 	struct pci_dev *ubox = NULL;
 	struct pci_dev *dev = NULL;
 	u32 nid, gid;
-	int i, idx, lgc_pkg, ret = -EPERM;
+	int idx, lgc_pkg, ret = -EPERM;
 	struct intel_uncore_topology *upi;
 	unsigned int devfn;
 
@@ -5611,27 +5619,22 @@ static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, i
 			break;
 		}
 
-		for (i = 0; i < 8; i++) {
-			if (nid != GIDNIDMAP(gid, i))
-				continue;
-			lgc_pkg = topology_phys_to_logical_pkg(i);
-			if (lgc_pkg < 0) {
-				ret = -EPERM;
-				goto err;
-			}
-			for (idx = 0; idx < type->num_boxes; idx++) {
-				upi = &type->topology[lgc_pkg][idx];
-				devfn = PCI_DEVFN(dev_link0 + idx, ICX_UPI_REGS_ADDR_FUNCTION);
-				dev = pci_get_domain_bus_and_slot(pci_domain_nr(ubox->bus),
-								  ubox->bus->number,
-								  devfn);
-				if (dev) {
-					ret = upi_fill_topology(dev, upi, idx);
-					if (ret)
-						goto err;
-				}
+		lgc_pkg = topology_gidnid_map(nid, gid);
+		if (lgc_pkg < 0) {
+			ret = -EPERM;
+			goto err;
+		}
+		for (idx = 0; idx < type->num_boxes; idx++) {
+			upi = &type->topology[lgc_pkg][idx];
+			devfn = PCI_DEVFN(dev_link0 + idx, ICX_UPI_REGS_ADDR_FUNCTION);
+			dev = pci_get_domain_bus_and_slot(pci_domain_nr(ubox->bus),
+							  ubox->bus->number,
+							  devfn);
+			if (dev) {
+				ret = upi_fill_topology(dev, upi, idx);
+				if (ret)
+					goto err;
 			}
-			break;
 		}
 	}
 err:
-- 
2.25.1

