Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA81C7726A3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbjHGNxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbjHGNxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A60171A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:52:57 -0700 (PDT)
Message-ID: <20230807135027.168401504@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=LqyaDmi+Gzh0+dg6bnechLN5ICIJ4S0eJD1WXG6PgLM=;
        b=GNy0Ydiq3sdy/foH0ArUiskmpLF/oKnYPbtHG+9+/Al41Y2Ye6TOp+Seo0bkw+xouZIKDk
        LVDyvejIilLdHJpXRZ2idjyIXE20qIkcTmnkMpqAQrTNt5u45KQs2a28dxXD8sQN5nIVls
        djZFQo50WTfuWZriboleD4vQKJdlAoCdUrwMGbuOijP6QkMjt7N4CrXXgVw7DAEbxR31Wa
        7x6VOU9zNFkA3nHwR0ehFPtmhxFxdKn/GG0WUU3aD5p8iN1qEzhmaQQsACRyCpZvfL/cfJ
        mV5hC6Lo5FmV9Ug17ksKV6oDMAh6747L9b5Qb6jZzeErv/o3EsJoeKXYPZlyzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=LqyaDmi+Gzh0+dg6bnechLN5ICIJ4S0eJD1WXG6PgLM=;
        b=mHwX04tEOT5rzbHO/pqepUuHDb34gOFsTX7dtlE6XL6/aEaZnDWUR7FIPnGZPYy5dih7Gz
        JN/UkYlr06kT/OAw==
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
Subject: [patch 14/53] x86/platform/intel-mid: Prepare for separate mpparse
 callbacks
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:52:55 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the split SMP configuration callbacks with NOOPs as MID is
strictly ACPI only.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/platform/intel-mid/intel-mid.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -118,7 +118,9 @@ void __init x86_intel_mid_early_setup(vo
 	machine_ops.emergency_restart  = intel_mid_reboot;
 
 	/* Avoid searching for BIOS MP tables */
-	x86_init.mpparse.find_mptable = x86_init_noop;
-	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
+	x86_init.mpparse.find_mptable		= x86_init_noop;
+	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
+	x86_init.mpparse.parse_smp_cfg		= x86_init_noop;
+	x86_init.mpparse.get_smp_config		= x86_init_uint_noop;
 	set_bit(MP_BUS_ISA, mp_bus_not_pci);
 }

