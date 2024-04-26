Return-Path: <linux-kernel+bounces-160234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F2D8B3ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629371F27435
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F70C16D9D1;
	Fri, 26 Apr 2024 15:10:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6284316C87B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144203; cv=none; b=qIseEe7f3jdBAMYbSMd380LwPPLRbzXMVOY4dMkvX7o3HUnfzI9iAtqON5n0fSGaKDWtFQwUeXnDpVcXGlZfBygxBpRNynehMoO/yNpI01lZD4tnRiv0N1op4gqfvyRohzQdrPaXkjEV9KVChOAocmpKRFrVzEN6Fd853N3KHC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144203; c=relaxed/simple;
	bh=S657cfG7SUvRVg7X3YG88hJswklUjd1kuLvFZ8FJR1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xs6ixRFrIdQpaYR829mwzQk49DXY6vYIJsRqzOdoLDSJLkMgJhar8JrLl21bTvBqvXPdoJdO5OHKvBfi3TzrRQf054N7qiJ4xcvYE858XhtwudYluOfrLayqqymewRRESbUdrPSzbQYgoDrQ6KQVeylbtfNx8TWIRaum0N1CMwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA5C215DB;
	Fri, 26 Apr 2024 08:10:29 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5B7C3F8A4;
	Fri, 26 Apr 2024 08:09:58 -0700 (PDT)
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
Subject: [PATCH v2 16/35] x86/resctrl: Change mon_event_config_{read,write}() to be arch helpers
Date: Fri, 26 Apr 2024 16:08:45 +0100
Message-Id: <20240426150904.8854-16-Dave.Martin@arm.com>
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

mon_event_config_{read,write}() are called via IPI and access model
specific registers to do their work.

To support another architecture, this needs abstracting.

Rename mon_event_config_{read,write}() to have a "resctrl_arch_"
prefix, and move their struct mon_config_info parameter into
<linux/resctrl.h>.  This allows another architecture to supply an
implementation of these.

As struct mon_config_info is now exposed globally, give it a 'resctrl_'
prefix. MPAM systems need access to the domain to do this work, add
the resource and domain to struct resctrl_mon_config_info.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Changes in v2:

 * [Whitespace only] Re-tabbed struct resctrl_mon_config_info in
   <linux/resctrl.h> to fit the prevailing style.

   Non-functional change.

 * [Commit message only] Reword to align with the actual naming of the
   definitions and destination header file.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 34 +++++++++++++-------------
 include/linux/resctrl.h                |  9 +++++++
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index ee28266d7864..590a12df00b3 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1578,11 +1578,6 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 	return ret;
 }
 
-struct mon_config_info {
-	u32 evtid;
-	u32 mon_config;
-};
-
 #define INVALID_CONFIG_INDEX   UINT_MAX
 
 /**
@@ -1607,9 +1602,9 @@ static inline unsigned int mon_event_config_index_get(u32 evtid)
 	}
 }
 
-static void mon_event_config_read(void *info)
+void resctrl_arch_mon_event_config_read(void *info)
 {
-	struct mon_config_info *mon_info = info;
+	struct resctrl_mon_config_info *mon_info = info;
 	unsigned int index;
 	u64 msrval;
 
@@ -1624,14 +1619,15 @@ static void mon_event_config_read(void *info)
 	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
 }
 
-static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
+static void mondata_config_read(struct resctrl_mon_config_info *mon_info)
 {
-	smp_call_function_any(&d->cpu_mask, mon_event_config_read, mon_info, 1);
+	smp_call_function_any(&mon_info->d->cpu_mask,
+			      resctrl_arch_mon_event_config_read, mon_info, 1);
 }
 
 static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
 {
-	struct mon_config_info mon_info = {0};
+	struct resctrl_mon_config_info mon_info = {0};
 	struct rdt_domain *dom;
 	bool sep = false;
 
@@ -1642,9 +1638,11 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
 		if (sep)
 			seq_puts(s, ";");
 
-		memset(&mon_info, 0, sizeof(struct mon_config_info));
+		memset(&mon_info, 0, sizeof(struct resctrl_mon_config_info));
+		mon_info.r = r;
+		mon_info.d = dom;
 		mon_info.evtid = evtid;
-		mondata_config_read(dom, &mon_info);
+		mondata_config_read(&mon_info);
 
 		seq_printf(s, "%d=0x%02x", dom->id, mon_info.mon_config);
 		sep = true;
@@ -1677,9 +1675,9 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
 	return 0;
 }
 
-static void mon_event_config_write(void *info)
+void resctrl_arch_mon_event_config_write(void *info)
 {
-	struct mon_config_info *mon_info = info;
+	struct resctrl_mon_config_info *mon_info = info;
 	unsigned int index;
 
 	index = mon_event_config_index_get(mon_info->evtid);
@@ -1693,14 +1691,16 @@ static void mon_event_config_write(void *info)
 static void mbm_config_write_domain(struct rdt_resource *r,
 				    struct rdt_domain *d, u32 evtid, u32 val)
 {
-	struct mon_config_info mon_info = {0};
+	struct resctrl_mon_config_info mon_info = {0};
 
 	/*
 	 * Read the current config value first. If both are the same then
 	 * no need to write it again.
 	 */
+	mon_info.r = r;
+	mon_info.d = d;
 	mon_info.evtid = evtid;
-	mondata_config_read(d, &mon_info);
+	mondata_config_read(&mon_info);
 	if (mon_info.mon_config == val)
 		return;
 
@@ -1712,7 +1712,7 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 	 * are scoped at the domain level. Writing any of these MSRs
 	 * on one CPU is observed by all the CPUs in the domain.
 	 */
-	smp_call_function_any(&d->cpu_mask, mon_event_config_write,
+	smp_call_function_any(&d->cpu_mask, resctrl_arch_mon_event_config_write,
 			      &mon_info, 1);
 
 	/*
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 1a8d44ef765b..e8d5f2828415 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -192,6 +192,13 @@ struct resctrl_cpu_defaults {
 	u32 rmid;
 };
 
+struct resctrl_mon_config_info {
+	struct rdt_resource	*r;
+	struct rdt_domain	*d;
+	u32			evtid;
+	u32			mon_config;
+};
+
 /**
  * resctrl_arch_sync_cpu_closid_rmid() - Refresh this CPU's CLOSID and RMID.
  *					 Call via IPI.
@@ -216,6 +223,8 @@ struct rdt_domain *resctrl_arch_find_domain(struct rdt_resource *r, int id);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 
 bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
+void resctrl_arch_mon_event_config_write(void *info);
+void resctrl_arch_mon_event_config_read(void *info);
 
 /*
  * Update the ctrl_val and apply this config right now.
-- 
2.34.1


