Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4FC7C9FB5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 08:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjJPG31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 02:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjJPG3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 02:29:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BA610C
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 23:29:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A8D1F218B5;
        Mon, 16 Oct 2023 06:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697437754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gfiJW8Ts6bK8yjUp0LUTZbfxs1RFtdPcjXwRkvwtN44=;
        b=Fk73jBwYBGOHZuRQoALHGeKcoHC295iWwjwk1PCqfElvmfip/G6emaGyAxVPmH9aWoZSVj
        x0I9FY2B8Q73ebzl86astm9dfJnjSyh0Hd9ywBXWw6DGDdq3QjwQtQ9xHzcY8fa3cuOmZ1
        9vuT25p+m5wTvydo5rnrsa+KMgowATU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CBCA138EF;
        Mon, 16 Oct 2023 06:29:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OKUAHTrYLGXIQQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 16 Oct 2023 06:29:14 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH 7/7] xen/events: remove some info_for_irq() calls in pirq handling
Date:   Mon, 16 Oct 2023 08:28:31 +0200
Message-Id: <20231016062831.20630-8-jgross@suse.com>
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

Instead of the IRQ number user the struct irq_info pointer as parameter
in the internal pirq related functions. This allows to drop some calls
of info_for_irq().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/events/events_base.c | 113 +++++++++++++++++++------------
 1 file changed, 68 insertions(+), 45 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 47a33d3cbfcb..c75dff276894 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -172,7 +172,7 @@ static int **evtchn_to_irq;
 #ifdef CONFIG_X86
 static unsigned long *pirq_eoi_map;
 #endif
-static bool (*pirq_needs_eoi)(unsigned irq);
+static bool (*pirq_needs_eoi)(struct irq_info *info);
 
 #define EVTCHN_ROW(e)  (e / (PAGE_SIZE/sizeof(**evtchn_to_irq)))
 #define EVTCHN_COL(e)  (e % (PAGE_SIZE/sizeof(**evtchn_to_irq)))
@@ -188,7 +188,6 @@ static struct irq_chip xen_lateeoi_chip;
 static struct irq_chip xen_percpu_chip;
 static struct irq_chip xen_pirq_chip;
 static void enable_dynirq(struct irq_data *data);
-static void disable_dynirq(struct irq_data *data);
 
 static DEFINE_PER_CPU(unsigned int, irq_epoch);
 
@@ -451,10 +450,8 @@ static unsigned int virq_from_irq(struct irq_info *info)
 	return info->u.virq;
 }
 
-static unsigned pirq_from_irq(unsigned irq)
+static unsigned int pirq_from_irq(struct irq_info *info)
 {
-	struct irq_info *info = info_for_irq(irq);
-
 	BUG_ON(info == NULL);
 	BUG_ON(info->type != IRQT_PIRQ);
 
@@ -497,15 +494,14 @@ static void do_unmask(struct irq_info *info, u8 reason)
 }
 
 #ifdef CONFIG_X86
-static bool pirq_check_eoi_map(unsigned irq)
+static bool pirq_check_eoi_map(struct irq_info *info)
 {
-	return test_bit(pirq_from_irq(irq), pirq_eoi_map);
+	return test_bit(pirq_from_irq(info), pirq_eoi_map);
 }
 #endif
 
-static bool pirq_needs_eoi_flag(unsigned irq)
+static bool pirq_needs_eoi_flag(struct irq_info *info)
 {
-	struct irq_info *info = info_for_irq(irq);
 	BUG_ON(info->type != IRQT_PIRQ);
 
 	return info->u.pirq.flags & PIRQ_NEEDS_EOI;
@@ -799,14 +795,13 @@ static void event_handler_exit(struct irq_info *info)
 	clear_evtchn(info->evtchn);
 }
 
