Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A628A75F88E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjGXNiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjGXNhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:37:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E154230ED
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:36:13 -0700 (PDT)
Message-ID: <20230724132047.149054128@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=szXoVyIugEhLQoBNKHeoJc9xg6are8RXmgk50QQTfEQ=;
        b=n7uarqd3pMzRqJTlxuF5yXK90hit5XxnQykJs8a24A+nlnoQi0N3gkfVjconnL/Sdu0C2G
        v15Wk4FhYXkJlaKkLMVMV2HK18Do5U6f1D1NjNITNHVAar7gqXfVuOKf2oqGV6g02YScbA
        G4RLlCeJkFQLmGiAgV3fm+MAyImOCOF8bIVtukwhOpSqpTMr1rS+ZPySumefyi9epw9N2i
        eI4XiVO/uvFO4wp4hAq2HcjarF3j0t5ZCGktPg1yWxkMxuHDAJu6vqbetSKdxkByk4gyHp
        2Q8i51LBvU8ARAVrp6gF4JI3wElYrNlCO1G+BO7CevdN7peyy8MSXkOify4zpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=szXoVyIugEhLQoBNKHeoJc9xg6are8RXmgk50QQTfEQ=;
        b=o5eCI97zCcZ87VWWuPVHrr1SAFB0AAZLUdU2CvDZHOj2yu6AOA8CDjKrIPHe0Drvq4kFWY
        QFxKW1meOXIRfkCQ==
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
Subject: [patch V2 43/58] x86/apic: Prepare x2APIC for using apic::max_apic_id
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:34:58 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 

