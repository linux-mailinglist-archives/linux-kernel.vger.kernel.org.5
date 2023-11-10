Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E737E7E6F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343910AbjKJRox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345618AbjKJRny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:43:54 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 019A6AFBF;
        Fri, 10 Nov 2023 01:07:58 -0800 (PST)
Received: from loongson.cn (unknown [10.2.5.213])
        by gateway (Coremail) with SMTP id _____8Cxruvr8k1lWLI4AA--.43156S3;
        Fri, 10 Nov 2023 17:07:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxkN3q8k1l6vU9AA--.7142S5;
        Fri, 10 Nov 2023 17:07:55 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Tianrui Zhao <zhaotianrui@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] LoongArch: KVM: Remove kvm_acquire_timer before entering guest
Date:   Fri, 10 Nov 2023 17:05:29 +0800
Message-Id: <20231110090529.56950-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231110090529.56950-1-maobibo@loongson.cn>
References: <20231110090529.56950-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxkN3q8k1l6vU9AA--.7142S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAryUAry3ZFyftw17Gw13ZFc_yoWruF1DpF
        Z7urnFqw4rJr45Gw1jy3Wkur45XrWkKr13Xa4kJrWFyrnIyr15XF4kGrZ5XFW3J3yIyF1S
        vryrtw13ZF4DAwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
        67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUco7KUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Timer emulation method in VM is switch to SW timer, there are two
places where timer emulation is needed. One is during vcpu thread
context switch, the other is halt-polling with idle instruction
emulation. SW timer switching is remove during halt-polling mode,
so it is not necessary to disable SW timer before entering to guest.

This patch removes SW timer handling before entering guest mode, and
put it in HW timer restoring flow when vcpu thread is sched-in. With
this patch, vm timer emulation is simpler, there is SW/HW timer
switch only in vcpu thread context switch scenario.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/kvm_vcpu.h |  1 -
 arch/loongarch/kvm/timer.c            | 20 ++++++------------
 arch/loongarch/kvm/vcpu.c             | 29 ---------------------------
 3 files changed, 6 insertions(+), 44 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_vcpu.h b/arch/loongarch/include/asm/kvm_vcpu.h
index 553cfa2b2b1c..0e87652f780a 100644
--- a/arch/loongarch/include/asm/kvm_vcpu.h
+++ b/arch/loongarch/include/asm/kvm_vcpu.h
@@ -55,7 +55,6 @@ void kvm_save_fpu(struct loongarch_fpu *fpu);
 void kvm_restore_fpu(struct loongarch_fpu *fpu);
 void kvm_restore_fcsr(struct loongarch_fpu *fpu);
 
-void kvm_acquire_timer(struct kvm_vcpu *vcpu);
 void kvm_init_timer(struct kvm_vcpu *vcpu, unsigned long hz);
 void kvm_reset_timer(struct kvm_vcpu *vcpu);
 void kvm_save_timer(struct kvm_vcpu *vcpu);
diff --git a/arch/loongarch/kvm/timer.c b/arch/loongarch/kvm/timer.c
index 1d29bd21a9da..9e66939ec69a 100644
--- a/arch/loongarch/kvm/timer.c
+++ b/arch/loongarch/kvm/timer.c
@@ -64,19 +64,6 @@ void kvm_init_timer(struct kvm_vcpu *vcpu, unsigned long timer_hz)
 	kvm_write_sw_gcsr(vcpu->arch.csr, LOONGARCH_CSR_TVAL, 0);
 }
 
-/*
- * Restore hard timer state and enable guest to access timer registers
- * without trap, should be called with irq disabled
- */
-void kvm_acquire_timer(struct kvm_vcpu *vcpu)
-{
-	/*
-	 * Freeze the soft-timer and sync the guest stable timer with it. We do
-	 * this with interrupts disabled to avoid latency.
-	 */
-	hrtimer_cancel(&vcpu->arch.swtimer);
-}
-
 /*
  * Restore soft timer state from saved context.
  */
@@ -115,12 +102,17 @@ void kvm_restore_timer(struct kvm_vcpu *vcpu)
 		/*
 		 * Inject timer here though sw timer should inject timer
 		 * interrupt async already, since sw timer may be cancelled
-		 * during injecting intr async in function kvm_acquire_timer
+		 * during injecting intr async
 		 */
 		kvm_queue_irq(vcpu, INT_TI);
 	}
 
 	write_gcsr_timertick(delta);
+
+	/*
+	 * Freeze the soft-timer and sync the guest stable timer with it.
+	 */
+	hrtimer_cancel(&vcpu->arch.swtimer);
 }
 
 /*
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 42663a345bd1..cf1c4d64c1b7 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -95,7 +95,6 @@ static int kvm_pre_enter_guest(struct kvm_vcpu *vcpu)
 		 * check vmid before vcpu enter guest
 		 */
 		local_irq_disable();
-		kvm_acquire_timer(vcpu);
 		kvm_deliver_intr(vcpu);
 		kvm_deliver_exception(vcpu);
 		/* Make sure the vcpu mode has been written */
@@ -251,23 +250,6 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 	return -EINVAL;
 }
 
-/**
- * kvm_migrate_count() - Migrate timer.
- * @vcpu:       Virtual CPU.
- *
- * Migrate hrtimer to the current CPU by cancelling and restarting it
- * if the hrtimer is active.
- *
- * Must be called when the vCPU is migrated to a different CPU, so that
- * the timer can interrupt the guest at the new CPU, and the timer irq can
- * be delivered to the vCPU.
- */
-static void kvm_migrate_count(struct kvm_vcpu *vcpu)
-{
-	if (hrtimer_cancel(&vcpu->arch.swtimer))
-		hrtimer_restart(&vcpu->arch.swtimer);
-}
-
 static int _kvm_getcsr(struct kvm_vcpu *vcpu, unsigned int id, u64 *val)
 {
 	unsigned long gintc;
@@ -796,17 +778,6 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	if (vcpu->arch.last_sched_cpu != cpu) {
-		kvm_debug("[%d->%d]KVM vCPU[%d] switch\n",
-				vcpu->arch.last_sched_cpu, cpu, vcpu->vcpu_id);
-		/*
-		 * Migrate the timer interrupt to the current CPU so that it
-		 * always interrupts the guest and synchronously triggers a
-		 * guest timer interrupt.
-		 */
-		kvm_migrate_count(vcpu);
-	}
-
 	/* Restore guest state to registers */
 	_kvm_vcpu_load(vcpu, cpu);
 	local_irq_restore(flags);
-- 
2.39.3

