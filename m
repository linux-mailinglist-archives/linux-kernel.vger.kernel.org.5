Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B713801871
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441971AbjLBAEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbjLBAEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:04:23 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC8CD67
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:04:29 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db584b8fb9cso1387698276.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 16:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701475468; x=1702080268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nIOxy6M4X+Ql7aRps4Vs1bjcNWEAWUlJqdIwiwhjV/U=;
        b=kI+/ibgMIg4KxGHmFC5eMfYZb7cNC4SUlcuIhdeIuAb0VsJdRCW3bTKr8qWhDXY6IG
         +qZcDfutiNn0BhUZFdZ3yduqdV9Vk+VnOpVunl2h/lWJXX9yxNC2L7lDsckMRfxsQsST
         F3hcG2h5CDLUPHdtCPG9ySvW6uLH5tCoUJVEg2bawYOcHxmXWcfxBQuJF5uzhHT0iLrE
         Hgt3Vh7LWowDNTnBWdhv2QPczwD+hLCXvGVQaE/PPytIWLEn7Utmz+Fss1TE1pA0fO8J
         Y043TnFpw5fmkFXrCbiIOZJ/ckQC3vGGpUa9q0cwq8oZvZnjZ9K/VIa5kCTUUG+TtJhn
         JUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701475468; x=1702080268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIOxy6M4X+Ql7aRps4Vs1bjcNWEAWUlJqdIwiwhjV/U=;
        b=qjBBKlMoDQUzZxo+AyloBXuTAuVtpqL4cX5M/2i1zB2VCrYMmTXGTsj4q7LA+AK7YT
         nkTs68ydCo6YWLDZJ92qU06Sf/UYTX3fSQktX01mBjsILQVaZWjIagMOBa6XsACkRnny
         u/xv02ZXkO3YGpEUTMitA8+VUB0sUiv93MaCnwoAOlnnuac1mKeHTkA6kzxnsDCstBSH
         lhVCggj0TECTNS/4sBlUnJml9Sgzcv5XLo9X40LhbsFo1h2XZ5PWIbpbx3pNU+v5sTrz
         8JpzPgNeOaWoTd8wPC+orwmpBo52+KkuljL7IpO+Bo4Q2oP4pouPqjJzZCrACcmInR7I
         pQKg==
X-Gm-Message-State: AOJu0Yy+4UrfGN6CCHgn5ftbPm4bp8D6CecMl0+WrzXZHYyv0HzbJMjx
        bZ7H5Uc1XUjCe6ryLGVENDUg8UK6dpg=
X-Google-Smtp-Source: AGHT+IE8VTpP8iIpAtxJmnjFAbxSHkvt+0MQS5fKUuY2PbPdybPQNDNefIq9CU9yVFX2nrDSHES0zOtj1+E=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:687:0:b0:db4:5e66:4a05 with SMTP id
 129-20020a250687000000b00db45e664a05mr804821ybg.2.1701475468385; Fri, 01 Dec
 2023 16:04:28 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  1 Dec 2023 16:03:53 -0800
In-Reply-To: <20231202000417.922113-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231202000417.922113-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231202000417.922113-5-seanjc@google.com>
Subject: [PATCH v9 04/28] KVM: x86/pmu: Setup fixed counters' eventsel during
 PMU initialization
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
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the eventsel for all fixed counters during PMU initialization, the
eventsel is hardcoded and consumed if and only if the counter is supported,
i.e. there is no reason to redo the setup every time the PMU is refreshed.

Configuring all KVM-supported fixed counter also eliminates a potential
pitfall if/when KVM supports discontiguous fixed counters, in which case
configuring only nr_arch_fixed_counters will be insufficient (ignoring the
fact that KVM will need many other changes to support discontiguous fixed
counters).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index f3c44ddc09f8..98e92b9ece09 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -407,27 +407,21 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
  * Note, reference cycles is counted using a perf-defined "psuedo-encoding",
  * as there is no architectural general purpose encoding for reference cycles.
  */
-static void setup_fixed_pmc_eventsel(struct kvm_pmu *pmu)
+static u64 intel_get_fixed_pmc_eventsel(int index)
 {
 	const struct {
-		u8 eventsel;
+		u8 event;
 		u8 unit_mask;
 	} fixed_pmc_events[] = {
 		[0] = { 0xc0, 0x00 }, /* Instruction Retired / PERF_COUNT_HW_INSTRUCTIONS. */
 		[1] = { 0x3c, 0x00 }, /* CPU Cycles/ PERF_COUNT_HW_CPU_CYCLES. */
 		[2] = { 0x00, 0x03 }, /* Reference Cycles / PERF_COUNT_HW_REF_CPU_CYCLES*/
 	};
-	int i;
 
 	BUILD_BUG_ON(ARRAY_SIZE(fixed_pmc_events) != KVM_PMC_MAX_FIXED);
 
-	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
-		int index = array_index_nospec(i, KVM_PMC_MAX_FIXED);
-		struct kvm_pmc *pmc = &pmu->fixed_counters[index];
-
-		pmc->eventsel = (fixed_pmc_events[index].unit_mask << 8) |
-				 fixed_pmc_events[index].eventsel;
-	}
+	return (fixed_pmc_events[index].unit_mask << 8) |
+		fixed_pmc_events[index].event;
 }
 
 static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
@@ -493,7 +487,6 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 						  kvm_pmu_cap.bit_width_fixed);
 		pmu->counter_bitmask[KVM_PMC_FIXED] =
 			((u64)1 << edx.split.bit_width_fixed) - 1;
-		setup_fixed_pmc_eventsel(pmu);
 	}
 
 	for (i = 0; i < pmu->nr_arch_fixed_counters; i++)
@@ -571,6 +564,7 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
 		pmu->fixed_counters[i].vcpu = vcpu;
 		pmu->fixed_counters[i].idx = i + INTEL_PMC_IDX_FIXED;
 		pmu->fixed_counters[i].current_config = 0;
+		pmu->fixed_counters[i].eventsel = intel_get_fixed_pmc_eventsel(i);
 	}
 
 	lbr_desc->records.nr = 0;
-- 
2.43.0.rc2.451.g8631bc7472-goog

