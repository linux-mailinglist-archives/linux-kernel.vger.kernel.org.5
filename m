Return-Path: <linux-kernel+bounces-121951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E910088EFCE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1855B1C35028
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCAF1534FC;
	Wed, 27 Mar 2024 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pl4oGSM4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D06C1534E1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569846; cv=none; b=LKGYLVD99KmzCplAi87k4CBQj92OZ2a6no+I2JDjmMTWJPAK0XYRMMmY2N6Sv8kZDXxJX6uy4TlaF3nXOq93oQqWlXy1nGrAwcO7bEeRALqhGvOWC0573wTwxRy+KADLs4mpC+2aDBUuOgHc48FyqgHyTkxA2GYorWSJ9HB267A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569846; c=relaxed/simple;
	bh=p9PxKFKNPcVQ3UIxnb1saO+ycTTfGlj0Z2RcgpesIvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+6OBWzy3sln7tDUxPjDR1eMBn8V4Gf4MQYEnIN95+PR2ntnIiIAiwvDdEgJEyfuWi8ICwbK68NLrQX+g+LLGI/iNEEaOciwBdhL3yo/oWCRul9Y0hITPzIT9MpS3KIycDhFLNem8gIf0yIJd0VomVRJB1z5N+Yr9h/12ZAoR2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pl4oGSM4; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711569844; x=1743105844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p9PxKFKNPcVQ3UIxnb1saO+ycTTfGlj0Z2RcgpesIvA=;
  b=Pl4oGSM43duxjbwX16c+/sV0jt09CpNPuNT0nRJFt5ukZgS+MPaH9lk8
   tAMTEhEO2DLHHFrmrk9Ha90viuFnRNFwGepVh0gB0ufzCvT4MTNlLAiy4
   3+HLtWQb9L6wxbOMAiXGuOQHfXF79CQuY8N9XadN+O1CC870Gs6khjBxi
   psVpY9PRIqqCoeIZkcEIu6j86pZKTz+6bd4GsHVxTnhOZHTvObo5XWXmD
   1+Baar5XpHbBHS4Gr23xwtnDOojhw/feiiIkUNN7KoyXXd38+DzQTXSsW
   mHliXuNIh4CSU/QqChF2WbuyQlM8M4+T0jHuByGQVYEMfor8iRVVrMpcp
   Q==;
X-CSE-ConnectionGUID: 3hi88GGxRCW0bxroej9EiA==
X-CSE-MsgGUID: of73pvr5QD+J1EvqByXqyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="18132969"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="18132969"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 13:04:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16246107"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 13:04:02 -0700
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
Subject: [PATCH 02/10] x86/resctrl: Add new rdt_resource for sub-node monitoring
Date: Wed, 27 Mar 2024 13:03:44 -0700
Message-ID: <20240327200352.236835-3-tony.luck@intel.com>
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

When a system enables Sub-NUMA Cluster (SNC) mode each CPU socket is
divided into 2 or more NUMA nodes. CPU cores and memory are divided
between these nodes. L3 cache monitoring functions are independently
implemented on each SNC node.

Add a new rdt_resource as a foundation for the structures to track
monitor resources in each of the L3 sub-nodes.

Add new scope option RESCTRL_NODE to build domains scoped at the
NUMA node level.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                |  1 +
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/core.c     | 12 ++++++++++++
 3 files changed, 14 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index ed693bfe474d..f39a07b27a98 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -153,6 +153,7 @@ struct resctrl_schema;
 enum resctrl_scope {
 	RESCTRL_L2_CACHE = 2,
 	RESCTRL_L3_CACHE = 3,
+	RESCTRL_NODE,
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 8f40fb35db78..24fad5ecc158 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -472,6 +472,7 @@ enum resctrl_res_level {
 	RDT_RESOURCE_L2,
 	RDT_RESOURCE_MBA,
 	RDT_RESOURCE_SMBA,
+	RDT_RESOURCE_SUBL3,
 
 	/* Must be the last */
 	RDT_NUM_RESOURCES,
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 4c5e985e1388..395bcb3199f8 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -115,6 +115,16 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.fflags			= RFTYPE_RES_MB,
 		},
 	},
+	[RDT_RESOURCE_SUBL3] =
+	{
+		.r_resctrl = {
+			.rid			= RDT_RESOURCE_SUBL3,
+			.name			= "SUBL3",
+			.scope			= RESCTRL_NODE,
+			.domains		= domain_init(RDT_RESOURCE_SUBL3),
+			.fflags			= RFTYPE_RES_CACHE,
+		},
+	},
 };
 
 /*
@@ -487,6 +497,8 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
 	case RESCTRL_L2_CACHE:
 	case RESCTRL_L3_CACHE:
 		return get_cpu_cacheinfo_id(cpu, scope);
+	case RESCTRL_NODE:
+		return cpu_to_node(cpu);
 	default:
 		break;
 	}
-- 
2.44.0


