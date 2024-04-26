Return-Path: <linux-kernel+bounces-160242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A28C18B3AD4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5849F1F27D1A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10A9171089;
	Fri, 26 Apr 2024 15:10:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BC916FF5F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144229; cv=none; b=YVvDuxxgdk4buAF+iStdCievCYCcqTShNSKZnNR+wD9mqh4vYHPAD6H7f2dYVKikFpucJ0i249LuGLGnuZUoIQ6QiW5qUf6TYpodsQam5co0Zhb1naIazVX/iSmsUkYrsFXc7e7pwNy3MvNhCSp3Z0EUODXTaRpw5tcjiiG62m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144229; c=relaxed/simple;
	bh=fykdwzJzD98BfFk4Jek2Q2DE+vtzqHXdg4p4qfxfTtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cCHrzTnX5hyzeHJ6tAk+WEeZdGN4scuaEKMMjfmUolbGffon0XHqJEmuJPVSoVSyjzD7qcn/x0rW0u6m+zruC3WjHxgc6bI2KM3bHWdvWJ+wbobNVjuKwzxVQOHeEnVz261HVRLdpFc66bp5t86DinZwGzhGwHALAWNj8I7Bi7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5B1F15DB;
	Fri, 26 Apr 2024 08:10:55 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 530713F73F;
	Fri, 26 Apr 2024 08:10:24 -0700 (PDT)
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
Subject: [PATCH v2 24/35] x86/resctrl: Move get_config_index() to a header
Date: Fri, 26 Apr 2024 16:08:53 +0100
Message-Id: <20240426150904.8854-24-Dave.Martin@arm.com>
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

get_config_index() is used by the architecture specific code to map a
CLOSID+type pair to an index in the configuration arrays.

MPAM needs to do this too to preserve the ABI to user-space, there is
no reason to do it differently.

Move the helper to a header file.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Changes in v2:

 * Reindent resctrl_get_config_index() as per coding-style.rst rules.

 * Remove redundant parentheses from arithmetic in
   resctrl_get_config_index(), so as to match the original source
   version of this moved code.

   No functional change.
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 19 +++----------------
 include/linux/resctrl.h                   | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 3603ade95f1d..b4627ae19291 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -277,19 +277,6 @@ static int parse_line(char *line, struct resctrl_schema *s,
 	return -EINVAL;
 }
 
-static u32 get_config_index(u32 closid, enum resctrl_conf_type type)
-{
-	switch (type) {
-	default:
-	case CDP_NONE:
-		return closid;
-	case CDP_CODE:
-		return closid * 2 + 1;
-	case CDP_DATA:
-		return closid * 2;
-	}
-}
-
 static bool apply_config(struct rdt_hw_domain *hw_dom,
 			 struct resctrl_staged_config *cfg, u32 idx,
 			 cpumask_var_t cpu_mask)
@@ -311,7 +298,7 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
-	u32 idx = get_config_index(closid, t);
+	u32 idx = resctrl_get_config_index(closid, t);
 	struct msr_param msr_param;
 
 	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
@@ -351,7 +338,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 			if (!cfg->have_new_ctrl)
 				continue;
 
-			idx = get_config_index(closid, t);
+			idx = resctrl_get_config_index(closid, t);
 			if (!apply_config(hw_dom, cfg, idx, cpu_mask))
 				continue;
 
@@ -476,7 +463,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type type)
 {
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
-	u32 idx = get_config_index(closid, type);
+	u32 idx = resctrl_get_config_index(closid, type);
 
 	return hw_dom->ctrl_val[idx];
 }
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 18ef7de0aa47..7bbed5d8a155 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -269,6 +269,21 @@ bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
 void resctrl_arch_mon_event_config_write(void *info);
 void resctrl_arch_mon_event_config_read(void *info);
 
+/* For use by arch code to remap resctrl's smaller CDP CLOSID range */
+static inline u32 resctrl_get_config_index(u32 closid,
+					   enum resctrl_conf_type type)
+{
+	switch (type) {
+	default:
+	case CDP_NONE:
+		return closid;
+	case CDP_CODE:
+		return closid * 2 + 1;
+	case CDP_DATA:
+		return closid * 2;
+	}
+}
+
 /*
  * Update the ctrl_val and apply this config right now.
  * Must be called on one of the domain's CPUs.
-- 
2.34.1


