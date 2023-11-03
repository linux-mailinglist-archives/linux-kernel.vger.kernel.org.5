Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0A47E0BF0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjKCXGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjKCXF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:05:59 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657E7D6F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 16:05:56 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc385e90a9so20288815ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 16:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699052756; x=1699657556; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=14t8J2dqJR1PSLTL343RjgPlrxeM7Se//FxMlzhSSkI=;
        b=ExEtH0hv7fYQsiq/avEZTwYtW2skJHaoxzsDr2tX5DrB/hiHXPQfFto7o2sQ6tWVns
         F8NX6SIWFd3OlkDYC02t7q+F1vZNk2IeRO0jt6stqOzWXe63vOpFn3a7dPwD49j/8yiE
         zYxs22FzZR1u6OaEGHI/CnObRENd3owz692tE3A+9lkO9XljReRp8sF/EQAdjJxzu98y
         Wc4m5g+sMkmA5fcmMgmMBD5/JHqIDvu1mVhchbFzFiNbdXromW+z/rz1bztlAZoagwEt
         GcPtdglaykpuvYgGt8Dpd7NmwjsrhklFF1KAohIznGYWJWTzrHtVnAT/DHLzYf09ipAX
         gq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699052756; x=1699657556;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14t8J2dqJR1PSLTL343RjgPlrxeM7Se//FxMlzhSSkI=;
        b=c+Tsxf/QXH/2Qd9XYy6xosuxkyDKCPpB/Iql/148O7QM4325M8gY+4YEK8ZvHVDy2x
         vH3CRZSRS2Ns7BfeCZQ8peEU3hLjIG4Bo87ek9WRuHQocWfRuGU+KD9ITETdcmQrukQ/
         8dQ5weleU0BSEXbkiD1BW0mMm0fo9xndQLqI8689UyJMbV3VcwGjVYWDtcImqpDVe9A/
         +NNxNqsehsvqieKnWE+pmiC+d/Qg1N5P9pFkzoL+C8IRlS8qTs2dZ6XQSnq72YxGBnib
         g3wNC13E6gKiduVcRig+DvIw7OcuDkyivP/GpmTgXe0YeYW9rhU+v14Kyz667AWrvkbF
         G6iA==
X-Gm-Message-State: AOJu0YxeWrxDNSUTiIcyC9uyk3Rqi8jmJ1NmuhTJezs/Ml7Xi47sbSnK
        DqLdz792EaoYR9QM+MaMfRGBlIClsxo=
X-Google-Smtp-Source: AGHT+IGFwPMlPeFC+ELnJ9TVkRYHuty2j+AJtK6pD28u0rUU9WO/tqBpvSvIbEOG/FUmESncwZkg1f6am5c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:9b93:b0:1cc:5674:9177 with SMTP id
 y19-20020a1709029b9300b001cc56749177mr260160plp.11.1699052755280; Fri, 03 Nov
 2023 16:05:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Nov 2023 16:05:41 -0700
In-Reply-To: <20231103230541.352265-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231103230541.352265-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231103230541.352265-7-seanjc@google.com>
Subject: [PATCH v2 6/6] KVM: x86/pmu: Track emulated counter events instead of
 previous counter
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Mingwei Zhang <mizhang@google.com>,
        Roman Kagan <rkagan@amazon.de>,
        Jim Mattson <jmattson@google.com>,
        Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly track emulated counter events instead of using the common
counter value that's shared with the hardware counter owned by perf.
Bumping the common counter requires snapshotting the pre-increment value
in order to detect overflow from emulation, and the snapshot approach is
inherently flawed.

Snapshotting the previous counter at every increment assumes that there is
at most one emulated counter event per emulated instruction (or rather,
between checks for KVM_REQ_PMU).  That's mostly holds true today because
KVM only emulates (branch) instructions retired, but the approach will
fall apart if KVM ever supports event types that don't have a 1:1
relationship with instructions.

And KVM already has a relevant bug, as handle_invalid_guest_state()
emulates multiple instructions without checking KVM_REQ_PMU, i.e. could
miss an overflow event due to clobbering pmc->prev_counter.  Not checking
KVM_REQ_PMU is problematic in both cases, but at least with the emulated
counter approach, the resulting behavior is delayed overflow detection,
as opposed to completely lost detection.

Tracking the emulated count fixes another bug where the snapshot approach
can signal spurious overflow due to incorporating both the emulated count
and perf's count in the check, i.e. if overflow is detected by perf, then
KVM's emulation will also incorrectly signal overflow.  Add a comment in
the related code to call out the need to process emulated events *after*
pausing the perf event (big kudos to Mingwei for figuring out that
particular wrinkle).

