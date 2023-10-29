Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3287DAE9E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 22:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjJ2Vdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 17:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjJ2Vdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 17:33:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BFCC0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 14:33:32 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698615211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=yprqf5f/hnK/okVp8EW2MwTwwj/D7yRO4l5PnNv3qYc=;
        b=GSkJmWypOa4UQz1XmqBL4meRvW7oiWwy4S6eqy1iyAqjdarg+veOrX4Sy9WCIb9bC9hkyP
        1jItzI/+hz1al9EkGf5GrABU2qCa5WNgqt630xsOisdVxOQcZVcTE0iTligHOYBQEkwqXY
        O1mp1qZvxvHMMaysgANVK/L4G2FHGxbGQFMax9+is9N8loO6Q656JN+scVtcmWIyVSbJ5+
        eK/UPjctLNVxpmFjYYvJ0ts4qHVSiRlptwoWq7BHjdlifeNWD0cRDmlyuoAIC6fDmogN8d
        /B3L36WXzToWqVa4VMNj0+CotIn53TD1QjAxTT669gonhbzoL8avXd8nglfwwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698615211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=yprqf5f/hnK/okVp8EW2MwTwwj/D7yRO4l5PnNv3qYc=;
        b=7bEs5Xk6niAK0mNOE2u2hYUHv90yApLVoMpiafo+FCXl8b4IHg7RPjuq+CXEV7vCBoNnM8
        sguEHxs7ZATIUeDQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/apic for v6.7-rc1
References: <169861500709.181063.7816209662289132093.tglx@xen13>
Message-ID: <169861501334.181063.3078165562616801860.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 29 Oct 2023 22:33:30 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/apic branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2023-10=
-29-v2

up to:  b56ebe7c896d: x86/apic/msi: Fix misconfigured non-maskable MSI quirk

Updates for the X86 APIC:

  - Make the quirk for non-maskable MSI interrupts in the affinity setter
    functional again.

    It was broken by a MSI core code update, which restructured the code in
    a way that the quirk flag was not longer set correctly.

    Trying to restore the core logic caused a deeper inspection and it
    turned out that the extra quirk flag is not required at all because
    it's the inverse of the reservation mode bit, which only can be set
    when the MSI interrupt is maskable.

    So the trivial fix is to use the reservation mode check in the affinity
    setter function and remove almost 40 lines of code related to the
    no-mask quirk flag.

  - Cure a Kconfig dependency issue which causes compile fails by correcting
    the conditionals in the affected heaer files.

  - Clean up coding style in the UV APIC driver.

Thanks,

	tglx

------------------>
Koichiro Den (1):
      x86/apic/msi: Fix misconfigured non-maskable MSI quirk

Lu Yao (1):
      x86/msi: Fix compile error caused by CONFIG_GENERIC_MSI_IRQ=3Dy && !CON=
FIG_X86_LOCAL_APIC

Yang Li (1):
      x86/platform/uv/apic: Clean up inconsistent indenting


 arch/x86/include/asm/hw_irq.h      |  6 +++---
 arch/x86/kernel/apic/msi.c         |  8 +++-----
 arch/x86/kernel/apic/x2apic_uv_x.c |  2 +-
 arch/x86/kernel/hpet.c             |  4 ++--
 include/linux/irq.h                | 26 ++++----------------------
 include/linux/msi.h                |  6 ------
 kernel/irq/debugfs.c               |  1 -
 kernel/irq/msi.c                   | 12 +-----------
 8 files changed, 14 insertions(+), 51 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 551829884734..b02c3cd3c0f6 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -28,7 +28,7 @@
 #include <asm/irq.h>
 #include <asm/sections.h>
=20
-#ifdef	CONFIG_X86_LOCAL_APIC
+#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 struct irq_data;
 struct pci_dev;
 struct msi_desc;
@@ -105,10 +105,10 @@ static inline void irq_complete_move(struct irq_cfg *c)=
 { }
 #endif
=20
 extern void apic_ack_edge(struct irq_data *data);
-#else	/*  CONFIG_X86_LOCAL_APIC */
+#else	/*  CONFIG_IRQ_DOMAIN_HIERARCHY */
 static inline void lock_vector_lock(void) {}
 static inline void unlock_vector_lock(void) {}
-#endif	/* CONFIG_X86_LOCAL_APIC */
+#endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
=20
 /* Statistics */
 extern atomic_t irq_err_count;
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 6b6b711678fe..d9651f15ae4f 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -55,14 +55,14 @@ msi_set_affinity(struct irq_data *irqd, const struct cpum=
ask *mask, bool force)
 	 * caused by the non-atomic update of the address/data pair.
 	 *
 	 * Direct update is possible when:
