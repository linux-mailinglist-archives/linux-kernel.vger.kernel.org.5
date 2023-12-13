Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20135810ACD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjLMHCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbjLMGku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:40:50 -0500
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB78AB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 22:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702449655; x=1733985655;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=94amqqZKB2zJhADw4oYeciSDrXheAqykdeuVtMiJBwE=;
  b=YewaEIIb3vMLMNA8xGcEHKQgCbXPhZe7rnM/9qasdjdcJS+UJjq3BO2k
   uueMVMAckvXiVBDmeJyIOigD7t7faqcMbWwELxFcVtENaUUufqjlJhDlR
   DDkc2gz8+UR4MTm71Gpio8MxUGvyIzBaAdUX5NNR+BlqSf3uOC8PTSCMG
   g=;
X-IronPort-AV: E=Sophos;i="6.04,272,1695686400"; 
   d="scan'208";a="171634859"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 06:40:53 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
        by email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com (Postfix) with ESMTPS id E9EAFA0B0C;
        Wed, 13 Dec 2023 06:40:48 +0000 (UTC)
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:56758]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.22.100:2525] with esmtp (Farcaster)
 id 9438de3e-ca1c-46b1-a8b0-23d75734eed4; Wed, 13 Dec 2023 06:40:47 +0000 (UTC)
X-Farcaster-Flow-ID: 9438de3e-ca1c-46b1-a8b0-23d75734eed4
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 06:40:47 +0000
Received: from u5d18b891348c5b.ant.amazon.com (10.146.13.114) by
 EX19D014EUC004.ant.amazon.com (10.252.51.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 06:40:37 +0000
From:   James Gowans <jgowans@amazon.com>
To:     <jgowans@amazon.com>, Eric Biederman <ebiederm@xmission.com>,
        "Sean Christopherson" <seanjc@google.com>
CC:     <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "Pavel Machek" <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Alexander Graf <graf@amazon.de>,
        "Jan H . Schoenherr" <jschoenh@amazon.de>
Subject: [PATCH] kexec: do syscore_shutdown() in kernel_kexec
Date:   Wed, 13 Dec 2023 08:40:04 +0200
Message-ID: <20231213064004.2419447-1-jgowans@amazon.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.146.13.114]
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscore_shutdown() runs driver and module callbacks to get the system
into a state where it can be correctly shut down. In commit
6f389a8f1dd2 ("PM / reboot: call syscore_shutdown() after disable_nonboot_cpus()")
syscore_shutdown() was removed from kernel_restart_prepare() and hence
got (incorrectly?) removed from the kexec flow. This was innocuous until
commit 6735150b6997 ("KVM: Use syscore_ops instead of reboot_notifier to hook restart/shutdown")
changed the way that KVM registered its shutdown callbacks, switching from
reboot notifiers to syscore_ops.shutdown. As syscore_shutdown() is
missing from kexec, KVM's shutdown hook is not run and virtualisation is
left enabled on the boot CPU which results in triple faults when
switching to the new kernel on Intel x86 VT-x with VMXE enabled.

Fix this by adding syscore_shutdown() to the kexec sequence. In terms of
where to add it, it is being added after migrating the kexec task to the
boot CPU, but before APs are shut down. It is not totally clear if this
is the best place: in commit 6f389a8f1dd2 ("PM / reboot: call syscore_shutdown() after disable_nonboot_cpus()")
it is stated that "syscore_ops operations should be carried with one
CPU on-line and interrupts disabled." APs are only offlined later in
machine_shutdown(), so this syscore_shutdown() is being run while APs
are still online. This seems to be the correct place as it matches where
syscore_shutdown() is run in the reboot and halt flows - they also run
it before APs are shut down. The assumption is that the commit message
in commit 6f389a8f1dd2 ("PM / reboot: call syscore_shutdown() after disable_nonboot_cpus()")
is no longer valid.

KVM has been discussed here as it is what broke loudly by not having
syscore_shutdown() in kexec, but this change impacts more than just KVM;
all drivers/modules which register a syscore_ops.shutdown callback will
now be invoked in the kexec flow. Looking at some of them like x86 MCE
it is probably more correct to also shut these down during kexec.
Maintainers of all drivers which use syscore_ops.shutdown are added on
CC for visibility. They are:

arch/powerpc/platforms/cell/spu_base.c  .shutdown = spu_shutdown,
arch/x86/kernel/cpu/mce/core.c	        .shutdown = mce_syscore_shutdown,
arch/x86/kernel/i8259.c                 .shutdown = i8259A_shutdown,
drivers/irqchip/irq-i8259.c	        .shutdown = i8259A_shutdown,
drivers/irqchip/irq-sun6i-r.c	        .shutdown = sun6i_r_intc_shutdown,
drivers/leds/trigger/ledtrig-cpu.c	.shutdown = ledtrig_cpu_syscore_shutdown,
drivers/power/reset/sc27xx-poweroff.c	.shutdown = sc27xx_poweroff_shutdown,
kernel/irq/generic-chip.c	        .shutdown = irq_gc_shutdown,
virt/kvm/kvm_main.c	                .shutdown = kvm_shutdown,

This has been tested by doing a kexec on x86_64 and aarch64.

Fixes: 6735150b6997 ("KVM: Use syscore_ops instead of reboot_notifier to hook restart/shutdown")

Signed-off-by: James Gowans <jgowans@amazon.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Alexander Graf <graf@amazon.de>
Cc: Jan H. Schoenherr <jschoenh@amazon.de>
---
 kernel/kexec_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index be5642a4ec49..b926c4db8a91 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1254,6 +1254,7 @@ int kernel_kexec(void)
 		kexec_in_progress = true;
 		kernel_restart_prepare("kexec reboot");
 		migrate_to_reboot_cpu();
+		syscore_shutdown();
 
 		/*
 		 * migrate_to_reboot_cpu() disables CPU hotplug assuming that
-- 
2.34.1

