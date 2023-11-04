Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4152C7E0C8D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 01:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjKDACs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 20:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjKDACq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 20:02:46 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A1FD52
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 17:02:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a839b31a0dso53877677b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 17:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699056162; x=1699660962; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nOzsUN1YNjo4mM3u1hilIKuxhzw1b/cPpyuR5vqvOEM=;
        b=CFMT/kaORlS2yU0gvAAAxQ1jOYqJYKqa+q1KZd9Zwuc+usFP6yHgxaoOBKETtlFsHv
         jHBAR8F7UnDz5/UBgKXgSZE84V7ckfz8L9jy+oCz+lPi+I36q8t/TEPLd4DfM78CMBED
         p8cd016sLD1tRfZhMOPhlHcPA3NAIY53MEk1kpzXdHjCkDHUdw/p6zociJAplcCG0JL6
         5St3VZgwKFNnCnP9LEg523MvY0ckM1/Df3ELVoBjagBf33fjUSNOIyRfiNBMCHK/UlhA
         zqtzlxYHY6MY7US7zMVNGPip7G1VSzuMG90d9AqUq7d7kz1FF+fs1qTu9iFX6a3R49WZ
         ZmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699056162; x=1699660962;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nOzsUN1YNjo4mM3u1hilIKuxhzw1b/cPpyuR5vqvOEM=;
        b=EWUM0NTOFz2hWFtr4XFuy1F0X7uR7tH1ubnWbHfW/J+Oz9M6NYly+WkPOSwARVJYIT
         YR+qhnPYLExOFXgIQhb9H5QH4TLut5izAFNdU0QXMgqvUO6Suk2aJ7P3T38D2ZGRU13t
         F5L8ub5hzExGo7phDt6/VRIonP/UzI7rP1LopGkKQcWzwQ7sITBTf9IqhlB4+gxMat5t
         ySr4+RybF88NsClZsNYnuah0hGXGvOon8m17ZQGtWP23yS8sf/SyIhubXMdEOzSDIb4a
         ni50M3fVrNTLiAuInu3tmD5DrFP8pV1wriZvllmsXbqpOJIbm8wtkXwyOmOx3U7viMOz
         bN/A==
X-Gm-Message-State: AOJu0Yx3hlrl8wiWJmnRnTYTo9hFizAuC6sDVKpk3Ejxx52weQKf2Sm1
        ZOY2cMW8xXTf4IfaMOnUGlZI5qTDPmg=
X-Google-Smtp-Source: AGHT+IGAbN0m5ShzVxvluMl0W5kCIQjTup2IT2nxWsIkQodtNZB6+MZQkaVB8Sf70LHX1BZEnLV0C+dyiLg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:df52:0:b0:5a7:b9b0:d23f with SMTP id
 i79-20020a0ddf52000000b005a7b9b0d23fmr83931ywe.6.1699056162701; Fri, 03 Nov
 2023 17:02:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Nov 2023 17:02:19 -0700
In-Reply-To: <20231104000239.367005-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231104000239.367005-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231104000239.367005-2-seanjc@google.com>
Subject: [PATCH v6 01/20] KVM: x86/pmu: Don't allow exposing unsupported
 architectural events
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Like Xu <likexu@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Aaron Lewis <aaronlewis@google.com>
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

Hide architectural events that unsupported according to guest CPUID *or*
hardware, i.e. don't let userspace advertise and potentially program
unsupported architectural events.

Note, KVM already limits the length of the reverse polarity field, only
the mask itself is missing.

Fixes: f5132b01386b ("KVM: Expose a version 2 architectural PMU to a guests")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 820d3e1f6b4f..1b13a472e3f2 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -533,7 +533,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->counter_bitmask[KVM_PMC_GP] = ((u64)1 << eax.split.bit_width) - 1;
 	eax.split.mask_length = min_t(int, eax.split.mask_length,
 				      kvm_pmu_cap.events_mask_len);
-	pmu->available_event_types = ~entry->ebx &
+	pmu->available_event_types = ~(entry->ebx | kvm_pmu_cap.events_mask) &
 					((1ull << eax.split.mask_length) - 1);
 
 	if (pmu->version == 1) {
-- 
2.42.0.869.gea05f2083d-goog

