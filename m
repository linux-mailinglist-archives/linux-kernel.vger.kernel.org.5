Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EB07726A1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjHGNxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbjHGNw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:52:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D6D1BCE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:52:52 -0700 (PDT)
Message-ID: <20230807135027.012341767@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=C8gfQrn6Fv0quhrh8RYsTvXPC0AFtY95rXW+OtM42Wk=;
        b=DKmxB+Z4VxY3hYFXe9mL1sA7++zNl5UOjD8pk9tWSjse4jqL55SsQwtNsk9QHAscdsGB/A
        OPZS0QKCS9AIztKFys5IZEbY4EAEofzGyksYHySiGSFQuf7kHJcd8mCofQujbcIk5QniR9
        /OKT5S72akKKvgdGUC7F6WXg0e1RsSBHRXE/N88fvGQxURY8L3845r1QOmJYvoJeKu+GTw
        QYkSyCt0A2XYl4cBOM/AHyukjw5zm5LoYwUFdFMiU7xdghxaYX22K49cUJl6khFyn9oxgt
        ZzaKMnH/b8fRQSlFR/xOqjdEJcCf9hGgbnvGmdbADZz3gsNfmMwUIllGLhGkNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=C8gfQrn6Fv0quhrh8RYsTvXPC0AFtY95rXW+OtM42Wk=;
        b=nwkebDq1IoFYG9EoDAFOF+lAlqAORa2af+/vjE/NHeusFrzxdp9TBeeU+AFC9IzAEougkN
        fwPDyaWA83oIHYDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: [patch 11/53] x86/mpparse: Prepare for callback separation
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:52:50 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of splitting the get_smp_config() callback, rename
default_get_smp_config() to mpparse_get_smp_config() and provide an early
and late wrapper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/mpspec.h |   12 ++++++++----
 arch/x86/kernel/mpparse.c     |   12 +++++++++++-
 arch/x86/kernel/x86_init.c    |    2 +-
 3 files changed, 20 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -60,12 +60,16 @@ static inline void early_get_smp_config(
 extern void e820__memblock_alloc_reserved_mpc_new(void);
 extern int enable_update_mptable;
 extern void mpparse_find_mptable(void);
-extern void default_get_smp_config(unsigned int early);
+extern void mpparse_parse_early_smp_config(void);
+extern void mpparse_parse_smp_config(void);
+extern void mpparse_get_smp_config(unsigned int early);
 #else
 static inline void e820__memblock_alloc_reserved_mpc_new(void) { }
-#define enable_update_mptable	(0)
-#define mpparse_find_mptable	x86_init_noop
-#define default_get_smp_config	x86_init_uint_noop
+#define enable_update_mptable		(0)
+#define mpparse_find_mptable		x86_init_noop
+#define mpparse_parse_early_smp_config	x86_init_noop
+#define mpparse_parse_smp_config	x86_init_noop
+#define mpparse_get_smp_config		x86_init_uint_noop
 #endif
 
 int generic_processor_info(int apicid);
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -476,7 +476,7 @@ static int __init check_physptr(struct m
 /*
  * Scan the memory blocks for an SMP configuration block.
  */
-void __init default_get_smp_config(unsigned int early)
+void __init mpparse_get_smp_config(unsigned int early)
 {
 	struct mpf_intel *mpf;
 
@@ -541,6 +541,16 @@ void __init default_get_smp_config(unsig
 	early_memunmap(mpf, sizeof(*mpf));
 }
 
+void __init mpparse_parse_early_smp_config(void)
+{
+	mpparse_get_smp_config(true);
+}
+
+void __init mpparse_parse_smp_config(void)
+{
+	mpparse_get_smp_config(false);
+}
+
 static void __init smp_reserve_memory(struct mpf_intel *mpf)
 {
 	memblock_reserve(mpf->physptr, get_mpc_size(mpf->physptr));
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -71,7 +71,7 @@ struct x86_init_ops x86_init __initdata
 	.mpparse = {
 		.setup_ioapic_ids	= x86_init_noop,
 		.find_mptable		= mpparse_find_mptable,
-		.get_smp_config		= default_get_smp_config,
+		.get_smp_config		= mpparse_get_smp_config,
 	},
 
 	.irqs = {

