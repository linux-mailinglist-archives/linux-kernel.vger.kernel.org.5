Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B222F80A001
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573460AbjLHJxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 04:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjLHJxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:53:40 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC545A3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 01:53:45 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-286867cac72so1489476a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 01:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702029224; x=1702634024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hiH20+WIVu5ly0cYmj661IYgJO82SP3K8lNJ5MfYHyg=;
        b=cVCAZ4NRUOBnqdITDvkb9w1twgViDrnt0vW42huewlY4rfpaiYXEtDR6h55dU0z4AC
         roWNcM5DNVnMAr0Py+boISWSLuGMoQUC6EuFkGTk2iLMfe8xqUdI5x1XePQtq3ZdJq8U
         J+LhqWUDLKTGmazlHA8l5av/33Mq8FjrZF+cRKaJjs+r3LqW9p/8q2NuNM7t4OZAg+L2
         2R1tzg7dgedY6u5UiLMv/dNQKimusVzyp0F70YNW4dtSq4dSs0uoMWSVT6qiyIX3+Ieb
         Ftledwz/6gFdPNsQ83oR282wn++jnIuq/g/0DtManEkqo2d4ameHgZvNftCTezArMnQc
         PrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702029224; x=1702634024;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiH20+WIVu5ly0cYmj661IYgJO82SP3K8lNJ5MfYHyg=;
        b=WceOHR2Jg2waI67zfGI+Io7T6h+w9kyLNLB/Z5TiMUE7d8Rpl8/2KpwnyVVc79eMwI
         +TIcvBUfv3swD6tj0S6Rv6jGvFPKkOMepVnrvsuhwabq0R2wFZi2noV46agT3QUMXe6j
         bsWKDLFvtsYjg/PM0A2mDfc2X769NrTQgbkco7JpIcf04se9naL/Mwy+woQ/1G+oM1TD
         yQfrtUDJd0kIQlpBT0j62RIeLeU98Tqcmd+GqftwU7vGJAEbqnrpTPdythE+tu/+1HHD
         FR9cSgyTkyBUGW88AYPKoA6OkT0spQ0aZeKCHWkJ9LbIdJM2Ig1wsonXcWrDPGTEFhRH
         zO1w==
X-Gm-Message-State: AOJu0YzpLm51ndlwwKXkOg1DLkKggkxipyXXNuG+dkniMr+c0FFeeapn
        c5gf+LyjxpB7zbrDPVRRvow8dsgDacwqovbe
X-Google-Smtp-Source: AGHT+IFcBP3UZcaSf5zWFkK+8uBofBQvnHXm72+xGVs/HAAeD6DDPF2T4jwVPr8HMFB7rMW0fmPZVg==
X-Received: by 2002:a17:90b:4f43:b0:285:9ec0:892a with SMTP id pj3-20020a17090b4f4300b002859ec0892amr3513274pjb.33.1702029224083;
        Fri, 08 Dec 2023 01:53:44 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090ac10600b00286ead49257sm1407985pjt.21.2023.12.08.01.53.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 08 Dec 2023 01:53:43 -0800 (PST)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Baoquan He <bhe@redhat.com>, Kairui Song <kasong@tencent.com>
Subject: [PATCH v2] x86/mpparse, kexec: switch apic driver early when x2apic is pre-enabled
Date:   Fri,  8 Dec 2023 17:52:48 +0800
Message-ID: <20231208095248.59356-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

Previous Link: https://lore.kernel.org/lkml/20220608064348.66402-3-ryncsn@gmail.com/

Following kernel panic is observed when doing kdump/kexec in
virtual machines that using MPTABLE, not ACPI, and supports x2apic,
this can be easily reproduced on Fedora using qemu:

  qemu-kvm -nodefaults -nographic -no-acpi -smp 2 -m 1G -monitor none \
    -serial stdio -hda <distro image using unpatched kernel>

And trigger a kdump/kexec in the qemu VM, it crash with:

