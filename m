Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B574801878
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjLBAEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441967AbjLBAEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:04:36 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31C6133
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:04:30 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2859fe4461aso3253322a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 16:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701475470; x=1702080270; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=IlV9aHgXCDr1PCq/OJiSpLXuk1u3KjEQF1oNVvd8opE=;
        b=LwYKKOV5Ckke8o2P+FmOkZfdVSozdktgsUGHls2/Lz7I7XkQhAyidKTec6qmG4/lXF
         P7fNQp/RcfX4qdJ2efuQ14RH+Hv/ljm4s/2OgGXsDp4khSczuHd15lc2NrbVSIPXobJN
         irjjaL7/UAJx8qmziVc93KzIqeLFSy4JwHeg6KxIsFZrQgNKGSf2WmqHAezhNxpLViHR
         DQhQqRmYnuTsIBMEM0WBXx2rONcAquU1IQBZxgRnKh4nu/pm/ehr340ndhOhQ1VhCeLK
         aoocImMQKxXCzx1TohhPu3PdT1A8tv3bX5WSbpMGnpD3/qB2BGkLCs26tOGaB1hawgkw
         OyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701475470; x=1702080270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlV9aHgXCDr1PCq/OJiSpLXuk1u3KjEQF1oNVvd8opE=;
        b=PQnRLWv6GzcJVWF0RSXuj5C9nXz8o0JRxwbWSOPfpTXnvWrbCFmVAqNp1xzEoE4nHb
         6uYdhlh66eIvmgy5PEvL57n9kxhgFaErIJ5I5I424Xuiopz99qIOjSM8xU2QdvCqVWkc
         lMej2wHHorQG3NoFzqQcbzJlxSMtScRtYEUS4izZBayacIkChYWBpla6UBEVP/Z5iPKm
         JvCxPhbv/LNh8JGF6y+GixkXmpeHQXZ6S+bmufWY0Br4vOzi5KS441TCxEqHdcTC9gJW
         4ZVb7BmAWY/3c4+QaztN12lW2SKxz7Pypg01nkgebGDrkJkBr/CRHIMMAaCfT40cqUrN
         0h3A==
X-Gm-Message-State: AOJu0YztE+on4wXYdvF5IHb1HuoDj+3WBohdo1fwaxK3IWNj2qsHbpps
        ESR/PibtI39pda5DK/di5Xuxc5nLXtI=
X-Google-Smtp-Source: AGHT+IHe73U04LFyU3cCC97hEmyqtqWWU+NyyoCwQ5gWdButyfA0mh42MPPXQN6XuuXmYJI+tvDCi+Uv4IQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:7006:b0:1cf:cc0d:b295 with SMTP id
 y6-20020a170902700600b001cfcc0db295mr3418209plk.13.1701475470418; Fri, 01 Dec
 2023 16:04:30 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  1 Dec 2023 16:03:54 -0800
In-Reply-To: <20231202000417.922113-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231202000417.922113-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231202000417.922113-6-seanjc@google.com>
Subject: [PATCH v9 05/28] KVM: x86/pmu: Get eventsel for fixed counters from perf
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get the event selectors used to effectively request fixed counters for
perf events from perf itself instead of hardcoding them in KVM and hoping
that they match the underlying hardware.  While fixed counters 0 and 1 use
architectural events, as of ffbe4ab0beda ("perf/x86/intel: Extend the
ref-cycles event to GP counters") fixed counter 2 (reference TSC cycles)
may use a software-defined pseudo-encoding or a real hardware-defined
encoding.

Reported-by: Kan Liang <kan.liang@linux.intel.com>
Closes: https://lkml.kernel.org/r/4281eee7-6423-4ec8-bb18-c6aeee1faf2c%40linux.intel.com
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 98e92b9ece09..ec4feaef3d55 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -404,24 +404,28 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
  * result is the same (ignoring the fact that using a general purpose counter
  * will likely exacerbate counter contention).
  *
- * Note, reference cycles is counted using a perf-defined "psuedo-encoding",
- * as there is no architectural general purpose encoding for reference cycles.
+ * Forcibly inlined to allow asserting on @index at build time, and there should
+ * never be more than one user.
  */
-static u64 intel_get_fixed_pmc_eventsel(int index)
+static __always_inline u64 intel_get_fixed_pmc_eventsel(unsigned int index)
 {
-	const struct {
-		u8 event;
-		u8 unit_mask;
-	} fixed_pmc_events[] = {
-		[0] = { 0xc0, 0x00 }, /* Instruction Retired / PERF_COUNT_HW_INSTRUCTIONS. */
-		[1] = { 0x3c, 0x00 }, /* CPU Cycles/ PERF_COUNT_HW_CPU_CYCLES. */
-		[2] = { 0x00, 0x03 }, /* Reference Cycles / PERF_COUNT_HW_REF_CPU_CYCLES*/
+	const enum perf_hw_id fixed_pmc_perf_ids[] = {
+		[0] = PERF_COUNT_HW_INSTRUCTIONS,
+		[1] = PERF_COUNT_HW_CPU_CYCLES,
+		[2] = PERF_COUNT_HW_REF_CPU_CYCLES,
 	};
+	u64 eventsel;
 
-	BUILD_BUG_ON(ARRAY_SIZE(fixed_pmc_events) != KVM_PMC_MAX_FIXED);
+	BUILD_BUG_ON(ARRAY_SIZE(fixed_pmc_perf_ids) != KVM_PMC_MAX_FIXED);
+	BUILD_BUG_ON(index >= KVM_PMC_MAX_FIXED);
 
-	return (fixed_pmc_events[index].unit_mask << 8) |
-		fixed_pmc_events[index].event;
+	/*
+	 * Yell if perf reports support for a fixed counter but perf doesn't
+	 * have a known encoding for the associated general purpose event.
+	 */
+	eventsel = perf_get_hw_event_config(fixed_pmc_perf_ids[index]);
+	WARN_ON_ONCE(!eventsel && index < kvm_pmu_cap.num_counters_fixed);
+	return eventsel;
 }
 
 static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
-- 
2.43.0.rc2.451.g8631bc7472-goog

