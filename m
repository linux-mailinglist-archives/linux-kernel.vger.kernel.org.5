Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274D27E0C95
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 01:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjKDADI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 20:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjKDAC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 20:02:58 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72F9D4C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 17:02:54 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc23f2226bso20397355ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 17:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699056174; x=1699660974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5i9f3RYw+3rq1epr4QQj/W0ALWCCMiQAE1rG5bd7znE=;
        b=LBDed+xncv04uLfvYR92fVlIknYGjtt4+rLKhCClBBmCsqur31PsyPcV4yXUjg5SCq
         PnhVKCUtMJ3bFrSbdR9WwOFsfxiJPW/v46AZvbQot33n4fYscEBaM/5KvAUsb91K/CeW
         7Hy3IbPgyR3QkeLeL1AP0zByPNMuiy6lkGJce6m80BIIK4MQaRITWrOeoKJjQi2HlNnG
         mK7JuiRrfn7o4IFkjk3SKaTGMzqrBcE9cfaFdES9PMrtUqLMIktm4fdJs5f2QiWq46UE
         F8XcEjK2mhRmHGJsiSAN4sL+3PvPWhYyQHxtGfcaIwzhO8LXK0jM9l5rrk52PhUYPhIF
         b8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699056174; x=1699660974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5i9f3RYw+3rq1epr4QQj/W0ALWCCMiQAE1rG5bd7znE=;
        b=H3ZkOc0vApfu7tAYzf1Zfmp9iGLCpoLhozdZhzYRzYDsHkyt0nnGiwnxyLyApWcaiT
         K7AqEfECjP1AaAkGjsWjqKCKOYtTrqbfCL+c47Dp4+0B0EzGVeF0L1FXwIPqDZvcfmyn
         GNwCANPjJxYLNbTMYzcumdqEV3uWf69VtX7SMOb+BzMrUXEsDn+GzRfLRTUhsADV/+K+
         QpsDzuz4kbXMu0WiD1pPkAp9ie3Ff2BpivoADYZ9AeXOFlAGR9YKsVzZ1DpPFabcVhWv
         HUVV//vVSY97ay0nKBA0VHC1suFG01Mluz3VoeUFJdwxw0olmphI9DTDv7YsbbyxpnzA
         hcmw==
X-Gm-Message-State: AOJu0YyLJ2RCDF/pOKmXWzkxYNlU+O5u0O2oVE08QO0z6FeN+0e0f3g7
        s5mM5K+LqSNQLeC9aejN1aH886CpjFI=
X-Google-Smtp-Source: AGHT+IE1eWH7pXBbLchwQEff990m3l+n8cZsTNJyIs2lE9v5Z9AluM1XnWKc74yLZ7JL/oXNCsem7ErGVKE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2609:b0:1b8:8c7:31e6 with SMTP id
 jd9-20020a170903260900b001b808c731e6mr430898plb.1.1699056174214; Fri, 03 Nov
 2023 17:02:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Nov 2023 17:02:25 -0700
In-Reply-To: <20231104000239.367005-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231104000239.367005-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231104000239.367005-8-seanjc@google.com>
Subject: [PATCH v6 07/20] KVM: selftests: Drop the "name" param from KVM_X86_PMU_FEATURE()
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the "name" parameter from KVM_X86_PMU_FEATURE(), it's unused and
the name is redundant with the macro, i.e. it's truly useless.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index a01931f7d954..2d9771151dd9 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -289,7 +289,7 @@ struct kvm_x86_cpu_property {
 struct kvm_x86_pmu_feature {
 	struct kvm_x86_cpu_feature anti_feature;
 };
-#define	KVM_X86_PMU_FEATURE(name, __bit)					\
+#define	KVM_X86_PMU_FEATURE(__bit)						\
 ({										\
 	struct kvm_x86_pmu_feature feature = {					\
 		.anti_feature = KVM_X86_CPU_FEATURE(0xa, 0, EBX, __bit),	\
@@ -298,7 +298,7 @@ struct kvm_x86_pmu_feature {
 	feature;								\
 })
 
-#define X86_PMU_FEATURE_BRANCH_INSNS_RETIRED	KVM_X86_PMU_FEATURE(BRANCH_INSNS_RETIRED, 5)
+#define X86_PMU_FEATURE_BRANCH_INSNS_RETIRED	KVM_X86_PMU_FEATURE(5)
 
 static inline unsigned int x86_family(unsigned int eax)
 {
-- 
2.42.0.869.gea05f2083d-goog

