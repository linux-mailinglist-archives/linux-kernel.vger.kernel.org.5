Return-Path: <linux-kernel+bounces-160235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C48E8B3ACB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0731C214B0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7272416D9DC;
	Fri, 26 Apr 2024 15:10:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD8816DEAC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144207; cv=none; b=nWs39c4P2teDw9rf+J+DlcSwxSDXDISb3BrBMrfm26uAeVnO3rOELjuJaAjKvxXMRT92S70FlKMRg7y4bqN+xXo70mdqob/9WIybEICA3lcze7WZu72wsYsHbYLPJpnwP9EFec8y2DPYWFe2WB4j71Ylksi6yldKy4va4Hgvo0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144207; c=relaxed/simple;
	bh=JB3w90fALHf1e+TEkMMiZKpOwO4/bleEIlZ3LfQUYZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C7l/aVpHAkXeGJvg2TeJHddJbCT0lQsc+XQtq8iZawvRz8IIiNctFCzUulDwflzCOaJ1TD6iOQIexMAFCgz/Cn/E0GcIo4gAWi03DbL8brgVSY2kqwCgbeFD3mYsNyJ6n+NvR7iGC4Z1uYUYBEReb8EY9KZqS5lojtD0c9fFlZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B3771596;
	Fri, 26 Apr 2024 08:10:33 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 080C93F73F;
	Fri, 26 Apr 2024 08:10:01 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	Peter Newman <peternewman@google.com>,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: [PATCH v2 17/35] x86/resctrl: Move mbm_cfg_mask to struct rdt_resource
Date: Fri, 26 Apr 2024 16:08:46 +0100
Message-Id: <20240426150904.8854-17-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426150904.8854-1-Dave.Martin@arm.com>
References: <20240426150537.8094-1-Dave.Martin@arm.com>
 <20240426150904.8854-1-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Morse <james.morse@arm.com>

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

FYI: Dave Martin (et al.):

 * Reword comments to avoid being overly arch-specific.

   Is the _content_ of mbm_cfg_mask arch-independent?

Changes in v2:

   (none)
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
index 372c35b4f633..403655b49081 100644
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
index 590a12df00b3..ef9c30a2eace 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1729,7 +1729,6 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 
 static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 {
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	char *dom_str = NULL, *id_str;
 	unsigned long dom_id, val;
 	struct rdt_domain *d;
@@ -1756,9 +1755,9 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
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
index e8d5f2828415..2f71ae690640 100644
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
2.34.1


