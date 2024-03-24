Return-Path: <linux-kernel+bounces-115737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFD588948D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5A91F33967
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03552197D8;
	Mon, 25 Mar 2024 02:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1Jlk/f7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C89B21C99F;
	Sun, 24 Mar 2024 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321846; cv=none; b=CZ9OZhkPIW1vxwKfDLqimXUlMnkPthiAuK8HxythX3KuwdjyhQIrwQdVjZ61DAs5zkHltsUghwPuP2riMOFpgukOwTRYz4Fq69ELs2OuXnX/HBnjy+On+YK2ehaJvePhEhH+lwINwX6lViCyuR+HohUjSO/LzsGLQLayYUFVub4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321846; c=relaxed/simple;
	bh=ZsGdZoB7ileVKJyMqzxesuFEMdBK59pTpB+KyAjD88E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOETV5ElouZeo4o3MLM0VLWmm5q3c6VGcf5+/sPjEPsYrJwJQvRGVbQI/sSRM94m9qWM4TV7Rc4Zshkp46C0n+YL9t0IvOG1AzaK7lFt4Cv5XdRcSohT2S9L3+OSMhvgppyi4byGyYV4zOshllCo0M/JednVePFaPV8Iem1/j/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1Jlk/f7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47733C43390;
	Sun, 24 Mar 2024 23:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321845;
	bh=ZsGdZoB7ileVKJyMqzxesuFEMdBK59pTpB+KyAjD88E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F1Jlk/f72QG5LSn0zUPHO79G8RBepC3HrYE2EZcYjA8ctw0JxXuPXYjuUMDiREJM3
	 hgJrwyfjlu3nNtMWdiKm2qEOBtPEI1P0Fq85h6cuV+m0YSo5ipaOhtICxlW0Ybfasf
	 tnY1QbMk6ylZ6Kpd/4WVn/gfP1ofjAB9XG9J+AevD5+o1FJLaWLfMYqvjcIR8vXfjn
	 +MgeIyL0uKV11D8OVs9hFLUUTrvSYH7wT0WoEWaZT+z7ZxNY3+Dqm5Ul5xHWb6p76w
	 WJrpTxejr+fLBb5xcWPs7Adv6BwxY6i5r7zT/Q47t5RQLmIpdYmDj1TEIQRvJmorcG
	 TvgMfyiR0Sygg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 573/638] x86/hyperv: Use per cpu initial stack for vtl context
Date: Sun, 24 Mar 2024 19:00:10 -0400
Message-ID: <20240324230116.1348576-574-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Saurabh Sengar <ssengar@linux.microsoft.com>

[ Upstream commit 2b4b90e053a29057fb05ba81acce26bddce8d404 ]

Currently, the secondary CPUs in Hyper-V VTL context lack support for
parallel startup. Therefore, relying on the single initial_stack fetched
from the current task structure suffices for all vCPUs.

However, common initial_stack risks stack corruption when parallel startup
is enabled. In order to facilitate parallel startup, use the initial_stack
from the per CPU idle thread instead of the current task.

Fixes: 3be1bc2fe9d2 ("x86/hyperv: VTL support for Hyper-V")
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Link: https://lore.kernel.org/r/1709452896-13342-1-git-send-email-ssengar@linux.microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <1709452896-13342-1-git-send-email-ssengar@linux.microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/hyperv/hv_vtl.c | 19 +++++++++++++++----
 drivers/hv/Kconfig       |  1 +
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 53b309d41b3b9..c2f78fabc865b 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -12,6 +12,7 @@
 #include <asm/i8259.h>
 #include <asm/mshyperv.h>
 #include <asm/realmode.h>
+#include <../kernel/smpboot.h>
 
 extern struct boot_params boot_params;
 static struct real_mode_header hv_vtl_real_mode_header;
@@ -64,7 +65,7 @@ static void hv_vtl_ap_entry(void)
 	((secondary_startup_64_fn)secondary_startup_64)(&boot_params, &boot_params);
 }
 
-static int hv_vtl_bringup_vcpu(u32 target_vp_index, u64 eip_ignored)
+static int hv_vtl_bringup_vcpu(u32 target_vp_index, int cpu, u64 eip_ignored)
 {
 	u64 status;
 	int ret = 0;
@@ -78,7 +79,9 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, u64 eip_ignored)
 	struct ldttss_desc *ldt;
 	struct desc_struct *gdt;
 
-	u64 rsp = current->thread.sp;
+	struct task_struct *idle = idle_thread_get(cpu);
+	u64 rsp = (unsigned long)idle->thread.sp;
+
 	u64 rip = (u64)&hv_vtl_ap_entry;
 
 	native_store_gdt(&gdt_ptr);
@@ -205,7 +208,15 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
 
 static int hv_vtl_wakeup_secondary_cpu(int apicid, unsigned long start_eip)
 {
-	int vp_id;
+	int vp_id, cpu;
+
+	/* Find the logical CPU for the APIC ID */
+	for_each_present_cpu(cpu) {
+		if (arch_match_cpu_phys_id(cpu, apicid))
+			break;
+	}
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
 
 	pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
 	vp_id = hv_vtl_apicid_to_vp_id(apicid);
@@ -219,7 +230,7 @@ static int hv_vtl_wakeup_secondary_cpu(int apicid, unsigned long start_eip)
 		return -EINVAL;
 	}
 
-	return hv_vtl_bringup_vcpu(vp_id, start_eip);
+	return hv_vtl_bringup_vcpu(vp_id, cpu, start_eip);
 }
 
 int __init hv_vtl_early_init(void)
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 00242107d62e0..862c47b191afe 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -16,6 +16,7 @@ config HYPERV
 config HYPERV_VTL_MODE
 	bool "Enable Linux to boot in VTL context"
 	depends on X86_64 && HYPERV
+	depends on SMP
 	default n
 	help
 	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
-- 
2.43.0


