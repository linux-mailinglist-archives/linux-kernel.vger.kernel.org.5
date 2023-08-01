Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C5C76B24E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbjHAKuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjHAKtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:49:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293241BC1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:47:53 -0700 (PDT)
Message-ID: <20230801103817.570055901@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=szXoVyIugEhLQoBNKHeoJc9xg6are8RXmgk50QQTfEQ=;
        b=bIBHaPcrmwpbzik4I7YAcB55JTzRt4OeY4DMuTb+rG1cn85y2OIsVJ/3ihFBtyyHIyX94Q
        fd+dbKdrdan30Sw55iXqS7qRUyrPRitGVwzxNfFbbPQ1eewKo9mFlT8RgBkkqb/txRtj77
        lGujMDefaJYV3Pd1uZyRrDBoJ22TMbfDcNZE565md7fkC+cUNqsjubIIDHqoPhIcQpw98T
        /u7/IiGJyL17Mrzwe3+HkPqDV4qpdLflIX4sr63Lo3vrzeC4Ti4xnL6AMeRhtMp2ZLqFT5
        OaTspxgE0GTbFv2jQuFTafyVjHVb84dvqko0hWwWnsp81cPI5L2ilYG4Uli2OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=szXoVyIugEhLQoBNKHeoJc9xg6are8RXmgk50QQTfEQ=;
        b=otAaf0yDhNlcjwStZ9UGk+J/9gP7fhcbfA3ehDFdfE2zW4JZbBNioOgTGxzS0PYxfDCSjP
        +hw05cRjidMCoIAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V3 44/60] x86/apic: Prepare x2APIC for using apic::max_apic_id
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:35 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to remove the apic::apic_id_valid() callback and switch to
checking apic::max_apic_id, it is required to update apic::max_apic_id when
the APIC initialization code overrides it via x2apic_set_max_apicid().

Make the existing booleans a bitfield and add a flag which lets the update
function and the core code which switches the driver detect whether the
apic instance wants to have that update or not and apply it if required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h           |    7 ++++---
 arch/x86/kernel/apic/local.h          |    1 +
 arch/x86/kernel/apic/probe_64.c       |    4 ++++
 arch/x86/kernel/apic/x2apic_cluster.c |    1 +
 arch/x86/kernel/apic/x2apic_phys.c    |    5 ++++-
 5 files changed, 14 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -266,10 +266,11 @@ struct apic {
 	void	(*send_IPI_all)(int vector);
 	void	(*send_IPI_self)(int vector);
 
-	u32	disable_esr;
-
 	enum apic_delivery_modes delivery_mode;
-	bool	dest_mode_logical;
+
+	u32	disable_esr		: 1,
+		dest_mode_logical	: 1,
+		x2apic_set_max_apicid	: 1;
 
 	u32	(*calc_dest_apicid)(unsigned int cpu);
 
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -23,6 +23,7 @@ int x2apic_phys_pkg_id(int initial_apici
 void x2apic_send_IPI_all(int vector);
 void x2apic_send_IPI_allbutself(int vector);
 void x2apic_send_IPI_self(int vector);
+extern u32 x2apic_max_apicid;
 
 /* IPI */
 
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -19,6 +19,10 @@ static __init void apic_install_driver(s
 		return;
 
 	apic = driver;
+
+	if (IS_ENABLED(CONFIG_X86_X2APIC) && apic->x2apic_set_max_apicid)
+		apic->max_apic_id = x2apic_max_apicid;
+
 	pr_info("Switched APIC routing to %s:\n", apic->name);
 }
 
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -240,6 +240,7 @@ static struct apic apic_x2apic_cluster _
 	.phys_pkg_id			= x2apic_phys_pkg_id,
 
 	.max_apic_id			= UINT_MAX,
+	.x2apic_set_max_apicid		= true,
 	.get_apic_id			= x2apic_get_apic_id,
 	.set_apic_id			= x2apic_set_apic_id,
 
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -8,11 +8,13 @@
 int x2apic_phys;
 
 static struct apic apic_x2apic_phys;
-static u32 x2apic_max_apicid __ro_after_init = UINT_MAX;
+u32 x2apic_max_apicid __ro_after_init = UINT_MAX;
 
 void __init x2apic_set_max_apicid(u32 apicid)
 {
 	x2apic_max_apicid = apicid;
+	if (apic->x2apic_set_max_apicid)
+		apic->max_apic_id = apicid;
 }
 
 static int __init set_x2apic_phys_mode(char *arg)
@@ -161,6 +163,7 @@ static struct apic apic_x2apic_phys __ro
 	.phys_pkg_id			= x2apic_phys_pkg_id,
 
 	.max_apic_id			= UINT_MAX,
+	.x2apic_set_max_apicid		= true,
 	.get_apic_id			= x2apic_get_apic_id,
 	.set_apic_id			= x2apic_set_apic_id,
 

