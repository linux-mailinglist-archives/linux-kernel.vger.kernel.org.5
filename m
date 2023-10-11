Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9867C47E0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 04:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344849AbjJKCmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 22:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344850AbjJKCmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 22:42:02 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CC1B4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 19:41:57 -0700 (PDT)
X-UUID: 2ae501e020d04e76bce2ac58757c3385-20231011
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:8b65f283-09fc-44ab-a602-1c20f30eed68,IP:20,
        URL:0,TC:0,Content:-25,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,AC
        TION:release,TS:15
X-CID-INFO: VERSION:1.1.32,REQID:8b65f283-09fc-44ab-a602-1c20f30eed68,IP:20,UR
        L:0,TC:0,Content:-25,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:15
X-CID-META: VersionHash:5f78ec9,CLOUDID:59ebc8bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:231011104149YJMBUFJ5,BulkQuantity:0,Recheck:0,SF:19|43|38|23|17|102,
        TC:nil,Content:0,EDM:5,IP:-2,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 2ae501e020d04e76bce2ac58757c3385-20231011
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(119.39.248.66)] by mailgw
        (envelope-from <yaolu@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1348739861; Wed, 11 Oct 2023 10:41:46 +0800
From:   Lu Yao <yaolu@kylinos.cn>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, rdunlap@infradead.org
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org,
        Lu Yao <yaolu@kylinos.cn>
Subject: [PATCH v2] x86/msi: Fix compile error caused by GENERIC_MSI_IRQ and X86_LOCAL_APIC
Date:   Wed, 11 Oct 2023 10:41:43 +0800
Message-Id: <20231011024143.92233-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

  arch/x86/kernel/hpet.c:550:13: error: ‘x86_vector_domain’ undeclared

  arch/x86/kernel/hpet.c:600:9: error: implicit declaration of
    function ‘init_irq_alloc_info’

This is because 'x86_vector_domain' is defined in 'kernel/apic/vector.c'
which is compiled only when 'X86_LOCAL_APIC' is enabled. So use
'X86_LOCAL_APIC' to expose these code rather than 'GENERIC_MSI_IRQ'.

Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
Change from v1:
 * Fix arch/x86/kernel/hpet.c compiled error
Thanks to Randy for the feedback.
v1: https://lore.kernel.org/lkml/20231008082827.279154-1-yaolu@kylinos.cn/

---
 arch/x86/include/asm/hw_irq.h | 6 +++---
 arch/x86/kernel/hpet.c        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 551829884734..b02c3cd3c0f6 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -28,7 +28,7 @@
 #include <asm/irq.h>
 #include <asm/sections.h>
 
-#ifdef	CONFIG_X86_LOCAL_APIC
+#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 struct irq_data;
 struct pci_dev;
 struct msi_desc;
@@ -105,10 +105,10 @@ static inline void irq_complete_move(struct irq_cfg *c) { }
 #endif
 
 extern void apic_ack_edge(struct irq_data *data);
-#else	/*  CONFIG_X86_LOCAL_APIC */
+#else	/*  CONFIG_IRQ_DOMAIN_HIERARCHY */
 static inline void lock_vector_lock(void) {}
 static inline void unlock_vector_lock(void) {}
-#endif	/* CONFIG_X86_LOCAL_APIC */
+#endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 
 /* Statistics */
 extern atomic_t irq_err_count;
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 1648aa0204d9..9904c0d46eba 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -52,7 +52,7 @@ unsigned long				hpet_address;
 u8					hpet_blockid; /* OS timer block num */
 bool					hpet_msi_disable;
 
-#ifdef CONFIG_GENERIC_MSI_IRQ
+#ifdef CONFIG_X86_LOCAL_APIC
 static DEFINE_PER_CPU(struct hpet_channel *, cpu_hpet_channel);
 static struct irq_domain		*hpet_domain;
 #endif
@@ -469,7 +469,7 @@ static void __init hpet_legacy_clockevent_register(struct hpet_channel *hc)
 /*
  * HPET MSI Support
  */
-#ifdef CONFIG_GENERIC_MSI_IRQ
+#ifdef CONFIG_X86_LOCAL_APIC
 static void hpet_msi_unmask(struct irq_data *data)
 {
 	struct hpet_channel *hc = irq_data_get_irq_handler_data(data);
-- 
2.25.1

