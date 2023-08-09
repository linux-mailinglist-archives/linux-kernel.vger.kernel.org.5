Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BCD776826
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjHITMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjHITMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:12:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DF526AF;
        Wed,  9 Aug 2023 12:12:21 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:12:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691608339;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AL5tloo4gcCakXKY0xrTL05hpNQrhljrtfWZbb8Ohaw=;
        b=pjAWnMGmmzIKYDOFXAfOTT0R6KFbeKsHRQv8dGLEqmx45Hx5wUeKuNmu/Bb1UvlD/kdVYZ
        uGYsos75iVwr1AjNiFkMxY/djRpT6oCGPZukqyFJUGPaPthB43arWD43/4hVfVNQjAuBQ4
        mF3NCpfPWfMsv3kErtsBM1HjJEsFY815DpU+3P3ik5wWzOOzwAk7+IyQH2Jto2/ZuNN1bj
        cogeEdAKm1tsRJgo8OfepxOPpcPZeC5xU7W+SXKN+LGBAE6/jmaLhZRfJCZXgsooJHHFrI
        y28q0D98IKrxFO9hxGc9t5YUgdajPiyfN0zlENEbbV8ZqT27oHbEDDIDe+yXDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691608339;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AL5tloo4gcCakXKY0xrTL05hpNQrhljrtfWZbb8Ohaw=;
        b=2MzixbH/R+vaZ03KkecjXHRX9IPUBPj40688lwDXl+yecMWsnOVtCf7G/OrCfgR5qZFRPb
        hH24vnJ49mH4wgBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic/32: Remove bigsmp_cpu_present_to_apicid()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169160833914.27769.16527369886376883585.tip-bot2@tip-bot2>
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

Commit-ID:     4114e1686fdc350e4191ca670710b3fa9bd10947
Gitweb:        https://git.kernel.org/tip/4114e1686fdc350e4191ca670710b3fa9bd10947
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:56 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:25 -07:00

x86/apic/32: Remove bigsmp_cpu_present_to_apicid()

It's a copy of default_cpu_present_to_apicid() with the omission of the
actual check whether the CPU is present.

This APIC callback should die completely, but the XEN APIC implementation
does something different which needs to be addressed first.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/kernel/apic/bigsmp_32.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index a26cb46..aba8ce1 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -43,14 +43,6 @@ static void bigsmp_setup_apic_routing(void)
 		nr_ioapics);
 }
 
-static int bigsmp_cpu_present_to_apicid(int mps_cpu)
-{
-	if (mps_cpu < nr_cpu_ids)
-		return (int) per_cpu(x86_cpu_to_apicid, mps_cpu);
-
-	return BAD_APICID;
-}
-
 static void bigsmp_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retmap)
 {
 	/* For clustered we don't have a good way to do this yet - hack */
@@ -119,7 +111,7 @@ static struct apic apic_bigsmp __ro_after_init = {
 	.init_apic_ldr			= bigsmp_init_apic_ldr,
 	.ioapic_phys_id_map		= bigsmp_ioapic_phys_id_map,
 	.setup_apic_routing		= bigsmp_setup_apic_routing,
-	.cpu_present_to_apicid		= bigsmp_cpu_present_to_apicid,
+	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= physid_set_mask_of_physid,
 	.phys_pkg_id			= bigsmp_phys_pkg_id,
 
