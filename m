Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE8B7BCD36
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 10:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbjJHI2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 04:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbjJHI2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 04:28:45 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55277C5
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 01:28:43 -0700 (PDT)
X-UUID: d81ea7d0ab2e484db2894242fdc67240-20231008
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:bc513836-fd88-4365-9f67-0f81455eb21e,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:0
X-CID-INFO: VERSION:1.1.32,REQID:bc513836-fd88-4365-9f67-0f81455eb21e,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:dea2ce14-4929-4845-9571-38c601e9c3c9,B
        ulkID:2310081553314Y00UXH7,BulkQuantity:1,Recheck:0,SF:17|19|44|38|24|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:41,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: d81ea7d0ab2e484db2894242fdc67240-20231008
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <yaolu@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 515217298; Sun, 08 Oct 2023 16:28:31 +0800
From:   yaolu <yaolu@kylinos.cn>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        yaolu <yaolu@kylinos.cn>
Subject: [PATCH] x86/msi: Fix compile error "incomplete typedef 'msi_alloc_info_t'"
Date:   Sun,  8 Oct 2023 16:28:27 +0800
Message-Id: <20231008082827.279154-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling the x86 kernel, if X86_64 || SMP || X86_32_NON_STANDARD ||
X86_UP_APIC || PCI_MSI is not enabled in '.config' and GENERIC_MSI_IRQ is
selected, the following compilation error will occur:

> include/linux/gpio/driver.h:38:19: error:
>   field 'msiinfo' has incomplete type
> kernel/irq/msi.c:752:5: error: invalid use of incomplete typedef
>   'msi_alloc_info_t' {aka 'struct irq_alloc_info'}
> kernel/irq/msi.c:740:1: error: control reaches end of non-void function

This is because 'X86_LOCAL_APIC' is not defined, but file such as
'kernel/irq/msi.c' only depends on 'GENERIC_MSI_IRQ', and uses
'struct msi_alloc_info_t'. When enable 'GENERIC_MSI_IRQ' will select
'IRQ_DOMAIN_HIERARCHY', so exposing this struct using
'IRQ_DOMAIN_HIERARCHY' rather than 'X86_LOCAL_APIC'.

Signed-off-by: yaolu <yaolu@kylinos.cn>
---
 arch/x86/include/asm/hw_irq.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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
-- 
2.25.1

