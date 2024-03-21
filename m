Return-Path: <linux-kernel+bounces-110419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC81885EED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DBC284C54
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329871384BF;
	Thu, 21 Mar 2024 16:51:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F1C138497
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039901; cv=none; b=bkljFAf+1vlUdvOBhrao6AH3vJcaCHpry3vDTum6pTXpehaG6V9RDY3xEbpybiXl3uzbc+Xidy8srg2MKspwkWgl7WaiLVkncGJY5cme7rJloDxKvqTuPwhuhThRIlQUE4W7NI+7De2QoNA5YNNxZlIfZn9Le2Dg6lzc8FyUizc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039901; c=relaxed/simple;
	bh=Cws3wrVYTAT+jLldZUCn+6oJV9rvQBZ4AZ7z71pkCI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C+QIbA6zAGkD54O5M1UvH4Qmq85uTApF2rgo58xrndO1Jw1i0xc9zK1oxkI0aWLo5l1j5+eaqyEKdHPe409WLWMUZ38wIqHs2h4yxLkVaL/J6Tn0q6WXACM0/GZ9Q9sY2SjPbgrgegVSU+TUguDFtFrjvVpr9iORkpNG4LpXP+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85B621688;
	Thu, 21 Mar 2024 09:52:13 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 465983F67D;
	Thu, 21 Mar 2024 09:51:36 -0700 (PDT)
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
Subject: [PATCH v1 03/31] x86/resctrl: Move ctrlval string parsing policy away from the arch code
Date: Thu, 21 Mar 2024 16:50:38 +0000
Message-Id: <20240321165106.31602-4-james.morse@arm.com>
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

The policy for parsing the configuration values as a string from
user-space is specified by a function pointer the arch code specifies.

These strings are part of resctrl's ABI, and the functions and their
caller both live in the same file. Exporting the parsing functions and
allowing the architecture to choose how a schema is parsed allows an
architecture to get this wrong.

Keep this all in the flesystem parts of resctrl. This should prevent any
architecture's string-parsing behaviour from varying without core code
changes. Use the fflags to spot caches and bandwidth resources, and use
the appropriate helper.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c        |  4 ----
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 28 +++++++++++++++++++----
 arch/x86/kernel/cpu/resctrl/internal.h    | 10 --------
 include/linux/resctrl.h                   |  7 ------
 4 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b773b3bdebe3..d07eff7d6750 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -75,7 +75,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.name			= "L3",
 			.cache_level		= 3,
 			.domains		= domain_init(RDT_RESOURCE_L3),
-			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
 			.fflags			= RFTYPE_RES_CACHE,
 		},
@@ -89,7 +88,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.name			= "L2",
 			.cache_level		= 2,
 			.domains		= domain_init(RDT_RESOURCE_L2),
-			.parse_ctrlval		= parse_cbm,
 			.format_str		= "%d=%0*x",
 			.fflags			= RFTYPE_RES_CACHE,
 		},
@@ -103,7 +101,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.name			= "MB",
 			.cache_level		= 3,
 			.domains		= domain_init(RDT_RESOURCE_MBA),
-			.parse_ctrlval		= parse_bw,
 			.format_str		= "%d=%*u",
 			.fflags			= RFTYPE_RES_MB,
 		},
@@ -115,7 +112,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.name			= "SMBA",
 			.cache_level		= 3,
 			.domains		= domain_init(RDT_RESOURCE_SMBA),
-			.parse_ctrlval		= parse_bw,
 			.format_str		= "%d=%*u",
 			.fflags			= RFTYPE_RES_MB,
 		},
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 788ac0395645..72a651671c68 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -23,6 +23,15 @@
 
 #include "internal.h"
 
