Return-Path: <linux-kernel+bounces-139896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB278A08EC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457E22823EC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8E813DBBD;
	Thu, 11 Apr 2024 06:55:29 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155E513E8BE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818529; cv=none; b=Ltk+qR4U5WJ0jQcbg9M3r9cv/5bs+5AsSeaFbLq75lYXVyr1ZgF253ow45NiNNssSepy8jEPgmzsc2Tp6m9khgMrdz384+oiRxb5deqpOcLBgucE+zMqMdezNLNDUkW9bqpTzFQLISCoJLIyoZR18Ugbsp5ZO0M2d/l1EibtVYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818529; c=relaxed/simple;
	bh=MuHFOgP+VINNMeVH16+DixeNsqv/i9paZgGXoPbFS4c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQNPnywZwxAv1JQkt9zn1j77U7eCLUWCX/ees2/vpiqBRe0aYyL+uBIYBJUm4vO85Sbc85y3J48zHPmisqOBg8Eb+rmjISh335q0ULlcfKEoZEHwdWbm+lAJ7nMOsd98Rh9dvb01ju+N9rTzJ9gBpa/GRh3OY/QReCfBZGJG48M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VFVl84jfVz1yn2R;
	Thu, 11 Apr 2024 14:53:08 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B58B140156;
	Thu, 11 Apr 2024 14:55:25 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Thu, 11 Apr
 2024 14:55:23 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <james.morse@arm.com>, <suzuki.poulose@arm.com>,
	<yuzenghui@huawei.com>, <tglx@linutronix.de>, <mark.rutland@arm.com>,
	<ardb@kernel.org>, <broonie@kernel.org>, <liaochang1@huawei.com>,
	<anshuman.khandual@arm.com>, <miguel.luis@oracle.com>, <joey.gouly@arm.com>,
	<ryan.roberts@arm.com>, <jeremy.linton@arm.com>,
	<daniel.thompson@linaro.org>, <sumit.garg@linaro.org>, <liwei391@huawei.com>,
	<peterz@infradead.org>, <jpoimboe@kernel.org>, <ericchancf@google.com>,
	<kristina.martsenko@arm.com>, <robh@kernel.org>,
	<scott@os.amperecomputing.com>, <songshuaishuai@tinylab.org>,
	<shijie@os.amperecomputing.com>, <bhe@redhat.com>,
	<akpm@linux-foundation.org>, <horms@kernel.org>,
	<rmk+kernel@armlinux.org.uk>, <Jonathan.Cameron@huawei.com>,
	<takakura@valinux.co.jp>, <dianders@chromium.org>, <swboyd@chromium.org>,
	<frederic@kernel.org>, <reijiw@google.com>, <ruanjinjie@huawei.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kvmarm@lists.linux.dev>
Subject: [PATCH v2 9/9] irqchip/gic-v3: Improve the maintainability of NMI masking in GIC driver
Date: Thu, 11 Apr 2024 06:48:58 +0000
Message-ID: <20240411064858.3232574-10-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411064858.3232574-1-liaochang1@huawei.com>
References: <20240411064858.3232574-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200013.china.huawei.com (7.221.188.133)

It has a better maintainability to use the local_nmi_enable() in GIC
driver to unmask NMI and keep regular IRQ and FIQ maskable, instead of
writing raw value into DAIF, PMR and ALLINT directly.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/arm64/include/asm/daifflags.h | 13 +++++++++++++
 drivers/irqchip/irq-gic-v3.c       |  6 ++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index b831def08bb3..1196eb85aa8d 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -330,4 +330,17 @@ static inline void local_errnmi_enable(void)
 	irqflags.fields.allint = 0;
 	local_allint_restore(irqflags);
 }
+
+/*
+ * local_nmi_enable - Enable NMI with or without superpriority.
+ */
+static inline void local_nmi_enable(void)
+{
+	arch_irqflags_t irqflags;
+
+	irqflags.fields.daif = read_sysreg(daif);
+	irqflags.fields.pmr = GIC_PRIO_IRQOFF;
+	irqflags.fields.allint = 0;
+	local_allint_restore(irqflags);
+}
 #endif
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 6fb276504bcc..ed7d8d87768f 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -33,6 +33,7 @@
 #include <asm/exception.h>
 #include <asm/smp_plat.h>
 #include <asm/virt.h>
+#include <asm/daifflags.h>
 
 #include "irq-gic-common.h"
 
@@ -813,10 +814,7 @@ static void __gic_handle_irq_from_irqson(struct pt_regs *regs)
 		nmi_exit();
 	}
 
-	if (gic_prio_masking_enabled()) {
-		gic_pmr_mask_irqs();
-		gic_arch_enable_irqs();
-	}
+	local_nmi_enable();
 
 	if (!is_nmi)
 		__gic_handle_irq(irqnr, regs);
-- 
2.34.1


