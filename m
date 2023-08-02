Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0951776CACE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjHBKZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjHBKX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:23:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BD330D1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 03:22:19 -0700 (PDT)
Message-ID: <20230802101934.924770305@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690971719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=dCJ675XRBN0nH/FVG6be5pN6/XKm3FLkxuXqtWJHHNE=;
        b=x0T7RwHmn15tm0Bs8ZjDPJLTBGPqVnxETx0F5yv7R4E0JgrRpz7+E7tzWITycUfEu+MWSS
        ZL8dIL6Kp7stAiWx1i+I3eTrH/ESvYQMaTWpYR+IAUGKTihGsHGAy2Aa0MNyMCajL6Xv2b
        SAAxQwmUe/r8wO6lD3xc4Vp3q6oenYOgqcJ8jh83r72qpURo7zJ3iufy8Q2m8A+ItxTgUK
        J0TFlm8yX1A2mH2fGxAu2t38niiSiNKtP0hAdYC/MirH1m4BMJCpE49MyYy+m6Eaw8VzFM
        dxhA5cf3IMLFteqfBQPtvtNNQey6DnjZl71NH+EBxNV73U0WuvhxJtyrenh82g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690971719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=dCJ675XRBN0nH/FVG6be5pN6/XKm3FLkxuXqtWJHHNE=;
        b=ilXXJAbhecQY8Sfrpo02SFMDLMnw8w5lXtXX/19KQ/bCI9mKKqTMlTZxS/4Qnf3umoQ1DB
        fHitGSthN95zfqCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: [patch V3 39/40] x86/xen/smp_pv: Remove cpudata fiddling
References: <20230802101635.459108805@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  2 Aug 2023 12:21:59 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new topology CPUID parser installs already fake topology for XEN/PV,
which ends up with cpuinfo::max_cores = 1.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
---
V2: New patch
---
 arch/x86/xen/smp_pv.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -73,7 +73,6 @@ static void cpu_bringup(void)
 	}
 	cpu = smp_processor_id();
 	smp_store_cpu_info(cpu);
-	cpu_data(cpu).x86_max_cores = 1;
 	set_cpu_sibling_map(cpu);
 
 	speculative_store_bypass_ht_init();
@@ -223,8 +222,6 @@ static void __init xen_pv_smp_prepare_cp
 
 	smp_prepare_cpus_common();
 
-	cpu_data(0).x86_max_cores = 1;
-
 	speculative_store_bypass_ht_init();
 
 	xen_pmu_init(0);

