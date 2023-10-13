Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87987C8243
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjJMJiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjJMJiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:38:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEF3CE;
        Fri, 13 Oct 2023 02:38:09 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:38:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697189887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8OpENGFnxAaYj7M8fE6cKf/8eE2Iu8UMtWVNtT2iVz0=;
        b=yoeWq9p2InyIMquxtDF7i8qBK/m0CcHMoZsxmQ6+QMb4fFffshiQWxNyOS6bvxauJZ+uw4
        Ec8uQsLzXoBPqbUYvqSmO0CXrji5wCuVHV6NVIBpHX+k9hkgLYJ4g1e/zwHsz/kzS7FWzg
        AhEEyKIUx9iowJ1msmhVnPEspEUP/xsMNs4E2Skb64Rq5aApJqGbFpo8FeGFzfw4VBNTRN
        iZWu+DX10s40/d77C25wSSJK+fXmEABkTRetBYofjV7TGGtzGLXR3tcP5AdCT6X4C+hwyO
        pVBm74QqK8dCNxOsBV3IVsbFNVaemg18Zb3RIzr3Gi9+HZxdBdJb1irgiH0fyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697189887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8OpENGFnxAaYj7M8fE6cKf/8eE2Iu8UMtWVNtT2iVz0=;
        b=Cxq2aRwKhCEI/Ury96a1CxlDfRvewV0ySg6E0XN4vEZk1OwSNQ4yLXzGui1wW5+NIdHoWt
        2lr1KcTd1gBgulDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/apic: Use BAD_APICID consistently
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814085112.862835121@linutronix.de>
References: <20230814085112.862835121@linutronix.de>
MIME-Version: 1.0
Message-ID: <169718988727.3135.6720592549471092966.tip-bot2@tip-bot2>
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

Commit-ID:     9ff4275bc8fd7bd5ac4677e2724397f8db3209bf
Gitweb:        https://git.kernel.org/tip/9ff4275bc8fd7bd5ac4677e2724397f8db3209bf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Aug 2023 10:18:39 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Oct 2023 14:38:18 +02:00

x86/apic: Use BAD_APICID consistently

APIC ID checks compare with BAD_APICID all over the place, but some
initializers and some code which fiddles with global data structure use
-1[U] instead. That simply cannot work at all.

Fix it up and use BAD_APICID consistently all over the place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230814085112.862835121@linutronix.de

---
 arch/x86/kernel/acpi/boot.c | 2 +-
 arch/x86/kernel/apic/apic.c | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 2a0ea38..f3e4d35 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -856,7 +856,7 @@ int acpi_unmap_cpu(int cpu)
 	set_apicid_to_node(per_cpu(x86_cpu_to_apicid, cpu), NUMA_NO_NODE);
 #endif
 
-	per_cpu(x86_cpu_to_apicid, cpu) = -1;
+	per_cpu(x86_cpu_to_apicid, cpu) = BAD_APICID;
 	set_cpu_present(cpu, false);
 	num_processors--;
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 3cdf484..d2b1d60 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -72,7 +72,7 @@ unsigned int num_processors;
 unsigned disabled_cpus;
 
 /* Processor that is doing the boot up */
-unsigned int boot_cpu_physical_apicid __ro_after_init = -1U;
+unsigned int boot_cpu_physical_apicid __ro_after_init = BAD_APICID;
 EXPORT_SYMBOL_GPL(boot_cpu_physical_apicid);
 
 u8 boot_cpu_apic_version __ro_after_init;
@@ -2318,9 +2318,7 @@ static int nr_logical_cpuids = 1;
 /*
  * Used to store mapping between logical CPU IDs and APIC IDs.
  */
-int cpuid_to_apicid[] = {
-	[0 ... NR_CPUS - 1] = -1,
-};
+int cpuid_to_apicid[] = { [0 ... NR_CPUS - 1] = BAD_APICID, };
 
 bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 {
