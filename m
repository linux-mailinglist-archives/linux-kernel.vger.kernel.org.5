Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152017E394F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjKGKa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjKGKaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:30:17 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B55010DC;
        Tue,  7 Nov 2023 02:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rpX32JELJVRxbBajbNmSR45zpZhhmbYGw/k55Nv6FvI=; b=XN47gDlFG8oQadHagMkhORXF23
        NRjFhMOv+fOecI9DuYcspnJ2wjxtrLSw4kI7bc6Pzft54dDr9K/i4r6/Gb3KEDyFfKfWMGKLgGrYB
        OSevVF3x5B/KPXN/975w4BVriOHzRvLd6esz2xUFlZRQoIRMjLTlSsaeP/Kceq2ToGjYHJ6dEQsLx
        fQrD1VL6a3tObH1/Fg4nNXaFBxAZCLqI4T5fb3Bnlg3+oIueijd3Enrj9JH7iCFWC6RLcKnDFwV7U
        8rtN7+DW9WSr+UgP69IdSopcQdt+6g65W/qa/h/ObeMek38otWK872SHRRsHD1tTzmreGVN6/GjkW
        7mlyujLw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59044 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1r0JLB-0000Er-05;
        Tue, 07 Nov 2023 10:29:49 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1r0JLB-00CTwy-7y; Tue, 07 Nov 2023 10:29:49 +0000
In-Reply-To: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
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
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Subject: [PATCH RFC 06/22] drivers: base: Use present CPUs in
 GENERIC_CPU_DEVICES
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r0JLB-00CTwy-7y@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 07 Nov 2023 10:29:49 +0000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

Three of the five ACPI architectures create sysfs entries using
register_cpu() for present CPUs, whereas arm64, riscv and all
GENERIC_CPU_DEVICES do this for possible CPUs.

Registering a CPU is what causes them to show up in sysfs.

It makes very little sense to register all possible CPUs. Registering
a CPU is what triggers the udev notifications allowing user-space to
react to newly added CPUs.

To allow all five ACPI architectures to use GENERIC_CPU_DEVICES, change
it to use for_each_present_cpu(). Making the ACPI architectures use
GENERIC_CPU_DEVICES is a pre-requisite step to centralise their
cpu_register() logic, before moving it into the ACPI processor driver.
When ACPI is disabled this work would be done by
cpu_dev_register_generic().

Of the ACPI architectures that register possible CPUs, arm64 and riscv
do not support making possible CPUs present as they use the weak 'always
fails' version of arch_register_cpu().

Only two of the eight architectures that use GENERIC_CPU_DEVICES have a
distinction between present and possible CPUs.

The following architectures use GENERIC_CPU_DEVICES but are not SMP,
so possible == present:
 * m68k
 * microblaze
 * nios2

The following architectures use GENERIC_CPU_DEVICES and consider
possible == present:
 * csky: setup_smp()
 * processor_probe() sets possible for all CPUs and present for all CPUs
   except the boot cpu, which will have been done by
   init/main.c::start_kernel().

um appears to be a subarchitecture of x86.

The remaining architecture using GENERIC_CPU_DEVICES are:
 * openrisc and hexagon:
   where smp_init_cpus() makes all CPUs < NR_CPUS possible,
   whereas smp_prepare_cpus() only makes CPUs < setup_max_cpus present.

After this change, openrisc and hexagon systems that use the max_cpus
command line argument would not see the other CPUs present in sysfs.
This should not be a problem as these CPUs can't bre brought online as
_cpu_up() checks cpu_present().

After this change, only CPUs which are present appear in sysfs.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/base/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 9ea22e165acd..34b48f660b6b 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -533,7 +533,7 @@ static void __init cpu_dev_register_generic(void)
 #ifdef CONFIG_GENERIC_CPU_DEVICES
 	int i;
 
-	for_each_possible_cpu(i) {
+	for_each_present_cpu(i) {
 		if (register_cpu(&per_cpu(cpu_devices, i), i))
 			panic("Failed to register CPU device");
 	}
-- 
2.30.2

