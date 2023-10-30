Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781FB7DBBB9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjJ3O1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbjJ3O1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:27:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FE1F5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:27:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1AB471FF07;
        Mon, 30 Oct 2023 14:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698676054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+x62jf5ZiMaBeXCGaTeI3fAeetzVsKKIlwH9XbYi/Wk=;
        b=DVFbhplYczx0rCQjxOvC9F63FeFl9OHZE7xQlGzpqBW0G7Msl6Bylf1AyraSQmEocHrYIh
        ppCCeVfnXGjDCYZ3hTKI397EhbDm222zDQWg+DtpbWN/rvvhX/wM4T6jNQ55qBgpg7+XIm
        V+0arNif/gGSK5kvLKV7DzQ+XySO2QE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBD17138F8;
        Mon, 30 Oct 2023 14:27:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4y9JNFW9P2VkQgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 30 Oct 2023 14:27:33 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH] xen/events: avoid using info_for_irq() in xen_send_IPI_one()
Date:   Mon, 30 Oct 2023 15:27:32 +0100
Message-Id: <20231030142732.1702-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xen_send_IPI_one() is being used by cpuhp_report_idle_dead() after
it calls rcu_report_dead(), meaning that any RCU usage by
xen_send_IPI_one() is a bad idea.

Unfortunately xen_send_IPI_one() is using notify_remote_via_irq()
today, which is using irq_get_chip_data() via info_for_irq(). And
irq_get_chip_data() in turn is using a maple-tree lookup requiring
RCU.

Avoid this problem by caching the ipi event channels in another
percpu variable, allowing the use notify_remote_via_evtchn() in
xen_send_IPI_one().

Fixes: 721255b9826b ("genirq: Use a maple tree for interrupt descriptor management")
Reported-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Juergen Gross <jgross@suse.com>
Tested-by: David Woodhouse <dwmw@amazon.co.uk>
---
 drivers/xen/events/events_base.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 1b2136fe0fa5..2cf0c2b69386 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -164,6 +164,8 @@ static DEFINE_PER_CPU(int [NR_VIRQS], virq_to_irq) = {[0 ... NR_VIRQS-1] = -1};
 
 /* IRQ <-> IPI mapping */
 static DEFINE_PER_CPU(int [XEN_NR_IPIS], ipi_to_irq) = {[0 ... XEN_NR_IPIS-1] = -1};
+/* Cache for IPI event channels - needed for hot cpu unplug (avoid RCU usage). */
+static DEFINE_PER_CPU(evtchn_port_t [XEN_NR_IPIS], ipi_to_evtchn) = {[0 ... XEN_NR_IPIS-1] = 0};
 
 /* Event channel distribution data */
 static atomic_t channels_on_cpu[NR_CPUS];
@@ -366,6 +368,7 @@ static int xen_irq_info_ipi_setup(unsigned cpu,
 	info->u.ipi = ipi;
 
 	per_cpu(ipi_to_irq, cpu)[ipi] = irq;
+	per_cpu(ipi_to_evtchn, cpu)[ipi] = evtchn;
 
 	return xen_irq_info_common_setup(info, irq, IRQT_IPI, evtchn, 0);
 }
@@ -981,6 +984,7 @@ static void __unbind_from_irq(unsigned int irq)
 			break;
 		case IRQT_IPI:
 			per_cpu(ipi_to_irq, cpu)[ipi_from_irq(irq)] = -1;
+			per_cpu(ipi_to_evtchn, cpu)[ipi_from_irq(irq)] = 0;
 			break;
 		case IRQT_EVTCHN:
 			dev = info->u.interdomain;
@@ -1631,7 +1635,7 @@ EXPORT_SYMBOL_GPL(evtchn_put);
 
 void xen_send_IPI_one(unsigned int cpu, enum ipi_vector vector)
 {
-	int irq;
+	evtchn_port_t evtchn;
 
 #ifdef CONFIG_X86
 	if (unlikely(vector == XEN_NMI_VECTOR)) {
@@ -1642,9 +1646,9 @@ void xen_send_IPI_one(unsigned int cpu, enum ipi_vector vector)
 		return;
 	}
 #endif
-	irq = per_cpu(ipi_to_irq, cpu)[vector];
-	BUG_ON(irq < 0);
-	notify_remote_via_irq(irq);
+	evtchn = per_cpu(ipi_to_evtchn, cpu)[vector];
+	BUG_ON(evtchn == 0);
+	notify_remote_via_evtchn(evtchn);
 }
 
 struct evtchn_loop_ctrl {
-- 
2.35.3

