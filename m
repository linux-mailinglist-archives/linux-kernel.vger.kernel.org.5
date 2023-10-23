Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB96B7D2CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjJWIbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbjJWIas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:30:48 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A0010EA
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:30:24 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c9e95aa02dso21512265ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698049823; x=1698654623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DBuRxeBwydw4BwBQS/PBMNuUJKwvOuK50YBTu/VQqs=;
        b=KxlUY0bdG+FdiA3aRJmxHmFrT8czPG8ktWnSfbAuxJ187b7aBmevmaWvZkDAhm9zaR
         z8VegjvSmMIa2QZ8GqQOQwtZEfoPt6aN5P9HZ2iBdy4D7IWbGC5tSUIg7sVjTfi2jJ17
         tKAR09xEJOktQgKsPukRgSIeSpb7qztR1hnHZDX4qZtDObtfssk3R39f7DHLhScPfRgc
         OKQ4peFFyxDPmhFts5fWtt7R2lIMq+7iGydLsHEII+D725ZOD3GW0wmbFrOUmjeAQP0/
         aY7WId0cAQqI4/TBWfWDf9wqS1oA+2iQOH50c3f6uCNZstxDJ2Wm3w92O6G2EzESiTfX
         NT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698049823; x=1698654623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DBuRxeBwydw4BwBQS/PBMNuUJKwvOuK50YBTu/VQqs=;
        b=uz9GDxWsXdFX4lHoNit6cq1DGiIaPyVmdsQQ/jifIiOiAan6pNFwdVSeKiwKpjeoow
         yeMUoQMXL8k7Xn3KETPRdFvYKNwV8CR607F7CyAj1sSeIYdjj2DcqbwWFPQ0JZMJt6aP
         kPfVz3uWpW3lPbzTb1chDkeDyIZhCnV/jx4eqC4dWEttnJCf/Ohqj5cmWxgr/ozHiylP
         s2LF9EoEPk2L1pnwlh3w2NthEkEILHcvUUwqjFaRDMcDYrztauAx2jlIUIz5lgHP+Soz
         KzyQThjbNVUpmQjQ2lL365odOlaFe9Thia3maVU20EhUbu8Eah1/WxemPTE7gVfK2xAR
         +dOQ==
X-Gm-Message-State: AOJu0Yx6zHj7ieHnWwoU+mJsZk9njlFYECp1dmx3fQU1mAk0ncv6GxBw
        JObes6vvRLbAf4l6nn9WyBEffQ==
X-Google-Smtp-Source: AGHT+IFbYL9LzR1f7qPWMFMhpIw/jq2fW6XuDR85z/dEj8js9eHh6BWdpBWgonHNNRMuACn/U0IMZw==
X-Received: by 2002:a17:903:32d2:b0:1c6:d0a:cf01 with SMTP id i18-20020a17090332d200b001c60d0acf01mr16447416plr.11.1698049823515;
        Mon, 23 Oct 2023 01:30:23 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d15-20020a170903230f00b001b8b07bc600sm5415805plh.186.2023.10.23.01.30.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Oct 2023 01:30:23 -0700 (PDT)
From:   Xu Lu <luxu.kernel@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, maz@kernel.org,
        anup@brainfault.org, atishp@atishpatra.org
Cc:     dengliang.1214@bytedance.com, liyu.yukiteru@bytedance.com,
        sunjiadong.lff@bytedance.com, xieyongji@bytedance.com,
        lihangjing@bytedance.com, chaiwen.cc@bytedance.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC 11/12] riscv: Request pmu overflow interrupt as NMI
Date:   Mon, 23 Oct 2023 16:29:10 +0800
Message-Id: <20231023082911.23242-12-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231023082911.23242-1-luxu.kernel@bytedance.com>
References: <20231023082911.23242-1-luxu.kernel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit registers pmu overflow interrupt as NMI to improve the accuracy
of perf sampling.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/irqflags.h |  2 +-
 drivers/perf/riscv_pmu_sbi.c      | 23 +++++++++++++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
index 6a709e9c69ca..be840e297559 100644
--- a/arch/riscv/include/asm/irqflags.h
+++ b/arch/riscv/include/asm/irqflags.h
@@ -12,7 +12,7 @@
 
 #ifdef CONFIG_RISCV_PSEUDO_NMI
 
-#define __ALLOWED_NMI_MASK			0
+#define __ALLOWED_NMI_MASK			BIT(IRQ_PMU_OVF)
 #define ALLOWED_NMI_MASK			(__ALLOWED_NMI_MASK & irqs_enabled_ie)
 
 static inline bool nmi_allowed(int irq)
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 995b501ec721..85abb7dd43b9 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -760,6 +760,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 
 static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 {
+	int ret = 0;
 	struct riscv_pmu *pmu = hlist_entry_safe(node, struct riscv_pmu, node);
 	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
 
@@ -778,20 +779,30 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 	if (riscv_pmu_use_irq) {
 		cpu_hw_evt->irq = riscv_pmu_irq;
 		csr_clear(CSR_IP, BIT(riscv_pmu_irq_num));
-#ifndef CONFIG_RISCV_PSEUDO_NMI
+#ifdef CONFIG_RISCV_PSEUDO_NMI
+		ret = prepare_percpu_nmi(riscv_pmu_irq);
+		if (ret != 0) {
+			pr_err("Failed to prepare percpu nmi:%d\n", ret);
+			return ret;
+		}
+		enable_percpu_nmi(riscv_pmu_irq, IRQ_TYPE_NONE);
+#else
 		csr_set(CSR_IE, BIT(riscv_pmu_irq_num));
-#endif
 		enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
+#endif
 	}
 
-	return 0;
+	return ret;
 }
 
 static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
 {
 	if (riscv_pmu_use_irq) {
+#ifdef CONFIG_RISCV_PSEUDO_NMI
+		disable_percpu_nmi(riscv_pmu_irq);
+		teardown_percpu_nmi(riscv_pmu_irq);
+#else
 		disable_percpu_irq(riscv_pmu_irq);
-#ifndef CONFIG_RISCV_PSEUDO_NMI
 		csr_clear(CSR_IE, BIT(riscv_pmu_irq_num));
 #endif
 	}
@@ -835,7 +846,11 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 		return -ENODEV;
 	}
 
+#ifdef CONFIG_RISCV_PSEUDO_NMI
+	ret = request_percpu_nmi(riscv_pmu_irq, pmu_sbi_ovf_handler, "riscv-pmu", hw_events);
+#else
 	ret = request_percpu_irq(riscv_pmu_irq, pmu_sbi_ovf_handler, "riscv-pmu", hw_events);
+#endif
 	if (ret) {
 		pr_err("registering percpu irq failed [%d]\n", ret);
 		return ret;
-- 
2.20.1

