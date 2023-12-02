Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C7A80187E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442062AbjLBAFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbjLBAEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:04:42 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DA319A6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:04:38 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1d0663326f2so7803585ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 16:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701475477; x=1702080277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zt7ybhq5WnclmZFElyWqnJvdy+r8HXRtRnLKc3xf2JI=;
        b=AhvfMxZJDmQitaZHepYxHihsF6EdYpAvt2Nvgb2OLo6PrLmdeZtq/1sb97NXf/FESO
         lyMQwMgHMTz4WbTl6A2PjFtozqlZ6KAWggccn26qz67pPwaof2UtUZCJSsByHvAH0uAN
         Yk/iEME2RHRSt0IWLfQUppjB/Dx5+LiGnm6tX2DdJog7GmkxDx60cb/grZ793ELba/a9
         InZ3invBneXkVEAp+vT0+r1K/d1lCBlWCjNy5U6Kmr8/jhtAFvCoRdzParE5wu9uv0aj
         KBD9rRHlAx5fadc7iAHPMcIPVKv7KLCDiSTyWxWA4oWReUpGM1t3y65EdX6eADdSCdCt
         BBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701475477; x=1702080277;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zt7ybhq5WnclmZFElyWqnJvdy+r8HXRtRnLKc3xf2JI=;
        b=gcHPxwIrnIhgaTenfnk6rSSM91Ylx+w1HoBjblcg6yKh9niUj9QTLn1v4sksVb6Scc
         OzZosicztoZODNcQGFxtfHPUlyFiggfvE8i6IPSiAdr9skgcToZHwUAgTtwKL94KoxId
         P+iV3CIftlA6NhQHawJvl3feJkX+K3gqmdxtH5X+0d5LIhZwD5LwXfRCCBQGteMr8KHJ
         QY9digviHF6zRAQepFhTkZahOHSbckvtVnwwKpTifrXUMvIvok0gurf15uicT+4sXK5T
         w67slLOHrAhzuqf+f/7KtwW0jTmMJBKwZKsGLX8arlOIJDRzskkFm33C91Id65flr6LD
         uKig==
X-Gm-Message-State: AOJu0YyVkvrQ1qYrWiRaIjp9PE0fH9RUtiZsOJRie6TvvGR3gf5w69sO
        2SOJoIdujUNs/It6AXTkU3yx9cZM++U=
X-Google-Smtp-Source: AGHT+IHrmOuj3xZAMVZQrh4ZLSKSf2huKkh1Ee3VCjD2CsjPfbnpVQm/QQ8sa80ygAOTJsh0LozVxYb79/w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c412:b0:1cf:abb3:eb36 with SMTP id
 k18-20020a170902c41200b001cfabb3eb36mr5664286plk.8.1701475477554; Fri, 01 Dec
 2023 16:04:37 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  1 Dec 2023 16:03:58 -0800
In-Reply-To: <20231202000417.922113-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231202000417.922113-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231202000417.922113-10-seanjc@google.com>
Subject: [PATCH v9 09/28] KVM: x86/pmu: Disallow "fast" RDPMC for
 architectural Intel PMUs
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
Content-Transfer-Encoding: quoted-printable
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

Inject #GP on RDPMC if the "fast" flag is set for architectural Intel
PMUs, i.e. if the PMU version is non-zero.  Per Intel's SDM, and confirmed
on bare metal, the "fast" flag is supported only for non-architectural
PMUs, and is reserved for architectural PMUs.

  If the processor does not support architectural performance monitoring
  (CPUID.0AH:EAX[7:0]=3D0), ECX[30:0] specifies the index of the PMC to be
  read. Setting ECX[31] selects =E2=80=9Cfast=E2=80=9D read mode if support=
ed. In this mode,
  RDPMC returns bits 31:0 of the PMC in EAX while clearing EDX to zero.

  If the processor does support architectural performance monitoring
  (CPUID.0AH:EAX[7:0] =E2=89=A0 0), ECX[31:16] specifies type of PMC while =
ECX[15:0]
  specifies the index of the PMC to be read within that type. The following
  PMC types are currently defined:
  =E2=80=94 General-purpose counters use type 0. The index x (to read IA32_=
PMCx)
    must be less than the value enumerated by CPUID.0AH.EAX[15:8] (thus
    ECX[15:8] must be zero).
  =E2=80=94 Fixed-function counters use type 4000H. The index x (to read
    IA32_FIXED_CTRx) can be used if either CPUID.0AH.EDX[4:0] > x or
    CPUID.0AH.ECX[x] =3D 1 (thus ECX[15:5] must be 0).
  =E2=80=94 Performance metrics use type 2000H. This type can be used only =
if
    IA32_PERF_CAPABILITIES.PERF_METRICS_AVAILABLE[bit 15]=3D1. For this typ=
e,
    the index in ECX[15:0] is implementation specific.

Opportunistically WARN if KVM ever actually tries to complete RDPMC for a
non-architectural PMU, and drop the non-existent "support" for fast RDPMC,
as KVM doesn't support such PMUs, i.e. kvm_pmu_rdpmc() should reject the
RDPMC before getting to the Intel code.

Fixes: f5132b01386b ("KVM: Expose a version 2 architectural PMU to a guests=
")
Fixes: 67f4d4288c35 ("KVM: x86: rdpmc emulation checks the counter incorrec=
tly")
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 6903dd9b71ad..644de27bd48a 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -22,7 +22,6 @@
=20
 /* Perf's "BASE" is wildly misleading, this is a single-bit flag, not a ba=
se. */
 #define INTEL_RDPMC_FIXED	INTEL_PMC_FIXED_RDPMC_BASE
-#define INTEL_RDPMC_FAST	BIT(31)
=20
 #define MSR_PMC_FULL_WIDTH_BIT      (MSR_IA32_PMC0 - MSR_IA32_PERFCTR0)
=20
@@ -67,10 +66,25 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kv=
m_vcpu *vcpu,
 	struct kvm_pmc *counters;
 	unsigned int num_counters;
=20
-	if (idx & INTEL_RDPMC_FAST)
-		*mask &=3D GENMASK_ULL(31, 0);
+	/*
+	 * The encoding of ECX for RDPMC is different for architectural versus
+	 * non-architecturals PMUs (PMUs with version '0').  For architectural
+	 * PMUs, bits 31:16 specify the PMC type and bits 15:0 specify the PMC
+	 * index.  For non-architectural PMUs, bit 31 is a "fast" flag, and
+	 * bits 30:0 specify the PMC index.
+	 *
+	 * Yell and reject attempts to read PMCs for a non-architectural PMU,
+	 * as KVM doesn't support such PMUs.
+	 */
+	if (WARN_ON_ONCE(!pmu->version))
+		return NULL;
=20
-	idx &=3D ~(INTEL_RDPMC_FIXED | INTEL_RDPMC_FAST);
+	/*
+	 * Fixed PMCs are supported on all architectural PMUs.  Note, KVM only
+	 * emulates fixed PMCs for PMU v2+, but the flag itself is still valid,
+	 * i.e. let RDPMC fail due to accessing a non-existent counter.
+	 */
+	idx &=3D ~INTEL_RDPMC_FIXED;
 	if (fixed) {
 		counters =3D pmu->fixed_counters;
 		num_counters =3D pmu->nr_arch_fixed_counters;
--=20
2.43.0.rc2.451.g8631bc7472-goog

