Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A5F787474
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242276AbjHXPlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242274AbjHXPlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:41:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25252CCB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:41:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CE83921890;
        Thu, 24 Aug 2023 15:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692891668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=9/kOeP6eJirlVSVxrRB3IZ2bMbCx1I/9IzEaeTk09ZY=;
        b=ZUWWuSKuwQ9meA8nLTMoldNyIiDZACendfPRUOtjf6WPvmItGcRWUJ+VznaE+ZqboueGI7
        xG/+V0dZFvSmFec9cbgDOq2KOgAymZl/V0GznId1EPMwLPQxfzqByWyuKBh1LED2epBAlo
        5WNg/bnZ2ElqfFTywJL0yZaHOADhJjg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73115132F2;
        Thu, 24 Aug 2023 15:41:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LD64GhR652RlSAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 24 Aug 2023 15:41:08 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH] xen: simplify evtchn_do_upcall() call maze
Date:   Thu, 24 Aug 2023 17:41:06 +0200
Message-Id: <20230824154106.14799-1-jgross@suse.com>
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

There are several functions involved for performing the functionality
of evtchn_do_upcall():

- __xen_evtchn_do_upcall() doing the real work
- xen_hvm_evtchn_do_upcall() just being a wrapper for
  __xen_evtchn_do_upcall(), exposed for external callers
- xen_evtchn_do_upcall() calling __xen_evtchn_do_upcall(), too, but
  without any user

Simplify this maze by:

- removing the unused xen_evtchn_do_upcall()
- removing xen_hvm_evtchn_do_upcall() as the only left caller of
  __xen_evtchn_do_upcall(), while renaming __xen_evtchn_do_upcall() to
  xen_evtchn_do_upcall()

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/entry/common.c          |  2 +-
 arch/x86/xen/enlighten.c         |  2 +-
 arch/x86/xen/enlighten_hvm.c     |  2 +-
 drivers/xen/events/events_base.c | 21 ++-------------------
 drivers/xen/platform-pci.c       |  2 +-
 include/xen/events.h             |  3 +--
 6 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6c2826417b33..93c60c0c9d4a 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -294,7 +294,7 @@ static void __xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 
 	inc_irq_stat(irq_hv_callback_count);
 
-	xen_hvm_evtchn_do_upcall();
+	xen_evtchn_do_upcall();
 
 	set_irq_regs(old_regs);
 }
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index b8db2148c07d..0337392a3121 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -32,7 +32,7 @@ EXPORT_SYMBOL_GPL(hypercall_page);
  * &HYPERVISOR_shared_info->vcpu_info[cpu]. See xen_hvm_init_shared_info
  * and xen_vcpu_setup for details. By default it points to share_info->vcpu_info
  * but during boot it is switched to point to xen_vcpu_info.
- * The pointer is used in __xen_evtchn_do_upcall to acknowledge pending events.
+ * The pointer is used in xen_evtchn_do_upcall to acknowledge pending events.
  */
 DEFINE_PER_CPU(struct vcpu_info *, xen_vcpu);
 DEFINE_PER_CPU(struct vcpu_info, xen_vcpu_info);
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index a6820ca940bf..fbf37ae825bf 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -136,7 +136,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_xen_hvm_callback)
 
 	inc_irq_stat(irq_hv_callback_count);
 
-	xen_hvm_evtchn_do_upcall();
+	xen_evtchn_do_upcall();
 
 	set_irq_regs(old_regs);
 }
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 3bdd5b59661d..0bb86e6c4d0a 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1704,7 +1704,7 @@ void handle_irq_for_port(evtchn_port_t port, struct evtchn_loop_ctrl *ctrl)
 	generic_handle_irq(irq);
 }
 
-static int __xen_evtchn_do_upcall(void)
+int xen_evtchn_do_upcall(void)
 {
 	struct vcpu_info *vcpu_info = __this_cpu_read(xen_vcpu);
 	int ret = vcpu_info->evtchn_upcall_pending ? IRQ_HANDLED : IRQ_NONE;
@@ -1735,24 +1735,7 @@ static int __xen_evtchn_do_upcall(void)
 
 	return ret;
 }
-
-void xen_evtchn_do_upcall(struct pt_regs *regs)
-{
-	struct pt_regs *old_regs = set_irq_regs(regs);
-
-	irq_enter();
-
-	__xen_evtchn_do_upcall();
-
-	irq_exit();
-	set_irq_regs(old_regs);
-}
-
-int xen_hvm_evtchn_do_upcall(void)
-{
-	return __xen_evtchn_do_upcall();
-}
-EXPORT_SYMBOL_GPL(xen_hvm_evtchn_do_upcall);
+EXPORT_SYMBOL_GPL(xen_evtchn_do_upcall);
 
 /* Rebind a new event channel to an existing irq. */
 void rebind_evtchn_irq(evtchn_port_t evtchn, int irq)
diff --git a/drivers/xen/platform-pci.c b/drivers/xen/platform-pci.c
index fcc819131572..544d3f9010b9 100644
--- a/drivers/xen/platform-pci.c
+++ b/drivers/xen/platform-pci.c
@@ -64,7 +64,7 @@ static uint64_t get_callback_via(struct pci_dev *pdev)
 
 static irqreturn_t do_hvm_evtchn_intr(int irq, void *dev_id)
 {
-	return xen_hvm_evtchn_do_upcall();
+	return xen_evtchn_do_upcall();
 }
 
 static int xen_allocate_irq(struct pci_dev *pdev)
diff --git a/include/xen/events.h b/include/xen/events.h
index 95970a2f7695..8f62d15eef90 100644
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -106,8 +106,7 @@ int irq_from_virq(unsigned int cpu, unsigned int virq);
 evtchn_port_t evtchn_from_irq(unsigned irq);
 
 int xen_set_callback_via(uint64_t via);
-void xen_evtchn_do_upcall(struct pt_regs *regs);
-int xen_hvm_evtchn_do_upcall(void);
+int xen_evtchn_do_upcall(void);
 
 /* Bind a pirq for a physical interrupt to an irq. */
 int xen_bind_pirq_gsi_to_irq(unsigned gsi,
-- 
2.35.3

