Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F1B7C8249
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjJMJio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjJMJiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:38:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5525CC0;
        Fri, 13 Oct 2023 02:38:11 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:38:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697189890;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kqf/BoUJZcJ2Xcq4Hb3P58umHenSlBTPeLgsifWCH0k=;
        b=GMIl3yCs81eubRDr7siFSyGE1I0vg7D6d9IAsUW541bytt3sK4jabiYIDNhHeltkSZz0Kj
        J+yPUP2kyMBrJrq3cLPrcyPMxD3zCjI2S7yjp8IE1/GDpKlL4CizzlttdW2k0xkWIzu7b6
        JZ/5AA7DxuOGQkKvNzdZvXy8QjqEtjvBYedj3tbOMS+16k/ygREXIO9m/lwSyNHOcIXsfy
        /aNDhbU42RFKkF1oZzA4IhfMhz2P640Ag+Uvw8bbgF2Myfe2f91gkFxd4X2NTLPGvSNWo4
        I71KfrKc5H5z9pWCf6bpo7ZEgq1c1DJnFYPA1MwugQoRucQoTvpiRZxoEKj6xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697189890;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kqf/BoUJZcJ2Xcq4Hb3P58umHenSlBTPeLgsifWCH0k=;
        b=jpNnYOz2FhkaKmJJoJwNE0vLKwUNOrMyFh4W0RKHhVIH5uXI0qUG6yT09qJSwGrNoU244l
        Ijk9whjMWbKyZEBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpu: Move cu_id into topology info
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814085112.628405546@linutronix.de>
References: <20230814085112.628405546@linutronix.de>
MIME-Version: 1.0
Message-ID: <169718988942.3135.7810611573349152830.tip-bot2@tip-bot2>
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

Commit-ID:     e3c0c5d52ad34ab2c97f93ca4a0c2e9ca2fdc06b
Gitweb:        https://git.kernel.org/tip/e3c0c5d52ad34ab2c97f93ca4a0c2e9ca2fdc06b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Aug 2023 10:18:35 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Oct 2023 14:38:18 +02:00

x86/cpu: Move cu_id into topology info

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230814085112.628405546@linutronix.de

---
 arch/x86/include/asm/processor.h | 4 +++-
 arch/x86/kernel/cpu/amd.c        | 2 +-
 arch/x86/kernel/cpu/common.c     | 2 +-
 arch/x86/kernel/smpboot.c        | 6 +++---
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a637602..517d0bc 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -90,6 +90,9 @@ struct cpuinfo_topology {
 	// Physical die ID on AMD, Relative on Intel
 	u32			die_id;
 
+	// Compute unit ID - AMD specific
+	u32			cu_id;
+
 	// Core ID relative to the package
 	u32			core_id;
 };
@@ -110,7 +113,6 @@ struct cpuinfo_x86 {
 	__u8			x86_phys_bits;
 	/* CPUID returned core id bits: */
 	__u8			x86_coreid_bits;
-	__u8			cu_id;
 	/* Max extended CPUID function supported: */
 	__u32			extended_cpuid_level;
 	/* Maximum supported CPUID level, -1=no CPUID: */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 66bb929..a744d8d 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -413,7 +413,7 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 		c->topo.die_id  = ecx & 0xff;
 
 		if (c->x86 == 0x15)
-			c->cu_id = ebx & 0xff;
+			c->topo.cu_id = ebx & 0xff;
 
 		if (c->x86 >= 0x17) {
 			c->topo.core_id = ebx & 0xff;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 4147665..106b27f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1829,7 +1829,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	c->x86_model_id[0] = '\0';  /* Unset */
 	c->x86_max_cores = 1;
 	c->x86_coreid_bits = 0;
-	c->cu_id = 0xff;
+	c->topo.cu_id = 0xff;
 #ifdef CONFIG_X86_64
 	c->x86_clflush_size = 64;
 	c->x86_phys_bits = 36;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 7ab9224..17b86f4 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -482,9 +482,9 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 			if (c->topo.core_id == o->topo.core_id)
 				return topology_sane(c, o, "smt");
 
-			if ((c->cu_id != 0xff) &&
-			    (o->cu_id != 0xff) &&
-			    (c->cu_id == o->cu_id))
+			if ((c->topo.cu_id != 0xff) &&
+			    (o->topo.cu_id != 0xff) &&
+			    (c->topo.cu_id == o->topo.cu_id))
 				return topology_sane(c, o, "smt");
 		}
 
