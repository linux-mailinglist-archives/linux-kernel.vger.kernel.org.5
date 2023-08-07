Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F27D7726C3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjHGNzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbjHGNwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:52:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E13710D9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:52:46 -0700 (PDT)
Message-ID: <20230807135026.802468362@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rdpVDGyxoao4mcEVei61Te5kVt75qdc74++NqQsV064=;
        b=xXRePEYimbFtTcQhqTXK7CmDyZdKWOQrW/h5sONM/hXLov0wCscOlYBnEkAw8OF+XwroDf
        klF+H+9LEF7KgA7AZfnzImbN2ORr7XuAyPHP+k5wl6PtQazASv/VshmfgEhEJfaVNkCzX9
        qGu8lhxcr6QYtL9fmxulrueVRd/o+P2j4XYcuwqkmewf1WM8rqQyk0O8+5yFPJwpFk6k2l
        goPsrNFJp5uSLc4sx/aTi7vbKfCXJe9SYwJR2C6tLurwLpoaAmKH/QzX0SuMXS0dIVSQ50
        kjpCCfby08QzkZG2gbdl4TlokyfPia0v01y0p7wiR9l0of1aeL0TAg1VpN9fxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rdpVDGyxoao4mcEVei61Te5kVt75qdc74++NqQsV064=;
        b=yCxcrsAkpce6Ad8kxZ6KgA87XK0sbKAu/OQlXql/iTebm2gQzovKIarKeK3og6kHb9Zb00
        bSXWBtH0h+GFrHBg==
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
Subject: [patch 07/53] x86/ioapic: Simplify
 setup_ioapic_ids_from_mpc_nocheck()
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:52:44 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to go through APIC callbacks. It's already established that this is
an ancient APIC. So just copy the present mask and use the direct physid*
functions all over the place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/io_apic.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1471,7 +1471,7 @@ static void __init setup_ioapic_ids_from
 	 * This is broken; anything with a real cpu count has to
 	 * circumvent this idiocy regardless.
 	 */
-	apic->ioapic_phys_id_map(&phys_cpu_present_map, &phys_id_present_map);
+	phys_id_present_map = phys_cpu_present_map;
 
 	/*
 	 * Set the IOAPIC ID to the value stored in the MPC table.
@@ -1496,8 +1496,7 @@ static void __init setup_ioapic_ids_from
 		 * system must have a unique ID or we get lots of nice
 		 * 'stuck on smp_invalidate_needed IPI wait' messages.
 		 */
-		if (apic->check_apicid_used(&phys_id_present_map,
-					    mpc_ioapic_id(ioapic_idx))) {
+		if (physid_isset(mpc_ioapic_id(ioapic_idx), phys_id_present_map)) {
 			pr_err("BIOS bug, IO-APIC#%d ID %d is already used!...\n",
 				ioapic_idx, mpc_ioapic_id(ioapic_idx));
 			for (i = 0; i < broadcast_id; i++)