+struct rdt_parse_data {
+	struct rdtgroup		*rdtgrp;
+	char			*buf;
+};
+
+typedef int (ctrlval_parser_t)(struct rdt_parse_data *data,
+			       struct resctrl_schema *s,
+			       struct rdt_domain *d);
+
 /*
  * Check whether MBA bandwidth percentage value is correct. The value is
  * checked against the minimum and max bandwidth values specified by the
@@ -59,8 +68,8 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 	return true;
 }
 
-int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
-	     struct rdt_domain *d)
+static int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
+		    struct rdt_domain *d)
 {
 	struct resctrl_staged_config *cfg;
 	u32 closid = data->rdtgrp->closid;
@@ -138,8 +147,8 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
  * Read one cache bit mask (hex). Check that it is valid for the current
  * resource type.
  */
-int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
-	      struct rdt_domain *d)
+static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
+		     struct rdt_domain *d)
 {
 	struct rdtgroup *rdtgrp = data->rdtgrp;
 	struct resctrl_staged_config *cfg;
@@ -195,6 +204,14 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 	return 0;
 }
 
+static ctrlval_parser_t *get_parser(struct rdt_resource *res)
+{
+	if (res->fflags & RFTYPE_RES_CACHE)
+		return &parse_cbm;
+	else
+		return &parse_bw;
+}
+
 /*
  * For each domain in this resource we expect to find a series of:
  *	id=mask
@@ -204,6 +221,7 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 static int parse_line(char *line, struct resctrl_schema *s,
 		      struct rdtgroup *rdtgrp)
 {
+	ctrlval_parser_t *parse_ctrlval = get_parser(s->res);
 	enum resctrl_conf_type t = s->conf_type;
 	struct resctrl_staged_config *cfg;
 	struct rdt_resource *r = s->res;
@@ -235,7 +253,7 @@ static int parse_line(char *line, struct resctrl_schema *s,
 		if (d->id == dom_id) {
 			data.buf = dom;
 			data.rdtgrp = rdtgrp;
-			if (r->parse_ctrlval(&data, s, d))
+			if (parse_ctrlval(&data, s, d))
 				return -EINVAL;
 			if (rdtgrp->mode ==  RDT_MODE_PSEUDO_LOCKSETUP) {
 				cfg = &d->staged_config[t];
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 65990def6c79..9048bd32e86f 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -413,11 +413,6 @@ static inline bool is_mbm_event(int e)
 		e <= QOS_L3_MBM_LOCAL_EVENT_ID);
 }
 
-struct rdt_parse_data {
-	struct rdtgroup		*rdtgrp;
-	char			*buf;
-};
-
 /**
  * struct rdt_hw_resource - arch private attributes of a resctrl resource
  * @r_resctrl:		Attributes of the resource used directly by resctrl.
@@ -455,11 +450,6 @@ static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r
 	return container_of(r, struct rdt_hw_resource, r_resctrl);
 }
 
-int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
-	      struct rdt_domain *d);
-int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
-	     struct rdt_domain *d);
-
 extern struct mutex rdtgroup_mutex;
 
 extern struct rdt_hw_resource rdt_resources_all[];
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 168cc9510069..6e87bc95f5ea 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -157,9 +157,6 @@ struct resctrl_membw {
 	u32				*mb_map;
 };
 
-struct rdt_parse_data;
-struct resctrl_schema;
-
 /**
  * struct rdt_resource - attributes of a resctrl resource
  * @rid:		The index of the resource
@@ -174,7 +171,6 @@ struct resctrl_schema;
  * @data_width:		Character width of data when displaying
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
  * @format_str:		Per resource format string to show domain value
- * @parse_ctrlval:	Per resource function pointer to parse control values
  * @evt_list:		List of monitoring events
  * @fflags:		flags to choose base and info files
  * @cdp_capable:	Is the CDP feature available on this resource
@@ -192,9 +188,6 @@ struct rdt_resource {
 	int			data_width;
 	u32			default_ctrl;
 	const char		*format_str;
-	int			(*parse_ctrlval)(struct rdt_parse_data *data,
-						 struct resctrl_schema *s,
-						 struct rdt_domain *d);
 	struct list_head	evt_list;
 	unsigned long		fflags;
 	bool			cdp_capable;
-- 
2.39.2


