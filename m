Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A137776A50
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjHIUgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbjHIUgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA592136;
        Wed,  9 Aug 2023 13:36:13 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XTU/qg25v4UlhYph41w3e0dHIdISUNjuxEGCpq96sM0=;
        b=d1WouCEY0ugqmsbK4LYXtWCHtesDKHLkKaN4udzXrXBcawXdQrWeuS9c6tU5AoNfqFKMsx
        2DBZiaRmMRhyygXabzqoyCspoC7/dvNg49PH8h5w3j2w9sQPyRCsRrS0RPR2PCEVAR7whl
        ToX/aByGI+orie0RMHPCYFFPXW4y761ATal9MYIvvyPvvFAq/taBVnmVY4oT9jgMC/IHY8
        E04nakd53OiBSTdMNMWvmy/BGcMxiMXi15HQt1u4kT1DI4d3Pl85UUDoyvYscpQRbi6zMy
        FsGXGQYR8/I+QKKAP6leLKFSIQg8jUK/pwyzZsbZi0l7Jc8n0z2xzS8MDBToPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XTU/qg25v4UlhYph41w3e0dHIdISUNjuxEGCpq96sM0=;
        b=ApqivpTtRDkhZSH1j5hEZEzlrILf8BXcve+3Jdjwh5vaQA6NpH4kmYkdSv9h7y0Fgjb99j
        OsHlENuQPQkG3pAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Prepare x2APIC for using apic::max_apic_id
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161337138.27769.11944204974937541880.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     b5a5ce58d3d22ce560305ef9c70a2ec21fb887ba
Gitweb:        https://git.kernel.org/tip/b5a5ce58d3d22ce560305ef9c70a2ec21fb887ba
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:11 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:31 -07:00

x86/apic: Prepare x2APIC for using apic::max_apic_id

In order to remove the apic::apic_id_valid() callback and switch to
checking apic::max_apic_id, it is required to update apic::max_apic_id when
the APIC initialization code overrides it via x2apic_set_max_apicid().

Make the existing booleans a bitfield and add a flag which lets the update
function and the core code which switches the driver detect whether the
apic instance wants to have that update or not and apply it if required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/include/asm/apic.h           | 7 ++++---
 arch/x86/kernel/apic/local.h          | 1 +
 arch/x86/kernel/apic/probe_64.c       | 4 ++++
 arch/x86/kernel/apic/x2apic_cluster.c | 1 +
 arch/x86/kernel/apic/x2apic_phys.c    | 5 ++++-
 5 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 42d3240..2e79c13 100644
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
 
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index a250675..e576b3a 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -23,6 +23,7 @@ int x2apic_phys_pkg_id(int initial_apicid, int index_msb);
 void x2apic_send_IPI_all(int vector);
 void x2apic_send_IPI_allbutself(int vector);
 void x2apic_send_IPI_self(int vector);
+extern u32 x2apic_max_apicid;
 
 /* IPI */
 
diff --git a/arch/x86/kernel/apic/probe_64.c b/arch/x86/kernel/apic/probe_64.c
index a82bb52..a12a379 100644
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -19,6 +19,10 @@ static __init void apic_install_driver(struct apic *driver)
 		return;
 
 	apic = driver;
+
+	if (IS_ENABLED(CONFIG_X86_X2APIC) && apic->x2apic_set_max_apicid)
+		apic->max_apic_id = x2apic_max_apicid;
+
 	pr_info("Switched APIC routing to %s:\n", apic->name);
 }
 
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index 036dd1c..a164764 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -240,6 +240,7 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 	.phys_pkg_id			= x2apic_phys_pkg_id,
 
 	.max_apic_id			= UINT_MAX,
+	.x2apic_set_max_apicid		= true,
 	.get_apic_id			= x2apic_get_apic_id,
 	.set_apic_id			= x2apic_set_apic_id,
 
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index d292ec3..3aabfd3 100644
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
@@ -161,6 +163,7 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 	.phys_pkg_id			= x2apic_phys_pkg_id,
 
 	.max_apic_id			= UINT_MAX,
+	.x2apic_set_max_apicid		= true,
 	.get_apic_id			= x2apic_get_apic_id,
 	.set_apic_id			= x2apic_set_apic_id,
 
