Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BB279D804
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbjILRvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbjILRva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:51:30 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752A5172C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:51:26 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c06f6f98c0so50041425ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694541086; x=1695145886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULAM2cjqGNSNlXEqRgMaXwaIHenoZQcGTorSa/ElLrs=;
        b=h+5i2yKbgAk0GYhbNKmFzThzcxUXB48Qb2fo3LabLppdwJDQG/d+CB4TJHi+WGMLAp
         hVIlxYzVRtBsnZ6OFdNMh3ZxrEz3xRChy8OF55RGA/rCQhT+F3L3qymAQr/6BegXFJvq
         XEzoXM4c0MSDeiwHQkvrr2vPxJO4w6HaFWxJJuH7E098jHj74KxgqGS9xuPyNrghiLZH
         y5kqPL/HBraA3Y/G8XISxiFELRD/rHpnBLXScNsZ3eRUOByfR60lfpZy3IgwHkDjuyrj
         f/JqUko9g6qc0/jDBmo/bNhBRAFHOCEFgp6pWhXYGvX7JXmU5TP+dkKWseiUTSlVL9Ig
         4APA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694541086; x=1695145886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULAM2cjqGNSNlXEqRgMaXwaIHenoZQcGTorSa/ElLrs=;
        b=KOS9RNpZKwxAqQ7c7KPrwaaVUQtdwVSjUUcWP1XBUtU6CnM1HSyo3kKN3gmDJfiK9E
         zoWtcL7ulHoAr8emhUxUqlYAXOGCH1UU2SI1JTFIHY3knd8uk6zRqninXoUHLbUd9aF1
         6ih6X1bt4yf338fkb1d+ypctjPp/YqZYOKBJibWdn/wFedYnaNVYZ2e0WS+YrtM8CFlc
         XpGIvFl69a5FMV4ZQuzbgq1bAyXh8XzCM0FdXo/FZOz9Q3s+ZDrekz9MDDX+vb77bMfo
         hBXyDQC0RnJ4JEV9O+3WYCx0Kd7RDbNp+IM21FSoc5TblTE6IHDyy3iVmaX9t599wwSq
         w3mQ==
X-Gm-Message-State: AOJu0YzJCkNYZIZCNAoU90ulLyLY3Xv7zuGK2rX8wdB27UW2NoR1mLc4
        gBMTlGbbfVt2W068ZlnDfQvbBQ==
X-Google-Smtp-Source: AGHT+IFJh8UphwdAEpQShz1M//4fzHvEQ0muo9MLiJBcGmOW4xSyUBW+ebY5Q+aizD1he9EO0y8fLw==
X-Received: by 2002:a17:902:b697:b0:1c3:d864:d6a8 with SMTP id c23-20020a170902b69700b001c3d864d6a8mr489453pls.23.1694541085840;
        Tue, 12 Sep 2023 10:51:25 -0700 (PDT)
Received: from localhost.localdomain ([171.76.81.83])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902a40c00b001b891259eddsm8691440plq.197.2023.09.12.10.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:51:25 -0700 (PDT)
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
Subject: [PATCH v8 11/16] irqchip/riscv-imsic: Add support for PCI MSI irqdomain
Date:   Tue, 12 Sep 2023 23:19:23 +0530
Message-Id: <20230912174928.528414-12-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912174928.528414-1-apatel@ventanamicro.com>
References: <20230912174928.528414-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux PCI framework requires it's own dedicated MSI irqdomain so
let us create PCI MSI irqdomain as child of the IMSIC base irqdomain.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/Kconfig                    |  7 ++++
 drivers/irqchip/irq-riscv-imsic-platform.c | 48 ++++++++++++++++++++++
 drivers/irqchip/irq-riscv-imsic-state.h    |  1 +
 3 files changed, 56 insertions(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index ee99aacbefcc..a6aad78076a0 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -551,6 +551,13 @@ config RISCV_IMSIC
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
index b78f1b2ee3dc..ff737b4e195f 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -12,6 +12,7 @@
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/msi.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/smp.h>
@@ -184,6 +185,39 @@ static const struct irq_domain_ops imsic_base_domain_ops = {
 	.free		= imsic_irq_domain_free,
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
 };
@@ -208,12 +242,26 @@ static int imsic_irq_domains_init(struct device *dev)
 	}
 	irq_domain_update_bus_token(imsic->base_domain, DOMAIN_BUS_NEXUS);
 
+#ifdef CONFIG_RISCV_IMSIC_PCI
+	/* Create PCI MSI domain */
+	imsic->pci_domain = pci_msi_create_irq_domain(dev->fwnode,
+						&imsic_pci_domain_info,
+						imsic->base_domain);
+	if (!imsic->pci_domain) {
+		dev_err(dev, "failed to create IMSIC PCI domain\n");
+		irq_domain_remove(imsic->base_domain);
+		return -ENOMEM;
+	}
+#endif
+
 	/* Create Platform MSI domain */
 	imsic->plat_domain = platform_msi_create_irq_domain(dev->fwnode,
 						&imsic_plat_domain_info,
 						imsic->base_domain);
 	if (!imsic->plat_domain) {
 		dev_err(dev, "failed to create IMSIC platform domain\n");
+		if (imsic->pci_domain)
+			irq_domain_remove(imsic->pci_domain);
 		irq_domain_remove(imsic->base_domain);
 		return -ENOMEM;
 	}
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index 3170018949a8..ff3c377b9b33 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -31,6 +31,7 @@ struct imsic_priv {
 
 	/* IRQ domains (created by platform driver) */
 	struct irq_domain *base_domain;
+	struct irq_domain *pci_domain;
 	struct irq_domain *plat_domain;
 };
 
-- 
2.34.1

