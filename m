Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6E37D84C4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345290AbjJZObq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345287AbjJZObe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:31:34 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BC51B8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:31:31 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c506d1798eso3173581fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698330689; x=1698935489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjJNbk+YzeocIZaMbaGiDwKsD4n3sxNNihAmQTPUtd4=;
        b=DQQskNQywQflG/oz+VBvZWAbL+Su2H1Qo1VBiRWdCC/xrUaR4OkBG/NltbM98GWFq6
         cUAjW/x59+r4PIdVpAga/SO+PsvStDvH/txzXax28O57piy0ocYvJi6i54kwaOAaS7Ou
         C3m2ySxPFfVu18eUzh3B/gUCI/Od8nzRS43OsYGeE+IP+v0d3zJkC8v5wVfNnsSDsDri
         muJDNIBw7MIl6DZWGMmZPONA6Qns6bAwxvxZXjHbHnxAiwUCc00ta9p+CSAVVBImrvVM
         BE4CCKVkoCJrUvpUdFc8D0xmbNanhSwbg5iOwbgTHyfMI0WKZ+GF1DhTLFjBDpc9F6SM
         rzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698330689; x=1698935489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjJNbk+YzeocIZaMbaGiDwKsD4n3sxNNihAmQTPUtd4=;
        b=gjkB4vW/LT2EmfFJv0Cwf54huvFyP8Kh6S+2Zp1LtT2TwCYUNuvnytgL+ERQvBRidq
         dF1cu7cG4DTXwWf+s6uM3Sv3ZKo758wlKj5fr6uHHpJBygtCK1ura6HXp0bU0mykcHqT
         qLUfXBlGV1f+1t7VfEqebc20iBSyjbCyCqJ1ADco7SDdwm0Vh54VLANP5yTCNDeHQrNJ
         lmYLMW+xYySaSocIA9i7oGh4Ip4EmyXBAJ80+le8pIqSJ6ZhiP2gKD62ZTJiwLfYh1Q7
         RgQ6lOu7vEL6786K3eOHsNNYLgUwtevRAt04R2dzd+7co5ZyeykaaPXKCPSWsknyQTBT
         28aQ==
X-Gm-Message-State: AOJu0YwRxxHUZDBLRjji0pBPHRXGLHcvoUbSfLj1PWLLc2nIM88FYfG4
        sy+mnPw6h/k/lAI1ivmltfbvIw==
X-Google-Smtp-Source: AGHT+IFLytGw/7jgeGoJfJWsBD048sUEsQCNLXq5OinxBlnRc9jpp7CR1gsux8sfYWyRCNcKwi3XKw==
X-Received: by 2002:a05:6512:2821:b0:505:7144:7c37 with SMTP id cf33-20020a056512282100b0050571447c37mr13666108lfb.6.1698330689555;
        Thu, 26 Oct 2023 07:31:29 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:b380:32be:257:5381])
        by smtp.gmail.com with ESMTPSA id r9-20020a056000014900b003232f167df5sm14316589wrx.108.2023.10.26.07.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 07:31:29 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Himanshu Chauhan <hchauhan@ventanamicro.com>,
        Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH 3/3] perf: RISC-V: add support for SSE event
Date:   Thu, 26 Oct 2023 16:31:22 +0200
Message-ID: <20231026143122.279437-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231026143122.279437-1-cleger@rivosinc.com>
References: <20231026143122.279437-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use SSE within PMU drivers, register a SSE handler for the
local PMU event. There is not a lot of specific code needed to handle
the SSE event, just reuse the existing overlflow IRQ handler and pass
appropriate pt_regs.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h |  2 ++
 drivers/perf/riscv_pmu_sbi.c | 51 +++++++++++++++++++++++++++++-------
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 2e99cafe7fed..13b01cd3a814 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -121,6 +121,8 @@ enum sbi_ext_pmu_fid {
 	SBI_EXT_PMU_COUNTER_START,
 	SBI_EXT_PMU_COUNTER_STOP,
 	SBI_EXT_PMU_COUNTER_FW_READ,
+	SBI_EXT_PMU_COUNTER_FW_READ_HI,
+	SBI_EXT_PMU_COUNTER_IRQ_CLEAR,
 };
 
 union sbi_pmu_ctr_info {
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 96c7f670c8f0..3fca70b13304 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -17,6 +17,7 @@
 #include <linux/irqdomain.h>
 #include <linux/of_irq.h>
 #include <linux/of.h>
+#include <linux/riscv_sse.h>
 #include <linux/cpu_pm.h>
 #include <linux/sched/clock.h>
 
@@ -625,6 +626,12 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
 		  cpu_hw_evt->used_hw_ctrs[0], 0, 0, 0, 0);
 }
 
