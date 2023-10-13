Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B987C823E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjJMJiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjJMJiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:38:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E73C2;
        Fri, 13 Oct 2023 02:38:06 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:38:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697189885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WlULN2FKNj+uBtc62O1xBJqn2scubroxbISi5Ot1+3o=;
        b=AmXvQec0TV6w4xRPeX5UvoNsLP/fUY2qef4prxOObyA8Cbz8vQtjZf6EmFris0Hzfrx8uG
        9u2JItIiPOsN338k/1yOhAEC8OS+WNZm8zayMbE9L7du0IcNeXLcCW86MeLquzU5EQMCqg
        dAGQlQxk9Z89an4gXDD1pFxPXcStJsWPZasfE6JzHRZ3EtzPmXy+X1GZhaHRHn22T0HvN5
        EEui1MI12IGR/XpAXzyOlLbQI1rQI+E79R0urX4VaYC3jy03HGg+w+BkMF+yt2DOu3/K8E
        enXqdm4fTwuB5jeupBpLj40fhwexTmc79AXi6u0C2s9769l/KwOXw2cpagERtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697189885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WlULN2FKNj+uBtc62O1xBJqn2scubroxbISi5Ot1+3o=;
        b=AXlpz1Fd1oj22dxDvsgk8eNbZLmsuKvOcDD+9yk6dA7oYVCWmL/GDNlrRoU3fSQiT7MPdR
        mbKRiGBQiyGcGmCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/apic: Use u32 for [gs]et_apic_id()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814085113.172569282@linutronix.de>
References: <20230814085113.172569282@linutronix.de>
MIME-Version: 1.0
Message-ID: <169718988453.3135.9797978967950225698.tip-bot2@tip-bot2>
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

Commit-ID:     59f7928cd46316371bee71b0cb34e133567e5b35
Gitweb:        https://git.kernel.org/tip/59f7928cd46316371bee71b0cb34e133567e5b35
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Aug 2023 10:18:44 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Oct 2023 14:38:19 +02:00

x86/apic: Use u32 for [gs]et_apic_id()

APIC IDs are used with random data types u16, u32, int, unsigned int,
unsigned long.

Make it all consistently use u32 because that reflects the hardware
register width.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230814085113.172569282@linutronix.de

---
 arch/x86/include/asm/apic.h          | 14 ++------------
 arch/x86/kernel/apic/apic_flat_64.c  |  4 ++--
 arch/x86/kernel/apic/apic_noop.c     |  2 +-
 arch/x86/kernel/apic/apic_numachip.c |  8 ++++----
 arch/x86/kernel/apic/bigsmp_32.c     |  2 +-
 arch/x86/kernel/apic/local.h         |  4 ++--
 arch/x86/kernel/apic/probe_32.c      | 10 ++++++++++
 arch/x86/kernel/apic/x2apic_phys.c   |  4 ++--
 arch/x86/kernel/apic/x2apic_uv_x.c   |  2 +-
 arch/x86/xen/apic.c                  |  4 ++--
 10 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 0788c46..e7b45f2 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -298,8 +298,8 @@ struct apic {
 	u32	(*cpu_present_to_apicid)(int mps_cpu);
 	u32	(*phys_pkg_id)(u32 cpuid_apic, int index_msb);
 
-	u32	(*get_apic_id)(unsigned long x);
-	u32	(*set_apic_id)(unsigned int id);
+	u32	(*get_apic_id)(u32 id);
+	u32	(*set_apic_id)(u32 apicid);
 
 	/* wakeup_secondary_cpu */
 	int	(*wakeup_secondary_cpu)(int apicid, unsigned long start_eip);
@@ -493,16 +493,6 @@ static inline bool lapic_vector_set_in_irr(unsigned int vector)
 	return !!(irr & (1U << (vector % 32)));
 }
 
-static inline unsigned default_get_apic_id(unsigned long x)
-{
-	unsigned int ver = GET_APIC_VERSION(apic_read(APIC_LVR));
-
-	if (APIC_XAPIC(ver) || boot_cpu_has(X86_FEATURE_EXTD_APICID))
-		return (x >> 24) & 0xFF;
-	else
-		return (x >> 24) & 0x0F;
-}
-
 /*
  * Warm reset vector position:
  */
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index ca05aca..37daa3f 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -56,12 +56,12 @@ flat_send_IPI_mask_allbutself(const struct cpumask *cpumask, int vector)
 	_flat_send_IPI_mask(mask, vector);
 }
 
-static unsigned int flat_get_apic_id(unsigned long x)
+static u32 flat_get_apic_id(u32 x)
 {
 	return (x >> 24) & 0xFF;
 }
 
