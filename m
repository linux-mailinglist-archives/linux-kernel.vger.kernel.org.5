Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EB675707B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjGQXYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjGQXYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:24:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83227173D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:24:07 -0700 (PDT)
Message-ID: <20230717223225.634205045@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=zCuopdE3RQFCHCsf4zrOItotVQ+TGysIbFJ/I2GYtw8=;
        b=dppNph2lvl/AOCMRGkW5+6iP+zBV6T6fhualr5yM3nTvvGsVHRkvAczwnO5iChrUEZTBLr
        MPzxLG322AeGzqsLHIL4lC77BEWkGJt0evtw7wNvM39/0e9r3ULKKR7Zit9hFaUE1uj8Ys
        D//L5k0w6q8X4zMFjlVdWr8AhneziF8A2VOYgW6vRHH6H3uV6JQDO+1p9kX8jabWS+JGdG
        Q+Sn/dd8s8F4QKFSAZHe7Kf9G4wCTmahDZtMHlQM78GGnRnHIRHj0cfVyEOUlH8kF4WfKi
        YGMkvlg7YcxM9HqhFrXUKnyQZoItU3nMPjRw+jS2TME8KfxqdewJMzSu+ngFNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=zCuopdE3RQFCHCsf4zrOItotVQ+TGysIbFJ/I2GYtw8=;
        b=X3TZmsQ1KOmKrkLjA6RX6lbC27nGCSpGt7+z4PlXHaB7WPz4d7khssHbEuHP3Mrf/F6XmQ
        gx147IAen5VtsuDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 43/58] x86/apic: Prepare x2APIC for using apic::max_apic_id
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:41 +0200 (CEST)
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
 

