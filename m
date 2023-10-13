Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C069A7C8322
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjJMKcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjJMKcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:32:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5377C0;
        Fri, 13 Oct 2023 03:32:18 -0700 (PDT)
Date:   Fri, 13 Oct 2023 10:32:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697193137;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8GqFWLwKpBTs9NmQk+Iig1hSCyVU4NpiAHXus0C4MYY=;
        b=C9xkqxnkOPfo8XMwxlWuc1XAQDG9/H4lYI2e5ErusY6y4gw2296g/tqhdhYn2m2USH977n
        UhDoFRgKS9vVFOH1fkMxsaaMuzQ5D3zTARNKBkUB8MUHZpweINzxZa3hOu4I5loA7mUKC7
        kwQLs4fd44ih3kaFAp37VuDhpDpaKsco9hnb40N6fp3HjOp53TgafstJIQOanpTcd3ZUZU
        Cas6JOCsAPDE7SLIOuf9ZQsg0SwjU6NALFUUZ7iZ/pFsQp8ut7Wm1IFwER30qvOuhKDl/j
        rZkTor6Vt3UWRbBApwX+kNSNoKzjJ+cg2Ig0p120BvV4PymRLPQm3Ew+ZUSAdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697193137;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8GqFWLwKpBTs9NmQk+Iig1hSCyVU4NpiAHXus0C4MYY=;
        b=iZRw9O5fftztFdFP0XV6JtFZcbG7KQ+5+50BZC69hgsZkzJTQOH+rqKFPgEynIIZarPHTW
        Bw8xuy47xSd18kAQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/apic, x86/hyperv: Use u32 in hv_snp_boot_ap() too
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814085113.233274223@linutronix.de>
References: <20230814085113.233274223@linutronix.de>
MIME-Version: 1.0
Message-ID: <169719313683.3135.11702474908875768918.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     92fe9bb77b0c9fade150350fdb0629a662f0923f
Gitweb:        https://git.kernel.org/tip/92fe9bb77b0c9fade150350fdb0629a662f0923f
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 13 Oct 2023 12:14:27 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Oct 2023 12:26:58 +02:00

x86/apic, x86/hyperv: Use u32 in hv_snp_boot_ap() too

The data type for APIC IDs was standardized to 'u32' in the
following recent commit:

   db4a4086a223 ("x86/apic: Use u32 for wakeup_secondary_cpu[_64]()")

Which changed the function arguments type signature of the
apic->wakeup_secondary_cpu() APIC driver function.

Propagate this to hv_snp_boot_ap() as well, which also addresses a
'assignment from incompatible pointer type' build warning that triggers
under the -Werror=incompatible-pointer-types GCC warning.

Fixes: db4a4086a223 ("x86/apic: Use u32 for wakeup_secondary_cpu[_64]()")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230814085113.233274223@linutronix.de
---
 arch/x86/hyperv/ivm.c           | 2 +-
 arch/x86/include/asm/mshyperv.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 8c6bf07..c6edde1 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -288,7 +288,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
 		free_page((unsigned long)vmsa);
 }
 
-int hv_snp_boot_ap(int cpu, unsigned long start_ip)
+int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
 {
 	struct sev_es_save_area *vmsa = (struct sev_es_save_area *)
 		__get_free_page(GFP_KERNEL | __GFP_ZERO);
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 033b53f..a9630e9 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -276,11 +276,11 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 bool hv_ghcb_negotiate_protocol(void);
 void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
-int hv_snp_boot_ap(int cpu, unsigned long start_ip);
+int hv_snp_boot_ap(u32 cpu, unsigned long start_ip);
 #else
 static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
 static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
-static inline int hv_snp_boot_ap(int cpu, unsigned long start_ip) { return 0; }
+static inline int hv_snp_boot_ap(u32 cpu, unsigned long start_ip) { return 0; }
 #endif
 
 #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
