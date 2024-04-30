Return-Path: <linux-kernel+bounces-163697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8E38B6E6E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2CB1F26A50
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923B11292CC;
	Tue, 30 Apr 2024 09:34:41 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893DE127E31
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714469681; cv=none; b=JsRtVnXyywtX0zTx/v/Q4DdyWK2xgAnOSBU8SPmodIc9cRPc3Dt9nbdgsEknz9RovjJRHBobGIXwX/D7wjTjyIm0KPGT2H2HEIxC1OlkBuwX35/AicfkvJdC5tu6NoP1PM1LwdB70P/huM/Wjq/lNmafr/vcAm4m1/YZdM/znQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714469681; c=relaxed/simple;
	bh=NM7ltXVgJiTvHbyePJW9hEoscG9RrRRi+f9vhsUXWrA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E5KbpJDs5XqA5bPyIe4bXzcRc8ItlF8GSY5YgzccTL8FhfVjgYNonFTcd6ed0zlRJpzU13p653N7OD+lwdLILSRD75ia5OOd/egO6KZevx8FJntjJYzglWNmEq0+NeY1nvZQZTwLyxcv64+NuC44C3yE9GpIjPr0y2a4T4nciDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VTFLT27P8zXnlG
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:30:57 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id C2C5C18007C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:34:35 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 17:34:35 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] genirq/irqdomain: Clean code for __irq_domain_create()
Date: Tue, 30 Apr 2024 17:33:53 +0800
Message-ID: <20240430093353.1919862-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)

Introduce irq_domain_alloc_name() function to handle name allocation for
the irq domain, add "out_free_domain" label to free the irq domain, and
when "is_fwnode_irqchip(fwnode)" is true, "domain->fwnode = fwnode" is
the common action, so do it outside the switch, which can make the code
more clearer.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/irq/irqdomain.c | 75 +++++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 30 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 3dd1c871e091..49a983161340 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -127,6 +127,39 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(irq_domain_free_fwnode);
 
+static int irq_domain_alloc_name(struct fwnode_handle *fwnode,
+				 struct irq_domain *domain,
+				 int unknown_domains, char *in_name)
+{
+	char *name;
+
+	if (fwnode == NULL) {
+		if (unknown_domains)
+			domain->name = kasprintf(GFP_KERNEL, "unknown-%d",
+						 unknown_domains);
+		else
+			domain->name = kstrdup(in_name, GFP_KERNEL);
+		if (!domain->name)
+			return -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * fwnode paths contain '/', which debugfs is legitimately
+	 * unhappy about. Replace them with ':', which does
+	 * the trick and is not as offensive as '\'...
+	 */
+	name = kasprintf(GFP_KERNEL, "%pfw", fwnode);
+	if (!name)
+		return -ENOMEM;
+
+	domain->name = strreplace(name, '/', ':');
+
+out:
+	domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
+	return 0;
+}
+
 static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 					      unsigned int size,
 					      irq_hw_number_t hwirq_max,
@@ -151,53 +184,31 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 
 	if (is_fwnode_irqchip(fwnode)) {
 		fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
+		domain->fwnode = fwnode;
 
 		switch (fwid->type) {
 		case IRQCHIP_FWNODE_NAMED:
 		case IRQCHIP_FWNODE_NAMED_ID:
-			domain->fwnode = fwnode;
-			domain->name = kstrdup(fwid->name, GFP_KERNEL);
-			if (!domain->name) {
-				kfree(domain);
-				return NULL;
-			}
-			domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
+			if (irq_domain_alloc_name(NULL, domain, 0, fwid->name))
+				goto out_free_domain;
 			break;
 		default:
-			domain->fwnode = fwnode;
 			domain->name = fwid->name;
 			break;
 		}
 	} else if (is_of_node(fwnode) || is_acpi_device_node(fwnode) ||
 		   is_software_node(fwnode)) {
-		char *name;
-
-		/*
-		 * fwnode paths contain '/', which debugfs is legitimately
-		 * unhappy about. Replace them with ':', which does
-		 * the trick and is not as offensive as '\'...
-		 */
-		name = kasprintf(GFP_KERNEL, "%pfw", fwnode);
-		if (!name) {
-			kfree(domain);
-			return NULL;
-		}
-
-		domain->name = strreplace(name, '/', ':');
+		if (irq_domain_alloc_name(fwnode, domain, 0, NULL))
+			goto out_free_domain;
 		domain->fwnode = fwnode;
-		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 	}
 
 	if (!domain->name) {
 		if (fwnode)
 			pr_err("Invalid fwnode type for irqdomain\n");
-		domain->name = kasprintf(GFP_KERNEL, "unknown-%d",
-					 atomic_inc_return(&unknown_domains));
-		if (!domain->name) {
-			kfree(domain);
-			return NULL;
-		}
-		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
+		if (irq_domain_alloc_name(NULL, domain,
+		    atomic_inc_return(&unknown_domains), NULL))
+			goto out_free_domain;
 	}
 
 	fwnode_handle_get(fwnode);
@@ -228,6 +239,10 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 	irq_domain_check_hierarchy(domain);
 
 	return domain;
+
+out_free_domain:
+	kfree(domain);
+	return NULL;
 }
 
 static void __irq_domain_publish(struct irq_domain *domain)
-- 
2.34.1


