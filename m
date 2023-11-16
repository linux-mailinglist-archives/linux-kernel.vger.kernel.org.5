Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40A47ED998
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 03:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344559AbjKPCdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 21:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjKPCdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 21:33:10 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2DBC19E;
        Wed, 15 Nov 2023 18:33:05 -0800 (PST)
Received: from loongson.cn (unknown [10.2.5.213])
        by gateway (Coremail) with SMTP id _____8AxDOtgf1Vln3A6AA--.44713S3;
        Thu, 16 Nov 2023 10:33:04 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxnd5df1Vl9p9DAA--.18774S4;
        Thu, 16 Nov 2023 10:33:04 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Tianrui Zhao <zhaotianrui@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] LoongArch: KVM: Allow to access HW timer CSR registers always
Date:   Thu, 16 Nov 2023 10:30:35 +0800
Message-Id: <20231116023036.2324371-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231116023036.2324371-1-maobibo@loongson.cn>
References: <20231116023036.2324371-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxnd5df1Vl9p9DAA--.18774S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFW7XFyDXw47WrW7CF13KFX_yoW5JrWDpr
        ZIkF9rtr48KryqgFyDJrs8uF15CrZ7K34xWFy7ArW2yr12vw1rJFykG3s7XFWYqa4SqFWS
        vryrCwn0vF4DXwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1a6r1DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
        14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IUbCzuJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently HW timer CSR registers are allowed to access before entering to
vm and disabled if switch to SW timer in host mode, instead it is not
necessary to do so. HW timer CSR registers can be accessed always, it
is nothing to do with whether it is in vm mode or host mode. This patch
removes the limitation.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/main.c  |  1 -
 arch/loongarch/kvm/timer.c | 27 ++++++---------------------
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index 1c1d5199500e..86a2f2d0cb27 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -287,7 +287,6 @@ int kvm_arch_hardware_enable(void)
 	if (env & CSR_GCFG_MATC_ROOT)
 		gcfg |= CSR_GCFG_MATC_ROOT;
 
-	gcfg |= CSR_GCFG_TIT;
 	write_csr_gcfg(gcfg);
 
 	kvm_flush_tlb_all();
diff --git a/arch/loongarch/kvm/timer.c b/arch/loongarch/kvm/timer.c
index 437e960d8fdb..e37c0ebffabd 100644
--- a/arch/loongarch/kvm/timer.c
+++ b/arch/loongarch/kvm/timer.c
@@ -70,15 +70,6 @@ void kvm_init_timer(struct kvm_vcpu *vcpu, unsigned long timer_hz)
  */
 void kvm_acquire_timer(struct kvm_vcpu *vcpu)
 {
-	unsigned long cfg;
-
-	cfg = read_csr_gcfg();
-	if (!(cfg & CSR_GCFG_TIT))
-		return;
-
-	/* Enable guest access to hard timer */
-	write_csr_gcfg(cfg & ~CSR_GCFG_TIT);
-
 	/*
 	 * Freeze the soft-timer and sync the guest stable timer with it. We do
 	 * this with interrupts disabled to avoid latency.
@@ -175,21 +166,15 @@ static void _kvm_save_timer(struct kvm_vcpu *vcpu)
  */
 void kvm_save_timer(struct kvm_vcpu *vcpu)
 {
-	unsigned long cfg;
 	struct loongarch_csrs *csr = vcpu->arch.csr;
 
 	preempt_disable();
-	cfg = read_csr_gcfg();
-	if (!(cfg & CSR_GCFG_TIT)) {
-		/* Disable guest use of hard timer */
-		write_csr_gcfg(cfg | CSR_GCFG_TIT);
-
-		/* Save hard timer state */
-		kvm_save_hw_gcsr(csr, LOONGARCH_CSR_TCFG);
-		kvm_save_hw_gcsr(csr, LOONGARCH_CSR_TVAL);
-		if (kvm_read_sw_gcsr(csr, LOONGARCH_CSR_TCFG) & CSR_TCFG_EN)
-			_kvm_save_timer(vcpu);
-	}
+
+	/* Save hard timer state */
+	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_TCFG);
+	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_TVAL);
+	if (kvm_read_sw_gcsr(csr, LOONGARCH_CSR_TCFG) & CSR_TCFG_EN)
+		_kvm_save_timer(vcpu);
 
 	/* Save timer-related state to vCPU context */
 	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_ESTAT);
-- 
2.39.3

