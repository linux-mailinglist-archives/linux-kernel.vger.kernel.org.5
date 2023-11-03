Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31137E0C34
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjKCXVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjKCXVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:21:47 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0707A2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 16:21:44 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6c3077984e8so2501503b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 16:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699053704; x=1699658504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bj/eblPINrMB9xzXRyi+vs548CQoWthOvhDL0h2WS+0=;
        b=R06J6lWfIL38LQQUTjtJPvRlsgjWKbq9bNL7s+Jdiomouv6QlWGgV7iNTu90RTUbAG
         qXF9qxzsaETCh3itM9VTZuRPtGuq7qwT8buNRvVzpmK/MxbSoaKAPCsUrPxTWOC05l2F
         ZkWiarYuBbCTQMhNEc35ugkDpCuBCe9uXBGbebcK4I6siti8HwKL7XQKU71G+3vjXLo/
         DNGjC4bhwddDH+pbyu8Bbyfy471BWmamvAnpAQvR0w2DBvObWAPfsNwgJNdQSREe4THz
         6C6HL3lErDDUTmd2t1VSTng6G8cZHzZ4hdyo/+1P5MCjc0WEs9CJx9eb8O+f3GEwvbSC
         J90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699053704; x=1699658504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bj/eblPINrMB9xzXRyi+vs548CQoWthOvhDL0h2WS+0=;
        b=BuabG+Of36MoIlb11malPsgxDRdOMqoyi4x5OE64jsIWvErBZBqRkWFJCwvTftFj09
         LPdSg51dmv9JpepyMuFC51EN53rrbwWck+cYBi1ARi+PucsiUx2cOH62C2Y8vKEPb9r2
         JSHotIVD52qyn4M72My/Zzzjb0j6GxPow34mfA/Z4vRpJ34Tn6Ls39jtBI8yS9OggelW
         0s8MkcF5ft46cJDa520o/9ptsFJqwA8fthIcwFuCCo96rpO/KoHZKYVq7SCHkMpA4PKI
         4Z4linNVa2THofD7ov2Bf7Bw6NfWbB8qO1CNaSzo2BZzaDSwgM3thzPgJsJo/0uJJCko
         q/Ig==
X-Gm-Message-State: AOJu0Yz4Q1uiUm2RB7CpFOBEkffpGDXK7ayRs4E1CRPpHsD68MOuwTqD
        Onikc8PcBkdzs62YzwSMR0McqhEklzywdRGL2wpQ/A==
X-Google-Smtp-Source: AGHT+IGK2h3ZrhYZ3HypiHYVTkF9qjppv32zQkaZQMu4RXQQfPH9yv0bM+3I4STC/qSkHkA/1P8ttA==
X-Received: by 2002:a05:6a20:e109:b0:180:d9de:2d5e with SMTP id kr9-20020a056a20e10900b00180d9de2d5emr15674481pzb.39.1699053703828;
        Fri, 03 Nov 2023 16:21:43 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 13-20020a17090a004d00b0027782f611d1sm2084339pjb.36.2023.11.03.16.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 16:21:43 -0700 (PDT)
Date:   Fri, 3 Nov 2023 23:21:39 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Roman Kagan <rkagan@amazon.de>,
        Jim Mattson <jmattson@google.com>,
        Like Xu <like.xu.linux@gmail.com>
Subject: Re: [PATCH v2 6/6] KVM: x86/pmu: Track emulated counter events
 instead of previous counter
Message-ID: <ZUWAg3WP2XESCAR4@google.com>
References: <20231103230541.352265-1-seanjc@google.com>
 <20231103230541.352265-7-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103230541.352265-7-seanjc@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023, Sean Christopherson wrote:
