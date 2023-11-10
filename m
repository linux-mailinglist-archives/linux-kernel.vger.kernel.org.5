Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D200C7E7715
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345709AbjKJCNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjKJCNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:13:17 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C116F4683
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:13:15 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5afe220cadeso22505017b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699582395; x=1700187195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nHi8MKAu3RoJG1H9OsREjBorzQIuSOD8CbIQ6CUD2qY=;
        b=KLNNiMIJUsEBuE+fkmyqU1zgGYo0EDskgFm22SyPA/VSW2593cPKpl8w+Bp+9WSJkm
         zgWENid06cehvL8T+Fcj/dqaZUb8quqsk1ue8GpYUx7SpaNP6HQYr8343fahXSr5Gpor
         pdHc8GD3TA4aJ8kSHpSScZh4dMBDLyaK0dKYEjNZP0N98xo5wcK98zzifpsjz7Sf07wE
         UpjXU6KkUIhIVH/cmk2pHufOgvs14n2Ys6py1LFeTc0jJ+ed3HlaGeAZGumZ653cvD38
         Fvu1f8DbZhrDbjjrNb7dviLUjhU4mAep7IAtOb9k435t/Out6CTMbzgNXpC84CvPTlKc
         cfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699582395; x=1700187195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHi8MKAu3RoJG1H9OsREjBorzQIuSOD8CbIQ6CUD2qY=;
        b=atpNTWHSuxocvgXEeeqmUQLmayYzGQsml0DGRtCU5CDQVWs6k9YcbwVKqsuxSQIjKe
         V3okDx+qivQWIUyTx5BlUajxXf60GMqVxLJyXLGgDKQqdYxjHaZDROmE1Lw2h1ndy8dp
         fAPqR2D8pjxKHTseMrUvICwBXUsIgeMZpq0h9bS9W9LesltrhSe2ylm5lQsXZggzTVWq
         Q8Og8ulk6nm3ly98kvXDS1eE6oxsEt9dfmGrxxuB95JByGP+i5ZyxVlPgYPV5N+BSPB6
         yXeLRhN8uC/f1Q/4uVwAvzjktfLWwnui688qs1lllIEjV/m6oE2VEc1RNOkFcGrqDdoY
         FsvA==
X-Gm-Message-State: AOJu0YzJHzYeJhx7G/yqld0pebGspAT2lpnS0u4rvnK1sKaLTgxFDqFa
        An1/fEgx5CpJZRqM6fcPbsdvggjyDX8=
X-Google-Smtp-Source: AGHT+IEqHpSHLS6wfLh4Hywd2nYqTqjMTkDeUfGccIcuJAYxOwUjJKm7Xp5jlxasJxrWYb9tJd+vSAJpjmQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d591:0:b0:579:f832:74b with SMTP id
 x139-20020a0dd591000000b00579f832074bmr200264ywd.10.1699582394899; Thu, 09
 Nov 2023 18:13:14 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  9 Nov 2023 18:12:41 -0800
In-Reply-To: <20231110021306.1269082-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110021306.1269082-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110021306.1269082-2-seanjc@google.com>
Subject: [PATCH v8 01/26] KVM: x86/pmu: Always treat Fixed counters as
 available when supported
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

Treat fixed counters as available when they are supported, i.e. don't
silently ignore an enabled fixed counter just because guest CPUID says the
associated general purpose architectural event is unavailable.

KVM originally treated fixed counters as always available, but that got
changed as part of a fix to avoid confusing REF_CPU_CYCLES, which does NOT
map to an architectural event, with the actual architectural event used
associated with bit 7, TOPDOWN_SLOTS.

The commit justified the change with:

    If the event is marked as unavailable in the Intel guest CPUID
    0AH.EBX leaf, we need to avoid any perf_event creation, whether
    it's a gp or fixed counter.

but that justification doesn't mesh with reality.  The Intel SDM uses
"architectural events" to refer to both general purpose events (the ones
with the reverse polarity mask in CPUID.0xA.EBX) and the events for fixed
counters, e.g. the SDM makes statements like:

  Each of the fixed-function PMC can count only one architectural
  performance event.

but the fact that fixed counter 2 (TSC reference cycles) doesn't have an
associated general purpose architectural makes trying to apply the mask
from CPUID.0xA.EBX impossible.

Furthermore, the lack of enumeration for an architectural event in CPUID
only means the CPU doesn't officially support the architectural encoding,
i.e. it doesn't mean using the architectural encoding _won't_ work, it
sipmly means there are no guarantees that it will work as expected.  E.g.
if KVM is running in a VM that advertises a fixed counters but not the
corresponding architectural event encoding, and perf decides to use a
general purpose counter instead of a fixed counter, odds are very good
that the underlying hardware actually does support the architectrual
encoding, and that programming the encoding will count the right thing.

In other words, asking perf to count the event will probably work, whereas
intentionally doing nothing is obviously guaranteed to fail.

Note, at the time of the change, KVM didn't enforce hardware support, i.e.
didn't prevent userspace from enumerating support in guest CPUID.0xA.EBX
for architectural events that aren't supported in hardware.  I.e. silently
dropping the fixed counter didn't somehow protection against counting the
wrong event, it just enforced guest CPUID.  And practically speaking, this
issue is almost certainly limited to running KVM on a funky virtual CPU
model.  No known real hardware has an asymmetric PMU where a fixed counter
is supported but the associated architectural event is not.

Fixes: a21864486f7e ("KVM: x86/pmu: Fix available_event_types check for REF_CPU_CYCLES event")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 820d3e1f6b4f..c6e227edcf8e 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -108,11 +108,24 @@ static bool intel_hw_event_available(struct kvm_pmc *pmc)
 	u8 unit_mask = (pmc->eventsel & ARCH_PERFMON_EVENTSEL_UMASK) >> 8;
 	int i;
 
+	/*
+	 * Fixed counters are always available if KVM reaches this point.  If a
+	 * fixed counter is unsupported in hardware or guest CPUID, KVM doesn't
+	 * allow the counter's corresponding MSR to be written.  KVM does use
+	 * architectural events to program fixed counters, as the interface to
+	 * perf doesn't allow requesting a specific fixed counter, e.g. perf
+	 * may (sadly) back a guest fixed PMC with a general purposed counter.
+	 * But if _hardware_ doesn't support the associated event, KVM simply
+	 * doesn't enumerate support for the fixed counter.
+	 */
+	if (pmc_is_fixed(pmc))
+		return true;
+
 	BUILD_BUG_ON(ARRAY_SIZE(intel_arch_events) != NR_INTEL_ARCH_EVENTS);
 
 	/*
 	 * Disallow events reported as unavailable in guest CPUID.  Note, this
-	 * doesn't apply to pseudo-architectural events.
+	 * doesn't apply to pseudo-architectural events (see above).
 	 */
 	for (i = 0; i < NR_REAL_INTEL_ARCH_EVENTS; i++) {
 		if (intel_arch_events[i].eventsel != event_select ||
-- 
2.42.0.869.gea05f2083d-goog

