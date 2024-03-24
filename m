Return-Path: <linux-kernel+bounces-112933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E58887FDC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 247DFB220B7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9116B757E4;
	Sun, 24 Mar 2024 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdvi8PHy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83E374C0E;
	Sun, 24 Mar 2024 22:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319745; cv=none; b=s8zmaNlNAjMtKtqGNAygVD47VDtf3/2w/DFsEkKPe9CugwNZ9Gg46GscUm7WBW6TtCKcsZ/Yg1+Jywp7imuzdddfHBiylKTFB2Wt21jQ69rmTv14rQqTteiLkbVPKMSHSTytfgRDo87tsFwZJvWz8S3B2RameTLxKis7nT8Ukfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319745; c=relaxed/simple;
	bh=P49efD8rlRGlUbOAd0Tvwnd/0EIr02E5XZUZfN8A1nI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agb0K1FSV/Wyp+2qAtveqvil5b8qdQLSTHMzmuwNaMQa3ILDf8jyNdcsSu9MoqFxdIjGBuCvFTmn75NgOSjrCHhbVZ3Mqsc9AlZpOn/FXsP+PoXldwIYHolK/ecNNOV4aYu8FtFMPVKCaaayHeup4V4SZAnoOcmpqfinJV8KfwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdvi8PHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C326EC433C7;
	Sun, 24 Mar 2024 22:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319745;
	bh=P49efD8rlRGlUbOAd0Tvwnd/0EIr02E5XZUZfN8A1nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bdvi8PHyAt9wOQYw+9r7iuJ7PdydMVAC5OCA3SncE0Zzvg7JSXwpkKKBjWOBYMomF
	 fjMfaKTnwfDYmch0I4PxPDhCz/lacpjJMj8nrjM0gV1DVidhLp7GUMljRdrVTnI860
	 jFNILUJSoTJyKQUYi54pQ9NyZ4IL4OL3+abrA6W8g6B/6zajyFZrct+5UigwZDrVp5
	 XoLJY7oL6w4oX13zER3HQqPlChScucCzcTbMAjZseIThRJZyfpNIakHcEDE3FzG9NV
	 MSuq/Qx31LNvvsmsvPtvjilCFSkEXoc0UmOSMFgrzlgDcIzbK5uc5IjYJ+JLXevTJu
	 PJNQ2YX+kyTug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Babu Moger <babu.moger@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 046/715] x86/resctrl: Read supported bandwidth sources from CPUID
Date: Sun, 24 Mar 2024 18:23:45 -0400
Message-ID: <20240324223455.1342824-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Babu Moger <babu.moger@amd.com>

[ Upstream commit 54e35eb8611cce5550d3d7689679b1a91c864f28 ]

If the BMEC (Bandwidth Monitoring Event Configuration) feature is
supported, the bandwidth events can be configured. The maximum supported
bandwidth bitmask can be read from CPUID:

  CPUID_Fn80000020_ECX_x03 [Platform QoS Monitoring Bandwidth Event Configuration]
  Bits    Description
  31:7    Reserved
   6:0    Identifies the bandwidth sources that can be tracked.

While at it, move the mask checking to mon_config_write() before
iterating over all the domains. Also, print the valid bitmask when the
user tries to configure invalid event configuration value.

The CPUID details are documented in the Processor Programming Reference
(PPR) Vol 1.1 for AMD Family 19h Model 11h B1 - 55901 Rev 0.25 in the
Link tag.

Fixes: dc2a3e857981 ("x86/resctrl: Add interface to read mbm_total_bytes_config")
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Link: https://lore.kernel.org/r/669896fa512c7451319fa5ca2fdb6f7e015b5635.1705359148.git.babu.moger@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/resctrl/internal.h |  3 +++
 arch/x86/kernel/cpu/resctrl/monitor.c  |  6 ++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 14 ++++++++------
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index d2979748fae47..e3dc35a00a197 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -394,6 +394,8 @@ struct rdt_parse_data {
  * @msr_update:		Function pointer to update QOS MSRs
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
  * @mbm_width:		Monitor width, to detect and correct for overflow.
+ * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
+ *			Monitoring Event Configuration (BMEC) is supported.
  * @cdp_enabled:	CDP state of this resource
  *
  * Members of this structure are either private to the architecture
@@ -408,6 +410,7 @@ struct rdt_hw_resource {
 				 struct rdt_resource *r);
 	unsigned int		mon_scale;
 	unsigned int		mbm_width;
+	unsigned int		mbm_cfg_mask;
 	bool			cdp_enabled;
 };
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f136ac046851c..acca577e2b066 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -813,6 +813,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		return ret;
 
 	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
+		u32 eax, ebx, ecx, edx;
+
+		/* Detect list of bandwidth sources that can be tracked */
+		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
+		hw_res->mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
+
 		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
 			mbm_total_event.configurable = true;
 			mbm_config_rftype_init("mbm_total_bytes_config");
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 69a1de92384ab..2b69e560b05f1 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1620,12 +1620,6 @@ static int mbm_config_write_domain(struct rdt_resource *r,
 	struct mon_config_info mon_info = {0};
 	int ret = 0;
 
-	/* mon_config cannot be more than the supported set of events */
-	if (val > MAX_EVT_CONFIG_BITS) {
-		rdt_last_cmd_puts("Invalid event configuration\n");
-		return -EINVAL;
-	}
-
 	/*
 	 * Read the current config value first. If both are the same then
 	 * no need to write it again.
@@ -1663,6 +1657,7 @@ static int mbm_config_write_domain(struct rdt_resource *r,
 
 static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	char *dom_str = NULL, *id_str;
 	unsigned long dom_id, val;
 	struct rdt_domain *d;
@@ -1686,6 +1681,13 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 		return -EINVAL;
 	}
 
+	/* Value from user cannot be more than the supported set of events */
+	if ((val & hw_res->mbm_cfg_mask) != val) {
+		rdt_last_cmd_printf("Invalid event configuration: max valid mask is 0x%02x\n",
+				    hw_res->mbm_cfg_mask);
+		return -EINVAL;
+	}
+
 	list_for_each_entry(d, &r->domains, list) {
 		if (d->id == dom_id) {
 			ret = mbm_config_write_domain(r, d, evtid, val);
-- 
2.43.0


