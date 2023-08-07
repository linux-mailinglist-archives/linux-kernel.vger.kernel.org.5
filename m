Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E500E77269D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbjHGNxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbjHGNwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:52:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C72510D5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:52:41 -0700 (PDT)
Message-ID: <20230807135026.636507272@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yzPalGwgNV+hv5fraMZh8WMCr4ypmAb2ZvNhqZKp6/4=;
        b=TCV6O+CG00GeXn+a1he4JPWxkG57mzG3b1yu3o/ohWynYnglIUDivLSqz9WmUsMXKUHMrB
        CWt2yeHBl3HF+uMq0c60c0aI4T7offUADhMCkvapN2UfTyihOfnn7yAEJJVU3xFTBL3jae
        rhp/mB5x65k9DIj8DfGmEd2PdDnUAZocOlRUpNtiwc2rxTWse00G2ZVdk5f27rPwDAI7lK
        A+fxMR1kRotwQpAUBmlQ6tyve4uJ9W8gJ336+3dJZ/YsLxYoknlotL6apqLyszTRx/A5JV
        kDBIx3o0NoBa5AO7kYMPyLMaOQU8LPQVzaHSsD7sDpCV7hR6pcvfZ5P0ZJHv+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yzPalGwgNV+hv5fraMZh8WMCr4ypmAb2ZvNhqZKp6/4=;
        b=latYlXwaRgAi9FG6M3RL/5Pcp7XFqm5yOyA+yuH/0icD1crJzcUieocZ7hOuQprjxkMS2m
        CFFI7U91d3ycnSCw==
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
Subject: [patch 04/53] x86/ioapic: Replace some more set bit nonsense
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:52:39 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yet another set_bit() operation wrapped in oring a mask.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/mpspec.h  |    3 ---
 arch/x86/kernel/apic/io_apic.c |    6 ++----
 2 files changed, 2 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -86,9 +86,6 @@ typedef struct physid_mask physid_mask_t
 #define physid_set(physid, map)			set_bit(physid, (map).mask)
 #define physid_isset(physid, map)		test_bit(physid, (map).mask)
 
-#define physids_or(dst, src1, src2)					\
-	bitmap_or((dst).mask, (src1).mask, (src2).mask, MAX_LOCAL_APIC)
-
 #define physids_clear(map)					\
 	bitmap_zero((map).mask, MAX_LOCAL_APIC)
 
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2494,9 +2494,8 @@ unsigned int arch_dynirq_lower_bound(uns
 #ifdef CONFIG_X86_32
 static int io_apic_get_unique_id(int ioapic, int apic_id)
 {
-	union IO_APIC_reg_00 reg_00;
 	static physid_mask_t apic_id_map = PHYSID_MASK_NONE;
-	physid_mask_t tmp;
+	union IO_APIC_reg_00 reg_00;
 	unsigned long flags;
 	int i = 0;
 
@@ -2542,8 +2541,7 @@ static int io_apic_get_unique_id(int ioa
 		apic_id = i;
 	}
 
-	physid_set_mask_of_physid(apic_id, &tmp);
-	physids_or(apic_id_map, apic_id_map, tmp);
+	physid_set(apic_id, apic_id_map);
 
 	if (reg_00.bits.ID != apic_id) {
 		reg_00.bits.ID = apic_id;

