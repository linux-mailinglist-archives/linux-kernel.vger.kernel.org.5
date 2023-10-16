Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081FF7C9F82
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 08:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjJPG3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 02:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjJPG3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 02:29:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7C0137
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 23:29:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1EBCC218B5;
        Mon, 16 Oct 2023 06:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697437749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8tpUjw2e6RaQIlbcZjjZ8I3SSuNLz9AsXteBGTzqAdM=;
        b=ReDNizVbt2fmpKu+czbKT0Et+d2e92d6zBjU3MD2xixkt1HI5Edp1Bb5QYIGdpPGmgF4a/
        6NyRMZ2XKxGDOn+Kn5BzIxzqVAeFlX0kzKbwqMHNgtSBwt/yiSXkDqegZeYfQBG7sGv++X
        UnL4M1NcPJuO2iSi4rbzjNDvQ2og6uY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5189138EF;
        Mon, 16 Oct 2023 06:29:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8u1dNjTYLGW1QQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 16 Oct 2023 06:29:08 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH 6/7] xen/events: modify internal [un]bind interfaces
Date:   Mon, 16 Oct 2023 08:28:30 +0200
Message-Id: <20231016062831.20630-7-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231016062831.20630-1-jgross@suse.com>
References: <20231016062831.20630-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -6.10
X-Spamd-Result: default: False [-6.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_FIVE(0.00)[5];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the internal bind- and unbind-interfaces to take a struct
irq_info parameter. When allocating a new IRQ pass the pointer from
the allocating function further up.

This will reduce the number of info_for_irq() calls and make the code
more efficient.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/events/events_base.c | 252 +++++++++++++++----------------
 1 file changed, 121 insertions(+), 131 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 58e5549ee1db..47a33d3cbfcb 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -325,7 +325,6 @@ static void delayed_free_irq(struct work_struct *work)
 
 /* Constructors for packed IRQ information. */
 static int xen_irq_info_common_setup(struct irq_info *info,
-				     unsigned irq,
 				     enum xen_irq_type type,
 				     evtchn_port_t evtchn,
 				     unsigned short cpu)
@@ -340,23 +339,22 @@ static int xen_irq_info_common_setup(struct irq_info *info,
 	info->mask_reason = EVT_MASK_REASON_EXPLICIT;
 	raw_spin_lock_init(&info->lock);
 
-	ret = set_evtchn_to_irq(evtchn, irq);
+	ret = set_evtchn_to_irq(evtchn, info->irq);
 	if (ret < 0)
 		return ret;
 
-	irq_clear_status_flags(irq, IRQ_NOREQUEST|IRQ_NOAUTOEN);
+	irq_clear_status_flags(info->irq, IRQ_NOREQUEST | IRQ_NOAUTOEN);
 
 	return xen_evtchn_port_setup(evtchn);
 }
 
-static int xen_irq_info_evtchn_setup(unsigned irq,
+static int xen_irq_info_evtchn_setup(struct irq_info *info,
 				     evtchn_port_t evtchn,
 				     struct xenbus_device *dev)
 {
-	struct irq_info *info = info_for_irq(irq);
 	int ret;
 
-	ret = xen_irq_info_common_setup(info, irq, IRQT_EVTCHN, evtchn, 0);
+	ret = xen_irq_info_common_setup(info, IRQT_EVTCHN, evtchn, 0);
 	info->u.interdomain = dev;
 	if (dev)
 		atomic_inc(&dev->event_channels);
@@ -364,49 +362,36 @@ static int xen_irq_info_evtchn_setup(unsigned irq,
 	return ret;
 }
 
-static int xen_irq_info_ipi_setup(unsigned cpu,
-				  unsigned irq,
-				  evtchn_port_t evtchn,
-				  enum ipi_vector ipi)
+static int xen_irq_info_ipi_setup(struct irq_info *info, unsigned int cpu,
+				  evtchn_port_t evtchn, enum ipi_vector ipi)
 {
-	struct irq_info *info = info_for_irq(irq);
-
 	info->u.ipi = ipi;
 
-	per_cpu(ipi_to_irq, cpu)[ipi] = irq;
+	per_cpu(ipi_to_irq, cpu)[ipi] = info->irq;
 
-	return xen_irq_info_common_setup(info, irq, IRQT_IPI, evtchn, 0);
+	return xen_irq_info_common_setup(info, IRQT_IPI, evtchn, 0);
 }
 
-static int xen_irq_info_virq_setup(unsigned cpu,
-				   unsigned irq,
-				   evtchn_port_t evtchn,
-				   unsigned virq)
+static int xen_irq_info_virq_setup(struct irq_info *info, unsigned int cpu,
+				   evtchn_port_t evtchn, unsigned int virq)
 {
-	struct irq_info *info = info_for_irq(irq);
-
 	info->u.virq = virq;
 
-	per_cpu(virq_to_irq, cpu)[virq] = irq;
+	per_cpu(virq_to_irq, cpu)[virq] = info->irq;
 
-	return xen_irq_info_common_setup(info, irq, IRQT_VIRQ, evtchn, 0);
+	return xen_irq_info_common_setup(info, IRQT_VIRQ, evtchn, 0);
 }
 
-static int xen_irq_info_pirq_setup(unsigned irq,
-				   evtchn_port_t evtchn,
-				   unsigned pirq,
-				   unsigned gsi,
-				   uint16_t domid,
-				   unsigned char flags)
+static int xen_irq_info_pirq_setup(struct irq_info *info, evtchn_port_t evtchn,
+				   unsigned int pirq, unsigned int gsi,
+				   uint16_t domid, unsigned char flags)
 {
-	struct irq_info *info = info_for_irq(irq);
-
 	info->u.pirq.pirq = pirq;
 	info->u.pirq.gsi = gsi;
 	info->u.pirq.domid = domid;
 	info->u.pirq.flags = flags;
 
-	return xen_irq_info_common_setup(info, irq, IRQT_PIRQ, evtchn, 0);
+	return xen_irq_info_common_setup(info, IRQT_PIRQ, evtchn, 0);
 }
 
 static void xen_irq_info_cleanup(struct irq_info *info)
@@ -450,20 +435,16 @@ int irq_evtchn_from_virq(unsigned int cpu, unsigned int virq,
 	return irq;
 }
 
-static enum ipi_vector ipi_from_irq(unsigned irq)
+static enum ipi_vector ipi_from_irq(struct irq_info *info)
 {
-	struct irq_info *info = info_for_irq(irq);
-
 	BUG_ON(info == NULL);
 	BUG_ON(info->type != IRQT_IPI);
 
 	return info->u.ipi;
 }
 
-static unsigned virq_from_irq(unsigned irq)
+static unsigned int virq_from_irq(struct irq_info *info)
 {
-	struct irq_info *info = info_for_irq(irq);
-
 	BUG_ON(info == NULL);
 	BUG_ON(info->type != IRQT_VIRQ);
 
@@ -530,13 +511,9 @@ static bool pirq_needs_eoi_flag(unsigned irq)
 	return info->u.pirq.flags & PIRQ_NEEDS_EOI;
 }
 
-static void bind_evtchn_to_cpu(evtchn_port_t evtchn, unsigned int cpu,
+static void bind_evtchn_to_cpu(struct irq_info *info, unsigned int cpu,
 			       bool force_affinity)
 {
-	struct irq_info *info = evtchn_to_info(evtchn);
-
-	BUG_ON(info == NULL);
-
 	if (IS_ENABLED(CONFIG_SMP) && force_affinity) {
 		struct irq_data *data = irq_get_irq_data(info->irq);
 
@@ -544,7 +521,7 @@ static void bind_evtchn_to_cpu(evtchn_port_t evtchn, unsigned int cpu,
 		irq_data_update_effective_affinity(data, cpumask_of(cpu));
 	}
 
-	xen_evtchn_port_bind_to_cpu(evtchn, cpu, info->cpu);
+	xen_evtchn_port_bind_to_cpu(info->evtchn, cpu, info->cpu);
 
 	channels_on_cpu_dec(info);
 	info->cpu = cpu;
@@ -759,23 +736,24 @@ static struct irq_info *xen_irq_init(unsigned int irq)
 	return info;
 }
 
-static inline int __must_check xen_allocate_irq_dynamic(void)
+static struct irq_info *xen_allocate_irq_dynamic(void)
 {
 	int irq = irq_alloc_desc_from(0, -1);
+	struct irq_info *info = NULL;
 
 	if (irq >= 0) {
-		if (!xen_irq_init(irq)) {
+		info = xen_irq_init(irq);
+		if (!info)
 			xen_irq_free_desc(irq);
-			irq = -1;
-		}
 	}
 
-	return irq;
+	return info;
 }
 
-static int __must_check xen_allocate_irq_gsi(unsigned gsi)
+static struct irq_info *xen_allocate_irq_gsi(unsigned int gsi)
 {
 	int irq;
+	struct irq_info *info;
 
 	/*
 	 * A PV guest has no concept of a GSI (since it has no ACPI
@@ -792,18 +770,15 @@ static int __must_check xen_allocate_irq_gsi(unsigned gsi)
 	else
 		irq = irq_alloc_desc_at(gsi, -1);
 
-	if (!xen_irq_init(irq)) {
+	info = xen_irq_init(irq);
+	if (!info)
 		xen_irq_free_desc(irq);
-		irq = -1;
-	}
 
-	return irq;
+	return info;
 }
 
-static void xen_free_irq(unsigned irq)
+static void xen_free_irq(struct irq_info *info)
 {
-	struct irq_info *info = info_for_irq(irq);
-
 	if (WARN_ON(!info))
 		return;
 
@@ -894,7 +869,7 @@ static unsigned int __startup_pirq(unsigned int irq)
 		goto err;
 
 	info->evtchn = evtchn;
-	bind_evtchn_to_cpu(evtchn, 0, false);
+	bind_evtchn_to_cpu(info, 0, false);
 
 	rc = xen_evtchn_port_setup(evtchn);
 	if (rc)
@@ -960,10 +935,9 @@ int xen_irq_from_gsi(unsigned gsi)
 }
 EXPORT_SYMBOL_GPL(xen_irq_from_gsi);
 
-static void __unbind_from_irq(unsigned int irq)
+static void __unbind_from_irq(struct irq_info *info, unsigned int irq)
 {
-	evtchn_port_t evtchn = evtchn_from_irq(irq);
-	struct irq_info *info = info_for_irq(irq);
+	evtchn_port_t evtchn;
 
 	if (!info) {
 		xen_irq_free_desc(irq);
@@ -976,6 +950,8 @@ static void __unbind_from_irq(unsigned int irq)
 			return;
 	}
 
+	evtchn = info->evtchn;
+
 	if (VALID_EVTCHN(evtchn)) {
 		unsigned int cpu = info->cpu;
 		struct xenbus_device *dev;
@@ -985,10 +961,10 @@ static void __unbind_from_irq(unsigned int irq)
 
 		switch (info->type) {
 		case IRQT_VIRQ:
-			per_cpu(virq_to_irq, cpu)[virq_from_irq(irq)] = -1;
+			per_cpu(virq_to_irq, cpu)[virq_from_irq(info)] = -1;
 			break;
 		case IRQT_IPI:
-			per_cpu(ipi_to_irq, cpu)[ipi_from_irq(irq)] = -1;
+			per_cpu(ipi_to_irq, cpu)[ipi_from_irq(info)] = -1;
 			break;
 		case IRQT_EVTCHN:
 			dev = info->u.interdomain;
@@ -1002,7 +978,7 @@ static void __unbind_from_irq(unsigned int irq)
 		xen_irq_info_cleanup(info);
 	}
 
-	xen_free_irq(irq);
+	xen_free_irq(info);
 }
 
 /*
@@ -1018,24 +994,24 @@ static void __unbind_from_irq(unsigned int irq)
 int xen_bind_pirq_gsi_to_irq(unsigned gsi,
 			     unsigned pirq, int shareable, char *name)
 {
-	int irq;
+	struct irq_info *info;
 	struct physdev_irq irq_op;
 	int ret;
 
 	mutex_lock(&irq_mapping_update_lock);
 
-	irq = xen_irq_from_gsi(gsi);
-	if (irq != -1) {
+	ret = xen_irq_from_gsi(gsi);
+	if (ret != -1) {
 		pr_info("%s: returning irq %d for gsi %u\n",
-			__func__, irq, gsi);
+			__func__, ret, gsi);
 		goto out;
 	}
 
-	irq = xen_allocate_irq_gsi(gsi);
-	if (irq < 0)
+	info = xen_allocate_irq_gsi(gsi);
+	if (!info)
 		goto out;
 
-	irq_op.irq = irq;
+	irq_op.irq = info->irq;
 	irq_op.vector = 0;
 
 	/* Only the privileged domain can do this. For non-priv, the pcifront
@@ -1043,20 +1019,19 @@ int xen_bind_pirq_gsi_to_irq(unsigned gsi,
 	 * this in the priv domain. */
 	if (xen_initial_domain() &&
 	    HYPERVISOR_physdev_op(PHYSDEVOP_alloc_irq_vector, &irq_op)) {
-		xen_free_irq(irq);
-		irq = -ENOSPC;
+		xen_free_irq(info);
+		ret = -ENOSPC;
 		goto out;
 	}
 
-	ret = xen_irq_info_pirq_setup(irq, 0, pirq, gsi, DOMID_SELF,
+	ret = xen_irq_info_pirq_setup(info, 0, pirq, gsi, DOMID_SELF,
 			       shareable ? PIRQ_SHAREABLE : 0);
 	if (ret < 0) {
-		__unbind_from_irq(irq);
-		irq = ret;
+		__unbind_from_irq(info, info->irq);
 		goto out;
 	}
 
-	pirq_query_unmask(irq);
+	pirq_query_unmask(info->irq);
 	/* We try to use the handler with the appropriate semantic for the
 	 * type of interrupt: if the interrupt is an edge triggered
 	 * interrupt we use handle_edge_irq.
@@ -1073,16 +1048,18 @@ int xen_bind_pirq_gsi_to_irq(unsigned gsi,
 	 * is the right choice either way.
 	 */
 	if (shareable)
-		irq_set_chip_and_handler_name(irq, &xen_pirq_chip,
+		irq_set_chip_and_handler_name(info->irq, &xen_pirq_chip,
 				handle_fasteoi_irq, name);
 	else
-		irq_set_chip_and_handler_name(irq, &xen_pirq_chip,
+		irq_set_chip_and_handler_name(info->irq, &xen_pirq_chip,
 				handle_edge_irq, name);
 
+	ret = info->irq;
+
 out:
 	mutex_unlock(&irq_mapping_update_lock);
 
-	return irq;
+	return ret;
 }
 
 #ifdef CONFIG_PCI_MSI
@@ -1104,6 +1081,7 @@ int xen_bind_pirq_msi_to_irq(struct pci_dev *dev, struct msi_desc *msidesc,
 			     int pirq, int nvec, const char *name, domid_t domid)
 {
 	int i, irq, ret;
+	struct irq_info *info;
 
 	mutex_lock(&irq_mapping_update_lock);
 
@@ -1112,12 +1090,13 @@ int xen_bind_pirq_msi_to_irq(struct pci_dev *dev, struct msi_desc *msidesc,
 		goto out;
 
 	for (i = 0; i < nvec; i++) {
-		if (!xen_irq_init(irq + i))
+		info = xen_irq_init(irq + i);
+		if (!info)
 			goto error_irq;
 
 		irq_set_chip_and_handler_name(irq + i, &xen_pirq_chip, handle_edge_irq, name);
 
-		ret = xen_irq_info_pirq_setup(irq + i, 0, pirq + i, 0, domid,
+		ret = xen_irq_info_pirq_setup(info, 0, pirq + i, 0, domid,
 					      i == 0 ? 0 : PIRQ_MSI_GROUP);
 		if (ret < 0)
 			goto error_irq;
@@ -1129,9 +1108,12 @@ int xen_bind_pirq_msi_to_irq(struct pci_dev *dev, struct msi_desc *msidesc,
 out:
 	mutex_unlock(&irq_mapping_update_lock);
 	return irq;
+
 error_irq:
-	while (nvec--)
-		__unbind_from_irq(irq + nvec);
+	while (nvec--) {
+		info = info_for_irq(irq + nvec);
+		__unbind_from_irq(info, irq + nvec);
+	}
 	mutex_unlock(&irq_mapping_update_lock);
 	return ret;
 }
@@ -1167,7 +1149,7 @@ int xen_destroy_irq(int irq)
 		}
 	}
 
-	xen_free_irq(irq);
+	xen_free_irq(info);
 
 out:
 	mutex_unlock(&irq_mapping_update_lock);
@@ -1183,8 +1165,7 @@ EXPORT_SYMBOL_GPL(xen_pirq_from_irq);
 static int bind_evtchn_to_irq_chip(evtchn_port_t evtchn, struct irq_chip *chip,
 				   struct xenbus_device *dev)
 {
-	int irq;
-	int ret;
+	int ret = -ENOMEM;
 	struct irq_info *info;
 
 	if (evtchn >= xen_evtchn_max_channels())
@@ -1195,17 +1176,16 @@ static int bind_evtchn_to_irq_chip(evtchn_port_t evtchn, struct irq_chip *chip,
 	info = evtchn_to_info(evtchn);
 
 	if (!info) {
-		irq = xen_allocate_irq_dynamic();
-		if (irq < 0)
+		info = xen_allocate_irq_dynamic();
+		if (!info)
 			goto out;
 
-		irq_set_chip_and_handler_name(irq, chip,
+		irq_set_chip_and_handler_name(info->irq, chip,
 					      handle_edge_irq, "event");
 
-		ret = xen_irq_info_evtchn_setup(irq, evtchn, dev);
+		ret = xen_irq_info_evtchn_setup(info, evtchn, dev);
 		if (ret < 0) {
-			__unbind_from_irq(irq);
-			irq = ret;
+			__unbind_from_irq(info, info->irq);
 			goto out;
 		}
 		/*
@@ -1215,16 +1195,17 @@ static int bind_evtchn_to_irq_chip(evtchn_port_t evtchn, struct irq_chip *chip,
 		 * affinity setting is not invoked on them so nothing would
 		 * bind the channel.
 		 */
-		bind_evtchn_to_cpu(evtchn, 0, false);
+		bind_evtchn_to_cpu(info, 0, false);
 	} else {
 		WARN_ON(info->type != IRQT_EVTCHN);
-		irq = info->irq;
 	}
 
+	ret = info->irq;
+
 out:
 	mutex_unlock(&irq_mapping_update_lock);
 
-	return irq;
+	return ret;
 }
 
 int bind_evtchn_to_irq(evtchn_port_t evtchn)
@@ -1243,18 +1224,19 @@ static int bind_ipi_to_irq(unsigned int ipi, unsigned int cpu)
 {
 	struct evtchn_bind_ipi bind_ipi;
 	evtchn_port_t evtchn;
-	int ret, irq;
+	struct irq_info *info;
+	int ret;
 
 	mutex_lock(&irq_mapping_update_lock);
 
-	irq = per_cpu(ipi_to_irq, cpu)[ipi];
+	ret = per_cpu(ipi_to_irq, cpu)[ipi];
 
-	if (irq == -1) {
-		irq = xen_allocate_irq_dynamic();
-		if (irq < 0)
+	if (ret == -1) {
+		info = xen_allocate_irq_dynamic();
+		if (!info)
 			goto out;
 
-		irq_set_chip_and_handler_name(irq, &xen_percpu_chip,
+		irq_set_chip_and_handler_name(info->irq, &xen_percpu_chip,
 					      handle_percpu_irq, "ipi");
 
 		bind_ipi.vcpu = xen_vcpu_nr(cpu);
@@ -1263,25 +1245,25 @@ static int bind_ipi_to_irq(unsigned int ipi, unsigned int cpu)
 			BUG();
 		evtchn = bind_ipi.port;
 
-		ret = xen_irq_info_ipi_setup(cpu, irq, evtchn, ipi);
+		ret = xen_irq_info_ipi_setup(info, cpu, evtchn, ipi);
 		if (ret < 0) {
-			__unbind_from_irq(irq);
-			irq = ret;
+			__unbind_from_irq(info, info->irq);
 			goto out;
 		}
 		/*
 		 * Force the affinity mask to the target CPU so proc shows
 		 * the correct target.
 		 */
-		bind_evtchn_to_cpu(evtchn, cpu, true);
+		bind_evtchn_to_cpu(info, cpu, true);
+		ret = info->irq;
 	} else {
-		struct irq_info *info = info_for_irq(irq);
+		info = info_for_irq(ret);
 		WARN_ON(info == NULL || info->type != IRQT_IPI);
 	}
 
  out:
 	mutex_unlock(&irq_mapping_update_lock);
-	return irq;
+	return ret;
 }
 
 static int bind_interdomain_evtchn_to_irq_chip(struct xenbus_device *dev,
@@ -1349,22 +1331,23 @@ int bind_virq_to_irq(unsigned int virq, unsigned int cpu, bool percpu)
 {
 	struct evtchn_bind_virq bind_virq;
 	evtchn_port_t evtchn = 0;
-	int irq, ret;
+	struct irq_info *info;
+	int ret;
 
 	mutex_lock(&irq_mapping_update_lock);
 
-	irq = per_cpu(virq_to_irq, cpu)[virq];
+	ret = per_cpu(virq_to_irq, cpu)[virq];
 
-	if (irq == -1) {
-		irq = xen_allocate_irq_dynamic();
-		if (irq < 0)
+	if (ret == -1) {
+		info = xen_allocate_irq_dynamic();
+		if (!info)
 			goto out;
 
 		if (percpu)
-			irq_set_chip_and_handler_name(irq, &xen_percpu_chip,
+			irq_set_chip_and_handler_name(info->irq, &xen_percpu_chip,
 						      handle_percpu_irq, "virq");
 		else
-			irq_set_chip_and_handler_name(irq, &xen_dynamic_chip,
+			irq_set_chip_and_handler_name(info->irq, &xen_dynamic_chip,
 						      handle_edge_irq, "virq");
 
 		bind_virq.virq = virq;
@@ -1379,10 +1362,9 @@ int bind_virq_to_irq(unsigned int virq, unsigned int cpu, bool percpu)
 			BUG_ON(ret < 0);
 		}
 
-		ret = xen_irq_info_virq_setup(cpu, irq, evtchn, virq);
+		ret = xen_irq_info_virq_setup(info, cpu, evtchn, virq);
 		if (ret < 0) {
-			__unbind_from_irq(irq);
-			irq = ret;
+			__unbind_from_irq(info, info->irq);
 			goto out;
 		}
 
@@ -1390,22 +1372,26 @@ int bind_virq_to_irq(unsigned int virq, unsigned int cpu, bool percpu)
 		 * Force the affinity mask for percpu interrupts so proc
 		 * shows the correct target.
 		 */
-		bind_evtchn_to_cpu(evtchn, cpu, percpu);
+		bind_evtchn_to_cpu(info, cpu, percpu);
+		ret = info->irq;
 	} else {
-		struct irq_info *info = info_for_irq(irq);
+		info = info_for_irq(ret);
 		WARN_ON(info == NULL || info->type != IRQT_VIRQ);
 	}
 
 out:
 	mutex_unlock(&irq_mapping_update_lock);
 
-	return irq;
+	return ret;
 }
 
 static void unbind_from_irq(unsigned int irq)
 {
+	struct irq_info *info;
+
 	mutex_lock(&irq_mapping_update_lock);
-	__unbind_from_irq(irq);
+	info = info_for_irq(irq);
+	__unbind_from_irq(info, irq);
 	mutex_unlock(&irq_mapping_update_lock);
 }
 
@@ -1739,11 +1725,11 @@ void rebind_evtchn_irq(evtchn_port_t evtchn, int irq)
 	BUG_ON(info->type == IRQT_UNBOUND);
 
 	info->irq = irq;
-	(void)xen_irq_info_evtchn_setup(irq, evtchn, NULL);
+	(void)xen_irq_info_evtchn_setup(info, evtchn, NULL);
 
 	mutex_unlock(&irq_mapping_update_lock);
 
-	bind_evtchn_to_cpu(evtchn, info->cpu, false);
+	bind_evtchn_to_cpu(info, info->cpu, false);
 
 	/* Unmask the event channel. */
 	enable_irq(irq);
@@ -1777,7 +1763,7 @@ static int xen_rebind_evtchn_to_cpu(struct irq_info *info, unsigned int tcpu)
 	 * it, but don't do the xenlinux-level rebind in that case.
 	 */
 	if (HYPERVISOR_event_channel_op(EVTCHNOP_bind_vcpu, &bind_vcpu) >= 0)
-		bind_evtchn_to_cpu(evtchn, tcpu, false);
+		bind_evtchn_to_cpu(info, tcpu, false);
 
 	do_unmask(info, EVT_MASK_REASON_TEMPORARY);
 
@@ -1928,7 +1914,7 @@ static void restore_pirqs(void)
 		if (rc) {
 			pr_warn("xen map irq failed gsi=%d irq=%d pirq=%d rc=%d\n",
 				gsi, irq, pirq, rc);
-			xen_free_irq(irq);
+			xen_free_irq(info);
 			continue;
 		}
 
@@ -1942,13 +1928,15 @@ static void restore_cpu_virqs(unsigned int cpu)
 {
 	struct evtchn_bind_virq bind_virq;
 	evtchn_port_t evtchn;
+	struct irq_info *info;
 	int virq, irq;
 
 	for (virq = 0; virq < NR_VIRQS; virq++) {
 		if ((irq = per_cpu(virq_to_irq, cpu)[virq]) == -1)
 			continue;
+		info = info_for_irq(irq);
 
-		BUG_ON(virq_from_irq(irq) != virq);
+		BUG_ON(virq_from_irq(info) != virq);
 
 		/* Get a new binding from Xen. */
 		bind_virq.virq = virq;
@@ -1959,9 +1947,9 @@ static void restore_cpu_virqs(unsigned int cpu)
 		evtchn = bind_virq.port;
 
 		/* Record the new mapping. */
-		(void)xen_irq_info_virq_setup(cpu, irq, evtchn, virq);
+		xen_irq_info_virq_setup(info, cpu, evtchn, virq);
 		/* The affinity mask is still valid */
-		bind_evtchn_to_cpu(evtchn, cpu, false);
+		bind_evtchn_to_cpu(info, cpu, false);
 	}
 }
 
@@ -1969,13 +1957,15 @@ static void restore_cpu_ipis(unsigned int cpu)
 {
 	struct evtchn_bind_ipi bind_ipi;
 	evtchn_port_t evtchn;
+	struct irq_info *info;
 	int ipi, irq;
 
 	for (ipi = 0; ipi < XEN_NR_IPIS; ipi++) {
 		if ((irq = per_cpu(ipi_to_irq, cpu)[ipi]) == -1)
 			continue;
+		info = info_for_irq(irq);
 
-		BUG_ON(ipi_from_irq(irq) != ipi);
+		BUG_ON(ipi_from_irq(info) != ipi);
 
 		/* Get a new binding from Xen. */
 		bind_ipi.vcpu = xen_vcpu_nr(cpu);
@@ -1985,9 +1975,9 @@ static void restore_cpu_ipis(unsigned int cpu)
 		evtchn = bind_ipi.port;
 
 		/* Record the new mapping. */
-		(void)xen_irq_info_ipi_setup(cpu, irq, evtchn, ipi);
+		xen_irq_info_ipi_setup(info, cpu, evtchn, ipi);
 		/* The affinity mask is still valid */
-		bind_evtchn_to_cpu(evtchn, cpu, false);
+		bind_evtchn_to_cpu(info, cpu, false);
 	}
 }
 
-- 
2.35.3

