Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2377E771E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345765AbjKJCNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345750AbjKJCNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:13:30 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D910246B0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:13:24 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6bd5730bef9so1600784b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699582404; x=1700187204; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2PzRa92RKIbv75Ni9RyZiiDqwO+fW7tfrLRiix/ZeFk=;
        b=bXDhMts0VFGhCFMxQcwTJVIpNNRQB12quF39HGoUaMnmJmBF0/zLs4fGEaw0vXQwQ8
         srxHHbZo1ALBhjPibLVsZYibRdWluMyosvRKnaFTWVAtGd0JCtYNz5ETg+gid6qwuq/W
         1fBTkAheO5sp0JakE8iE2utTx5uWe0nTeAj9b/cDAdbKYijTHIsl7bZCuyRN8ghONMXq
         89dexPCJVqATkG9NA8QjTvLvBKDgvSvOzCRRJqzPIB8RoRjmYc9fLaAOheKHIcz5Pkro
         RvW4j08WGNOnaIcJkcshTPxNTJ4c7nxXV/xThqWoQj0Pb68oL3bs14hJ/zVrWpP384PL
         SMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699582404; x=1700187204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2PzRa92RKIbv75Ni9RyZiiDqwO+fW7tfrLRiix/ZeFk=;
        b=hzOgQlFBk/Q3gdloRGHkZDKmmNfwGrLZ5s12lZ7RujyE84LKAAKIbOpIxD/2g5SqHu
         FV/3GaXbs9UnG3h4QhVDe6cCpj+MHcREXir3FyKxB2Gl1IOrQmQXd9IDWflhNqDQQcOb
         gyQJgGpWolt8TOipajxVE9GeS1HRH6Cq0Ut8OlZgZa8SPw3IA2v0kndPy/o2+TiRxOLs
         Y5HXN2kbpZqA+h2dWgqbkuJIfUan4kNtrZZ1CWe07GgjwwwcjMXnHE3pttgP2qxY3wVM
         U2WoM3E/AVeLUROBh2j+IItBNXjX9EG5HcvvwSEVDKO92LfvWuOyaQKTzALYSwBTozwr
         MGaA==
X-Gm-Message-State: AOJu0YxwzbcdM5PNdfo1TqQzM39M5ATVLYhLYdjtbYrRnfdz1QMPMcqb
        28B84Gz1lcp2OKS+sR1CvQ+iOouvp4w=
X-Google-Smtp-Source: AGHT+IFjMVC/vL2pU3SSoINJ741BNz003DY1pTOT7iibCLJDeq38xp0tH0BXTrYYKRiMMFG+NllhGbbPf2o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:a09:b0:6c3:9efc:6747 with SMTP id
 p9-20020a056a000a0900b006c39efc6747mr428065pfh.3.1699582404364; Thu, 09 Nov
 2023 18:13:24 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  9 Nov 2023 18:12:46 -0800
In-Reply-To: <20231110021306.1269082-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110021306.1269082-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110021306.1269082-7-seanjc@google.com>
Subject: [PATCH v8 06/26] KVM: x86/pmu: Don't ignore bits 31:30 for RDPMC
 index on AMD
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

Stop stripping bits 31:30 prior to validating/consuming the RDPMC index on
AMD.  Per the APM's documentation of RDPMC, *values* greater than 27 are
reserved.  The behavior of upper bits being flags is firmly Intel-only.

Fixes: ca724305a2b0 ("KVM: x86/vPMU: Implement AMD vPMU code for KVM")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/pmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 5596fe816ea8..427ec055c8bb 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -77,8 +77,6 @@ static bool amd_is_valid_rdpmc_ecx(struct kvm_vcpu *vcpu, unsigned int idx)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 
-	idx &= ~(3u << 30);
-
 	return idx < pmu->nr_arch_gp_counters;
 }
 
@@ -86,7 +84,7 @@ static bool amd_is_valid_rdpmc_ecx(struct kvm_vcpu *vcpu, unsigned int idx)
 static struct kvm_pmc *amd_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
 	unsigned int idx, u64 *mask)
 {
-	return amd_pmc_idx_to_pmc(vcpu_to_pmu(vcpu), idx & ~(3u << 30));
+	return amd_pmc_idx_to_pmc(vcpu_to_pmu(vcpu), idx);
 }
 
 static struct kvm_pmc *amd_msr_idx_to_pmc(struct kvm_vcpu *vcpu, u32 msr)
-- 
2.42.0.869.gea05f2083d-goog

