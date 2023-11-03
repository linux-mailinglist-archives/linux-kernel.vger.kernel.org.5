Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39067E0C02
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjKCXGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjKCXFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:05:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3AED64
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 16:05:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da0c6d62ec8so2984648276.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 16:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699052749; x=1699657549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=PIc07kH91+cPU8S0NDLhNr7u04OQXkw6B524JpAs8r4=;
        b=LIecUdMSlswrzia4Txqh2//zY8sAsGqtlQ4x4TypDl+bX2sS0H5zEoCSlMMZvkxEFb
         iMG/xdWze67S5ICqEUYDpaqrn4UeZa52hCRNHo/4n9JSYUCCqEuJ7iiDzyyGmmYsCkiB
         GNZjYxKI1l2ShDGRWevk3TZ4WCC9+YHngLlI2gKlXjE8LYdg3QIQgNWuUmu/G29mB3JD
         6Kpk9yrUhndlSec3XuQpbhFPs7oOq5t2lzgB2KBgzK8OJ3iHuYNUJ94VjoBa0R/u6qSx
         OR97+ELUC6bwMeSMz9Zo2d9PRPIsiGv58J9Qk02MUWiLtVMD8+w3WVJ85UybPo5MRDcn
         AdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699052749; x=1699657549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PIc07kH91+cPU8S0NDLhNr7u04OQXkw6B524JpAs8r4=;
        b=AyoLUg7DzrRYcw2sdSsEFQMHd2MWv3RV/DGuRwm26FCuYuD7wrVeOMxQ5u33KusTi3
         D921qUK++gcFsDSHiOH0/+DxAoFFljbTDTwJN53dz/m28S+YqSo+aRYBxeR7OcMhJbo+
         iuSAJ534dTTmbXRIlT1EoPhInD1b0/pCIOaQ5j+k9AYNNIsjGkoqUEwdowQBbg4V0rh3
         McET/pR+eBc9NfHJ456d6QLeEFb4jlxFCMvfbKFOQy+qZZnVF3eg6Hcmfjz1JZyzez0S
         d/ZiAFNuIQEEGeiMTVMO59m09P0zmbkE98sl9KIbYGMc3Us5hH4y+7cCP4cQDwuzcIaq
         IcOQ==
X-Gm-Message-State: AOJu0YwJ0qZBhBFCpRRpMDMrIrFY0eW0lMHmw1WKE0MVk141jH3JGURi
        9gOcxy1yA61Dxsb6a9Oo7nlDolXgE6w=
X-Google-Smtp-Source: AGHT+IGQH3rOOCQXNPi400rdIixp/HhKqhN6bqEr4nOXrmGJC/CyNts/C5TL6ESngadKiAbSBsjqTJSWLWc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:2083:0:b0:da0:c584:def4 with SMTP id
 g125-20020a252083000000b00da0c584def4mr428586ybg.1.1699052749410; Fri, 03 Nov
 2023 16:05:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Nov 2023 16:05:38 -0700
In-Reply-To: <20231103230541.352265-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231103230541.352265-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231103230541.352265-4-seanjc@google.com>
Subject: [PATCH v2 3/6] KVM: x86/pmu: Stop calling kvm_pmu_reset() at RESET
 (it's redundant)
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop kvm_vcpu_reset()'s call to kvm_pmu_reset(), the call is performed
only for RESET, which is really just the same thing as vCPU creation,
and kvm_arch_vcpu_create() *just* called kvm_pmu_init(), i.e. there can't
possibly be any work to do.

Unlike Intel, AMD's amd_pmu_refresh() does fill all_valid_pmc_idx even if
guest CPUID is empty, but everything that is at all dynamic is guaranteed
to be '0'/NULL, e.g. it should be impossible for KVM to have already
created a perf event.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 2 +-
 arch/x86/kvm/pmu.h | 1 -
 arch/x86/kvm/x86.c | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index dc8e8e907cfb..458e836c6efe 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -657,7 +657,7 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return 0;
 }
 
-void kvm_pmu_reset(struct kvm_vcpu *vcpu)
+static void kvm_pmu_reset(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index a46aa9b25150..db9a12c0a2ef 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -243,7 +243,6 @@ bool kvm_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr);
 int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
 int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
 void kvm_pmu_refresh(struct kvm_vcpu *vcpu);
-void kvm_pmu_reset(struct kvm_vcpu *vcpu);
 void kvm_pmu_init(struct kvm_vcpu *vcpu);
 void kvm_pmu_cleanup(struct kvm_vcpu *vcpu);
 void kvm_pmu_destroy(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2c924075f6f1..efbf52a9dc83 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12207,7 +12207,6 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	}
 
 	if (!init_event) {
-		kvm_pmu_reset(vcpu);
 		vcpu->arch.smbase = 0x30000;
 
 		vcpu->arch.msr_misc_features_enables = 0;
-- 
2.42.0.869.gea05f2083d-goog

