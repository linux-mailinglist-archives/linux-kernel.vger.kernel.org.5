Return-Path: <linux-kernel+bounces-121955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8700988EFD6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E421F33E93
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9BF15381B;
	Wed, 27 Mar 2024 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WaTh3hwz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD06153501
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569848; cv=none; b=tb71K0bG7qMhzUpEUjapguxATb6a80//TbSIRso9+fjY2HcbAJ+e1rYbIFBrK0mF1gvwqfYd+XWfxoRp3hDv7VQJobnreJT05kN/YmB9r2oZza4sOUb2HvAguBpkIkO5sYODBE/2Jf8sWRbdbW+976LJPj2Xh7gvd0DZNk0G4XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569848; c=relaxed/simple;
	bh=PviGf2ukuqvClh6Tzg6t+9sRC+0cgDfB2kvycRzoQFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sz5MEHq2E50j/VmlReUsdbQsgFw5DFacLEk2UlRiCdRPVsOdyd2Cddc6g54U5FOgh+XvcKGsAe6vpyNAQi4jbs0VwhCrclYIPKttJqXJ71fDfAtZkM9L2scI+LaUwUZYI1v7HuyMjc3qDMZ7oA+O/CWDAbKF2Wetrbgh+heNYoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WaTh3hwz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711569847; x=1743105847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PviGf2ukuqvClh6Tzg6t+9sRC+0cgDfB2kvycRzoQFo=;
  b=WaTh3hwzWaE0WVUrIuUPcwwhbOOdEXYhi1eqWCNQTFTZBm3vGWEBaaro
   sLfvhkiwhQR/PO81MqmMvtkTAxgvV+eEhNMHSj4gkBDd6Yv+1bgrOiLC/
   UBUWyp1fo3Gjwy+harQfhHYvJ97IBSc709NwZUGr3tTHfrKXBKYVbE5Rm
   RmH0bEguYS4fnMV+th68i44T1cWN9e4jZvcGdEKyB4rhnl37/28wYwzQt
   PcbbfVrsrW96dv+MIxAd2oqCVJ/xD3zOe6ooyt9ZoklbGGE718VmJaFDf
   Ea1G1IVpyihCuVa2hd0fJgCgDXJdvfaQDOMW1PJUlcw8PhRyYPRrBGIz/
   w==;
X-CSE-ConnectionGUID: AKLxWARnTd2Bqhzzg331Nw==
X-CSE-MsgGUID: O1pdmX1uS9SW3oiU7qXAyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="18132999"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="18132999"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 13:04:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16246128"
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
Subject: [PATCH 06/10] x86/resctrl: Update mkdir_mondata_subdir() for Sub-NUMA domains
Date: Wed, 27 Mar 2024 13:03:48 -0700
Message-ID: <20240327200352.236835-7-tony.luck@intel.com>
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

When Sub-NUMA domain mode is enabled all the monitoring happens
at the SUBL3 resource level. Changes are required to populate the
"mon_data" directories in the resctrl file system.

When making the first SUBL3 directory code must first create the
parent mon_L3_XX directory and fill it with files for each of
the monitoring functions. Subsequent SUBL3 creation requests will
simply use the directory that was created by the first request.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 12 +++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 74 ++++++++++++++++++--------
 2 files changed, 65 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 21d81f51838f..7f05502454c5 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -456,6 +456,18 @@ static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r
 	return container_of(r, struct rdt_hw_resource, r_resctrl);
 }
 
+static inline struct rdt_domain *get_parent_domain(struct rdt_resource *r,
+						   struct rdt_domain *d)
+{
+	struct  rdt_domain *pd;
+
+	list_for_each_entry(pd, &r->parent->domains, list)
+		if (pd->id == d->parent)
+			return pd;
+
+	return NULL;
+}
+
 int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 	      struct rdt_domain *d);
 int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f2af58a791a4..22effd8dc207 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3026,31 +3026,16 @@ static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 	}
 }
 
-static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
-				struct rdt_domain *d,
-				struct rdt_resource *r, struct rdtgroup *prgrp)
+static int mon_add_all_files(struct kernfs_node *kn, struct rdt_domain *d,
+			     struct rdt_resource *r, struct rdtgroup *prgrp)
 {
 	union mon_data_bits priv;
-	struct kernfs_node *kn;
 	struct mon_evt *mevt;
 	struct rmid_read rr;
-	char name[32];
 	int ret;
 
-	sprintf(name, "mon_%s_%02d", r->name, d->id);
-	/* create the directory */
-	kn = kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
-	if (IS_ERR(kn))
-		return PTR_ERR(kn);
-
-	ret = rdtgroup_kn_set_ugid(kn);
-	if (ret)
-		goto out_destroy;
-
-	if (WARN_ON(list_empty(&r->evt_list))) {
-		ret = -EPERM;
-		goto out_destroy;
-	}
+	if (WARN_ON(list_empty(&r->evt_list)))
+		return -EPERM;
 
 	priv.u.rid = r->rid;
 	priv.u.domid = d->id;
@@ -3058,11 +3043,58 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 		priv.u.evtid = mevt->evtid;
 		ret = mon_addfile(kn, mevt->name, priv.priv);
 		if (ret)
-			goto out_destroy;
+			return ret;
 
 		if (is_mbm_event(mevt->evtid))
 			mon_event_read(&rr, r, d, prgrp, mevt->evtid, true);
 	}
+
+	return 0;
+}
+
+static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
+				struct rdt_domain *d,
+				struct rdt_resource *r, struct rdtgroup *prgrp)
+{
+	struct kernfs_node *kn = parent_kn, *ckn;
+	struct rdt_domain *pd;
+	char name[32];
+	int ret;
+
+	if (r->parent) {
+		pd = get_parent_domain(r, d);
+		if (!pd)
+			return 0;
+		sprintf(name, "mon_%s_%02d", r->parent->name, pd->id);
+		kn = kernfs_find_and_get_ns(parent_kn, name, NULL);
+		if (kn) {
+			parent_kn = kn;
+			goto subdir;
+		}
+		kn = kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
+		if (IS_ERR(kn))
+			return PTR_ERR(kn);
+		ret = rdtgroup_kn_set_ugid(kn);
+		if (ret)
+			goto out_destroy;
+		ret = mon_add_all_files(kn, d, r, prgrp);
+		if (ret)
+			goto out_destroy;
+	}
+subdir:
+	sprintf(name, "mon_%s_%02d", r->name, d->id);
+	/* create the directory */
+	ckn = kernfs_create_dir(kn, name, parent_kn->mode, prgrp);
+	if (IS_ERR(ckn))
+		goto out_destroy;
+
+	ret = rdtgroup_kn_set_ugid(ckn);
+	if (ret)
+		goto out_destroy;
+
+	ret = mon_add_all_files(ckn, d, r, prgrp);
+	if (ret)
+		goto out_destroy;
 	kernfs_activate(kn);
 	return 0;
 
@@ -3078,8 +3110,8 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 static void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
 					   struct rdt_domain *d)
 {
-	struct kernfs_node *parent_kn;
 	struct rdtgroup *prgrp, *crgrp;
+	struct kernfs_node *parent_kn;
 	struct list_head *head;
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
-- 
2.44.0


