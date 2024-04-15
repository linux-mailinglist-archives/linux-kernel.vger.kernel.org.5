Return-Path: <linux-kernel+bounces-144620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 433958A4872
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B665B235FF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2401A374CB;
	Mon, 15 Apr 2024 06:54:37 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B184A1F5E6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164076; cv=none; b=b9WPNCLy4cv0xSkU8JReVgC1lDg9HG4eImTIo81A/bBUdIJo3oKArh9cJwtE9rDPgtSuS0JyXUu5eDc2Jo2hKVpIlfEPV+L70ynJyPvHkaqdf7p8bBZ3RuTpjnCvypazaJH31pem+MWtKa6k6hS417RWzDy5ouA7ZjKKwaq3YWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164076; c=relaxed/simple;
	bh=DUknK6OMkLGCAt736I9+KxRyeX2BT6UFivLu3n5tfos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnWP4K+KXfQVoT4eMdyWVOiZ1STj1yHXiFGYfVCxgZ62Z/D5RuBnjuAa+xU9cYFwvouaOwEboicYzdkwttTns0l5m8N2KgUY6So635oD+9DX/BgFOLXBkFRl7bvJZkMGqcYtSfswJ82m5bSJOnXwNovaMcgTc1BjGgMfcbLL/3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VHyX41M3Yz1yp22;
	Mon, 15 Apr 2024 14:52:04 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 210591402C7;
	Mon, 15 Apr 2024 14:54:25 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Mon, 15 Apr
 2024 14:54:23 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <james.morse@arm.com>, <suzuki.poulose@arm.com>,
	<yuzenghui@huawei.com>, <tglx@linutronix.de>, <mark.rutland@arm.com>,
	<ardb@kernel.org>, <broonie@kernel.org>, <liaochang1@huawei.com>,
	<anshuman.khandual@arm.com>, <miguel.luis@oracle.com>, <joey.gouly@arm.com>,
	<ryan.roberts@arm.com>, <jeremy.linton@arm.com>, <ericchancf@google.com>,
	<kristina.martsenko@arm.com>, <robh@kernel.org>,
	<scott@os.amperecomputing.com>, <songshuaishuai@tinylab.org>,
	<shijie@os.amperecomputing.com>, <akpm@linux-foundation.org>,
	<bhe@redhat.com>, <horms@kernel.org>, <mhiramat@kernel.org>,
	<rmk+kernel@armlinux.org.uk>, <shahuang@redhat.com>,
	<takakura@valinux.co.jp>, <dianders@chromium.org>, <swboyd@chromium.org>,
	<sumit.garg@linaro.org>, <frederic@kernel.org>, <reijiw@google.com>,
	<akihiko.odaki@daynix.com>, <ruanjinjie@huawei.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kvmarm@lists.linux.dev>
Subject: [PATCH v3 4/8] arm64: daifflags: Add logical exception masks covering DAIF + PMR + ALLINT
Date: Mon, 15 Apr 2024 06:47:54 +0000
Message-ID: <20240415064758.3250209-5-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415064758.3250209-1-liaochang1@huawei.com>
References: <20240415064758.3250209-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200013.china.huawei.com (7.221.188.133)

In Mark Brown's support for FEAT_NMI patchset [1], Mark Rutland suggest
to refactor the way of DAIF management via adding new "logical exception
mask" helpers that treat DAIF + PMR + ALLINT as separate elements.

A series of new exception mask helpers that has a similar interface as
the existing counterparts, which starts with "local_allint_". The usage
and behavior of new ones suppose to align with the old ones, otherwise,
some unexpected result will occurs.

[1] https://lore.kernel.org/linux-arm-kernel/Y4sH5qX5bK9xfEBp@lpieralisi/

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/arm64/include/asm/daifflags.h   | 240 +++++++++++++++++++++++++++
 arch/arm64/include/uapi/asm/ptrace.h |   1 +
 2 files changed, 241 insertions(+)

diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index 55f57dfa8e2f..df4c4989babd 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -11,6 +11,7 @@
 #include <asm/barrier.h>
 #include <asm/cpufeature.h>
 #include <asm/ptrace.h>
+#include <asm/nmi.h>
 
 #define DAIF_PROCCTX		0
 #define DAIF_PROCCTX_NOIRQ	(PSR_I_BIT | PSR_F_BIT)
@@ -141,4 +142,243 @@ static inline void local_daif_inherit(struct pt_regs *regs)
 	 */
 	write_sysreg(flags, daif);
 }
