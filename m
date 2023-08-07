Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C447726A4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbjHGNxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbjHGNxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B51171E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:52:55 -0700 (PDT)
Message-ID: <20230807135027.116024518@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=VT3e6NN7PgE82Og+WaclHeJcI+6c5zm7tVy4Rda9bOc=;
        b=nAPyiYOpE3R7FVPD7whSXhVfyWwIyd3HSmO7TchobLaeuBZCnG+k1AguAZRgCms1/gUX1R
        p7tjfuZrDYwdQodpFLBUB/1Th7SwQg52n2RnKuuxuScd87M2FY4Ah9NV403HMHkK0CXAi/
        DCqA9KTwn1gV1a/bswWlK90aJBfCKXLMHKCMq6HZkSlVY0j4DBJ2EVX0BGC8VO6is1Lg49
        M827KFJ1cgNxYAlEvYuU/7se7VmSkF+V4MCjkwM0oU6TXUOvWBhik7bvbgeVbAtf8iC/Yo
        4yKxZJSdf5lG0k5OlJyhH2dq4ABHmtHXiZHi8yHSG7UkK4KF2VMUueQCermwGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=VT3e6NN7PgE82Og+WaclHeJcI+6c5zm7tVy4Rda9bOc=;
        b=gdmTjHtSrcED4YAbdTEQuqDd4Roi44XV3/3Rm/+5+I7SnCzPZCsye6Bp9rreOW/GkiRwuq
        Lgb31IA7CGCb1rCg==
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
Subject: [patch 13/53] x86/platform/ce4100: Prepare for separate mpparse
 callbacks
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:52:53 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select x86_dtb_parse_smp_config() as SMP configuration parser in
preparation of splitting up the get_smp_config() callback.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/platform/ce4100/ce4100.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/arch/x86/platform/ce4100/ce4100.c
@@ -135,12 +135,14 @@ static void sdv_pci_init(void)
  */
 void __init x86_ce4100_early_setup(void)
 {
-	x86_init.oem.arch_setup = sdv_arch_setup;
-	x86_init.resources.probe_roms = x86_init_noop;
-	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
-	x86_init.mpparse.find_mptable = x86_init_noop;
-	x86_init.pci.init = ce4100_pci_init;
-	x86_init.pci.init_irq = sdv_pci_init;
+	x86_init.oem.arch_setup			= sdv_arch_setup;
+	x86_init.resources.probe_roms		= x86_init_noop;
+	x86_init.mpparse.find_mptable		= x86_init_noop;
+	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
+	x86_init.mpparse.parse_smp_cfg		= x86_dtb_parse_smp_config;
+	x86_init.mpparse.get_smp_config		= x86_init_uint_noop;
+	x86_init.pci.init			= ce4100_pci_init;
+	x86_init.pci.init_irq			= sdv_pci_init;
 
 	/*
 	 * By default, the reboot method is ACPI which is supported by the

