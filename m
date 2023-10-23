Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A897D3DB3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjJWR3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjJWR3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:29:19 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F9B19AF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:28:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso2857713b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698082136; x=1698686936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAkfutBo3nsUV3HCsxsM2k1RXnz72Gyz1ATUfewlcRg=;
        b=V5MRNu5tlKa6z7J687dI4+YoOAt5711X3Arbhpo42DFYd+jh89GO3DN5Vi1Yw3c5Q8
         1nqrOZfysXPwAR6ul247Tp20ZD4k26jp1gIFgi8ZJyBvF20s3BJM8s/wExKbNqzwhp5X
         DI0Q1O7+4JCitwNiJfB8Iq0et2/SU4135wR+PiOOXWxRZaB/zGTAhnjVQr+tygnG2aBV
         9HfVGan6omIVHR+DZEqPQLQc7NFdQonTPAAmbIFQ3Qm0DOwxZougB+TAMyCRrySNOL2n
         FplFFA+XLnD3tL3osFKbqSulbv7h25xAoXMvVEe4F4KmIvSZhDsrjqmt5WSEG2gozXQ4
         s31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698082136; x=1698686936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAkfutBo3nsUV3HCsxsM2k1RXnz72Gyz1ATUfewlcRg=;
        b=r5IfkewdLtdsHUOqy2Uh7UiRvPBVDNP3rj4MwR8Hp5Bu6CVDGz+PuHFbSsladsKR0f
         PHu0RnyuhYFp/Afk59hOC0jgj9kiCYCmHIG1fF8xLeH/KZzDJtWyKl8rspI0vXG8Fj4Q
         0NBZEq0AuoRC/sQlOGYKD+bCs/QoOjn/gepAIVRds3kgYDN5H+UY9p2dddlYUqdWMWwO
         PaBdJItKId1T1Wm0Z7Ar45fT5UOVkZbLkF1p18UXcxnD4e20YPK2VniSRrE7LGHUxVv/
         Fy7/jnvDJIOE7M1L/eD762WQeYmfMcZrgJznTiEljei2a+PAK34jIY9bSEmLGiswBhMF
         AFyQ==
X-Gm-Message-State: AOJu0Yz8LT3ow2gdvTFI4OgislvPMEkKMLb+EgsJ5B+uGfBnrwnKA6Bz
        lXxf5wrXGWtGhEGV3szZW2e+1g==
X-Google-Smtp-Source: AGHT+IHEv622PTW8MXUm9/v9050C6S07lO3IVyzS+4QpJbZY1khLeZlRwyIxweFH/lEjSsN7iN7amg==
X-Received: by 2002:a05:6a00:c94:b0:6be:35f:631b with SMTP id a20-20020a056a000c9400b006be035f631bmr8503824pfv.33.1698082136066;
        Mon, 23 Oct 2023 10:28:56 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.9])
        by smtp.gmail.com with ESMTPSA id g5-20020aa79f05000000b006be055ab117sm6473194pfr.92.2023.10.23.10.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 10:28:55 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v11 09/14] irqchip/riscv-imsic: Add support for PCI MSI irqdomain
Date:   Mon, 23 Oct 2023 22:57:55 +0530
Message-Id: <20231023172800.315343-10-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023172800.315343-1-apatel@ventanamicro.com>
References: <20231023172800.315343-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux PCI framework requires it's own dedicated MSI irqdomain so
let us create PCI MSI irqdomain as child of the IMSIC base irqdomain.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/Kconfig                    |  7 +++
 drivers/irqchip/irq-riscv-imsic-platform.c | 51 ++++++++++++++++++++++
 drivers/irqchip/irq-riscv-imsic-state.h    |  1 +
 3 files changed, 59 insertions(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index bdd80716114d..c1d69b418dfb 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -552,6 +552,13 @@ config RISCV_IMSIC
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_MSI_IRQ
 
+config RISCV_IMSIC_PCI
+	bool
+	depends on RISCV_IMSIC
+	depends on PCI
+	depends on PCI_MSI
+	default RISCV_IMSIC
+
 config EXYNOS_IRQ_COMBINER
 	bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
 	depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST
diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 23d286cb017e..cdb659401199 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -13,6 +13,7 @@
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/msi.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/smp.h>
@@ -215,6 +216,42 @@ static const struct irq_domain_ops imsic_base_domain_ops = {
 #endif
 };
 
+#ifdef CONFIG_RISCV_IMSIC_PCI
+
+static void imsic_pci_mask_irq(struct irq_data *d)
+{
+	pci_msi_mask_irq(d);
+	irq_chip_mask_parent(d);
+}
+
+static void imsic_pci_unmask_irq(struct irq_data *d)
+{
+	pci_msi_unmask_irq(d);
+	irq_chip_unmask_parent(d);
+}
+
+static struct irq_chip imsic_pci_irq_chip = {
+	.name			= "IMSIC-PCI",
+	.irq_mask		= imsic_pci_mask_irq,
+	.irq_unmask		= imsic_pci_unmask_irq,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= imsic_irq_set_affinity,
+#endif
+	.irq_eoi		= irq_chip_eoi_parent,
+};
+
+static struct msi_domain_ops imsic_pci_domain_ops = {
+};
+
+static struct msi_domain_info imsic_pci_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
+	.ops	= &imsic_pci_domain_ops,
+	.chip	= &imsic_pci_irq_chip,
+};
+
+#endif
+
 static struct irq_chip imsic_plat_irq_chip = {
 	.name			= "IMSIC-PLAT",
 #ifdef CONFIG_SMP
@@ -243,6 +280,18 @@ static int imsic_irq_domains_init(struct fwnode_handle *fwnode)
 	}
 	irq_domain_update_bus_token(imsic->base_domain, DOMAIN_BUS_NEXUS);
 
+#ifdef CONFIG_RISCV_IMSIC_PCI
+	/* Create PCI MSI domain */
+	imsic->pci_domain = pci_msi_create_irq_domain(fwnode,
+						&imsic_pci_domain_info,
+						imsic->base_domain);
+	if (!imsic->pci_domain) {
+		pr_err("%pfwP: failed to create IMSIC PCI domain\n", fwnode);
+		irq_domain_remove(imsic->base_domain);
+		return -ENOMEM;
+	}
+#endif
+
 	/* Create Platform MSI domain */
 	imsic->plat_domain = platform_msi_create_irq_domain(fwnode,
 						&imsic_plat_domain_info,
@@ -250,6 +299,8 @@ static int imsic_irq_domains_init(struct fwnode_handle *fwnode)
 	if (!imsic->plat_domain) {
 		pr_err("%pfwP: failed to create IMSIC platform domain\n",
 			fwnode);
+		if (imsic->pci_domain)
+			irq_domain_remove(imsic->pci_domain);
 		irq_domain_remove(imsic->base_domain);
 		return -ENOMEM;
 	}
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index 82911b8b08b4..8d209e77432e 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -67,6 +67,7 @@ struct imsic_priv {
 
 	/* IRQ domains (created by platform driver) */
 	struct irq_domain *base_domain;
+	struct irq_domain *pci_domain;
 	struct irq_domain *plat_domain;
 };
 
-- 
2.34.1

