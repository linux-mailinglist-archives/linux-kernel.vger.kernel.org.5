Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A157BC75A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343991AbjJGMBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343906AbjJGMAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:00:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDECBBD
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 05:00:47 -0700 (PDT)
Date:   Sat, 07 Oct 2023 12:00:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696680046;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=33oJ6ThYUb0ZrDPofYXtH/4n9V0dh99XXp+p7Aro9y8=;
        b=uv1jwALuH2StM5mjjiVTokOuDJkH4YNFdyB6hULF0rwktxaD3qbpKqY0uUclfQTIy5W8SW
        f4eyDMOJ5LfOJ47DVDEF2+S80I6msJzyGFpk+uK4/q4/FPHaMdLlkCD+B0Q50w7Lr2+fsx
        kazkthqmWLfS6gMgrsDtUJ6He+nsTyfCSD1hwdCqiI/oIpLXkZGrTIpHo+Lbhd6XOMIsgD
        zq7vTf7oI3sEvEtua2TZIa2l1RXPdJcYfVTDmCJjk2jBZh1wEsrMSwcHkznt9+cRetOe93
        hdy1cCUhSs+w4R0d369P/gwVx5Ovc3clpuBJPIJ80er9YEhoX7thumRRtTI+uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696680046;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=33oJ6ThYUb0ZrDPofYXtH/4n9V0dh99XXp+p7Aro9y8=;
        b=RD20KPyl1PpND7Idsr0efZahI1pbDltkTCcZziEoQ2z53Uik0grkxgTUn68bizxhdVLlNg
        X7RctCTi6yJ+2oDg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/gic-v3-its: Split allocation
 from initialisation of its_node
Cc:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, tglx@linutronix.de
In-Reply-To: <20231006125929.48591-4-lpieralisi@kernel.org>
References: <20231006125929.48591-4-lpieralisi@kernel.org>
MIME-Version: 1.0
Message-ID: <169668004542.3135.11806951035956850955.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     9585a495ac936049dba141e8f9d99159ca06d46a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/9585a495ac936049dba141e8f9d99159ca06d46a
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 06 Oct 2023 14:59:27 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 07 Oct 2023 12:47:12 +01:00

irqchip/gic-v3-its: Split allocation from initialisation of its_node

In order to pave the way for more fancy quirk handling without making
more of a mess of this terrible driver, split the allocation of the
ITS descriptor (its_node) from the actual probing.

This will allow firmware-specific hooks to be added between these
two points.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20231006125929.48591-4-lpieralisi@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 149 +++++++++++++++++-------------
 1 file changed, 89 insertions(+), 60 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e0c2b10..5e57b60 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4952,7 +4952,7 @@ out_unmap:
 	return NULL;
 }
 