-	 * - The MSI is maskable (remapped MSI does not use this code path)).
-	 *   The quirk bit is not set in this case.
+	 * - The MSI is maskable (remapped MSI does not use this code path).
+	 *   The reservation mode bit is set in this case.
 	 * - The new vector is the same as the old vector
 	 * - The old vector is MANAGED_IRQ_SHUTDOWN_VECTOR (interrupt starts up)
 	 * - The interrupt is not yet started up
 	 * - The new destination CPU is the same as the old destination CPU
 	 */
-	if (!irqd_msi_nomask_quirk(irqd) ||
+	if (!irqd_can_reserve(irqd) ||
 	    cfg->vector =3D=3D old_cfg.vector ||
 	    old_cfg.vector =3D=3D MANAGED_IRQ_SHUTDOWN_VECTOR ||
 	    !irqd_is_started(irqd) ||
@@ -215,8 +215,6 @@ static bool x86_init_dev_msi_info(struct device *dev, str=
uct irq_domain *domain,
 		if (WARN_ON_ONCE(domain !=3D real_parent))
 			return false;
 		info->chip->irq_set_affinity =3D msi_set_affinity;
-		/* See msi_set_affinity() for the gory details */
-		info->flags |=3D MSI_FLAG_NOMASK_QUIRK;
 		break;
 	case DOMAIN_BUS_DMAR:
 	case DOMAIN_BUS_AMDVI:
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic=
_uv_x.c
index 205cee567629..7d304ef1a7f5 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -110,7 +110,7 @@ static void __init early_get_pnodeid(void)
 	} else if (UVH_RH_GAM_ADDR_MAP_CONFIG) {
 		union uvh_rh_gam_addr_map_config_u  m_n_config;
=20
-	m_n_config.v =3D uv_early_read_mmr(UVH_RH_GAM_ADDR_MAP_CONFIG);
+		m_n_config.v =3D uv_early_read_mmr(UVH_RH_GAM_ADDR_MAP_CONFIG);
 		uv_cpuid.n_skt =3D m_n_config.s.n_skt;
 		if (is_uv(UV3))
 			uv_cpuid.m_skt =3D m_n_config.s3.m_skt;
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 1648aa0204d9..41eecf180b7f 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -52,7 +52,7 @@ unsigned long				hpet_address;
 u8					hpet_blockid; /* OS timer block num */
 bool					hpet_msi_disable;
=20
-#ifdef CONFIG_GENERIC_MSI_IRQ
+#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_GENERIC_MSI_IRQ)
 static DEFINE_PER_CPU(struct hpet_channel *, cpu_hpet_channel);
 static struct irq_domain		*hpet_domain;
 #endif
@@ -469,7 +469,7 @@ static void __init hpet_legacy_clockevent_register(struct=
 hpet_channel *hc)
 /*
  * HPET MSI Support
  */
-#ifdef CONFIG_GENERIC_MSI_IRQ
+#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_GENERIC_MSI_IRQ)
 static void hpet_msi_unmask(struct irq_data *data)
 {
 	struct hpet_channel *hc =3D irq_data_get_irq_handler_data(data);
diff --git a/include/linux/irq.h b/include/linux/irq.h
index d8a6fdce9373..90081afa10ce 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -215,8 +215,6 @@ struct irq_data {
  * IRQD_SINGLE_TARGET		- IRQ allows only a single affinity target
  * IRQD_DEFAULT_TRIGGER_SET	- Expected trigger already been set
  * IRQD_CAN_RESERVE		- Can use reservation mode
- * IRQD_MSI_NOMASK_QUIRK	- Non-maskable MSI quirk for affinity change
- *				  required
  * IRQD_HANDLE_ENFORCE_IRQCTX	- Enforce that handle_irq_*() is only invoked
  *				  from actual interrupt context.
  * IRQD_AFFINITY_ON_ACTIVATE	- Affinity is set on activation. Don't call
@@ -247,11 +245,10 @@ enum {
 	IRQD_SINGLE_TARGET		=3D BIT(24),
 	IRQD_DEFAULT_TRIGGER_SET	=3D BIT(25),
 	IRQD_CAN_RESERVE		=3D BIT(26),
-	IRQD_MSI_NOMASK_QUIRK		=3D BIT(27),
-	IRQD_HANDLE_ENFORCE_IRQCTX	=3D BIT(28),
-	IRQD_AFFINITY_ON_ACTIVATE	=3D BIT(29),
-	IRQD_IRQ_ENABLED_ON_SUSPEND	=3D BIT(30),
-	IRQD_RESEND_WHEN_IN_PROGRESS    =3D BIT(31),
+	IRQD_HANDLE_ENFORCE_IRQCTX	=3D BIT(27),
+	IRQD_AFFINITY_ON_ACTIVATE	=3D BIT(28),
+	IRQD_IRQ_ENABLED_ON_SUSPEND	=3D BIT(29),
+	IRQD_RESEND_WHEN_IN_PROGRESS    =3D BIT(30),
 };
=20
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -426,21 +423,6 @@ static inline bool irqd_can_reserve(struct irq_data *d)
 	return __irqd_to_state(d) & IRQD_CAN_RESERVE;
 }
=20
-static inline void irqd_set_msi_nomask_quirk(struct irq_data *d)
-{
-	__irqd_to_state(d) |=3D IRQD_MSI_NOMASK_QUIRK;
-}
-
-static inline void irqd_clr_msi_nomask_quirk(struct irq_data *d)
-{
-	__irqd_to_state(d) &=3D ~IRQD_MSI_NOMASK_QUIRK;
-}
-
-static inline bool irqd_msi_nomask_quirk(struct irq_data *d)
-{
-	return __irqd_to_state(d) & IRQD_MSI_NOMASK_QUIRK;
-}
-
 static inline void irqd_set_affinity_on_activate(struct irq_data *d)
 {
 	__irqd_to_state(d) |=3D IRQD_AFFINITY_ON_ACTIVATE;
diff --git a/include/linux/msi.h b/include/linux/msi.h
index a50ea79522f8..ddace8c34dcf 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -547,12 +547,6 @@ enum {
 	MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS	=3D (1 << 5),
 	/* Free MSI descriptors */
 	MSI_FLAG_FREE_MSI_DESCS		=3D (1 << 6),
-	/*
-	 * Quirk to handle MSI implementations which do not provide
-	 * masking. Currently known to affect x86, but has to be partially
-	 * handled in the core MSI code.
-	 */
-	MSI_FLAG_NOMASK_QUIRK		=3D (1 << 7),
=20
 	/* Mask for the generic functionality */
 	MSI_GENERIC_FLAGS_MASK		=3D GENMASK(15, 0),
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index 5971a66be034..aae0402507ed 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -121,7 +121,6 @@ static const struct irq_bit_descr irqdata_states[] =3D {
 	BIT_MASK_DESCR(IRQD_AFFINITY_ON_ACTIVATE),
 	BIT_MASK_DESCR(IRQD_MANAGED_SHUTDOWN),
 	BIT_MASK_DESCR(IRQD_CAN_RESERVE),
-	BIT_MASK_DESCR(IRQD_MSI_NOMASK_QUIRK),
=20
 	BIT_MASK_DESCR(IRQD_FORWARDED_TO_VCPU),
=20
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index b4c31a5c1147..79b4a58ba9c3 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1204,7 +1204,6 @@ static int msi_handle_pci_fail(struct irq_domain *domai=
n, struct msi_desc *desc,
=20
 #define VIRQ_CAN_RESERVE	0x01
 #define VIRQ_ACTIVATE		0x02
-#define VIRQ_NOMASK_QUIRK	0x04
=20
 static int msi_init_virq(struct irq_domain *domain, int virq, unsigned int v=
flags)
 {
@@ -1213,8 +1212,6 @@ static int msi_init_virq(struct irq_domain *domain, int=
 virq, unsigned int vflag
=20
 	if (!(vflags & VIRQ_CAN_RESERVE)) {
 		irqd_clr_can_reserve(irqd);
-		if (vflags & VIRQ_NOMASK_QUIRK)
-			irqd_set_msi_nomask_quirk(irqd);
=20
 		/*
 		 * If the interrupt is managed but no CPU is available to
@@ -1275,15 +1272,8 @@ static int __msi_domain_alloc_irqs(struct device *dev,=
 struct irq_domain *domain
 	 * Interrupt can use a reserved vector and will not occupy
 	 * a real device vector until the interrupt is requested.
 	 */
-	if (msi_check_reservation_mode(domain, info, dev)) {
+	if (msi_check_reservation_mode(domain, info, dev))
 		vflags |=3D VIRQ_CAN_RESERVE;
-		/*
-		 * MSI affinity setting requires a special quirk (X86) when
-		 * reservation mode is active.
-		 */
-		if (info->flags & MSI_FLAG_NOMASK_QUIRK)
-			vflags |=3D VIRQ_NOMASK_QUIRK;
-	}
=20
 	xa_for_each_range(xa, idx, desc, ctrl->first, ctrl->last) {
 		if (!msi_desc_match(desc, MSI_DESC_NOTASSOCIATED))

