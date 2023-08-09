Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5541E776A47
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbjHIUgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbjHIUgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF13213B;
        Wed,  9 Aug 2023 13:36:13 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gbfovm7t+L/Eo0VwcoT9iGKKbR3xdHooKhE+maHJWao=;
        b=iWhCeyZNZWwRkzMJR10TA8uwEcgO9IdC89rz11tYkD16+VPPvTBCWe5DAYXdQOBsjcII47
        ngCQ9xwnWdPi+5bdyNU6IhdTNrrJWlXJqvzNeVySLtnU9t/hf63eVB/mwCEGTqEFLpkRkR
        /frjt5dwGMAMC+Xuz8so/K1m+fdKZ7n4x09Q3tItq9B4mYwCzP1onS2fBvvPMJTF7umxSQ
        n/zbMFWDmSiQ8B1yoGwuIQOA3HTmsFAgYCwcyfiK1LIpNUku5OUaV/sreiZwaGBxLZErjE
        2FVqucWQFg97q8J39Xxzvj8EZqv8wvHDKJfF/qTySJJiMYdMHrnkDPpC+7wyZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gbfovm7t+L/Eo0VwcoT9iGKKbR3xdHooKhE+maHJWao=;
        b=dCaqSWGBplYzOaShK4erUkSwBKCEkdIjNS9pxXtf65GGWwe6/FOnEqyeQHfPZJik1sYIbu
        exCo5qZJ9DFkVBAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Simplify X2APIC ID validation
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161337185.27769.2452854020127752295.tip-bot2@tip-bot2>
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

Commit-ID:     a9d608c22aeecaa6cd34717a8576318ae2295379
Gitweb:        https://git.kernel.org/tip/a9d608c22aeecaa6cd34717a8576318ae2295379
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:10 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:31 -07:00

x86/apic: Simplify X2APIC ID validation

Currently, x2apic_max_apicid==0 means that there is no max APIC id limit.
But, this means that 0 needs to be special-cased.

Designate UINT_MAX to mean unlimited so that a plain old less than or equal
compare works and there is no special-casing.  Replace the 0 initialization
with UINT_MAX.

[ dhansen: muck with changelog ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/kernel/apic/x2apic_phys.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index d6495ac..d292ec3 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -8,7 +8,7 @@
 int x2apic_phys;
 
 static struct apic apic_x2apic_phys;
-static u32 x2apic_max_apicid __ro_after_init;
+static u32 x2apic_max_apicid __ro_after_init = UINT_MAX;
 
 void __init x2apic_set_max_apicid(u32 apicid)
 {
@@ -125,10 +125,7 @@ static int x2apic_phys_probe(void)
 /* Common x2apic functions, also used by x2apic_cluster */
 int x2apic_apic_id_valid(u32 apicid)
 {
-	if (x2apic_max_apicid && apicid > x2apic_max_apicid)
-		return 0;
-
-	return 1;
+	return apicid <= x2apic_max_apicid;
 }
 
 unsigned int x2apic_get_apic_id(unsigned long id)
