Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66096801876
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441916AbjLBAEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441939AbjLBAEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:04:37 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1B8DD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:04:33 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d3aa625542so17208697b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 16:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701475472; x=1702080272; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MdN/fXe06mNI/rx7xpLhmxtX8yoQrkzTbIXLwt/4RE8=;
        b=L1h7Y1D7+jirALHlwpBx/C8UuKNR0EiPyYpBUkcuZBOENFFXt7jwGMTnZH0naccBf6
         p1g48ya97PKgoKcF2L4G70TDMx1beW5yKGPYIUwtBnmPKs4bbJE0lXAMKderZ4bVfCk+
         05IcD9lBhSiS2zmS2zHvYlCe/pO093Wry9/qCAZ85WFMNxP+Q+H7A9CkKkWZ1gMJVWnx
         HCGij+VmFvd3fldpdHHLXZG1H2t8m1PkcgAi95ADHmHOmdn1pEtR6yWycowWDWHeqDG8
         WdBbGvKcJZzmyqYZl/62m1x0ybsioTKPTPIypga6Lh1BN/sqBVoC10cNMeWRrwwwHZxh
         tYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701475472; x=1702080272;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MdN/fXe06mNI/rx7xpLhmxtX8yoQrkzTbIXLwt/4RE8=;
        b=uF9MRhht7x+gWoblZ+p3u5EJQ+ofXIKz5/2bRnLBtovJOvCLHuRvsu4AfvVVLvvH/5
         HbIuBwAcrCAMTEQfxcEBDM9o/WjpP4ZTWeVIF4bGnzwqgn/xfiSinzkGyD91tbol4kS7
         QtfQgK5Nk8Y83wO/KmrJLbhXIpGizLzSBqWlLaIAPcc2d+2/KjoxY1OZZUucpon+SQTu
         frYQQYiGjevBHVx/3UmCm9zzH766WgJpUUuj9YWT2ZXaonjpdlyyBzdnFFSE09oQ/E5i
         O0jLGX++WroOhrj++f4dnHDJBmopdRnbcY+gmOGOVtUNfZKw7s2OCMS4nUu4xhhY7w1v
         pwDQ==
X-Gm-Message-State: AOJu0YzKmNAHwR5WGe2/pvPWaW/9KGEAJY6azVW0IQhiExQIW6qWnOiY
        DrEuR4nfLhhADCS+uUJb0hFGWklZdFU=
X-Google-Smtp-Source: AGHT+IERz1rUps5EiMVy9w+tyG59EohoCR5CKWnINcLL7YhhxwxMailU70Dpdxt/Xg3oveOJFM69kOls0DI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:3692:b0:5d1:6732:25a0 with SMTP id
 fu18-20020a05690c369200b005d1673225a0mr674144ywb.4.1701475472351; Fri, 01 Dec
 2023 16:04:32 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  1 Dec 2023 16:03:55 -0800
In-Reply-To: <20231202000417.922113-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231202000417.922113-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231202000417.922113-7-seanjc@google.com>
Subject: [PATCH v9 06/28] KVM: x86/pmu: Don't ignore bits 31:30 for RDPMC
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 1475d47c821c..1fafc46f61c9 100644
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
2.43.0.rc2.451.g8631bc7472-goog

