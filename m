Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13AF7C658C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377564AbjJLG00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbjJLG0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:26:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73623101;
        Wed, 11 Oct 2023 23:25:37 -0700 (PDT)
Date:   Thu, 12 Oct 2023 06:25:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697091935;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5DIwPHfjDKni4ULexliWOMEADdnbFFYA528qpHWmc1U=;
        b=0uxylyqQ0pX4K9PljaQwLuBstfxCLZMXfmI9XIYw195vNTFg3SkG8IUV/y5vKP0G+yzqHL
        1h5OZy5FFI0t1v+xVNrlSzrsRRx7xPlCw9cUXI/dVgoiFJiclh7zGdvTM/NXVqxqZAfAK/
        wN4PtBNZ+G+7oUZcItyDc2g1O2CBdfu6JFBjjUDoJiIa/fRa4Tk2/eHABVbjUEuXpfVHzJ
        AY0gUw878ZECRHMLqL1pqTo2ScDio9lc8klSbLqrOC+v3NF+NZyyWTGxbDHGGuhyqNBj5p
        2f+L5JZ9AW4f7/Ph6O3VHCIK/T2lM3AOQmtTd3Thzn5IgeJiw+mqP9c4fRC0Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697091935;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5DIwPHfjDKni4ULexliWOMEADdnbFFYA528qpHWmc1U=;
        b=Rx/39lipNDxxNymOslNgiQCbJEQOem7AeQa7ZNENUAA9OXQ0bSquN5en/9GTuE6VlXcyyY
        22kHYyNyxfN4jnAQ==
From:   "tip-bot2 for Lu Yao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/msi: Fix compile error caused by
 CONFIG_GENERIC_MSI_IRQ=y && !CONFIG_X86_LOCAL_APIC
Cc:     kernel test robot <lkp@intel.com>, Lu Yao <yaolu@kylinos.cn>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231012032659.323251-1-yaolu@kylinos.cn>
References: <20231012032659.323251-1-yaolu@kylinos.cn>
MIME-Version: 1.0
Message-ID: <169709193403.3135.8043258061582152833.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     441ccc351256533b6381e86a5648dbfe04b74286
Gitweb:        https://git.kernel.org/tip/441ccc351256533b6381e86a5648dbfe04b=
74286
Author:        Lu Yao <yaolu@kylinos.cn>
AuthorDate:    Thu, 12 Oct 2023 11:26:59 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 12 Oct 2023 08:13:27 +02:00

x86/msi: Fix compile error caused by CONFIG_GENERIC_MSI_IRQ=3Dy && !CONFIG_X8=
6_LOCAL_APIC

When compiling the x86 kernel, if X86_LOCAL_APIC is not enabled but
GENERIC_MSI_IRQ is selected in '.config', the following compilation
error will occur:

  include/linux/gpio/driver.h:38:19: error:
    field 'msiinfo' has incomplete type

  kernel/irq/msi.c:752:5: error: invalid use of incomplete typedef
    'msi_alloc_info_t' {aka 'struct irq_alloc_info'}

  kernel/irq/msi.c:740:1: error: control reaches end of non-void function

This is because file such as 'kernel/irq/msi.c' only depends on
'GENERIC_MSI_IRQ', and uses 'struct msi_alloc_info_t'. However,
this struct depends on 'X86_LOCAL_APIC'.

When enable 'GENERIC_MSI_IRQ' or 'X86_LOCAL_APIC' will select
'IRQ_DOMAIN_HIERARCHY', so exposing this struct using
'IRQ_DOMAIN_HIERARCHY' rather than 'X86_LOCAL_APIC'.

Under the above conditions, if 'HPET_TIMER' is selected, the following
compilation error will occur:

  arch/x86/kernel/hpet.c:550:13: error: =E2=80=98x86_vector_domain=E2=80=99 u=
ndeclared

  arch/x86/kernel/hpet.c:600:9: error: implicit declaration of
    function =E2=80=98init_irq_alloc_info=E2=80=99

This is because 'x86_vector_domain' is defined in 'kernel/apic/vector.c'
which is compiled only when 'X86_LOCAL_APIC' is enabled. Besides,
function 'msi_domain_set_affinity' is defined in 'include/linux/msi.h'
which depends on 'GENERIC_MSI_IRQ'. So use 'X86_LOCAL_APIC' and
'GENERIC_MSI_IRQ' to expose these code.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lu Yao <yaolu@kylinos.cn>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231012032659.323251-1-yaolu@kylinos.cn
---
 arch/x86/include/asm/hw_irq.h | 6 +++---
 arch/x86/kernel/hpet.c        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 5518298..b02c3cd 100644
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
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 1648aa0..41eecf1 100644
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