-static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
+static int its_init_domain(struct its_node *its)
 {
 	struct irq_domain *inner_domain;
 	struct msi_domain_info *info;
@@ -4966,7 +4966,7 @@ static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
 
 	inner_domain = irq_domain_create_hierarchy(its_parent,
 						   its->msi_domain_flags, 0,
-						   handle, &its_domain_ops,
+						   its->fwnode_handle, &its_domain_ops,
 						   info);
 	if (!inner_domain) {
 		kfree(info);
@@ -5017,8 +5017,7 @@ static int its_init_vpe_domain(void)
 	return 0;
 }
 
-static int __init its_compute_its_list_map(struct resource *res,
-					   void __iomem *its_base)
+static int __init its_compute_its_list_map(struct its_node *its)
 {
 	int its_number;
 	u32 ctlr;
@@ -5032,15 +5031,15 @@ static int __init its_compute_its_list_map(struct resource *res,
 	its_number = find_first_zero_bit(&its_list_map, GICv4_ITS_LIST_MAX);
 	if (its_number >= GICv4_ITS_LIST_MAX) {
 		pr_err("ITS@%pa: No ITSList entry available!\n",
-		       &res->start);
+		       &its->phys_base);
 		return -EINVAL;
 	}
 
-	ctlr = readl_relaxed(its_base + GITS_CTLR);
+	ctlr = readl_relaxed(its->base + GITS_CTLR);
 	ctlr &= ~GITS_CTLR_ITS_NUMBER;
 	ctlr |= its_number << GITS_CTLR_ITS_NUMBER_SHIFT;
-	writel_relaxed(ctlr, its_base + GITS_CTLR);
-	ctlr = readl_relaxed(its_base + GITS_CTLR);
+	writel_relaxed(ctlr, its->base + GITS_CTLR);
+	ctlr = readl_relaxed(its->base + GITS_CTLR);
 	if ((ctlr & GITS_CTLR_ITS_NUMBER) != (its_number << GITS_CTLR_ITS_NUMBER_SHIFT)) {
 		its_number = ctlr & GITS_CTLR_ITS_NUMBER;
 		its_number >>= GITS_CTLR_ITS_NUMBER_SHIFT;
@@ -5048,75 +5047,50 @@ static int __init its_compute_its_list_map(struct resource *res,
 
 	if (test_and_set_bit(its_number, &its_list_map)) {
 		pr_err("ITS@%pa: Duplicate ITSList entry %d\n",
-		       &res->start, its_number);
+		       &its->phys_base, its_number);
 		return -EINVAL;
 	}
 
 	return its_number;
 }
 
-static int __init its_probe_one(struct resource *res,
-				struct fwnode_handle *handle, int numa_node)
+static int __init its_probe_one(struct its_node *its)
 {
-	struct its_node *its;
-	void __iomem *its_base;
-	u64 baser, tmp, typer;
+	u64 baser, tmp;
 	struct page *page;
 	u32 ctlr;
 	int err;
 
-	its_base = its_map_one(res, &err);
-	if (!its_base)
-		return err;
-
-	pr_info("ITS %pR\n", res);
-
-	its = kzalloc(sizeof(*its), GFP_KERNEL);
-	if (!its) {
-		err = -ENOMEM;
-		goto out_unmap;
-	}
-
-	raw_spin_lock_init(&its->lock);
-	mutex_init(&its->dev_alloc_lock);
-	INIT_LIST_HEAD(&its->entry);
-	INIT_LIST_HEAD(&its->its_device_list);
-	typer = gic_read_typer(its_base + GITS_TYPER);
-	its->typer = typer;
-	its->base = its_base;
-	its->phys_base = res->start;
 	if (is_v4(its)) {
-		if (!(typer & GITS_TYPER_VMOVP)) {
-			err = its_compute_its_list_map(res, its_base);
+		if (!(its->typer & GITS_TYPER_VMOVP)) {
+			err = its_compute_its_list_map(its);
 			if (err < 0)
-				goto out_free_its;
+				goto out;
 
 			its->list_nr = err;
 
 			pr_info("ITS@%pa: Using ITS number %d\n",
-				&res->start, err);
+				&its->phys_base, err);
 		} else {
-			pr_info("ITS@%pa: Single VMOVP capable\n", &res->start);
+			pr_info("ITS@%pa: Single VMOVP capable\n", &its->phys_base);
 		}
 
 		if (is_v4_1(its)) {
-			u32 svpet = FIELD_GET(GITS_TYPER_SVPET, typer);
+			u32 svpet = FIELD_GET(GITS_TYPER_SVPET, its->typer);
 
-			its->sgir_base = ioremap(res->start + SZ_128K, SZ_64K);
+			its->sgir_base = ioremap(its->phys_base + SZ_128K, SZ_64K);
 			if (!its->sgir_base) {
 				err = -ENOMEM;
-				goto out_free_its;
+				goto out;
 			}
 
-			its->mpidr = readl_relaxed(its_base + GITS_MPIDR);
+			its->mpidr = readl_relaxed(its->base + GITS_MPIDR);
 
 			pr_info("ITS@%pa: Using GICv4.1 mode %08x %08x\n",
-				&res->start, its->mpidr, svpet);
+				&its->phys_base, its->mpidr, svpet);
 		}
 	}
 
-	its->numa_node = numa_node;
-
 	page = alloc_pages_node(its->numa_node, GFP_KERNEL | __GFP_ZERO,
 				get_order(ITS_CMD_QUEUE_SZ));
 	if (!page) {
@@ -5125,12 +5099,9 @@ static int __init its_probe_one(struct resource *res,
 	}
 	its->cmd_base = (void *)page_address(page);
 	its->cmd_write = its->cmd_base;
-	its->fwnode_handle = handle;
 	its->get_msi_base = its_irq_get_msi_base;
 	its->msi_domain_flags = IRQ_DOMAIN_FLAG_ISOLATED_MSI;
 
-	its_enable_quirks(its);
-
 	err = its_alloc_tables(its);
 	if (err)
 		goto out_free_cmd;
@@ -5174,7 +5145,7 @@ static int __init its_probe_one(struct resource *res,
 		ctlr |= GITS_CTLR_ImDe;
 	writel_relaxed(ctlr, its->base + GITS_CTLR);
 
-	err = its_init_domain(handle, its);
+	err = its_init_domain(its);
 	if (err)
 		goto out_free_tables;
 
@@ -5191,11 +5162,8 @@ out_free_cmd:
 out_unmap_sgir:
 	if (its->sgir_base)
 		iounmap(its->sgir_base);
-out_free_its:
-	kfree(its);
-out_unmap:
-	iounmap(its_base);
-	pr_err("ITS@%pa: failed probing (%d)\n", &res->start, err);
+out:
+	pr_err("ITS@%pa: failed probing (%d)\n", &its->phys_base, err);
 	return err;
 }
 
@@ -5356,10 +5324,53 @@ static const struct of_device_id its_device_id[] = {
 	{},
 };
 
+static struct its_node __init *its_node_init(struct resource *res,
+					     struct fwnode_handle *handle, int numa_node)
+{
+	void __iomem *its_base;
+	struct its_node *its;
+	int err;
+
+	its_base = its_map_one(res, &err);
+	if (!its_base)
+		return NULL;
+
+	pr_info("ITS %pR\n", res);
+
+	its = kzalloc(sizeof(*its), GFP_KERNEL);
+	if (!its)
+		goto out_unmap;
+
+	raw_spin_lock_init(&its->lock);
+	mutex_init(&its->dev_alloc_lock);
+	INIT_LIST_HEAD(&its->entry);
+	INIT_LIST_HEAD(&its->its_device_list);
+
+	its->typer = gic_read_typer(its_base + GITS_TYPER);
+	its->base = its_base;
+	its->phys_base = res->start;
+
+	its->numa_node = numa_node;
+	its->fwnode_handle = handle;
+
+	return its;
+
+out_unmap:
+	iounmap(its_base);
+	return NULL;
+}
+
+static void its_node_destroy(struct its_node *its)
+{
+	iounmap(its->base);
+	kfree(its);
+}
+
 static int __init its_of_probe(struct device_node *node)
 {
 	struct device_node *np;
 	struct resource res;
+	int err;
 
 	/*
 	 * Make sure *all* the ITS are reset before we probe any, as
@@ -5369,8 +5380,6 @@ static int __init its_of_probe(struct device_node *node)
 	 */
 	for (np = of_find_matching_node(node, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
-		int err;
-
 		if (!of_device_is_available(np) ||
 		    !of_property_read_bool(np, "msi-controller") ||
 		    of_address_to_resource(np, 0, &res))
@@ -5383,6 +5392,8 @@ static int __init its_of_probe(struct device_node *node)
 
 	for (np = of_find_matching_node(node, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
+		struct its_node *its;
+
 		if (!of_device_is_available(np))
 			continue;
 		if (!of_property_read_bool(np, "msi-controller")) {
@@ -5396,7 +5407,17 @@ static int __init its_of_probe(struct device_node *node)
 			continue;
 		}
 
-		its_probe_one(&res, &np->fwnode, of_node_to_nid(np));
+
+		its = its_node_init(&res, &np->fwnode, of_node_to_nid(np));
+		if (!its)
+			return -ENOMEM;
+
+		its_enable_quirks(its);
+		err = its_probe_one(its);
+		if (err)  {
+			its_node_destroy(its);
+			return err;
+		}
 	}
 	return 0;
 }
@@ -5508,6 +5529,7 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
 {
 	struct acpi_madt_generic_translator *its_entry;
 	struct fwnode_handle *dom_handle;
+	struct its_node *its;
 	struct resource res;
 	int err;
 
@@ -5532,11 +5554,18 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
 		goto dom_err;
 	}
 
-	err = its_probe_one(&res, dom_handle,
-			acpi_get_its_numa_node(its_entry->translation_id));
+	its = its_node_init(&res, dom_handle,
+			    acpi_get_its_numa_node(its_entry->translation_id));
+	if (!its) {
+		err = -ENOMEM;
+		goto node_err;
+	}
+
+	err = its_probe_one(its);
 	if (!err)
 		return 0;
 
+node_err:
 	iort_deregister_domain_token(its_entry->translation_id);
 dom_err:
 	irq_domain_free_fwnode(dom_handle);