> Explicitly track emulated counter events instead of using the common
> counter value that's shared with the hardware counter owned by perf.
> Bumping the common counter requires snapshotting the pre-increment value
> in order to detect overflow from emulation, and the snapshot approach is
> inherently flawed.
> 
> Snapshotting the previous counter at every increment assumes that there is
> at most one emulated counter event per emulated instruction (or rather,
> between checks for KVM_REQ_PMU).  That's mostly holds true today because
> KVM only emulates (branch) instructions retired, but the approach will
> fall apart if KVM ever supports event types that don't have a 1:1
> relationship with instructions.
> 
> And KVM already has a relevant bug, as handle_invalid_guest_state()
> emulates multiple instructions without checking KVM_REQ_PMU, i.e. could
> miss an overflow event due to clobbering pmc->prev_counter.  Not checking
> KVM_REQ_PMU is problematic in both cases, but at least with the emulated
> counter approach, the resulting behavior is delayed overflow detection,
> as opposed to completely lost detection.
> 
> Tracking the emulated count fixes another bug where the snapshot approach
> can signal spurious overflow due to incorporating both the emulated count
> and perf's count in the check, i.e. if overflow is detected by perf, then
> KVM's emulation will also incorrectly signal overflow.  Add a comment in
> the related code to call out the need to process emulated events *after*
> pausing the perf event (big kudos to Mingwei for figuring out that
> particular wrinkle).
> 
> Cc: Mingwei Zhang <mizhang@google.com>
> Cc: Roman Kagan <rkagan@amazon.de>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Cc: Like Xu <like.xu.linux@gmail.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
Reviewed-by: Mingwei Zhang <mizhang@google.com>

