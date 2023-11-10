Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8D97E7EBF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344617AbjKJRrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbjKJRqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:46:01 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B8E7AFBD;
        Fri, 10 Nov 2023 01:07:56 -0800 (PST)
Received: from loongson.cn (unknown [10.2.5.213])
        by gateway (Coremail) with SMTP id _____8CxtPDr8k1lTrI4AA--.47018S3;
        Fri, 10 Nov 2023 17:07:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxkN3q8k1l6vU9AA--.7142S3;
        Fri, 10 Nov 2023 17:07:54 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Tianrui Zhao <zhaotianrui@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] LoongArch: KVM: Remove SW timer switch when vcpu is halt polling
Date:   Fri, 10 Nov 2023 17:05:27 +0800
Message-Id: <20231110090529.56950-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231110090529.56950-1-maobibo@loongson.cn>
References: <20231110090529.56950-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxkN3q8k1l6vU9AA--.7142S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur48Gr45Cr4DGFW7Kr4xZrc_yoW8KF4xpa
        yakFnIqr4rGrnrK3sxJa1kur47Xw4kKF1fXa9rAay5Ar1qyF10qF48trWqqFy5Kw4rAFyS
        vr1rKa45u3WYy3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjOJ5UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With halt-polling supported, there is checking for pending events
or interrupts when vcpu executes idle instruction. Pending interrupts
include injected SW interrupts and passthrough HW interrupts, such as
HW timer interrupts, since HW timer works still even if vcpu exists
from VM mode.

Since HW timer pending interrupt can be set directly with CSR status
register, and pending HW timer interrupt checking is used in vcpu block
checking function, it is not necessary to switch to sw timer during
halt-polling. This patch adds preemption disabling in function
kvm_cpu_has_pending_timer, and removes SW timer switching in idle
instruction emulation function.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/exit.c | 13 ++-----------
 arch/loongarch/kvm/vcpu.c |  9 ++++++++-
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
index ce8de3fa472c..e708a1786d6b 100644
--- a/arch/loongarch/kvm/exit.c
+++ b/arch/loongarch/kvm/exit.c
@@ -200,17 +200,8 @@ int kvm_emu_idle(struct kvm_vcpu *vcpu)
 	++vcpu->stat.idle_exits;
 	trace_kvm_exit_idle(vcpu, KVM_TRACE_EXIT_IDLE);
 
-	if (!kvm_arch_vcpu_runnable(vcpu)) {
-		/*
-		 * Switch to the software timer before halt-polling/blocking as
-		 * the guest's timer may be a break event for the vCPU, and the
-		 * hypervisor timer runs only when the CPU is in guest mode.
-		 * Switch before halt-polling so that KVM recognizes an expired
-		 * timer before blocking.
-		 */
-		kvm_save_timer(vcpu);
-		kvm_vcpu_block(vcpu);
-	}
+	if (!kvm_arch_vcpu_runnable(vcpu))
+		kvm_vcpu_halt(vcpu);
 
 	return EMULATE_DONE;
 }
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 73d0c2b9c1a5..42663a345bd1 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -187,8 +187,15 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 
 int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
 {
-	return kvm_pending_timer(vcpu) ||
+	int ret;
+
+	/* protect from TOD sync and vcpu_load/put */
+	preempt_disable();
+	ret = kvm_pending_timer(vcpu) ||
 		kvm_read_hw_gcsr(LOONGARCH_CSR_ESTAT) & (1 << INT_TI);
+	preempt_enable();
+
+	return ret;
 }
 
 int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu)
-- 
2.39.3