+static void pmu_sbi_irq_clear(void)
+{
+	/* No need to check the error here as we can't do anything about the error */
+	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_IRQ_CLEAR, 0, 0, 0, 0, 0, 0);
+}
+
 /*
  * This function starts all the used counters in two step approach.
  * Any counter that did not overflow can be start in a single step
@@ -670,10 +677,10 @@ static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
 	}
 }
 
-static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
+static irqreturn_t pmu_sbi_ovf_handler(struct cpu_hw_events *cpu_hw_evt,
+				       struct pt_regs *regs, bool from_sse)
 {
 	struct perf_sample_data data;
-	struct pt_regs *regs;
 	struct hw_perf_event *hw_evt;
 	union sbi_pmu_ctr_info *info;
 	int lidx, hidx, fidx;
@@ -681,7 +688,6 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	struct perf_event *event;
 	unsigned long overflow;
 	unsigned long overflowed_ctrs = 0;
-	struct cpu_hw_events *cpu_hw_evt = dev;
 	u64 start_clock = sched_clock();
 
 	if (WARN_ON_ONCE(!cpu_hw_evt))
@@ -691,7 +697,10 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	fidx = find_first_bit(cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS);
 	event = cpu_hw_evt->events[fidx];
 	if (!event) {
-		csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
+		if (from_sse)
+			pmu_sbi_irq_clear();
+		else
+			csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
 		return IRQ_NONE;
 	}
 
@@ -703,16 +712,16 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 
 	/*
 	 * Overflow interrupt pending bit should only be cleared after stopping
-	 * all the counters to avoid any race condition.
+	 * all the counters to avoid any race condition. When using SSE,
+	 * interrupt is cleared when stopping counters.
 	 */
-	csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
+	if (!from_sse)
+		csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
 
 	/* No overflow bit is set */
 	if (!overflow)
 		return IRQ_NONE;
 
-	regs = get_irq_regs();
-
 	for_each_set_bit(lidx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS) {
 		struct perf_event *event = cpu_hw_evt->events[lidx];
 
@@ -758,6 +767,22 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t pmu_sbi_ovf_irq_handler(int irq, void *dev)
+{
+	return pmu_sbi_ovf_handler(dev, get_irq_regs(), false);
+}
+
+static int pmu_sbi_ovf_sse_handler(uint32_t evt, void *arg,
+				   struct pt_regs *regs)
+{
+	struct cpu_hw_events __percpu *hw_events = arg;
+	struct cpu_hw_events *hw_event = raw_cpu_ptr(hw_events);
+
+	pmu_sbi_ovf_handler(hw_event, regs, true);
+
+	return 0;
+}
+
 static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 {
 	struct riscv_pmu *pmu = hlist_entry_safe(node, struct riscv_pmu, node);
@@ -801,9 +826,17 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
 static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pdev)
 {
 	int ret;
+	struct sse_event *evt;
 	struct cpu_hw_events __percpu *hw_events = pmu->hw_events;
 	struct irq_domain *domain = NULL;
 
+	evt = sse_event_register(SBI_SSE_EVENT_LOCAL_PMU, 0,
+				 pmu_sbi_ovf_sse_handler, hw_events);
+	if (!IS_ERR(evt)) {
+		sse_event_enable(evt);
+		return 0;
+	}
+
 	if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
 		riscv_pmu_irq_num = RV_IRQ_PMU;
 		riscv_pmu_use_irq = true;
@@ -831,7 +864,7 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 		return -ENODEV;
 	}
 
-	ret = request_percpu_irq(riscv_pmu_irq, pmu_sbi_ovf_handler, "riscv-pmu", hw_events);
+	ret = request_percpu_irq(riscv_pmu_irq, pmu_sbi_ovf_irq_handler, "riscv-pmu", hw_events);
 	if (ret) {
 		pr_err("registering percpu irq failed [%d]\n", ret);
 		return ret;
-- 
2.42.0

