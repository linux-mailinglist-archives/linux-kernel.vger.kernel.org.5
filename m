Return-Path: <linux-kernel+bounces-110434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCA1885F00
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB880280A81
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3B313DBB6;
	Thu, 21 Mar 2024 16:52:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248F113DBA7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039946; cv=none; b=rUDgWHYPsOYvnlMB10On+paCYgLsv+rIPy8/CYCZqna0DVoFlliIqvexBOzwDf5DCJbUhPO83NjTPdyj1udQEaeurnvef6o6LPi/HAirsXia20kmgBhqwFOO7ikkvL1UAkvAgPNCsTQVV/78LOLxDuSYB/A2iC+8Tb8k5m0cCeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039946; c=relaxed/simple;
	bh=+5BvKf5htIBvRDp2qqOq0mTafg8fhw/l1D7nUZ7vM6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S5czH/XRcPoNZBdn0SqAY2EdQ1s6M3vLekJneQcGijuUrGS507Pxbkw7OIvijpViVxSuwHVKf37I3Sj8WPtqA7yLCdy7dAbd3tQIs3vONLKn1MS+39hLX6kWD+lfFewCIlVNO0NYglJm7nOlfhuk9J7d73MFCl5vMAtPRiC2TGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05EBD1063;
	Thu, 21 Mar 2024 09:52:59 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBE6A3F67D;
	Thu, 21 Mar 2024 09:52:21 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>
Subject: [PATCH v1 17/31] x86/resctrl: Move mbm_cfg_mask to struct rdt_resource
Date: Thu, 21 Mar 2024 16:50:52 +0000
Message-Id: <20240321165106.31602-18-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240321165106.31602-1-james.morse@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mbm_cfg_mask field lists the bits that user-space can set when
configuring an event. This value is output via the last_cmd_status
file.

Once the filesystem parts of resctrl are moved to live in /fs/, the
struct rdt_hw_resource is inaccessible to the filesystem code. Because
this value is output to user-space, it has to be accessible to the
filesystem code.

Move it to struct rdt_resource.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 3 ---
 arch/x86/kernel/cpu/resctrl/monitor.c  | 2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 5 ++---
 include/linux/resctrl.h                | 3 +++
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 46370eafb00f..238b81d3f64a 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -371,8 +371,6 @@ struct msr_param {
  * @msr_update:		Function pointer to update QOS MSRs
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
  * @mbm_width:		Monitor width, to detect and correct for overflow.
- * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
- *			Monitoring Event Configuration (BMEC) is supported.
  * @cdp_enabled:	CDP state of this resource
  *
  * Members of this structure are either private to the architecture
@@ -387,7 +385,6 @@ struct rdt_hw_resource {
 				 struct rdt_resource *r);
 	unsigned int		mon_scale;
 	unsigned int		mbm_width;
-	unsigned int		mbm_cfg_mask;
 	bool			cdp_enabled;
 };
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index ccb85c61b43b..287fb0a5f060 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1068,7 +1068,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 
 		/* Detect list of bandwidth sources that can be tracked */
 		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
-		hw_res->mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
+		r->mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
 	}
 
 	r->mon_capable = true;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e76018687117..3d3a839eba6b 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1731,7 +1731,6 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 
 static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 {
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	char *dom_str = NULL, *id_str;
 	unsigned long dom_id, val;
 	struct rdt_domain *d;
@@ -1758,9 +1757,9 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 	}
 
 	/* Value from user cannot be more than the supported set of events */
-	if ((val & hw_res->mbm_cfg_mask) != val) {
+	if ((val & r->mbm_cfg_mask) != val) {
 		rdt_last_cmd_printf("Invalid event configuration: max valid mask is 0x%02x\n",
-				    hw_res->mbm_cfg_mask);
+				    r->mbm_cfg_mask);
 		return -EINVAL;
 	}
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 975b80102fbe..8a7367d1ce45 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -140,6 +140,8 @@ struct resctrl_membw {
  * @format_str:		Per resource format string to show domain value
  * @evt_list:		List of monitoring events
  * @fflags:		flags to choose base and info files
+ * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
+ *			Monitoring Event Configuration (BMEC) is supported.
  * @cdp_capable:	Is the CDP feature available on this resource
  */
 struct rdt_resource {
@@ -157,6 +159,7 @@ struct rdt_resource {
 	const char		*format_str;
 	struct list_head	evt_list;
 	unsigned long		fflags;
+	unsigned int		mbm_cfg_mask;
 	bool			cdp_capable;
 };
 
-- 
2.39.2


