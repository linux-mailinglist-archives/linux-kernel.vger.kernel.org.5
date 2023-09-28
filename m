Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2457B1264
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjI1GM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjI1GMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:12:49 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E4519A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 23:12:47 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-35135b79b6aso25416225ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 23:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695881567; x=1696486367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STPmpWfv6fDT1bub5fGqVvG8FTLSWrxke8YCaHE+OKo=;
        b=NJ0zPm70Bw9b9tKvA8yFHtLtCak0iQMnq/F47X3U+s49WFF1EAjZRmYV41gElzApPD
         bvPs7GGbSgxF89IDARwTyl4RhurnCq/8OlokcvJiM2MWrEtlT79HaSZIjBB8tYlmJ1/0
         9YeRNBg2DFVuNg6NiTRPOvWfBsT3zQnQLmB4Ocy9qM6XXJJKY7oCIwx4eT3PGFec37Kk
         yihFnvkSHTD51aH+MDELolpKN9D+WmARM+Vicg+iSaF4IvmWLT1+uSBIEo4hxM3z5/Zr
         ZNqn3fFWUYuDp1FxndbyV5pYjZH1tANegqZdJeL4vpZqI8CY6wnnOn4bm3SuUv/+1dDf
         orBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695881567; x=1696486367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STPmpWfv6fDT1bub5fGqVvG8FTLSWrxke8YCaHE+OKo=;
        b=KxMFUm6bd1RTfjRi2tv+AOYl7GUtTpYxEVBJa+T+9EdBSoURv+Gzq8Dl6DEC7OySfu
         z0YIn5LVj/CDJ19CkRPXRLot8rCBpHA5U+Qh6eV/lCpxmfjBd5Kx6aS6hBJV79EFjnnK
         DjrbtTH67jAcPBG2UjpSxtEPTn6BJeNU9gLlL+t4Ao9Y7EyYuWnZQs0kgCkDMUz+BoMm
         aOzh8J0QFDDCKtO54cQQZ9JgM+DJZKLW1c4Y9w5xy3Mjb2OMGYTGnqPWya6NKlZCoJ6G
         3lKeDvfkJT25Tg3WUkLaRAtdA7j1knkV2oPL5KErIWO57ARgfiIjbd1zUgI3YlGwGbfr
         vr2g==
X-Gm-Message-State: AOJu0YyCApfg/DNCvc1F5sSksmzhdeYtfRT92XKI2pJ6hobtzdIDwdHH
        rjZPqhJfLKk6tm5Snzl8LezFkg==
X-Google-Smtp-Source: AGHT+IF5cEULCrsIG+xNyOUk71v9yZPtPKH6kOyBYcgS6EY9LoX/+39gSK0f6Q4Mo9nbNIO0uKdV9A==
X-Received: by 2002:a05:6e02:1c42:b0:351:211a:e86a with SMTP id d2-20020a056e021c4200b00351211ae86amr313596ilg.17.1695881566999;
        Wed, 27 Sep 2023 23:12:46 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id x6-20020a92d306000000b003506f457d70sm4774467ila.63.2023.09.27.23.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 23:12:46 -0700 (PDT)
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
Subject: [PATCH v9 03/15] drivers: irqchip/riscv-intc: Mark all INTC nodes as initialized
Date:   Thu, 28 Sep 2023 11:41:55 +0530
Message-Id: <20230928061207.1841513-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928061207.1841513-1-apatel@ventanamicro.com>
References: <20230928061207.1841513-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V INTC local interrupts are per-HART (or per-CPU) so we
create INTC IRQ domain only for the INTC node belonging to the boot
HART. This means only the boot HART INTC node will be marked as
initialized and other INTC nodes won't be marked which results
downstream interrupt controllers (such as PLIC, IMSIC and APLIC
direct-mode) not being probed due to missing device suppliers.

To address this issue, we mark all INTC node for which we don't
create IRQ domain as initialized.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-intc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 4adeee1bc391..e8d01b14ccdd 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -155,8 +155,16 @@ static int __init riscv_intc_init(struct device_node *node,
 	 * for each INTC DT node. We only need to do INTC initialization
 	 * for the INTC DT node belonging to boot CPU (or boot HART).
 	 */
-	if (riscv_hartid_to_cpuid(hartid) != smp_processor_id())
+	if (riscv_hartid_to_cpuid(hartid) != smp_processor_id()) {
+		/*
+		 * The INTC nodes of each CPU are suppliers for downstream
+		 * interrupt controllers (such as PLIC, IMSIC and APLIC
+		 * direct-mode) so we should mark an INTC node as initialized
+		 * if we are not creating IRQ domain for it.
+		 */
+		fwnode_dev_initialized(of_fwnode_handle(node), true);
 		return 0;
+	}
 
 	return riscv_intc_init_common(of_node_to_fwnode(node));
 }
-- 
2.34.1