>  arch/x86/include/asm/kvm_host.h | 17 +++++++++++-
>  arch/x86/kvm/pmu.c              | 48 ++++++++++++++++++++++++---------
>  arch/x86/kvm/pmu.h              |  3 ++-
>  3 files changed, 53 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index d7036982332e..d8bc9ba88cfc 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -500,8 +500,23 @@ struct kvm_pmc {
>  	u8 idx;
>  	bool is_paused;
>  	bool intr;
> +	/*
> +	 * Base value of the PMC counter, relative to the *consumed* count in
> +	 * the associated perf_event.  This value includes counter updates from
> +	 * the perf_event and emulated_count since the last time the counter
> +	 * was reprogrammed, but it is *not* the current value as seen by the
> +	 * guest or userspace.
> +	 *
> +	 * The count is relative to the associated perf_event so that KVM
> +	 * doesn't need to reprogram the perf_event every time the guest writes
> +	 * to the counter.
> +	 */
>  	u64 counter;
> -	u64 prev_counter;
> +	/*
> +	 * PMC events triggered by KVM emulation that haven't been fully
> +	 * processed, i.e. haven't undergone overflow detection.
> +	 */
> +	u64 emulated_counter;
>  	u64 eventsel;
>  	struct perf_event *perf_event;
>  	struct kvm_vcpu *vcpu;
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 3725d001239d..87cc6c8809ad 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -127,9 +127,9 @@ static void kvm_perf_overflow(struct perf_event *perf_event,
>  	struct kvm_pmc *pmc = perf_event->overflow_handler_context;
>  
>  	/*
> -	 * Ignore overflow events for counters that are scheduled to be
> -	 * reprogrammed, e.g. if a PMI for the previous event races with KVM's
> -	 * handling of a related guest WRMSR.
> +	 * Ignore asynchronous overflow events for counters that are scheduled
> +	 * to be reprogrammed, e.g. if a PMI for the previous event races with
> +	 * KVM's handling of a related guest WRMSR.
>  	 */
>  	if (test_and_set_bit(pmc->idx, pmc_to_pmu(pmc)->reprogram_pmi))
>  		return;
> @@ -224,17 +224,30 @@ static int pmc_reprogram_counter(struct kvm_pmc *pmc, u32 type, u64 config,
>  	return 0;
>  }
>  
> -static void pmc_pause_counter(struct kvm_pmc *pmc)
> +static bool pmc_pause_counter(struct kvm_pmc *pmc)
>  {
>  	u64 counter = pmc->counter;
> -
> -	if (!pmc->perf_event || pmc->is_paused)
> -		return;
> +	u64 prev_counter;
>  
>  	/* update counter, reset event value to avoid redundant accumulation */
> -	counter += perf_event_pause(pmc->perf_event, true);
> +	if (pmc->perf_event && !pmc->is_paused)
> +		counter += perf_event_pause(pmc->perf_event, true);
> +
> +	/*
> +	 * Snapshot the previous counter *after* accumulating state from perf.
> +	 * If overflow already happened, hardware (via perf) is responsible for
> +	 * generating a PMI.  KVM just needs to detect overflow on emulated
> +	 * counter events that haven't yet been processed.
> +	 */
> +	prev_counter = counter & pmc_bitmask(pmc);
> +
> +	counter += pmc->emulated_counter;
>  	pmc->counter = counter & pmc_bitmask(pmc);
> +
> +	pmc->emulated_counter = 0;
>  	pmc->is_paused = true;
> +
> +	return pmc->counter < prev_counter;
>  }
>  
>  static bool pmc_resume_counter(struct kvm_pmc *pmc)
> @@ -289,6 +302,15 @@ static void pmc_update_sample_period(struct kvm_pmc *pmc)
>  
>  void pmc_write_counter(struct kvm_pmc *pmc, u64 val)
>  {
> +	/*
> +	 * Drop any unconsumed accumulated counts, the WRMSR is a write, not a
> +	 * read-modify-write.  Adjust the counter value so that its value is
> +	 * relative to the current count, as reading the current count from
> +	 * perf is faster than pausing and repgrogramming the event in order to
> +	 * reset it to '0'.  Note, this very sneakily offsets the accumulated
> +	 * emulated count too, by using pmc_read_counter()!
> +	 */
> +	pmc->emulated_counter = 0;
>  	pmc->counter += val - pmc_read_counter(pmc);
>  	pmc->counter &= pmc_bitmask(pmc);
>  	pmc_update_sample_period(pmc);
> @@ -428,14 +450,15 @@ static void reprogram_counter(struct kvm_pmc *pmc)
>  	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
>  	u64 eventsel = pmc->eventsel;
>  	u64 new_config = eventsel;
> +	bool emulate_overflow;
>  	u8 fixed_ctr_ctrl;
>  
> -	pmc_pause_counter(pmc);
> +	emulate_overflow = pmc_pause_counter(pmc);
>  
>  	if (!pmc_event_is_allowed(pmc))
>  		goto reprogram_complete;
>  
> -	if (pmc->counter < pmc->prev_counter)
> +	if (emulate_overflow)
>  		__kvm_perf_overflow(pmc, false);
>  
>  	if (eventsel & ARCH_PERFMON_EVENTSEL_PIN_CONTROL)
> @@ -475,7 +498,6 @@ static void reprogram_counter(struct kvm_pmc *pmc)
>  
>  reprogram_complete:
>  	clear_bit(pmc->idx, (unsigned long *)&pmc_to_pmu(pmc)->reprogram_pmi);
> -	pmc->prev_counter = 0;
>  }
>  
>  void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
> @@ -701,6 +723,7 @@ static void kvm_pmu_reset(struct kvm_vcpu *vcpu)
>  
>  		pmc_stop_counter(pmc);
>  		pmc->counter = 0;
> +		pmc->emulated_counter = 0;
>  
>  		if (pmc_is_gp(pmc))
>  			pmc->eventsel = 0;
> @@ -772,8 +795,7 @@ void kvm_pmu_destroy(struct kvm_vcpu *vcpu)
>  
>  static void kvm_pmu_incr_counter(struct kvm_pmc *pmc)
>  {
> -	pmc->prev_counter = pmc->counter;
> -	pmc->counter = (pmc->counter + 1) & pmc_bitmask(pmc);
> +	pmc->emulated_counter++;
>  	kvm_pmu_request_counter_reprogram(pmc);
>  }
>  
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index cae85e550f60..7caeb3d8d4fd 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -66,7 +66,8 @@ static inline u64 pmc_read_counter(struct kvm_pmc *pmc)
>  {
>  	u64 counter, enabled, running;
>  
> -	counter = pmc->counter;
> +	counter = pmc->counter + pmc->emulated_counter;
> +
>  	if (pmc->perf_event && !pmc->is_paused)
>  		counter += perf_event_read_value(pmc->perf_event,
>  						 &enabled, &running);
> -- 
> 2.42.0.869.gea05f2083d-goog
> 
