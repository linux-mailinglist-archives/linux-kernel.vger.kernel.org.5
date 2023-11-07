Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558BB7E391C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjKGK3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjKGK3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:29:10 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3DEF7;
        Tue,  7 Nov 2023 02:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mnU5AkoHae2A4t/6hUnkAeF1QeR2fa8gldl6fabdpys=; b=Xvbg8rVwQvptDasFluB1GivJJR
        lkmYK9tHPkK3vfKg66aLbO07r9lL+qDWdsMtP1fVlOa8E6KTkOYoEs2lwy4BuATJgRxBHul9tXxli
        QGqH/a1GwQbXH4Ty2qge3vzSS6Lc2LavAFmQ5ENfzpAimPTrAHwq4g364DPRdQkTj0tDP0qjcdxfK
        STyjqt1AJWeyZh74VX0SvsNhUiKdGJQ5F9Q8X2OntVFa17qD+omT8nLqUX52QnKNsc7MXWynhIz17
        xiLH8jwcSjSqGdcRk8+6xspJu1Yko/6rlvG1nsItzUsrSafRMYvzk7lo3JLicVij5zIccje25TllF
        GUWgjCdw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37708)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r0JKK-0000DJ-2j;
        Tue, 07 Nov 2023 10:28:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r0JKF-0006qX-KE; Tue, 07 Nov 2023 10:28:51 +0000
Date:   Tue, 7 Nov 2023 10:28:51 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org
Cc:     Albert Ou <aou@eecs.berkeley.edu>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        Len Brown <lenb@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Salil Mehta <salil.mehta@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>
Subject: [PATCH RFC 00/22] Initial cleanups for vCPU hotplug
Message-ID: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Rather than posting the entire set of vCPU kernel patches, this is a
subset of those patches which I hope will be able to be appropriately
queued for the next merge window. I am also hoping that nothing here
is covered by Rafael's concerns he alluded to in his response to the
RFC v3 series.

This series aims to switch most architectures over to using generic CPU
devices rather than arch specific implementations, which I think is
worthwhile doing even if the vCPU hotplug series needs further work.

Since this series changes the init order (node_dev_init() vs
cpu_dev_init()) and later on in the vCPU hotplug series move the
location that CPUs are registered, the first two patches head off
problems with register_cpu_capacity_sysctl() and the intel_epb code.
These two were ordered later in the original series.

The next pair of patches are new and remove the exports of
arch_*register_cpu() which are not necessary - these functions are only
called from non-modular code - drivers/base/cpu.c and acpi_processor.c
both of which can only be built-in.

The majority of the other patches come from the vCPU hotplug RFC v3
series I posted earlier, rebased on Linus' current tip, but with some
new patches adding arch_cpu_is_hotpluggable() as the remaining
arch_register_cpu() functions only differ in the setting of the
hotpluggable member of the CPU device - so let's get generic code
doing that and provide a way for an architecture to specify whether a
CPU is hotpluggable.

I would appreciate testing reports on loongarch, riscv and x86
platforms please.

Thanks!

 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/cpu.h     |  1 -
 arch/arm64/kernel/setup.c        | 13 ++-----------
 arch/loongarch/Kconfig           |  2 ++
 arch/loongarch/kernel/topology.c | 42 ++--------------------------------------
 arch/riscv/Kconfig               |  1 +
 arch/riscv/kernel/setup.c        | 18 ++---------------
 arch/x86/Kconfig                 |  2 ++
 arch/x86/include/asm/cpu.h       |  4 ----
 arch/x86/kernel/cpu/intel_epb.c  |  2 +-
 arch/x86/kernel/topology.c       | 33 ++-----------------------------
 drivers/acpi/Kconfig             |  1 -
 drivers/acpi/acpi_processor.c    | 18 -----------------
 drivers/base/arch_topology.c     | 38 ++++++++++++++++++++++++------------
 drivers/base/cpu.c               | 39 +++++++++++++++++++++++++++++--------
 drivers/base/init.c              |  2 +-
 drivers/base/node.c              |  7 -------
 include/linux/cpu.h              |  5 +++++
 18 files changed, 78 insertions(+), 151 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
