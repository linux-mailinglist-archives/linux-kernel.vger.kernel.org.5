Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE937AAF48
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbjIVKOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjIVKOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:14:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5D794;
        Fri, 22 Sep 2023 03:14:43 -0700 (PDT)
Date:   Fri, 22 Sep 2023 10:14:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695377681;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m6oKo80YM1jv6r3dEtqSy8VqmOuvE51r2r/UpE6b6WA=;
        b=XPIFrP7gCRpEGWyLDNuWxXA0sCne93JpjTdyp6BU1husnrxfvU6Kbz5oIg5R3X5zdp34mS
        AXncqMNEEVBMiHEU9NsmTf64xhU1L95n29i8eZqd9oKpQLxgm6q2rpoi2yFQRDvgR3xMrg
        Cq/vO2kf97yDh5tF349Y3rIb2+uetemGzvjyoyX0dQ1WXbk4D2nApUG0yyIs+Mex2JxZ8v
        MYgFCkbZznmDd7O7xAP1KZI4o4zyb9UNu4slsjp1IHuzso8Vob78M352XMR782ts6cOAvQ
        jvT4FRVi4h/QWNjmBQetcdebcFJDjR6VT5Pz1IoPa9DQp3VgNqQQQOy6lanZbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695377681;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m6oKo80YM1jv6r3dEtqSy8VqmOuvE51r2r/UpE6b6WA=;
        b=F2pDuttEpQX0/SnFCJ72XshohTQdxryFfALtK+b7dk1lnSfdR+c8jzttptWTYDHdMJi92p
        d5B8zkLuepYDMxAQ==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/amd/core: Fix overflow reset on hotplug
Cc:     Sandipan Das <sandipan.das@amd.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C882a87511af40792ba69bb0e9026f19a2e71e8a3=2E16946?=
 =?utf-8?q?96888=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C882a87511af40792ba69bb0e9026f19a2e71e8a3=2E169469?=
 =?utf-8?q?6888=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <169537768083.27769.536098722468135960.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     23d2626b841c2adccdeb477665313c02dff02dc3
Gitweb:        https://git.kernel.org/tip/23d2626b841c2adccdeb477665313c02dff02dc3
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 14 Sep 2023 19:36:04 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Sep 2023 12:05:14 +02:00

perf/x86/amd/core: Fix overflow reset on hotplug

Kernels older than v5.19 do not support PerfMonV2 and the PMI handler
does not clear the overflow bits of the PerfCntrGlobalStatus register.
Because of this, loading a recent kernel using kexec from an older
kernel can result in inconsistent register states on Zen 4 systems.

The PMI handler of the new kernel gets confused and shows a warning when
an overflow occurs because some of the overflow bits are set even if the
corresponding counters are inactive. These are remnants from overflows
that were handled by the older kernel.

During CPU hotplug, the PerfCntrGlobalCtl and PerfCntrGlobalStatus
registers should always be cleared for PerfMonV2-capable processors.
However, a condition used for NB event constaints applicable only to
older processors currently prevents this from happening. Move the reset
sequence to an appropriate place and also clear the LBR Freeze bit.

Fixes: 21d59e3e2c40 ("perf/x86/amd/core: Detect PerfMonV2 support")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/882a87511af40792ba69bb0e9026f19a2e71e8a3.1694696888.git.sandipan.das@amd.com
---
 arch/x86/events/amd/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index abadd5f..ed626bf 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -534,8 +534,12 @@ static void amd_pmu_cpu_reset(int cpu)
 	/* Clear enable bits i.e. PerfCntrGlobalCtl.PerfCntrEn */
 	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
 
-	/* Clear overflow bits i.e. PerfCntrGLobalStatus.PerfCntrOvfl */
-	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, amd_pmu_global_cntr_mask);
+	/*
+	 * Clear freeze and overflow bits i.e. PerfCntrGLobalStatus.LbrFreeze
+	 * and PerfCntrGLobalStatus.PerfCntrOvfl
+	 */
+	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
+	       GLOBAL_STATUS_LBRS_FROZEN | amd_pmu_global_cntr_mask);
 }
 
 static int amd_pmu_cpu_prepare(int cpu)
@@ -570,6 +574,7 @@ static void amd_pmu_cpu_starting(int cpu)
 	int i, nb_id;
 
 	cpuc->perf_ctr_virt_mask = AMD64_EVENTSEL_HOSTONLY;
+	amd_pmu_cpu_reset(cpu);
 
 	if (!x86_pmu.amd_nb_constraints)
 		return;
@@ -591,8 +596,6 @@ static void amd_pmu_cpu_starting(int cpu)
 
 	cpuc->amd_nb->nb_id = nb_id;
 	cpuc->amd_nb->refcnt++;
-
-	amd_pmu_cpu_reset(cpu);
 }
 
 static void amd_pmu_cpu_dead(int cpu)
@@ -601,6 +604,7 @@ static void amd_pmu_cpu_dead(int cpu)
 
 	kfree(cpuhw->lbr_sel);
 	cpuhw->lbr_sel = NULL;
+	amd_pmu_cpu_reset(cpu);
 
 	if (!x86_pmu.amd_nb_constraints)
 		return;
@@ -613,8 +617,6 @@ static void amd_pmu_cpu_dead(int cpu)
 
 		cpuhw->amd_nb = NULL;
 	}
-
-	amd_pmu_cpu_reset(cpu);
 }
 
 static inline void amd_pmu_set_global_ctl(u64 ctl)
