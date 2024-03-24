Return-Path: <linux-kernel+bounces-113964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601B188879F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19CE3289077
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3522C21D155;
	Sun, 24 Mar 2024 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdcWuVrF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB8312CD94;
	Sun, 24 Mar 2024 22:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321076; cv=none; b=QQdEon+8QVHby1QM/tfFSB3aC9qTkW7TdD4yI8Nb9GRa8RGjeSFriM2gHMilz8tWVQgrU6yCnP2bKG29Z0qWrf+88jV/4F+CdTLKbHlT88VP50+8bIzJ050L4OiLldDXWSTg+5V/BnpW6RMJFmitU7BBF6+7bNfrfhapoA59+/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321076; c=relaxed/simple;
	bh=uquEdJtuigaZvFIpAaO4VKrtKjcu/o4l9cyrRi+kE6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRL7t1gPRHegcmyE8wVMPMUtC6U6ytGOAoJogOYvN54Wa37GZVCpGv8tNrjse9xcFBi17sBqNxTE3Vy6GiuVV+zO7EjqPN67P54C1bdXbZt3g1US93zTgAdtivZroypTr/O+02nhMEKg5WbRq474QtrqWeSo13yOKTBtXaH4ZIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdcWuVrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F0CC433A6;
	Sun, 24 Mar 2024 22:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321074;
	bh=uquEdJtuigaZvFIpAaO4VKrtKjcu/o4l9cyrRi+kE6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LdcWuVrFjnZkcEooCMX5CN/tS3NInd8QT9u33XiabUj6eZOEaW/xjzK8Q5+2eIR0W
	 56WL3VMVMKJfmtM7q7Hzp5fLZzymvrKHJb2+JDyCEjWJf81PFL6bVm6KJv7d5vSINi
	 w/ZJmCqIMAxbPSdGfeeMPz7I4VaePmjLRBrk0r4jLgwt78QgFRNoa2E/1TZi+ZkFp3
	 89OHeMw7WL+DD1dBsWvkwYYXkMZDnx+5EaDBCpBL93S0o1B3aASsThYTcL0Z/H8FEC
	 +MDz4m8iLjgxOk+K3WY9Qo6o5ezXDcQ0U97GIVadIUbnypzZ8GHQRZ9531v0/aU7i7
	 MXHo5Vd7EKmJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 638/713] x86/hyperv: Use per cpu initial stack for vtl context
Date: Sun, 24 Mar 2024 18:46:04 -0400
Message-ID: <20240324224720.1345309-639-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index cf1b78cb2d043..c8062975a5316 100644
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
 
 static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
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
@@ -219,7 +230,7 @@ static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
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


