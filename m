Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7A27C9F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 08:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjJPG3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 02:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjJPG24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 02:28:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB21F3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 23:28:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6C3DD218B5;
        Mon, 16 Oct 2023 06:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697437732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ydWqnY65qleF7L+CVZP+R/eFnKLoLLs90oWX5lP4me4=;
        b=fJOGjm92PDGBloxprGkOy2oR2KxyYzORf6xAwXbhjknw7+qrgrs4kMEXiB9MzYRxP97D92
        AJ9dmPLcefR7lUBQgWlzIlrQ2Sqv9p85J3SGYg/LVlKwQVqVYpff4Ra8XR5qvsjaEhf71n
        MT90eBUqsRPAq1dHZ4e4/OAlMh3M4YM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3EFD5138EF;
        Mon, 16 Oct 2023 06:28:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yC8PDiTYLGWVQQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 16 Oct 2023 06:28:52 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH 3/7] xen/events: reduce externally visible helper functions
Date:   Mon, 16 Oct 2023 08:28:27 +0200
Message-Id: <20231016062831.20630-4-jgross@suse.com>
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

get_evtchn_to_irq() has only one external user while irq_from_evtchn()
provides the same functionality and is exported for a wider user base.
Modify the only external user of get_evtchn_to_irq() to use
irq_from_evtchn() instead and make get_evtchn_to_irq() static.

evtchn_from_irq() and irq_from_virq() have a single external user and
can easily be combined to a new helper irq_evtchn_from_virq() allowing
to drop irq_from_virq() and to make evtchn_from_irq() static.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/events/events_2l.c       |  8 ++++----
 drivers/xen/events/events_base.c     | 13 +++++++++----
 drivers/xen/events/events_internal.h |  1 -
 include/xen/events.h                 |  4 ++--
 4 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/xen/events/events_2l.c b/drivers/xen/events/events_2l.c
index b8f2f971c2f0..e3585330cf98 100644
--- a/drivers/xen/events/events_2l.c
+++ b/drivers/xen/events/events_2l.c
@@ -171,11 +171,11 @@ static void evtchn_2l_handle_events(unsigned cpu, struct evtchn_loop_ctrl *ctrl)
 	int i;
 	struct shared_info *s = HYPERVISOR_shared_info;
 	struct vcpu_info *vcpu_info = __this_cpu_read(xen_vcpu);
+	evtchn_port_t evtchn;
 
 	/* Timer interrupt has highest priority. */
-	irq = irq_from_virq(cpu, VIRQ_TIMER);
+	irq = irq_evtchn_from_virq(cpu, VIRQ_TIMER, &evtchn);
 	if (irq != -1) {
-		evtchn_port_t evtchn = evtchn_from_irq(irq);
 		word_idx = evtchn / BITS_PER_LONG;
 		bit_idx = evtchn % BITS_PER_LONG;
 		if (active_evtchns(cpu, s, word_idx) & (1ULL << bit_idx))
@@ -328,9 +328,9 @@ irqreturn_t xen_debug_interrupt(int irq, void *dev_id)
 	for (i = 0; i < EVTCHN_2L_NR_CHANNELS; i++) {
 		if (sync_test_bit(i, BM(sh->evtchn_pending))) {
 			int word_idx = i / BITS_PER_EVTCHN_WORD;
-			printk("  %d: event %d -> irq %d%s%s%s\n",
+			printk("  %d: event %d -> irq %u%s%s%s\n",
 			       cpu_from_evtchn(i), i,
-			       get_evtchn_to_irq(i),
+			       irq_from_evtchn(i),
 			       sync_test_bit(word_idx, BM(&v->evtchn_pending_sel))
 			       ? "" : " l2-clear",
 			       !sync_test_bit(i, BM(sh->evtchn_mask))
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 1d797dd85d0e..97d71c5e7c28 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -246,7 +246,7 @@ static int set_evtchn_to_irq(evtchn_port_t evtchn, unsigned int irq)
 	return 0;
 }
 
-int get_evtchn_to_irq(evtchn_port_t evtchn)
+static int get_evtchn_to_irq(evtchn_port_t evtchn)
 {
 	if (evtchn >= xen_evtchn_max_channels())
 		return -1;
@@ -412,7 +412,7 @@ static void xen_irq_info_cleanup(struct irq_info *info)
 /*
  * Accessors for packed IRQ information.
  */
-evtchn_port_t evtchn_from_irq(unsigned irq)
+static evtchn_port_t evtchn_from_irq(unsigned int irq)
 {
 	const struct irq_info *info = NULL;
 
@@ -430,9 +430,14 @@ unsigned int irq_from_evtchn(evtchn_port_t evtchn)
 }
 EXPORT_SYMBOL_GPL(irq_from_evtchn);
 
-int irq_from_virq(unsigned int cpu, unsigned int virq)
+int irq_evtchn_from_virq(unsigned int cpu, unsigned int virq,
+			 evtchn_port_t *evtchn)
 {
-	return per_cpu(virq_to_irq, cpu)[virq];
+	int irq = per_cpu(virq_to_irq, cpu)[virq];
+
+	*evtchn = evtchn_from_irq(irq);
+
+	return irq;
 }
 
 static enum ipi_vector ipi_from_irq(unsigned irq)
diff --git a/drivers/xen/events/events_internal.h b/drivers/xen/events/events_internal.h
index 4d3398eff9cd..19ae31695edc 100644
--- a/drivers/xen/events/events_internal.h
+++ b/drivers/xen/events/events_internal.h
@@ -33,7 +33,6 @@ struct evtchn_ops {
 
 extern const struct evtchn_ops *evtchn_ops;
 
-int get_evtchn_to_irq(evtchn_port_t evtchn);
 void handle_irq_for_port(evtchn_port_t port, struct evtchn_loop_ctrl *ctrl);
 
 unsigned int cpu_from_evtchn(evtchn_port_t evtchn);
diff --git a/include/xen/events.h b/include/xen/events.h
index a129cafa80ed..3b07409f8032 100644
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -100,8 +100,8 @@ void xen_poll_irq_timeout(int irq, u64 timeout);
 
 /* Determine the IRQ which is bound to an event channel */
 unsigned int irq_from_evtchn(evtchn_port_t evtchn);
-int irq_from_virq(unsigned int cpu, unsigned int virq);
-evtchn_port_t evtchn_from_irq(unsigned irq);
+int irq_evtchn_from_virq(unsigned int cpu, unsigned int virq,
+			 evtchn_port_t *evtchn);
 
 int xen_set_callback_via(uint64_t via);
 int xen_evtchn_do_upcall(void);
-- 
2.35.3

