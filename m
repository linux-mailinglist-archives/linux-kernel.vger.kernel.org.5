Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3567726A2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbjHGNxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbjHGNw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:52:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971E7F3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:52:54 -0700 (PDT)
Message-ID: <20230807135027.064321764@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/LBxxfhEQgbaGsq91nXw+XvYY9V2TrRdpuXMU4IXdUM=;
        b=o8LQe7Ls4Z+/qGPCnSTzkqJR7EB9PiToMXBVPmICdCqg0/Km0aped2/ubIhsQNkXQl1z9n
        1ajBj0Ku4iHL+Skz56EQgDFXxqxz7Ydgs/wKaei/FhaXs4l24iomECpgwygIwsjHvHxjW3
        10ICos8H5LMLM1ms0qkEvLp+5Sj+YbCfu8+oGM1XTNTzZR5JCcDDWH9+yqSkp3shtqUO5t
        96lJQCb27KgaMJ1Fc2wEUM3RPN4ixeU0IY/AgX+k0J057fgZz+tdA8wJ9NrbvZ3fvAa/E0
        ia+/58ca7bfpBHHWvg8oGti2O1fzH+pxBsO8RctGz+fkkUyUaceE/53KMuLltg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/LBxxfhEQgbaGsq91nXw+XvYY9V2TrRdpuXMU4IXdUM=;
        b=S8EHjFNgdV+eWvx3T6Au9tOnjKenvPyGPuFUOHVr2kVZL2/oAUg4UCd/4JTuaxxtreoGx4
        F58d3Bugq9s58xBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: [patch 12/53] x86/dtb: Rename x86_dtb_init()
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:52:52 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86_dtb_init() is a misnomer and it really should be used as a SMP
configuration parser which is selected by the platform via
x86_init::mpparse:parse_smp_config().

Rename it to x86_dtb_parse_smp_config() in preparation for that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/prom.h  |    4 ++--
 arch/x86/kernel/devicetree.c |    2 +-
 arch/x86/kernel/setup.c      |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/prom.h
+++ b/arch/x86/include/asm/prom.h
@@ -23,11 +23,11 @@ extern int of_ioapic;
 extern u64 initial_dtb;
 extern void add_dtb(u64 data);
 void x86_of_pci_init(void);
-void x86_dtb_init(void);
+void x86_dtb_parse_smp_config(void);
 #else
 static inline void add_dtb(u64 data) { }
 static inline void x86_of_pci_init(void) { }
-static inline void x86_dtb_init(void) { }
+static inline void x86_dtb_parse_smp_config(void) { }
 #define of_ioapic 0
 #endif
 
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -304,7 +304,7 @@ static void __init x86_flattree_get_conf
 static inline void x86_flattree_get_config(void) { }
 #endif
 
-void __init x86_dtb_init(void)
+void __init x86_dtb_parse_smp_config(void)
 {
 	x86_flattree_get_config();
 
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1260,7 +1260,7 @@ void __init setup_arch(char **cmdline_p)
 	 * Read APIC and some other early information from ACPI tables.
 	 */
 	acpi_boot_init();
-	x86_dtb_init();
+	x86_dtb_parse_smp_config();
 
 	/*
 	 * get boot-time SMP configuration:

