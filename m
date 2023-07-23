Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F1C75E1D7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 14:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjGWM2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 08:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjGWM2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 08:28:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E32B2;
        Sun, 23 Jul 2023 05:28:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B9ED60CF9;
        Sun, 23 Jul 2023 12:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1F9C433C7;
        Sun, 23 Jul 2023 12:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690115316;
        bh=3j6boO9BLIVMiKFAoL/JgILI/K5U0HR/yrgpKNdX5pU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=opHgkkDU5eZ60Cb6mMpo+A7SMBFIcZBUxCF3diyEhQL9Uly0XShpW1TGXwvJw3aMM
         CiYDg6rwPJeObpDzCHLYeKTrwuNr9xJuXv0dTp/7kAE+Yxfzw3av+PTopzhwZUXrLj
         WMi/ge/Y1mWYjm1CH5pPZMDlbVJtGggHq2WeX9Ho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.40
Date:   Sun, 23 Jul 2023 14:28:26 +0200
Message-ID: <2023072326-happily-trinity-0df2@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023072326-outfield-throat-a778@gregkh>
References: <2023072326-outfield-throat-a778@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/admin-guide/device-mapper/dm-init.rst b/Documentation/admin-guide/device-mapper/dm-init.rst
index e5242ff17e9b..981d6a907699 100644
--- a/Documentation/admin-guide/device-mapper/dm-init.rst
+++ b/Documentation/admin-guide/device-mapper/dm-init.rst
@@ -123,3 +123,11 @@ Other examples (per target):
     0 1638400 verity 1 8:1 8:2 4096 4096 204800 1 sha256
     fb1a5a0f00deb908d8b53cb270858975e76cf64105d412ce764225d53b8f3cfd
     51934789604d1b92399c52e7cb149d1b3a1b74bbbcb103b2a0aaacbed5c08584
