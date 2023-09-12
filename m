Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED26179D7ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbjILRug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236865AbjILRue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:50:34 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066DE10E9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:50:31 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c1e780aa95so40602305ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694541030; x=1695145830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IKD5S2fbnJino2jsSEu0lyxkI20ofFJrbuG4PPQ6fw=;
        b=o3x55fPZ6iwO23F8UrGX29emOODOiVCte7aeVIcROae4NVD4l/pIgJBOUrhCkfNF2B
         lqu3gHnUpwssK6y1FdOPdnQ8F4NwPbRotWYK9vmJcJtvf0FXQquUaIAEgiVokn8ET5gx
         XR+pVZSfEetcXdyIv5nTjjP2ZsTCHA5Vm94B+YONExOz/SdwRvJ3f0l8/LU5O4VcVxKG
         s4xlhqS8S1Ld0pOj+6PvYNYGpWDLAhz2q4MRR4Hf/mX00ZhH9VhMEe3hyZvjzTIyiF4T
         zuj43pIJe0G1mzpdP0ub+Ln4QuX/B9jyhEk0o7ctmhMY4A5fEfZ7qvPbI6MzPqaSmb8r
         HGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694541030; x=1695145830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IKD5S2fbnJino2jsSEu0lyxkI20ofFJrbuG4PPQ6fw=;
        b=dQjsDGTg44sKFTp6JWvMhTA47Y9n7xQbHk7wl/5eaUS9DRrbxgrcsfD5GEh/NtnFtJ
         vEaEELzctfgP/hSxU/TpSCguAgeWLeWzLpapycYqY+dzTJBjkpTZ9w1/YvYlqcRNL+OV
         BMwLns9AluYV+70vNtnNyUxvIUXY/QIWGkWlq4w3bTF9ldeWtKuP3GwJTN4Wk49KP9nK
         7y4tBbUjQjSBQlIwenuI+Ai/hzcqAHq186zi6lDG0pAba2mZAFEKF/QU75KetesuQBxZ
         SDYDtVCJkcm+R4VL4dSK4F/oDzGzrbnSUXSob11544ohiVOCuNPvJCeGQdl1XpX0/b2J
         Rx3g==
X-Gm-Message-State: AOJu0YzjP0IIeJU5sZ6NG1GPCwwZPV8jmH/4OcJhwWhfPzSQ+lKqS95g
        c977hx3WTvGAivNbCL597Bbuwg==
X-Google-Smtp-Source: AGHT+IFMERBeKxTJB9AlyRI3xNpGXzEafM62yO44s+WaPRa/xDJk52ujsBlJpAigaAJ4jApqiclPeg==
X-Received: by 2002:a17:902:e546:b0:1c3:bc7c:e14c with SMTP id n6-20020a170902e54600b001c3bc7ce14cmr578213plf.32.1694541030378;
        Tue, 12 Sep 2023 10:50:30 -0700 (PDT)
Received: from localhost.localdomain ([171.76.81.83])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902a40c00b001b891259eddsm8691440plq.197.2023.09.12.10.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:50:29 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v8 02/16] RISC-V: Add riscv_get_intc_hartid() function
Date:   Tue, 12 Sep 2023 23:19:14 +0530
Message-Id: <20230912174928.528414-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912174928.528414-1-apatel@ventanamicro.com>
References: <20230912174928.528414-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add a common riscv_get_intc_hartid() which help device drivers to
get hartid of the HART associated with a INTC (i.e. local interrupt
controller) fwnode. This new function is more generic compared to
the existing riscv_of_parent_hartid() function hence we also replace
use of riscv_of_parent_hartid() with riscv_get_intc_hartid().

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/processor.h |  4 +++-
 arch/riscv/kernel/cpu.c            | 13 ++++++++++++-
 drivers/irqchip/irq-riscv-intc.c   |  2 +-
 drivers/irqchip/irq-sifive-plic.c  |  3 ++-
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 3e23e1786d05..3ce64b3bea4e 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -119,7 +119,9 @@ static inline void wait_for_interrupt(void)
 struct device_node;
 int riscv_of_processor_hartid(struct device_node *node, unsigned long *hartid);
 int riscv_early_of_processor_hartid(struct device_node *node, unsigned long *hartid);
-int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid);
+
+struct fwnode_handle;
+int riscv_get_intc_hartid(struct fwnode_handle *node, unsigned long *hartid);
 
 extern void riscv_fill_hwcap(void);
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 157ace8b262c..ee583eac3c5b 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -123,7 +123,8 @@ int __init riscv_early_of_processor_hartid(struct device_node *node, unsigned lo
  * To achieve this, we walk up the DT tree until we find an active
  * RISC-V core (HART) node and extract the cpuid from it.
  */
-int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid)
+static int riscv_of_parent_hartid(struct device_node *node,
+				  unsigned long *hartid)
 {
 	for (; node; node = node->parent) {
 		if (of_device_is_compatible(node, "riscv")) {
@@ -139,6 +140,16 @@ int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid)
 	return -1;
 }
 
+/* Find hart ID of the INTC fwnode. */
+int riscv_get_intc_hartid(struct fwnode_handle *node, unsigned long *hartid)
+{
+	/* Extend this function ACPI in the future. */
+	if (!is_of_node(node))
+		return -ENODEV;
+
+	return riscv_of_parent_hartid(to_of_node(node), hartid);
+}
+
 DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 
 unsigned long riscv_cached_mvendorid(unsigned int cpu_id)
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 4adeee1bc391..65f4a2afb381 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -143,7 +143,7 @@ static int __init riscv_intc_init(struct device_node *node,
 	int rc;
 	unsigned long hartid;
 
-	rc = riscv_of_parent_hartid(node, &hartid);
+	rc = riscv_get_intc_hartid(of_fwnode_handle(node), &hartid);
 	if (rc < 0) {
 		pr_warn("unable to find hart id for %pOF\n", node);
 		return 0;
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index e1484905b7bd..56b0544b1f27 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -477,7 +477,8 @@ static int __init __plic_init(struct device_node *node,
 			continue;
 		}
 
-		error = riscv_of_parent_hartid(parent.np, &hartid);
+		error = riscv_get_intc_hartid(of_fwnode_handle(parent.np),
+					      &hartid);
 		if (error < 0) {
 			pr_warn("failed to parse hart ID for context %d.\n", i);
 			continue;
-- 
2.34.1