-static u32 set_apic_id(unsigned int id)
+static u32 set_apic_id(u32 id)
 {
 	return (id & 0xFF) << 24;
 }
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index 28ea342..f111486 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -30,7 +30,7 @@ static void noop_apic_icr_write(u32 low, u32 id) { }
 static int noop_wakeup_secondary_cpu(int apicid, unsigned long start_eip) { return -1; }
 static u64 noop_apic_icr_read(void) { return 0; }
 static u32 noop_phys_pkg_id(u32 cpuid_apic, int index_msb) { return 0; }
-static unsigned int noop_get_apic_id(unsigned long x) { return 0; }
+static u32 noop_get_apic_id(u32 apicid) { return 0; }
 static void noop_apic_eoi(void) { }
 
 static u32 noop_apic_read(u32 reg)
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index c35181c..af350b4 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -25,7 +25,7 @@ static const struct apic apic_numachip1;
 static const struct apic apic_numachip2;
 static void (*numachip_apic_icr_write)(int apicid, unsigned int val) __read_mostly;
 
-static unsigned int numachip1_get_apic_id(unsigned long x)
+static u32 numachip1_get_apic_id(u32 x)
 {
 	unsigned long value;
 	unsigned int id = (x >> 24) & 0xff;
@@ -38,12 +38,12 @@ static unsigned int numachip1_get_apic_id(unsigned long x)
 	return id;
 }
 
-static u32 numachip1_set_apic_id(unsigned int id)
+static u32 numachip1_set_apic_id(u32 id)
 {
 	return (id & 0xff) << 24;
 }
 
-static unsigned int numachip2_get_apic_id(unsigned long x)
+static u32 numachip2_get_apic_id(u32 x)
 {
 	u64 mcfg;
 
@@ -51,7 +51,7 @@ static unsigned int numachip2_get_apic_id(unsigned long x)
 	return ((mcfg >> (28 - 8)) & 0xfff00) | (x >> 24);
 }
 
-static u32 numachip2_set_apic_id(unsigned int id)
+static u32 numachip2_set_apic_id(u32 id)
 {
 	return id << 24;
 }
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 3c95e0b..7ee3c48 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -13,7 +13,7 @@
 
 #include "local.h"
 
-static unsigned bigsmp_get_apic_id(unsigned long x)
+static u32 bigsmp_get_apic_id(u32 x)
 {
 	return (x >> 24) & 0xFF;
 }
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index 2bf0d1c..9ea6186 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -15,8 +15,8 @@
 
 /* X2APIC */
 void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
-unsigned int x2apic_get_apic_id(unsigned long id);
-u32 x2apic_set_apic_id(unsigned int id);
+u32 x2apic_get_apic_id(u32 id);
+u32 x2apic_set_apic_id(u32 id);
 u32 x2apic_phys_pkg_id(u32 initial_apicid, int index_msb);
 
 void x2apic_send_IPI_all(int vector);
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 2867fa6..5eb3fbe 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -23,6 +23,16 @@ static u32 default_phys_pkg_id(u32 cpuid_apic, int index_msb)
 	return cpuid_apic >> index_msb;
 }
 
+static u32 default_get_apic_id(u32 x)
+{
+	unsigned int ver = GET_APIC_VERSION(apic_read(APIC_LVR));
+
+	if (APIC_XAPIC(ver) || boot_cpu_has(X86_FEATURE_EXTD_APICID))
+		return (x >> 24) & 0xFF;
+	else
+		return (x >> 24) & 0x0F;
+}
+
 /* should be called last. */
 static int probe_default(void)
 {
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 55cbcec..7c9fe28 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -124,12 +124,12 @@ static int x2apic_phys_probe(void)
 	return apic == &apic_x2apic_phys;
 }
 
-unsigned int x2apic_get_apic_id(unsigned long id)
+u32 x2apic_get_apic_id(u32 id)
 {
 	return id;
 }
 
-u32 x2apic_set_apic_id(unsigned int id)
+u32 x2apic_set_apic_id(u32 id)
 {
 	return id;
 }
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 3589ab6..46d4de2 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -779,7 +779,7 @@ static void uv_send_IPI_all(int vector)
 	uv_send_IPI_mask(cpu_online_mask, vector);
 }
 
-static u32 set_apic_id(unsigned int id)
+static u32 set_apic_id(u32 id)
 {
 	return id;
 }
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index 40538b2..9dd5490 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -33,13 +33,13 @@ static unsigned int xen_io_apic_read(unsigned apic, unsigned reg)
 	return 0xfd;
 }
 
-static u32 xen_set_apic_id(unsigned int x)
+static u32 xen_set_apic_id(u32 x)
 {
 	WARN_ON(1);
 	return x;
 }
 
-static unsigned int xen_get_apic_id(unsigned long x)
+static u32 xen_get_apic_id(u32 x)
 {
 	return ((x)>>24) & 0xFFu;
 }