+
+For setups using device-mapper on top of asynchronously probed block
+devices (MMC, USB, ..), it may be necessary to tell dm-init to
+explicitly wait for them to become available before setting up the
+device-mapper tables. This can be done with the "dm-mod.waitfor="
+module parameter, which takes a list of devices to wait for::
+
+  dm-mod.waitfor=<device1>[,..,<deviceN>]
diff --git a/Makefile b/Makefile
index f0619754c29a..2bb0c01391a9 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 39
+SUBLEVEL = 40
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 5cedb28e8a40..8042a87b8511 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -317,7 +317,7 @@ struct kvm_vcpu_arch {
 	unsigned int aux_inuse;
 
 	/* COP0 State */
-	struct mips_coproc *cop0;
+	struct mips_coproc cop0;
 
 	/* Resume PC after MMIO completion */
 	unsigned long io_pc;
@@ -698,7 +698,7 @@ static inline bool kvm_mips_guest_can_have_fpu(struct kvm_vcpu_arch *vcpu)
 static inline bool kvm_mips_guest_has_fpu(struct kvm_vcpu_arch *vcpu)
 {
 	return kvm_mips_guest_can_have_fpu(vcpu) &&
-		kvm_read_c0_guest_config1(vcpu->cop0) & MIPS_CONF1_FP;
+		kvm_read_c0_guest_config1(&vcpu->cop0) & MIPS_CONF1_FP;
 }
 
 static inline bool kvm_mips_guest_can_have_msa(struct kvm_vcpu_arch *vcpu)
@@ -710,7 +710,7 @@ static inline bool kvm_mips_guest_can_have_msa(struct kvm_vcpu_arch *vcpu)
 static inline bool kvm_mips_guest_has_msa(struct kvm_vcpu_arch *vcpu)
 {
 	return kvm_mips_guest_can_have_msa(vcpu) &&
-		kvm_read_c0_guest_config3(vcpu->cop0) & MIPS_CONF3_MSA;
+		kvm_read_c0_guest_config3(&vcpu->cop0) & MIPS_CONF3_MSA;
 }
 
 struct kvm_mips_callbacks {
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 6f5d82595877..482af80b8179 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1675,7 +1675,10 @@ static inline void decode_cpucfg(struct cpuinfo_mips *c)
 
 static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 {
+	c->cputype = CPU_LOONGSON64;
+
 	/* All Loongson processors covered here define ExcCode 16 as GSExc. */
+	decode_configs(c);
 	c->options |= MIPS_CPU_GSEXCEX;
 
 	switch (c->processor_id & PRID_IMP_MASK) {
@@ -1685,7 +1688,6 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 		case PRID_REV_LOONGSON2K_R1_1:
 		case PRID_REV_LOONGSON2K_R1_2:
 		case PRID_REV_LOONGSON2K_R1_3:
-			c->cputype = CPU_LOONGSON64;
 			__cpu_name[cpu] = "Loongson-2K";
 			set_elf_platform(cpu, "gs264e");
 			set_isa(c, MIPS_CPU_ISA_M64R2);
@@ -1698,14 +1700,12 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 		switch (c->processor_id & PRID_REV_MASK) {
 		case PRID_REV_LOONGSON3A_R2_0:
 		case PRID_REV_LOONGSON3A_R2_1:
-			c->cputype = CPU_LOONGSON64;
 			__cpu_name[cpu] = "ICT Loongson-3";
 			set_elf_platform(cpu, "loongson3a");
 			set_isa(c, MIPS_CPU_ISA_M64R2);
 			break;
 		case PRID_REV_LOONGSON3A_R3_0:
 		case PRID_REV_LOONGSON3A_R3_1:
-			c->cputype = CPU_LOONGSON64;
 			__cpu_name[cpu] = "ICT Loongson-3";
 			set_elf_platform(cpu, "loongson3a");
 			set_isa(c, MIPS_CPU_ISA_M64R2);
@@ -1725,7 +1725,6 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 		c->ases &= ~MIPS_ASE_VZ; /* VZ of Loongson-3A2000/3000 is incomplete */
 		break;
 	case PRID_IMP_LOONGSON_64G:
-		c->cputype = CPU_LOONGSON64;
 		__cpu_name[cpu] = "ICT Loongson-3";
 		set_elf_platform(cpu, "loongson3a");
 		set_isa(c, MIPS_CPU_ISA_M64R2);
@@ -1735,8 +1734,6 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 		panic("Unknown Loongson Processor ID!");
 		break;
 	}
-
-	decode_configs(c);
 }
 #else
 static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu) { }
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index edaec93a1a1f..e64372b8f66a 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -312,7 +312,7 @@ int kvm_get_badinstrp(u32 *opc, struct kvm_vcpu *vcpu, u32 *out)
  */
 int kvm_mips_count_disabled(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 
 	return	(vcpu->arch.count_ctl & KVM_REG_MIPS_COUNT_CTL_DC) ||
 		(kvm_read_c0_guest_cause(cop0) & CAUSEF_DC);
@@ -384,7 +384,7 @@ static inline ktime_t kvm_mips_count_time(struct kvm_vcpu *vcpu)
  */
 static u32 kvm_mips_read_count_running(struct kvm_vcpu *vcpu, ktime_t now)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	ktime_t expires, threshold;
 	u32 count, compare;
 	int running;
@@ -444,7 +444,7 @@ static u32 kvm_mips_read_count_running(struct kvm_vcpu *vcpu, ktime_t now)
  */
 u32 kvm_mips_read_count(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 
 	/* If count disabled just read static copy of count */
 	if (kvm_mips_count_disabled(vcpu))
@@ -502,7 +502,7 @@ ktime_t kvm_mips_freeze_hrtimer(struct kvm_vcpu *vcpu, u32 *count)
 static void kvm_mips_resume_hrtimer(struct kvm_vcpu *vcpu,
 				    ktime_t now, u32 count)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	u32 compare;
 	u64 delta;
 	ktime_t expire;
@@ -603,7 +603,7 @@ int kvm_mips_restore_hrtimer(struct kvm_vcpu *vcpu, ktime_t before,
  */
 void kvm_mips_write_count(struct kvm_vcpu *vcpu, u32 count)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	ktime_t now;
 
 	/* Calculate bias */
@@ -649,7 +649,7 @@ void kvm_mips_init_count(struct kvm_vcpu *vcpu, unsigned long count_hz)
  */
 int kvm_mips_set_count_hz(struct kvm_vcpu *vcpu, s64 count_hz)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	int dc;
 	ktime_t now;
 	u32 count;
@@ -696,7 +696,7 @@ int kvm_mips_set_count_hz(struct kvm_vcpu *vcpu, s64 count_hz)
  */
 void kvm_mips_write_compare(struct kvm_vcpu *vcpu, u32 compare, bool ack)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	int dc;
 	u32 old_compare = kvm_read_c0_guest_compare(cop0);
 	s32 delta = compare - old_compare;
@@ -779,7 +779,7 @@ void kvm_mips_write_compare(struct kvm_vcpu *vcpu, u32 compare, bool ack)
  */
 static ktime_t kvm_mips_count_disable(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	u32 count;
 	ktime_t now;
 
@@ -806,7 +806,7 @@ static ktime_t kvm_mips_count_disable(struct kvm_vcpu *vcpu)
  */
 void kvm_mips_count_disable_cause(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 
 	kvm_set_c0_guest_cause(cop0, CAUSEF_DC);
 	if (!(vcpu->arch.count_ctl & KVM_REG_MIPS_COUNT_CTL_DC))
@@ -826,7 +826,7 @@ void kvm_mips_count_disable_cause(struct kvm_vcpu *vcpu)
  */
 void kvm_mips_count_enable_cause(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	u32 count;
 
 	kvm_clear_c0_guest_cause(cop0, CAUSEF_DC);
@@ -852,7 +852,7 @@ void kvm_mips_count_enable_cause(struct kvm_vcpu *vcpu)
  */
 int kvm_mips_set_count_ctl(struct kvm_vcpu *vcpu, s64 count_ctl)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	s64 changed = count_ctl ^ vcpu->arch.count_ctl;
 	s64 delta;
 	ktime_t expire, now;
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index a25e0b73ee70..a4f4407b0a33 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -659,7 +659,7 @@ static int kvm_mips_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices)
 static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 			    const struct kvm_one_reg *reg)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	struct mips_fpu_struct *fpu = &vcpu->arch.fpu;
 	int ret;
 	s64 v;
@@ -771,7 +771,7 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
 static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
 			    const struct kvm_one_reg *reg)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	struct mips_fpu_struct *fpu = &vcpu->arch.fpu;
 	s64 v;
 	s64 vs[2];
@@ -1111,7 +1111,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
 {
 	return kvm_mips_pending_timer(vcpu) ||
-		kvm_read_c0_guest_cause(vcpu->arch.cop0) & C_TI;
+		kvm_read_c0_guest_cause(&vcpu->arch.cop0) & C_TI;
 }
 
 int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu)
@@ -1135,7 +1135,7 @@ int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu)
 	kvm_debug("\thi: 0x%08lx\n", vcpu->arch.hi);
 	kvm_debug("\tlo: 0x%08lx\n", vcpu->arch.lo);
 
-	cop0 = vcpu->arch.cop0;
+	cop0 = &vcpu->arch.cop0;
 	kvm_debug("\tStatus: 0x%08x, Cause: 0x%08x\n",
 		  kvm_read_c0_guest_status(cop0),
 		  kvm_read_c0_guest_cause(cop0));
@@ -1257,7 +1257,7 @@ static int __kvm_mips_handle_exit(struct kvm_vcpu *vcpu)
 
 	case EXCCODE_TLBS:
 		kvm_debug("TLB ST fault:  cause %#x, status %#x, PC: %p, BadVaddr: %#lx\n",
-			  cause, kvm_read_c0_guest_status(vcpu->arch.cop0), opc,
+			  cause, kvm_read_c0_guest_status(&vcpu->arch.cop0), opc,
 			  badvaddr);
 
 		++vcpu->stat.tlbmiss_st_exits;
@@ -1329,7 +1329,7 @@ static int __kvm_mips_handle_exit(struct kvm_vcpu *vcpu)
 		kvm_get_badinstr(opc, vcpu, &inst);
 		kvm_err("Exception Code: %d, not yet handled, @ PC: %p, inst: 0x%08x  BadVaddr: %#lx Status: %#x\n",
 			exccode, opc, inst, badvaddr,
-			kvm_read_c0_guest_status(vcpu->arch.cop0));
+			kvm_read_c0_guest_status(&vcpu->arch.cop0));
 		kvm_arch_vcpu_dump_regs(vcpu);
 		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		ret = RESUME_HOST;
@@ -1402,7 +1402,7 @@ int noinstr kvm_mips_handle_exit(struct kvm_vcpu *vcpu)
 /* Enable FPU for guest and restore context */
 void kvm_own_fpu(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	unsigned int sr, cfg5;
 
 	preempt_disable();
@@ -1446,7 +1446,7 @@ void kvm_own_fpu(struct kvm_vcpu *vcpu)
 /* Enable MSA for guest and restore context */
 void kvm_own_msa(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	unsigned int sr, cfg5;
 
 	preempt_disable();
diff --git a/arch/mips/kvm/stats.c b/arch/mips/kvm/stats.c
index 53f851a61554..3e6682018fbe 100644
--- a/arch/mips/kvm/stats.c
+++ b/arch/mips/kvm/stats.c
@@ -54,9 +54,9 @@ void kvm_mips_dump_stats(struct kvm_vcpu *vcpu)
 	kvm_info("\nKVM VCPU[%d] COP0 Access Profile:\n", vcpu->vcpu_id);
 	for (i = 0; i < N_MIPS_COPROC_REGS; i++) {
 		for (j = 0; j < N_MIPS_COPROC_SEL; j++) {
-			if (vcpu->arch.cop0->stat[i][j])
+			if (vcpu->arch.cop0.stat[i][j])
 				kvm_info("%s[%d]: %lu\n", kvm_cop0_str[i], j,
-					 vcpu->arch.cop0->stat[i][j]);
+					 vcpu->arch.cop0.stat[i][j]);
 		}
 	}
 #endif
diff --git a/arch/mips/kvm/trace.h b/arch/mips/kvm/trace.h
index a8c7fd7bf6d2..136c3535a1cb 100644
--- a/arch/mips/kvm/trace.h
+++ b/arch/mips/kvm/trace.h
@@ -322,11 +322,11 @@ TRACE_EVENT_FN(kvm_guest_mode_change,
 	    ),
 
 	    TP_fast_assign(
-			__entry->epc = kvm_read_c0_guest_epc(vcpu->arch.cop0);
+			__entry->epc = kvm_read_c0_guest_epc(&vcpu->arch.cop0);
 			__entry->pc = vcpu->arch.pc;
-			__entry->badvaddr = kvm_read_c0_guest_badvaddr(vcpu->arch.cop0);
-			__entry->status = kvm_read_c0_guest_status(vcpu->arch.cop0);
-			__entry->cause = kvm_read_c0_guest_cause(vcpu->arch.cop0);
+			__entry->badvaddr = kvm_read_c0_guest_badvaddr(&vcpu->arch.cop0);
+			__entry->status = kvm_read_c0_guest_status(&vcpu->arch.cop0);
+			__entry->cause = kvm_read_c0_guest_cause(&vcpu->arch.cop0);
 	    ),
 
 	    TP_printk("EPC: 0x%08lx PC: 0x%08lx Status: 0x%08x Cause: 0x%08x BadVAddr: 0x%08lx",
diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
index c706f5890a05..c8f7d793bc63 100644
--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -422,7 +422,7 @@ static void _kvm_vz_restore_htimer(struct kvm_vcpu *vcpu,
  */
 static void kvm_vz_restore_timer(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	u32 cause, compare;
 
 	compare = kvm_read_sw_gc0_compare(cop0);
@@ -517,7 +517,7 @@ static void _kvm_vz_save_htimer(struct kvm_vcpu *vcpu,
  */
 static void kvm_vz_save_timer(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	u32 gctl0, compare, cause;
 
 	gctl0 = read_c0_guestctl0();
@@ -863,7 +863,7 @@ static unsigned long mips_process_maar(unsigned int op, unsigned long val)
 
 static void kvm_write_maari(struct kvm_vcpu *vcpu, unsigned long val)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 
 	val &= MIPS_MAARI_INDEX;
 	if (val == MIPS_MAARI_INDEX)
@@ -876,7 +876,7 @@ static enum emulation_result kvm_vz_gpsi_cop0(union mips_instruction inst,
 					      u32 *opc, u32 cause,
 					      struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	enum emulation_result er = EMULATE_DONE;
 	u32 rt, rd, sel;
 	unsigned long curr_pc;
@@ -1911,7 +1911,7 @@ static int kvm_vz_get_one_reg(struct kvm_vcpu *vcpu,
 			      const struct kvm_one_reg *reg,
 			      s64 *v)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	unsigned int idx;
 
 	switch (reg->id) {
@@ -2081,7 +2081,7 @@ static int kvm_vz_get_one_reg(struct kvm_vcpu *vcpu,
 	case KVM_REG_MIPS_CP0_MAARI:
 		if (!cpu_guest_has_maar || cpu_guest_has_dyn_maar)
 			return -EINVAL;
-		*v = kvm_read_sw_gc0_maari(vcpu->arch.cop0);
+		*v = kvm_read_sw_gc0_maari(&vcpu->arch.cop0);
 		break;
 #ifdef CONFIG_64BIT
 	case KVM_REG_MIPS_CP0_XCONTEXT:
@@ -2135,7 +2135,7 @@ static int kvm_vz_set_one_reg(struct kvm_vcpu *vcpu,
 			      const struct kvm_one_reg *reg,
 			      s64 v)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	unsigned int idx;
 	int ret = 0;
 	unsigned int cur, change;
@@ -2562,7 +2562,7 @@ static void kvm_vz_vcpu_load_tlb(struct kvm_vcpu *vcpu, int cpu)
 
 static int kvm_vz_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	bool migrated, all;
 
 	/*
@@ -2704,7 +2704,7 @@ static int kvm_vz_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 static int kvm_vz_vcpu_put(struct kvm_vcpu *vcpu, int cpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 
 	if (current->flags & PF_VCPU)
 		kvm_vz_vcpu_save_wired(vcpu);
@@ -3076,7 +3076,7 @@ static void kvm_vz_vcpu_uninit(struct kvm_vcpu *vcpu)
 
 static int kvm_vz_vcpu_setup(struct kvm_vcpu *vcpu)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct mips_coproc *cop0 = &vcpu->arch.cop0;
 	unsigned long count_hz = 100*1000*1000; /* default to 100 MHz */
 
 	/*
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 894d48cd0492..054844153b1f 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -402,3 +402,11 @@ checkbin:
 		echo -n '*** Please use a different binutils version.' ; \
 		false ; \
 	fi
+	@if test "x${CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT}" = "xy" -a \
+		"x${CONFIG_LD_IS_BFD}" = "xy" -a \
+		"${CONFIG_LD_VERSION}" = "23700" ; then \
+		echo -n '*** binutils 2.37 drops unused section symbols, which recordmcount ' ; \
+		echo 'is unable to handle.' ; \
+		echo '*** Please use a different binutils version.' ; \
+		false ; \
+	fi
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 206475e3e0b4..4856e1a5161c 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -364,26 +364,27 @@ ssize_t cpu_show_spec_store_bypass(struct device *dev, struct device_attribute *
 
 static int ssb_prctl_get(struct task_struct *task)
 {
+	/*
+	 * The STF_BARRIER feature is on by default, so if it's off that means
+	 * firmware has explicitly said the CPU is not vulnerable via either
+	 * the hypercall or device tree.
+	 */
+	if (!security_ftr_enabled(SEC_FTR_STF_BARRIER))
+		return PR_SPEC_NOT_AFFECTED;
+
+	/*
+	 * If the system's CPU has no known barrier (see setup_stf_barrier())
+	 * then assume that the CPU is not vulnerable.
+	 */
 	if (stf_enabled_flush_types == STF_BARRIER_NONE)
-		/*
-		 * We don't have an explicit signal from firmware that we're
-		 * vulnerable or not, we only have certain CPU revisions that
-		 * are known to be vulnerable.
-		 *
-		 * We assume that if we're on another CPU, where the barrier is
-		 * NONE, then we are not vulnerable.
-		 */
 		return PR_SPEC_NOT_AFFECTED;
-	else
-		/*
-		 * If we do have a barrier type then we are vulnerable. The
-		 * barrier is not a global or per-process mitigation, so the
-		 * only value we can report here is PR_SPEC_ENABLE, which
-		 * appears as "vulnerable" in /proc.
-		 */
-		return PR_SPEC_ENABLE;
-
-	return -EINVAL;
+
+	/*
+	 * Otherwise the CPU is vulnerable. The barrier is not a global or
+	 * per-process mitigation, so the only value that can be reported here
+	 * is PR_SPEC_ENABLE, which appears as "vulnerable" in /proc.
+	 */
+	return PR_SPEC_ENABLE;
 }
 
 int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
diff --git a/arch/powerpc/mm/book3s64/hash_native.c b/arch/powerpc/mm/book3s64/hash_native.c
index 9342e79870df..430d1d935a7c 100644
--- a/arch/powerpc/mm/book3s64/hash_native.c
+++ b/arch/powerpc/mm/book3s64/hash_native.c
@@ -328,10 +328,12 @@ static long native_hpte_insert(unsigned long hpte_group, unsigned long vpn,
 
 static long native_hpte_remove(unsigned long hpte_group)
 {
+	unsigned long hpte_v, flags;
 	struct hash_pte *hptep;
 	int i;
 	int slot_offset;
-	unsigned long hpte_v;
+
+	local_irq_save(flags);
 
 	DBG_LOW("    remove(group=%lx)\n", hpte_group);
 
@@ -356,13 +358,16 @@ static long native_hpte_remove(unsigned long hpte_group)
 		slot_offset &= 0x7;
 	}
 
-	if (i == HPTES_PER_GROUP)
-		return -1;
+	if (i == HPTES_PER_GROUP) {
+		i = -1;
+		goto out;
+	}
 
 	/* Invalidate the hpte. NOTE: this also unlocks it */
 	release_hpte_lock();
 	hptep->v = 0;
-
+out:
+	local_irq_restore(flags);
 	return i;
 }
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 9390cdff39ff..7c4852af9e3f 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1187,7 +1187,7 @@ static void __init reserve_crashkernel(void)
 	 */
 	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
 					       search_start,
-					       min(search_end, (unsigned long) SZ_4G));
+					       min(search_end, (unsigned long)(SZ_4G - 1)));
 	if (crash_base == 0) {
 		/* Try again without restricting region to 32bit addressible memory */
 		crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index d926e0f7ef57..5ee21a19969c 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -69,7 +69,7 @@ struct rv_jit_context {
 	struct bpf_prog *prog;
 	u16 *insns;		/* RV insns */
 	int ninsns;
-	int body_len;
+	int prologue_len;
 	int epilogue_offset;
 	int *offset;		/* BPF to RV */
 	int nexentries;
@@ -216,8 +216,8 @@ static inline int rv_offset(int insn, int off, struct rv_jit_context *ctx)
 	int from, to;
 
 	off++; /* BPF branch is from PC+1, RV is from PC */
-	from = (insn > 0) ? ctx->offset[insn - 1] : 0;
-	to = (insn + off > 0) ? ctx->offset[insn + off - 1] : 0;
+	from = (insn > 0) ? ctx->offset[insn - 1] : ctx->prologue_len;
+	to = (insn + off > 0) ? ctx->offset[insn + off - 1] : ctx->prologue_len;
 	return ninsns_rvoff(to - from);
 }
 
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 737baf8715da..7a26a3e1c73c 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -44,7 +44,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	unsigned int prog_size = 0, extable_size = 0;
 	bool tmp_blinded = false, extra_pass = false;
 	struct bpf_prog *tmp, *orig_prog = prog;
-	int pass = 0, prev_ninsns = 0, prologue_len, i;
+	int pass = 0, prev_ninsns = 0, i;
 	struct rv_jit_data *jit_data;
 	struct rv_jit_context *ctx;
 
@@ -83,6 +83,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		prog = orig_prog;
 		goto out_offset;
 	}
+
+	if (build_body(ctx, extra_pass, NULL)) {
+		prog = orig_prog;
+		goto out_offset;
+	}
+
 	for (i = 0; i < prog->len; i++) {
 		prev_ninsns += 32;
 		ctx->offset[i] = prev_ninsns;
@@ -91,12 +97,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	for (i = 0; i < NR_JIT_ITERATIONS; i++) {
 		pass++;
 		ctx->ninsns = 0;
+
+		bpf_jit_build_prologue(ctx);
+		ctx->prologue_len = ctx->ninsns;
+
 		if (build_body(ctx, extra_pass, ctx->offset)) {
 			prog = orig_prog;
 			goto out_offset;
 		}
-		ctx->body_len = ctx->ninsns;
-		bpf_jit_build_prologue(ctx);
+
 		ctx->epilogue_offset = ctx->ninsns;
 		bpf_jit_build_epilogue(ctx);
 
@@ -162,10 +171,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 
 	if (!prog->is_func || extra_pass) {
 		bpf_jit_binary_lock_ro(jit_data->header);
-		prologue_len = ctx->epilogue_offset - ctx->body_len;
 		for (i = 0; i < prog->len; i++)
-			ctx->offset[i] = ninsns_rvoff(prologue_len +
-						      ctx->offset[i]);
+			ctx->offset[i] = ninsns_rvoff(ctx->offset[i]);
 		bpf_prog_fill_jited_linfo(prog, ctx->offset);
 out_offset:
 		kfree(ctx->offset);
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index ed646c583e4f..5ed242897b0d 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -27,6 +27,7 @@ KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float -mbac
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS_DECOMPRESSOR += -ffreestanding
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-stack-protector
+KBUILD_CFLAGS_DECOMPRESSOR += -fPIE
 KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5a1d0ea402e4..2fb5e1541efc 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3975,6 +3975,13 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		struct perf_event *leader = event->group_leader;
 		struct perf_event *sibling = NULL;
 
+		/*
+		 * When this memload event is also the first event (no group
+		 * exists yet), then there is no aux event before it.
+		 */
+		if (leader == event)
+			return -ENODATA;
+
 		if (!is_mem_loads_aux_event(leader)) {
 			for_each_sibling_event(sibling, leader) {
 				if (is_mem_loads_aux_event(sibling))
diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index 9ac46ab3a296..119345eeb04c 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -237,7 +237,7 @@ static int tuntap_probe(struct iss_net_private *lp, int index, char *init)
 
 	init += sizeof(TRANSPORT_TUNTAP_NAME) - 1;
 	if (*init == ',') {
-		rem = split_if_spec(init + 1, &mac_str, &dev_name);
+		rem = split_if_spec(init + 1, &mac_str, &dev_name, NULL);
 		if (rem != NULL) {
 			pr_err("%s: extra garbage on specification : '%s'\n",
 			       dev->name, rem);
diff --git a/block/blk-crypto-profile.c b/block/blk-crypto-profile.c
index 3290c03c9918..aa7fc1436893 100644
--- a/block/blk-crypto-profile.c
+++ b/block/blk-crypto-profile.c
@@ -79,7 +79,14 @@ int blk_crypto_profile_init(struct blk_crypto_profile *profile,
 	unsigned int slot_hashtable_size;
 
 	memset(profile, 0, sizeof(*profile));
-	init_rwsem(&profile->lock);
+
+	/*
+	 * profile->lock of an underlying device can nest inside profile->lock
+	 * of a device-mapper device, so use a dynamic lock class to avoid
+	 * false-positive lockdep reports.
+	 */
+	lockdep_register_key(&profile->lockdep_key);
+	__init_rwsem(&profile->lock, "&profile->lock", &profile->lockdep_key);
 
 	if (num_slots == 0)
 		return 0;
@@ -89,7 +96,7 @@ int blk_crypto_profile_init(struct blk_crypto_profile *profile,
 	profile->slots = kvcalloc(num_slots, sizeof(profile->slots[0]),
 				  GFP_KERNEL);
 	if (!profile->slots)
-		return -ENOMEM;
+		goto err_destroy;
 
 	profile->num_slots = num_slots;
 
@@ -441,6 +448,7 @@ void blk_crypto_profile_destroy(struct blk_crypto_profile *profile)
 {
 	if (!profile)
 		return;
+	lockdep_unregister_key(&profile->lockdep_key);
 	kvfree(profile->slot_hashtable);
 	kvfree_sensitive(profile->slots,
 			 sizeof(profile->slots[0]) * profile->num_slots);
diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 3de89795f584..18fc1c436081 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -843,7 +843,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 		if (!d->config_buf)
 			goto err_alloc;
 
-		for (i = 0; i < chip->num_config_regs; i++) {
+		for (i = 0; i < chip->num_config_bases; i++) {
 			d->config_buf[i] = kcalloc(chip->num_config_regs,
 						   sizeof(**d->config_buf),
 						   GFP_KERNEL);
diff --git a/drivers/bus/intel-ixp4xx-eb.c b/drivers/bus/intel-ixp4xx-eb.c
index 91db001eb69a..972603ed06a6 100644
--- a/drivers/bus/intel-ixp4xx-eb.c
+++ b/drivers/bus/intel-ixp4xx-eb.c
@@ -33,7 +33,7 @@
 #define IXP4XX_EXP_TIMING_STRIDE	0x04
 #define IXP4XX_EXP_CS_EN		BIT(31)
 #define IXP456_EXP_PAR_EN		BIT(30) /* Only on IXP45x and IXP46x */
-#define IXP4XX_EXP_T1_MASK		GENMASK(28, 27)
+#define IXP4XX_EXP_T1_MASK		GENMASK(29, 28)
 #define IXP4XX_EXP_T1_SHIFT		28
 #define IXP4XX_EXP_T2_MASK		GENMASK(27, 26)
 #define IXP4XX_EXP_T2_SHIFT		26
diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index a1c24148ed31..75fb46298a87 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -110,7 +110,7 @@ static int imx_rngc_self_test(struct imx_rngc *rngc)
 	cmd = readl(rngc->base + RNGC_COMMAND);
 	writel(cmd | RNGC_CMD_SELF_TEST, rngc->base + RNGC_COMMAND);
 
-	ret = wait_for_completion_timeout(&rngc->rng_op_done, RNGC_TIMEOUT);
+	ret = wait_for_completion_timeout(&rngc->rng_op_done, msecs_to_jiffies(RNGC_TIMEOUT));
 	imx_rngc_irq_mask_clear(rngc);
 	if (!ret)
 		return -ETIMEDOUT;
@@ -187,9 +187,7 @@ static int imx_rngc_init(struct hwrng *rng)
 		cmd = readl(rngc->base + RNGC_COMMAND);
 		writel(cmd | RNGC_CMD_SEED, rngc->base + RNGC_COMMAND);
 
-		ret = wait_for_completion_timeout(&rngc->rng_op_done,
-				RNGC_TIMEOUT);
-
+		ret = wait_for_completion_timeout(&rngc->rng_op_done, msecs_to_jiffies(RNGC_TIMEOUT));
 		if (!ret) {
 			ret = -ETIMEDOUT;
 			goto err;
diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 95d847c9de79..d7ef4d0a7409 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -515,6 +515,7 @@ static int tpm_add_legacy_sysfs(struct tpm_chip *chip)
  * 6.x.y.z series: 6.0.18.6 +
  * 3.x.y.z series: 3.57.y.5 +
  */
+#ifdef CONFIG_X86
 static bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
 {
 	u32 val1, val2;
@@ -563,6 +564,12 @@ static bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
 
 	return true;
 }
+#else
+static inline bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
+{
+	return false;
+}
+#endif /* CONFIG_X86 */
 
 static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {
diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 916f4ff246c1..cbbedf52607c 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -563,15 +563,18 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	u32 rsp_size;
 	int ret;
 
-	INIT_LIST_HEAD(&acpi_resource_list);
-	ret = acpi_dev_get_resources(device, &acpi_resource_list,
-				     crb_check_resource, iores_array);
-	if (ret < 0)
-		return ret;
-	acpi_dev_free_resource_list(&acpi_resource_list);
-
-	/* Pluton doesn't appear to define ACPI memory regions */
+	/*
+	 * Pluton sometimes does not define ACPI memory regions.
+	 * Mapping is then done in crb_map_pluton
+	 */
 	if (priv->sm != ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON) {
+		INIT_LIST_HEAD(&acpi_resource_list);
+		ret = acpi_dev_get_resources(device, &acpi_resource_list,
+					     crb_check_resource, iores_array);
+		if (ret < 0)
+			return ret;
+		acpi_dev_free_resource_list(&acpi_resource_list);
+
 		if (resource_type(iores_array) != IORESOURCE_MEM) {
 			dev_err(dev, FW_BUG "TPM2 ACPI table does not define a memory resource\n");
 			return -EINVAL;
diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index f3a7251c8e38..9586e0857a3e 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -189,21 +189,28 @@ static int tpm_tis_i2c_read_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
 	int ret;
 
 	for (i = 0; i < TPM_RETRY; i++) {
-		/* write register */
-		msg.len = sizeof(reg);
-		msg.buf = &reg;
-		msg.flags = 0;
-		ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
-		if (ret < 0)
-			return ret;
-
-		/* read data */
-		msg.buf = result;
-		msg.len = len;
-		msg.flags = I2C_M_RD;
-		ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
-		if (ret < 0)
-			return ret;
+		u16 read = 0;
+
+		while (read < len) {
+			/* write register */
+			msg.len = sizeof(reg);
+			msg.buf = &reg;
+			msg.flags = 0;
+			ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
+			if (ret < 0)
+				return ret;
+
+			/* read data */
+			msg.buf = result + read;
+			msg.len = len - read;
+			msg.flags = I2C_M_RD;
+			if (msg.len > I2C_SMBUS_BLOCK_MAX)
+				msg.len = I2C_SMBUS_BLOCK_MAX;
+			ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
+			if (ret < 0)
+				return ret;
+			read += msg.len;
+		}
 
 		ret = tpm_tis_i2c_sanity_check_read(reg, len, result);
 		if (ret == 0)
@@ -223,19 +230,27 @@ static int tpm_tis_i2c_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
 	struct i2c_msg msg = { .addr = phy->i2c_client->addr };
 	u8 reg = tpm_tis_i2c_address_to_register(addr);
 	int ret;
+	u16 wrote = 0;
 
 	if (len > TPM_BUFSIZE - 1)
 		return -EIO;
 
-	/* write register and data in one go */
 	phy->io_buf[0] = reg;
-	memcpy(phy->io_buf + sizeof(reg), value, len);
-
-	msg.len = sizeof(reg) + len;
 	msg.buf = phy->io_buf;
-	ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
-	if (ret < 0)
-		return ret;
+	while (wrote < len) {
+		/* write register and data in one go */
+		msg.len = sizeof(reg) + len - wrote;
+		if (msg.len > I2C_SMBUS_BLOCK_MAX)
+			msg.len = I2C_SMBUS_BLOCK_MAX;
+
+		memcpy(phy->io_buf + sizeof(reg), value + wrote,
+		       msg.len - sizeof(reg));
+
+		ret = tpm_tis_i2c_retry_transfer_until_ack(data, &msg);
+		if (ret < 0)
+			return ret;
+		wrote += msg.len - sizeof(reg);
+	}
 
 	return 0;
 }
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index 5c865987ba5c..30e953988cab 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -683,37 +683,21 @@ static struct miscdevice vtpmx_miscdev = {
 	.fops = &vtpmx_fops,
 };
 
-static int vtpmx_init(void)
-{
-	return misc_register(&vtpmx_miscdev);
-}
-
-static void vtpmx_cleanup(void)
-{
-	misc_deregister(&vtpmx_miscdev);
-}
-
 static int __init vtpm_module_init(void)
 {
 	int rc;
 
-	rc = vtpmx_init();
-	if (rc) {
-		pr_err("couldn't create vtpmx device\n");
-		return rc;
-	}
-
 	workqueue = create_workqueue("tpm-vtpm");
 	if (!workqueue) {
 		pr_err("couldn't create workqueue\n");
-		rc = -ENOMEM;
-		goto err_vtpmx_cleanup;
+		return -ENOMEM;
 	}
 
-	return 0;
-
-err_vtpmx_cleanup:
-	vtpmx_cleanup();
+	rc = misc_register(&vtpmx_miscdev);
+	if (rc) {
+		pr_err("couldn't create vtpmx device\n");
+		destroy_workqueue(workqueue);
+	}
 
 	return rc;
 }
@@ -721,7 +705,7 @@ static int __init vtpm_module_init(void)
 static void __exit vtpm_module_exit(void)
 {
 	destroy_workqueue(workqueue);
-	vtpmx_cleanup();
+	misc_deregister(&vtpmx_miscdev);
 }
 
 module_init(vtpm_module_init);
diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 80f4e2d14e04..2d674126160f 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -755,7 +755,7 @@ svc_create_memory_pool(struct platform_device *pdev,
 	end = rounddown(sh_memory->addr + sh_memory->size, PAGE_SIZE);
 	paddr = begin;
 	size = end - begin;
-	va = memremap(paddr, size, MEMREMAP_WC);
+	va = devm_memremap(dev, paddr, size, MEMREMAP_WC);
 	if (!va) {
 		dev_err(dev, "fail to remap shared memory\n");
 		return ERR_PTR(-EINVAL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index da01c1424b4a..260e6a3316db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2737,6 +2737,9 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 			if (!attachment->is_mapped)
 				continue;
 
+			if (attachment->bo_va->base.bo->tbo.pin_count)
+				continue;
+
 			kfd_mem_dmaunmap_attachment(mem, attachment);
 			ret = update_gpuvm_pte(mem, attachment, &sync_obj);
 			if (ret) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 58fe7279599f..ec938a1a5062 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1668,18 +1668,30 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 
 	/* Insert partial mapping before the range */
 	if (!list_empty(&before->list)) {
+		struct amdgpu_bo *bo = before->bo_va->base.bo;
+
 		amdgpu_vm_it_insert(before, &vm->va);
 		if (before->flags & AMDGPU_PTE_PRT)
 			amdgpu_vm_prt_get(adev);
+
+		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
+		    !before->bo_va->base.moved)
+			amdgpu_vm_bo_moved(&before->bo_va->base);
 	} else {
 		kfree(before);
 	}
 
 	/* Insert partial mapping after the range */
 	if (!list_empty(&after->list)) {
+		struct amdgpu_bo *bo = after->bo_va->base.bo;
+
 		amdgpu_vm_it_insert(after, &vm->va);
 		if (after->flags & AMDGPU_PTE_PRT)
 			amdgpu_vm_prt_get(adev);
+
+		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
+		    !after->bo_va->base.moved)
+			amdgpu_vm_bo_moved(&after->bo_va->base);
 	} else {
 		kfree(after);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index aa761ff3a5fa..7ba47fc1917b 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -346,7 +346,7 @@ static void nbio_v2_3_init_registers(struct amdgpu_device *adev)
 
 #define NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT		0x00000000 // off by default, no gains over L1
 #define NAVI10_PCIE__LC_L1_INACTIVITY_DEFAULT		0x00000009 // 1=1us, 9=1ms
-#define NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT	0x0000000E // 4ms
+#define NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT	0x0000000E // 400ms
 
 static void nbio_v2_3_enable_aspm(struct amdgpu_device *adev,
 				  bool enable)
@@ -479,9 +479,12 @@ static void nbio_v2_3_program_aspm(struct amdgpu_device *adev)
 		WREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP5, data);
 
 	def = data = RREG32_PCIE(smnPCIE_LC_CNTL);
-	data &= ~PCIE_LC_CNTL__LC_L0S_INACTIVITY_MASK;
-	data |= 0x9 << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
-	data |= 0x1 << PCIE_LC_CNTL__LC_PMI_TO_L1_DIS__SHIFT;
+	data |= NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L0S_INACTIVITY__SHIFT;
+	if (pci_is_thunderbolt_attached(adev->pdev))
+		data |= NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT  << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
+	else
+		data |= NAVI10_PCIE__LC_L1_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
+	data &= ~PCIE_LC_CNTL__LC_PMI_TO_L1_DIS_MASK;
 	if (def != data)
 		WREG32_PCIE(smnPCIE_LC_CNTL, data);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 5b251d009467..97b033dfe9e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2330,7 +2330,7 @@ const struct amd_ip_funcs sdma_v4_0_ip_funcs = {
 
 static const struct amdgpu_ring_funcs sdma_v4_0_ring_funcs = {
 	.type = AMDGPU_RING_TYPE_SDMA,
-	.align_mask = 0xf,
+	.align_mask = 0xff,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
 	.secure_submission_supported = true,
@@ -2400,7 +2400,7 @@ static const struct amdgpu_ring_funcs sdma_v4_0_ring_funcs_2nd_mmhub = {
 
 static const struct amdgpu_ring_funcs sdma_v4_0_page_ring_funcs = {
 	.type = AMDGPU_RING_TYPE_SDMA,
-	.align_mask = 0xf,
+	.align_mask = 0xff,
 	.nop = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP),
 	.support_64bit_ptrs = true,
 	.secure_submission_supported = true,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9be3769d68a8..b854eec2787e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6972,7 +6972,13 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 				drm_add_modes_noedid(connector, 640, 480);
 	} else {
 		amdgpu_dm_connector_ddc_get_modes(connector, edid);
-		amdgpu_dm_connector_add_common_modes(encoder, connector);
+		/* most eDP supports only timings from its edid,
+		 * usually only detailed timings are available
+		 * from eDP edid. timings which are not from edid
+		 * may damage eDP
+		 */
+		if (connector->connector_type != DRM_MODE_CONNECTOR_eDP)
+			amdgpu_dm_connector_add_common_modes(encoder, connector);
 		amdgpu_dm_connector_add_freesync_modes(connector, edid);
 	}
 	amdgpu_dm_fbc_init(connector);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 0329e548134b..db7744beed5f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -42,6 +42,30 @@
 #include "dm_helpers.h"
 #include "ddc_service_types.h"
 
+static u32 edid_extract_panel_id(struct edid *edid)
+{
+	return (u32)edid->mfg_id[0] << 24   |
+	       (u32)edid->mfg_id[1] << 16   |
+	       (u32)EDID_PRODUCT_ID(edid);
+}
+
+static void apply_edid_quirks(struct edid *edid, struct dc_edid_caps *edid_caps)
+{
+	uint32_t panel_id = edid_extract_panel_id(edid);
+
+	switch (panel_id) {
+	/* Workaround for some monitors which does not work well with FAMS */
+	case drm_edid_encode_panel_id('S', 'A', 'M', 0x0E5E):
+	case drm_edid_encode_panel_id('S', 'A', 'M', 0x7053):
+	case drm_edid_encode_panel_id('S', 'A', 'M', 0x71AC):
+		DRM_DEBUG_DRIVER("Disabling FAMS on monitor with panel id %X\n", panel_id);
+		edid_caps->panel_patch.disable_fams = true;
+		break;
+	default:
+		return;
+	}
+}
+
 /* dm_helpers_parse_edid_caps
  *
  * Parse edid caps
@@ -113,6 +137,8 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	else
 		edid_caps->speaker_flags = DEFAULT_SPEAKER_LOCATION;
 
+	apply_edid_quirks(edid_buf, edid_caps);
+
 	kfree(sads);
 	kfree(sadb);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index b405f2e86927..cca014344416 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1539,6 +1539,9 @@ bool dc_validate_boot_timing(const struct dc *dc,
 		return false;
 	}
 
+	if (dc->debug.force_odm_combine)
+		return false;
+
 	/* Check for enabled DIG to identify enabled display */
 	if (!link->link_enc->funcs->is_dig_enabled(link->link_enc))
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index e179e80667d1..19d7cfa53211 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -970,10 +970,12 @@ enum dc_status resource_map_phy_clock_resources(
 		|| dc_is_virtual_signal(pipe_ctx->stream->signal))
 		pipe_ctx->clock_source =
 				dc->res_pool->dp_clock_source;
-	else
-		pipe_ctx->clock_source = find_matching_pll(
-			&context->res_ctx, dc->res_pool,
-			stream);
+	else {
+		if (stream && stream->link && stream->link->link_enc)
+			pipe_ctx->clock_source = find_matching_pll(
+				&context->res_ctx, dc->res_pool,
+				stream);
+	}
 
 	if (pipe_ctx->clock_source == NULL)
 		return DC_NO_CLOCK_SOURCE_RESOURCE;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 2d49e99a152c..622efa556e7a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1678,6 +1678,17 @@ static void dcn20_program_pipe(
 
 		if (hws->funcs.setup_vupdate_interrupt)
 			hws->funcs.setup_vupdate_interrupt(dc, pipe_ctx);
+
+		if (hws->funcs.calculate_dccg_k1_k2_values && dc->res_pool->dccg->funcs->set_pixel_rate_div) {
+			unsigned int k1_div, k2_div;
+
+			hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
+
+			dc->res_pool->dccg->funcs->set_pixel_rate_div(
+				dc->res_pool->dccg,
+				pipe_ctx->stream_res.tg->inst,
+				k1_div, k2_div);
+		}
 	}
 
 	if (pipe_ctx->update_flags.bits.odm)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 2f4afe40f3e6..f5fa7abd97fc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1165,10 +1165,6 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 	unsigned int odm_combine_factor = 0;
 	bool two_pix_per_container = false;
 
-	// For phantom pipes, use the same programming as the main pipes
-	if (pipe_ctx->stream->mall_stream_config.type == SUBVP_PHANTOM) {
-		stream = pipe_ctx->stream->mall_stream_config.paired_stream;
-	}
 	two_pix_per_container = optc2_is_two_pixels_per_containter(&stream->timing);
 	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
index 2b33eeb213e2..fe941b103de8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
@@ -98,7 +98,7 @@ static void optc32_set_odm_combine(struct timing_generator *optc, int *opp_id, i
 	optc1->opp_count = opp_cnt;
 }
 
-static void optc32_set_h_timing_div_manual_mode(struct timing_generator *optc, bool manual_mode)
+void optc32_set_h_timing_div_manual_mode(struct timing_generator *optc, bool manual_mode)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h
index 5e57c39235fa..e5c5343e5640 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h
@@ -250,5 +250,6 @@
 	SF(OTG0_OTG_DRR_CONTROL, OTG_V_TOTAL_LAST_USED_BY_DRR, mask_sh)
 
 void dcn32_timing_generator_init(struct optc *optc1);
+void optc32_set_h_timing_div_manual_mode(struct timing_generator *optc, bool manual_mode);
 
 #endif /* __DC_OPTC_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index eb5b7eb292ef..b53468aca4a9 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -471,7 +471,7 @@ struct dmub_notification {
  * of a firmware to know if feature or functionality is supported or present.
  */
 #define DMUB_FW_VERSION(major, minor, revision) \
-	((((major) & 0xFF) << 24) | (((minor) & 0xFF) << 16) | ((revision) & 0xFFFF))
+	((((major) & 0xFF) << 24) | (((minor) & 0xFF) << 16) | (((revision) & 0xFF) << 8))
 
 /**
  * dmub_srv_create() - creates the DMUB service.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 44bbf17e4bef..3bc4128a22ac 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -168,6 +168,7 @@ struct smu_temperature_range {
 	int mem_crit_max;
 	int mem_emergency_max;
 	int software_shutdown_temp;
+	int software_shutdown_temp_offset;
 };
 
 struct smu_state_validation_block {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index bffa6247c3cd..d6479a808855 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -297,5 +297,9 @@ int smu_v13_0_get_pptable_from_firmware(struct smu_context *smu,
 					uint32_t *size,
 					uint32_t pptable_id);
 
+int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
+				     uint32_t pcie_gen_cap,
+				     uint32_t pcie_width_cap);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 5143b4df2cc1..2456f2a72def 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1381,6 +1381,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
 	 */
 	uint32_t ctxid = entry->src_data[0];
 	uint32_t data;
+	uint32_t high;
 
 	if (client_id == SOC15_IH_CLIENTID_THM) {
 		switch (src_id) {
@@ -1437,6 +1438,36 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
 					schedule_work(&smu->throttling_logging_work);
 
 				break;
+			case 0x8:
+				high = smu->thermal_range.software_shutdown_temp +
+					smu->thermal_range.software_shutdown_temp_offset;
+				high = min_t(typeof(high),
+					     SMU_THERMAL_MAXIMUM_ALERT_TEMP,
+					     high);
+				dev_emerg(adev->dev, "Reduce soft CTF limit to %d (by an offset %d)\n",
+							high,
+							smu->thermal_range.software_shutdown_temp_offset);
+
+				data = RREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL);
+				data = REG_SET_FIELD(data, THM_THERMAL_INT_CTRL,
+							DIG_THERM_INTH,
+							(high & 0xff));
+				data = data & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
+				WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, data);
+				break;
+			case 0x9:
+				high = min_t(typeof(high),
+					     SMU_THERMAL_MAXIMUM_ALERT_TEMP,
+					     smu->thermal_range.software_shutdown_temp);
+				dev_emerg(adev->dev, "Recover soft CTF limit to %d\n", high);
+
+				data = RREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL);
+				data = REG_SET_FIELD(data, THM_THERMAL_INT_CTRL,
+							DIG_THERM_INTH,
+							(high & 0xff));
+				data = data & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
+				WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, data);
+				break;
 			}
 		}
 	}
@@ -2458,3 +2489,70 @@ int smu_v13_0_mode1_reset(struct smu_context *smu)
 
 	return ret;
 }
+
+/*
+ * Intel hosts such as Raptor Lake and Sapphire Rapids don't support dynamic
+ * speed switching. Until we have confirmation from Intel that a specific host
+ * supports it, it's safer that we keep it disabled for all.
+ *
+ * https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/005/pci-express-support/
+ * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
+ */
+static bool smu_v13_0_is_pcie_dynamic_switching_supported(void)
+{
+#if IS_ENABLED(CONFIG_X86)
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	if (c->x86_vendor == X86_VENDOR_INTEL)
+		return false;
+#endif
+	return true;
+}
+
+int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
+				     uint32_t pcie_gen_cap,
+				     uint32_t pcie_width_cap)
+{
+	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
+	struct smu_13_0_pcie_table *pcie_table =
+				&dpm_context->dpm_tables.pcie_table;
+	int num_of_levels = pcie_table->num_of_link_levels;
+	uint32_t smu_pcie_arg;
+	int ret, i;
+
+	if (!smu_v13_0_is_pcie_dynamic_switching_supported()) {
+		if (pcie_table->pcie_gen[num_of_levels - 1] < pcie_gen_cap)
+			pcie_gen_cap = pcie_table->pcie_gen[num_of_levels - 1];
+
+		if (pcie_table->pcie_lane[num_of_levels - 1] < pcie_width_cap)
+			pcie_width_cap = pcie_table->pcie_lane[num_of_levels - 1];
+
+		/* Force all levels to use the same settings */
+		for (i = 0; i < num_of_levels; i++) {
+			pcie_table->pcie_gen[i] = pcie_gen_cap;
+			pcie_table->pcie_lane[i] = pcie_width_cap;
+		}
+	} else {
+		for (i = 0; i < num_of_levels; i++) {
+			if (pcie_table->pcie_gen[i] > pcie_gen_cap)
+				pcie_table->pcie_gen[i] = pcie_gen_cap;
+			if (pcie_table->pcie_lane[i] > pcie_width_cap)
+				pcie_table->pcie_lane[i] = pcie_width_cap;
+		}
+	}
+
+	for (i = 0; i < num_of_levels; i++) {
+		smu_pcie_arg = i << 16;
+		smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
+		smu_pcie_arg |= pcie_table->pcie_lane[i];
+
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_OverridePcieParameters,
+						      smu_pcie_arg,
+						      NULL);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 54fc42dad775..f7ac488a3da2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1216,37 +1216,6 @@ static int smu_v13_0_0_force_clk_levels(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_v13_0_0_update_pcie_parameters(struct smu_context *smu,
-					      uint32_t pcie_gen_cap,
-					      uint32_t pcie_width_cap)
-{
-	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-	struct smu_13_0_pcie_table *pcie_table =
-				&dpm_context->dpm_tables.pcie_table;
-	uint32_t smu_pcie_arg;
-	int ret, i;
-
-	for (i = 0; i < pcie_table->num_of_link_levels; i++) {
-		if (pcie_table->pcie_gen[i] > pcie_gen_cap)
-			pcie_table->pcie_gen[i] = pcie_gen_cap;
-		if (pcie_table->pcie_lane[i] > pcie_width_cap)
-			pcie_table->pcie_lane[i] = pcie_width_cap;
-
-		smu_pcie_arg = i << 16;
-		smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
-		smu_pcie_arg |= pcie_table->pcie_lane[i];
-
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_OverridePcieParameters,
-						      smu_pcie_arg,
-						      NULL);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 static const struct smu_temperature_range smu13_thermal_policy[] = {
 	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
 	{ 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000},
@@ -1281,6 +1250,7 @@ static int smu_v13_0_0_get_thermal_temperature_range(struct smu_context *smu,
 	range->mem_emergency_max = (pptable->SkuTable.TemperatureLimit[TEMP_MEM] + CTF_OFFSET_MEM)*
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	range->software_shutdown_temp = powerplay_table->software_shutdown_temp;
+	range->software_shutdown_temp_offset = pptable->SkuTable.FanAbnormalTempLimitOffset;
 
 	return 0;
 }
@@ -2032,7 +2002,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.print_clk_levels = smu_v13_0_0_print_clk_levels,
 	.force_clk_levels = smu_v13_0_0_force_clk_levels,
-	.update_pcie_parameters = smu_v13_0_0_update_pcie_parameters,
+	.update_pcie_parameters = smu_v13_0_update_pcie_parameters,
 	.get_thermal_temperature_range = smu_v13_0_0_get_thermal_temperature_range,
 	.register_irq_handler = smu_v13_0_register_irq_handler,
 	.enable_thermal_alert = smu_v13_0_enable_thermal_alert,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index bd61518bb7b1..d980eff2b616 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1225,37 +1225,6 @@ static int smu_v13_0_7_force_clk_levels(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_v13_0_7_update_pcie_parameters(struct smu_context *smu,
-					      uint32_t pcie_gen_cap,
-					      uint32_t pcie_width_cap)
-{
-	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-	struct smu_13_0_pcie_table *pcie_table =
-				&dpm_context->dpm_tables.pcie_table;
-	uint32_t smu_pcie_arg;
-	int ret, i;
-
-	for (i = 0; i < pcie_table->num_of_link_levels; i++) {
-		if (pcie_table->pcie_gen[i] > pcie_gen_cap)
-			pcie_table->pcie_gen[i] = pcie_gen_cap;
-		if (pcie_table->pcie_lane[i] > pcie_width_cap)
-			pcie_table->pcie_lane[i] = pcie_width_cap;
-
-		smu_pcie_arg = i << 16;
-		smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
-		smu_pcie_arg |= pcie_table->pcie_lane[i];
-
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_OverridePcieParameters,
-						      smu_pcie_arg,
-						      NULL);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 static const struct smu_temperature_range smu13_thermal_policy[] =
 {
 	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
@@ -1288,6 +1257,7 @@ static int smu_v13_0_7_get_thermal_temperature_range(struct smu_context *smu,
 	range->mem_emergency_max = (pptable->SkuTable.TemperatureLimit[TEMP_MEM] + CTF_OFFSET_MEM)*
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	range->software_shutdown_temp = powerplay_table->software_shutdown_temp;
+	range->software_shutdown_temp_offset = pptable->SkuTable.FanAbnormalTempLimitOffset;
 
 	return 0;
 }
@@ -1749,7 +1719,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.print_clk_levels = smu_v13_0_7_print_clk_levels,
 	.force_clk_levels = smu_v13_0_7_force_clk_levels,
-	.update_pcie_parameters = smu_v13_0_7_update_pcie_parameters,
+	.update_pcie_parameters = smu_v13_0_update_pcie_parameters,
 	.get_thermal_temperature_range = smu_v13_0_7_get_thermal_temperature_range,
 	.register_irq_handler = smu_v13_0_register_irq_handler,
 	.enable_thermal_alert = smu_v13_0_enable_thermal_alert,
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index d16775c973c4..b89f7f7ca188 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -170,10 +170,10 @@
  * @pwm_refclk_freq: Cache for the reference clock input to the PWM.
  */
 struct ti_sn65dsi86 {
-	struct auxiliary_device		bridge_aux;
-	struct auxiliary_device		gpio_aux;
-	struct auxiliary_device		aux_aux;
-	struct auxiliary_device		pwm_aux;
+	struct auxiliary_device		*bridge_aux;
+	struct auxiliary_device		*gpio_aux;
+	struct auxiliary_device		*aux_aux;
+	struct auxiliary_device		*pwm_aux;
 
 	struct device			*dev;
 	struct regmap			*regmap;
@@ -468,27 +468,34 @@ static void ti_sn65dsi86_delete_aux(void *data)
 	auxiliary_device_delete(data);
 }
 
-/*
- * AUX bus docs say that a non-NULL release is mandatory, but it makes no
- * sense for the model used here where all of the aux devices are allocated
- * in the single shared structure. We'll use this noop as a workaround.
- */
-static void ti_sn65dsi86_noop(struct device *dev) {}
+static void ti_sn65dsi86_aux_device_release(struct device *dev)
+{
+	struct auxiliary_device *aux = container_of(dev, struct auxiliary_device, dev);
+
+	kfree(aux);
+}
 
 static int ti_sn65dsi86_add_aux_device(struct ti_sn65dsi86 *pdata,
-				       struct auxiliary_device *aux,
+				       struct auxiliary_device **aux_out,
 				       const char *name)
 {
 	struct device *dev = pdata->dev;
+	struct auxiliary_device *aux;
 	int ret;
 
+	aux = kzalloc(sizeof(*aux), GFP_KERNEL);
+	if (!aux)
+		return -ENOMEM;
+
 	aux->name = name;
 	aux->dev.parent = dev;
-	aux->dev.release = ti_sn65dsi86_noop;
+	aux->dev.release = ti_sn65dsi86_aux_device_release;
 	device_set_of_node_from_dev(&aux->dev, dev);
 	ret = auxiliary_device_init(aux);
-	if (ret)
+	if (ret) {
+		kfree(aux);
 		return ret;
+	}
 	ret = devm_add_action_or_reset(dev, ti_sn65dsi86_uninit_aux, aux);
 	if (ret)
 		return ret;
@@ -497,6 +504,8 @@ static int ti_sn65dsi86_add_aux_device(struct ti_sn65dsi86 *pdata,
 	if (ret)
 		return ret;
 	ret = devm_add_action_or_reset(dev, ti_sn65dsi86_delete_aux, aux);
+	if (!ret)
+		*aux_out = aux;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index c0dc5858a723..7115898258af 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -140,6 +140,12 @@ drm_atomic_state_init(struct drm_device *dev, struct drm_atomic_state *state)
 	if (!state->planes)
 		goto fail;
 
+	/*
+	 * Because drm_atomic_state can be committed asynchronously we need our
+	 * own reference and cannot rely on the on implied by drm_file in the
+	 * ioctl call.
+	 */
+	drm_dev_get(dev);
 	state->dev = dev;
 
 	drm_dbg_atomic(dev, "Allocated atomic state %p\n", state);
@@ -299,7 +305,8 @@ EXPORT_SYMBOL(drm_atomic_state_clear);
 void __drm_atomic_state_free(struct kref *ref)
 {
 	struct drm_atomic_state *state = container_of(ref, typeof(*state), ref);
-	struct drm_mode_config *config = &state->dev->mode_config;
+	struct drm_device *dev = state->dev;
+	struct drm_mode_config *config = &dev->mode_config;
 
 	drm_atomic_state_clear(state);
 
@@ -311,6 +318,8 @@ void __drm_atomic_state_free(struct kref *ref)
 		drm_atomic_state_default_release(state);
 		kfree(state);
 	}
+
+	drm_dev_put(dev);
 }
 EXPORT_SYMBOL(__drm_atomic_state_free);
 
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 02b4a7dc92f5..202a9990f451 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1225,7 +1225,16 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
 			continue;
 
 		ret = drm_crtc_vblank_get(crtc);
-		WARN_ONCE(ret != -EINVAL, "driver forgot to call drm_crtc_vblank_off()\n");
+		/*
+		 * Self-refresh is not a true "disable"; ensure vblank remains
+		 * enabled.
+		 */
+		if (new_crtc_state->self_refresh_active)
+			WARN_ONCE(ret != 0,
+				  "driver disabled vblank in self-refresh\n");
+		else
+			WARN_ONCE(ret != -EINVAL,
+				  "driver forgot to call drm_crtc_vblank_off()\n");
 		if (ret == 0)
 			drm_crtc_vblank_put(crtc);
 	}
diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
index 2b230b4d6942..dcbeeb68ca64 100644
--- a/drivers/gpu/drm/drm_client.c
+++ b/drivers/gpu/drm/drm_client.c
@@ -122,13 +122,34 @@ EXPORT_SYMBOL(drm_client_init);
  * drm_client_register() it is no longer permissible to call drm_client_release()
  * directly (outside the unregister callback), instead cleanup will happen
  * automatically on driver unload.
+ *
+ * Registering a client generates a hotplug event that allows the client
+ * to set up its display from pre-existing outputs. The client must have
+ * initialized its state to able to handle the hotplug event successfully.
  */
 void drm_client_register(struct drm_client_dev *client)
 {
 	struct drm_device *dev = client->dev;
+	int ret;
 
 	mutex_lock(&dev->clientlist_mutex);
 	list_add(&client->list, &dev->clientlist);
+
+	if (client->funcs && client->funcs->hotplug) {
+		/*
+		 * Perform an initial hotplug event to pick up the
+		 * display configuration for the client. This step
+		 * has to be performed *after* registering the client
+		 * in the list of clients, or a concurrent hotplug
+		 * event might be lost; leaving the display off.
+		 *
+		 * Hold the clientlist_mutex as for a regular hotplug
+		 * event.
+		 */
+		ret = client->funcs->hotplug(client);
+		if (ret)
+			drm_dbg_kms(dev, "client hotplug ret=%d\n", ret);
+	}
 	mutex_unlock(&dev->clientlist_mutex);
 }
 EXPORT_SYMBOL(drm_client_register);
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 76e46713b2f0..442746d9777a 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -2634,10 +2634,6 @@ void drm_fbdev_generic_setup(struct drm_device *dev,
 		preferred_bpp = 32;
 	fb_helper->preferred_bpp = preferred_bpp;
 
-	ret = drm_fbdev_client_hotplug(&fb_helper->client);
-	if (ret)
-		drm_dbg_kms(dev, "client hotplug ret=%d\n", ret);
-
 	drm_client_register(&fb_helper->client);
 }
 EXPORT_SYMBOL(drm_fbdev_generic_setup);
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 455d9ae6c41c..da9b995b54c8 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -5133,7 +5133,6 @@ copy_bigjoiner_crtc_state_modeset(struct intel_atomic_state *state,
 	saved_state->uapi = slave_crtc_state->uapi;
 	saved_state->scaler_state = slave_crtc_state->scaler_state;
 	saved_state->shared_dpll = slave_crtc_state->shared_dpll;
-	saved_state->dpll_hw_state = slave_crtc_state->dpll_hw_state;
 	saved_state->crc_enabled = slave_crtc_state->crc_enabled;
 
 	intel_crtc_free_hw_state(slave_crtc_state);
diff --git a/drivers/gpu/drm/i915/gt/intel_gtt.c b/drivers/gpu/drm/i915/gt/intel_gtt.c
index 2eaeba14319e..f4879f437bfa 100644
--- a/drivers/gpu/drm/i915/gt/intel_gtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gtt.c
@@ -611,7 +611,7 @@ __vm_create_scratch_for_read(struct i915_address_space *vm, unsigned long size)
 	if (IS_ERR(obj))
 		return ERR_CAST(obj);
 
-	i915_gem_object_set_cache_coherency(obj, I915_CACHING_CACHED);
+	i915_gem_object_set_cache_coherency(obj, I915_CACHE_LLC);
 
 	vma = i915_vma_instance(obj, vm, NULL);
 	if (IS_ERR(vma)) {
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 7ca00b032336..f851aaf2c591 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2117,6 +2117,7 @@ static const struct panel_desc innolux_at043tn24 = {
 		.height = 54,
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
 };
 
@@ -3109,6 +3110,7 @@ static const struct drm_display_mode powertip_ph800480t013_idf02_mode = {
 	.vsync_start = 480 + 49,
 	.vsync_end = 480 + 49 + 2,
 	.vtotal = 480 + 49 + 2 + 22,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
 };
 
 static const struct panel_desc powertip_ph800480t013_idf02  = {
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index fa1f4ee6d195..9fea03121247 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -717,13 +717,13 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
 	if (crtc->state->self_refresh_active)
 		rockchip_drm_set_win_enabled(crtc, false);
 
+	if (crtc->state->self_refresh_active)
+		goto out;
+
 	mutex_lock(&vop->vop_lock);
 
 	drm_crtc_vblank_off(crtc);
 
-	if (crtc->state->self_refresh_active)
-		goto out;
-
 	/*
 	 * Vop standby will take effect at end of current frame,
 	 * if dsp hold valid irq happen, it means standby complete.
@@ -757,9 +757,9 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
 	vop_core_clks_disable(vop);
 	pm_runtime_put(vop->dev);
 
-out:
 	mutex_unlock(&vop->vop_lock);
 
+out:
 	if (crtc->state->event && !crtc->state->active) {
 		spin_lock_irq(&crtc->dev->event_lock);
 		drm_crtc_send_vblank_event(crtc, crtc->state->event);
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 7c8e8be774f1..f2c4e9037d6e 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1165,6 +1165,7 @@ int ttm_bo_swapout(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx,
 		ret = ttm_bo_handle_move_mem(bo, evict_mem, true, &ctx, &hop);
 		if (unlikely(ret != 0)) {
 			WARN(ret == -EMULTIHOP, "Unexpected multihop in swaput - likely driver bug.\n");
+			ttm_resource_free(bo, &evict_mem);
 			goto out;
 		}
 	}
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
index 6f0d332ccf51..06bdcf072d10 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
@@ -132,29 +132,45 @@ static void get_common_inputs(struct common_input_property *common, int report_i
 	common->event_type = HID_USAGE_SENSOR_EVENT_DATA_UPDATED_ENUM;
 }
 
-static int float_to_int(u32 float32)
+static int float_to_int(u32 flt32_val)
 {
 	int fraction, shift, mantissa, sign, exp, zeropre;
 
-	mantissa = float32 & GENMASK(22, 0);
-	sign = (float32 & BIT(31)) ? -1 : 1;
-	exp = (float32 & ~BIT(31)) >> 23;
+	mantissa = flt32_val & GENMASK(22, 0);
+	sign = (flt32_val & BIT(31)) ? -1 : 1;
+	exp = (flt32_val & ~BIT(31)) >> 23;
 
 	if (!exp && !mantissa)
 		return 0;
 
+	/*
+	 * Calculate the exponent and fraction part of floating
+	 * point representation.
+	 */
 	exp -= 127;
 	if (exp < 0) {
 		exp = -exp;
+		if (exp >= BITS_PER_TYPE(u32))
+			return 0;
 		zeropre = (((BIT(23) + mantissa) * 100) >> 23) >> exp;
 		return zeropre >= 50 ? sign : 0;
 	}
 
 	shift = 23 - exp;
-	float32 = BIT(exp) + (mantissa >> shift);
-	fraction = mantissa & GENMASK(shift - 1, 0);
+	if (abs(shift) >= BITS_PER_TYPE(u32))
+		return 0;
+
+	if (shift < 0) {
+		shift = -shift;
+		flt32_val = BIT(exp) + (mantissa << shift);
+		shift = 0;
+	} else {
+		flt32_val = BIT(exp) + (mantissa >> shift);
+	}
+
+	fraction = (shift == 0) ? 0 : mantissa & GENMASK(shift - 1, 0);
 
-	return (((fraction * 100) >> shift) >= 50) ? sign * (float32 + 1) : sign * float32;
+	return (((fraction * 100) >> shift) >= 50) ? sign * (flt32_val + 1) : sign * flt32_val;
 }
 
 static u8 get_input_rep(u8 current_index, int sensor_idx, int report_id,
diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 1a68b099d323..eb965974ed85 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -71,7 +71,7 @@
 	#define MESON_SAR_ADC_REG3_PANEL_DETECT_COUNT_MASK	GENMASK(20, 18)
 	#define MESON_SAR_ADC_REG3_PANEL_DETECT_FILTER_TB_MASK	GENMASK(17, 16)
 	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_SHIFT		10
-	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_WIDTH		5
+	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_WIDTH		6
 	#define MESON_SAR_ADC_REG3_BLOCK_DLY_SEL_MASK		GENMASK(9, 8)
 	#define MESON_SAR_ADC_REG3_BLOCK_DLY_MASK		GENMASK(7, 0)
 
diff --git a/drivers/md/dm-init.c b/drivers/md/dm-init.c
index b0c45c6ebe0b..dc4381d68313 100644
--- a/drivers/md/dm-init.c
+++ b/drivers/md/dm-init.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/ctype.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/device-mapper.h>
 #include <linux/init.h>
@@ -18,12 +19,17 @@
 #define DM_MAX_DEVICES 256
 #define DM_MAX_TARGETS 256
 #define DM_MAX_STR_SIZE 4096
+#define DM_MAX_WAITFOR 256
 
 static char *create;
 
+static char *waitfor[DM_MAX_WAITFOR];
+
 /*
  * Format: dm-mod.create=<name>,<uuid>,<minor>,<flags>,<table>[,<table>+][;<name>,<uuid>,<minor>,<flags>,<table>[,<table>+]+]
  * Table format: <start_sector> <num_sectors> <target_type> <target_args>
+ * Block devices to wait for to become available before setting up tables:
+ * dm-mod.waitfor=<device1>[,..,<deviceN>]
  *
  * See Documentation/admin-guide/device-mapper/dm-init.rst for dm-mod.create="..." format
  * details.
@@ -266,7 +272,7 @@ static int __init dm_init_init(void)
 	struct dm_device *dev;
 	LIST_HEAD(devices);
 	char *str;
-	int r;
+	int i, r;
 
 	if (!create)
 		return 0;
@@ -286,6 +292,17 @@ static int __init dm_init_init(void)
 	DMINFO("waiting for all devices to be available before creating mapped devices");
 	wait_for_device_probe();
 
+	for (i = 0; i < ARRAY_SIZE(waitfor); i++) {
+		if (waitfor[i]) {
+			DMINFO("waiting for device %s ...", waitfor[i]);
+			while (!dm_get_dev_t(waitfor[i]))
+				msleep(5);
+		}
+	}
+
+	if (waitfor[0])
+		DMINFO("all devices available");
+
 	list_for_each_entry(dev, &devices, list) {
 		if (dm_early_create(&dev->dmi, dev->table,
 				    dev->target_args_array))
@@ -301,3 +318,6 @@ late_initcall(dm_init_init);
 
 module_param(create, charp, 0);
 MODULE_PARM_DESC(create, "Create a mapped device in early boot");
+
+module_param_array(waitfor, charp, NULL, 0);
+MODULE_PARM_DESC(waitfor, "Devices to wait for before setting up tables");
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index a2b8f8781a99..fe7dad3ffa75 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -33,11 +33,11 @@
 #define DEFAULT_BUFFER_SECTORS		128
 #define DEFAULT_JOURNAL_WATERMARK	50
 #define DEFAULT_SYNC_MSEC		10000
-#define DEFAULT_MAX_JOURNAL_SECTORS	131072
+#define DEFAULT_MAX_JOURNAL_SECTORS	(IS_ENABLED(CONFIG_64BIT) ? 131072 : 8192)
 #define MIN_LOG2_INTERLEAVE_SECTORS	3
 #define MAX_LOG2_INTERLEAVE_SECTORS	31
 #define METADATA_WORKQUEUE_MAX_ACTIVE	16
-#define RECALC_SECTORS			32768
+#define RECALC_SECTORS			(IS_ENABLED(CONFIG_64BIT) ? 32768 : 2048)
 #define RECALC_WRITE_SUPER		16
 #define BITMAP_BLOCK_SIZE		4096	/* don't change it */
 #define BITMAP_FLUSH_INTERVAL		(10 * HZ)
diff --git a/drivers/md/dm-verity-loadpin.c b/drivers/md/dm-verity-loadpin.c
index 4f78cc55c251..0666699b6858 100644
--- a/drivers/md/dm-verity-loadpin.c
+++ b/drivers/md/dm-verity-loadpin.c
@@ -58,6 +58,9 @@ bool dm_verity_loadpin_is_bdev_trusted(struct block_device *bdev)
 	int srcu_idx;
 	bool trusted = false;
 
+	if (bdev == NULL)
+		return false;
+
 	if (list_empty(&dm_verity_loadpin_trusted_root_digests))
 		return false;
 
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index b536befd8898..0f7c3b3c62b2 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -270,6 +270,18 @@ static int create_strip_zones(struct mddev *mddev, struct r0conf **private_conf)
 		goto abort;
 	}
 
+	if (conf->layout == RAID0_ORIG_LAYOUT) {
+		for (i = 1; i < conf->nr_strip_zones; i++) {
+			sector_t first_sector = conf->strip_zone[i-1].zone_end;
+
+			sector_div(first_sector, mddev->chunk_sectors);
+			zone = conf->strip_zone + i;
+			/* disk_shift is first disk index used in the zone */
+			zone->disk_shift = sector_div(first_sector,
+						      zone->nb_dev);
+		}
+	}
+
 	pr_debug("md/raid0:%s: done.\n", mdname(mddev));
 	*private_conf = conf;
 
@@ -431,6 +443,20 @@ static int raid0_run(struct mddev *mddev)
 	return ret;
 }
 
+/*
+ * Convert disk_index to the disk order in which it is read/written.
+ *  For example, if we have 4 disks, they are numbered 0,1,2,3. If we
+ *  write the disks starting at disk 3, then the read/write order would
+ *  be disk 3, then 0, then 1, and then disk 2 and we want map_disk_shift()
+ *  to map the disks as follows 0,1,2,3 => 1,2,3,0. So disk 0 would map
+ *  to 1, 1 to 2, 2 to 3, and 3 to 0. That way we can compare disks in
+ *  that 'output' space to understand the read/write disk ordering.
+ */
+static int map_disk_shift(int disk_index, int num_disks, int disk_shift)
+{
+	return ((disk_index + num_disks - disk_shift) % num_disks);
+}
+
 static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 {
 	struct r0conf *conf = mddev->private;
@@ -444,7 +470,9 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	sector_t end_disk_offset;
 	unsigned int end_disk_index;
 	unsigned int disk;
+	sector_t orig_start, orig_end;
 
+	orig_start = start;
 	zone = find_zone(conf, &start);
 
 	if (bio_end_sector(bio) > zone->zone_end) {
@@ -458,6 +486,7 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	} else
 		end = bio_end_sector(bio);
 
+	orig_end = end;
 	if (zone != conf->strip_zone)
 		end = end - zone[-1].zone_end;
 
@@ -469,13 +498,26 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	last_stripe_index = end;
 	sector_div(last_stripe_index, stripe_size);
 
-	start_disk_index = (int)(start - first_stripe_index * stripe_size) /
-		mddev->chunk_sectors;
+	/* In the first zone the original and alternate layouts are the same */
+	if ((conf->layout == RAID0_ORIG_LAYOUT) && (zone != conf->strip_zone)) {
+		sector_div(orig_start, mddev->chunk_sectors);
+		start_disk_index = sector_div(orig_start, zone->nb_dev);
+		start_disk_index = map_disk_shift(start_disk_index,
+						  zone->nb_dev,
+						  zone->disk_shift);
+		sector_div(orig_end, mddev->chunk_sectors);
+		end_disk_index = sector_div(orig_end, zone->nb_dev);
+		end_disk_index = map_disk_shift(end_disk_index,
+						zone->nb_dev, zone->disk_shift);
+	} else {
+		start_disk_index = (int)(start - first_stripe_index * stripe_size) /
+			mddev->chunk_sectors;
+		end_disk_index = (int)(end - last_stripe_index * stripe_size) /
+			mddev->chunk_sectors;
+	}
 	start_disk_offset = ((int)(start - first_stripe_index * stripe_size) %
 		mddev->chunk_sectors) +
 		first_stripe_index * mddev->chunk_sectors;
-	end_disk_index = (int)(end - last_stripe_index * stripe_size) /
-		mddev->chunk_sectors;
 	end_disk_offset = ((int)(end - last_stripe_index * stripe_size) %
 		mddev->chunk_sectors) +
 		last_stripe_index * mddev->chunk_sectors;
@@ -483,18 +525,22 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	for (disk = 0; disk < zone->nb_dev; disk++) {
 		sector_t dev_start, dev_end;
 		struct md_rdev *rdev;
+		int compare_disk;
+
+		compare_disk = map_disk_shift(disk, zone->nb_dev,
+					      zone->disk_shift);
 
-		if (disk < start_disk_index)
+		if (compare_disk < start_disk_index)
 			dev_start = (first_stripe_index + 1) *
 				mddev->chunk_sectors;
-		else if (disk > start_disk_index)
+		else if (compare_disk > start_disk_index)
 			dev_start = first_stripe_index * mddev->chunk_sectors;
 		else
 			dev_start = start_disk_offset;
 
-		if (disk < end_disk_index)
+		if (compare_disk < end_disk_index)
 			dev_end = (last_stripe_index + 1) * mddev->chunk_sectors;
-		else if (disk > end_disk_index)
+		else if (compare_disk > end_disk_index)
 			dev_end = last_stripe_index * mddev->chunk_sectors;
 		else
 			dev_end = end_disk_offset;
diff --git a/drivers/md/raid0.h b/drivers/md/raid0.h
index 3816e5477db1..8cc761ca7423 100644
--- a/drivers/md/raid0.h
+++ b/drivers/md/raid0.h
@@ -6,6 +6,7 @@ struct strip_zone {
 	sector_t zone_end;	/* Start of the next zone (in sectors) */
 	sector_t dev_start;	/* Zone offset in real dev (in sectors) */
 	int	 nb_dev;	/* # of devices attached to the zone */
+	int	 disk_shift;	/* start disk for the original layout */
 };
 
 /* Linux 3.14 (20d0189b101) made an unintended change to
diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index 9f3c4a01b4c1..4af1d368c321 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -233,6 +233,7 @@ static const struct of_device_id pm8008_match[] = {
 	{ .compatible = "qcom,pm8008", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, pm8008_match);
 
 static struct i2c_driver pm8008_mfd_driver = {
 	.driver = {
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index e5cabb901213..13518cac076c 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1260,7 +1260,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 
 	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE, 4, 0);
 	if (init.attrs)
-		sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_ATTR, 6, 0);
+		sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_ATTR, 4, 0);
 
 	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
 				      sc, args);
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 11530b4ec389..d1e2f22537db 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -728,6 +728,10 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	struct pci_dev *pdev = test->pdev;
 
 	mutex_lock(&test->mutex);
+
+	reinit_completion(&test->irq_raised);
+	test->last_irq = -ENODATA;
+
 	switch (cmd) {
 	case PCITEST_BAR:
 		bar = arg;
@@ -937,6 +941,9 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 	if (id < 0)
 		return;
 
+	pci_endpoint_test_release_irq(test);
+	pci_endpoint_test_free_irq_vectors(test);
+
 	misc_deregister(&test->miscdev);
 	kfree(misc_device->name);
 	kfree(test->name);
@@ -946,9 +953,6 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 			pci_iounmap(pdev, test->bar[bar]);
 	}
 
-	pci_endpoint_test_release_irq(test);
-	pci_endpoint_test_free_irq_vectors(test);
-
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 }
diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 074e14225c06..029a2a302aa6 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -76,6 +76,7 @@
 #define GENCMDIADDRH(aih, addr)		((aih) | (((addr) >> 16) & 0xffff))
 
 #define DMA_DIR(dir)		((dir) ? NFC_CMD_N2M : NFC_CMD_M2N)
+#define DMA_ADDR_ALIGN		8
 
 #define ECC_CHECK_RETURN_FF	(-1)
 
@@ -842,6 +843,9 @@ static int meson_nfc_read_oob(struct nand_chip *nand, int page)
 
 static bool meson_nfc_is_buffer_dma_safe(const void *buffer)
 {
+	if ((uintptr_t)buffer % DMA_ADDR_ALIGN)
+		return false;
+
 	if (virt_addr_valid(buffer) && (!object_is_on_stack(buffer)))
 		return true;
 	return false;
diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 7a6166a0c9bc..b3f798866899 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -469,6 +469,9 @@ qca8k_phy_eth_busy_wait(struct qca8k_mgmt_eth_data *mgmt_eth_data,
 	bool ack;
 	int ret;
 
+	if (!skb)
+		return -ENOMEM;
+
 	reinit_completion(&mgmt_eth_data->rw_done);
 
 	/* Increment seq_num and set it in the copy pkt */
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 451c3a1b6255..633b321d7fdd 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -35,6 +35,8 @@
 
 #define ENA_REGS_ADMIN_INTR_MASK 1
 
+#define ENA_MAX_BACKOFF_DELAY_EXP 16U
+
 #define ENA_MIN_ADMIN_POLL_US 100
 
 #define ENA_MAX_ADMIN_POLL_US 5000
@@ -536,6 +538,7 @@ static int ena_com_comp_status_to_errno(struct ena_com_admin_queue *admin_queue,
 
 static void ena_delay_exponential_backoff_us(u32 exp, u32 delay_us)
 {
+	exp = min_t(u32, exp, ENA_MAX_BACKOFF_DELAY_EXP);
 	delay_us = max_t(u32, ENA_MIN_ADMIN_POLL_US, delay_us);
 	delay_us = min_t(u32, delay_us * (1U << exp), ENA_MAX_ADMIN_POLL_US);
 	usleep_range(delay_us, 2 * delay_us);
diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 1761df8fb7f9..10c7c232cc4e 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1492,8 +1492,6 @@ int bgmac_enet_probe(struct bgmac *bgmac)
 
 	bgmac->in_init = true;
 
-	bgmac_chip_intrs_off(bgmac);
-
 	net_dev->irq = bgmac->irq;
 	SET_NETDEV_DEV(net_dev, bgmac->dev);
 	dev_set_drvdata(bgmac->dev, bgmac);
@@ -1511,6 +1509,8 @@ int bgmac_enet_probe(struct bgmac *bgmac)
 	 */
 	bgmac_clk_enable(bgmac, 0);
 
+	bgmac_chip_intrs_off(bgmac);
+
 	/* This seems to be fixing IRQ by assigning OOB #6 to the core */
 	if (!(bgmac->feature_flags & BGMAC_FEAT_IDM_MASK)) {
 		if (bgmac->feature_flags & BGMAC_FEAT_IRQ_ID_OOB_6)
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index bf9e246784b6..1fe8038587ac 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -664,5 +664,7 @@ void bcmgenet_mii_exit(struct net_device *dev)
 	if (of_phy_is_fixed_link(dn))
 		of_phy_deregister_fixed_link(dn);
 	of_node_put(priv->phy_dn);
+	clk_prepare_enable(priv->clk);
 	platform_device_unregister(priv->mii_pdev);
+	clk_disable_unprepare(priv->clk);
 }
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 38df602f2869..033f17cb96be 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -541,6 +541,9 @@ static int gve_get_link_ksettings(struct net_device *netdev,
 		err = gve_adminq_report_link_speed(priv);
 
 	cmd->base.speed = priv->link_speed;
+
+	cmd->base.duplex = DUPLEX_FULL;
+
 	return err;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 7a5ec3ce3407..8f77088900e9 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7852,10 +7852,10 @@ static int
 ice_validate_mqprio_qopt(struct ice_vsi *vsi,
 			 struct tc_mqprio_qopt_offload *mqprio_qopt)
 {
-	u64 sum_max_rate = 0, sum_min_rate = 0;
 	int non_power_of_2_qcount = 0;
 	struct ice_pf *pf = vsi->back;
 	int max_rss_q_cnt = 0;
+	u64 sum_min_rate = 0;
 	struct device *dev;
 	int i, speed;
 	u8 num_tc;
@@ -7871,6 +7871,7 @@ ice_validate_mqprio_qopt(struct ice_vsi *vsi,
 	dev = ice_pf_to_dev(pf);
 	vsi->ch_rss_size = 0;
 	num_tc = mqprio_qopt->qopt.num_tc;
+	speed = ice_get_link_speed_kbps(vsi);
 
 	for (i = 0; num_tc; i++) {
 		int qcount = mqprio_qopt->qopt.count[i];
@@ -7911,7 +7912,6 @@ ice_validate_mqprio_qopt(struct ice_vsi *vsi,
 		 */
 		max_rate = mqprio_qopt->max_rate[i];
 		max_rate = div_u64(max_rate, ICE_BW_KBPS_DIVISOR);
-		sum_max_rate += max_rate;
 
 		/* min_rate is minimum guaranteed rate and it can't be zero */
 		min_rate = mqprio_qopt->min_rate[i];
@@ -7924,6 +7924,12 @@ ice_validate_mqprio_qopt(struct ice_vsi *vsi,
 			return -EINVAL;
 		}
 
+		if (max_rate && max_rate > speed) {
+			dev_err(dev, "TC%d: max_rate(%llu Kbps) > link speed of %u Kbps\n",
+				i, max_rate, speed);
+			return -EINVAL;
+		}
+
 		iter_div_u64_rem(min_rate, ICE_MIN_BW_LIMIT, &rem);
 		if (rem) {
 			dev_err(dev, "TC%d: Min Rate not multiple of %u Kbps",
@@ -7961,12 +7967,6 @@ ice_validate_mqprio_qopt(struct ice_vsi *vsi,
 	    (mqprio_qopt->qopt.offset[i] + mqprio_qopt->qopt.count[i]))
 		return -EINVAL;
 
-	speed = ice_get_link_speed_kbps(vsi);
-	if (sum_max_rate && sum_max_rate > (u64)speed) {
-		dev_err(dev, "Invalid max Tx rate(%llu) Kbps > speed(%u) Kbps specified\n",
-			sum_max_rate, speed);
-		return -EINVAL;
-	}
 	if (sum_min_rate && sum_min_rate > (u64)speed) {
 		dev_err(dev, "Invalid min Tx rate(%llu) Kbps > speed (%u) Kbps specified\n",
 			sum_min_rate, speed);
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 8cc077b712ad..511fc3f41208 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1707,6 +1707,8 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 	/* twisted pair */
 	cmd->base.port = PORT_TP;
 	cmd->base.phy_address = hw->phy.addr;
+	ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
+	ethtool_link_ksettings_add_link_mode(cmd, advertising, TP);
 
 	/* advertising link modes */
 	if (hw->phy.autoneg_advertised & ADVERTISE_10_HALF)
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index b67a6a81474f..273941f90f06 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -709,7 +709,6 @@ static void igc_configure_tx_ring(struct igc_adapter *adapter,
 	/* disable the queue */
 	wr32(IGC_TXDCTL(reg_idx), 0);
 	wrfl();
-	mdelay(10);
 
 	wr32(IGC_TDLEN(reg_idx),
 	     ring->count * sizeof(union igc_adv_tx_desc));
@@ -1015,7 +1014,7 @@ static __le32 igc_tx_launchtime(struct igc_ring *ring, ktime_t txtime,
 	ktime_t base_time = adapter->base_time;
 	ktime_t now = ktime_get_clocktai();
 	ktime_t baset_est, end_of_cycle;
-	u32 launchtime;
+	s32 launchtime;
 	s64 n;
 
 	n = div64_s64(ktime_sub_ns(now, base_time), cycle_time);
@@ -1028,7 +1027,7 @@ static __le32 igc_tx_launchtime(struct igc_ring *ring, ktime_t txtime,
 			*first_flag = true;
 			ring->last_ff_cycle = baset_est;
 
-			if (ktime_compare(txtime, ring->last_tx_cycle) > 0)
+			if (ktime_compare(end_of_cycle, ring->last_tx_cycle) > 0)
 				*insert_empty = true;
 		}
 	}
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 4e10ced736db..d96cdccdc1e1 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -356,16 +356,35 @@ static int igc_ptp_feature_enable_i225(struct ptp_clock_info *ptp,
 			tsim &= ~IGC_TSICR_TT0;
 		}
 		if (on) {
+			struct timespec64 safe_start;
 			int i = rq->perout.index;
 
 			igc_pin_perout(igc, i, pin, use_freq);
-			igc->perout[i].start.tv_sec = rq->perout.start.sec;
+			igc_ptp_read(igc, &safe_start);
+
+			/* PPS output start time is triggered by Target time(TT)
+			 * register. Programming any past time value into TT
+			 * register will cause PPS to never start. Need to make
+			 * sure we program the TT register a time ahead in
+			 * future. There isn't a stringent need to fire PPS out
+			 * right away. Adding +2 seconds should take care of
+			 * corner cases. Let's say if the SYSTIML is close to
+			 * wrap up and the timer keeps ticking as we program the
+			 * register, adding +2seconds is safe bet.
+			 */
+			safe_start.tv_sec += 2;
+
+			if (rq->perout.start.sec < safe_start.tv_sec)
+				igc->perout[i].start.tv_sec = safe_start.tv_sec;
+			else
+				igc->perout[i].start.tv_sec = rq->perout.start.sec;
 			igc->perout[i].start.tv_nsec = rq->perout.start.nsec;
 			igc->perout[i].period.tv_sec = ts.tv_sec;
 			igc->perout[i].period.tv_nsec = ts.tv_nsec;
-			wr32(trgttimh, rq->perout.start.sec);
+			wr32(trgttimh, (u32)igc->perout[i].start.tv_sec);
 			/* For now, always select timer 0 as source. */
-			wr32(trgttiml, rq->perout.start.nsec | IGC_TT_IO_TIMER_SEL_SYSTIM0);
+			wr32(trgttiml, (u32)(igc->perout[i].start.tv_nsec |
+					     IGC_TT_IO_TIMER_SEL_SYSTIM0));
 			if (use_freq)
 				wr32(freqout, ns);
 			tsauxc |= tsauxc_mask;
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 5aefaaff0871..aca5b72cfeec 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1505,7 +1505,7 @@ static void mvneta_defaults_set(struct mvneta_port *pp)
 			 */
 			if (txq_number == 1)
 				txq_map = (cpu == pp->rxq_def) ?
-					MVNETA_CPU_TXQ_ACCESS(1) : 0;
+					MVNETA_CPU_TXQ_ACCESS(0) : 0;
 
 		} else {
 			txq_map = MVNETA_CPU_TXQ_ACCESS_ALL_MASK;
@@ -4294,7 +4294,7 @@ static void mvneta_percpu_elect(struct mvneta_port *pp)
 		 */
 		if (txq_number == 1)
 			txq_map = (cpu == elected_cpu) ?
-				MVNETA_CPU_TXQ_ACCESS(1) : 0;
+				MVNETA_CPU_TXQ_ACCESS(0) : 0;
 		else
 			txq_map = mvreg_read(pp, MVNETA_CPU_MAP(cpu)) &
 				MVNETA_CPU_TXQ_ACCESS_ALL_MASK;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
index 3411e2e47d46..0ee420a489fc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
@@ -208,7 +208,7 @@ struct ptp *ptp_get(void)
 	/* Check driver is bound to PTP block */
 	if (!ptp)
 		ptp = ERR_PTR(-EPROBE_DEFER);
-	else
+	else if (!IS_ERR(ptp))
 		pci_dev_get(ptp->pdev);
 
 	return ptp;
@@ -388,11 +388,10 @@ static int ptp_extts_on(struct ptp *ptp, int on)
 static int ptp_probe(struct pci_dev *pdev,
 		     const struct pci_device_id *ent)
 {
-	struct device *dev = &pdev->dev;
 	struct ptp *ptp;
 	int err;
 
-	ptp = devm_kzalloc(dev, sizeof(*ptp), GFP_KERNEL);
+	ptp = kzalloc(sizeof(*ptp), GFP_KERNEL);
 	if (!ptp) {
 		err = -ENOMEM;
 		goto error;
@@ -428,20 +427,19 @@ static int ptp_probe(struct pci_dev *pdev,
 	return 0;
 
 error_free:
-	devm_kfree(dev, ptp);
+	kfree(ptp);
 
 error:
 	/* For `ptp_get()` we need to differentiate between the case
 	 * when the core has not tried to probe this device and the case when
-	 * the probe failed.  In the later case we pretend that the
-	 * initialization was successful and keep the error in
+	 * the probe failed.  In the later case we keep the error in
 	 * `dev->driver_data`.
 	 */
 	pci_set_drvdata(pdev, ERR_PTR(err));
 	if (!first_ptp_block)
 		first_ptp_block = ERR_PTR(err);
 
-	return 0;
+	return err;
 }
 
 static void ptp_remove(struct pci_dev *pdev)
@@ -449,16 +447,17 @@ static void ptp_remove(struct pci_dev *pdev)
 	struct ptp *ptp = pci_get_drvdata(pdev);
 	u64 clock_cfg;
 
-	if (cn10k_ptp_errata(ptp) && hrtimer_active(&ptp->hrtimer))
-		hrtimer_cancel(&ptp->hrtimer);
-
 	if (IS_ERR_OR_NULL(ptp))
 		return;
 
+	if (cn10k_ptp_errata(ptp) && hrtimer_active(&ptp->hrtimer))
+		hrtimer_cancel(&ptp->hrtimer);
+
 	/* Disable PTP clock */
 	clock_cfg = readq(ptp->reg_base + PTP_CLOCK_CFG);
 	clock_cfg &= ~PTP_CLOCK_CFG_PTP_EN;
 	writeq(clock_cfg, ptp->reg_base + PTP_CLOCK_CFG);
+	kfree(ptp);
 }
 
 static const struct pci_device_id ptp_id_table[] = {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 873f081c030d..733add3a9dc6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -3244,7 +3244,7 @@ static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	rvu->ptp = ptp_get();
 	if (IS_ERR(rvu->ptp)) {
 		err = PTR_ERR(rvu->ptp);
-		if (err == -EPROBE_DEFER)
+		if (err)
 			goto err_release_regions;
 		rvu->ptp = NULL;
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 8cb2a0181fb9..705325431dec 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -3804,21 +3804,14 @@ int rvu_mbox_handler_nix_set_rx_mode(struct rvu *rvu, struct nix_rx_mode *req,
 	}
 
 	/* install/uninstall promisc entry */
-	if (promisc) {
+	if (promisc)
 		rvu_npc_install_promisc_entry(rvu, pcifunc, nixlf,
 					      pfvf->rx_chan_base,
 					      pfvf->rx_chan_cnt);
-
-		if (rvu_npc_exact_has_match_table(rvu))
-			rvu_npc_exact_promisc_enable(rvu, pcifunc);
-	} else {
+	else
 		if (!nix_rx_multicast)
 			rvu_npc_enable_promisc_entry(rvu, pcifunc, nixlf, false);
 
-		if (rvu_npc_exact_has_match_table(rvu))
-			rvu_npc_exact_promisc_disable(rvu, pcifunc);
-	}
-
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
index 3b48b635977f..3b0a66c0977a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
@@ -1168,8 +1168,10 @@ static u16 __rvu_npc_exact_cmd_rules_cnt_update(struct rvu *rvu, int drop_mcam_i
 {
 	struct npc_exact_table *table;
 	u16 *cnt, old_cnt;
+	bool promisc;
 
 	table = rvu->hw->table;
+	promisc = table->promisc_mode[drop_mcam_idx];
 
 	cnt = &table->cnt_cmd_rules[drop_mcam_idx];
 	old_cnt = *cnt;
@@ -1181,13 +1183,18 @@ static u16 __rvu_npc_exact_cmd_rules_cnt_update(struct rvu *rvu, int drop_mcam_i
 
 	*enable_or_disable_cam = false;
 
-	/* If all rules are deleted, disable cam */
+	if (promisc)
+		goto done;
+
+	/* If all rules are deleted and not already in promisc mode;
+	 * disable cam
+	 */
 	if (!*cnt && val < 0) {
 		*enable_or_disable_cam = true;
 		goto done;
 	}
 
-	/* If rule got added, enable cam */
+	/* If rule got added and not already in promisc mode; enable cam */
 	if (!old_cnt && val > 0) {
 		*enable_or_disable_cam = true;
 		goto done;
@@ -1466,6 +1473,12 @@ int rvu_npc_exact_promisc_disable(struct rvu *rvu, u16 pcifunc)
 	*promisc = false;
 	mutex_unlock(&table->lock);
 
+	/* Enable drop rule */
+	rvu_npc_enable_mcam_by_entry_index(rvu, drop_mcam_idx, NIX_INTF_RX,
+					   true);
+
+	dev_dbg(rvu->dev, "%s: disabled  promisc mode (cgx=%d lmac=%d)\n",
+		__func__, cgx_id, lmac_id);
 	return 0;
 }
 
@@ -1507,6 +1520,12 @@ int rvu_npc_exact_promisc_enable(struct rvu *rvu, u16 pcifunc)
 	*promisc = true;
 	mutex_unlock(&table->lock);
 
+	/*  disable drop rule */
+	rvu_npc_enable_mcam_by_entry_index(rvu, drop_mcam_idx, NIX_INTF_RX,
+					   false);
+
+	dev_dbg(rvu->dev, "%s: Enabled promisc mode (cgx=%d lmac=%d)\n",
+		__func__, cgx_id, lmac_id);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index d0554f6d2673..934c199667b5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -867,6 +867,14 @@ static int otx2_prepare_flow_request(struct ethtool_rx_flow_spec *fsp,
 				return -EINVAL;
 
 			vlan_etype = be16_to_cpu(fsp->h_ext.vlan_etype);
+
+			/* Drop rule with vlan_etype == 802.1Q
+			 * and vlan_id == 0 is not supported
+			 */
+			if (vlan_etype == ETH_P_8021Q && !fsp->m_ext.vlan_tci &&
+			    fsp->ring_cookie == RX_CLS_FLOW_DISC)
+				return -EINVAL;
+
 			/* Only ETH_P_8021Q and ETH_P_802AD types supported */
 			if (vlan_etype != ETH_P_8021Q &&
 			    vlan_etype != ETH_P_8021AD)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 6a01ab1a6e6f..1aeb18a901b1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -579,6 +579,21 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 			return -EOPNOTSUPP;
 		}
 
+		if (!match.mask->vlan_id) {
+			struct flow_action_entry *act;
+			int i;
+
+			flow_action_for_each(i, act, &rule->action) {
+				if (act->id == FLOW_ACTION_DROP) {
+					netdev_err(nic->netdev,
+						   "vlan tpid 0x%x with vlan_id %d is not supported for DROP rule.\n",
+						   ntohs(match.key->vlan_tpid),
+						   match.key->vlan_id);
+					return -EOPNOTSUPP;
+				}
+			}
+		}
+
 		if (match.mask->vlan_id ||
 		    match.mask->vlan_dei ||
 		    match.mask->vlan_priority) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
index 03cb79adf912..be83ad9db82a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
@@ -594,7 +594,7 @@ int mlx5e_fs_tt_redirect_any_create(struct mlx5e_flow_steering *fs)
 
 	err = fs_any_create_table(fs);
 	if (err)
-		return err;
+		goto err_free_any;
 
 	err = fs_any_enable(fs);
 	if (err)
@@ -606,8 +606,8 @@ int mlx5e_fs_tt_redirect_any_create(struct mlx5e_flow_steering *fs)
 
 err_destroy_table:
 	fs_any_destroy_table(fs_any);
-
-	kfree(fs_any);
+err_free_any:
 	mlx5e_fs_set_any(fs, NULL);
+	kfree(fs_any);
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index efd02ce4425d..72b4781f0eb2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -729,8 +729,10 @@ int mlx5e_ptp_open(struct mlx5e_priv *priv, struct mlx5e_params *params,
 
 	c = kvzalloc_node(sizeof(*c), GFP_KERNEL, dev_to_node(mlx5_core_dma_dev(mdev)));
 	cparams = kvzalloc(sizeof(*cparams), GFP_KERNEL);
-	if (!c || !cparams)
-		return -ENOMEM;
+	if (!c || !cparams) {
+		err = -ENOMEM;
+		goto err_free;
+	}
 
 	c->priv     = priv;
 	c->mdev     = priv->mdev;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
index d7c020f72401..06c47404996b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
@@ -190,6 +190,7 @@ static int accel_fs_tcp_create_groups(struct mlx5e_flow_table *ft,
 	in = kvzalloc(inlen, GFP_KERNEL);
 	if  (!in || !ft->g) {
 		kfree(ft->g);
+		ft->g = NULL;
 		kvfree(in);
 		return -ENOMEM;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 7883b625634f..7ab489520a87 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1551,7 +1551,8 @@ static void remove_unready_flow(struct mlx5e_tc_flow *flow)
 	uplink_priv = &rpriv->uplink_priv;
 
 	mutex_lock(&uplink_priv->unready_flows_lock);
-	unready_flow_del(flow);
+	if (flow_flag_test(flow, NOT_READY))
+		unready_flow_del(flow);
 	mutex_unlock(&uplink_priv->unready_flows_lock);
 }
 
@@ -1896,8 +1897,7 @@ static void mlx5e_tc_del_fdb_flow(struct mlx5e_priv *priv,
 	esw_attr = attr->esw_attr;
 	mlx5e_put_flow_tunnel_id(flow);
 
-	if (flow_flag_test(flow, NOT_READY))
-		remove_unready_flow(flow);
+	remove_unready_flow(flow);
 
 	if (mlx5e_is_offloaded_flow(flow)) {
 		if (flow_flag_test(flow, SLOW))
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 50eeecba1f18..e804613faa1f 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -144,6 +144,18 @@ static int lan743x_csr_light_reset(struct lan743x_adapter *adapter)
 				  !(data & HW_CFG_LRST_), 100000, 10000000);
 }
 
+static int lan743x_csr_wait_for_bit_atomic(struct lan743x_adapter *adapter,
+					   int offset, u32 bit_mask,
+					   int target_value, int udelay_min,
+					   int udelay_max, int count)
+{
+	u32 data;
+
+	return readx_poll_timeout_atomic(LAN743X_CSR_READ_OP, offset, data,
+					 target_value == !!(data & bit_mask),
+					 udelay_max, udelay_min * count);
+}
+
 static int lan743x_csr_wait_for_bit(struct lan743x_adapter *adapter,
 				    int offset, u32 bit_mask,
 				    int target_value, int usleep_min,
@@ -746,8 +758,8 @@ static int lan743x_dp_write(struct lan743x_adapter *adapter,
 	u32 dp_sel;
 	int i;
 
-	if (lan743x_csr_wait_for_bit(adapter, DP_SEL, DP_SEL_DPRDY_,
-				     1, 40, 100, 100))
+	if (lan743x_csr_wait_for_bit_atomic(adapter, DP_SEL, DP_SEL_DPRDY_,
+					    1, 40, 100, 100))
 		return -EIO;
 	dp_sel = lan743x_csr_read(adapter, DP_SEL);
 	dp_sel &= ~DP_SEL_MASK_;
@@ -758,8 +770,9 @@ static int lan743x_dp_write(struct lan743x_adapter *adapter,
 		lan743x_csr_write(adapter, DP_ADDR, addr + i);
 		lan743x_csr_write(adapter, DP_DATA_0, buf[i]);
 		lan743x_csr_write(adapter, DP_CMD, DP_CMD_WRITE_);
-		if (lan743x_csr_wait_for_bit(adapter, DP_SEL, DP_SEL_DPRDY_,
-					     1, 40, 100, 100))
+		if (lan743x_csr_wait_for_bit_atomic(adapter, DP_SEL,
+						    DP_SEL_DPRDY_,
+						    1, 40, 100, 100))
 			return -EIO;
 	}
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 159bfcc76498..a89ab455af67 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -462,11 +462,6 @@ static void ionic_qcqs_free(struct ionic_lif *lif)
 static void ionic_link_qcq_interrupts(struct ionic_qcq *src_qcq,
 				      struct ionic_qcq *n_qcq)
 {
-	if (WARN_ON(n_qcq->flags & IONIC_QCQ_F_INTR)) {
-		ionic_intr_free(n_qcq->cq.lif->ionic, n_qcq->intr.index);
-		n_qcq->flags &= ~IONIC_QCQ_F_INTR;
-	}
-
 	n_qcq->intr.vector = src_qcq->intr.vector;
 	n_qcq->intr.index = src_qcq->intr.index;
 	n_qcq->napi_qcq = src_qcq->napi_qcq;
diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index 68e56e451b2b..c3fbdd6b68ba 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -184,13 +184,10 @@ static ssize_t nsim_dev_trap_fa_cookie_write(struct file *file,
 	cookie_len = (count - 1) / 2;
 	if ((count - 1) % 2)
 		return -EINVAL;
-	buf = kmalloc(count, GFP_KERNEL | __GFP_NOWARN);
-	if (!buf)
-		return -ENOMEM;
 
-	ret = simple_write_to_buffer(buf, count, ppos, data, count);
-	if (ret < 0)
-		goto free_buf;
+	buf = memdup_user(data, count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
 
 	fa_cookie = kmalloc(sizeof(*fa_cookie) + cookie_len,
 			    GFP_KERNEL | __GFP_NOWARN);
diff --git a/drivers/net/phy/dp83td510.c b/drivers/net/phy/dp83td510.c
index 3cd9a77f9532..d7616b13c594 100644
--- a/drivers/net/phy/dp83td510.c
+++ b/drivers/net/phy/dp83td510.c
@@ -12,6 +12,11 @@
 
 /* MDIO_MMD_VEND2 registers */
 #define DP83TD510E_PHY_STS			0x10
+/* Bit 7 - mii_interrupt, active high. Clears on read.
+ * Note: Clearing does not necessarily deactivate IRQ pin if interrupts pending.
+ * This differs from the DP83TD510E datasheet (2020) which states this bit
+ * clears on write 0.
+ */
 #define DP83TD510E_STS_MII_INT			BIT(7)
 #define DP83TD510E_LINK_STATUS			BIT(0)
 
@@ -53,12 +58,6 @@ static int dp83td510_config_intr(struct phy_device *phydev)
 	int ret;
 
 	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
-		/* Clear any pending interrupts */
-		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PHY_STS,
-				    0x0);
-		if (ret)
-			return ret;
-
 		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
 				    DP83TD510E_INTERRUPT_REG_1,
 				    DP83TD510E_INT1_LINK_EN);
@@ -81,10 +80,6 @@ static int dp83td510_config_intr(struct phy_device *phydev)
 					 DP83TD510E_GENCFG_INT_EN);
 		if (ret)
 			return ret;
-
-		/* Clear any pending interrupts */
-		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PHY_STS,
-				    0x0);
 	}
 
 	return ret;
@@ -94,14 +89,6 @@ static irqreturn_t dp83td510_handle_interrupt(struct phy_device *phydev)
 {
 	int  ret;
 
-	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PHY_STS);
-	if (ret < 0) {
-		phy_error(phydev);
-		return IRQ_NONE;
-	} else if (!(ret & DP83TD510E_STS_MII_INT)) {
-		return IRQ_NONE;
-	}
-
 	/* Read the current enabled interrupts */
 	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_INTERRUPT_REG_1);
 	if (ret < 0) {
diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index fb2c35bd73bb..f6362429b735 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -6146,8 +6146,11 @@ static int airo_get_rate(struct net_device *dev,
 {
 	struct airo_info *local = dev->ml_priv;
 	StatusRid status_rid;		/* Card status info */
+	int ret;
 
-	readStatusRid(local, &status_rid, 1);
+	ret = readStatusRid(local, &status_rid, 1);
+	if (ret)
+		return -EBUSY;
 
 	vwrq->value = le16_to_cpu(status_rid.currentXmitRate) * 500000;
 	/* If more than one rate, set auto */
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 50701c55ed60..ec0af903961f 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -2130,17 +2130,18 @@ static ssize_t rtw89_debug_priv_send_h2c_set(struct file *filp,
 	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	u8 *h2c;
+	int ret;
 	u16 h2c_len = count / 2;
 
 	h2c = rtw89_hex2bin_user(rtwdev, user_buf, count);
 	if (IS_ERR(h2c))
 		return -EFAULT;
 
-	rtw89_fw_h2c_raw(rtwdev, h2c, h2c_len);
+	ret = rtw89_fw_h2c_raw(rtwdev, h2c, h2c_len);
 
 	kfree(h2c);
 
-	return count;
+	return ret ? ret : count;
 }
 
 static int
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 04550b1f984c..730f2103b91d 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1338,12 +1338,17 @@ static struct pci_driver amd_ntb_pci_driver = {
 
 static int __init amd_ntb_pci_driver_init(void)
 {
+	int ret;
 	pr_info("%s %s\n", NTB_DESC, NTB_VER);
 
 	if (debugfs_initialized())
 		debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
-	return pci_register_driver(&amd_ntb_pci_driver);
+	ret = pci_register_driver(&amd_ntb_pci_driver);
+	if (ret)
+		debugfs_remove_recursive(debugfs_dir);
+
+	return ret;
 }
 module_init(amd_ntb_pci_driver_init);
 
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 0ed6f809ff2e..51799fccf840 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2891,6 +2891,7 @@ static struct pci_driver idt_pci_driver = {
 
 static int __init idt_pci_driver_init(void)
 {
+	int ret;
 	pr_info("%s %s\n", NTB_DESC, NTB_VER);
 
 	/* Create the top DebugFS directory if the FS is initialized */
@@ -2898,7 +2899,11 @@ static int __init idt_pci_driver_init(void)
 		dbgfs_topdir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
 	/* Register the NTB hardware driver to handle the PCI device */
-	return pci_register_driver(&idt_pci_driver);
+	ret = pci_register_driver(&idt_pci_driver);
+	if (ret)
+		debugfs_remove_recursive(dbgfs_topdir);
+
+	return ret;
 }
 module_init(idt_pci_driver_init);
 
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index 84772013812b..60a4ebc7bf35 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -2064,12 +2064,17 @@ static struct pci_driver intel_ntb_pci_driver = {
 
 static int __init intel_ntb_pci_driver_init(void)
 {
+	int ret;
 	pr_info("%s %s\n", NTB_DESC, NTB_VER);
 
 	if (debugfs_initialized())
 		debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
-	return pci_register_driver(&intel_ntb_pci_driver);
+	ret = pci_register_driver(&intel_ntb_pci_driver);
+	if (ret)
+		debugfs_remove_recursive(debugfs_dir);
+
+	return ret;
 }
 module_init(intel_ntb_pci_driver_init);
 
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index a9b97ebc71ac..2abd2235bbca 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -410,7 +410,7 @@ int ntb_transport_register_client_dev(char *device_name)
 
 		rc = device_register(dev);
 		if (rc) {
-			kfree(client_dev);
+			put_device(dev);
 			goto err;
 		}
 
diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index 5ee0afa621a9..eeeb4b1c97d2 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -998,6 +998,8 @@ static int tool_init_mws(struct tool_ctx *tc)
 		tc->peers[pidx].outmws =
 			devm_kcalloc(&tc->ntb->dev, tc->peers[pidx].outmw_cnt,
 				   sizeof(*tc->peers[pidx].outmws), GFP_KERNEL);
+		if (tc->peers[pidx].outmws == NULL)
+			return -ENOMEM;
 
 		for (widx = 0; widx < tc->peers[pidx].outmw_cnt; widx++) {
 			tc->peers[pidx].outmws[widx].pidx = pidx;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 560ce2f05a96..fd73db8a535d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4175,10 +4175,40 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 
 	ret = nvme_global_check_duplicate_ids(ctrl->subsys, &info->ids);
 	if (ret) {
-		dev_err(ctrl->device,
-			"globally duplicate IDs for nsid %d\n", info->nsid);
+		/*
+		 * We've found two different namespaces on two different
+		 * subsystems that report the same ID.  This is pretty nasty
+		 * for anything that actually requires unique device
+		 * identification.  In the kernel we need this for multipathing,
+		 * and in user space the /dev/disk/by-id/ links rely on it.
+		 *
+		 * If the device also claims to be multi-path capable back off
+		 * here now and refuse the probe the second device as this is a
+		 * recipe for data corruption.  If not this is probably a
+		 * cheap consumer device if on the PCIe bus, so let the user
+		 * proceed and use the shiny toy, but warn that with changing
+		 * probing order (which due to our async probing could just be
+		 * device taking longer to startup) the other device could show
+		 * up at any time.
+		 */
 		nvme_print_device_info(ctrl);
-		return ret;
+		if ((ns->ctrl->ops->flags & NVME_F_FABRICS) || /* !PCIe */
+		    ((ns->ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) &&
+		     info->is_shared)) {
+			dev_err(ctrl->device,
+				"ignoring nsid %d because of duplicate IDs\n",
+				info->nsid);
+			return ret;
+		}
+
+		dev_err(ctrl->device,
+			"clearing duplicate IDs for nsid %d\n", info->nsid);
+		dev_err(ctrl->device,
+			"use of /dev/disk/by-id/ may cause data corruption\n");
+		memset(&info->ids.nguid, 0, sizeof(info->ids.nguid));
+		memset(&info->ids.uuid, 0, sizeof(info->ids.uuid));
+		memset(&info->ids.eui64, 0, sizeof(info->ids.eui64));
+		ctrl->quirks |= NVME_QUIRK_BOGUS_NID;
 	}
 
 	mutex_lock(&ctrl->subsys->lock);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 145fa7ef3f74..ce2e628f94a0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1022,7 +1022,7 @@ static __always_inline void nvme_pci_unmap_rq(struct request *req)
 	        struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
 		dma_unmap_page(dev->dev, iod->meta_dma,
-			       rq_integrity_vec(req)->bv_len, rq_data_dir(req));
+			       rq_integrity_vec(req)->bv_len, rq_dma_dir(req));
 	}
 
 	if (blk_rq_nr_phys_segments(req))
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e87567dbe99f..d707214069ca 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1348,7 +1348,10 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 	return opp_table;
 
 remove_opp_dev:
+	_of_clear_opp_table(opp_table);
 	_remove_opp_dev(opp_dev, opp_table);
+	mutex_destroy(&opp_table->genpd_virt_dev_lock);
+	mutex_destroy(&opp_table->lock);
 err:
 	kfree(opp_table);
 	return ERR_PTR(ret);
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 49905b2a9960..d24712a76ba7 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1176,6 +1176,8 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
 	writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
 		PCI_EXP_DEVCTL2);
 
+	dw_pcie_dbi_ro_wr_dis(pci);
+
 	return 0;
 }
 
diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index d1a200b93b2b..827d91e73efa 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -125,6 +125,7 @@ static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
 static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
 					 struct pci_epf_header *hdr)
 {
+	u32 reg;
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *rockchip = &ep->rockchip;
 
@@ -137,8 +138,9 @@ static int rockchip_pcie_ep_write_header(struct pci_epc *epc, u8 fn, u8 vfn,
 				    PCIE_CORE_CONFIG_VENDOR);
 	}
 
-	rockchip_pcie_write(rockchip, hdr->deviceid << 16,
-			    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) + PCI_VENDOR_ID);
+	reg = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_DID_VID);
+	reg = (reg & 0xFFFF) | (hdr->deviceid << 16);
+	rockchip_pcie_write(rockchip, reg, PCIE_EP_CONFIG_DID_VID);
 
 	rockchip_pcie_write(rockchip,
 			    hdr->revid |
@@ -312,15 +314,15 @@ static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn,
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *rockchip = &ep->rockchip;
-	u16 flags;
+	u32 flags;
 
 	flags = rockchip_pcie_read(rockchip,
 				   ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
 				   ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
 	flags &= ~ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_MASK;
 	flags |=
-	   ((multi_msg_cap << 1) <<  ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET) |
-	   PCI_MSI_FLAGS_64BIT;
+	   (multi_msg_cap << ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET) |
+	   (PCI_MSI_FLAGS_64BIT << ROCKCHIP_PCIE_EP_MSI_FLAGS_OFFSET);
 	flags &= ~ROCKCHIP_PCIE_EP_MSI_CTRL_MASK_MSI_CAP;
 	rockchip_pcie_write(rockchip, flags,
 			    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
@@ -332,7 +334,7 @@ static int rockchip_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *rockchip = &ep->rockchip;
-	u16 flags;
+	u32 flags;
 
 	flags = rockchip_pcie_read(rockchip,
 				   ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
@@ -345,48 +347,25 @@ static int rockchip_pcie_ep_get_msi(struct pci_epc *epc, u8 fn, u8 vfn)
 }
 
 static void rockchip_pcie_ep_assert_intx(struct rockchip_pcie_ep *ep, u8 fn,
-					 u8 intx, bool is_asserted)
+					 u8 intx, bool do_assert)
 {
 	struct rockchip_pcie *rockchip = &ep->rockchip;
-	u32 r = ep->max_regions - 1;
-	u32 offset;
-	u32 status;
-	u8 msg_code;
-
-	if (unlikely(ep->irq_pci_addr != ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR ||
-		     ep->irq_pci_fn != fn)) {
-		rockchip_pcie_prog_ep_ob_atu(rockchip, fn, r,
-					     AXI_WRAPPER_NOR_MSG,
-					     ep->irq_phys_addr, 0, 0);
-		ep->irq_pci_addr = ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR;
-		ep->irq_pci_fn = fn;
-	}
 
 	intx &= 3;
-	if (is_asserted) {
+
+	if (do_assert) {
 		ep->irq_pending |= BIT(intx);
-		msg_code = ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTA + intx;
+		rockchip_pcie_write(rockchip,
+				    PCIE_CLIENT_INT_IN_ASSERT |
+				    PCIE_CLIENT_INT_PEND_ST_PEND,
+				    PCIE_CLIENT_LEGACY_INT_CTRL);
 	} else {
 		ep->irq_pending &= ~BIT(intx);
-		msg_code = ROCKCHIP_PCIE_MSG_CODE_DEASSERT_INTA + intx;
+		rockchip_pcie_write(rockchip,
+				    PCIE_CLIENT_INT_IN_DEASSERT |
+				    PCIE_CLIENT_INT_PEND_ST_NORMAL,
+				    PCIE_CLIENT_LEGACY_INT_CTRL);
 	}
-
-	status = rockchip_pcie_read(rockchip,
-				    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
-				    ROCKCHIP_PCIE_EP_CMD_STATUS);
-	status &= ROCKCHIP_PCIE_EP_CMD_STATUS_IS;
-
-	if ((status != 0) ^ (ep->irq_pending != 0)) {
-		status ^= ROCKCHIP_PCIE_EP_CMD_STATUS_IS;
-		rockchip_pcie_write(rockchip, status,
-				    ROCKCHIP_PCIE_EP_FUNC_BASE(fn) +
-				    ROCKCHIP_PCIE_EP_CMD_STATUS);
-	}
-
-	offset =
-	   ROCKCHIP_PCIE_MSG_ROUTING(ROCKCHIP_PCIE_MSG_ROUTING_LOCAL_INTX) |
-	   ROCKCHIP_PCIE_MSG_CODE(msg_code) | ROCKCHIP_PCIE_MSG_NO_DATA;
-	writel(0, ep->irq_cpu_addr + offset);
 }
 
 static int rockchip_pcie_ep_send_legacy_irq(struct rockchip_pcie_ep *ep, u8 fn,
@@ -416,7 +395,7 @@ static int rockchip_pcie_ep_send_msi_irq(struct rockchip_pcie_ep *ep, u8 fn,
 					 u8 interrupt_num)
 {
 	struct rockchip_pcie *rockchip = &ep->rockchip;
-	u16 flags, mme, data, data_mask;
+	u32 flags, mme, data, data_mask;
 	u8 msi_count;
 	u64 pci_addr, pci_addr_mask = 0xff;
 
@@ -506,6 +485,7 @@ static const struct pci_epc_features rockchip_pcie_epc_features = {
 	.linkup_notifier = false,
 	.msi_capable = true,
 	.msix_capable = false,
+	.align = 256,
 };
 
 static const struct pci_epc_features*
@@ -631,6 +611,9 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 
 	ep->irq_pci_addr = ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR;
 
+	rockchip_pcie_write(rockchip, PCIE_CLIENT_CONF_ENABLE,
+			    PCIE_CLIENT_CONFIG);
+
 	return 0;
 err_epc_mem_exit:
 	pci_epc_mem_exit(epc);
diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 990a00e08bc5..1aa84035a8bc 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/iopoll.h>
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -153,6 +154,12 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 }
 EXPORT_SYMBOL_GPL(rockchip_pcie_parse_dt);
 
+#define rockchip_pcie_read_addr(addr) rockchip_pcie_read(rockchip, addr)
+/* 100 ms max wait time for PHY PLLs to lock */
+#define RK_PHY_PLL_LOCK_TIMEOUT_US 100000
+/* Sleep should be less than 20ms */
+#define RK_PHY_PLL_LOCK_SLEEP_US 1000
+
 int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 {
 	struct device *dev = rockchip->dev;
@@ -254,6 +261,16 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		}
 	}
 
+	err = readx_poll_timeout(rockchip_pcie_read_addr,
+				 PCIE_CLIENT_SIDE_BAND_STATUS,
+				 regs, !(regs & PCIE_CLIENT_PHY_ST),
+				 RK_PHY_PLL_LOCK_SLEEP_US,
+				 RK_PHY_PLL_LOCK_TIMEOUT_US);
+	if (err) {
+		dev_err(dev, "PHY PLLs could not lock, %d\n", err);
+		goto err_power_off_phy;
+	}
+
 	/*
 	 * Please don't reorder the deassert sequence of the following
 	 * four reset pins.
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 32c3a859c26b..8e92dc3339ec 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -38,6 +38,13 @@
 #define   PCIE_CLIENT_MODE_EP            HIWORD_UPDATE(0x0040, 0)
 #define   PCIE_CLIENT_GEN_SEL_1		  HIWORD_UPDATE(0x0080, 0)
 #define   PCIE_CLIENT_GEN_SEL_2		  HIWORD_UPDATE_BIT(0x0080)
+#define PCIE_CLIENT_LEGACY_INT_CTRL	(PCIE_CLIENT_BASE + 0x0c)
+#define   PCIE_CLIENT_INT_IN_ASSERT		HIWORD_UPDATE_BIT(0x0002)
+#define   PCIE_CLIENT_INT_IN_DEASSERT		HIWORD_UPDATE(0x0002, 0)
+#define   PCIE_CLIENT_INT_PEND_ST_PEND		HIWORD_UPDATE_BIT(0x0001)
+#define   PCIE_CLIENT_INT_PEND_ST_NORMAL	HIWORD_UPDATE(0x0001, 0)
+#define PCIE_CLIENT_SIDE_BAND_STATUS	(PCIE_CLIENT_BASE + 0x20)
+#define   PCIE_CLIENT_PHY_ST			BIT(12)
 #define PCIE_CLIENT_DEBUG_OUT_0		(PCIE_CLIENT_BASE + 0x3c)
 #define   PCIE_CLIENT_DEBUG_LTSSM_MASK		GENMASK(5, 0)
 #define   PCIE_CLIENT_DEBUG_LTSSM_L1		0x18
@@ -133,6 +140,8 @@
 #define PCIE_RC_RP_ATS_BASE		0x400000
 #define PCIE_RC_CONFIG_NORMAL_BASE	0x800000
 #define PCIE_RC_CONFIG_BASE		0xa00000
+#define PCIE_EP_CONFIG_BASE		0xa00000
+#define PCIE_EP_CONFIG_DID_VID		(PCIE_EP_CONFIG_BASE + 0x00)
 #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
 #define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_BASE + 0xc4)
 #define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
@@ -216,6 +225,7 @@
 #define ROCKCHIP_PCIE_EP_CMD_STATUS			0x4
 #define   ROCKCHIP_PCIE_EP_CMD_STATUS_IS		BIT(19)
 #define ROCKCHIP_PCIE_EP_MSI_CTRL_REG			0x90
+#define   ROCKCHIP_PCIE_EP_MSI_FLAGS_OFFSET		16
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET		17
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_MASK		GENMASK(19, 17)
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MME_OFFSET		20
@@ -223,7 +233,6 @@
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_ME				BIT(16)
 #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MASK_MSI_CAP	BIT(24)
 #define ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR				0x1
-#define ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR		0x3
 #define ROCKCHIP_PCIE_EP_FUNC_BASE(fn)	(((fn) << 12) & GENMASK(19, 12))
 #define ROCKCHIP_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
 	(PCIE_RC_RP_ATS_BASE + 0x0840 + (fn) * 0x0040 + (bar) * 0x0008)
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index f0c4d0f77453..2e8a4de2abab 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -54,6 +54,9 @@ struct pci_epf_test {
 	struct delayed_work	cmd_handler;
 	struct dma_chan		*dma_chan_tx;
 	struct dma_chan		*dma_chan_rx;
+	struct dma_chan		*transfer_chan;
+	dma_cookie_t		transfer_cookie;
+	enum dma_status		transfer_status;
 	struct completion	transfer_complete;
 	bool			dma_supported;
 	bool			dma_private;
@@ -85,8 +88,14 @@ static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
 static void pci_epf_test_dma_callback(void *param)
 {
 	struct pci_epf_test *epf_test = param;
-
-	complete(&epf_test->transfer_complete);
+	struct dma_tx_state state;
+
+	epf_test->transfer_status =
+		dmaengine_tx_status(epf_test->transfer_chan,
+				    epf_test->transfer_cookie, &state);
+	if (epf_test->transfer_status == DMA_COMPLETE ||
+	    epf_test->transfer_status == DMA_ERROR)
+		complete(&epf_test->transfer_complete);
 }
 
 /**
@@ -120,7 +129,6 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 	struct dma_async_tx_descriptor *tx;
 	struct dma_slave_config sconf = {};
 	struct device *dev = &epf->dev;
-	dma_cookie_t cookie;
 	int ret;
 
 	if (IS_ERR_OR_NULL(chan)) {
@@ -151,26 +159,34 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 		return -EIO;
 	}
 
+	reinit_completion(&epf_test->transfer_complete);
+	epf_test->transfer_chan = chan;
 	tx->callback = pci_epf_test_dma_callback;
 	tx->callback_param = epf_test;
-	cookie = tx->tx_submit(tx);
-	reinit_completion(&epf_test->transfer_complete);
+	epf_test->transfer_cookie = tx->tx_submit(tx);
 
-	ret = dma_submit_error(cookie);
+	ret = dma_submit_error(epf_test->transfer_cookie);
 	if (ret) {
-		dev_err(dev, "Failed to do DMA tx_submit %d\n", cookie);
-		return -EIO;
+		dev_err(dev, "Failed to do DMA tx_submit %d\n", ret);
+		goto terminate;
 	}
 
 	dma_async_issue_pending(chan);
 	ret = wait_for_completion_interruptible(&epf_test->transfer_complete);
 	if (ret < 0) {
-		dmaengine_terminate_sync(chan);
-		dev_err(dev, "DMA wait_for_completion_timeout\n");
-		return -ETIMEDOUT;
+		dev_err(dev, "DMA wait_for_completion interrupted\n");
+		goto terminate;
 	}
 
-	return 0;
+	if (epf_test->transfer_status == DMA_ERROR) {
+		dev_err(dev, "DMA transfer failed\n");
+		ret = -EIO;
+	}
+
+terminate:
+	dmaengine_terminate_sync(chan);
+
+	return ret;
 }
 
 struct epf_dma_filter {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 98d841a7b45b..88c437249982 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2942,13 +2942,13 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
 	{
 		/*
 		 * Downstream device is not accessible after putting a root port
-		 * into D3cold and back into D0 on Elo i2.
+		 * into D3cold and back into D0 on Elo Continental Z2 board
 		 */
-		.ident = "Elo i2",
+		.ident = "Elo Continental Z2",
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Elo Touch Solutions"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Elo i2"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "RevB"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "Elo Touch Solutions"),
+			DMI_MATCH(DMI_BOARD_NAME, "Geminilake"),
+			DMI_MATCH(DMI_BOARD_VERSION, "Continental Z2"),
 		},
 	},
 #endif
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 90e676439170..7170516298b0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -994,8 +994,10 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	resource_list_for_each_entry_safe(window, n, &resources) {
 		offset = window->offset;
 		res = window->res;
-		if (!res->flags && !res->start && !res->end)
+		if (!res->flags && !res->start && !res->end) {
+			release_resource(res);
 			continue;
+		}
 
 		list_move_tail(&window->node, &bridge->windows);
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ccc90656130a..472fa2c8ebce 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4174,6 +4174,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9220,
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c49 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9230,
 			 quirk_dma_func1_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9235,
+			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
 			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0645,
diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index ebca5eab9c9b..56897d4d4fd3 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -181,9 +181,6 @@ void riscv_pmu_start(struct perf_event *event, int flags)
 	uint64_t max_period = riscv_pmu_ctr_get_width_mask(event);
 	u64 init_val;
 
-	if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
-		return;
-
 	if (flags & PERF_EF_RELOAD)
 		WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
 
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 32c3edaf9038..a8df77e80549 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -115,16 +115,20 @@ static void amd_gpio_set_value(struct gpio_chip *gc, unsigned offset, int value)
 	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 }
 
-static int amd_gpio_set_debounce(struct gpio_chip *gc, unsigned offset,
-		unsigned debounce)
+static int amd_gpio_set_debounce(struct amd_gpio *gpio_dev, unsigned int offset,
+				 unsigned int debounce)
 {
 	u32 time;
 	u32 pin_reg;
 	int ret = 0;
-	unsigned long flags;
-	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
 
-	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
+	/* Use special handling for Pin0 debounce */
+	if (offset == 0) {
+		pin_reg = readl(gpio_dev->base + WAKE_INT_MASTER_REG);
+		if (pin_reg & INTERNAL_GPIO0_DEBOUNCE)
+			debounce = 0;
+	}
+
 	pin_reg = readl(gpio_dev->base + offset * 4);
 
 	if (debounce) {
@@ -175,23 +179,10 @@ static int amd_gpio_set_debounce(struct gpio_chip *gc, unsigned offset,
 		pin_reg &= ~(DB_CNTRl_MASK << DB_CNTRL_OFF);
 	}
 	writel(pin_reg, gpio_dev->base + offset * 4);
-	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 
 	return ret;
 }
 
-static int amd_gpio_set_config(struct gpio_chip *gc, unsigned offset,
-			       unsigned long config)
-{
-	u32 debounce;
-
-	if (pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
-		return -ENOTSUPP;
-
-	debounce = pinconf_to_config_argument(config);
-	return amd_gpio_set_debounce(gc, offset, debounce);
-}
-
 #ifdef CONFIG_DEBUG_FS
 static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 {
@@ -206,19 +197,19 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 
 	char *level_trig;
 	char *active_level;
-	char *interrupt_enable;
 	char *interrupt_mask;
 	char *wake_cntrl0;
 	char *wake_cntrl1;
 	char *wake_cntrl2;
 	char *pin_sts;
-	char *pull_up_sel;
-	char *pull_up_enable;
-	char *pull_down_enable;
+	char *interrupt_sts;
+	char *wake_sts;
 	char *orientation;
 	char debounce_value[40];
 	char *debounce_enable;
+	char *wake_cntrlz;
 
+	seq_printf(s, "WAKE_INT_MASTER_REG: 0x%08x\n", readl(gpio_dev->base + WAKE_INT_MASTER_REG));
 	for (bank = 0; bank < gpio_dev->hwbank_num; bank++) {
 		unsigned int time = 0;
 		unsigned int unit = 0;
@@ -245,6 +236,7 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 			continue;
 		}
 		seq_printf(s, "GPIO bank%d\n", bank);
+		seq_puts(s, "gpio\t  int|active|trigger|S0i3| S3|S4/S5| Z|wake|pull|  orient|       debounce|reg\n");
 		for (; i < pin_num; i++) {
 			seq_printf(s, "#%d\t", i);
 			raw_spin_lock_irqsave(&gpio_dev->lock, flags);
@@ -254,7 +246,6 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 			if (pin_reg & BIT(INTERRUPT_ENABLE_OFF)) {
 				u8 level = (pin_reg >> ACTIVE_LEVEL_OFF) &
 						ACTIVE_LEVEL_MASK;
-				interrupt_enable = "+";
 
 				if (level == ACTIVE_LEVEL_HIGH)
 					active_level = "↑";
@@ -271,59 +262,61 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 				else
 					level_trig = " edge";
 
-			} else {
-				interrupt_enable = "∅";
-				active_level = "∅";
-				level_trig = "    ∅";
-			}
+				if (pin_reg & BIT(INTERRUPT_MASK_OFF))
+					interrupt_mask = "😛";
+				else
+					interrupt_mask = "😷";
 
-			if (pin_reg & BIT(INTERRUPT_MASK_OFF))
-				interrupt_mask = "😛";
-			else
-				interrupt_mask = "😷";
-			seq_printf(s, "int %s (%s)| active-%s| %s-⚡| ",
-				   interrupt_enable,
+				if (pin_reg & BIT(INTERRUPT_STS_OFF))
+					interrupt_sts = "🔥";
+				else
+					interrupt_sts = "  ";
+
+				seq_printf(s, "%s %s|     %s|  %s|",
+				   interrupt_sts,
 				   interrupt_mask,
 				   active_level,
 				   level_trig);
+			} else
+				seq_puts(s, "    ∅|      |       |");
 
 			if (pin_reg & BIT(WAKE_CNTRL_OFF_S0I3))
 				wake_cntrl0 = "⏰";
 			else
-				wake_cntrl0 = " ∅";
-			seq_printf(s, "S0i3 %s| ", wake_cntrl0);
+				wake_cntrl0 = "  ";
+			seq_printf(s, "  %s| ", wake_cntrl0);
 
 			if (pin_reg & BIT(WAKE_CNTRL_OFF_S3))
 				wake_cntrl1 = "⏰";
 			else
-				wake_cntrl1 = " ∅";
-			seq_printf(s, "S3 %s| ", wake_cntrl1);
+				wake_cntrl1 = "  ";
+			seq_printf(s, "%s|", wake_cntrl1);
 
 			if (pin_reg & BIT(WAKE_CNTRL_OFF_S4))
 				wake_cntrl2 = "⏰";
 			else
-				wake_cntrl2 = " ∅";
-			seq_printf(s, "S4/S5 %s| ", wake_cntrl2);
+				wake_cntrl2 = "  ";
+			seq_printf(s, "   %s|", wake_cntrl2);
 
-			if (pin_reg & BIT(PULL_UP_ENABLE_OFF)) {
-				pull_up_enable = "+";
-				if (pin_reg & BIT(PULL_UP_SEL_OFF))
-					pull_up_sel = "8k";
-				else
-					pull_up_sel = "4k";
-			} else {
-				pull_up_enable = "∅";
-				pull_up_sel = "  ";
-			}
-			seq_printf(s, "pull-↑ %s (%s)| ",
-				   pull_up_enable,
-				   pull_up_sel);
+			if (pin_reg & BIT(WAKECNTRL_Z_OFF))
+				wake_cntrlz = "⏰";
+			else
+				wake_cntrlz = "  ";
+			seq_printf(s, "%s|", wake_cntrlz);
 
-			if (pin_reg & BIT(PULL_DOWN_ENABLE_OFF))
-				pull_down_enable = "+";
+			if (pin_reg & BIT(WAKE_STS_OFF))
+				wake_sts = "🔥";
 			else
-				pull_down_enable = "∅";
-			seq_printf(s, "pull-↓ %s| ", pull_down_enable);
+				wake_sts = " ";
+			seq_printf(s, "   %s|", wake_sts);
+
+			if (pin_reg & BIT(PULL_UP_ENABLE_OFF)) {
+				seq_puts(s, "  ↑ |");
+			} else if (pin_reg & BIT(PULL_DOWN_ENABLE_OFF)) {
+				seq_puts(s, "  ↓ |");
+			} else  {
+				seq_puts(s, "    |");
+			}
 
 			if (pin_reg & BIT(OUTPUT_ENABLE_OFF)) {
 				pin_sts = "output";
@@ -338,7 +331,7 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 				else
 					orientation = "↓";
 			}
-			seq_printf(s, "%s %s| ", pin_sts, orientation);
+			seq_printf(s, "%s %s|", pin_sts, orientation);
 
 			db_cntrl = (DB_CNTRl_MASK << DB_CNTRL_OFF) & pin_reg;
 			if (db_cntrl) {
@@ -357,19 +350,17 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 						unit = 61;
 				}
 				if ((DB_TYPE_REMOVE_GLITCH << DB_CNTRL_OFF) == db_cntrl)
-					debounce_enable = "b +";
+					debounce_enable = "b";
 				else if ((DB_TYPE_PRESERVE_LOW_GLITCH << DB_CNTRL_OFF) == db_cntrl)
-					debounce_enable = "↓ +";
+					debounce_enable = "↓";
 				else
-					debounce_enable = "↑ +";
-
+					debounce_enable = "↑";
+				snprintf(debounce_value, sizeof(debounce_value), "%06u", time * unit);
+				seq_printf(s, "%s (🕑 %sus)|", debounce_enable, debounce_value);
 			} else {
-				debounce_enable = "  ∅";
-				time = 0;
+				seq_puts(s, "               |");
 			}
-			snprintf(debounce_value, sizeof(debounce_value), "%u", time * unit);
-			seq_printf(s, "debounce %s (🕑 %sus)| ", debounce_enable, debounce_value);
-			seq_printf(s, " 0x%x\n", pin_reg);
+			seq_printf(s, "0x%x\n", pin_reg);
 		}
 	}
 }
@@ -648,21 +639,21 @@ static bool do_amd_gpio_irq_handler(int irq, void *dev_id)
 			 * We must read the pin register again, in case the
 			 * value was changed while executing
 			 * generic_handle_domain_irq() above.
-			 * If we didn't find a mapping for the interrupt,
-			 * disable it in order to avoid a system hang caused
-			 * by an interrupt storm.
+			 * If the line is not an irq, disable it in order to
+			 * avoid a system hang caused by an interrupt storm.
 			 */
 			raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 			regval = readl(regs + i);
-			if (irq == 0) {
-				regval &= ~BIT(INTERRUPT_ENABLE_OFF);
+			if (!gpiochip_line_is_irq(gc, irqnr + i)) {
+				regval &= ~BIT(INTERRUPT_MASK_OFF);
 				dev_dbg(&gpio_dev->pdev->dev,
 					"Disabling spurious GPIO IRQ %d\n",
 					irqnr + i);
+			} else {
+				ret = true;
 			}
 			writel(regval, regs + i);
 			raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
-			ret = true;
 		}
 	}
 	/* did not cause wake on resume context for shared IRQ */
@@ -749,7 +740,7 @@ static int amd_pinconf_get(struct pinctrl_dev *pctldev,
 		break;
 
 	case PIN_CONFIG_BIAS_PULL_UP:
-		arg = (pin_reg >> PULL_UP_SEL_OFF) & (BIT(0) | BIT(1));
+		arg = (pin_reg >> PULL_UP_ENABLE_OFF) & BIT(0);
 		break;
 
 	case PIN_CONFIG_DRIVE_STRENGTH:
@@ -768,7 +759,7 @@ static int amd_pinconf_get(struct pinctrl_dev *pctldev,
 }
 
 static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
-				unsigned long *configs, unsigned num_configs)
+			   unsigned long *configs, unsigned int num_configs)
 {
 	int i;
 	u32 arg;
@@ -786,9 +777,8 @@ static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 
 		switch (param) {
 		case PIN_CONFIG_INPUT_DEBOUNCE:
-			pin_reg &= ~DB_TMR_OUT_MASK;
-			pin_reg |= arg & DB_TMR_OUT_MASK;
-			break;
+			ret = amd_gpio_set_debounce(gpio_dev, pin, arg);
+			goto out_unlock;
 
 		case PIN_CONFIG_BIAS_PULL_DOWN:
 			pin_reg &= ~BIT(PULL_DOWN_ENABLE_OFF);
@@ -796,10 +786,8 @@ static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			break;
 
 		case PIN_CONFIG_BIAS_PULL_UP:
-			pin_reg &= ~BIT(PULL_UP_SEL_OFF);
-			pin_reg |= (arg & BIT(0)) << PULL_UP_SEL_OFF;
 			pin_reg &= ~BIT(PULL_UP_ENABLE_OFF);
-			pin_reg |= ((arg>>1) & BIT(0)) << PULL_UP_ENABLE_OFF;
+			pin_reg |= (arg & BIT(0)) << PULL_UP_ENABLE_OFF;
 			break;
 
 		case PIN_CONFIG_DRIVE_STRENGTH:
@@ -817,6 +805,7 @@ static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 
 		writel(pin_reg, gpio_dev->base + pin*4);
 	}
+out_unlock:
 	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 
 	return ret;
@@ -858,6 +847,14 @@ static int amd_pinconf_group_set(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+static int amd_gpio_set_config(struct gpio_chip *gc, unsigned int pin,
+			       unsigned long config)
+{
+	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
+
+	return amd_pinconf_set(gpio_dev->pctrl, pin, &config, 1);
+}
+
 static const struct pinconf_ops amd_pinconf_ops = {
 	.pin_config_get		= amd_pinconf_get,
 	.pin_config_set		= amd_pinconf_set,
@@ -865,34 +862,6 @@ static const struct pinconf_ops amd_pinconf_ops = {
 	.pin_config_group_set = amd_pinconf_group_set,
 };
 
-static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
-{
-	struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
-	unsigned long flags;
-	u32 pin_reg, mask;
-	int i;
-
-	mask = BIT(WAKE_CNTRL_OFF_S0I3) | BIT(WAKE_CNTRL_OFF_S3) |
-		BIT(INTERRUPT_MASK_OFF) | BIT(INTERRUPT_ENABLE_OFF) |
-		BIT(WAKE_CNTRL_OFF_S4);
-
-	for (i = 0; i < desc->npins; i++) {
-		int pin = desc->pins[i].number;
-		const struct pin_desc *pd = pin_desc_get(gpio_dev->pctrl, pin);
-
-		if (!pd)
-			continue;
-
-		raw_spin_lock_irqsave(&gpio_dev->lock, flags);
-
-		pin_reg = readl(gpio_dev->base + i * 4);
-		pin_reg &= ~mask;
-		writel(pin_reg, gpio_dev->base + i * 4);
-
-		raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
-	}
-}
-
 #ifdef CONFIG_PM_SLEEP
 static bool amd_gpio_should_save(struct amd_gpio *gpio_dev, unsigned int pin)
 {
@@ -1130,9 +1099,6 @@ static int amd_gpio_probe(struct platform_device *pdev)
 		return PTR_ERR(gpio_dev->pctrl);
 	}
 
-	/* Disable and mask interrupts */
-	amd_gpio_irq_init(gpio_dev);
-
 	girq = &gpio_dev->gc.irq;
 	gpio_irq_chip_set_chip(girq, &amd_gpio_irqchip);
 	/* This will let us handle the parent IRQ in the driver */
diff --git a/drivers/pinctrl/pinctrl-amd.h b/drivers/pinctrl/pinctrl-amd.h
index c8635998465d..34c5c3e71fb2 100644
--- a/drivers/pinctrl/pinctrl-amd.h
+++ b/drivers/pinctrl/pinctrl-amd.h
@@ -17,6 +17,7 @@
 #define AMD_GPIO_PINS_BANK3     32
 
 #define WAKE_INT_MASTER_REG 0xfc
+#define INTERNAL_GPIO0_DEBOUNCE (1 << 15)
 #define EOI_MASK (1 << 29)
 
 #define WAKE_INT_STATUS_REG0 0x2f8
@@ -35,13 +36,13 @@
 #define WAKE_CNTRL_OFF_S4               15
 #define PIN_STS_OFF			16
 #define DRV_STRENGTH_SEL_OFF		17
-#define PULL_UP_SEL_OFF			19
 #define PULL_UP_ENABLE_OFF		20
 #define PULL_DOWN_ENABLE_OFF		21
 #define OUTPUT_VALUE_OFF		22
 #define OUTPUT_ENABLE_OFF		23
 #define SW_CNTRL_IN_OFF			24
 #define SW_CNTRL_EN_OFF			25
+#define WAKECNTRL_Z_OFF			27
 #define INTERRUPT_STS_OFF		28
 #define WAKE_STS_OFF			29
 
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 223550a10d4d..2fe6e147785e 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -135,6 +135,16 @@ static acpi_status find_guid(const char *guid_string, struct wmi_block **out)
 	return AE_NOT_FOUND;
 }
 
+static bool guid_parse_and_compare(const char *string, const guid_t *guid)
+{
+	guid_t guid_input;
+
+	if (guid_parse(string, &guid_input))
+		return false;
+
+	return guid_equal(&guid_input, guid);
+}
+
 static const void *find_guid_context(struct wmi_block *wblock,
 				     struct wmi_driver *wdriver)
 {
@@ -145,11 +155,7 @@ static const void *find_guid_context(struct wmi_block *wblock,
 		return NULL;
 
 	while (*id->guid_string) {
-		guid_t guid_input;
-
-		if (guid_parse(id->guid_string, &guid_input))
-			continue;
-		if (guid_equal(&wblock->gblock.guid, &guid_input))
+		if (guid_parse_and_compare(id->guid_string, &wblock->gblock.guid))
 			return id->context;
 		id++;
 	}
@@ -833,11 +839,7 @@ static int wmi_dev_match(struct device *dev, struct device_driver *driver)
 		return 0;
 
 	while (*id->guid_string) {
-		guid_t driver_guid;
-
-		if (WARN_ON(guid_parse(id->guid_string, &driver_guid)))
-			continue;
-		if (guid_equal(&driver_guid, &wblock->gblock.guid))
+		if (guid_parse_and_compare(id->guid_string, &wblock->gblock.guid))
 			return 1;
 
 		id++;
diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 5732300eb004..33107204a951 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -156,8 +156,9 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 			  const struct pwm_state *state)
 {
 	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
-	unsigned int duty, period, pre_div, cnt, duty_cnt;
+	unsigned int pre_div, cnt, duty_cnt;
 	unsigned long fin_freq;
+	u64 duty, period;
 
 	duty = state->duty_cycle;
 	period = state->period;
@@ -179,19 +180,19 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 
 	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
 
-	pre_div = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
+	pre_div = div64_u64(fin_freq * period, NSEC_PER_SEC * 0xffffLL);
 	if (pre_div > MISC_CLK_DIV_MASK) {
 		dev_err(meson->chip.dev, "unable to get period pre_div\n");
 		return -EINVAL;
 	}
 
-	cnt = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * (pre_div + 1));
+	cnt = div64_u64(fin_freq * period, NSEC_PER_SEC * (pre_div + 1));
 	if (cnt > 0xffff) {
 		dev_err(meson->chip.dev, "unable to get period cnt\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(meson->chip.dev, "period=%u pre_div=%u cnt=%u\n", period,
+	dev_dbg(meson->chip.dev, "period=%llu pre_div=%u cnt=%u\n", period,
 		pre_div, cnt);
 
 	if (duty == period) {
@@ -204,14 +205,13 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 		channel->lo = cnt;
 	} else {
 		/* Then check is we can have the duty with the same pre_div */
-		duty_cnt = div64_u64(fin_freq * (u64)duty,
-				     NSEC_PER_SEC * (pre_div + 1));
+		duty_cnt = div64_u64(fin_freq * duty, NSEC_PER_SEC * (pre_div + 1));
 		if (duty_cnt > 0xffff) {
 			dev_err(meson->chip.dev, "unable to get duty cycle\n");
 			return -EINVAL;
 		}
 
-		dev_dbg(meson->chip.dev, "duty=%u pre_div=%u duty_cnt=%u\n",
+		dev_dbg(meson->chip.dev, "duty=%llu pre_div=%u duty_cnt=%u\n",
 			duty, pre_div, duty_cnt);
 
 		channel->pre_div = pre_div;
@@ -351,18 +351,8 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	channel->lo = FIELD_GET(PWM_LOW_MASK, value);
 	channel->hi = FIELD_GET(PWM_HIGH_MASK, value);
 
-	if (channel->lo == 0) {
-		state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
-		state->duty_cycle = state->period;
-	} else if (channel->lo >= channel->hi) {
-		state->period = meson_pwm_cnt_to_ns(chip, pwm,
-						    channel->lo + channel->hi);
-		state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm,
-							channel->hi);
-	} else {
-		state->period = 0;
-		state->duty_cycle = 0;
-	}
+	state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->lo + channel->hi);
+	state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
 
 	state->polarity = PWM_POLARITY_NORMAL;
 
diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 5ad251477593..f99a9ef42116 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -1188,6 +1188,9 @@ static long zcrypt_msgtype6_send_cprb(bool userspace, struct zcrypt_queue *zq,
 		ap_cancel_message(zq->queue, ap_msg);
 	}
 
+	if (rc == -EAGAIN && ap_msg->flags & AP_MSG_FLAG_ADMIN)
+		rc = -EIO; /* do not retry administrative requests */
+
 out:
 	if (rc)
 		ZCRYPT_DBF_DBG("%s send cprb at dev=%02x.%04x rc=%d\n",
@@ -1308,6 +1311,9 @@ static long zcrypt_msgtype6_send_ep11_cprb(bool userspace, struct zcrypt_queue *
 		ap_cancel_message(zq->queue, ap_msg);
 	}
 
+	if (rc == -EAGAIN && ap_msg->flags & AP_MSG_FLAG_ADMIN)
+		rc = -EIO; /* do not retry administrative requests */
+
 out:
 	if (rc)
 		ZCRYPT_DBF_DBG("%s send cprb at dev=%02x.%04x rc=%d\n",
diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index d2d207791056..3a5650e0e207 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -134,7 +134,6 @@ void lpfc_check_nlp_post_devloss(struct lpfc_vport *vport,
 				 struct lpfc_nodelist *ndlp);
 void lpfc_ignore_els_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			  struct lpfc_iocbq *rspiocb);
-int  lpfc_nlp_not_used(struct lpfc_nodelist *ndlp);
 struct lpfc_nodelist *lpfc_setup_disc_node(struct lpfc_vport *, uint32_t);
 void lpfc_disc_list_loopmap(struct lpfc_vport *);
 void lpfc_disc_start(struct lpfc_vport *);
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index e21c73a3803e..43ebb41ded59 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -5150,14 +5150,9 @@ lpfc_els_free_iocb(struct lpfc_hba *phba, struct lpfc_iocbq *elsiocb)
  *
  * This routine is the completion callback function to the Logout (LOGO)
  * Accept (ACC) Response ELS command. This routine is invoked to indicate
- * the completion of the LOGO process. It invokes the lpfc_nlp_not_used() to
- * release the ndlp if it has the last reference remaining (reference count
- * is 1). If succeeded (meaning ndlp released), it sets the iocb ndlp
- * field to NULL to inform the following lpfc_els_free_iocb() routine no
- * ndlp reference count needs to be decremented. Otherwise, the ndlp
- * reference use-count shall be decremented by the lpfc_els_free_iocb()
- * routine. Finally, the lpfc_els_free_iocb() is invoked to release the
- * IOCB data structure.
+ * the completion of the LOGO process. If the node has transitioned to NPR,
+ * this routine unregisters the RPI if it is still registered. The
+ * lpfc_els_free_iocb() is invoked to release the IOCB data structure.
  **/
 static void
 lpfc_cmpl_els_logo_acc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
@@ -5198,19 +5193,9 @@ lpfc_cmpl_els_logo_acc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		    (ndlp->nlp_last_elscmd == ELS_CMD_PLOGI))
 			goto out;
 
-		/* NPort Recovery mode or node is just allocated */
-		if (!lpfc_nlp_not_used(ndlp)) {
-			/* A LOGO is completing and the node is in NPR state.
-			 * Just unregister the RPI because the node is still
-			 * required.
-			 */
+		if (ndlp->nlp_flag & NLP_RPI_REGISTERED)
 			lpfc_unreg_rpi(vport, ndlp);
-		} else {
-			/* Indicate the node has already released, should
-			 * not reference to it from within lpfc_els_free_iocb.
-			 */
-			cmdiocb->ndlp = NULL;
-		}
+
 	}
  out:
 	/*
@@ -5230,9 +5215,8 @@ lpfc_cmpl_els_logo_acc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
  * RPI (Remote Port Index) mailbox command to the @phba. It simply releases
  * the associated lpfc Direct Memory Access (DMA) buffer back to the pool and
  * decrements the ndlp reference count held for this completion callback
- * function. After that, it invokes the lpfc_nlp_not_used() to check
- * whether there is only one reference left on the ndlp. If so, it will
- * perform one more decrement and trigger the release of the ndlp.
+ * function. After that, it invokes the lpfc_drop_node to check
+ * whether it is appropriate to release the node.
  **/
 void
 lpfc_mbx_cmpl_dflt_rpi(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index d38ebd7281b9..549fa7d6c0f6 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -4332,13 +4332,14 @@ lpfc_mbx_cmpl_ns_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 
 		/* If the node is not registered with the scsi or nvme
 		 * transport, remove the fabric node.  The failed reg_login
-		 * is terminal.
+		 * is terminal and forces the removal of the last node
+		 * reference.
 		 */
 		if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD))) {
 			spin_lock_irq(&ndlp->lock);
 			ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
 			spin_unlock_irq(&ndlp->lock);
-			lpfc_nlp_not_used(ndlp);
+			lpfc_nlp_put(ndlp);
 		}
 
 		if (phba->fc_topology == LPFC_TOPOLOGY_LOOP) {
@@ -6703,25 +6704,6 @@ lpfc_nlp_put(struct lpfc_nodelist *ndlp)
 	return ndlp ? kref_put(&ndlp->kref, lpfc_nlp_release) : 0;
 }
 
-/* This routine free's the specified nodelist if it is not in use
- * by any other discovery thread. This routine returns 1 if the
- * ndlp has been freed. A return value of 0 indicates the ndlp is
- * not yet been released.
- */
-int
-lpfc_nlp_not_used(struct lpfc_nodelist *ndlp)
-{
-	lpfc_debugfs_disc_trc(ndlp->vport, LPFC_DISC_TRC_NODE,
-		"node not used:   did:x%x flg:x%x refcnt:x%x",
-		ndlp->nlp_DID, ndlp->nlp_flag,
-		kref_read(&ndlp->kref));
-
-	if (kref_read(&ndlp->kref) == 1)
-		if (lpfc_nlp_put(ndlp))
-			return 1;
-	return 0;
-}
-
 /**
  * lpfc_fcf_inuse - Check if FCF can be unregistered.
  * @phba: Pointer to hba context object.
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 64355d0baa5f..d2c7de804b99 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -402,6 +402,11 @@ static void mpi3mr_process_admin_reply_desc(struct mpi3mr_ioc *mrioc,
 				memcpy((u8 *)cmdptr->reply, (u8 *)def_reply,
 				    mrioc->reply_sz);
 			}
+			if (sense_buf && cmdptr->sensebuf) {
+				cmdptr->is_sense = 1;
+				memcpy(cmdptr->sensebuf, sense_buf,
+				       MPI3MR_SENSE_BUF_SZ);
+			}
 			if (cmdptr->is_waiting) {
 				complete(&cmdptr->done);
 				cmdptr->is_waiting = 0;
diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index b67ad30d56e6..64734d6e8ccb 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -2750,6 +2750,7 @@ static void
 qla2x00_terminate_rport_io(struct fc_rport *rport)
 {
 	fc_port_t *fcport = *(fc_port_t **)rport->dd_data;
+	scsi_qla_host_t *vha;
 
 	if (!fcport)
 		return;
@@ -2759,9 +2760,12 @@ qla2x00_terminate_rport_io(struct fc_rport *rport)
 
 	if (test_bit(ABORT_ISP_ACTIVE, &fcport->vha->dpc_flags))
 		return;
+	vha = fcport->vha;
 
 	if (unlikely(pci_channel_offline(fcport->vha->hw->pdev))) {
 		qla2x00_abort_all_cmds(fcport->vha, DID_NO_CONNECT << 16);
+		qla2x00_eh_wait_for_pending_commands(fcport->vha, fcport->d_id.b24,
+			0, WAIT_TARGET);
 		return;
 	}
 	/*
@@ -2786,6 +2790,15 @@ qla2x00_terminate_rport_io(struct fc_rport *rport)
 			qla2x00_port_logout(fcport->vha, fcport);
 		}
 	}
+
+	/* check for any straggling io left behind */
+	if (qla2x00_eh_wait_for_pending_commands(fcport->vha, fcport->d_id.b24, 0, WAIT_TARGET)) {
+		ql_log(ql_log_warn, vha, 0x300b,
+		       "IO not return.  Resetting. \n");
+		set_bit(ISP_ABORT_NEEDED, &vha->dpc_flags);
+		qla2xxx_wake_dpc(vha);
+		qla2x00_wait_for_chip_reset(vha);
+	}
 }
 
 static int
diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index dba7bba788d7..19bb64bdd88b 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -283,6 +283,10 @@ qla2x00_process_els(struct bsg_job *bsg_job)
 
 	if (bsg_request->msgcode == FC_BSG_RPT_ELS) {
 		rport = fc_bsg_to_rport(bsg_job);
+		if (!rport) {
+			rval = -ENOMEM;
+			goto done;
+		}
 		fcport = *(fc_port_t **) rport->dd_data;
 		host = rport_to_shost(rport);
 		vha = shost_priv(host);
@@ -2992,6 +2996,8 @@ qla24xx_bsg_request(struct bsg_job *bsg_job)
 
 	if (bsg_request->msgcode == FC_BSG_RPT_ELS) {
 		rport = fc_bsg_to_rport(bsg_job);
+		if (!rport)
+			return ret;
 		host = rport_to_shost(rport);
 		vha = shost_priv(host);
 	} else {
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index cd4eb11b0707..5a2f629d18e6 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -457,6 +457,15 @@ static inline be_id_t port_id_to_be_id(port_id_t port_id)
 	return res;
 }
 
+struct tmf_arg {
+	struct qla_qpair *qpair;
+	struct fc_port *fcport;
+	struct scsi_qla_host *vha;
+	u64 lun;
+	u32 flags;
+	uint8_t modifier;
+};
+
 struct els_logo_payload {
 	uint8_t opcode;
 	uint8_t rsvd[3];
@@ -536,6 +545,10 @@ struct srb_iocb {
 			uint32_t data;
 			struct completion comp;
 			__le16 comp_status;
+
+			uint8_t modifier;
+			uint8_t vp_index;
+			uint16_t loop_id;
 		} tmf;
 		struct {
 #define SRB_FXDISC_REQ_DMA_VALID	BIT_0
@@ -639,6 +652,7 @@ struct srb_iocb {
 #define SRB_SA_UPDATE	25
 #define SRB_ELS_CMD_HST_NOLOGIN 26
 #define SRB_SA_REPLACE	27
+#define SRB_MARKER	28
 
 struct qla_els_pt_arg {
 	u8 els_opcode;
@@ -681,7 +695,6 @@ typedef struct srb {
 	struct iocb_resource iores;
 	struct kref cmd_kref;	/* need to migrate ref_count over to this */
 	void *priv;
-	wait_queue_head_t nvme_ls_waitq;
 	struct fc_port *fcport;
 	struct scsi_qla_host *vha;
 	unsigned int start_timer:1;
@@ -2521,6 +2534,7 @@ enum rscn_addr_format {
 typedef struct fc_port {
 	struct list_head list;
 	struct scsi_qla_host *vha;
+	struct list_head tmf_pending;
 
 	unsigned int conf_compl_supported:1;
 	unsigned int deleted:2;
@@ -2541,6 +2555,8 @@ typedef struct fc_port {
 	unsigned int do_prli_nvme:1;
 
 	uint8_t nvme_flag;
+	uint8_t active_tmf;
+#define MAX_ACTIVE_TMF 8
 
 	uint8_t node_name[WWN_SIZE];
 	uint8_t port_name[WWN_SIZE];
@@ -5482,4 +5498,8 @@ struct ql_vnd_tgt_stats_resp {
 	_fp->disc_state, _fp->scan_state, _fp->loop_id, _fp->deleted, \
 	_fp->flags
 
+#define TMF_NOT_READY(_fcport) \
+	(!_fcport || IS_SESSION_DELETED(_fcport) || atomic_read(&_fcport->state) != FCS_ONLINE || \
+	!_fcport->vha->hw->flags.fw_started)
+
 #endif
diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_edif.c
index 1cafd27d5a60..7aee4d093969 100644
--- a/drivers/scsi/qla2xxx/qla_edif.c
+++ b/drivers/scsi/qla2xxx/qla_edif.c
@@ -2319,8 +2319,8 @@ qla24xx_issue_sa_replace_iocb(scsi_qla_host_t *vha, struct qla_work_evt *e)
 	if (!sa_ctl) {
 		ql_dbg(ql_dbg_edif, vha, 0x70e6,
 		    "sa_ctl allocation failed\n");
-		rval =  -ENOMEM;
-		goto done;
+		rval = -ENOMEM;
+		return rval;
 	}
 
 	fcport = sa_ctl->fcport;
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index ee54207fc531..316122709b0e 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -69,7 +69,7 @@ extern int qla2x00_async_logout(struct scsi_qla_host *, fc_port_t *);
 extern int qla2x00_async_prlo(struct scsi_qla_host *, fc_port_t *);
 extern int qla2x00_async_adisc(struct scsi_qla_host *, fc_port_t *,
     uint16_t *);
-extern int qla2x00_async_tm_cmd(fc_port_t *, uint32_t, uint32_t, uint32_t);
+extern int qla2x00_async_tm_cmd(fc_port_t *, uint32_t, uint64_t, uint32_t);
 struct qla_work_evt *qla2x00_alloc_work(struct scsi_qla_host *,
     enum qla_work_type);
 extern int qla24xx_async_gnl(struct scsi_qla_host *, fc_port_t *);
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 93f7f3dd5d82..b597c782b95e 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1997,6 +1997,11 @@ qla2x00_tmf_iocb_timeout(void *data)
 	int rc, h;
 	unsigned long flags;
 
+	if (sp->type == SRB_MARKER) {
+		complete(&tmf->u.tmf.comp);
+		return;
+	}
+
 	rc = qla24xx_async_abort_cmd(sp, false);
 	if (rc) {
 		spin_lock_irqsave(sp->qpair->qp_lock_ptr, flags);
@@ -2014,24 +2019,131 @@ qla2x00_tmf_iocb_timeout(void *data)
 	}
 }
 
+static void qla_marker_sp_done(srb_t *sp, int res)
+{
+	struct srb_iocb *tmf = &sp->u.iocb_cmd;
+
+	if (res != QLA_SUCCESS)
+		ql_dbg(ql_dbg_taskm, sp->vha, 0x8004,
+		    "Async-marker fail hdl=%x portid=%06x ctrl=%x lun=%lld qp=%d.\n",
+		    sp->handle, sp->fcport->d_id.b24, sp->u.iocb_cmd.u.tmf.flags,
+		    sp->u.iocb_cmd.u.tmf.lun, sp->qpair->id);
+
+	sp->u.iocb_cmd.u.tmf.data = res;
+	complete(&tmf->u.tmf.comp);
+}
+
+#define  START_SP_W_RETRIES(_sp, _rval) \
+{\
+	int cnt = 5; \
+	do { \
+		_rval = qla2x00_start_sp(_sp); \
+		if (_rval == EAGAIN) \
+			msleep(1); \
+		else \
+			break; \
+		cnt--; \
+	} while (cnt); \
+}
+
+/**
+ * qla26xx_marker: send marker IOCB and wait for the completion of it.
+ * @arg: pointer to argument list.
+ *    It is assume caller will provide an fcport pointer and modifier
+ */
+static int
+qla26xx_marker(struct tmf_arg *arg)
+{
+	struct scsi_qla_host *vha = arg->vha;
+	struct srb_iocb *tm_iocb;
+	srb_t *sp;
+	int rval = QLA_FUNCTION_FAILED;
+	fc_port_t *fcport = arg->fcport;
+
+	if (TMF_NOT_READY(arg->fcport)) {
+		ql_dbg(ql_dbg_taskm, vha, 0x8039,
+		    "FC port not ready for marker loop-id=%x portid=%06x modifier=%x lun=%lld qp=%d.\n",
+		    fcport->loop_id, fcport->d_id.b24,
+		    arg->modifier, arg->lun, arg->qpair->id);
+		return QLA_SUSPENDED;
+	}
+
+	/* ref: INIT */
+	sp = qla2xxx_get_qpair_sp(vha, arg->qpair, fcport, GFP_KERNEL);
+	if (!sp)
+		goto done;
+
+	sp->type = SRB_MARKER;
+	sp->name = "marker";
+	qla2x00_init_async_sp(sp, qla2x00_get_async_timeout(vha), qla_marker_sp_done);
+	sp->u.iocb_cmd.timeout = qla2x00_tmf_iocb_timeout;
+
+	tm_iocb = &sp->u.iocb_cmd;
+	init_completion(&tm_iocb->u.tmf.comp);
+	tm_iocb->u.tmf.modifier = arg->modifier;
+	tm_iocb->u.tmf.lun = arg->lun;
+	tm_iocb->u.tmf.loop_id = fcport->loop_id;
+	tm_iocb->u.tmf.vp_index = vha->vp_idx;
+
+	START_SP_W_RETRIES(sp, rval);
+
+	ql_dbg(ql_dbg_taskm, vha, 0x8006,
+	    "Async-marker hdl=%x loop-id=%x portid=%06x modifier=%x lun=%lld qp=%d rval %d.\n",
+	    sp->handle, fcport->loop_id, fcport->d_id.b24,
+	    arg->modifier, arg->lun, sp->qpair->id, rval);
+
+	if (rval != QLA_SUCCESS) {
+		ql_log(ql_log_warn, vha, 0x8031,
+		    "Marker IOCB send failure (%x).\n", rval);
+		goto done_free_sp;
+	}
+
+	wait_for_completion(&tm_iocb->u.tmf.comp);
+	rval = tm_iocb->u.tmf.data;
+
+	if (rval != QLA_SUCCESS) {
+		ql_log(ql_log_warn, vha, 0x8019,
+		    "Marker failed hdl=%x loop-id=%x portid=%06x modifier=%x lun=%lld qp=%d rval %d.\n",
+		    sp->handle, fcport->loop_id, fcport->d_id.b24,
+		    arg->modifier, arg->lun, sp->qpair->id, rval);
+	}
+
+done_free_sp:
+	/* ref: INIT */
+	kref_put(&sp->cmd_kref, qla2x00_sp_release);
+done:
+	return rval;
+}
+
 static void qla2x00_tmf_sp_done(srb_t *sp, int res)
 {
 	struct srb_iocb *tmf = &sp->u.iocb_cmd;
 
+	if (res)
+		tmf->u.tmf.data = res;
 	complete(&tmf->u.tmf.comp);
 }
 
-int
-qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint32_t lun,
-	uint32_t tag)
+static int
+__qla2x00_async_tm_cmd(struct tmf_arg *arg)
 {
-	struct scsi_qla_host *vha = fcport->vha;
+	struct scsi_qla_host *vha = arg->vha;
 	struct srb_iocb *tm_iocb;
 	srb_t *sp;
 	int rval = QLA_FUNCTION_FAILED;
 
+	fc_port_t *fcport = arg->fcport;
+
+	if (TMF_NOT_READY(arg->fcport)) {
+		ql_dbg(ql_dbg_taskm, vha, 0x8032,
+		    "FC port not ready for TM command loop-id=%x portid=%06x modifier=%x lun=%lld qp=%d.\n",
+		    fcport->loop_id, fcport->d_id.b24,
+		    arg->modifier, arg->lun, arg->qpair->id);
+		return QLA_SUSPENDED;
+	}
+
 	/* ref: INIT */
-	sp = qla2x00_get_sp(vha, fcport, GFP_KERNEL);
+	sp = qla2xxx_get_qpair_sp(vha, arg->qpair, fcport, GFP_KERNEL);
 	if (!sp)
 		goto done;
 
@@ -2044,15 +2156,16 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint32_t lun,
 
 	tm_iocb = &sp->u.iocb_cmd;
 	init_completion(&tm_iocb->u.tmf.comp);
-	tm_iocb->u.tmf.flags = flags;
-	tm_iocb->u.tmf.lun = lun;
+	tm_iocb->u.tmf.flags = arg->flags;
+	tm_iocb->u.tmf.lun = arg->lun;
+
+	START_SP_W_RETRIES(sp, rval);
 
 	ql_dbg(ql_dbg_taskm, vha, 0x802f,
-	    "Async-tmf hdl=%x loop-id=%x portid=%02x%02x%02x.\n",
-	    sp->handle, fcport->loop_id, fcport->d_id.b.domain,
-	    fcport->d_id.b.area, fcport->d_id.b.al_pa);
+	    "Async-tmf hdl=%x loop-id=%x portid=%06x ctrl=%x lun=%lld qp=%d rval=%x.\n",
+	    sp->handle, fcport->loop_id, fcport->d_id.b24,
+	    arg->flags, arg->lun, sp->qpair->id, rval);
 
-	rval = qla2x00_start_sp(sp);
 	if (rval != QLA_SUCCESS)
 		goto done_free_sp;
 	wait_for_completion(&tm_iocb->u.tmf.comp);
@@ -2064,15 +2177,8 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint32_t lun,
 		    "TM IOCB failed (%x).\n", rval);
 	}
 
-	if (!test_bit(UNLOADING, &vha->dpc_flags) && !IS_QLAFX00(vha->hw)) {
-		flags = tm_iocb->u.tmf.flags;
-		lun = (uint16_t)tm_iocb->u.tmf.lun;
-
-		/* Issue Marker IOCB */
-		qla2x00_marker(vha, vha->hw->base_qpair,
-		    fcport->loop_id, lun,
-		    flags == TCF_LUN_RESET ? MK_SYNC_ID_LUN : MK_SYNC_ID);
-	}
+	if (!test_bit(UNLOADING, &vha->dpc_flags) && !IS_QLAFX00(vha->hw))
+		rval = qla26xx_marker(arg);
 
 done_free_sp:
 	/* ref: INIT */
@@ -2081,6 +2187,115 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint32_t lun,
 	return rval;
 }
 
+static void qla_put_tmf(fc_port_t *fcport)
+{
+	struct scsi_qla_host *vha = fcport->vha;
+	struct qla_hw_data *ha = vha->hw;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
+	fcport->active_tmf--;
+	spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
+}
+
+static
+int qla_get_tmf(fc_port_t *fcport)
+{
+	struct scsi_qla_host *vha = fcport->vha;
+	struct qla_hw_data *ha = vha->hw;
+	unsigned long flags;
+	int rc = 0;
+	LIST_HEAD(tmf_elem);
+
+	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
+	list_add_tail(&tmf_elem, &fcport->tmf_pending);
+
+	while (fcport->active_tmf >= MAX_ACTIVE_TMF) {
+		spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
+
+		msleep(1);
+
+		spin_lock_irqsave(&ha->tgt.sess_lock, flags);
+		if (TMF_NOT_READY(fcport)) {
+			ql_log(ql_log_warn, vha, 0x802c,
+			    "Unable to acquire TM resource due to disruption.\n");
+			rc = EIO;
+			break;
+		}
+		if (fcport->active_tmf < MAX_ACTIVE_TMF &&
+		    list_is_first(&tmf_elem, &fcport->tmf_pending))
+			break;
+	}
+
+	list_del(&tmf_elem);
+
+	if (!rc)
+		fcport->active_tmf++;
+
+	spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
+
+	return rc;
+}
+
+int
+qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint64_t lun,
+		     uint32_t tag)
+{
+	struct scsi_qla_host *vha = fcport->vha;
+	struct qla_qpair *qpair;
+	struct tmf_arg a;
+	int i, rval = QLA_SUCCESS;
+
+	if (TMF_NOT_READY(fcport))
+		return QLA_SUSPENDED;
+
+	a.vha = fcport->vha;
+	a.fcport = fcport;
+	a.lun = lun;
+	if (flags & (TCF_LUN_RESET|TCF_ABORT_TASK_SET|TCF_CLEAR_TASK_SET|TCF_CLEAR_ACA)) {
+		a.modifier = MK_SYNC_ID_LUN;
+
+		if (qla_get_tmf(fcport))
+			return QLA_FUNCTION_FAILED;
+	} else {
+		a.modifier = MK_SYNC_ID;
+	}
+
+	if (vha->hw->mqenable) {
+		for (i = 0; i < vha->hw->num_qpairs; i++) {
+			qpair = vha->hw->queue_pair_map[i];
+			if (!qpair)
+				continue;
+
+			if (TMF_NOT_READY(fcport)) {
+				ql_log(ql_log_warn, vha, 0x8026,
+				    "Unable to send TM due to disruption.\n");
+				rval = QLA_SUSPENDED;
+				break;
+			}
+
+			a.qpair = qpair;
+			a.flags = flags|TCF_NOTMCMD_TO_TARGET;
+			rval = __qla2x00_async_tm_cmd(&a);
+			if (rval)
+				break;
+		}
+	}
+
+	if (rval)
+		goto bailout;
+
+	a.qpair = vha->hw->base_qpair;
+	a.flags = flags;
+	rval = __qla2x00_async_tm_cmd(&a);
+
+bailout:
+	if (a.modifier == MK_SYNC_ID_LUN)
+		qla_put_tmf(fcport);
+
+	return rval;
+}
+
 int
 qla24xx_async_abort_command(srb_t *sp)
 {
@@ -5313,6 +5528,7 @@ qla2x00_alloc_fcport(scsi_qla_host_t *vha, gfp_t flags)
 	INIT_WORK(&fcport->reg_work, qla_register_fcport_fn);
 	INIT_LIST_HEAD(&fcport->gnl_entry);
 	INIT_LIST_HEAD(&fcport->list);
+	INIT_LIST_HEAD(&fcport->tmf_pending);
 
 	INIT_LIST_HEAD(&fcport->sess_cmd_list);
 	spin_lock_init(&fcport->sess_cmd_lock);
@@ -5355,7 +5571,7 @@ static void qla_get_login_template(scsi_qla_host_t *vha)
 	__be32 *q;
 
 	memset(ha->init_cb, 0, ha->init_cb_size);
-	sz = min_t(int, sizeof(struct fc_els_flogi), ha->init_cb_size);
+	sz = min_t(int, sizeof(struct fc_els_csp), ha->init_cb_size);
 	rval = qla24xx_get_port_login_templ(vha, ha->init_cb_dma,
 					    ha->init_cb, sz);
 	if (rval != QLA_SUCCESS) {
diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index b0ee307b5d4b..a034699e58ae 100644
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -109,11 +109,13 @@ qla2x00_set_fcport_disc_state(fc_port_t *fcport, int state)
 {
 	int old_val;
 	uint8_t shiftbits, mask;
+	uint8_t port_dstate_str_sz;
 
 	/* This will have to change when the max no. of states > 16 */
 	shiftbits = 4;
 	mask = (1 << shiftbits) - 1;
 
+	port_dstate_str_sz = sizeof(port_dstate_str) / sizeof(char *);
 	fcport->disc_state = state;
 	while (1) {
 		old_val = atomic_read(&fcport->shadow_disc_state);
@@ -121,7 +123,8 @@ qla2x00_set_fcport_disc_state(fc_port_t *fcport, int state)
 		    old_val, (old_val << shiftbits) | state)) {
 			ql_dbg(ql_dbg_disc, fcport->vha, 0x2134,
 			    "FCPort %8phC disc_state transition: %s to %s - portid=%06x.\n",
-			    fcport->port_name, port_dstate_str[old_val & mask],
+			    fcport->port_name, (old_val & mask) < port_dstate_str_sz ?
+				    port_dstate_str[old_val & mask] : "Unknown",
 			    port_dstate_str[state], fcport->d_id.b24);
 			return;
 		}
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 4f48f098ea5a..c9a686f06d29 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -522,21 +522,25 @@ __qla2x00_marker(struct scsi_qla_host *vha, struct qla_qpair *qpair,
 		return (QLA_FUNCTION_FAILED);
 	}
 
+	mrk24 = (struct mrk_entry_24xx *)mrk;
+
 	mrk->entry_type = MARKER_TYPE;
 	mrk->modifier = type;
 	if (type != MK_SYNC_ALL) {
 		if (IS_FWI2_CAPABLE(ha)) {
-			mrk24 = (struct mrk_entry_24xx *) mrk;
 			mrk24->nport_handle = cpu_to_le16(loop_id);
 			int_to_scsilun(lun, (struct scsi_lun *)&mrk24->lun);
 			host_to_fcp_swap(mrk24->lun, sizeof(mrk24->lun));
 			mrk24->vp_index = vha->vp_idx;
-			mrk24->handle = make_handle(req->id, mrk24->handle);
 		} else {
 			SET_TARGET_ID(ha, mrk->target, loop_id);
 			mrk->lun = cpu_to_le16((uint16_t)lun);
 		}
 	}
+
+	if (IS_FWI2_CAPABLE(ha))
+		mrk24->handle = QLA_SKIP_HANDLE;
+
 	wmb();
 
 	qla2x00_start_iocbs(vha, req);
@@ -603,7 +607,8 @@ qla24xx_build_scsi_type_6_iocbs(srb_t *sp, struct cmd_type_6 *cmd_pkt,
 	put_unaligned_le32(COMMAND_TYPE_6, &cmd_pkt->entry_type);
 
 	/* No data transfer */
-	if (!scsi_bufflen(cmd) || cmd->sc_data_direction == DMA_NONE) {
+	if (!scsi_bufflen(cmd) || cmd->sc_data_direction == DMA_NONE ||
+	    tot_dsds == 0) {
 		cmd_pkt->byte_count = cpu_to_le32(0);
 		return 0;
 	}
@@ -2541,7 +2546,7 @@ qla24xx_tm_iocb(srb_t *sp, struct tsk_mgmt_entry *tsk)
 	scsi_qla_host_t *vha = fcport->vha;
 	struct qla_hw_data *ha = vha->hw;
 	struct srb_iocb *iocb = &sp->u.iocb_cmd;
-	struct req_que *req = vha->req;
+	struct req_que *req = sp->qpair->req;
 
 	flags = iocb->u.tmf.flags;
 	lun = iocb->u.tmf.lun;
@@ -2557,7 +2562,8 @@ qla24xx_tm_iocb(srb_t *sp, struct tsk_mgmt_entry *tsk)
 	tsk->port_id[2] = fcport->d_id.b.domain;
 	tsk->vp_index = fcport->vha->vp_idx;
 
-	if (flags == TCF_LUN_RESET) {
+	if (flags & (TCF_LUN_RESET | TCF_ABORT_TASK_SET|
+	    TCF_CLEAR_TASK_SET|TCF_CLEAR_ACA)) {
 		int_to_scsilun(lun, &tsk->lun);
 		host_to_fcp_swap((uint8_t *)&tsk->lun,
 			sizeof(tsk->lun));
@@ -3858,9 +3864,9 @@ int qla_get_iocbs_resource(struct srb *sp)
 	case SRB_NACK_LOGO:
 	case SRB_LOGOUT_CMD:
 	case SRB_CTRL_VP:
-		push_it_through = true;
-		fallthrough;
+	case SRB_MARKER:
 	default:
+		push_it_through = true;
 		get_exch = false;
 	}
 
@@ -3876,6 +3882,19 @@ int qla_get_iocbs_resource(struct srb *sp)
 	return qla_get_fw_resources(sp->qpair, &sp->iores);
 }
 
+static void
+qla_marker_iocb(srb_t *sp, struct mrk_entry_24xx *mrk)
+{
+	mrk->entry_type = MARKER_TYPE;
+	mrk->modifier = sp->u.iocb_cmd.u.tmf.modifier;
+	if (sp->u.iocb_cmd.u.tmf.modifier != MK_SYNC_ALL) {
+		mrk->nport_handle = cpu_to_le16(sp->u.iocb_cmd.u.tmf.loop_id);
+		int_to_scsilun(sp->u.iocb_cmd.u.tmf.lun, (struct scsi_lun *)&mrk->lun);
+		host_to_fcp_swap(mrk->lun, sizeof(mrk->lun));
+		mrk->vp_index = sp->u.iocb_cmd.u.tmf.vp_index;
+	}
+}
+
 int
 qla2x00_start_sp(srb_t *sp)
 {
@@ -3898,7 +3917,7 @@ qla2x00_start_sp(srb_t *sp)
 
 	pkt = __qla2x00_alloc_iocbs(sp->qpair, sp);
 	if (!pkt) {
-		rval = EAGAIN;
+		rval = -EAGAIN;
 		ql_log(ql_log_warn, vha, 0x700c,
 		    "qla2x00_alloc_iocbs failed.\n");
 		goto done;
@@ -3979,6 +3998,9 @@ qla2x00_start_sp(srb_t *sp)
 	case SRB_SA_REPLACE:
 		qla24xx_sa_replace_iocb(sp, pkt);
 		break;
+	case SRB_MARKER:
+		qla_marker_iocb(sp, pkt);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 86928a762a7a..b41d604ca9bc 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1862,9 +1862,9 @@ qla2x00_process_completed_request(struct scsi_qla_host *vha,
 	}
 }
 
-srb_t *
-qla2x00_get_sp_from_handle(scsi_qla_host_t *vha, const char *func,
-    struct req_que *req, void *iocb)
+static srb_t *
+qla_get_sp_from_handle(scsi_qla_host_t *vha, const char *func,
+		       struct req_que *req, void *iocb, u16 *ret_index)
 {
 	struct qla_hw_data *ha = vha->hw;
 	sts_entry_t *pkt = iocb;
@@ -1899,12 +1899,25 @@ qla2x00_get_sp_from_handle(scsi_qla_host_t *vha, const char *func,
 		return NULL;
 	}
 
-	req->outstanding_cmds[index] = NULL;
-
+	*ret_index = index;
 	qla_put_fw_resources(sp->qpair, &sp->iores);
 	return sp;
 }
 
+srb_t *
+qla2x00_get_sp_from_handle(scsi_qla_host_t *vha, const char *func,
+			   struct req_que *req, void *iocb)
+{
+	uint16_t index;
+	srb_t *sp;
+
+	sp = qla_get_sp_from_handle(vha, func, req, iocb, &index);
+	if (sp)
+		req->outstanding_cmds[index] = NULL;
+
+	return sp;
+}
+
 static void
 qla2x00_mbx_iocb_entry(scsi_qla_host_t *vha, struct req_que *req,
     struct mbx_entry *mbx)
@@ -3237,13 +3250,13 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
 		return;
 	}
 
-	req->outstanding_cmds[handle] = NULL;
 	cp = GET_CMD_SP(sp);
 	if (cp == NULL) {
 		ql_dbg(ql_dbg_io, vha, 0x3018,
 		    "Command already returned (0x%x/%p).\n",
 		    sts->handle, sp);
 
+		req->outstanding_cmds[handle] = NULL;
 		return;
 	}
 
@@ -3514,6 +3527,9 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
 
 	if (rsp->status_srb == NULL)
 		sp->done(sp, res);
+
+	/* for io's, clearing of outstanding_cmds[handle] means scsi_done was called */
+	req->outstanding_cmds[handle] = NULL;
 }
 
 /**
@@ -3590,6 +3606,7 @@ qla2x00_error_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, sts_entry_t *pkt)
 	uint16_t que = MSW(pkt->handle);
 	struct req_que *req = NULL;
 	int res = DID_ERROR << 16;
+	u16 index;
 
 	ql_dbg(ql_dbg_async, vha, 0x502a,
 	    "iocb type %xh with error status %xh, handle %xh, rspq id %d\n",
@@ -3608,7 +3625,6 @@ qla2x00_error_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, sts_entry_t *pkt)
 
 	switch (pkt->entry_type) {
 	case NOTIFY_ACK_TYPE:
-	case STATUS_TYPE:
 	case STATUS_CONT_TYPE:
 	case LOGINOUT_PORT_IOCB_TYPE:
 	case CT_IOCB_TYPE:
@@ -3628,6 +3644,14 @@ qla2x00_error_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, sts_entry_t *pkt)
 	case CTIO_TYPE7:
 	case CTIO_CRC2:
 		return 1;
+	case STATUS_TYPE:
+		sp = qla_get_sp_from_handle(vha, func, req, pkt, &index);
+		if (sp) {
+			sp->done(sp, res);
+			req->outstanding_cmds[index] = NULL;
+			return 0;
+		}
+		break;
 	}
 fatal:
 	ql_log(ql_log_warn, vha, 0x5030,
@@ -3750,6 +3774,28 @@ static int qla_chk_cont_iocb_avail(struct scsi_qla_host *vha,
 	return rc;
 }
 
+static void qla_marker_iocb_entry(scsi_qla_host_t *vha, struct req_que *req,
+	struct mrk_entry_24xx *pkt)
+{
+	const char func[] = "MRK-IOCB";
+	srb_t *sp;
+	int res = QLA_SUCCESS;
+
+	if (!IS_FWI2_CAPABLE(vha->hw))
+		return;
+
+	sp = qla2x00_get_sp_from_handle(vha, func, req, pkt);
+	if (!sp)
+		return;
+
+	if (pkt->entry_status) {
+		ql_dbg(ql_dbg_taskm, vha, 0x8025, "marker failure.\n");
+		res = QLA_COMMAND_ERROR;
+	}
+	sp->u.iocb_cmd.u.tmf.data = res;
+	sp->done(sp, res);
+}
+
 /**
  * qla24xx_process_response_queue() - Process response queue entries.
  * @vha: SCSI driver HA context
@@ -3864,9 +3910,7 @@ void qla24xx_process_response_queue(struct scsi_qla_host *vha,
 					(struct nack_to_isp *)pkt);
 			break;
 		case MARKER_TYPE:
-			/* Do nothing in this case, this check is to prevent it
-			 * from falling into default case
-			 */
+			qla_marker_iocb_entry(vha, rsp->req, (struct mrk_entry_24xx *)pkt);
 			break;
 		case ABORT_IOCB_TYPE:
 			qla24xx_abort_iocb_entry(vha, rsp->req,
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index c57e02a35521..57545d5e82b9 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -360,7 +360,6 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
 	if (rval != QLA_SUCCESS) {
 		ql_log(ql_log_warn, vha, 0x700e,
 		    "qla2x00_start_sp failed = %d\n", rval);
-		wake_up(&sp->nvme_ls_waitq);
 		sp->priv = NULL;
 		priv->sp = NULL;
 		qla2x00_rel_sp(sp);
@@ -648,7 +647,6 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 	if (!sp)
 		return -EBUSY;
 
-	init_waitqueue_head(&sp->nvme_ls_waitq);
 	kref_init(&sp->cmd_kref);
 	spin_lock_init(&priv->cmd_lock);
 	sp->priv = priv;
@@ -667,7 +665,6 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 	if (rval != QLA_SUCCESS) {
 		ql_log(ql_log_warn, vha, 0x212d,
 		    "qla2x00_start_nvme_mq failed = %d\n", rval);
-		wake_up(&sp->nvme_ls_waitq);
 		sp->priv = NULL;
 		priv->sp = NULL;
 		qla2xxx_rel_qpair_sp(sp->qpair, sp);
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 08dc825fbf4f..ed70eb884786 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1068,43 +1068,6 @@ qla2xxx_mqueuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd,
 	return 0;
 }
 
-/*
- * qla2x00_eh_wait_on_command
- *    Waits for the command to be returned by the Firmware for some
- *    max time.
- *
- * Input:
- *    cmd = Scsi Command to wait on.
- *
- * Return:
- *    Completed in time : QLA_SUCCESS
- *    Did not complete in time : QLA_FUNCTION_FAILED
- */
-static int
-qla2x00_eh_wait_on_command(struct scsi_cmnd *cmd)
-{
-#define ABORT_POLLING_PERIOD	1000
-#define ABORT_WAIT_ITER		((2 * 1000) / (ABORT_POLLING_PERIOD))
-	unsigned long wait_iter = ABORT_WAIT_ITER;
-	scsi_qla_host_t *vha = shost_priv(cmd->device->host);
-	struct qla_hw_data *ha = vha->hw;
-	srb_t *sp = scsi_cmd_priv(cmd);
-	int ret = QLA_SUCCESS;
-
-	if (unlikely(pci_channel_offline(ha->pdev)) || ha->flags.eeh_busy) {
-		ql_dbg(ql_dbg_taskm, vha, 0x8005,
-		    "Return:eh_wait.\n");
-		return ret;
-	}
-
-	while (sp->type && wait_iter--)
-		msleep(ABORT_POLLING_PERIOD);
-	if (sp->type)
-		ret = QLA_FUNCTION_FAILED;
-
-	return ret;
-}
-
 /*
  * qla2x00_wait_for_hba_online
  *    Wait till the HBA is online after going through
@@ -1355,6 +1318,9 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 	return ret;
 }
 
+#define ABORT_POLLING_PERIOD	1000
+#define ABORT_WAIT_ITER		((2 * 1000) / (ABORT_POLLING_PERIOD))
+
 /*
  * Returns: QLA_SUCCESS or QLA_FUNCTION_FAILED.
  */
@@ -1368,41 +1334,73 @@ __qla2x00_eh_wait_for_pending_commands(struct qla_qpair *qpair, unsigned int t,
 	struct req_que *req = qpair->req;
 	srb_t *sp;
 	struct scsi_cmnd *cmd;
+	unsigned long wait_iter = ABORT_WAIT_ITER;
+	bool found;
+	struct qla_hw_data *ha = vha->hw;
 
 	status = QLA_SUCCESS;
 
-	spin_lock_irqsave(qpair->qp_lock_ptr, flags);
-	for (cnt = 1; status == QLA_SUCCESS &&
-		cnt < req->num_outstanding_cmds; cnt++) {
-		sp = req->outstanding_cmds[cnt];
-		if (!sp)
-			continue;
-		if (sp->type != SRB_SCSI_CMD)
-			continue;
-		if (vha->vp_idx != sp->vha->vp_idx)
-			continue;
-		match = 0;
-		cmd = GET_CMD_SP(sp);
-		switch (type) {
-		case WAIT_HOST:
-			match = 1;
-			break;
-		case WAIT_TARGET:
-			match = cmd->device->id == t;
-			break;
-		case WAIT_LUN:
-			match = (cmd->device->id == t &&
-				cmd->device->lun == l);
-			break;
-		}
-		if (!match)
-			continue;
+	while (wait_iter--) {
+		found = false;
 
-		spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
-		status = qla2x00_eh_wait_on_command(cmd);
 		spin_lock_irqsave(qpair->qp_lock_ptr, flags);
+		for (cnt = 1; cnt < req->num_outstanding_cmds; cnt++) {
+			sp = req->outstanding_cmds[cnt];
+			if (!sp)
+				continue;
+			if (sp->type != SRB_SCSI_CMD)
+				continue;
+			if (vha->vp_idx != sp->vha->vp_idx)
+				continue;
+			match = 0;
+			cmd = GET_CMD_SP(sp);
+			switch (type) {
+			case WAIT_HOST:
+				match = 1;
+				break;
+			case WAIT_TARGET:
+				if (sp->fcport)
+					match = sp->fcport->d_id.b24 == t;
+				else
+					match = 0;
+				break;
+			case WAIT_LUN:
+				if (sp->fcport)
+					match = (sp->fcport->d_id.b24 == t &&
+						cmd->device->lun == l);
+				else
+					match = 0;
+				break;
+			}
+			if (!match)
+				continue;
+
+			spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
+
+			if (unlikely(pci_channel_offline(ha->pdev)) ||
+			    ha->flags.eeh_busy) {
+				ql_dbg(ql_dbg_taskm, vha, 0x8005,
+				    "Return:eh_wait.\n");
+				return status;
+			}
+
+			/*
+			 * SRB_SCSI_CMD is still in the outstanding_cmds array.
+			 * it means scsi_done has not called. Wait for it to
+			 * clear from outstanding_cmds.
+			 */
+			msleep(ABORT_POLLING_PERIOD);
+			spin_lock_irqsave(qpair->qp_lock_ptr, flags);
+			found = true;
+		}
+		spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
+
+		if (!found)
+			break;
 	}
-	spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
+
+	if (wait_iter == -1)
+		status = QLA_FUNCTION_FAILED;
 
 	return status;
 }
@@ -5076,7 +5074,8 @@ struct scsi_qla_host *qla2x00_create_host(struct scsi_host_template *sht,
 	}
 	INIT_DELAYED_WORK(&vha->scan.scan_work, qla_scan_work_fn);
 
-	sprintf(vha->host_str, "%s_%lu", QLA2XXX_DRIVER_NAME, vha->host_no);
+	snprintf(vha->host_str, sizeof(vha->host_str), "%s_%lu",
+		 QLA2XXX_DRIVER_NAME, vha->host_no);
 	ql_dbg(ql_dbg_init, vha, 0x0041,
 	    "Allocated the host=%p hw=%p vha=%p dev_name=%s",
 	    vha->host, vha->hw, vha,
diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 3f11554df2f3..10235b36d131 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -210,6 +210,7 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 	const struct elf32_hdr *ehdr;
 	phys_addr_t min_addr = PHYS_ADDR_MAX;
 	phys_addr_t max_addr = 0;
+	bool relocate = false;
 	size_t metadata_len;
 	void *metadata;
 	int ret;
@@ -224,6 +225,9 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 		if (!mdt_phdr_valid(phdr))
 			continue;
 
+		if (phdr->p_flags & QCOM_MDT_RELOCATABLE)
+			relocate = true;
+
 		if (phdr->p_paddr < min_addr)
 			min_addr = phdr->p_paddr;
 
@@ -246,11 +250,13 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 		goto out;
 	}
 
-	ret = qcom_scm_pas_mem_setup(pas_id, mem_phys, max_addr - min_addr);
-	if (ret) {
-		/* Unable to set up relocation */
-		dev_err(dev, "error %d setting up firmware %s\n", ret, fw_name);
-		goto out;
+	if (relocate) {
+		ret = qcom_scm_pas_mem_setup(pas_id, mem_phys, max_addr - min_addr);
+		if (ret) {
+			/* Unable to set up relocation */
+			dev_err(dev, "error %d setting up firmware %s\n", ret, fw_name);
+			goto out;
+		}
 	}
 
 out:
diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index b2eb3090f4b4..08934d27f709 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -167,7 +167,8 @@ struct qcom_swrm_ctrl {
 	u32 intr_mask;
 	u8 rcmd_id;
 	u8 wcmd_id;
-	struct qcom_swrm_port_config pconfig[QCOM_SDW_MAX_PORTS];
+	/* Port numbers are 1 - 14 */
+	struct qcom_swrm_port_config pconfig[QCOM_SDW_MAX_PORTS + 1];
 	struct sdw_stream_runtime *sruntime[SWRM_MAX_DAIS];
 	enum sdw_slave_status status[SDW_MAX_DEVICES + 1];
 	int (*reg_read)(struct qcom_swrm_ctrl *ctrl, int reg, u32 *val);
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 1e8fe44a7099..eeb7b43ebe53 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -91,7 +91,6 @@ struct serial8250_config {
 #define UART_BUG_TXEN	BIT(1)	/* UART has buggy TX IIR status */
 #define UART_BUG_NOMSR	BIT(2)	/* UART has buggy MSR status bits (Au1x00) */
 #define UART_BUG_THRE	BIT(3)	/* UART has buggy THRE reassertion */
-#define UART_BUG_PARITY	BIT(4)	/* UART mishandles parity if FIFO enabled */
 #define UART_BUG_TXRACE	BIT(5)	/* UART Tx fails to set remote DR */
 
 
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index cd27821f54ec..0ea89df6702f 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1252,14 +1252,6 @@ static int pci_oxsemi_tornado_setup(struct serial_private *priv,
 	return pci_default_setup(priv, board, up, idx);
 }
 
-static int pci_asix_setup(struct serial_private *priv,
-		  const struct pciserial_board *board,
-		  struct uart_8250_port *port, int idx)
-{
-	port->bugs |= UART_BUG_PARITY;
-	return pci_default_setup(priv, board, port, idx);
-}
-
 #define QPCR_TEST_FOR1		0x3F
 #define QPCR_TEST_GET1		0x00
 #define QPCR_TEST_FOR2		0x40
@@ -1975,7 +1967,6 @@ pci_moxa_setup(struct serial_private *priv,
 #define PCI_DEVICE_ID_WCH_CH355_4S	0x7173
 #define PCI_VENDOR_ID_AGESTAR		0x5372
 #define PCI_DEVICE_ID_AGESTAR_9375	0x6872
-#define PCI_VENDOR_ID_ASIX		0x9710
 #define PCI_DEVICE_ID_BROADCOM_TRUMANAGE 0x160a
 #define PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800 0x818e
 
@@ -2620,16 +2611,6 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.exit		= pci_wch_ch38x_exit,
 		.setup          = pci_wch_ch38x_setup,
 	},
-	/*
-	 * ASIX devices with FIFO bug
-	 */
-	{
-		.vendor		= PCI_VENDOR_ID_ASIX,
-		.device		= PCI_ANY_ID,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_asix_setup,
-	},
 	/*
 	 * Broadcom TruManage (NetXtreme)
 	 */
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index b8e8a96c3eb6..acf578aa9930 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2629,11 +2629,8 @@ static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
 
 	if (c_cflag & CSTOPB)
 		cval |= UART_LCR_STOP;
-	if (c_cflag & PARENB) {
+	if (c_cflag & PARENB)
 		cval |= UART_LCR_PARITY;
-		if (up->bugs & UART_BUG_PARITY)
-			up->fifo_bug = true;
-	}
 	if (!(c_cflag & PARODD))
 		cval |= UART_LCR_EPAR;
 	if (c_cflag & CMSPAR)
@@ -2794,8 +2791,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	up->lcr = cval;					/* Save computed LCR */
 
 	if (up->capabilities & UART_CAP_FIFO && port->fifosize > 1) {
-		/* NOTE: If fifo_bug is not set, a user can set RX_trigger. */
-		if ((baud < 2400 && !up->dma) || up->fifo_bug) {
+		if (baud < 2400 && !up->dma) {
 			up->fcr &= ~UART_FCR_TRIGGER_MASK;
 			up->fcr |= UART_FCR_TRIGGER_1;
 		}
@@ -3131,8 +3127,7 @@ static int do_set_rxtrig(struct tty_port *port, unsigned char bytes)
 	struct uart_8250_port *up = up_to_u8250p(uport);
 	int rxtrig;
 
-	if (!(up->capabilities & UART_CAP_FIFO) || uport->fifosize <= 1 ||
-	    up->fifo_bug)
+	if (!(up->capabilities & UART_CAP_FIFO) || uport->fifosize <= 1)
 		return -EINVAL;
 
 	rxtrig = bytes_to_fcr_rxtrig(up, bytes);
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index cff64e5edee2..fbce8ef205ce 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -880,11 +880,11 @@ static void atmel_complete_tx_dma(void *arg)
 
 	port->icount.tx += atmel_port->tx_len;
 
-	spin_lock_irq(&atmel_port->lock_tx);
+	spin_lock(&atmel_port->lock_tx);
 	async_tx_ack(atmel_port->desc_tx);
 	atmel_port->cookie_tx = -EINVAL;
 	atmel_port->desc_tx = NULL;
-	spin_unlock_irq(&atmel_port->lock_tx);
+	spin_unlock(&atmel_port->lock_tx);
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index f07c4f9ff13c..d2137f6eff32 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -397,6 +397,16 @@ static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
        hrtimer_start(hrt, ms_to_ktime(msec), HRTIMER_MODE_REL);
 }
 
+static void imx_uart_disable_loopback_rs485(struct imx_port *sport)
+{
+	unsigned int uts;
+
+	/* See SER_RS485_ENABLED/UTS_LOOP comment in imx_uart_probe() */
+	uts = imx_uart_readl(sport, imx_uart_uts_reg(sport));
+	uts &= ~UTS_LOOP;
+	imx_uart_writel(sport, uts, imx_uart_uts_reg(sport));
+}
+
 /* called with port.lock taken and irqs off */
 static void imx_uart_start_rx(struct uart_port *port)
 {
@@ -418,6 +428,7 @@ static void imx_uart_start_rx(struct uart_port *port)
 	/* Write UCR2 first as it includes RXEN */
 	imx_uart_writel(sport, ucr2, UCR2);
 	imx_uart_writel(sport, ucr1, UCR1);
+	imx_uart_disable_loopback_rs485(sport);
 }
 
 /* called with port.lock taken and irqs off */
@@ -1404,7 +1415,7 @@ static int imx_uart_startup(struct uart_port *port)
 	int retval, i;
 	unsigned long flags;
 	int dma_is_inited = 0;
-	u32 ucr1, ucr2, ucr3, ucr4, uts;
+	u32 ucr1, ucr2, ucr3, ucr4;
 
 	retval = clk_prepare_enable(sport->clk_per);
 	if (retval)
@@ -1509,10 +1520,7 @@ static int imx_uart_startup(struct uart_port *port)
 		imx_uart_writel(sport, ucr2, UCR2);
 	}
 
-	/* See SER_RS485_ENABLED/UTS_LOOP comment in imx_uart_probe() */
-	uts = imx_uart_readl(sport, imx_uart_uts_reg(sport));
-	uts &= ~UTS_LOOP;
-	imx_uart_writel(sport, uts, imx_uart_uts_reg(sport));
+	imx_uart_disable_loopback_rs485(sport);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 77d1363029f5..aa2c51b84116 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1467,8 +1467,12 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
 			continue;
 
 		rate = clk_get_rate(clk);
-		if (!rate)
+		if (!rate) {
+			dev_err(ourport->port.dev,
+				"Failed to get clock rate for %s.\n", clkname);
+			clk_put(clk);
 			continue;
+		}
 
 		if (ourport->info->has_divslot) {
 			unsigned long div = rate / req_baud;
@@ -1494,10 +1498,18 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
 			calc_deviation = -calc_deviation;
 
 		if (calc_deviation < deviation) {
+			/*
+			 * If we find a better clk, release the previous one, if
+			 * any.
+			 */
+			if (!IS_ERR(*best_clk))
+				clk_put(*best_clk);
 			*best_clk = clk;
 			best_quot = quot;
 			*clk_num = cnt;
 			deviation = calc_deviation;
+		} else {
+			clk_put(clk);
 		}
 	}
 
diff --git a/drivers/ufs/host/Kconfig b/drivers/ufs/host/Kconfig
index 4cc2dbd79ed0..9b39fd76031b 100644
--- a/drivers/ufs/host/Kconfig
+++ b/drivers/ufs/host/Kconfig
@@ -71,6 +71,7 @@ config SCSI_UFS_QCOM
 config SCSI_UFS_MEDIATEK
 	tristate "Mediatek specific hooks to UFS controller platform driver"
 	depends on SCSI_UFSHCD_PLATFORM && ARCH_MEDIATEK
+	depends on RESET_CONTROLLER
 	select PHY_MTK_UFS
 	select RESET_TI_SYSCON
 	help
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 81ca2bc1f0be..019dcbe55dbd 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2116,7 +2116,7 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 {
 	u32 temp, port_offset, port_count;
 	int i;
-	u8 major_revision, minor_revision;
+	u8 major_revision, minor_revision, tmp_minor_revision;
 	struct xhci_hub *rhub;
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	struct xhci_port_cap *port_cap;
@@ -2136,6 +2136,15 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 		 */
 		if (minor_revision > 0x00 && minor_revision < 0x10)
 			minor_revision <<= 4;
+		/*
+		 * Some zhaoxin's xHCI controller that follow usb3.1 spec
+		 * but only support Gen1.
+		 */
+		if (xhci->quirks & XHCI_ZHAOXIN_HOST) {
+			tmp_minor_revision = minor_revision;
+			minor_revision = 0;
+		}
+
 	} else if (major_revision <= 0x02) {
 		rhub = &xhci->usb2_rhub;
 	} else {
@@ -2145,10 +2154,6 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 		/* Ignoring port protocol we can't understand. FIXME */
 		return;
 	}
-	rhub->maj_rev = XHCI_EXT_PORT_MAJOR(temp);
-
-	if (rhub->min_rev < minor_revision)
-		rhub->min_rev = minor_revision;
 
 	/* Port offset and count in the third dword, see section 7.2 */
 	temp = readl(addr + 2);
@@ -2167,8 +2172,6 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 	if (xhci->num_port_caps > max_caps)
 		return;
 
-	port_cap->maj_rev = major_revision;
-	port_cap->min_rev = minor_revision;
 	port_cap->psi_count = XHCI_EXT_PORT_PSIC(temp);
 
 	if (port_cap->psi_count) {
@@ -2189,6 +2192,11 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 				  XHCI_EXT_PORT_PSIV(port_cap->psi[i - 1])))
 				port_cap->psi_uid_count++;
 
+			if (xhci->quirks & XHCI_ZHAOXIN_HOST &&
+			    major_revision == 0x03 &&
+			    XHCI_EXT_PORT_PSIV(port_cap->psi[i]) >= 5)
+				minor_revision = tmp_minor_revision;
+
 			xhci_dbg(xhci, "PSIV:%d PSIE:%d PLT:%d PFD:%d LP:%d PSIM:%d\n",
 				  XHCI_EXT_PORT_PSIV(port_cap->psi[i]),
 				  XHCI_EXT_PORT_PSIE(port_cap->psi[i]),
@@ -2198,6 +2206,15 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 				  XHCI_EXT_PORT_PSIM(port_cap->psi[i]));
 		}
 	}
+
+	rhub->maj_rev = major_revision;
+
+	if (rhub->min_rev < minor_revision)
+		rhub->min_rev = minor_revision;
+
+	port_cap->maj_rev = major_revision;
+	port_cap->min_rev = minor_revision;
+
 	/* cache usb2 port capabilities */
 	if (major_revision < 0x03 && xhci->num_ext_caps < max_caps)
 		xhci->ext_caps[xhci->num_ext_caps++] = temp;
@@ -2439,8 +2456,12 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 	 * and our use of dma addresses in the trb_address_map radix tree needs
 	 * TRB_SEGMENT_SIZE alignment, so we pick the greater alignment need.
 	 */
-	xhci->segment_pool = dma_pool_create("xHCI ring segments", dev,
-			TRB_SEGMENT_SIZE, TRB_SEGMENT_SIZE, xhci->page_size);
+	if (xhci->quirks & XHCI_ZHAOXIN_TRB_FETCH)
+		xhci->segment_pool = dma_pool_create("xHCI ring segments", dev,
+				TRB_SEGMENT_SIZE * 2, TRB_SEGMENT_SIZE * 2, xhci->page_size * 2);
+	else
+		xhci->segment_pool = dma_pool_create("xHCI ring segments", dev,
+				TRB_SEGMENT_SIZE, TRB_SEGMENT_SIZE, xhci->page_size);
 
 	/* See Table 46 and Note on Figure 55 */
 	xhci->device_pool = dma_pool_create("xHCI input/output contexts", dev,
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 6e4dac71c409..5e72d02042ce 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -335,6 +335,18 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	     pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_4))
 		xhci->quirks |= XHCI_NO_SOFT_RETRY;
 
+	if (pdev->vendor == PCI_VENDOR_ID_ZHAOXIN) {
+		xhci->quirks |= XHCI_ZHAOXIN_HOST;
+
+		if (pdev->device == 0x9202) {
+			xhci->quirks |= XHCI_RESET_ON_RESUME;
+			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
+		}
+
+		if (pdev->device == 0x9203)
+			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
+	}
+
 	/* xHC spec requires PCI devices to support D3hot and D3cold */
 	if (xhci->hci_version >= 0x120)
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 6348cacdc65e..1354310cb37b 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1899,6 +1899,8 @@ struct xhci_hcd {
 #define XHCI_EP_CTX_BROKEN_DCS	BIT_ULL(42)
 #define XHCI_SUSPEND_RESUME_CLKS	BIT_ULL(43)
 #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
+#define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
+#define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 478c03bfba66..dd2ce7fabbae 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -187,16 +187,42 @@ static void ceph_netfs_expand_readahead(struct netfs_io_request *rreq)
 	struct inode *inode = rreq->inode;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_file_layout *lo = &ci->i_layout;
+	unsigned long max_pages = inode->i_sb->s_bdi->ra_pages;
+	loff_t end = rreq->start + rreq->len, new_end;
+	struct ceph_netfs_request_data *priv = rreq->netfs_priv;
+	unsigned long max_len;
 	u32 blockoff;
-	u64 blockno;
 
-	/* Expand the start downward */
-	blockno = div_u64_rem(rreq->start, lo->stripe_unit, &blockoff);
-	rreq->start = blockno * lo->stripe_unit;
-	rreq->len += blockoff;
+	if (priv) {
+		/* Readahead is disabled by posix_fadvise POSIX_FADV_RANDOM */
+		if (priv->file_ra_disabled)
+			max_pages = 0;
+		else
+			max_pages = priv->file_ra_pages;
+
+	}
 
-	/* Now, round up the length to the next block */
-	rreq->len = roundup(rreq->len, lo->stripe_unit);
+	/* Readahead is disabled */
+	if (!max_pages)
+		return;
+
+	max_len = max_pages << PAGE_SHIFT;
+
+	/*
+	 * Try to expand the length forward by rounding up it to the next
+	 * block, but do not exceed the file size, unless the original
+	 * request already exceeds it.
+	 */
+	new_end = min(round_up(end, lo->stripe_unit), rreq->i_size);
+	if (new_end > end && new_end <= rreq->start + max_len)
+		rreq->len = new_end - rreq->start;
+
+	/* Try to expand the start downward */
+	div_u64_rem(rreq->start, lo->stripe_unit, &blockoff);
+	if (rreq->len + blockoff <= max_len) {
+		rreq->start -= blockoff;
+		rreq->len += blockoff;
+	}
 }
 
 static bool ceph_netfs_clamp_length(struct netfs_io_subrequest *subreq)
@@ -362,18 +388,28 @@ static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
 {
 	struct inode *inode = rreq->inode;
 	int got = 0, want = CEPH_CAP_FILE_CACHE;
+	struct ceph_netfs_request_data *priv;
 	int ret = 0;
 
 	if (rreq->origin != NETFS_READAHEAD)
 		return 0;
 
+	priv = kzalloc(sizeof(*priv), GFP_NOFS);
+	if (!priv)
+		return -ENOMEM;
+
 	if (file) {
 		struct ceph_rw_context *rw_ctx;
 		struct ceph_file_info *fi = file->private_data;
 
+		priv->file_ra_pages = file->f_ra.ra_pages;
+		priv->file_ra_disabled = file->f_mode & FMODE_RANDOM;
+
 		rw_ctx = ceph_find_rw_context(fi);
-		if (rw_ctx)
+		if (rw_ctx) {
+			rreq->netfs_priv = priv;
 			return 0;
+		}
 	}
 
 	/*
@@ -383,27 +419,40 @@ static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
 	ret = ceph_try_get_caps(inode, CEPH_CAP_FILE_RD, want, true, &got);
 	if (ret < 0) {
 		dout("start_read %p, error getting cap\n", inode);
-		return ret;
+		goto out;
 	}
 
 	if (!(got & want)) {
 		dout("start_read %p, no cache cap\n", inode);
-		return -EACCES;
+		ret = -EACCES;
+		goto out;
+	}
+	if (ret == 0) {
+		ret = -EACCES;
+		goto out;
 	}
-	if (ret == 0)
-		return -EACCES;
 
-	rreq->netfs_priv = (void *)(uintptr_t)got;
-	return 0;
+	priv->caps = got;
+	rreq->netfs_priv = priv;
+
+out:
+	if (ret < 0)
+		kfree(priv);
+
+	return ret;
 }
 
 static void ceph_netfs_free_request(struct netfs_io_request *rreq)
 {
-	struct ceph_inode_info *ci = ceph_inode(rreq->inode);
-	int got = (uintptr_t)rreq->netfs_priv;
+	struct ceph_netfs_request_data *priv = rreq->netfs_priv;
+
+	if (!priv)
+		return;
 
-	if (got)
-		ceph_put_cap_refs(ci, got);
+	if (priv->caps)
+		ceph_put_cap_refs(ceph_inode(rreq->inode), priv->caps);
+	kfree(priv);
+	rreq->netfs_priv = NULL;
 }
 
 const struct netfs_request_ops ceph_netfs_ops = {
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index cdb26aadae12..4a9ad5ff726d 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3561,6 +3561,15 @@ static void handle_cap_grant(struct inode *inode,
 	}
 	BUG_ON(cap->issued & ~cap->implemented);
 
+	/* don't let check_caps skip sending a response to MDS for revoke msgs */
+	if (le32_to_cpu(grant->op) == CEPH_CAP_OP_REVOKE) {
+		cap->mds_wanted = 0;
+		if (cap == ci->i_auth_cap)
+			check_caps = 1; /* check auth cap only */
+		else
+			check_caps = 2; /* check all caps */
+	}
+
 	if (extra_info->inline_version > 0 &&
 	    extra_info->inline_version >= ci->i_inline_version) {
 		ci->i_inline_version = extra_info->inline_version;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 478b741b1107..562f42f4a77d 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -451,6 +451,19 @@ struct ceph_inode_info {
 	unsigned long  i_work_mask;
 };
 
+struct ceph_netfs_request_data {
+	int caps;
+
+	/*
+	 * Maximum size of a file readahead request.
+	 * The fadvise could update the bdi's default ra_pages.
+	 */
+	unsigned int file_ra_pages;
+
+	/* Set it if fadvise disables file readahead entirely */
+	bool file_ra_disabled;
+};
+
 static inline struct ceph_inode_info *
 ceph_inode(const struct inode *inode)
 {
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 7b29ea7bfb41..23cf9b8f31b7 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -958,15 +958,3 @@ void dlm_stop_lockspaces(void)
 		log_print("dlm user daemon left %d lockspaces", count);
 }
 
-void dlm_stop_lockspaces_check(void)
-{
-	struct dlm_ls *ls;
-
-	spin_lock(&lslist_lock);
-	list_for_each_entry(ls, &lslist, ls_list) {
-		if (WARN_ON(!rwsem_is_locked(&ls->ls_in_recovery) ||
-			    !dlm_locking_stopped(ls)))
-			break;
-	}
-	spin_unlock(&lslist_lock);
-}
diff --git a/fs/dlm/lockspace.h b/fs/dlm/lockspace.h
index 03f4a4a3a871..47ebd4411926 100644
--- a/fs/dlm/lockspace.h
+++ b/fs/dlm/lockspace.h
@@ -27,7 +27,6 @@ struct dlm_ls *dlm_find_lockspace_local(void *id);
 struct dlm_ls *dlm_find_lockspace_device(int minor);
 void dlm_put_lockspace(struct dlm_ls *ls);
 void dlm_stop_lockspaces(void);
-void dlm_stop_lockspaces_check(void);
 int dlm_new_user_lockspace(const char *name, const char *cluster,
 			   uint32_t flags, int lvblen,
 			   const struct dlm_lockspace_ops *ops,
diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index b2a25a33a148..71e426da48c3 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -136,7 +136,6 @@
 #include <net/tcp.h>
 
 #include "dlm_internal.h"
-#include "lockspace.h"
 #include "lowcomms.h"
 #include "config.h"
 #include "memory.h"
@@ -1458,8 +1457,6 @@ int dlm_midcomms_close(int nodeid)
 	if (nodeid == dlm_our_nodeid())
 		return 0;
 
-	dlm_stop_lockspaces_check();
-
 	idx = srcu_read_lock(&nodes_srcu);
 	/* Abort pending close/remove operation */
 	node = nodeid2node(nodeid, 0);
diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index 737f185aad8d..739e7d55c9e3 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -29,8 +29,6 @@ struct plock_async_data {
 struct plock_op {
 	struct list_head list;
 	int done;
-	/* if lock op got interrupted while waiting dlm_controld reply */
-	bool sigint;
 	struct dlm_plock_info info;
 	/* if set indicates async handling */
 	struct plock_async_data *data;
@@ -156,23 +154,29 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 
 	send_op(op);
 
-	rv = wait_event_interruptible(recv_wq, (op->done != 0));
-	if (rv == -ERESTARTSYS) {
-		spin_lock(&ops_lock);
-		/* recheck under ops_lock if we got a done != 0,
-		 * if so this interrupt case should be ignored
-		 */
-		if (op->done != 0) {
+	if (op->info.wait) {
+		rv = wait_event_killable(recv_wq, (op->done != 0));
+		if (rv == -ERESTARTSYS) {
+			spin_lock(&ops_lock);
+			/* recheck under ops_lock if we got a done != 0,
+			 * if so this interrupt case should be ignored
+			 */
+			if (op->done != 0) {
+				spin_unlock(&ops_lock);
+				goto do_lock_wait;
+			}
+			list_del(&op->list);
 			spin_unlock(&ops_lock);
-			goto do_lock_wait;
-		}
 
-		op->sigint = true;
-		spin_unlock(&ops_lock);
-		log_debug(ls, "%s: wait interrupted %x %llx pid %d",
-			  __func__, ls->ls_global_id,
-			  (unsigned long long)number, op->info.pid);
-		goto out;
+			log_debug(ls, "%s: wait interrupted %x %llx pid %d",
+				  __func__, ls->ls_global_id,
+				  (unsigned long long)number, op->info.pid);
+			do_unlock_close(&op->info);
+			dlm_release_plock_op(op);
+			goto out;
+		}
+	} else {
+		wait_event(recv_wq, (op->done != 0));
 	}
 
 do_lock_wait:
@@ -359,7 +363,9 @@ int dlm_posix_get(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		locks_init_lock(fl);
 		fl->fl_type = (op->info.ex) ? F_WRLCK : F_RDLCK;
 		fl->fl_flags = FL_POSIX;
-		fl->fl_pid = -op->info.pid;
+		fl->fl_pid = op->info.pid;
+		if (op->info.nodeid != dlm_our_nodeid())
+			fl->fl_pid = -fl->fl_pid;
 		fl->fl_start = op->info.start;
 		fl->fl_end = op->info.end;
 		rv = 0;
@@ -388,7 +394,7 @@ static ssize_t dev_read(struct file *file, char __user *u, size_t count,
 		if (op->info.flags & DLM_PLOCK_FL_CLOSE)
 			list_del(&op->list);
 		else
-			list_move(&op->list, &recv_list);
+			list_move_tail(&op->list, &recv_list);
 		memcpy(&info, &op->info, sizeof(info));
 	}
 	spin_unlock(&ops_lock);
@@ -426,34 +432,53 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 	if (check_version(&info))
 		return -EINVAL;
 
+	/*
+	 * The results for waiting ops (SETLKW) can be returned in any
+	 * order, so match all fields to find the op.  The results for
+	 * non-waiting ops are returned in the order that they were sent
+	 * to userspace, so match the result with the first non-waiting op.
+	 */
 	spin_lock(&ops_lock);
-	list_for_each_entry(iter, &recv_list, list) {
-		if (iter->info.fsid == info.fsid &&
-		    iter->info.number == info.number &&
-		    iter->info.owner == info.owner) {
-			if (iter->sigint) {
-				list_del(&iter->list);
-				spin_unlock(&ops_lock);
-
-				pr_debug("%s: sigint cleanup %x %llx pid %d",
-					  __func__, iter->info.fsid,
-					  (unsigned long long)iter->info.number,
-					  iter->info.pid);
-				do_unlock_close(&iter->info);
-				memcpy(&iter->info, &info, sizeof(info));
-				dlm_release_plock_op(iter);
-				return count;
+	if (info.wait) {
+		list_for_each_entry(iter, &recv_list, list) {
+			if (iter->info.fsid == info.fsid &&
+			    iter->info.number == info.number &&
+			    iter->info.owner == info.owner &&
+			    iter->info.pid == info.pid &&
+			    iter->info.start == info.start &&
+			    iter->info.end == info.end &&
+			    iter->info.ex == info.ex &&
+			    iter->info.wait) {
+				op = iter;
+				break;
+			}
+		}
+	} else {
+		list_for_each_entry(iter, &recv_list, list) {
+			if (!iter->info.wait) {
+				op = iter;
+				break;
 			}
-			list_del_init(&iter->list);
-			memcpy(&iter->info, &info, sizeof(info));
-			if (iter->data)
-				do_callback = 1;
-			else
-				iter->done = 1;
-			op = iter;
-			break;
 		}
 	}
+
+	if (op) {
+		/* Sanity check that op and info match. */
+		if (info.wait)
+			WARN_ON(op->info.optype != DLM_PLOCK_OP_LOCK);
+		else
+			WARN_ON(op->info.fsid != info.fsid ||
+				op->info.number != info.number ||
+				op->info.owner != info.owner ||
+				op->info.optype != info.optype);
+
+		list_del_init(&op->list);
+		memcpy(&op->info, &info, sizeof(info));
+		if (op->data)
+			do_callback = 1;
+		else
+			op->done = 1;
+	}
 	spin_unlock(&ops_lock);
 
 	if (op) {
@@ -462,8 +487,8 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 		else
 			wake_up(&recv_wq);
 	} else
-		log_print("%s: no op %x %llx", __func__,
-			  info.fsid, (unsigned long long)info.number);
+		pr_debug("%s: no op %x %llx", __func__,
+			 info.fsid, (unsigned long long)info.number);
 	return count;
 }
 
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 5aadc73d5765..e090bcd46db1 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -186,7 +186,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 
 	inode->i_flags &= ~S_DAX;
 	if (test_opt(&sbi->opt, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
-	    vi->datalayout == EROFS_INODE_FLAT_PLAIN)
+	    (vi->datalayout == EROFS_INODE_FLAT_PLAIN ||
+	     vi->datalayout == EROFS_INODE_CHUNK_BASED))
 		inode->i_flags |= S_DAX;
 	if (!nblks)
 		/* measure inode.i_blocks as generic filesystems */
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 92b2e4ddb7ce..533e612b6a48 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -866,7 +866,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	 */
 	tight &= (fe->mode > Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE);
 
-	cur = end - min_t(unsigned int, offset + end - map->m_la, end);
+	cur = end - min_t(erofs_off_t, offset + end - map->m_la, end);
 	if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 		zero_user_segment(page, cur, end);
 		goto next_part;
@@ -1660,7 +1660,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 	}
 
 	cur = map->m_la + map->m_llen - 1;
-	while (cur >= end) {
+	while ((cur >= end) && (cur < i_size_read(inode))) {
 		pgoff_t index = cur >> PAGE_SHIFT;
 		struct page *page;
 
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 918ab2f9e4c0..5a32fcd55183 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1265,9 +1265,8 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
 	inode_dio_wait(inode);
 
 	if (IS_DAX(inode))
-		error = dax_zero_range(inode, newsize,
-				       PAGE_ALIGN(newsize) - newsize, NULL,
-				       &ext2_iomap_ops);
+		error = dax_truncate_page(inode, newsize, NULL,
+					  &ext2_iomap_ops);
 	else
 		error = block_truncate_page(inode->i_mapping,
 				newsize, ext2_get_block);
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index c68bebe7ff4b..a9f3716119d3 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -651,6 +651,14 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 	count = ar.len;
+
+	/*
+	 * Update reserved blocks/metadata blocks after successful block
+	 * allocation which had been deferred till now.
+	 */
+	if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
+		ext4_da_update_reserve_space(inode, count, 1);
+
 got_it:
 	map->m_flags |= EXT4_MAP_MAPPED;
 	map->m_pblk = le32_to_cpu(chain[depth-1].key);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 80d5a859ab14..5aa3003cfc68 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -660,16 +660,6 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			 */
 			ext4_clear_inode_state(inode, EXT4_STATE_EXT_MIGRATE);
 		}
-
-		/*
-		 * Update reserved blocks/metadata blocks after successful
-		 * block allocation which had been deferred till now. We don't
-		 * support fallocate for non extent files. So we can update
-		 * reserve space here.
-		 */
-		if ((retval > 0) &&
-			(flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE))
-			ext4_da_update_reserve_space(inode, retval, 1);
 	}
 
 	if (retval > 0) {
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 8c2b1ff5e695..3784f7041649 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -800,6 +800,7 @@ static int ext4_shutdown(struct super_block *sb, unsigned long arg)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	__u32 flags;
+	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -818,7 +819,9 @@ static int ext4_shutdown(struct super_block *sb, unsigned long arg)
 
 	switch (flags) {
 	case EXT4_GOING_FLAGS_DEFAULT:
-		freeze_bdev(sb->s_bdev);
+		ret = freeze_bdev(sb->s_bdev);
+		if (ret)
+			return ret;
 		set_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
 		thaw_bdev(sb->s_bdev);
 		break;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 32d88757a780..88ed64ebae3e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6073,8 +6073,8 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 		 * them with group lock_held
 		 */
 		if (test_opt(sb, DISCARD)) {
-			err = ext4_issue_discard(sb, block_group, bit, count,
-						 NULL);
+			err = ext4_issue_discard(sb, block_group, bit,
+						 count_clusters, NULL);
 			if (err && err != -EOPNOTSUPP)
 				ext4_msg(sb, KERN_WARNING, "discard request in"
 					 " group:%u block:%d count:%lu failed"
@@ -6158,12 +6158,6 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 
 	sbi = EXT4_SB(sb);
 
-	if (sbi->s_mount_state & EXT4_FC_REPLAY) {
-		ext4_free_blocks_simple(inode, block, count);
-		return;
-	}
-
-	might_sleep();
 	if (bh) {
 		if (block)
 			BUG_ON(block != bh->b_blocknr);
@@ -6171,6 +6165,13 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 			block = bh->b_blocknr;
 	}
 
+	if (sbi->s_mount_state & EXT4_FC_REPLAY) {
+		ext4_free_blocks_simple(inode, block, EXT4_NUM_B2C(sbi, count));
+		return;
+	}
+
+	might_sleep();
+
 	if (!(flags & EXT4_FREE_BLOCKS_VALIDATED) &&
 	    !ext4_inode_block_valid(inode, block, count)) {
 		ext4_error(sb, "Freeing blocks not in datazone - "
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 760249d9152d..601e097e1720 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1129,6 +1129,12 @@ static void ext4_blkdev_remove(struct ext4_sb_info *sbi)
 	struct block_device *bdev;
 	bdev = sbi->s_journal_bdev;
 	if (bdev) {
+		/*
+		 * Invalidate the journal device's buffers.  We don't want them
+		 * floating about in memory - the physical journal device may
+		 * hotswapped, and it breaks the `ro-after' testing code.
+		 */
+		invalidate_bdev(bdev);
 		ext4_blkdev_put(bdev);
 		sbi->s_journal_bdev = NULL;
 	}
@@ -1274,13 +1280,7 @@ static void ext4_put_super(struct super_block *sb)
 	sync_blockdev(sb->s_bdev);
 	invalidate_bdev(sb->s_bdev);
 	if (sbi->s_journal_bdev && sbi->s_journal_bdev != sb->s_bdev) {
-		/*
-		 * Invalidate the journal device's buffers.  We don't want them
-		 * floating about in memory - the physical journal device may
-		 * hotswapped, and it breaks the `ro-after' testing code.
-		 */
 		sync_blockdev(sbi->s_journal_bdev);
-		invalidate_bdev(sbi->s_journal_bdev);
 		ext4_blkdev_remove(sbi);
 	}
 
@@ -5544,7 +5544,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		ext4_msg(sb, KERN_INFO, "recovery complete");
 		err = ext4_mark_recovery_complete(sb, es);
 		if (err)
-			goto failed_mount9;
+			goto failed_mount10;
 	}
 
 	if (test_opt(sb, DISCARD) && !bdev_max_discard_sectors(sb->s_bdev))
@@ -5563,7 +5563,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 
 	return 0;
 
-failed_mount9:
+failed_mount10:
+	ext4_quota_off_umount(sb);
+failed_mount9: __maybe_unused
 	ext4_release_orphan_info(sb);
 failed_mount8:
 	ext4_unregister_sysfs(sb);
@@ -5634,6 +5636,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	brelse(sbi->s_sbh);
 	ext4_blkdev_remove(sbi);
 out_fail:
+	invalidate_bdev(sb->s_bdev);
 	sb->s_fs_info = NULL;
 	return err ? err : ret;
 }
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index e50d5848c100..fb75ff7b3448 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -764,7 +764,7 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
 		ret = -EFSCORRUPTED;
 
 		/* Avoid f2fs_commit_super in irq context */
-		if (in_task)
+		if (!in_task)
 			f2fs_save_errors(sbi, ERROR_FAIL_DECOMPRESSION);
 		else
 			f2fs_handle_error(sbi, ERROR_FAIL_DECOMPRESSION);
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 21960a899b6a..bf5ba75b75d2 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -806,8 +806,15 @@ int f2fs_add_dentry(struct inode *dir, const struct f2fs_filename *fname,
 {
 	int err = -EAGAIN;
 
-	if (f2fs_has_inline_dentry(dir))
+	if (f2fs_has_inline_dentry(dir)) {
+		/*
+		 * Should get i_xattr_sem to keep the lock order:
+		 * i_xattr_sem -> inode_page lock used by f2fs_setxattr.
+		 */
+		f2fs_down_read(&F2FS_I(dir)->i_xattr_sem);
 		err = f2fs_add_inline_entry(dir, fname, inode, ino, mode);
+		f2fs_up_read(&F2FS_I(dir)->i_xattr_sem);
+	}
 	if (err == -EAGAIN)
 		err = f2fs_add_regular_entry(dir, fname, inode, ino, mode);
 
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index dc2e8637189e..db3b641f2158 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -527,10 +527,12 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 	if (len > F2FS_NAME_LEN)
 		return -ERANGE;
 
-	f2fs_down_read(&F2FS_I(inode)->i_xattr_sem);
+	if (!ipage)
+		f2fs_down_read(&F2FS_I(inode)->i_xattr_sem);
 	error = lookup_all_xattrs(inode, ipage, index, len, name,
 				&entry, &base_addr, &base_size, &is_inline);
-	f2fs_up_read(&F2FS_I(inode)->i_xattr_sem);
+	if (!ipage)
+		f2fs_up_read(&F2FS_I(inode)->i_xattr_sem);
 	if (error)
 		return error;
 
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index a3eb1e826947..da6a2bc6bf02 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -178,7 +178,13 @@ int dbMount(struct inode *ipbmap)
 	dbmp_le = (struct dbmap_disk *) mp->data;
 	bmp->db_mapsize = le64_to_cpu(dbmp_le->dn_mapsize);
 	bmp->db_nfree = le64_to_cpu(dbmp_le->dn_nfree);
+
 	bmp->db_l2nbperpage = le32_to_cpu(dbmp_le->dn_l2nbperpage);
+	if (bmp->db_l2nbperpage > L2PSIZE - L2MINBLOCKSIZE) {
+		err = -EINVAL;
+		goto err_release_metapage;
+	}
+
 	bmp->db_numag = le32_to_cpu(dbmp_le->dn_numag);
 	if (!bmp->db_numag) {
 		err = -EINVAL;
diff --git a/fs/jfs/jfs_filsys.h b/fs/jfs/jfs_filsys.h
index b5d702df7111..33ef13a0b110 100644
--- a/fs/jfs/jfs_filsys.h
+++ b/fs/jfs/jfs_filsys.h
@@ -122,7 +122,9 @@
 #define NUM_INODE_PER_IAG	INOSPERIAG
 
 #define MINBLOCKSIZE		512
+#define L2MINBLOCKSIZE		9
 #define MAXBLOCKSIZE		4096
+#define L2MAXBLOCKSIZE		12
 #define	MAXFILESIZE		((s64)1 << 52)
 
 #define JFS_LINK_MAX		0xffffffff
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 98491abf95b9..9e9a9ffd9295 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -605,11 +605,58 @@ static const struct NTFS_DE *hdr_insert_head(struct INDEX_HDR *hdr,
 	return e;
 }
 
+/*
+ * index_hdr_check
+ *
+ * return true if INDEX_HDR is valid
+ */
+static bool index_hdr_check(const struct INDEX_HDR *hdr, u32 bytes)
+{
+	u32 end = le32_to_cpu(hdr->used);
+	u32 tot = le32_to_cpu(hdr->total);
+	u32 off = le32_to_cpu(hdr->de_off);
+
+	if (!IS_ALIGNED(off, 8) || tot > bytes || end > tot ||
+	    off + sizeof(struct NTFS_DE) > end) {
+		/* incorrect index buffer. */
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * index_buf_check
+ *
+ * return true if INDEX_BUFFER seems is valid
+ */
+static bool index_buf_check(const struct INDEX_BUFFER *ib, u32 bytes,
+			    const CLST *vbn)
+{
+	const struct NTFS_RECORD_HEADER *rhdr = &ib->rhdr;
+	u16 fo = le16_to_cpu(rhdr->fix_off);
+	u16 fn = le16_to_cpu(rhdr->fix_num);
+
+	if (bytes <= offsetof(struct INDEX_BUFFER, ihdr) ||
+	    rhdr->sign != NTFS_INDX_SIGNATURE ||
+	    fo < sizeof(struct INDEX_BUFFER)
+	    /* Check index buffer vbn. */
+	    || (vbn && *vbn != le64_to_cpu(ib->vbn)) || (fo % sizeof(short)) ||
+	    fo + fn * sizeof(short) >= bytes ||
+	    fn != ((bytes >> SECTOR_SHIFT) + 1)) {
+		/* incorrect index buffer. */
+		return false;
+	}
+
+	return index_hdr_check(&ib->ihdr,
+			       bytes - offsetof(struct INDEX_BUFFER, ihdr));
+}
+
 void fnd_clear(struct ntfs_fnd *fnd)
 {
 	int i;
 
-	for (i = 0; i < fnd->level; i++) {
+	for (i = fnd->level - 1; i >= 0; i--) {
 		struct indx_node *n = fnd->nodes[i];
 
 		if (!n)
@@ -828,9 +875,16 @@ int indx_init(struct ntfs_index *indx, struct ntfs_sb_info *sbi,
 	u32 t32;
 	const struct INDEX_ROOT *root = resident_data(attr);
 
+	t32 = le32_to_cpu(attr->res.data_size);
+	if (t32 <= offsetof(struct INDEX_ROOT, ihdr) ||
+	    !index_hdr_check(&root->ihdr,
+			     t32 - offsetof(struct INDEX_ROOT, ihdr))) {
+		goto out;
+	}
+
 	/* Check root fields. */
 	if (!root->index_block_clst)
-		return -EINVAL;
+		goto out;
 
 	indx->type = type;
 	indx->idx2vbn_bits = __ffs(root->index_block_clst);
@@ -842,19 +896,19 @@ int indx_init(struct ntfs_index *indx, struct ntfs_sb_info *sbi,
 	if (t32 < sbi->cluster_size) {
 		/* Index record is smaller than a cluster, use 512 blocks. */
 		if (t32 != root->index_block_clst * SECTOR_SIZE)
-			return -EINVAL;
+			goto out;
 
 		/* Check alignment to a cluster. */
 		if ((sbi->cluster_size >> SECTOR_SHIFT) &
 		    (root->index_block_clst - 1)) {
-			return -EINVAL;
+			goto out;
 		}
 
 		indx->vbn2vbo_bits = SECTOR_SHIFT;
 	} else {
 		/* Index record must be a multiple of cluster size. */
 		if (t32 != root->index_block_clst << sbi->cluster_bits)
-			return -EINVAL;
+			goto out;
 
 		indx->vbn2vbo_bits = sbi->cluster_bits;
 	}
@@ -862,7 +916,14 @@ int indx_init(struct ntfs_index *indx, struct ntfs_sb_info *sbi,
 	init_rwsem(&indx->run_lock);
 
 	indx->cmp = get_cmp_func(root);
-	return indx->cmp ? 0 : -EINVAL;
+	if (!indx->cmp)
+		goto out;
+
+	return 0;
+
+out:
+	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
+	return -EINVAL;
 }
 
 static struct indx_node *indx_new(struct ntfs_index *indx,
@@ -1020,6 +1081,13 @@ int indx_read(struct ntfs_index *indx, struct ntfs_inode *ni, CLST vbn,
 		goto out;
 
 ok:
+	if (!index_buf_check(ib, bytes, &vbn)) {
+		ntfs_inode_err(&ni->vfs_inode, "directory corrupted");
+		ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
+		err = -EINVAL;
+		goto out;
+	}
+
 	if (err == -E_NTFS_FIXUP) {
 		ntfs_write_bh(ni->mi.sbi, &ib->rhdr, &in->nb, 0);
 		err = 0;
@@ -1607,9 +1675,9 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 
 	if (err) {
 		/* Restore root. */
-		if (mi_resize_attr(mi, attr, -ds_root))
+		if (mi_resize_attr(mi, attr, -ds_root)) {
 			memcpy(attr, a_root, asize);
-		else {
+		} else {
 			/* Bug? */
 			ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
 		}
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index e52dfa5c7562..dc937089a464 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -81,7 +81,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 			 le16_to_cpu(ref->seq), le16_to_cpu(rec->seq));
 		goto out;
 	} else if (!is_rec_inuse(rec)) {
-		err = -EINVAL;
+		err = -ESTALE;
 		ntfs_err(sb, "Inode r=%x is not in use!", (u32)ino);
 		goto out;
 	}
@@ -92,8 +92,10 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		goto out;
 	}
 
-	if (!is_rec_base(rec))
-		goto Ok;
+	if (!is_rec_base(rec)) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	/* Record should contain $I30 root. */
 	is_dir = rec->flags & RECORD_FLAG_DIR;
@@ -472,7 +474,6 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		inode->i_flags |= S_NOSEC;
 	}
 
-Ok:
 	if (ino == MFT_REC_MFT && !sb->s_root)
 		sbi->mft.ni = NULL;
 
@@ -526,6 +527,9 @@ struct inode *ntfs_iget5(struct super_block *sb, const struct MFT_REF *ref,
 		_ntfs_bad_inode(inode);
 	}
 
+	if (IS_ERR(inode) && name)
+		ntfs_set_state(sb->s_fs_info, NTFS_DIRTY_ERROR);
+
 	return inode;
 }
 
@@ -1641,10 +1645,8 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 		ntfs_remove_reparse(sbi, IO_REPARSE_TAG_SYMLINK, &new_de->ref);
 
 out5:
-	if (S_ISDIR(mode) || run_is_empty(&ni->file.run))
-		goto out4;
-
-	run_deallocate(sbi, &ni->file.run, false);
+	if (!S_ISDIR(mode))
+		run_deallocate(sbi, &ni->file.run, false);
 
 out4:
 	clear_rec_inuse(rec);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index c5c022fef4e0..24227b2e1b2b 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -794,12 +794,12 @@ int run_pack(const struct runs_tree *run, CLST svcn, CLST len, u8 *run_buf,
 	     u32 run_buf_size, CLST *packed_vcns);
 int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 	       CLST svcn, CLST evcn, CLST vcn, const u8 *run_buf,
-	       u32 run_buf_size);
+	       int run_buf_size);
 
 #ifdef NTFS3_CHECK_FREE_CLST
 int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 		  CLST svcn, CLST evcn, CLST vcn, const u8 *run_buf,
-		  u32 run_buf_size);
+		  int run_buf_size);
 #else
 #define run_unpack_ex run_unpack
 #endif
diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index aaaa0d3d35a2..12d8682f33b5 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -919,12 +919,15 @@ int run_pack(const struct runs_tree *run, CLST svcn, CLST len, u8 *run_buf,
  */
 int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 	       CLST svcn, CLST evcn, CLST vcn, const u8 *run_buf,
-	       u32 run_buf_size)
+	       int run_buf_size)
 {
 	u64 prev_lcn, vcn64, lcn, next_vcn;
 	const u8 *run_last, *run_0;
 	bool is_mft = ino == MFT_REC_MFT;
 
+	if (run_buf_size < 0)
+		return -EINVAL;
+
 	/* Check for empty. */
 	if (evcn + 1 == svcn)
 		return 0;
@@ -1046,7 +1049,7 @@ int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
  */
 int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 		  CLST svcn, CLST evcn, CLST vcn, const u8 *run_buf,
-		  u32 run_buf_size)
+		  int run_buf_size)
 {
 	int ret, err;
 	CLST next_vcn, lcn, len;
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 88866bcd1a21..f5d3092f478c 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -42,28 +42,26 @@ static inline size_t packed_ea_size(const struct EA_FULL *ea)
  * Assume there is at least one xattr in the list.
  */
 static inline bool find_ea(const struct EA_FULL *ea_all, u32 bytes,
-			   const char *name, u8 name_len, u32 *off)
+			   const char *name, u8 name_len, u32 *off, u32 *ea_sz)
 {
-	*off = 0;
+	u32 ea_size;
 
-	if (!ea_all || !bytes)
+	*off = 0;
+	if (!ea_all)
 		return false;
 
-	for (;;) {
+	for (; *off < bytes; *off += ea_size) {
 		const struct EA_FULL *ea = Add2Ptr(ea_all, *off);
-		u32 next_off = *off + unpacked_ea_size(ea);
-
-		if (next_off > bytes)
-			return false;
-
+		ea_size = unpacked_ea_size(ea);
 		if (ea->name_len == name_len &&
-		    !memcmp(ea->name, name, name_len))
+		    !memcmp(ea->name, name, name_len)) {
+			if (ea_sz)
+				*ea_sz = ea_size;
 			return true;
-
-		*off = next_off;
-		if (next_off >= bytes)
-			return false;
+		}
 	}
+
+	return false;
 }
 
 /*
@@ -74,12 +72,12 @@ static inline bool find_ea(const struct EA_FULL *ea_all, u32 bytes,
 static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 			size_t add_bytes, const struct EA_INFO **info)
 {
-	int err;
+	int err = -EINVAL;
 	struct ntfs_sb_info *sbi = ni->mi.sbi;
 	struct ATTR_LIST_ENTRY *le = NULL;
 	struct ATTRIB *attr_info, *attr_ea;
 	void *ea_p;
-	u32 size;
+	u32 size, off, ea_size;
 
 	static_assert(le32_to_cpu(ATTR_EA_INFO) < le32_to_cpu(ATTR_EA));
 
@@ -96,24 +94,31 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 
 	*info = resident_data_ex(attr_info, sizeof(struct EA_INFO));
 	if (!*info)
-		return -EINVAL;
+		goto out;
 
 	/* Check Ea limit. */
 	size = le32_to_cpu((*info)->size);
-	if (size > sbi->ea_max_size)
-		return -EFBIG;
+	if (size > sbi->ea_max_size) {
+		err = -EFBIG;
+		goto out;
+	}
+
+	if (attr_size(attr_ea) > sbi->ea_max_size) {
+		err = -EFBIG;
+		goto out;
+	}
 
-	if (attr_size(attr_ea) > sbi->ea_max_size)
-		return -EFBIG;
+	if (!size) {
+		/* EA info persists, but xattr is empty. Looks like EA problem. */
+		goto out;
+	}
 
 	/* Allocate memory for packed Ea. */
 	ea_p = kmalloc(size_add(size, add_bytes), GFP_NOFS);
 	if (!ea_p)
 		return -ENOMEM;
 
-	if (!size) {
-		/* EA info persists, but xattr is empty. Looks like EA problem. */
-	} else if (attr_ea->non_res) {
+	if (attr_ea->non_res) {
 		struct runs_tree run;
 
 		run_init(&run);
@@ -124,24 +129,52 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 		run_close(&run);
 
 		if (err)
-			goto out;
+			goto out1;
 	} else {
 		void *p = resident_data_ex(attr_ea, size);
 
-		if (!p) {
-			err = -EINVAL;
-			goto out;
-		}
+		if (!p)
+			goto out1;
 		memcpy(ea_p, p, size);
 	}
 
 	memset(Add2Ptr(ea_p, size), 0, add_bytes);
+
+	/* Check all attributes for consistency. */
+	for (off = 0; off < size; off += ea_size) {
+		const struct EA_FULL *ef = Add2Ptr(ea_p, off);
+		u32 bytes = size - off;
+
+		/* Check if we can use field ea->size. */
+		if (bytes < sizeof(ef->size))
+			goto out1;
+
+		if (ef->size) {
+			ea_size = le32_to_cpu(ef->size);
+			if (ea_size > bytes)
+				goto out1;
+			continue;
+		}
+
+		/* Check if we can use fields ef->name_len and ef->elength. */
+		if (bytes < offsetof(struct EA_FULL, name))
+			goto out1;
+
+		ea_size = ALIGN(struct_size(ef, name,
+					    1 + ef->name_len +
+						    le16_to_cpu(ef->elength)),
+				4);
+		if (ea_size > bytes)
+			goto out1;
+	}
+
 	*ea = ea_p;
 	return 0;
 
-out:
+out1:
 	kfree(ea_p);
-	*ea = NULL;
+out:
+	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
 	return err;
 }
 
@@ -163,6 +196,7 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, char *buffer,
 	const struct EA_FULL *ea;
 	u32 off, size;
 	int err;
+	int ea_size;
 	size_t ret;
 
 	err = ntfs_read_ea(ni, &ea_all, 0, &info);
@@ -175,8 +209,9 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, char *buffer,
 	size = le32_to_cpu(info->size);
 
 	/* Enumerate all xattrs. */
-	for (ret = 0, off = 0; off < size; off += unpacked_ea_size(ea)) {
+	for (ret = 0, off = 0; off < size; off += ea_size) {
 		ea = Add2Ptr(ea_all, off);
+		ea_size = unpacked_ea_size(ea);
 
 		if (!ea->name_len)
 			break;
@@ -230,7 +265,8 @@ static int ntfs_get_ea(struct inode *inode, const char *name, size_t name_len,
 		goto out;
 
 	/* Enumerate all xattrs. */
-	if (!find_ea(ea_all, le32_to_cpu(info->size), name, name_len, &off)) {
+	if (!find_ea(ea_all, le32_to_cpu(info->size), name, name_len, &off,
+		     NULL)) {
 		err = -ENODATA;
 		goto out;
 	}
@@ -272,7 +308,7 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 	struct EA_FULL *new_ea;
 	struct EA_FULL *ea_all = NULL;
 	size_t add, new_pack;
-	u32 off, size;
+	u32 off, size, ea_sz;
 	__le16 size_pack;
 	struct ATTRIB *attr;
 	struct ATTR_LIST_ENTRY *le;
@@ -307,9 +343,8 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 		size_pack = ea_info.size_pack;
 	}
 
-	if (info && find_ea(ea_all, size, name, name_len, &off)) {
+	if (info && find_ea(ea_all, size, name, name_len, &off, &ea_sz)) {
 		struct EA_FULL *ea;
-		size_t ea_sz;
 
 		if (flags & XATTR_CREATE) {
 			err = -EEXIST;
@@ -332,8 +367,6 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 		if (ea->flags & FILE_NEED_EA)
 			le16_add_cpu(&ea_info.count, -1);
 
-		ea_sz = unpacked_ea_size(ea);
-
 		le16_add_cpu(&ea_info.size_pack, 0 - packed_ea_size(ea));
 
 		memmove(ea, Add2Ptr(ea, ea_sz), size - off - ea_sz);
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 9e61511de7a7..677649b34965 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -497,20 +497,20 @@ static void ovl_idmap_posix_acl(struct inode *realinode,
  */
 struct posix_acl *ovl_get_acl(struct inode *inode, int type, bool rcu)
 {
-	struct inode *realinode = ovl_inode_real(inode);
+	struct inode *realinode;
 	struct posix_acl *acl, *clone;
 	struct path realpath;
 
-	if (!IS_POSIXACL(realinode))
-		return NULL;
-
 	/* Careful in RCU walk mode */
-	ovl_i_path_real(inode, &realpath);
-	if (!realpath.dentry) {
+	realinode = ovl_i_path_real(inode, &realpath);
+	if (!realinode) {
 		WARN_ON(!rcu);
 		return ERR_PTR(-ECHILD);
 	}
 
+	if (!IS_POSIXACL(realinode))
+		return NULL;
+
 	if (rcu) {
 		acl = get_cached_acl_rcu(realinode, type);
 	} else {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 052226aa7de0..a3c59ac015ee 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -369,7 +369,7 @@ enum ovl_path_type ovl_path_type(struct dentry *dentry);
 void ovl_path_upper(struct dentry *dentry, struct path *path);
 void ovl_path_lower(struct dentry *dentry, struct path *path);
 void ovl_path_lowerdata(struct dentry *dentry, struct path *path);
-void ovl_i_path_real(struct inode *inode, struct path *path);
+struct inode *ovl_i_path_real(struct inode *inode, struct path *path);
 enum ovl_path_type ovl_path_real(struct dentry *dentry, struct path *path);
 enum ovl_path_type ovl_path_realdata(struct dentry *dentry, struct path *path);
 struct dentry *ovl_dentry_upper(struct dentry *dentry);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 850e8d1bf829..0d8f96168e6c 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -266,7 +266,7 @@ struct dentry *ovl_i_dentry_upper(struct inode *inode)
 	return ovl_upperdentry_dereference(OVL_I(inode));
 }
 
-void ovl_i_path_real(struct inode *inode, struct path *path)
+struct inode *ovl_i_path_real(struct inode *inode, struct path *path)
 {
 	path->dentry = ovl_i_dentry_upper(inode);
 	if (!path->dentry) {
@@ -275,6 +275,8 @@ void ovl_i_path_real(struct inode *inode, struct path *path)
 	} else {
 		path->mnt = ovl_upper_mnt(OVL_FS(inode->i_sb));
 	}
+
+	return path->dentry ? d_inode_rcu(path->dentry) : NULL;
 }
 
 struct inode *ovl_inode_upper(struct inode *inode)
@@ -1121,8 +1123,7 @@ void ovl_copyattr(struct inode *inode)
 	struct inode *realinode;
 	struct user_namespace *real_mnt_userns;
 
-	ovl_i_path_real(inode, &realpath);
-	realinode = d_inode(realpath.dentry);
+	realinode = ovl_i_path_real(inode, &realpath);
 	real_mnt_userns = mnt_user_ns(realpath.mnt);
 
 	inode->i_uid = i_uid_into_mnt(real_mnt_userns, realinode);
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 9a367d4c74e4..27c6d14e369f 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -954,8 +954,8 @@ int cifs_close(struct inode *inode, struct file *file)
 		cfile = file->private_data;
 		file->private_data = NULL;
 		dclose = kmalloc(sizeof(struct cifs_deferred_close), GFP_KERNEL);
-		if ((cinode->oplock == CIFS_CACHE_RHW_FLG) &&
-		    cinode->lease_granted &&
+		if ((cifs_sb->ctx->closetimeo && cinode->oplock == CIFS_CACHE_RHW_FLG)
+		    && cinode->lease_granted &&
 		    !test_bit(CIFS_INO_CLOSE_ON_LOCK, &cinode->flags) &&
 		    dclose) {
 			if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, &cinode->flags)) {
diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 790acf65a092..22954a9c7a6c 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -153,7 +153,14 @@ smb2_find_smb_ses_unlocked(struct TCP_Server_Info *server, __u64 ses_id)
 	list_for_each_entry(ses, &pserver->smb_ses_list, smb_ses_list) {
 		if (ses->Suid != ses_id)
 			continue;
+
+		spin_lock(&ses->ses_lock);
+		if (ses->ses_status == SES_EXITING) {
+			spin_unlock(&ses->ses_lock);
+			continue;
+		}
 		++ses->ses_count;
+		spin_unlock(&ses->ses_lock);
 		return ses;
 	}
 
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 2b7c0ba6a77d..26cf73d664f9 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1339,9 +1339,8 @@ static int decode_negotiation_token(struct ksmbd_conn *conn,
 
 static int ntlm_negotiate(struct ksmbd_work *work,
 			  struct negotiate_message *negblob,
-			  size_t negblob_len)
+			  size_t negblob_len, struct smb2_sess_setup_rsp *rsp)
 {
-	struct smb2_sess_setup_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct challenge_message *chgblob;
 	unsigned char *spnego_blob = NULL;
 	u16 spnego_blob_len;
@@ -1446,10 +1445,10 @@ static struct ksmbd_user *session_user(struct ksmbd_conn *conn,
 	return user;
 }
 
-static int ntlm_authenticate(struct ksmbd_work *work)
+static int ntlm_authenticate(struct ksmbd_work *work,
+			     struct smb2_sess_setup_req *req,
+			     struct smb2_sess_setup_rsp *rsp)
 {
-	struct smb2_sess_setup_req *req = smb2_get_msg(work->request_buf);
-	struct smb2_sess_setup_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_session *sess = work->sess;
 	struct channel *chann = NULL;
@@ -1582,10 +1581,10 @@ static int ntlm_authenticate(struct ksmbd_work *work)
 }
 
 #ifdef CONFIG_SMB_SERVER_KERBEROS5
-static int krb5_authenticate(struct ksmbd_work *work)
+static int krb5_authenticate(struct ksmbd_work *work,
+			     struct smb2_sess_setup_req *req,
+			     struct smb2_sess_setup_rsp *rsp)
 {
-	struct smb2_sess_setup_req *req = smb2_get_msg(work->request_buf);
-	struct smb2_sess_setup_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_session *sess = work->sess;
 	char *in_blob, *out_blob;
@@ -1662,7 +1661,9 @@ static int krb5_authenticate(struct ksmbd_work *work)
 	return 0;
 }
 #else
-static int krb5_authenticate(struct ksmbd_work *work)
+static int krb5_authenticate(struct ksmbd_work *work,
+			     struct smb2_sess_setup_req *req,
+			     struct smb2_sess_setup_rsp *rsp)
 {
 	return -EOPNOTSUPP;
 }
@@ -1671,8 +1672,8 @@ static int krb5_authenticate(struct ksmbd_work *work)
 int smb2_sess_setup(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_sess_setup_req *req = smb2_get_msg(work->request_buf);
-	struct smb2_sess_setup_rsp *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_sess_setup_req *req;
+	struct smb2_sess_setup_rsp *rsp;
 	struct ksmbd_session *sess;
 	struct negotiate_message *negblob;
 	unsigned int negblob_len, negblob_off;
@@ -1680,6 +1681,8 @@ int smb2_sess_setup(struct ksmbd_work *work)
 
 	ksmbd_debug(SMB, "Received request for session setup\n");
 
+	WORK_BUFFERS(work, req, rsp);
+
 	rsp->StructureSize = cpu_to_le16(9);
 	rsp->SessionFlags = 0;
 	rsp->SecurityBufferOffset = cpu_to_le16(72);
@@ -1801,7 +1804,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 
 		if (conn->preferred_auth_mech &
 				(KSMBD_AUTH_KRB5 | KSMBD_AUTH_MSKRB5)) {
-			rc = krb5_authenticate(work);
+			rc = krb5_authenticate(work, req, rsp);
 			if (rc) {
 				rc = -EINVAL;
 				goto out_err;
@@ -1815,7 +1818,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			sess->Preauth_HashValue = NULL;
 		} else if (conn->preferred_auth_mech == KSMBD_AUTH_NTLMSSP) {
 			if (negblob->MessageType == NtLmNegotiate) {
-				rc = ntlm_negotiate(work, negblob, negblob_len);
+				rc = ntlm_negotiate(work, negblob, negblob_len, rsp);
 				if (rc)
 					goto out_err;
 				rsp->hdr.Status =
@@ -1828,7 +1831,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 						le16_to_cpu(rsp->SecurityBufferLength) - 1);
 
 			} else if (negblob->MessageType == NtLmAuthenticate) {
-				rc = ntlm_authenticate(work);
+				rc = ntlm_authenticate(work, req, rsp);
 				if (rc)
 					goto out_err;
 
@@ -1926,14 +1929,16 @@ int smb2_sess_setup(struct ksmbd_work *work)
 int smb2_tree_connect(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_tree_connect_req *req = smb2_get_msg(work->request_buf);
-	struct smb2_tree_connect_rsp *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_tree_connect_req *req;
+	struct smb2_tree_connect_rsp *rsp;
 	struct ksmbd_session *sess = work->sess;
 	char *treename = NULL, *name = NULL;
 	struct ksmbd_tree_conn_status status;
 	struct ksmbd_share_config *share;
 	int rc = -EINVAL;
 
+	WORK_BUFFERS(work, req, rsp);
+
 	treename = smb_strndup_from_utf16(req->Buffer,
 					  le16_to_cpu(req->PathLength), true,
 					  conn->local_nls);
@@ -2102,19 +2107,19 @@ static int smb2_create_open_flags(bool file_present, __le32 access,
  */
 int smb2_tree_disconnect(struct ksmbd_work *work)
 {
-	struct smb2_tree_disconnect_rsp *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_tree_disconnect_rsp *rsp;
+	struct smb2_tree_disconnect_req *req;
 	struct ksmbd_session *sess = work->sess;
 	struct ksmbd_tree_connect *tcon = work->tcon;
 
+	WORK_BUFFERS(work, req, rsp);
+
 	rsp->StructureSize = cpu_to_le16(4);
 	inc_rfc1001_len(work->response_buf, 4);
 
 	ksmbd_debug(SMB, "request\n");
 
 	if (!tcon || test_and_set_bit(TREE_CONN_EXPIRE, &tcon->status)) {
-		struct smb2_tree_disconnect_req *req =
-			smb2_get_msg(work->request_buf);
-
 		ksmbd_debug(SMB, "Invalid tid %d\n", req->hdr.Id.SyncId.TreeId);
 
 		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
@@ -2137,10 +2142,14 @@ int smb2_tree_disconnect(struct ksmbd_work *work)
 int smb2_session_logoff(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_logoff_rsp *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_logoff_req *req;
+	struct smb2_logoff_rsp *rsp;
 	struct ksmbd_session *sess;
-	struct smb2_logoff_req *req = smb2_get_msg(work->request_buf);
-	u64 sess_id = le64_to_cpu(req->hdr.SessionId);
+	u64 sess_id;
+
+	WORK_BUFFERS(work, req, rsp);
+
+	sess_id = le64_to_cpu(req->hdr.SessionId);
 
 	rsp->StructureSize = cpu_to_le16(4);
 	inc_rfc1001_len(work->response_buf, 4);
@@ -2180,12 +2189,14 @@ int smb2_session_logoff(struct ksmbd_work *work)
  */
 static noinline int create_smb2_pipe(struct ksmbd_work *work)
 {
-	struct smb2_create_rsp *rsp = smb2_get_msg(work->response_buf);
-	struct smb2_create_req *req = smb2_get_msg(work->request_buf);
+	struct smb2_create_rsp *rsp;
+	struct smb2_create_req *req;
 	int id;
 	int err;
 	char *name;
 
+	WORK_BUFFERS(work, req, rsp);
+
 	name = smb_strndup_from_utf16(req->Buffer, le16_to_cpu(req->NameLength),
 				      1, work->conn->local_nls);
 	if (IS_ERR(name)) {
@@ -5321,8 +5332,10 @@ int smb2_query_info(struct ksmbd_work *work)
 static noinline int smb2_close_pipe(struct ksmbd_work *work)
 {
 	u64 id;
-	struct smb2_close_req *req = smb2_get_msg(work->request_buf);
-	struct smb2_close_rsp *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_close_req *req;
+	struct smb2_close_rsp *rsp;
+
+	WORK_BUFFERS(work, req, rsp);
 
 	id = req->VolatileFileId;
 	ksmbd_session_rpc_close(work->sess, id);
@@ -5464,6 +5477,9 @@ int smb2_echo(struct ksmbd_work *work)
 {
 	struct smb2_echo_rsp *rsp = smb2_get_msg(work->response_buf);
 
+	if (work->next_smb2_rcv_hdr_off)
+		rsp = ksmbd_resp_buf_next(work);
+
 	rsp->StructureSize = cpu_to_le16(4);
 	rsp->Reserved = 0;
 	inc_rfc1001_len(work->response_buf, 4);
@@ -6178,8 +6194,10 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 	int nbytes = 0, err;
 	u64 id;
 	struct ksmbd_rpc_command *rpc_resp;
-	struct smb2_read_req *req = smb2_get_msg(work->request_buf);
-	struct smb2_read_rsp *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_read_req *req;
+	struct smb2_read_rsp *rsp;
+
+	WORK_BUFFERS(work, req, rsp);
 
 	id = req->VolatileFileId;
 
@@ -6427,14 +6445,16 @@ int smb2_read(struct ksmbd_work *work)
  */
 static noinline int smb2_write_pipe(struct ksmbd_work *work)
 {
-	struct smb2_write_req *req = smb2_get_msg(work->request_buf);
-	struct smb2_write_rsp *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_write_req *req;
+	struct smb2_write_rsp *rsp;
 	struct ksmbd_rpc_command *rpc_resp;
 	u64 id = 0;
 	int err = 0, ret = 0;
 	char *data_buf;
 	size_t length;
 
+	WORK_BUFFERS(work, req, rsp);
+
 	length = le32_to_cpu(req->Length);
 	id = req->VolatileFileId;
 
@@ -6703,6 +6723,9 @@ int smb2_cancel(struct ksmbd_work *work)
 	struct ksmbd_work *iter;
 	struct list_head *command_list;
 
+	if (work->next_smb2_rcv_hdr_off)
+		hdr = ksmbd_resp_buf_next(work);
+
 	ksmbd_debug(SMB, "smb2 cancel called on mid %llu, async flags 0x%x\n",
 		    hdr->MessageId, hdr->Flags);
 
@@ -6862,8 +6885,8 @@ static inline bool lock_defer_pending(struct file_lock *fl)
  */
 int smb2_lock(struct ksmbd_work *work)
 {
-	struct smb2_lock_req *req = smb2_get_msg(work->request_buf);
-	struct smb2_lock_rsp *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_lock_req *req;
+	struct smb2_lock_rsp *rsp;
 	struct smb2_lock_element *lock_ele;
 	struct ksmbd_file *fp = NULL;
 	struct file_lock *flock = NULL;
@@ -6880,6 +6903,8 @@ int smb2_lock(struct ksmbd_work *work)
 	LIST_HEAD(rollback_list);
 	int prior_lock = 0;
 
+	WORK_BUFFERS(work, req, rsp);
+
 	ksmbd_debug(SMB, "Received lock request\n");
 	fp = ksmbd_lookup_fd_slow(work, req->VolatileFileId, req->PersistentFileId);
 	if (!fp) {
@@ -7992,8 +8017,8 @@ int smb2_ioctl(struct ksmbd_work *work)
  */
 static void smb20_oplock_break_ack(struct ksmbd_work *work)
 {
-	struct smb2_oplock_break *req = smb2_get_msg(work->request_buf);
-	struct smb2_oplock_break *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_oplock_break *req;
+	struct smb2_oplock_break *rsp;
 	struct ksmbd_file *fp;
 	struct oplock_info *opinfo = NULL;
 	__le32 err = 0;
@@ -8002,6 +8027,8 @@ static void smb20_oplock_break_ack(struct ksmbd_work *work)
 	char req_oplevel = 0, rsp_oplevel = 0;
 	unsigned int oplock_change_type;
 
+	WORK_BUFFERS(work, req, rsp);
+
 	volatile_id = req->VolatileFid;
 	persistent_id = req->PersistentFid;
 	req_oplevel = req->OplockLevel;
@@ -8136,8 +8163,8 @@ static int check_lease_state(struct lease *lease, __le32 req_state)
 static void smb21_lease_break_ack(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_lease_ack *req = smb2_get_msg(work->request_buf);
-	struct smb2_lease_ack *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_lease_ack *req;
+	struct smb2_lease_ack *rsp;
 	struct oplock_info *opinfo;
 	__le32 err = 0;
 	int ret = 0;
@@ -8145,6 +8172,8 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 	__le32 lease_state;
 	struct lease *lease;
 
+	WORK_BUFFERS(work, req, rsp);
+
 	ksmbd_debug(OPLOCK, "smb21 lease break, lease state(0x%x)\n",
 		    le32_to_cpu(req->LeaseState));
 	opinfo = lookup_lease_in_table(conn, req->LeaseKey);
@@ -8270,8 +8299,10 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
  */
 int smb2_oplock_break(struct ksmbd_work *work)
 {
-	struct smb2_oplock_break *req = smb2_get_msg(work->request_buf);
-	struct smb2_oplock_break *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_oplock_break *req;
+	struct smb2_oplock_break *rsp;
+
+	WORK_BUFFERS(work, req, rsp);
 
 	switch (le16_to_cpu(req->StructureSize)) {
 	case OP_BREAK_STRUCT_SIZE_20:
diff --git a/include/linux/blk-crypto-profile.h b/include/linux/blk-crypto-profile.h
index e6802b69cdd6..90ab33cb5d0e 100644
--- a/include/linux/blk-crypto-profile.h
+++ b/include/linux/blk-crypto-profile.h
@@ -111,6 +111,7 @@ struct blk_crypto_profile {
 	 * keyslots while ensuring that they can't be changed concurrently.
 	 */
 	struct rw_semaphore lock;
+	struct lock_class_key lockdep_key;
 
 	/* List of idle slots, with least recently used slot at front */
 	wait_queue_head_t idle_slots_wait_queue;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index d9fbc5afeaf7..e6fb36b71b59 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -473,7 +473,7 @@ struct nvme_id_ns_nvm {
 };
 
 enum {
-	NVME_ID_NS_NVM_STS_MASK		= 0x3f,
+	NVME_ID_NS_NVM_STS_MASK		= 0x7f,
 	NVME_ID_NS_NVM_GUARD_SHIFT	= 7,
 	NVME_ID_NS_NVM_GUARD_MASK	= 0x3,
 };
diff --git a/include/linux/rethook.h b/include/linux/rethook.h
index c8ac1e5afcd1..bdbe6717f45a 100644
--- a/include/linux/rethook.h
+++ b/include/linux/rethook.h
@@ -59,6 +59,7 @@ struct rethook_node {
 };
 
 struct rethook *rethook_alloc(void *data, rethook_handler_t handler);
+void rethook_stop(struct rethook *rh);
 void rethook_free(struct rethook *rh);
 void rethook_add_node(struct rethook *rh, struct rethook_node *node);
 struct rethook_node *rethook_try_get(struct rethook *rh);
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 19376bee9667..79b328861c5f 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -98,7 +98,6 @@ struct uart_8250_port {
 	struct list_head	list;		/* ports on this IRQ */
 	u32			capabilities;	/* port capabilities */
 	unsigned short		bugs;		/* port bugs */
-	bool			fifo_bug;	/* min RX trigger if enabled */
 	unsigned int		tx_loadsz;	/* transmit fifo load size */
 	unsigned char		acr;
 	unsigned char		fcr;
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index a0143dd24430..3ca41b9da647 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -68,7 +68,6 @@ enum {
 	WORK_OFFQ_FLAG_BASE	= WORK_STRUCT_COLOR_SHIFT,
 
 	__WORK_OFFQ_CANCELING	= WORK_OFFQ_FLAG_BASE,
-	WORK_OFFQ_CANCELING	= (1 << __WORK_OFFQ_CANCELING),
 
 	/*
 	 * When a work item is off queue, its high bits point to the last
@@ -79,12 +78,6 @@ enum {
 	WORK_OFFQ_POOL_SHIFT	= WORK_OFFQ_FLAG_BASE + WORK_OFFQ_FLAG_BITS,
 	WORK_OFFQ_LEFT		= BITS_PER_LONG - WORK_OFFQ_POOL_SHIFT,
 	WORK_OFFQ_POOL_BITS	= WORK_OFFQ_LEFT <= 31 ? WORK_OFFQ_LEFT : 31,
-	WORK_OFFQ_POOL_NONE	= (1LU << WORK_OFFQ_POOL_BITS) - 1,
-
-	/* convenience constants */
-	WORK_STRUCT_FLAG_MASK	= (1UL << WORK_STRUCT_FLAG_BITS) - 1,
-	WORK_STRUCT_WQ_DATA_MASK = ~WORK_STRUCT_FLAG_MASK,
-	WORK_STRUCT_NO_POOL	= (unsigned long)WORK_OFFQ_POOL_NONE << WORK_OFFQ_POOL_SHIFT,
 
 	/* bit mask for work_busy() return values */
 	WORK_BUSY_PENDING	= 1 << 0,
@@ -94,6 +87,14 @@ enum {
 	WORKER_DESC_LEN		= 24,
 };
 
+/* Convenience constants - of type 'unsigned long', not 'enum'! */
+#define WORK_OFFQ_CANCELING	(1ul << __WORK_OFFQ_CANCELING)
+#define WORK_OFFQ_POOL_NONE	((1ul << WORK_OFFQ_POOL_BITS) - 1)
+#define WORK_STRUCT_NO_POOL	(WORK_OFFQ_POOL_NONE << WORK_OFFQ_POOL_SHIFT)
+
+#define WORK_STRUCT_FLAG_MASK    ((1ul << WORK_STRUCT_FLAG_BITS) - 1)
+#define WORK_STRUCT_WQ_DATA_MASK (~WORK_STRUCT_FLAG_MASK)
+
 struct work_struct {
 	atomic_long_t data;
 	struct list_head entry;
diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 8ab75128512a..f99a513b40a9 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -135,7 +135,7 @@ extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
  */
 static inline unsigned int psched_mtu(const struct net_device *dev)
 {
-	return dev->mtu + dev->hard_header_len;
+	return READ_ONCE(dev->mtu) + dev->hard_header_len;
 }
 
 static inline struct net *qdisc_net(struct Qdisc *q)
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index b5ba34ddd4b6..09141351d545 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -127,22 +127,6 @@ static void get_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
 	atomic_inc(&rcpu->refcnt);
 }
 
-/* called from workqueue, to workaround syscall using preempt_disable */
-static void cpu_map_kthread_stop(struct work_struct *work)
-{
-	struct bpf_cpu_map_entry *rcpu;
-
-	rcpu = container_of(work, struct bpf_cpu_map_entry, kthread_stop_wq);
-
-	/* Wait for flush in __cpu_map_entry_free(), via full RCU barrier,
-	 * as it waits until all in-flight call_rcu() callbacks complete.
-	 */
-	rcu_barrier();
-
-	/* kthread_stop will wake_up_process and wait for it to complete */
-	kthread_stop(rcpu->kthread);
-}
-
 static void __cpu_map_ring_cleanup(struct ptr_ring *ring)
 {
 	/* The tear-down procedure should have made sure that queue is
@@ -170,6 +154,30 @@ static void put_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
 	}
 }
 
+/* called from workqueue, to workaround syscall using preempt_disable */
+static void cpu_map_kthread_stop(struct work_struct *work)
+{
+	struct bpf_cpu_map_entry *rcpu;
+	int err;
+
+	rcpu = container_of(work, struct bpf_cpu_map_entry, kthread_stop_wq);
+
+	/* Wait for flush in __cpu_map_entry_free(), via full RCU barrier,
+	 * as it waits until all in-flight call_rcu() callbacks complete.
+	 */
+	rcu_barrier();
+
+	/* kthread_stop will wake_up_process and wait for it to complete */
+	err = kthread_stop(rcpu->kthread);
+	if (err) {
+		/* kthread_stop may be called before cpu_map_kthread_run
+		 * is executed, so we need to release the memory related
+		 * to rcpu.
+		 */
+		put_cpu_map_entry(rcpu);
+	}
+}
+
 static void cpu_map_bpf_prog_run_skb(struct bpf_cpu_map_entry *rcpu,
 				     struct list_head *listp,
 				     struct xdp_cpumap_stats *stats)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 49c6b5e0855c..8c3ededef317 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4357,8 +4357,9 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 				verbose(env, "verifier bug. subprog has tail_call and async cb\n");
 				return -EFAULT;
 			}
-			 /* async callbacks don't increase bpf prog stack size */
-			continue;
+			/* async callbacks don't increase bpf prog stack size unless called directly */
+			if (!bpf_pseudo_call(insn + i))
+				continue;
 		}
 		i = next_insn;
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 7f4ad5e70b40..ad6333c3fe1f 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -117,9 +117,16 @@ static bool round_up_default_nslabs(void)
 	return true;
 }
 
+/**
+ * swiotlb_adjust_nareas() - adjust the number of areas and slots
+ * @nareas:	Desired number of areas. Zero is treated as 1.
+ *
+ * Adjust the default number of areas in a memory pool.
+ * The default size of the memory pool may also change to meet minimum area
+ * size requirements.
+ */
 static void swiotlb_adjust_nareas(unsigned int nareas)
 {
-	/* use a single area when non is specified */
 	if (!nareas)
 		nareas = 1;
 	else if (!is_power_of_2(nareas))
@@ -133,6 +140,23 @@ static void swiotlb_adjust_nareas(unsigned int nareas)
 			(default_nslabs << IO_TLB_SHIFT) >> 20);
 }
 
+/**
+ * limit_nareas() - get the maximum number of areas for a given memory pool size
+ * @nareas:	Desired number of areas.
+ * @nslots:	Total number of slots in the memory pool.
+ *
+ * Limit the number of areas to the maximum possible number of areas in
+ * a memory pool of the given size.
+ *
+ * Return: Maximum possible number of areas.
+ */
+static unsigned int limit_nareas(unsigned int nareas, unsigned long nslots)
+{
+	if (nslots < nareas * IO_TLB_SEGSIZE)
+		return nslots / IO_TLB_SEGSIZE;
+	return nareas;
+}
+
 static int __init
 setup_io_tlb_npages(char *str)
 {
@@ -300,6 +324,38 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 	return;
 }
 
+static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
+		unsigned int flags,
+		int (*remap)(void *tlb, unsigned long nslabs))
+{
+	size_t bytes = PAGE_ALIGN(nslabs << IO_TLB_SHIFT);
+	void *tlb;
+
+	/*
+	 * By default allocate the bounce buffer memory from low memory, but
+	 * allow to pick a location everywhere for hypervisors with guest
+	 * memory encryption.
+	 */
+	if (flags & SWIOTLB_ANY)
+		tlb = memblock_alloc(bytes, PAGE_SIZE);
+	else
+		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
+
+	if (!tlb) {
+		pr_warn("%s: Failed to allocate %zu bytes tlb structure\n",
+			__func__, bytes);
+		return NULL;
+	}
+
+	if (remap && remap(tlb, nslabs) < 0) {
+		memblock_free(tlb, PAGE_ALIGN(bytes));
+		pr_warn("%s: Failed to remap %zu bytes\n", __func__, bytes);
+		return NULL;
+	}
+
+	return tlb;
+}
+
 /*
  * Statically reserve bounce buffer space and initialize bounce buffer data
  * structures for the software IO TLB used to implement the DMA API.
@@ -309,8 +365,8 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 {
 	struct io_tlb_mem *mem = &io_tlb_default_mem;
 	unsigned long nslabs;
+	unsigned int nareas;
 	size_t alloc_size;
-	size_t bytes;
 	void *tlb;
 
 	if (!addressing_limit && !swiotlb_force_bounce)
@@ -318,39 +374,22 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	if (swiotlb_force_disable)
 		return;
 
-	/*
-	 * default_nslabs maybe changed when adjust area number.
-	 * So allocate bounce buffer after adjusting area number.
-	 */
 	if (!default_nareas)
 		swiotlb_adjust_nareas(num_possible_cpus());
 
 	nslabs = default_nslabs;
-	/*
-	 * By default allocate the bounce buffer memory from low memory, but
-	 * allow to pick a location everywhere for hypervisors with guest
-	 * memory encryption.
-	 */
-retry:
-	bytes = PAGE_ALIGN(nslabs << IO_TLB_SHIFT);
-	if (flags & SWIOTLB_ANY)
-		tlb = memblock_alloc(bytes, PAGE_SIZE);
-	else
-		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
-	if (!tlb) {
-		pr_warn("%s: failed to allocate tlb structure\n", __func__);
-		return;
-	}
-
-	if (remap && remap(tlb, nslabs) < 0) {
-		memblock_free(tlb, PAGE_ALIGN(bytes));
-
+	nareas = limit_nareas(default_nareas, nslabs);
+	while ((tlb = swiotlb_memblock_alloc(nslabs, flags, remap)) == NULL) {
+		if (nslabs <= IO_TLB_MIN_SLABS)
+			return;
 		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
-		if (nslabs >= IO_TLB_MIN_SLABS)
-			goto retry;
+		nareas = limit_nareas(nareas, nslabs);
+	}
 
-		pr_warn("%s: Failed to remap %zu bytes\n", __func__, bytes);
-		return;
+	if (default_nslabs != nslabs) {
+		pr_info("SWIOTLB bounce buffer size adjusted %lu -> %lu slabs",
+			default_nslabs, nslabs);
+		default_nslabs = nslabs;
 	}
 
 	alloc_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), nslabs));
@@ -390,6 +429,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 {
 	struct io_tlb_mem *mem = &io_tlb_default_mem;
 	unsigned long nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
+	unsigned int nareas;
 	unsigned char *vstart = NULL;
 	unsigned int order, area_order;
 	bool retried = false;
@@ -398,6 +438,9 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	if (swiotlb_force_disable)
 		return 0;
 
+	if (!default_nareas)
+		swiotlb_adjust_nareas(num_possible_cpus());
+
 retry:
 	order = get_order(nslabs << IO_TLB_SHIFT);
 	nslabs = SLABS_PER_PAGE << order;
@@ -432,11 +475,8 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 			(PAGE_SIZE << order) >> 20);
 	}
 
-	if (!default_nareas)
-		swiotlb_adjust_nareas(num_possible_cpus());
-
-	area_order = get_order(array_size(sizeof(*mem->areas),
-		default_nareas));
+	nareas = limit_nareas(default_nareas, nslabs);
+	area_order = get_order(array_size(sizeof(*mem->areas), nareas));
 	mem->areas = (struct io_tlb_area *)
 		__get_free_pages(GFP_KERNEL | __GFP_ZERO, area_order);
 	if (!mem->areas)
@@ -450,7 +490,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	set_memory_decrypted((unsigned long)vstart,
 			     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
 	swiotlb_init_io_tlb_mem(mem, virt_to_phys(vstart), nslabs, 0, true,
-				default_nareas);
+				nareas);
 
 	swiotlb_print_info();
 	return 0;
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index af51ed6d45ef..782d3b41c1f3 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -426,6 +426,11 @@ late_initcall(cpu_latency_qos_init);
 
 /* Definitions related to the frequency QoS below. */
 
+static inline bool freq_qos_value_invalid(s32 value)
+{
+	return value < 0 && value != PM_QOS_DEFAULT_VALUE;
+}
+
 /**
  * freq_constraints_init - Initialize frequency QoS constraints.
  * @qos: Frequency QoS constraints to initialize.
@@ -531,7 +536,7 @@ int freq_qos_add_request(struct freq_constraints *qos,
 {
 	int ret;
 
-	if (IS_ERR_OR_NULL(qos) || !req || value < 0)
+	if (IS_ERR_OR_NULL(qos) || !req || freq_qos_value_invalid(value))
 		return -EINVAL;
 
 	if (WARN(freq_qos_request_active(req),
@@ -563,7 +568,7 @@ EXPORT_SYMBOL_GPL(freq_qos_add_request);
  */
 int freq_qos_update_request(struct freq_qos_request *req, s32 new_value)
 {
-	if (!req || new_value < 0)
+	if (!req || freq_qos_value_invalid(new_value))
 		return -EINVAL;
 
 	if (WARN(!freq_qos_request_active(req),
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index e8143e368074..1322247ce648 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -307,19 +307,16 @@ int unregister_fprobe(struct fprobe *fp)
 		    fp->ops.saved_func != fprobe_kprobe_handler))
 		return -EINVAL;
 
-	/*
-	 * rethook_free() starts disabling the rethook, but the rethook handlers
-	 * may be running on other processors at this point. To make sure that all
-	 * current running handlers are finished, call unregister_ftrace_function()
-	 * after this.
-	 */
 	if (fp->rethook)
-		rethook_free(fp->rethook);
+		rethook_stop(fp->rethook);
 
 	ret = unregister_ftrace_function(&fp->ops);
 	if (ret < 0)
 		return ret;
 
+	if (fp->rethook)
+		rethook_free(fp->rethook);
+
 	ftrace_free_filter(&fp->ops);
 
 	return ret;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 57db50c2dce8..552956ccb91c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3213,6 +3213,22 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
 	return cnt;
 }
 
+static void ftrace_free_pages(struct ftrace_page *pages)
+{
+	struct ftrace_page *pg = pages;
+
+	while (pg) {
+		if (pg->records) {
+			free_pages((unsigned long)pg->records, pg->order);
+			ftrace_number_of_pages -= 1 << pg->order;
+		}
+		pages = pg->next;
+		kfree(pg);
+		pg = pages;
+		ftrace_number_of_groups--;
+	}
+}
+
 static struct ftrace_page *
 ftrace_allocate_pages(unsigned long num_to_init)
 {
@@ -3251,17 +3267,7 @@ ftrace_allocate_pages(unsigned long num_to_init)
 	return start_pg;
 
  free_pages:
-	pg = start_pg;
-	while (pg) {
-		if (pg->records) {
-			free_pages((unsigned long)pg->records, pg->order);
-			ftrace_number_of_pages -= 1 << pg->order;
-		}
-		start_pg = pg->next;
-		kfree(pg);
-		pg = start_pg;
-		ftrace_number_of_groups--;
-	}
+	ftrace_free_pages(start_pg);
 	pr_info("ftrace: FAILED to allocate memory for functions\n");
 	return NULL;
 }
@@ -6666,9 +6672,11 @@ static int ftrace_process_locs(struct module *mod,
 			       unsigned long *start,
 			       unsigned long *end)
 {
+	struct ftrace_page *pg_unuse = NULL;
 	struct ftrace_page *start_pg;
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
+	unsigned long skipped = 0;
 	unsigned long count;
 	unsigned long *p;
 	unsigned long addr;
@@ -6731,8 +6739,10 @@ static int ftrace_process_locs(struct module *mod,
 		 * object files to satisfy alignments.
 		 * Skip any NULL pointers.
 		 */
-		if (!addr)
+		if (!addr) {
+			skipped++;
 			continue;
+		}
 
 		end_offset = (pg->index+1) * sizeof(pg->records[0]);
 		if (end_offset > PAGE_SIZE << pg->order) {
@@ -6746,8 +6756,10 @@ static int ftrace_process_locs(struct module *mod,
 		rec->ip = addr;
 	}
 
-	/* We should have used all pages */
-	WARN_ON(pg->next);
+	if (pg->next) {
+		pg_unuse = pg->next;
+		pg->next = NULL;
+	}
 
 	/* Assign the last page to ftrace_pages */
 	ftrace_pages = pg;
@@ -6769,6 +6781,11 @@ static int ftrace_process_locs(struct module *mod,
  out:
 	mutex_unlock(&ftrace_lock);
 
+	/* We should have used all pages unless we skipped some */
+	if (pg_unuse) {
+		WARN_ON(!skipped);
+		ftrace_free_pages(pg_unuse);
+	}
 	return ret;
 }
 
diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index 60f6cb2b486b..468006cce7ca 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -53,6 +53,19 @@ static void rethook_free_rcu(struct rcu_head *head)
 		kfree(rh);
 }
 
+/**
+ * rethook_stop() - Stop using a rethook.
+ * @rh: the struct rethook to stop.
+ *
+ * Stop using a rethook to prepare for freeing it. If you want to wait for
+ * all running rethook handler before calling rethook_free(), you need to
+ * call this first and wait RCU, and call rethook_free().
+ */
+void rethook_stop(struct rethook *rh)
+{
+	WRITE_ONCE(rh->handler, NULL);
+}
+
 /**
  * rethook_free() - Free struct rethook.
  * @rh: the struct rethook to be freed.
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 4acc27cb856f..c264421c4ecd 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5238,28 +5238,34 @@ unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_size);
 
+static void rb_clear_buffer_page(struct buffer_page *page)
+{
+	local_set(&page->write, 0);
+	local_set(&page->entries, 0);
+	rb_init_page(page->page);
+	page->read = 0;
+}
+
 static void
 rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 {
+	struct buffer_page *page;
+
 	rb_head_page_deactivate(cpu_buffer);
 
 	cpu_buffer->head_page
 		= list_entry(cpu_buffer->pages, struct buffer_page, list);
-	local_set(&cpu_buffer->head_page->write, 0);
-	local_set(&cpu_buffer->head_page->entries, 0);
-	local_set(&cpu_buffer->head_page->page->commit, 0);
-
-	cpu_buffer->head_page->read = 0;
+	rb_clear_buffer_page(cpu_buffer->head_page);
+	list_for_each_entry(page, cpu_buffer->pages, list) {
+		rb_clear_buffer_page(page);
+	}
 
 	cpu_buffer->tail_page = cpu_buffer->head_page;
 	cpu_buffer->commit_page = cpu_buffer->head_page;
 
 	INIT_LIST_HEAD(&cpu_buffer->reader_page->list);
 	INIT_LIST_HEAD(&cpu_buffer->new_pages);
-	local_set(&cpu_buffer->reader_page->write, 0);
-	local_set(&cpu_buffer->reader_page->entries, 0);
-	local_set(&cpu_buffer->reader_page->page->commit, 0);
-	cpu_buffer->reader_page->read = 0;
+	rb_clear_buffer_page(cpu_buffer->reader_page);
 
 	local_set(&cpu_buffer->entries_bytes, 0);
 	local_set(&cpu_buffer->overrun, 0);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5c1087df2f1c..27bbe180a2ef 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6679,6 +6679,7 @@ static int tracing_release_pipe(struct inode *inode, struct file *file)
 
 	free_cpumask_var(iter->started);
 	kfree(iter->fmt);
+	kfree(iter->temp);
 	mutex_destroy(&iter->mutex);
 	kfree(iter);
 
@@ -8061,7 +8062,7 @@ static const struct file_operations tracing_err_log_fops = {
 	.open           = tracing_err_log_open,
 	.write		= tracing_err_log_write,
 	.read           = seq_read,
-	.llseek         = seq_lseek,
+	.llseek         = tracing_lseek,
 	.release        = tracing_err_log_release,
 };
 
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 753fc536525d..d2370cdb4c1d 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -743,6 +743,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 	struct trace_eprobe *ep;
 	bool enabled;
 	int ret = 0;
+	int cnt = 0;
 
 	tp = trace_probe_primary_from_call(call);
 	if (WARN_ON_ONCE(!tp))
@@ -766,12 +767,25 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 		if (ret)
 			break;
 		enabled = true;
+		cnt++;
 	}
 
 	if (ret) {
 		/* Failed to enable one of them. Roll back all */
-		if (enabled)
-			disable_eprobe(ep, file->tr);
+		if (enabled) {
+			/*
+			 * It's a bug if one failed for something other than memory
+			 * not being available but another eprobe succeeded.
+			 */
+			WARN_ON_ONCE(ret != -ENOMEM);
+
+			list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
+				ep = container_of(pos, struct trace_eprobe, tp);
+				disable_eprobe(ep, file->tr);
+				if (!--cnt)
+					break;
+			}
+		}
 		if (file)
 			trace_probe_remove_file(tp, file);
 		else
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 75244d9e2bf9..105253b9bc31 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6555,13 +6555,15 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	if (get_named_trigger_data(trigger_data))
 		goto enable;
 
-	if (has_hist_vars(hist_data))
-		save_hist_vars(hist_data);
-
 	ret = create_actions(hist_data);
 	if (ret)
 		goto out_unreg;
 
+	if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
+		if (save_hist_vars(hist_data))
+			goto out_unreg;
+	}
+
 	ret = tracing_map_init(hist_data->map);
 	if (ret)
 		goto out_unreg;
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 625cab4b9d94..bff699fe9e71 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -707,6 +707,9 @@ static int user_field_set_string(struct ftrace_event_field *field,
 	pos += snprintf(buf + pos, LEN_OR_ZERO, " ");
 	pos += snprintf(buf + pos, LEN_OR_ZERO, "%s", field->name);
 
+	if (str_has_prefix(field->type, "struct "))
+		pos += snprintf(buf + pos, LEN_OR_ZERO, " %d", field->size);
+
 	if (colon)
 		pos += snprintf(buf + pos, LEN_OR_ZERO, ";");
 
@@ -1456,7 +1459,8 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 
 		if (unlikely(faulted))
 			return -EFAULT;
-	}
+	} else
+		return -EBADF;
 
 	return ret;
 }
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index b3bdb8ddb862..c293a607d536 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -143,6 +143,8 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 array:
 	/* the last stage: Loop on array */
 	if (code->op == FETCH_OP_LP_ARRAY) {
+		if (ret < 0)
+			ret = 0;
 		total += ret;
 		if (++i < code->param) {
 			code = s3;
@@ -204,11 +206,13 @@ store_trace_args(void *data, struct trace_probe *tp, void *rec,
 		if (unlikely(arg->dynamic))
 			*dl = make_data_loc(maxlen, dyndata - base);
 		ret = process_fetch_insn(arg->code, rec, dl, base);
-		if (unlikely(ret < 0 && arg->dynamic)) {
-			*dl = make_data_loc(0, dyndata - base);
-		} else {
-			dyndata += ret;
-			maxlen -= ret;
+		if (arg->dynamic) {
+			if (unlikely(ret < 0)) {
+				*dl = make_data_loc(0, dyndata - base);
+			} else {
+				dyndata += ret;
+				maxlen -= ret;
+			}
 		}
 	}
 }
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 4dd494f786bc..1e1557e42d2c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -698,12 +698,17 @@ static void clear_work_data(struct work_struct *work)
 	set_work_data(work, WORK_STRUCT_NO_POOL, 0);
 }
 
+static inline struct pool_workqueue *work_struct_pwq(unsigned long data)
+{
+	return (struct pool_workqueue *)(data & WORK_STRUCT_WQ_DATA_MASK);
+}
+
 static struct pool_workqueue *get_work_pwq(struct work_struct *work)
 {
 	unsigned long data = atomic_long_read(&work->data);
 
 	if (data & WORK_STRUCT_PWQ)
-		return (void *)(data & WORK_STRUCT_WQ_DATA_MASK);
+		return work_struct_pwq(data);
 	else
 		return NULL;
 }
@@ -731,8 +736,7 @@ static struct worker_pool *get_work_pool(struct work_struct *work)
 	assert_rcu_or_pool_mutex();
 
 	if (data & WORK_STRUCT_PWQ)
-		return ((struct pool_workqueue *)
-			(data & WORK_STRUCT_WQ_DATA_MASK))->pool;
+		return work_struct_pwq(data)->pool;
 
 	pool_id = data >> WORK_OFFQ_POOL_SHIFT;
 	if (pool_id == WORK_OFFQ_POOL_NONE)
@@ -753,8 +757,7 @@ static int get_work_pool_id(struct work_struct *work)
 	unsigned long data = atomic_long_read(&work->data);
 
 	if (data & WORK_STRUCT_PWQ)
-		return ((struct pool_workqueue *)
-			(data & WORK_STRUCT_WQ_DATA_MASK))->pool->id;
+		return work_struct_pwq(data)->pool->id;
 
 	return data >> WORK_OFFQ_POOL_SHIFT;
 }
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index abbcc1b0eec5..a898f05a2afd 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -629,4 +629,7 @@ void __hwasan_storeN_noabort(unsigned long addr, size_t size);
 
 void __hwasan_tag_memory(unsigned long addr, u8 tag, unsigned long size);
 
+void kasan_tag_mismatch(unsigned long addr, unsigned long access_info,
+			unsigned long ret_ip);
+
 #endif /* __MM_KASAN_KASAN_H */
diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index 3009028c4fa2..489baf2e6176 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -392,6 +392,8 @@ static int head_onwire_len(int ctrl_len, bool secure)
 	int head_len;
 	int rem_len;
 
+	BUG_ON(ctrl_len < 0 || ctrl_len > CEPH_MSG_MAX_CONTROL_LEN);
+
 	if (secure) {
 		head_len = CEPH_PREAMBLE_SECURE_LEN;
 		if (ctrl_len > CEPH_PREAMBLE_INLINE_LEN) {
@@ -410,6 +412,10 @@ static int head_onwire_len(int ctrl_len, bool secure)
 static int __tail_onwire_len(int front_len, int middle_len, int data_len,
 			     bool secure)
 {
+	BUG_ON(front_len < 0 || front_len > CEPH_MSG_MAX_FRONT_LEN ||
+	       middle_len < 0 || middle_len > CEPH_MSG_MAX_MIDDLE_LEN ||
+	       data_len < 0 || data_len > CEPH_MSG_MAX_DATA_LEN);
+
 	if (!front_len && !middle_len && !data_len)
 		return 0;
 
@@ -522,29 +528,34 @@ static int decode_preamble(void *p, struct ceph_frame_desc *desc)
 		desc->fd_aligns[i] = ceph_decode_16(&p);
 	}
 
-	/*
-	 * This would fire for FRAME_TAG_WAIT (it has one empty
-	 * segment), but we should never get it as client.
-	 */
-	if (!desc->fd_lens[desc->fd_seg_cnt - 1]) {
-		pr_err("last segment empty\n");
+	if (desc->fd_lens[0] < 0 ||
+	    desc->fd_lens[0] > CEPH_MSG_MAX_CONTROL_LEN) {
+		pr_err("bad control segment length %d\n", desc->fd_lens[0]);
 		return -EINVAL;
 	}
-
-	if (desc->fd_lens[0] > CEPH_MSG_MAX_CONTROL_LEN) {
-		pr_err("control segment too big %d\n", desc->fd_lens[0]);
+	if (desc->fd_lens[1] < 0 ||
+	    desc->fd_lens[1] > CEPH_MSG_MAX_FRONT_LEN) {
+		pr_err("bad front segment length %d\n", desc->fd_lens[1]);
 		return -EINVAL;
 	}
-	if (desc->fd_lens[1] > CEPH_MSG_MAX_FRONT_LEN) {
-		pr_err("front segment too big %d\n", desc->fd_lens[1]);
+	if (desc->fd_lens[2] < 0 ||
+	    desc->fd_lens[2] > CEPH_MSG_MAX_MIDDLE_LEN) {
+		pr_err("bad middle segment length %d\n", desc->fd_lens[2]);
 		return -EINVAL;
 	}
-	if (desc->fd_lens[2] > CEPH_MSG_MAX_MIDDLE_LEN) {
-		pr_err("middle segment too big %d\n", desc->fd_lens[2]);
+	if (desc->fd_lens[3] < 0 ||
+	    desc->fd_lens[3] > CEPH_MSG_MAX_DATA_LEN) {
+		pr_err("bad data segment length %d\n", desc->fd_lens[3]);
 		return -EINVAL;
 	}
-	if (desc->fd_lens[3] > CEPH_MSG_MAX_DATA_LEN) {
-		pr_err("data segment too big %d\n", desc->fd_lens[3]);
+
+	/*
+	 * This would fire for FRAME_TAG_WAIT (it has one empty
+	 * segment), but we should never get it as client.
+	 */
+	if (!desc->fd_lens[desc->fd_seg_cnt - 1]) {
+		pr_err("last segment empty, segment count %d\n",
+		       desc->fd_seg_cnt);
 		return -EINVAL;
 	}
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ef9772b12624..b6c16db86c71 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4042,6 +4042,11 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 
 	skb_push(skb, -skb_network_offset(skb) + offset);
 
+	/* Ensure the head is writeable before touching the shared info */
+	err = skb_unclone(skb, GFP_ATOMIC);
+	if (err)
+		goto err_linearize;
+
 	skb_shinfo(skb)->frag_list = NULL;
 
 	while (list_skb) {
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index e6c7edcf6834..51bfc74805ec 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -318,9 +318,8 @@ static void addrconf_del_dad_work(struct inet6_ifaddr *ifp)
 static void addrconf_mod_rs_timer(struct inet6_dev *idev,
 				  unsigned long when)
 {
-	if (!timer_pending(&idev->rs_timer))
+	if (!mod_timer(&idev->rs_timer, jiffies + when))
 		in6_dev_hold(idev);
-	mod_timer(&idev->rs_timer, jiffies + when);
 }
 
 static void addrconf_mod_dad_work(struct inet6_ifaddr *ifp,
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 9d92d51c4757..e2af7ab99282 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -422,7 +422,10 @@ static struct net_device *icmp6_dev(const struct sk_buff *skb)
 	if (unlikely(dev->ifindex == LOOPBACK_IFINDEX || netif_is_l3_master(skb->dev))) {
 		const struct rt6_info *rt6 = skb_rt6_info(skb);
 
-		if (rt6)
+		/* The destination could be an external IP in Ext Hdr (SRv6, RPL, etc.),
+		 * and ip6_null_entry could be set to skb if no route is found.
+		 */
+		if (rt6 && rt6->rt6i_idev)
 			dev = rt6->rt6i_idev->dev;
 	}
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index c029222ce46b..04f1d696503c 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -90,7 +90,7 @@ static u32 udp6_ehashfn(const struct net *net,
 	fhash = __ipv6_addr_jhash(faddr, udp_ipv6_hash_secret);
 
 	return __inet6_ehashfn(lhash, lport, fhash, fport,
-			       udp_ipv6_hash_secret + net_hash_mix(net));
+			       udp6_ehash_secret + net_hash_mix(net));
 }
 
 int udp_v6_get_port(struct sock *sk, unsigned short snum)
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 6447a09932f5..069c2659074b 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -611,14 +611,14 @@ static int ncsi_rsp_handler_snfc(struct ncsi_request *nr)
 	return 0;
 }
 
-/* Response handler for Mellanox command Get Mac Address */
-static int ncsi_rsp_handler_oem_mlx_gma(struct ncsi_request *nr)
+/* Response handler for Get Mac Address command */
+static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
 {
 	struct ncsi_dev_priv *ndp = nr->ndp;
 	struct net_device *ndev = ndp->ndev.dev;
-	const struct net_device_ops *ops = ndev->netdev_ops;
 	struct ncsi_rsp_oem_pkt *rsp;
 	struct sockaddr saddr;
+	u32 mac_addr_off = 0;
 	int ret = 0;
 
 	/* Get the response header */
@@ -626,11 +626,25 @@ static int ncsi_rsp_handler_oem_mlx_gma(struct ncsi_request *nr)
 
 	saddr.sa_family = ndev->type;
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
-	memcpy(saddr.sa_data, &rsp->data[MLX_MAC_ADDR_OFFSET], ETH_ALEN);
+	if (mfr_id == NCSI_OEM_MFR_BCM_ID)
+		mac_addr_off = BCM_MAC_ADDR_OFFSET;
+	else if (mfr_id == NCSI_OEM_MFR_MLX_ID)
+		mac_addr_off = MLX_MAC_ADDR_OFFSET;
+	else if (mfr_id == NCSI_OEM_MFR_INTEL_ID)
+		mac_addr_off = INTEL_MAC_ADDR_OFFSET;
+
+	memcpy(saddr.sa_data, &rsp->data[mac_addr_off], ETH_ALEN);
+	if (mfr_id == NCSI_OEM_MFR_BCM_ID || mfr_id == NCSI_OEM_MFR_INTEL_ID)
+		eth_addr_inc((u8 *)saddr.sa_data);
+	if (!is_valid_ether_addr((const u8 *)saddr.sa_data))
+		return -ENXIO;
+
 	/* Set the flag for GMA command which should only be called once */
 	ndp->gma_flag = 1;
 
-	ret = ops->ndo_set_mac_address(ndev, &saddr);
+	rtnl_lock();
+	ret = dev_set_mac_address(ndev, &saddr, NULL);
+	rtnl_unlock();
 	if (ret < 0)
 		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");
 
@@ -649,41 +663,10 @@ static int ncsi_rsp_handler_oem_mlx(struct ncsi_request *nr)
 
 	if (mlx->cmd == NCSI_OEM_MLX_CMD_GMA &&
 	    mlx->param == NCSI_OEM_MLX_CMD_GMA_PARAM)
-		return ncsi_rsp_handler_oem_mlx_gma(nr);
+		return ncsi_rsp_handler_oem_gma(nr, NCSI_OEM_MFR_MLX_ID);
 	return 0;
 }
 
-/* Response handler for Broadcom command Get Mac Address */
-static int ncsi_rsp_handler_oem_bcm_gma(struct ncsi_request *nr)
-{
-	struct ncsi_dev_priv *ndp = nr->ndp;
-	struct net_device *ndev = ndp->ndev.dev;
-	const struct net_device_ops *ops = ndev->netdev_ops;
-	struct ncsi_rsp_oem_pkt *rsp;
-	struct sockaddr saddr;
-	int ret = 0;
-
-	/* Get the response header */
-	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
-
-	saddr.sa_family = ndev->type;
-	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
-	memcpy(saddr.sa_data, &rsp->data[BCM_MAC_ADDR_OFFSET], ETH_ALEN);
-	/* Increase mac address by 1 for BMC's address */
-	eth_addr_inc((u8 *)saddr.sa_data);
-	if (!is_valid_ether_addr((const u8 *)saddr.sa_data))
-		return -ENXIO;
-
-	/* Set the flag for GMA command which should only be called once */
-	ndp->gma_flag = 1;
-
-	ret = ops->ndo_set_mac_address(ndev, &saddr);
-	if (ret < 0)
-		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");
-
-	return ret;
-}
-
 /* Response handler for Broadcom card */
 static int ncsi_rsp_handler_oem_bcm(struct ncsi_request *nr)
 {
@@ -695,42 +678,10 @@ static int ncsi_rsp_handler_oem_bcm(struct ncsi_request *nr)
 	bcm = (struct ncsi_rsp_oem_bcm_pkt *)(rsp->data);
 
 	if (bcm->type == NCSI_OEM_BCM_CMD_GMA)
-		return ncsi_rsp_handler_oem_bcm_gma(nr);
+		return ncsi_rsp_handler_oem_gma(nr, NCSI_OEM_MFR_BCM_ID);
 	return 0;
 }
 
-/* Response handler for Intel command Get Mac Address */
-static int ncsi_rsp_handler_oem_intel_gma(struct ncsi_request *nr)
-{
-	struct ncsi_dev_priv *ndp = nr->ndp;
-	struct net_device *ndev = ndp->ndev.dev;
-	const struct net_device_ops *ops = ndev->netdev_ops;
-	struct ncsi_rsp_oem_pkt *rsp;
-	struct sockaddr saddr;
-	int ret = 0;
-
-	/* Get the response header */
-	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
-
-	saddr.sa_family = ndev->type;
-	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
-	memcpy(saddr.sa_data, &rsp->data[INTEL_MAC_ADDR_OFFSET], ETH_ALEN);
-	/* Increase mac address by 1 for BMC's address */
-	eth_addr_inc((u8 *)saddr.sa_data);
-	if (!is_valid_ether_addr((const u8 *)saddr.sa_data))
-		return -ENXIO;
-
-	/* Set the flag for GMA command which should only be called once */
-	ndp->gma_flag = 1;
-
-	ret = ops->ndo_set_mac_address(ndev, &saddr);
-	if (ret < 0)
-		netdev_warn(ndev,
-			    "NCSI: 'Writing mac address to device failed\n");
-
-	return ret;
-}
-
 /* Response handler for Intel card */
 static int ncsi_rsp_handler_oem_intel(struct ncsi_request *nr)
 {
@@ -742,7 +693,7 @@ static int ncsi_rsp_handler_oem_intel(struct ncsi_request *nr)
 	intel = (struct ncsi_rsp_oem_intel_pkt *)(rsp->data);
 
 	if (intel->cmd == NCSI_OEM_INTEL_CMD_GMA)
-		return ncsi_rsp_handler_oem_intel_gma(nr);
+		return ncsi_rsp_handler_oem_gma(nr, NCSI_OEM_MFR_INTEL_ID);
 
 	return 0;
 }
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 3de72e7c1075..10e6ec0f9498 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -793,6 +793,16 @@ static int fl_set_key_port_range(struct nlattr **tb, struct fl_flow_key *key,
 		       TCA_FLOWER_KEY_PORT_SRC_MAX, &mask->tp_range.tp_max.src,
 		       TCA_FLOWER_UNSPEC, sizeof(key->tp_range.tp_max.src));
 
+	if (mask->tp_range.tp_min.dst != mask->tp_range.tp_max.dst) {
+		NL_SET_ERR_MSG(extack,
+			       "Both min and max destination ports must be specified");
+		return -EINVAL;
+	}
+	if (mask->tp_range.tp_min.src != mask->tp_range.tp_max.src) {
+		NL_SET_ERR_MSG(extack,
+			       "Both min and max source ports must be specified");
+		return -EINVAL;
+	}
 	if (mask->tp_range.tp_min.dst && mask->tp_range.tp_max.dst &&
 	    ntohs(key->tp_range.tp_max.dst) <=
 	    ntohs(key->tp_range.tp_min.dst)) {
diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index a32351da968c..1212b057b129 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -210,11 +210,6 @@ static int fw_set_parms(struct net *net, struct tcf_proto *tp,
 	if (err < 0)
 		return err;
 
-	if (tb[TCA_FW_CLASSID]) {
-		f->res.classid = nla_get_u32(tb[TCA_FW_CLASSID]);
-		tcf_bind_filter(tp, &f->res, base);
-	}
-
 	if (tb[TCA_FW_INDEV]) {
 		int ret;
 		ret = tcf_change_indev(net, tb[TCA_FW_INDEV], extack);
@@ -231,6 +226,11 @@ static int fw_set_parms(struct net *net, struct tcf_proto *tp,
 	} else if (head->mask != 0xFFFFFFFF)
 		return err;
 
+	if (tb[TCA_FW_CLASSID]) {
+		f->res.classid = nla_get_u32(tb[TCA_FW_CLASSID]);
+		tcf_bind_filter(tp, &f->res, base);
+	}
+
 	return 0;
 }
 
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 02098a02943e..e150d08f182d 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -113,6 +113,7 @@
 
 #define QFQ_MTU_SHIFT		16	/* to support TSO/GSO */
 #define QFQ_MIN_LMAX		512	/* see qfq_slot_insert */
+#define QFQ_MAX_LMAX		(1UL << QFQ_MTU_SHIFT)
 
 #define QFQ_MAX_AGG_CLASSES	8 /* max num classes per aggregate allowed */
 
@@ -214,9 +215,14 @@ static struct qfq_class *qfq_find_class(struct Qdisc *sch, u32 classid)
 	return container_of(clc, struct qfq_class, common);
 }
 
+static struct netlink_range_validation lmax_range = {
+	.min = QFQ_MIN_LMAX,
+	.max = QFQ_MAX_LMAX,
+};
+
 static const struct nla_policy qfq_policy[TCA_QFQ_MAX + 1] = {
-	[TCA_QFQ_WEIGHT] = { .type = NLA_U32 },
-	[TCA_QFQ_LMAX] = { .type = NLA_U32 },
+	[TCA_QFQ_WEIGHT] = NLA_POLICY_RANGE(NLA_U32, 1, QFQ_MAX_WEIGHT),
+	[TCA_QFQ_LMAX] = NLA_POLICY_FULL_RANGE(NLA_U32, &lmax_range),
 };
 
 /*
@@ -375,8 +381,13 @@ static int qfq_change_agg(struct Qdisc *sch, struct qfq_class *cl, u32 weight,
 			   u32 lmax)
 {
 	struct qfq_sched *q = qdisc_priv(sch);
-	struct qfq_aggregate *new_agg = qfq_find_agg(q, lmax, weight);
+	struct qfq_aggregate *new_agg;
+
+	/* 'lmax' can range from [QFQ_MIN_LMAX, pktlen + stab overhead] */
+	if (lmax > QFQ_MAX_LMAX)
+		return -EINVAL;
 
+	new_agg = qfq_find_agg(q, lmax, weight);
 	if (new_agg == NULL) { /* create new aggregate */
 		new_agg = kzalloc(sizeof(*new_agg), GFP_ATOMIC);
 		if (new_agg == NULL)
@@ -408,27 +419,25 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	}
 
 	err = nla_parse_nested_deprecated(tb, TCA_QFQ_MAX, tca[TCA_OPTIONS],
-					  qfq_policy, NULL);
+					  qfq_policy, extack);
 	if (err < 0)
 		return err;
 
-	if (tb[TCA_QFQ_WEIGHT]) {
+	if (tb[TCA_QFQ_WEIGHT])
 		weight = nla_get_u32(tb[TCA_QFQ_WEIGHT]);
-		if (!weight || weight > (1UL << QFQ_MAX_WSHIFT)) {
-			pr_notice("qfq: invalid weight %u\n", weight);
-			return -EINVAL;
-		}
-	} else
+	else
 		weight = 1;
 
-	if (tb[TCA_QFQ_LMAX])
+	if (tb[TCA_QFQ_LMAX]) {
 		lmax = nla_get_u32(tb[TCA_QFQ_LMAX]);
-	else
+	} else {
+		/* MTU size is user controlled */
 		lmax = psched_mtu(qdisc_dev(sch));
-
-	if (lmax < QFQ_MIN_LMAX || lmax > (1UL << QFQ_MTU_SHIFT)) {
-		pr_notice("qfq: invalid max length %u\n", lmax);
-		return -EINVAL;
+		if (lmax < QFQ_MIN_LMAX || lmax > QFQ_MAX_LMAX) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "MTU size out of bounds for qfq");
+			return -EINVAL;
+		}
 	}
 
 	inv_w = ONE_FP / weight;
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index 6690468c5cc2..14c6859e1ac4 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -5,14 +5,14 @@
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
 
-extern void my_direct_func(struct vm_area_struct *vma,
-			   unsigned long address, unsigned int flags);
+extern void my_direct_func(struct vm_area_struct *vma, unsigned long address,
+			   unsigned int flags, struct pt_regs *regs);
 
-void my_direct_func(struct vm_area_struct *vma,
-			unsigned long address, unsigned int flags)
+void my_direct_func(struct vm_area_struct *vma, unsigned long address,
+		    unsigned int flags, struct pt_regs *regs)
 {
-	trace_printk("handle mm fault vma=%p address=%lx flags=%x\n",
-		     vma, address, flags);
+	trace_printk("handle mm fault vma=%p address=%lx flags=%x regs=%p\n",
+		     vma, address, flags, regs);
 }
 
 extern void my_tramp(void *);
@@ -32,7 +32,9 @@ asm (
 "	pushq %rdi\n"
 "	pushq %rsi\n"
 "	pushq %rdx\n"
+"	pushq %rcx\n"
 "	call my_direct_func\n"
+"	popq %rcx\n"
 "	popq %rdx\n"
 "	popq %rsi\n"
 "	popq %rdi\n"
diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 6032f9b23c4c..e317c2e44dae 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -6,6 +6,7 @@ CONFIG_INET_DIAG=m
 CONFIG_INET_MPTCP_DIAG=m
 CONFIG_VETH=y
 CONFIG_NET_SCH_NETEM=m
+CONFIG_SYN_COOKIES=y
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NETFILTER_NETLINK=m
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 36dc2bab7a13..18c9b00ca058 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -719,6 +719,7 @@ table inet mangle {
 EOF
 	if [ $? -ne 0 ]; then
 		echo "SKIP: $msg, could not load nft ruleset"
+		mptcp_lib_fail_if_expected_feature "nft rules"
 		return
 	fi
 
@@ -734,6 +735,7 @@ EOF
 	if [ $? -ne 0 ]; then
 		ip netns exec "$listener_ns" nft flush ruleset
 		echo "SKIP: $msg, ip $r6flag rule failed"
+		mptcp_lib_fail_if_expected_feature "ip rule"
 		return
 	fi
 
@@ -742,6 +744,7 @@ EOF
 		ip netns exec "$listener_ns" nft flush ruleset
 		ip -net "$listener_ns" $r6flag rule del fwmark 1 lookup 100
 		echo "SKIP: $msg, ip route add local $local_addr failed"
+		mptcp_lib_fail_if_expected_feature "ip route"
 		return
 	fi
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index a493eaf8633f..af4fccd4f5cc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -121,6 +121,7 @@ check_mark()
 	for v in $values; do
 		if [ $v -ne 0 ]; then
 			echo "FAIL: got $tables $values in ns $ns , not 0 - not all expected packets marked" 1>&2
+			ret=1
 			return 1
 		fi
 	done
@@ -220,11 +221,11 @@ do_transfer()
 	fi
 
 	if [ $local_addr = "::" ];then
-		check_mark $listener_ns 6
-		check_mark $connector_ns 6
+		check_mark $listener_ns 6 || retc=1
+		check_mark $connector_ns 6 || retc=1
 	else
-		check_mark $listener_ns 4
-		check_mark $connector_ns 4
+		check_mark $listener_ns 4 || retc=1
+		check_mark $connector_ns 4 || retc=1
 	fi
 
 	check_transfer $cin $sout "file received by server"
diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index abddf4c63e79..1887bd61bd9a 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -425,7 +425,7 @@ int dsf(int fd, int pm_family, int argc, char *argv[])
 	}
 
 	/* token */
-	token = atoi(params[4]);
+	token = strtoul(params[4], NULL, 10);
 	rta = (void *)(data + off);
 	rta->rta_type = MPTCP_PM_ATTR_TOKEN;
 	rta->rta_len = RTA_LENGTH(4);
@@ -551,7 +551,7 @@ int csf(int fd, int pm_family, int argc, char *argv[])
 	}
 
 	/* token */
-	token = atoi(params[4]);
+	token = strtoul(params[4], NULL, 10);
 	rta = (void *)(data + off);
 	rta->rta_type = MPTCP_PM_ATTR_TOKEN;
 	rta->rta_len = RTA_LENGTH(4);
@@ -598,7 +598,7 @@ int remove_addr(int fd, int pm_family, int argc, char *argv[])
 			if (++arg >= argc)
 				error(1, 0, " missing token value");
 
-			token = atoi(argv[arg]);
+			token = strtoul(argv[arg], NULL, 10);
 			rta = (void *)(data + off);
 			rta->rta_type = MPTCP_PM_ATTR_TOKEN;
 			rta->rta_len = RTA_LENGTH(4);
@@ -710,7 +710,7 @@ int announce_addr(int fd, int pm_family, int argc, char *argv[])
 			if (++arg >= argc)
 				error(1, 0, " missing token value");
 
-			token = atoi(argv[arg]);
+			token = strtoul(argv[arg], NULL, 10);
 		} else
 			error(1, 0, "unknown keyword %s", argv[arg]);
 	}
@@ -1347,7 +1347,7 @@ int set_flags(int fd, int pm_family, int argc, char *argv[])
 				error(1, 0, " missing token value");
 
 			/* token */
-			token = atoi(argv[arg]);
+			token = strtoul(argv[arg], NULL, 10);
 		} else if (!strcmp(argv[arg], "flags")) {
 			char *tok, *str;
 
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index eb0f4f6afebd..cb6c28d40129 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -387,6 +387,7 @@ test_remove()
 		stdbuf -o0 -e0 printf "[OK]\n"
 	else
 		stdbuf -o0 -e0 printf "[FAIL]\n"
+		exit 1
 	fi
 
 	# RM_ADDR using an invalid addr id should result in no action
@@ -401,6 +402,7 @@ test_remove()
 		stdbuf -o0 -e0 printf "[OK]\n"
 	else
 		stdbuf -o0 -e0 printf "[FAIL]\n"
+		exit 1
 	fi
 
 	# RM_ADDR from the client to server machine
@@ -847,7 +849,7 @@ test_prio()
 	local count
 
 	# Send MP_PRIO signal from client to server machine
-	ip netns exec "$ns2" ./pm_nl_ctl set 10.0.1.2 port "$client4_port" flags backup token "$client4_token" rip 10.0.1.1 rport "$server4_port"
+	ip netns exec "$ns2" ./pm_nl_ctl set 10.0.1.2 port "$client4_port" flags backup token "$client4_token" rip 10.0.1.1 rport "$app4_port"
 	sleep 0.5
 
 	# Check TX
