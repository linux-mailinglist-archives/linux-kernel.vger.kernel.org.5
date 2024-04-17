Return-Path: <linux-kernel+bounces-148284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB9B8A803D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500D31F22ABF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1C913AA46;
	Wed, 17 Apr 2024 10:00:00 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2543127B45
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713347999; cv=none; b=oohh7D9EfpIAOukaM7UcrUbxKitriIim+QLOMnnjOBOsjPI37N20Yyr3h9YSKsIZ6WLf5QFHVoG5x3gAKB9ShvA5NNnwmp1FK6fF4uhODWrwvlVc7AQpPtUEeFl7pwu3sIMk6Mv1dDYPNVRU1kEqFQF2oZ/5tLm7I4tkuG5mwpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713347999; c=relaxed/simple;
	bh=4OHXa+TBQH27mQewJxobd0zpOvxg3J/Dc9Jj/i9H0L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kou4CPlbZz5KX2OQaekS6x9g5sKpl2UTWPj0AWGfT1HsADrslqjPbEdZv2dLcFA2FTNHZMPY1Ir17G6qeIxjeGjW3HTjVWwnpmtHrqq76Ef3oWy43xXl4CgdB0C3liwOlHMU7S04w5hJA99h8lp5zKMmqoVPTqefCMmpHCkp+2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxmfCbnR9mIrgoAA--.27331S3;
	Wed, 17 Apr 2024 17:59:55 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxKBKYnR9muOR9AA--.32535S4;
	Wed, 17 Apr 2024 17:59:54 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <maz@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn
Subject: [PATCH v4 2/3] LoongArch: Modify ACPI S3 state function for non-SMP
Date: Wed, 17 Apr 2024 17:59:50 +0800
Message-ID: <20240417095951.2635-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240417095951.2635-1-yangtiezhu@loongson.cn>
References: <20240417095951.2635-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxKBKYnR9muOR9AA--.32535S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WFyxAF4UCw13tFW8JF43Arc_yoW8Cw4kp3
	sFyayUtw48trn7CFn0qa1UWr4UZ393KrWIvFZFy3yj9rnxXFyIgr4Yg3Z8WF1Fqwn5uF40
	v3yFka4avF1UGwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU

Currently, per_cpu_offset(x) is defined as __per_cpu_offset[x])
only under CONFIG_SMP in include/asm-generic/percpu.h, that is
to say, the implementation of loongarch_common_resume() which
calls per_cpu_offset(0) is not suitable for the case of non-SMP,
so do not write per_cpu_offset(0) to PERCPU_BASE_KS when resume,
just save the value of PERCPU_BASE_KS when suspend and restore
it when resume to avoid compiling error for non-SMP and make it
work well for both SMP and non-SMP.

This is preparation for later patch. Tested with the command
"rtcwake -d rtc1 -s 20 -m mem", dmesg shows that "PM: suspend
entry (deep)" and "PM: suspend exit".

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/power/suspend.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/power/suspend.c b/arch/loongarch/power/suspend.c
index 166d9e06a64b..8571818b93dc 100644
--- a/arch/loongarch/power/suspend.c
+++ b/arch/loongarch/power/suspend.c
@@ -24,6 +24,7 @@ struct saved_registers {
 	u64 kpgd;
 	u32 pwctl0;
 	u32 pwctl1;
+	u64 pcpu_base;
 };
 static struct saved_registers saved_regs;
 
@@ -36,6 +37,7 @@ void loongarch_common_suspend(void)
 	saved_regs.pwctl1 = csr_read32(LOONGARCH_CSR_PWCTL1);
 	saved_regs.ecfg = csr_read32(LOONGARCH_CSR_ECFG);
 	saved_regs.euen = csr_read32(LOONGARCH_CSR_EUEN);
+	saved_regs.pcpu_base = csr_read64(PERCPU_BASE_KS);
 
 	loongarch_suspend_addr = loongson_sysconf.suspend_addr;
 }
@@ -44,7 +46,7 @@ void loongarch_common_resume(void)
 {
 	sync_counter();
 	local_flush_tlb_all();
-	csr_write64(per_cpu_offset(0), PERCPU_BASE_KS);
+	csr_write64(saved_regs.pcpu_base, PERCPU_BASE_KS);
 	csr_write64(eentry, LOONGARCH_CSR_EENTRY);
 	csr_write64(eentry, LOONGARCH_CSR_MERRENTRY);
 	csr_write64(tlbrentry, LOONGARCH_CSR_TLBRENTRY);
-- 
2.42.0


