Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E7777B4CD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjHNIzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbjHNIyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:54:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6E691
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:54:05 -0700 (PDT)
Message-ID: <20230814085113.172569282@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692003244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=gW9alEQWPEWU1DZHmBBF2GJvXtvud6blUQ7THdfyYng=;
        b=ht9fRZC+V2h5fFPk4KD1nYyRtYl7ZJqyKJiuX0fbYlXyZ2QhyKTjfA31+qm9GVIsWREB67
        3dJ7lHZuKYkzdosvzHG/FuXkq8xKcagSa5POPqZObeX+EGDSoL6P4qAuio2W4FtZLvXr+P
        JKwrmJYs2DadR84/+RUzws/kmGLZu8+I84FVHj1DqXoek9Z9gJocHRYZWUu9qbgpXQ+DR7
        MoMHWixtfra2VrpGWtHRVD+GpBdE4I7g8nvhtSgVPY7BLEV8jb0qXn1bnsgtbnt7a3ZJMl
        4zuFOmPZCwE11v+vw9oK72M33xzKKmEokuFbAVL5yLAU2Kig5NrifIh69rkC7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692003244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=gW9alEQWPEWU1DZHmBBF2GJvXtvud6blUQ7THdfyYng=;
        b=E8Ss5s41dy1YMQTZ1esgpzyVQDRZ+ntvpGoDy49OI7+i3oznUIHKCoYn+7GU08hbOzXhWg
        XwSsVuMSZOBqobCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: [patch V4 19/41] x86/apic: Use u32 for [gs]et_apic_id()
References: <20230814085006.593997112@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Aug 2023 10:54:03 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

APIC IDs are used with random data types u16, u32, int, unsigned int,
unsigned long.

Make it all consistently use u32 because that reflects the hardware
register width.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>

---
 arch/x86/include/asm/apic.h          |   14 ++------------
 arch/x86/kernel/apic/apic_flat_64.c  |    4 ++--
 arch/x86/kernel/apic/apic_noop.c     |    2 +-
 arch/x86/kernel/apic/apic_numachip.c |    8 ++++----
 arch/x86/kernel/apic/bigsmp_32.c     |    2 +-
 arch/x86/kernel/apic/local.h         |    4 ++--
 arch/x86/kernel/apic/probe_32.c      |   10 ++++++++++
 arch/x86/kernel/apic/x2apic_phys.c   |    4 ++--
 arch/x86/kernel/apic/x2apic_uv_x.c   |    2 +-
 arch/x86/xen/apic.c                  |    4 ++--
 10 files changed, 27 insertions(+), 27 deletions(-)

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
@@ -493,16 +493,6 @@ static inline bool lapic_vector_set_in_i
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
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -56,12 +56,12 @@ flat_send_IPI_mask_allbutself(const stru
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
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -30,7 +30,7 @@ static void noop_apic_icr_write(u32 low,
 static int noop_wakeup_secondary_cpu(int apicid, unsigned long start_eip) { return -1; }
 static u64 noop_apic_icr_read(void) { return 0; }
 static u32 noop_phys_pkg_id(u32 cpuid_apic, int index_msb) { return 0; }
-static unsigned int noop_get_apic_id(unsigned long x) { return 0; }
+static u32 noop_get_apic_id(u32 apicid) { return 0; }
 static void noop_apic_eoi(void) { }
 
 static u32 noop_apic_read(u32 reg)
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
@@ -38,12 +38,12 @@ static unsigned int numachip1_get_apic_i
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
 
@@ -51,7 +51,7 @@ static unsigned int numachip2_get_apic_i
 	return ((mcfg >> (28 - 8)) & 0xfff00) | (x >> 24);
 }
 
-static u32 numachip2_set_apic_id(unsigned int id)
+static u32 numachip2_set_apic_id(u32 id)
 {
 	return id << 24;
 }
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -13,7 +13,7 @@
 
 #include "local.h"
 
-static unsigned bigsmp_get_apic_id(unsigned long x)
+static u32 bigsmp_get_apic_id(u32 x)
 {
 	return (x >> 24) & 0xFF;
 }
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
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -23,6 +23,16 @@ static u32 default_phys_pkg_id(u32 cpuid
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
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -780,7 +780,7 @@ static void uv_send_IPI_all(int vector)
 	uv_send_IPI_mask(cpu_online_mask, vector);
 }
 
-static u32 set_apic_id(unsigned int id)
+static u32 set_apic_id(u32 id)
 {
 	return id;
 }
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -33,13 +33,13 @@ static unsigned int xen_io_apic_read(uns
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



