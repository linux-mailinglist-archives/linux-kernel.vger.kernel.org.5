Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1E17F2ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbjKUNo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbjKUNoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:44:44 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C2E1721;
        Tue, 21 Nov 2023 05:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=winLqcGTMq+SZizf/UjYofCIetGbvjNiBTRLKegVEMg=; b=PUMuHBv/SPVt12mWH7RCTV7yct
        rtAqDiaiK+G4xH0InybHlUIy2MghCYS9HSICK65UqkE7bZdyD+GgDNFCImlKtiyGh3OJSTHoqmk9G
        W3NgRgRXXDW92VmysYEVBLCHvFHjZY822RfhLQa/Vag9qZ8ztxtMjD7wlLC3utEX/nnRUHyeQMAUx
        KsC4Qxgbl+5QRb9orB4X5xzIGxyWgjnMu9jma0sMRIzIHmWcKs8fgqRlJEJKYue2gHUKYThSMSNkm
        UEpY5UM8Ak00vS2sIXu4bCYORzvzyeZU337wvBN74Xtd/OYs+xfhEkosJH0Flu+2VWGrBZZs64b23
        jrpMiytg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34688 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1r5R3A-00077a-0H;
        Tue, 21 Nov 2023 13:44:24 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1r5R3B-00Csz6-Uh; Tue, 21 Nov 2023 13:44:25 +0000
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 07/21] drivers: base: Allow parts of GENERIC_CPU_DEVICES to be
 overridden
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r5R3B-00Csz6-Uh@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 21 Nov 2023 13:44:25 +0000
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

Architectures often have extra per-cpu work that needs doing
before a CPU is registered, often to determine if a CPU is
hotpluggable.

To allow the ACPI architectures to use GENERIC_CPU_DEVICES, move
the cpu_register() call into arch_register_cpu(), which is made __weak
so architectures with extra work can override it.
This aligns with the way x86, ia64 and loongarch register hotplug CPUs
when they become present.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC:
 * Dropped __init from x86/ia64 arch_register_cpu()
Changes since RFC v2:
 * Dropped unnecessary Loongarch asm/cpu.h changes
---
 drivers/base/cpu.c  | 14 ++++++++++----
 include/linux/cpu.h |  4 ++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 34b48f660b6b..579064fda97b 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -525,19 +525,25 @@ bool cpu_is_hotpluggable(unsigned int cpu)
 EXPORT_SYMBOL_GPL(cpu_is_hotpluggable);
 
 #ifdef CONFIG_GENERIC_CPU_DEVICES
-static DEFINE_PER_CPU(struct cpu, cpu_devices);
+DEFINE_PER_CPU(struct cpu, cpu_devices);
+
+int __weak arch_register_cpu(int cpu)
+{
+	return register_cpu(&per_cpu(cpu_devices, cpu), cpu);
+}
 #endif
 
 static void __init cpu_dev_register_generic(void)
 {
-#ifdef CONFIG_GENERIC_CPU_DEVICES
 	int i;
 
+	if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
+		return;
+
 	for_each_present_cpu(i) {
-		if (register_cpu(&per_cpu(cpu_devices, i), i))
+		if (arch_register_cpu(i))
 			panic("Failed to register CPU device");
 	}
-#endif
 }
 
 #ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index fc8094419084..1e982d63eae8 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -88,6 +88,10 @@ extern ssize_t arch_cpu_probe(const char *, size_t);
 extern ssize_t arch_cpu_release(const char *, size_t);
 #endif
 
+#ifdef CONFIG_GENERIC_CPU_DEVICES
+DECLARE_PER_CPU(struct cpu, cpu_devices);
+#endif
+
 /*
  * These states are not related to the core CPU hotplug mechanism. They are
  * used by various (sub)architectures to track internal state
-- 
2.30.2

