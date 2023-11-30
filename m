Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BEF7FF044
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345595AbjK3Ngg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345597AbjK3Ngf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:36:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0C61708;
        Thu, 30 Nov 2023 05:36:41 -0800 (PST)
Date:   Thu, 30 Nov 2023 13:36:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701351399;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fbl1oUzoGgtbkHkBB7BIUyOTa3IbdWtj1e1FAc0Hemc=;
        b=UiNlZ5rJaIN/jmMRI2jTYGIs6bLnGpx7A7vAx9N9XUpRJ34VFFe7JZG6UUkd6BVCi1y7Gh
        fybXiUBe2Yzz6XatAozshpIINAchyHLj5lsci+1983f0NUIfi3pAk4ucn0rqiI8snWhFeG
        wcOa+/C+BDjlwvAiAX4irHi4axyp8XYvErMnntzkgzdd0aTlBwtVfgpGk1Pfx+kBefxGuj
        jzfjZlNhZCAwPJofRvnV1SaWnKbTiQ+tHTFDj58ayouehRiYEhaHiw1zHQF0U5oS7ASPZf
        iN1ncj1J9p6PCfKyOZEJL6dM0PL/UH1cCIMMu8v3/3j+LVBSqjzUsOSs1GTrdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701351399;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fbl1oUzoGgtbkHkBB7BIUyOTa3IbdWtj1e1FAc0Hemc=;
        b=Ct/Was1uF932MkXGaj5DGtZng0XMPQNSVhOz9HRcNwapPyJVNDj/g9NA5+yzukRGYEVGy+
        1RBLAOV5uEzBgIAg==
From:   "tip-bot2 for Alexander Antonov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Factor out topology_gidnid_map()
Cc:     Alexander Antonov <alexander.antonov@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231127185246.2371939-3-alexander.antonov@linux.intel.com>
References: <20231127185246.2371939-3-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <170135139879.398.10433431926205311280.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     fdd041028f2294228e10610b4fca6a1a83ac683d
Gitweb:        https://git.kernel.org/tip/fdd041028f2294228e10610b4fca6a1a83ac683d
Author:        Alexander Antonov <alexander.antonov@linux.intel.com>
AuthorDate:    Mon, 27 Nov 2023 10:52:46 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Nov 2023 14:29:53 +01:00

perf/x86/intel/uncore: Factor out topology_gidnid_map()

The same code is used for retrieving package ID procedure from GIDNIDMAP
register. Factor out topology_gidnid_map() to avoid code duplication.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20231127185246.2371939-3-alexander.antonov@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 77 ++++++++++++++-------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 1efbacf..a96496b 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1396,6 +1396,29 @@ err:
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
