Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6078480187D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442082AbjLBAFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441990AbjLBAEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:04:50 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6A31BCD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:04:40 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cfd4ef9f06so12115215ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 16:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701475479; x=1702080279; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kARN2t1cDT1nPhBBpb3LTJ5yo8qfPIAw+yo3QqNarOE=;
        b=AAY+Tv3HRsRRO7etlXqC0lCOCShST/GGftsFzjIet2J7cna2R5K4TW+Y61HpbcKnLf
         sSm13SLogQ3Wex8o9pMrXgfes8g8h3edtoWHygcq2Nw89h/Esp3vVCX9u6StgV8ZbOr/
         xp+dMlXlN3M8BeyHDnB8RWxkCPQuoTXhnXTMRCKeJi9/ypGqDa8hyDlGjhdfoLel7NFg
         rp5Ph59GGvzjmxvsfB+liF6LhCgqcC8c6VNCZxXV2svH8cHUTcplApVgnI+LW8RfTZY3
         cMyq/7FpSrVhNmePc9xljNXA/h2WYyj7sjS4BthD5+lum2rwrNFPqYl6AfXNAiZpvxP8
         03mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701475479; x=1702080279;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kARN2t1cDT1nPhBBpb3LTJ5yo8qfPIAw+yo3QqNarOE=;
        b=he9lrv1iDY4dZ8NEpwe3qS+QAmdp70PF/sn1OkzFaHatdX7a93r/a062rSYPBjYR5x
         +HnS6JdUZTOX87gXfqzRQRIeYnXDfBON5FtcWDcYYhYwueDglUzEbLWrnE5ARjfHS+w4
         sw38cZj6UuPY2IPjZrvX0kTydHtRrWE1ZobyJaVoXXmF4quOo9ls1fIfIPxs2DrDwVEs
         XKq/hJEAYyLilWJ0LAd7GPBJOUNS+N/PapBu4e55PhzmqyeeP44cccEOBUOZtQ22DuIS
         44aRMJBgkUK5NEipBIQUrz8eUQT5m1qCxxK/46Kto5+8BTjFDj5rogpedndbtyTFnXTt
         F+GA==
X-Gm-Message-State: AOJu0Yx9Y54kG817Gn5s/PSO2gUm3sdESTigXoXoVXzOYrwlGdMWwn82
        keubTc/5LCOg9cwP76+Bv3RiOkB8YL8=
X-Google-Smtp-Source: AGHT+IGkgfpbdPCK5UBd6AozaX6YxWcy/rifmqb9aNIZ5Kc3MKHGLaSP/2ib181qUSOmDWEVRIzpY9ZYZqs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:3291:b0:1cf:5cd7:8416 with SMTP id
 jh17-20020a170903329100b001cf5cd78416mr5059080plb.13.1701475479406; Fri, 01
 Dec 2023 16:04:39 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  1 Dec 2023 16:03:59 -0800
In-Reply-To: <20231202000417.922113-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231202000417.922113-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231202000417.922113-11-seanjc@google.com>
Subject: [PATCH v9 10/28] KVM: x86/pmu: Explicitly check for RDPMC of
 unsupported Intel PMC types
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

Explicitly check for attempts to read unsupported PMC types instead of
letting the bounds check fail.  Functionally, letting the check fail is
ok, but it's unnecessarily subtle and does a poor job of documenting the
architectural behavior that KVM is emulating.

Opportunistically add macros for the type vs. index to further document
what is going on.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 644de27bd48a..bd4f4bdf5419 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -23,6 +23,9 @@
 /* Perf's "BASE" is wildly misleading, this is a single-bit flag, not a base. */
 #define INTEL_RDPMC_FIXED	INTEL_PMC_FIXED_RDPMC_BASE
 
+#define INTEL_RDPMC_TYPE_MASK	GENMASK(31, 16)
+#define INTEL_RDPMC_INDEX_MASK	GENMASK(15, 0)
+
 #define MSR_PMC_FULL_WIDTH_BIT      (MSR_IA32_PMC0 - MSR_IA32_PERFCTR0)
 
 static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
@@ -82,9 +85,13 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
 	/*
 	 * Fixed PMCs are supported on all architectural PMUs.  Note, KVM only
 	 * emulates fixed PMCs for PMU v2+, but the flag itself is still valid,
-	 * i.e. let RDPMC fail due to accessing a non-existent counter.
+	 * i.e. let RDPMC fail due to accessing a non-existent counter.  Reject
+	 * attempts to read all other types, which are unknown/unsupported.
 	 */
-	idx &= ~INTEL_RDPMC_FIXED;
+	if (idx & INTEL_RDPMC_TYPE_MASK & ~INTEL_RDPMC_FIXED)
+		return NULL;
+
+	idx &= INTEL_RDPMC_INDEX_MASK;
 	if (fixed) {
 		counters = pmu->fixed_counters;
 		num_counters = pmu->nr_arch_fixed_counters;
-- 
2.43.0.rc2.451.g8631bc7472-goog

