Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605367E7724
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345745AbjKJCOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbjKJCNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:13:38 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B5F4792
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:13:29 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da03390793fso1867243276.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699582408; x=1700187208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldSAXTrx3gBNdQtyHk8R9u0SycFGAN1pYwkpn+U3utc=;
        b=lBSeli7urhZy6BiD1UbgqGnxNcERes0jpEb1p9lWjYSiyCSDxqmYNdtP9bswUfVUK8
         YwvJ59pjTfbewn9I//eA64nagWokOkg4rsAdSn224zDA5F3k3mmswlrswRy9QP7YkIU6
         0jAMWrWcqfxw3gTIML3m56fm/h3klB9Y3LAe9CQU79PcHKgTE8E0cC1VxNIxOjLchrN1
         Fv24/JL8/Jegu8pWLJvprsrQnf/zDkAJ1UmyxLck+LyiNrleVE02q9RzUD29+HReUlrd
         YWo0PyUSP8WDzMTOk8t10G8d87gIo9ExcyPyuwAwjx9fLIHj0SvDXbraPSUeO9G9763q
         JTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699582408; x=1700187208;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ldSAXTrx3gBNdQtyHk8R9u0SycFGAN1pYwkpn+U3utc=;
        b=Y1DxQ/5EYvoTZ90tGCAhmYwZ6zf4tGLSzg+dOpt+T1zC8EBrP+sCOuLfoO95LnG3T9
         zD57aoZB9kwnqs0HnJZz3EptQDAhVVYnUBrTzQ3PLhLB4S8JePcx1FLn0umn3hI+vs7i
         YoE6thyF0MemdORn+Nmev9m+cLBtt8HCDJq0N0IpxmyoNLVHc9raOG27QPGmifUmdXyq
         p1ei5uogjayvlGVZA887B19HZ3D5pNffpr+a0Onp3v5F3ei7RXHJJ7T2j69ZHBazN6g2
         3P0bgqaz0dJKv3KyySb2jCb0e/pLMbOCUQcQ19xz7HLO856UVh5oovvS869EX3YuMWGc
         a9fA==
X-Gm-Message-State: AOJu0YwWd5X/JL03hTw2Q40TO9/XKvDEt00rCc/V920xmevjmIT9pGXr
        4koEgIu7BTBrX6eRTGCVQQuqROq+WTI=
X-Google-Smtp-Source: AGHT+IEtxnMEV/Ty09TRmID9wO7zNn7AmI/VlDwhVAs0BQnKt5gZLxSwnydcK49mDS3NN7ScG4TL8UWO87E=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:df45:0:b0:d9a:5b63:a682 with SMTP id
 w66-20020a25df45000000b00d9a5b63a682mr183492ybg.13.1699582408349; Thu, 09 Nov
 2023 18:13:28 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  9 Nov 2023 18:12:48 -0800
In-Reply-To: <20231110021306.1269082-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110021306.1269082-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110021306.1269082-9-seanjc@google.com>
Subject: [PATCH v8 08/26] KVM: x86/pmu: Disallow "fast" RDPMC for
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

WARN if KVM ever actually tries to complete RDPMC for a non-architectural
PMU as KVM doesn't support such PMUs, i.e. kvm_pmu_rdpmc() should reject
the RDPMC before getting to the Intel code.

Fixes: f5132b01386b ("KVM: Expose a version 2 architectural PMU to a guests=
")
Fixes: 67f4d4288c35 ("KVM: x86: rdpmc emulation checks the counter incorrec=
tly")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index c6ea128ea7c8..80255f86072e 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -61,7 +61,19 @@ static struct kvm_pmc *intel_pmc_idx_to_pmc(struct kvm_p=
mu *pmu, int pmc_idx)
=20
 static u32 intel_rdpmc_get_masked_idx(struct kvm_pmu *pmu, u32 idx)
 {
-	return idx & ~(INTEL_RDPMC_FIXED | INTEL_RDPMC_FAST);
+	/*
+	 * Fast RDPMC is only supported on non-architectural PMUs, which KVM
+	 * doesn't support.
+	 */
+	if (WARN_ON_ONCE(!pmu->version))
+		return idx & ~INTEL_RDPMC_FAST;
+
+	/*
+	 * Fixed PMCs are supported on all architectural PMUs.  Note, KVM only
+	 * emulates fixed PMCs for PMU v2+, but the flag itself is still valid,
+	 * i.e. let RDPMC fail due to accessing a non-existent counter.
+	 */
+	return idx & ~INTEL_RDPMC_FIXED;
 }
=20
 static bool intel_is_valid_rdpmc_ecx(struct kvm_vcpu *vcpu, unsigned int i=
dx)
--=20
2.42.0.869.gea05f2083d-goog