Intel MultiProcessor Specification v1.4
MPTABLE: OEM ID: BOCHSCPU
MPTABLE: Product ID: 0.1
MPTABLE: APIC at: 0xFEE00000
BUG: unable to handle page fault for address: ffffffffff5fc020
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 25e15067 P4D 25e15067 PUD 25e17067 PMD 25e18067 PTE 0
Oops: 0000 [#1] SMP NOPTI
CPU: 0 PID: 0 Comm: swapper Not tainted 5.14.10-300.fc35.x86_64 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
RIP: 0010:native_apic_mem_read+0x2/0x10
Code: 14 25 20 cd e3 82 c3 90 bf 30 08 00 00 ff 14 25 18 cd e3 82 c3 cc cc cc 89 ff 89 b7 00 c0 5f ff c3 0f 1f 80 00 00 00 00 89 ff <8b> 87 00 c0 5f ff c3 0f 1f 80 00 00 00 0
RSP: 0000:ffffffff82e03e18 EFLAGS: 00010046
RAX: ffffffff81064840 RBX: ffffffffff240b6c RCX: ffffffff82f17428
RDX: c0000000ffffdfff RSI: 00000000ffffdfff RDI: 0000000000000020
RBP: ffff888023200000 R08: 0000000000000000 R09: ffffffff82e03c50
R10: ffffffff82e03c48 R11: ffffffff82f47468 R12: ffffffffff240b40
R13: ffffffffff200b30 R14: 0000000000000000 R15: 00000000000000d4
FS:  0000000000000000(0000) GS:ffffffff8365b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff5fc020 CR3: 0000000025e10000 CR4: 00000000000006b0
Call Trace:
 ? read_apic_id+0x15/0x30
 ? register_lapic_address+0x76/0x97
 ? default_get_smp_config+0x28b/0x42d
 ? dmi_check_system+0x1c/0x60
 ? acpi_boot_init+0x1d/0x4c3
 ? setup_arch+0xb37/0xc2a
 ? slab_is_available+0x5/0x10
 ? start_kernel+0x61/0x980
 ? load_ucode_bsp+0x4c/0xcd
 ? secondary_startup_64_no_verify+0xc2/0xcb
Modules linked in:
CR2: ffffffffff5fc020
random: get_random_bytes called from oops_exit+0x35/0x60 with crng_init=0
---[ end trace c9e569df3bdbefd3 ]---

It's still reproducible with latest kernel, the panic happens in following
init code:

setup_arch()
  ....
  check_x2apic()     <-- x2apic is enabled by first kernel before kexec,
                         this set x2apic_mode = 1, make sure later probes
                         will recognize pre-enabled x2apic.
  ....
  acpi_boot_init();  <-- If ACPI MADT is in use, this will switch apic driver
                         to x2apic, but it will do nothing with MPTABLE.
  x86_dtb_init();
  get_smp_config();
    default_get_smp_config();  <-- MPTABLE setup.
      check_physptr();
        smp_read_mpc();
          register_lapic_address(); <-- panic here
  init_apic_mappings();
  ....

The problem here is MPTABLE setup need to read some boot info from apic, so
it calls register_lapic_address() to register apic MMIO interface early.
But the MMIO interface is never mapped for pre-enabled x2apic, since commit
0450193bffed6 ("x86, x2apic: Don't map lapic addr for preenabled x2apic systems").

Simply map it won't work either, in x2apic mode the MMIO interface is
not usable (Intel SDM Volume 3A 10.12.2), later code will fail with
other errors. So here we do a x2apic driver probe and switch to
x2apic driver for early boot info access.

Such issue is currently only seen with kdump/kexec, kernel enabled the
x2apic in first kernel and kept it enabled to 2nd kernel.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 arch/x86/include/asm/apic.h           |  1 +
 arch/x86/kernel/apic/x2apic_cluster.c | 11 +++++++++++
 arch/x86/kernel/mpparse.c             |  4 +++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index d21f48f1c242..42902c7abedf 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -228,6 +228,7 @@ extern int x2apic_mode;
 extern int x2apic_phys;
 extern void __init x2apic_set_max_apicid(u32 apicid);
 extern void x2apic_setup(void);
+extern void x2apic_kexec_early_fix(void);
 static inline int x2apic_enabled(void)
 {
 	return boot_cpu_has(X86_FEATURE_X2APIC) && apic_is_x2apic_enabled();
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index a8306089c91b..2de800bed66d 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -261,3 +261,14 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 };
 
 apic_driver(apic_x2apic_cluster);
+
+/*
+ * Kexec may have x2apic enabled but ACPI disabled,
+ * in such case x2apic driver need to be loaded early
+ * for non-ACPI routine (MPtable) to work.
+ */
+void x2apic_kexec_early_fix(void)
+{
+	if (x2apic_enabled())
+		apic_install_driver(&apic_x2apic_cluster);
+}
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index b223922248e9..509a28febc4a 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -197,8 +197,10 @@ static int __init smp_read_mpc(struct mpc_table *mpc, unsigned early)
 		return 0;
 
 	/* Initialize the lapic mapping */
-	if (!acpi_lapic)
+	if (!acpi_lapic) {
+		x2apic_kexec_early_fix();
 		register_lapic_address(mpc->lapic);
+	}
 
 	if (early)
 		return 1;
-- 
2.43.0

