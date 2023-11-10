Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BB67E7778
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345889AbjKJC3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345753AbjKJC3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:29:18 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E51546B1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:29:13 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6b31cb3cc7eso1613580b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699583353; x=1700188153; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oUplQH4QKJNeOGVBIGmyoAKP+5jCzgTgFjMw0NNsbV8=;
        b=bxd9OyhRQfuVpkEeKnGJO9SydgcnMgzqO0QovgXETG/z0aCw3KhdoLNYUMUiwxCx3Z
         mho76pDdNhzA1TR0VsXvgZ7Lsg5+4z+ZGkwt5cXC3vIJWXb2FjhRlcpByRsx7dIMexEr
         45hD/HNiouVhXQ1YdZkzonuwFZ9mM0tTvpnh1aD7wJZmxRWpsi+92dv36pQl/LASUU6i
         +5zC+9EispEhTtKs7C0mtKaLnWVaw8bjBV4C7MakHq7i6tBhSGLygXiAYoT5WryMck0J
         xaTtnXPsngXix9N/bvseKFhdG3puqm/nRWFeXll13Xy0qKY8ZFXxkm2VbzX9ZJwPabZZ
         BDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699583353; x=1700188153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUplQH4QKJNeOGVBIGmyoAKP+5jCzgTgFjMw0NNsbV8=;
        b=FLqX/jxf8EeEcxn+iEGkwdOC9szVG9mnCAbiF+TkLu+X5k6q3F8Dqbleq/y6SbdX/B
         c04FVug9MDBLUJjSJgTUIh3yK9QV3V4WYWUQUxAjTmrsfEHTQdClP6SBTP92Nlp176cE
         uoDvJJ+ZCpTMbgLJAPb3lT+AmPT6zbUFXN65RPVXMLv0ayG9foBDj8WEcu/FM0lgfbCK
         SCiKPstSyLbPh/k8q2mBubWtaa5NdrRTKuv+/SkqoY0NiCqvxxy0RhiTyTAQz4P7pwQ+
         HoiTzgQu7lA3pyyEef4qt6i/IV6RdD1iOhzNE7CYzS/LMk5UCiAlW/fUq1+w2XJpjlOu
         vJ6A==
X-Gm-Message-State: AOJu0YwbKTDNIjuPJUN7OWr5wy6H+NF+/Lz/UVvuSSlL2g0vx0YmyDwU
        40C/ABKFCX/OClg5rpAOTOsIioSYc4Y=
X-Google-Smtp-Source: AGHT+IEucuu8/wKbjkKW4lLWW91QLJUJ5SOAPQg86CMbuYGjka0qEOMY6aBvXFhk7y3bJLf4TgCoQArYkak=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:850a:b0:690:29c0:ef51 with SMTP id
 ha10-20020a056a00850a00b0069029c0ef51mr307317pfb.1.1699583352940; Thu, 09 Nov
 2023 18:29:12 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  9 Nov 2023 18:28:53 -0800
In-Reply-To: <20231110022857.1273836-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110022857.1273836-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110022857.1273836-7-seanjc@google.com>
Subject: [PATCH 06/10] KVM: x86/pmu: Process only enabled PMCs when emulating
 events in software
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mask off disabled counters based on PERF_GLOBAL_CTRL *before* iterating
over PMCs to emulate (branch) instruction required events in software.  In
the common case where the guest isn't utilizing the PMU, pre-checking for
enabled counters turns a relatively expensive search into a few AND uops
and a Jcc.

Sadly, PMUs without PERF_GLOBAL_CTRL, e.g. most existing AMD CPUs, are out
of luck as there is no way to check that a PMC isn't being used without
checking the PMC's event selector.

Cc: Konstantin Khorenko <khorenko@virtuozzo.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 0e2175170038..488d21024a92 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -837,11 +837,20 @@ static inline bool cpl_is_matched(struct kvm_pmc *pmc)
 
 void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 perf_hw_id)
 {
+	DECLARE_BITMAP(bitmap, X86_PMC_IDX_MAX);
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
 	int i;
 
-	kvm_for_each_pmc(pmu, pmc, i, pmu->all_valid_pmc_idx) {
+	BUILD_BUG_ON(sizeof(pmu->global_ctrl) * BITS_PER_BYTE != X86_PMC_IDX_MAX);
+
+	if (!kvm_pmu_has_perf_global_ctrl(pmu))
+		bitmap_copy(bitmap, pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX);
+	else if (!bitmap_and(bitmap, pmu->all_valid_pmc_idx,
+			     (unsigned long *)&pmu->global_ctrl, X86_PMC_IDX_MAX))
+		return;
+
+	kvm_for_each_pmc(pmu, pmc, i, bitmap) {
 		if (!pmc_event_is_allowed(pmc))
 			continue;
 
-- 
2.42.0.869.gea05f2083d-goog

