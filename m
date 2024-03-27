Return-Path: <linux-kernel+bounces-121956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B50D88EFD7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC13E299D61
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AC2153BC9;
	Wed, 27 Mar 2024 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jyHLOP04"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD90C153566
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569849; cv=none; b=oynUIWVOVwWci6dEoG9nEMVABTWacIVoXicj2+BEG1nLLKehQV6P7JKTglBWeCNvtG35hfM1EckLttFiAh3MHp9aCCju8JYuRu36a9ZEeregsglPFCA9PP03/srZhS2uHzh/vE+xjrLXfqR6z3ZXgpi5m7ILGKMCjOFfGyIGqQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569849; c=relaxed/simple;
	bh=GqHADRWSK9k2kWQziCyKzMojosS7K/TvpaCs77T6KdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0tCXcb+gviKlHnYHAZv3RFQELpnO7ETDqY7QJ0JyCwDvoxpdy1kDPcXlGEdAqDV+Kjbnovoczx5bLIadMUFG42O42whlEYI3LBiBCY9TQkAid5j7d3E3aVk2GahpF6pf2lE6Ymi2ztrGnbnLgHm1ab1pj+0KlHMeYvuD/mQVMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jyHLOP04; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711569848; x=1743105848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GqHADRWSK9k2kWQziCyKzMojosS7K/TvpaCs77T6KdU=;
  b=jyHLOP0445bVCpk3qaO1t2+DCiWKhDYKuCZOQoNuRWGEi1Pe7sjU+RTe
   tE/y703V9EkQdub/KNU3oLR1GvAY80qMbozZlnEykpfF/zXAehjrcChdC
   UNf57taGKei6lsxfC+t0uadyjTvOzjwvhCtx2u18GPUt2a7kTCc6/H0q3
   U/NndsYUem4pROT/XmcfBEcAUJzt6W41HpdKlL5VJVCJ0S6ysBfKgWZew
   FI512y9xQTI1hkcMqJfoQnSIzgAZuSrNAy80Pch83U6XK+emxFuTggMb2
   AK0z+LkQdYUjrs4FqrYAbd+pVllZ+WHlrY1jYi8aHHzWtd7wvlpYF9LyY
   Q==;
X-CSE-ConnectionGUID: 54Ry8GBST/K/+62+FZQCmw==
X-CSE-MsgGUID: 729fafhyQqKxT3jfucC0XA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="18133006"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="18133006"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 13:04:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16246133"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 13:04:03 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH 07/10] x86/resctrl: Update rmdir_mondata_subdir_allrdtgrp() for Sub-NUMA domains
Date: Wed, 27 Mar 2024 13:03:49 -0700
Message-ID: <20240327200352.236835-8-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327200352.236835-1-tony.luck@intel.com>
References: <20240327200352.236835-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Old code could simply remove the mon_L3_XX directory with all
contents when a domain was taken offline. With Sub-NUMA cluster
enabled this becomes a multi-stage process.

While the parent L3 domain is still online the offline process for
a SUBL3 domain removes just one directory from mon_L3_XX. When the
last such domain goes offline the whole mon_L3_XX must be removed.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 46 ++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 22effd8dc207..399dc3175292 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3012,17 +3012,49 @@ static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
  * and monitor groups with given domain id.
  */
 static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-					   unsigned int dom_id)
+					   struct rdt_domain *d)
 {
 	struct rdtgroup *prgrp, *crgrp;
-	char name[32];
+	char pname[32], name[32];
+	bool remove_all = false;
+	struct kernfs_node *kn;
+	struct rdt_domain *pd;
+
+	sprintf(name, "mon_%s_%02d", r->name, d->id);
+
+	if (!r->parent) {
+		list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
+			kernfs_remove_by_name(prgrp->mon.mon_data_kn, name);
+
+			list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
+				kernfs_remove_by_name(crgrp->mon.mon_data_kn, name);
+		}
+		return;
+	}
+
+	sprintf(pname, "mon_%s_%02d", r->parent->name, d->parent);
+	pd = get_parent_domain(r, d);
+	if (!pd)
+		remove_all = true;
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
-		sprintf(name, "mon_%s_%02d", r->name, dom_id);
-		kernfs_remove_by_name(prgrp->mon.mon_data_kn, name);
+		if (remove_all) {
+			kernfs_remove_by_name(prgrp->mon.mon_data_kn, pname);
+		} else {
+			kn = kernfs_find_and_get_ns(prgrp->mon.mon_data_kn, pname, NULL);
+			if (kn)
+				kernfs_remove_by_name(kn, name);
+		}
 
-		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
-			kernfs_remove_by_name(crgrp->mon.mon_data_kn, name);
+		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list) {
+			if (remove_all) {
+				kernfs_remove_by_name(crgrp->mon.mon_data_kn, pname);
+			} else {
+				kn = kernfs_find_and_get_ns(crgrp->mon.mon_data_kn, pname, NULL);
+				if (kn)
+					kernfs_remove_by_name(kn, name);
+			}
+		}
 	}
 }
 
@@ -3979,7 +4011,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
 	 * per domain monitor data directories.
 	 */
 	if (resctrl_mounted && resctrl_arch_mon_capable())
-		rmdir_mondata_subdir_allrdtgrp(r, d->id);
+		rmdir_mondata_subdir_allrdtgrp(r, d);
 
 	if (is_mbm_enabled())
 		cancel_delayed_work(&d->mbm_over);
-- 
2.44.0


