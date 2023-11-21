Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED2B7F2EF6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbjKUNpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbjKUNo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:44:58 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7DC1737;
        Tue, 21 Nov 2023 05:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UQ05SB3yWDhX97AT8bSyWTwxLjmfSd4IctwvAhJmykI=; b=Fo5mO2GYy/nyDoE1Pv+YpT0JVl
        RmeGcXLuGeUp6TiBUu8iystNjPXQdn1rDAWALVB27V2kAwYLt21Q11Bygxc2wRtnxfQ/iGLONu2GT
        oHCarNxbOthpImWIG2QG9pTZLfcP+Bl5Y/5yEYzSOmizhBtf2ymOhh1aw3Oa13glBgHgk5tuqNre1
        wGAvLR9qFV+LuE4bxCnzN7aPJLjEcEycmYergkCrxIlC9tG5Ak6IoD2OVNGYDuRV5vFxMoOP1KHz1
        JkhYxWz8KBwgUOTrMS6oX/n/5UjmLRkxQoDucHhGPdYd0VPtSQXuD4o+ikRKo6nsLccyikB4q5Wmg
        Aftc5mlg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50552 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1r5R3Z-00079G-2B;
        Tue, 21 Nov 2023 13:44:49 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1r5R3b-00Csza-Ku; Tue, 21 Nov 2023 13:44:51 +0000
In-Reply-To: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
From:   Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org
Cc:     Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 12/21] arm64: setup: Switch over to GENERIC_CPU_DEVICES using
 arch_register_cpu()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r5R3b-00Csza-Ku@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 21 Nov 2023 13:44:51 +0000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

To allow ACPI's _STA value to hide CPUs that are present, but not
available to online right now due to VMM or firmware policy, the
register_cpu() call needs to be made by the ACPI machinery when ACPI
is in use. This allows it to hide CPUs that are unavailable from sysfs.

Switching to GENERIC_CPU_DEVICES is an intermediate step to allow all
five ACPI architectures to be modified at once.

Switch over to GENERIC_CPU_DEVICES, and provide an arch_register_cpu()
that populates the hotpluggable flag. arch_register_cpu() is also the
interface the ACPI machinery expects.

The struct cpu in struct cpuinfo_arm64 is never used directly, remove
it to use the one GENERIC_CPU_DEVICES provides.

This changes the CPUs visible in sysfs from possible to present, but
on arm64 smp_prepare_cpus() ensures these are the same.

This patch also has the effect of moving the registration of CPUs from
subsys to driver core initialisation, prior to any initcalls running.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC v2:
 * Add note about initialisation order change.
---
 arch/arm64/Kconfig           |  1 +
 arch/arm64/include/asm/cpu.h |  1 -
 arch/arm64/kernel/setup.c    | 13 ++++---------
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b071a00425d..84bce830e365 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -132,6 +132,7 @@ config ARM64
 	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select GENERIC_CPU_AUTOPROBE
+	select GENERIC_CPU_DEVICES
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index f3034099fd95..b1e43f56ee46 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -38,7 +38,6 @@ struct cpuinfo_32bit {
 };
 
 struct cpuinfo_arm64 {
-	struct cpu	cpu;
 	struct kobject	kobj;
 	u64		reg_ctr;
 	u64		reg_cntfrq;
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 417a8a86b2db..165bd2c0dd5a 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -402,19 +402,14 @@ static inline bool cpu_can_disable(unsigned int cpu)
 	return false;
 }
 
-static int __init topology_init(void)
+int arch_register_cpu(int num)
 {
-	int i;
+	struct cpu *cpu = &per_cpu(cpu_devices, num);
 
-	for_each_possible_cpu(i) {
-		struct cpu *cpu = &per_cpu(cpu_data.cpu, i);
-		cpu->hotpluggable = cpu_can_disable(i);
-		register_cpu(cpu, i);
-	}
+	cpu->hotpluggable = cpu_can_disable(num);
 
-	return 0;
+	return register_cpu(cpu, num);
 }
-subsys_initcall(topology_init);
 
 static void dump_kernel_offset(void)
 {
-- 
2.30.2

