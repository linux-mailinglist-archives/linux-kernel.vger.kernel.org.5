Return-Path: <linux-kernel+bounces-110435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE60885F01
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE81E281B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CBD13F00A;
	Thu, 21 Mar 2024 16:52:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9128113DBA7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039950; cv=none; b=sx+WU3aa+qwnTAt/EZ4S74Ra5YQTsf74VQ0SdBiZcyqRPeLr/2GPlSGWnHs+rXxKwCq4sFxKxA5XoctuC6oU0aeiGsNfOTdIC9NAVVh8ytsaH5asypREBHzeCw4t6h59ak3u73vDaq7t5Lgcz1+qrdSaHFdUuQvx9cKsB/rut8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039950; c=relaxed/simple;
	bh=WyuF2mCVFfgP/qcLiAkTCfTiFtu7/Z/fCShvVuhxHtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qHLQuCkIQcCbMtZ/Q5p8LE3CTU6VoRmplt8FnHJ3DNPhuHUp7GgYRRi+cBUFwsvO1GisF7HdIOll+EJ/6kUDHxAk/Q4IIWrxRJ6vACVebZMHgJ91l3h7WaCrLOigDuw5+4oyuQg7BpV6X5z5Petp+OiGIEv40fNWjtr55vilYnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4640D1688;
	Thu, 21 Mar 2024 09:53:02 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2F143F67D;
	Thu, 21 Mar 2024 09:52:24 -0700 (PDT)
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
Subject: [PATCH v1 18/31] x86/resctrl: Allow resctrl_arch_mon_event_config_write() to return an error
Date: Thu, 21 Mar 2024 16:50:53 +0000
Message-Id: <20240321165106.31602-19-james.morse@arm.com>
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
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 20 ++++++++++++++++----
 include/linux/resctrl.h                |  1 +
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 3d3a839eba6b..56a0bfdc11f7 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1685,13 +1685,16 @@ void resctrl_arch_mon_event_config_write(void *info)
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
 
@@ -1704,7 +1707,7 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 	mon_info.evtid = evtid;
 	mondata_config_read(&mon_info);
 	if (mon_info.mon_config == val)
-		return;
+		return 0;
 
 	mon_info.mon_config = val;
 
@@ -1716,6 +1719,10 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 	 */
 	smp_call_function_any(&d->cpu_mask, resctrl_arch_mon_event_config_write,
 			      &mon_info, 1);
+	if (mon_info.err) {
+		rdt_last_cmd_puts("Invalid event configuration\n");
+		return mon_info.err;
+	}
 
 	/*
 	 * When an Event Configuration is changed, the bandwidth counters
@@ -1727,6 +1734,8 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 	 * mbm_local and mbm_total counts for all the RMIDs.
 	 */
 	resctrl_arch_reset_rmid_all(r, d);
+
+	return 0;
 }
 
 static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
@@ -1734,6 +1743,7 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 	char *dom_str = NULL, *id_str;
 	unsigned long dom_id, val;
 	struct rdt_domain *d;
+	int err;
 
 	/* Walking r->domains, ensure it can't race with cpuhp */
 	lockdep_assert_cpus_held();
@@ -1765,7 +1775,9 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 
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
index 8a7367d1ce45..6705d7960dfd 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -200,6 +200,7 @@ struct resctrl_mon_config_info {
 	struct rdt_domain   *d;
 	u32                  evtid;
 	u32                  mon_config;
+	int                  err;
 };
 
 /*
-- 
2.39.2


