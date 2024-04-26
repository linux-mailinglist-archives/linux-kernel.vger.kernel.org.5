Return-Path: <linux-kernel+bounces-160236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9338B3ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5331E1F277E3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F50E16F0CD;
	Fri, 26 Apr 2024 15:10:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A359416EC0B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144210; cv=none; b=izPLjwntNaze0TW/iv4voenmj5NJQg0veWbeVqdmvREQmjVAe921dkaJaM6J9ceSBjcpgIWSn9grj8YhwmvmqcxwdAn2tZzr62Xn6jTUG0slEGSYbPr5rGkLpeBujZLy6jdDiGY9DAkYPb7vrsN8O9dq/HyIiLAgJfowXZWpMr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144210; c=relaxed/simple;
	bh=fwuE54yTuJ+vdterpl70TBqMp9QNQHFArAwZTmcSjpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K303NmqomQNcIrJ4K7tq2Jm8JrPcunMbflzBZjw9W00zKx+/eUq4xQsu8TXCQsDIMUj/HgRe2Fx9rX3vOXCcVWX7bWrqBhKqsp4uZqWDP80WOfvaoHeG0X5cv5BNfCcP/IXBwVub9kHWNiVoUs9GoDOaNUdqlvU6rpU8GtkKeS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 525CF15A1;
	Fri, 26 Apr 2024 08:10:36 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D10B3F73F;
	Fri, 26 Apr 2024 08:10:05 -0700 (PDT)
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
Subject: [PATCH v2 18/35] x86/resctrl: Allow resctrl_arch_mon_event_config_write() to return an error
Date: Fri, 26 Apr 2024 16:08:47 +0100
Message-Id: <20240426150904.8854-18-Dave.Martin@arm.com>
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

resctrl_arch_mon_event_config_write() writes a bitmap of events provided
by user-space into the configuration register for the monitors.

This assumes that all architectures support all the features each bit
corresponds to.

MPAM can filter monitors based on read, write, or both, but there are
many more options in the existing bitmap. To allow this interface to
work for machines with MPAM, allow the architecture helper to return
an error if an incompatible bitmap is set.

When valid values are provided, there is no change in behaviour. If
an invalid value is provided, currently it is silently ignored, but
last_cmd_status is updated. After this change, the parser will stop
at the first invalid value and return an error to user-space. This
matches the way changes to the schemata file are made.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

FYI: James Morse (et al.):

 * Can this patch be dropped?

   It looks like the core code will handling checking cfg values
   gracefully if the arch backend initialises rdt_resource::
   mbm_cfg_mask to something suitable?

   Is there any reason why we can't detect bad values globally before
   cross-calling?

Changes in v2:

 * [Whitespace only] Re-tabbed resctrl_mon_config_info::err field
   declaration in <linux/resctrl.h> to match the prevailing style.

   No functional change.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 20 ++++++++++++++++----
 include/linux/resctrl.h                |  1 +
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index ef9c30a2eace..38436e4c1741 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1683,13 +1683,16 @@ void resctrl_arch_mon_event_config_write(void *info)
 	index = mon_event_config_index_get(mon_info->evtid);
 	if (index == INVALID_CONFIG_INDEX) {
 		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
+		mon_info->err = -EINVAL;
 		return;
 	}
 	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
+
+	mon_info->err = 0;
 }
 
-static void mbm_config_write_domain(struct rdt_resource *r,
-				    struct rdt_domain *d, u32 evtid, u32 val)
+static int mbm_config_write_domain(struct rdt_resource *r,
+				   struct rdt_domain *d, u32 evtid, u32 val)
 {
 	struct resctrl_mon_config_info mon_info = {0};
 
@@ -1702,7 +1705,7 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 	mon_info.evtid = evtid;
 	mondata_config_read(&mon_info);
 	if (mon_info.mon_config == val)
-		return;
+		return 0;
 
 	mon_info.mon_config = val;
 
@@ -1714,6 +1717,10 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 	 */
 	smp_call_function_any(&d->cpu_mask, resctrl_arch_mon_event_config_write,
 			      &mon_info, 1);
+	if (mon_info.err) {
+		rdt_last_cmd_puts("Invalid event configuration\n");
+		return mon_info.err;
+	}
 
 	/*
 	 * When an Event Configuration is changed, the bandwidth counters
@@ -1725,6 +1732,8 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 	 * mbm_local and mbm_total counts for all the RMIDs.
 	 */
 	resctrl_arch_reset_rmid_all(r, d);
+
+	return 0;
 }
 
 static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
@@ -1732,6 +1741,7 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 	char *dom_str = NULL, *id_str;
 	unsigned long dom_id, val;
 	struct rdt_domain *d;
+	int err;
 
 	/* Walking r->domains, ensure it can't race with cpuhp */
 	lockdep_assert_cpus_held();
@@ -1763,7 +1773,9 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 
 	list_for_each_entry(d, &r->domains, list) {
 		if (d->id == dom_id) {
-			mbm_config_write_domain(r, d, evtid, val);
+			err = mbm_config_write_domain(r, d, evtid, val);
+			if (err)
+				return err;
 			goto next;
 		}
 	}
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 2f71ae690640..63d377e8cb87 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -200,6 +200,7 @@ struct resctrl_mon_config_info {
 	struct rdt_domain	*d;
 	u32			evtid;
 	u32			mon_config;
+	int			err;
 };
 
 /**
-- 
2.34.1