Cc: Mingwei Zhang <mizhang@google.com>
Cc: Roman Kagan <rkagan@amazon.de>
Cc: Jim Mattson <jmattson@google.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Like Xu <like.xu.linux@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 17 +++++++++++-
 arch/x86/kvm/pmu.c              | 48 ++++++++++++++++++++++++---------
 arch/x86/kvm/pmu.h              |  3 ++-
 3 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d7036982332e..d8bc9ba88cfc 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -500,8 +500,23 @@ struct kvm_pmc {
 	u8 idx;
 	bool is_paused;
 	bool intr;
+	/*
+	 * Base value of the PMC counter, relative to the *consumed* count in
+	 * the associated perf_event.  This value includes counter updates from
+	 * the perf_event and emulated_count since the last time the counter
+	 * was reprogrammed, but it is *not* the current value as seen by the
+	 * guest or userspace.
+	 *
+	 * The count is relative to the associated perf_event so that KVM
+	 * doesn't need to reprogram the perf_event every time the guest writes
+	 * to the counter.
+	 */
 	u64 counter;
-	u64 prev_counter;
+	/*
+	 * PMC events triggered by KVM emulation that haven't been fully
+	 * processed, i.e. haven't undergone overflow detection.
+	 */
+	u64 emulated_counter;
 	u64 eventsel;
 	struct perf_event *perf_event;
 	struct kvm_vcpu *vcpu;
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 3725d001239d..87cc6c8809ad 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -127,9 +127,9 @@ static void kvm_perf_overflow(struct perf_event *perf_event,
 	struct kvm_pmc *pmc = perf_event->overflow_handler_context;
 
 	/*
-	 * Ignore overflow events for counters that are scheduled to be
-	 * reprogrammed, e.g. if a PMI for the previous event races with KVM's
-	 * handling of a related guest WRMSR.
+	 * Ignore asynchronous overflow events for counters that are scheduled
+	 * to be reprogrammed, e.g. if a PMI for the previous event races with
+	 * KVM's handling of a related guest WRMSR.
 	 */
 	if (test_and_set_bit(pmc->idx, pmc_to_pmu(pmc)->reprogram_pmi))
 		return;
@@ -224,17 +224,30 @@ static int pmc_reprogram_counter(struct kvm_pmc *pmc, u32 type, u64 config,
 	return 0;
 }
 
-static void pmc_pause_counter(struct kvm_pmc *pmc)
+static bool pmc_pause_counter(struct kvm_pmc *pmc)
 {
 	u64 counter = pmc->counter;
-
-	if (!pmc->perf_event || pmc->is_paused)
-		return;
+	u64 prev_counter;
 
 	/* update counter, reset event value to avoid redundant accumulation */
-	counter += perf_event_pause(pmc->perf_event, true);
+	if (pmc->perf_event && !pmc->is_paused)
+		counter += perf_event_pause(pmc->perf_event, true);
+
+	/*
+	 * Snapshot the previous counter *after* accumulating state from perf.
+	 * If overflow already happened, hardware (via perf) is responsible for
+	 * generating a PMI.  KVM just needs to detect overflow on emulated
+	 * counter events that haven't yet been processed.
+	 */
+	prev_counter = counter & pmc_bitmask(pmc);
+
+	counter += pmc->emulated_counter;
 	pmc->counter = counter & pmc_bitmask(pmc);
+
+	pmc->emulated_counter = 0;
 	pmc->is_paused = true;
+
+	return pmc->counter < prev_counter;
 }
 
 static bool pmc_resume_counter(struct kvm_pmc *pmc)
@@ -289,6 +302,15 @@ static void pmc_update_sample_period(struct kvm_pmc *pmc)
 
 void pmc_write_counter(struct kvm_pmc *pmc, u64 val)
 {
+	/*
+	 * Drop any unconsumed accumulated counts, the WRMSR is a write, not a
+	 * read-modify-write.  Adjust the counter value so that its value is
+	 * relative to the current count, as reading the current count from
+	 * perf is faster than pausing and repgrogramming the event in order to
+	 * reset it to '0'.  Note, this very sneakily offsets the accumulated
+	 * emulated count too, by using pmc_read_counter()!
+	 */
+	pmc->emulated_counter = 0;
 	pmc->counter += val - pmc_read_counter(pmc);
 	pmc->counter &= pmc_bitmask(pmc);
 	pmc_update_sample_period(pmc);
@@ -428,14 +450,15 @@ static void reprogram_counter(struct kvm_pmc *pmc)
 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
 	u64 eventsel = pmc->eventsel;
 	u64 new_config = eventsel;
+	bool emulate_overflow;
 	u8 fixed_ctr_ctrl;
 
-	pmc_pause_counter(pmc);
+	emulate_overflow = pmc_pause_counter(pmc);
 
 	if (!pmc_event_is_allowed(pmc))
 		goto reprogram_complete;
 
-	if (pmc->counter < pmc->prev_counter)
+	if (emulate_overflow)
 		__kvm_perf_overflow(pmc, false);
 
 	if (eventsel & ARCH_PERFMON_EVENTSEL_PIN_CONTROL)
@@ -475,7 +498,6 @@ static void reprogram_counter(struct kvm_pmc *pmc)
 
 reprogram_complete:
 	clear_bit(pmc->idx, (unsigned long *)&pmc_to_pmu(pmc)->reprogram_pmi);
-	pmc->prev_counter = 0;
 }
 
 void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
@@ -701,6 +723,7 @@ static void kvm_pmu_reset(struct kvm_vcpu *vcpu)
 
 		pmc_stop_counter(pmc);
 		pmc->counter = 0;
+		pmc->emulated_counter = 0;
 
 		if (pmc_is_gp(pmc))
 			pmc->eventsel = 0;
@@ -772,8 +795,7 @@ void kvm_pmu_destroy(struct kvm_vcpu *vcpu)
 
 static void kvm_pmu_incr_counter(struct kvm_pmc *pmc)
 {
-	pmc->prev_counter = pmc->counter;
-	pmc->counter = (pmc->counter + 1) & pmc_bitmask(pmc);
+	pmc->emulated_counter++;
 	kvm_pmu_request_counter_reprogram(pmc);
 }
 
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index cae85e550f60..7caeb3d8d4fd 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -66,7 +66,8 @@ static inline u64 pmc_read_counter(struct kvm_pmc *pmc)
 {
 	u64 counter, enabled, running;
 
-	counter = pmc->counter;
+	counter = pmc->counter + pmc->emulated_counter;
+
 	if (pmc->perf_event && !pmc->is_paused)
 		counter += perf_event_read_value(pmc->perf_event,
 						 &enabled, &running);
-- 
2.42.0.869.gea05f2083d-goog