+
+/*
+ * For Arm64 processor support Armv8.8 or later, kernel supports three types
+ * of irqflags, they used for corresponding configuration depicted as below:
+ *
+ * 1. When CONFIG_ARM64_PSEUDO_NMI and CONFIG_ARM64_NMI are not 'y', kernel
+ *    does not support handling NMI.
+ *
+ * 2. When CONFIG_ARM64_PSEUDO_NMI=y and irqchip.gicv3_pseudo_nmi=1, kernel
+ *    makes use of the CPU Interface PMR and GIC priority feature to support
+ *    handling NMI.
+ *
+ * 3. When CONFIG_ARM64_NMI=y and irqchip.gicv3_pseudo_nmi is not enabled,
+ *    kernel makes use of the FEAT_NMI extension added since Armv8.8 to
+ *    support handling NMI.
+ */
+union arch_irqflags {
+	unsigned long flags;
+	struct {
+		unsigned long pmr : 8;     // SYS_ICC_PMR_EL1
+		unsigned long daif : 10;   // PSTATE.DAIF at bits[6-9]
+		unsigned long allint : 14; // PSTATE.ALLINT at bits[13]
+	} fields;
+};
+
+typedef union arch_irqflags arch_irqflags_t;
+
+static inline void __pmr_local_allint_mask(void)
+{
+	WARN_ON(system_has_prio_mask_debugging() &&
+		(read_sysreg_s(SYS_ICC_PMR_EL1) ==
+		 (GIC_PRIO_IRQOFF | GIC_PRIO_PSR_I_SET)));
+	/*
+	 * Don't really care for a dsb here, we don't intend to enable
+	 * IRQs.
+	 */
+	gic_write_pmr(GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET);
+}
+
+static inline void __nmi_local_allint_mask(void)
+{
+	_allint_set();
+}
+
+static inline void local_allint_mask(void)
+{
+	asm volatile(
+		"msr	daifset, #0xf		// local_daif_mask\n"
+		:
+		:
+		: "memory");
+
+	if (system_uses_irq_prio_masking())
+		__pmr_local_allint_mask();
+	else if (system_uses_nmi())
+		__nmi_local_allint_mask();
+
+	trace_hardirqs_off();
+}
+
+static inline arch_irqflags_t __pmr_local_allint_save_flags(void)
+{
+	arch_irqflags_t irqflags;
+
+	irqflags.fields.pmr = read_sysreg_s(SYS_ICC_PMR_EL1);
+	irqflags.fields.daif = read_sysreg(daif);
+	irqflags.fields.allint = 0;
+	/*
+	 * If IRQs are masked with PMR, reflect it in the daif of irqflags.
+	 * If NMIs and IRQs are masked with PMR, reflect it in the daif and
+	 * allint of irqflags, this avoid the need of checking PSTATE.A in
+	 * local_allint_restore() to determine if NMIs are masked.
+	 */
+	switch (irqflags.fields.pmr) {
+	case GIC_PRIO_IRQON:
+		break;
+
+	case __GIC_PRIO_IRQOFF:
+	case __GIC_PRIO_IRQOFF_NS:
+		irqflags.fields.daif |= PSR_I_BIT | PSR_F_BIT;
+		break;
+
+	case GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET:
+		irqflags.fields.allint = 1;
+		break;
+
+	default:
+		WARN_ON(1);
+	}
+
+	return irqflags;
+}
+
+static inline arch_irqflags_t __nmi_local_allint_save_flags(void)
+{
+	arch_irqflags_t irqflags;
+
+	irqflags.fields.daif = read_sysreg(daif);
+	irqflags.fields.allint = read_sysreg_s(SYS_ALLINT);
+
+	return irqflags;
+}
+
+static inline arch_irqflags_t local_allint_save_flags(void)
+{
+	arch_irqflags_t irqflags = { .flags = 0UL };
+
+	if (system_uses_irq_prio_masking())
+		return __pmr_local_allint_save_flags();
+	else if (system_uses_nmi())
+		return __nmi_local_allint_save_flags();
+
+	irqflags.fields.daif = read_sysreg(daif);
+	return irqflags;
+}
+
+static inline arch_irqflags_t local_allint_save(void)
+{
+	arch_irqflags_t irqflags;
+
+	irqflags = local_allint_save_flags();
+
+	local_allint_mask();
+
+	return irqflags;
+}
+
+static inline void gic_pmr_prio_check(void)
+{
+	WARN_ON(system_has_prio_mask_debugging() &&
+		(read_sysreg(daif) & (PSR_I_BIT | PSR_F_BIT)) !=
+		(PSR_I_BIT | PSR_F_BIT));
+}
+
+static inline void __pmr_local_allint_restore(arch_irqflags_t irqflags)
+{
+	unsigned long pmr = irqflags.fields.pmr;
+	unsigned long daif = irqflags.fields.daif;
+	unsigned long allint = irqflags.fields.allint;
+
+	gic_pmr_prio_check();
+
+	gic_write_pmr(pmr);
+
+	if (!(daif & PSR_I_BIT)) {
+		pmr_sync();
+	} else if (!allint) {
+		/*
+		 * Use arch_allint.fields.allint to indicates we can take
+		 * NMIs, instead of the old hacking style that use PSTATE.A.
+		 *
+		 * There has been concern that the write to daif
+		 * might be reordered before this write to PMR.
+		 * From the ARM ARM DDI 0487D.a, section D1.7.1
+		 * "Accessing PSTATE fields":
+		 *   Writes to the PSTATE fields have side-effects on
+		 *   various aspects of the PE operation. All of these
+		 *   side-effects are guaranteed:
+		 *     - Not to be visible to earlier instructions in
+		 *       the execution stream.
+		 *     - To be visible to later instructions in the
+		 *       execution stream
+		 *
+		 * Also, writes to PMR are self-synchronizing, so no
+		 * interrupts with a lower priority than PMR is signaled
+		 * to the PE after the write.
+		 *
+		 * So we don't need additional synchronization here.
+		 */
+		daif &= ~(PSR_I_BIT | PSR_F_BIT);
+	}
+	write_sysreg(daif, daif);
+}
+
+static inline void __nmi_local_allint_restore(arch_irqflags_t irqflags)
+{
+	if (irqflags.fields.allint)
+		_allint_set();
+	else
+		_allint_clear();
+
+	write_sysreg(irqflags.fields.daif, daif);
+}
+
+static inline int local_allint_disabled(arch_irqflags_t irqflags)
+{
+	return irqflags.fields.allint || (irqflags.fields.daif & PSR_I_BIT);
+}
+
+/*
+ * It has to conside the different kernel configure and parameters, that need
+ * to use coresspoding operations to mask interrupts properly. For example, the
+ * kernel disable PSEUDO_NMI, the kernel uses prio masking to support
+ * PSEUDO_NMI, or the kernel uses FEAT_NMI extension to support PSEUDO_NMI.
+ */
+static inline void local_allint_restore(arch_irqflags_t irqflags)
+{
+	int irq_disabled = local_allint_disabled(irqflags);
+
+	if (!irq_disabled)
+		trace_hardirqs_on();
+
+	if (system_uses_irq_prio_masking())
+		__pmr_local_allint_restore(irqflags);
+	else if (system_uses_nmi())
+		__nmi_local_allint_restore(irqflags);
+	else
+		write_sysreg(irqflags.fields.daif, daif);
+
+	if (irq_disabled)
+		trace_hardirqs_off();
+}
+
+/*
+ * Called by synchronous exception handlers to restore the DAIF bits that were
+ * modified by taking an exception.
+ */
+static inline void local_allint_inherit(struct pt_regs *regs)
+{
+	if (interrupts_enabled(regs))
+		trace_hardirqs_on();
+
+	if (system_uses_irq_prio_masking())
+		gic_write_pmr(regs->pmr_save);
+
+	/*
+	 * We can't use local_daif_restore(regs->pstate) here as
+	 * system_has_prio_mask_debugging() won't restore the I bit if it can
+	 * use the pmr instead.
+	 */
+	write_sysreg(regs->pstate & DAIF_MASK, daif);
+
+	if (system_uses_nmi()) {
+		if (regs->pstate & PSR_ALLINT_BIT)
+			_allint_set();
+		else
+			_allint_clear();
+	}
+}
 #endif
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 7fa2f7036aa7..8a125a1986be 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -48,6 +48,7 @@
 #define PSR_D_BIT	0x00000200
 #define PSR_BTYPE_MASK	0x00000c00
 #define PSR_SSBS_BIT	0x00001000
+#define PSR_ALLINT_BIT	0x00002000
 #define PSR_PAN_BIT	0x00400000
 #define PSR_UAO_BIT	0x00800000
 #define PSR_DIT_BIT	0x01000000
-- 
2.34.1


