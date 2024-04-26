Return-Path: <linux-kernel+bounces-160241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC868B3AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17A31F27DA1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74987149C43;
	Fri, 26 Apr 2024 15:10:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A461716FF5F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144226; cv=none; b=UIIzQR6G3yx9AeR4/ueAxZw1KSA+znNatuJJyfRwBayF9s0J8E0ZkDYy64+4X1JUwsyiY8fReJ76fLtPJTLKB1Zn1iV1AVfZHIgxenTAcE45/WuIDuKclCGiNvEukcuB5WedrMpMt7pCK7EH7Ijj0E+B6MnJ444p/y2Zg86cLvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144226; c=relaxed/simple;
	bh=Yc/Du8TTACSvFMbPAG+zasNqe/csSB/NLpP9Ig58bBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a3/eTbc20I9awGWA6WZzRMGKWZN2GZ3UWRKTmpTaU6ou+8eoNY7TQ6CdB6ZFuEE2goFooiw2SU+Pr6uovDfwHljhqWYcXOaJlC+9K0v88BHiQ+U1bbPjjuCETmZ5n7T5nVX50/Ld5L/ZhaESWSjxSYWUcgJvk5369aBSaiyQPHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 210321682;
	Fri, 26 Apr 2024 08:10:52 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C3013F73F;
	Fri, 26 Apr 2024 08:10:21 -0700 (PDT)
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
Subject: [PATCH v2 23/35] x86/resctrl: Move thread_throttle_mode_init() to be managed by resctrl
Date: Fri, 26 Apr 2024 16:08:52 +0100
Message-Id: <20240426150904.8854-23-Dave.Martin@arm.com>
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

thread_throttle_mode_init() is called from the architecture specific code
to make the 'thread_throttle_mode' file visible. The architecture specific
code has already set the membw.throttle_mode in the rdt_resource.

This doesn't need to be specific to the architecture, the throttle_mode
can be used by resctrl to determine if the 'thread_throttle_mode' file
should be visible.

Call thread_throttle_mode_init() from resctrl_setup(), check the
membw.throttle_mode on the MBA resource. This avoids publishing an
extra function between the architecture and filesystem code.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 1 -
 arch/x86/kernel/cpu/resctrl/internal.h | 1 -
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 9 ++++++++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 824a94593e9d..7cdecd8ac00b 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -227,7 +227,6 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 		r->membw.throttle_mode = THREAD_THROTTLE_PER_THREAD;
 	else
 		r->membw.throttle_mode = THREAD_THROTTLE_MAX;
-	thread_throttle_mode_init();
 
 	r->alloc_capable = true;
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index be4e8f31b127..e849d4407769 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -478,7 +478,6 @@ void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
-void __init thread_throttle_mode_init(void);
 void mbm_config_rftype_init(const char *config);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6ca986d3f5f2..ff209ba9176e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2067,10 +2067,15 @@ static struct rftype *rdtgroup_get_rftype_by_name(const char *name)
 	return NULL;
 }
 
-void __init thread_throttle_mode_init(void)
+static void __init thread_throttle_mode_init(void)
 {
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
 	struct rftype *rft;
 
+	if (!r->alloc_capable ||
+	    r->membw.throttle_mode == THREAD_THROTTLE_UNDEFINED)
+		return;
+
 	rft = rdtgroup_get_rftype_by_name("thread_throttle_mode");
 	if (!rft)
 		return;
@@ -4196,6 +4201,8 @@ int __init resctrl_init(void)
 
 	rdtgroup_setup_default();
 
+	thread_throttle_mode_init();
+
 	ret = resctrl_mon_resource_init();
 	if (ret)
 		return ret;
-- 
2.34.1


