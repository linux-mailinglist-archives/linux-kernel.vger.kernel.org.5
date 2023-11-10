Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056087E771A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345693AbjKJCNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345727AbjKJCNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:13:25 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A9F4695
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:13:21 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da0ccfc4fc8so1990189276.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699582400; x=1700187200; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uDpdyO5wteS2tCSVyIlZrwaNpirFZhycmLzD5CPKCCU=;
        b=qMXxfJ+lsiB4l4A6RJSu+pNo1t2eDnu+4Q0SzDS+F0wa9rlxvewJnWKHjFR7UFSytk
         gvEINr9Pv93m6yKwpovM5aozYPHV4U+vQ1TTG+c7ia0CPLk1f6PtQIGOoLh10RKOP6QW
         93jrx1wEFskG1U4eGSZWRCgD6QLJRVSzGSJ+bpQPP0OiHtWrq/7A2yA3P5ZJ0ka4mX+z
         rIhXOJcGzK+p9NNa7DeaW6SFcY57s2arI8xVvEBtIM9jokiTqBxM8is8tumSBbr1M60d
         LiuMsurxLIdr6CFcf9cvfvRlGS0dy0j/VoA69wyWxoza57XoAtMi5tos5t64q+LvMvcu
         VrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699582400; x=1700187200;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDpdyO5wteS2tCSVyIlZrwaNpirFZhycmLzD5CPKCCU=;
        b=KwHc0gEu5irCqH6Jx9IJicZWXSHdOua1L7thR6lLMzlEueFx0OOk6ZhM88CwgJ9et7
         ctiFOKu66Hm04B3uWxjDd64ADRoHV7BP9QVqZbUUaRKT+JANHSh/CZEpGFmDA9/AQLWB
         WzUJAPvMNAeCit2hoWk0/wwYU451a1UBlbcYVZrZ+LWdPGs0cjPkgS/vrJKZVGkExYcu
         LYXnZYA17uuRjLqBJBtynjUs6E9FTSOQx0sBrkLlCfgImtLwm6Jlv2uf/WIFg57blvFi
         6+0RCRFMBM6XQtD/t5LgZPyeoKBTtVPBnepjF+kQSFfCYLaBn47r+74uBIijnTzqveKs
         Pcjg==
X-Gm-Message-State: AOJu0YwZM1hZROsnMZGcY7Fzs1ZEAdg/PIr/V7TmSFtYg0Sug8dAp6L0
        6H7oWbkYM6yzbnhyeckuszO7+zd9z0I=
X-Google-Smtp-Source: AGHT+IE3hk2jW8uXQ54DbsLBHV3dm9I6uV2tMVC4BMKqHVvW/L2kF+m40xmeCrC9CkE/0s3M7H5X8gXIZ1Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:c083:0:b0:da3:7486:bc4b with SMTP id
 c125-20020a25c083000000b00da37486bc4bmr185729ybf.3.1699582400454; Thu, 09 Nov
 2023 18:13:20 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  9 Nov 2023 18:12:44 -0800
In-Reply-To: <20231110021306.1269082-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110021306.1269082-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110021306.1269082-5-seanjc@google.com>
Subject: [PATCH v8 04/26] KVM: x86/pmu: Setup fixed counters' eventsel during
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
index c4f2c6a268e7..c9df139efc0c 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -409,27 +409,21 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
@@ -495,7 +489,6 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 						  kvm_pmu_cap.bit_width_fixed);
 		pmu->counter_bitmask[KVM_PMC_FIXED] =
 			((u64)1 << edx.split.bit_width_fixed) - 1;
-		setup_fixed_pmc_eventsel(pmu);
 	}
 
 	for (i = 0; i < pmu->nr_arch_fixed_counters; i++)
@@ -573,6 +566,7 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
 		pmu->fixed_counters[i].vcpu = vcpu;
 		pmu->fixed_counters[i].idx = i + INTEL_PMC_IDX_FIXED;
 		pmu->fixed_counters[i].current_config = 0;
+		pmu->fixed_counters[i].eventsel = intel_get_fixed_pmc_eventsel(i);
 	}
 
 	lbr_desc->records.nr = 0;
-- 
2.42.0.869.gea05f2083d-goog