-static void pirq_query_unmask(int irq)
+static void pirq_query_unmask(struct irq_info *info)
 {
 	struct physdev_irq_status_query irq_status;
-	struct irq_info *info = info_for_irq(irq);
 
 	BUG_ON(info->type != IRQT_PIRQ);
 
-	irq_status.irq = pirq_from_irq(irq);
+	irq_status.irq = info->u.pirq.pirq;
 	if (HYPERVISOR_physdev_op(PHYSDEVOP_irq_status_query, &irq_status))
 		irq_status.flags = 0;
 
@@ -815,35 +810,57 @@ static void pirq_query_unmask(int irq)
 		info->u.pirq.flags |= PIRQ_NEEDS_EOI;
 }
 
-static void eoi_pirq(struct irq_data *data)
+static void do_eoi_pirq(struct irq_info *info)
 {
-	struct irq_info *info = info_for_irq(data->irq);
-	evtchn_port_t evtchn = info ? info->evtchn : 0;
-	struct physdev_eoi eoi = { .irq = pirq_from_irq(data->irq) };
+	struct physdev_eoi eoi = { .irq = pirq_from_irq(info) };
 	int rc = 0;
 
-	if (!VALID_EVTCHN(evtchn))
+	if (!VALID_EVTCHN(info->evtchn))
 		return;
 
 	event_handler_exit(info);
 
-	if (pirq_needs_eoi(data->irq)) {
+	if (pirq_needs_eoi(info)) {
 		rc = HYPERVISOR_physdev_op(PHYSDEVOP_eoi, &eoi);
 		WARN_ON(rc);
 	}
 }
 
+static void eoi_pirq(struct irq_data *data)
+{
+	struct irq_info *info = info_for_irq(data->irq);
+
+	do_eoi_pirq(info);
+}
+
+static void do_disable_dynirq(struct irq_info *info)
+{
+	if (VALID_EVTCHN(info->evtchn))
+		do_mask(info, EVT_MASK_REASON_EXPLICIT);
+}
+
+static void disable_dynirq(struct irq_data *data)
+{
+	struct irq_info *info = info_for_irq(data->irq);
+
+	if (info)
+		do_disable_dynirq(info);
+}
+
 static void mask_ack_pirq(struct irq_data *data)
 {
-	disable_dynirq(data);
-	eoi_pirq(data);
+	struct irq_info *info = info_for_irq(data->irq);
+
+	if (info) {
+		do_disable_dynirq(info);
+		do_eoi_pirq(info);
+	}
 }
 
-static unsigned int __startup_pirq(unsigned int irq)
+static unsigned int __startup_pirq(struct irq_info *info)
 {
 	struct evtchn_bind_pirq bind_pirq;
-	struct irq_info *info = info_for_irq(irq);
-	evtchn_port_t evtchn = evtchn_from_irq(irq);
+	evtchn_port_t evtchn = info->evtchn;
 	int rc;
 
 	BUG_ON(info->type != IRQT_PIRQ);
@@ -851,20 +868,20 @@ static unsigned int __startup_pirq(unsigned int irq)
 	if (VALID_EVTCHN(evtchn))
 		goto out;
 
-	bind_pirq.pirq = pirq_from_irq(irq);
+	bind_pirq.pirq = pirq_from_irq(info);
 	/* NB. We are happy to share unless we are probing. */
 	bind_pirq.flags = info->u.pirq.flags & PIRQ_SHAREABLE ?
 					BIND_PIRQ__WILL_SHARE : 0;
 	rc = HYPERVISOR_event_channel_op(EVTCHNOP_bind_pirq, &bind_pirq);
 	if (rc != 0) {
-		pr_warn("Failed to obtain physical IRQ %d\n", irq);
+		pr_warn("Failed to obtain physical IRQ %d\n", info->irq);
 		return 0;
 	}
 	evtchn = bind_pirq.port;
 
-	pirq_query_unmask(irq);
+	pirq_query_unmask(info);
 
-	rc = set_evtchn_to_irq(evtchn, irq);
+	rc = set_evtchn_to_irq(evtchn, info->irq);
 	if (rc)
 		goto err;
 
@@ -878,26 +895,28 @@ static unsigned int __startup_pirq(unsigned int irq)
 out:
 	do_unmask(info, EVT_MASK_REASON_EXPLICIT);
 
-	eoi_pirq(irq_get_irq_data(irq));
+	do_eoi_pirq(info);
 
 	return 0;
 
 err:
-	pr_err("irq%d: Failed to set port to irq mapping (%d)\n", irq, rc);
+	pr_err("irq%d: Failed to set port to irq mapping (%d)\n", info->irq,
+	       rc);
 	xen_evtchn_close(evtchn);
 	return 0;
 }
 
 static unsigned int startup_pirq(struct irq_data *data)
 {
-	return __startup_pirq(data->irq);
+	struct irq_info *info = info_for_irq(data->irq);
+
+	return __startup_pirq(info);
 }
 
 static void shutdown_pirq(struct irq_data *data)
 {
-	unsigned int irq = data->irq;
-	struct irq_info *info = info_for_irq(irq);
-	evtchn_port_t evtchn = evtchn_from_irq(irq);
+	struct irq_info *info = info_for_irq(data->irq);
+	evtchn_port_t evtchn = info->evtchn;
 
 	BUG_ON(info->type != IRQT_PIRQ);
 
@@ -1031,7 +1050,7 @@ int xen_bind_pirq_gsi_to_irq(unsigned gsi,
 		goto out;
 	}
 
-	pirq_query_unmask(info->irq);
+	pirq_query_unmask(info);
 	/* We try to use the handler with the appropriate semantic for the
 	 * type of interrupt: if the interrupt is an edge triggered
 	 * interrupt we use handle_edge_irq.
@@ -1158,7 +1177,9 @@ int xen_destroy_irq(int irq)
 
 int xen_pirq_from_irq(unsigned irq)
 {
-	return pirq_from_irq(irq);
+	struct irq_info *info = info_for_irq(irq);
+
+	return pirq_from_irq(info);
 }
 EXPORT_SYMBOL_GPL(xen_pirq_from_irq);
 
@@ -1820,28 +1841,30 @@ static void enable_dynirq(struct irq_data *data)
 		do_unmask(info, EVT_MASK_REASON_EXPLICIT);
 }
 
-static void disable_dynirq(struct irq_data *data)
+static void do_ack_dynirq(struct irq_info *info)
 {
-	struct irq_info *info = info_for_irq(data->irq);
-	evtchn_port_t evtchn = info ? info->evtchn : 0;
+	evtchn_port_t evtchn = info->evtchn;
 
 	if (VALID_EVTCHN(evtchn))
-		do_mask(info, EVT_MASK_REASON_EXPLICIT);
+		event_handler_exit(info);
 }
 
 static void ack_dynirq(struct irq_data *data)
 {
 	struct irq_info *info = info_for_irq(data->irq);
-	evtchn_port_t evtchn = info ? info->evtchn : 0;
 
-	if (VALID_EVTCHN(evtchn))
-		event_handler_exit(info);
+	if (info)
+		do_ack_dynirq(info);
 }
 
 static void mask_ack_dynirq(struct irq_data *data)
 {
-	disable_dynirq(data);
-	ack_dynirq(data);
+	struct irq_info *info = info_for_irq(data->irq);
+
+	if (info) {
+		do_disable_dynirq(info);
+		do_ack_dynirq(info);
+	}
 }
 
 static void lateeoi_ack_dynirq(struct irq_data *data)
@@ -1920,7 +1943,7 @@ static void restore_pirqs(void)
 
 		printk(KERN_DEBUG "xen: --> irq=%d, pirq=%d\n", irq, map_irq.pirq);
 
-		__startup_pirq(irq);
+		__startup_pirq(info);
 	}
 }
 
-- 
2.35.3

