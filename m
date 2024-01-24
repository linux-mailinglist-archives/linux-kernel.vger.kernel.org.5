Return-Path: <linux-kernel+bounces-36229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50269839DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BAA1C272E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162C679DB;
	Wed, 24 Jan 2024 00:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZvNqtW1"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E081A46AA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706056753; cv=none; b=GWYyNa6B3CNGfYRZtI9yUiji5Vh4jQlhgHsZ0hEgw92fHaSObEXk2idhzLUf5mfmHZN+ZvBqqalffL97XXC8hhDKYXzwXn3i1sAtMp/xKJOt/PcVO6bQ5fvIPbCf/T82TqamCbDIE0pyXKo3tNlKgZ4XIVAQo50fNTdTBwNeYpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706056753; c=relaxed/simple;
	bh=d47FqiBmt2oY1UnGiiPAsKGV/K1xPRRMHQa1eYmYyd8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AXTlmTcL3YZR2Jaw7XAUTFKH98lRGi03LWaeJe8sFJOzq5eZGLSoXeIxyZy5N3Oc9OwTGJld8tgYFGpi2Me4OYCXTGxmByb1YcskTID7eYSGsVxmMrar0vxNpo/o2yDW5K4HuKk8/hKx1BbeKGEPSYhkZbUWDRH78Xw4xXKLf5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QZvNqtW1; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc365b303abso2741497276.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706056751; x=1706661551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=FZPx6jaS+VlPs9U7Plzj144efeFD6kMtS2nhR6IMeJ0=;
        b=QZvNqtW1K5neCEhphKF66B15SarKJB3xYcoPBIPDn1qqArAJ15x5UOnbh5Wefkem+h
         c+nCKOZlZZ2sZdnIKUnVCWSeqE2x4sXVx3Hexmwahm2c05UBvCQGxi2CykbtfqUqnvjz
         yjeZvVNwO75rWJxsC3n8muwHYU5WprdC09sVuvalEqu0mtmwqB+9LknPWBtHf62flUQT
         2rFfsrNU+v2AtACMEJYzuxoRUyn2Q1064OEk7lFfmZ6I8JDcRuuW079CUa7M5CLdI4GZ
         fVDyGrg7wIgNNBQSA038aCJhT7tQ64W75Ool0h6wqWwypyH5a1Ra5Q2anZcpM+EUkRgZ
         Mn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706056751; x=1706661551;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZPx6jaS+VlPs9U7Plzj144efeFD6kMtS2nhR6IMeJ0=;
        b=U/L6JaXLboMLnNr8fde58WutBehJ89E5Y+0p9VIyrnYxDyeWTGdpLPmKlA/ONI0wmT
         fYMd8tF9HR0A/X0bc9T8aehdQGpHjpcA1sWgSKxzPB9H3NQf9uWehPCjCgZLtBQuciBL
         JFA3z6nhLECAhf3pojrkrKNYQxwCdS3f/4UUSChl6XaQtVwfU2A4ObYQXPpKodJIBSa1
         vD3YWYLfB8Tc7nq/0F6TObs4dqHdpKNlnMtA8s2YqgalBWVyqrg/JRwAp5rZRzzfegdE
         qTGMdCi1tNxNqJtrhdlgJXVQOcelvF1hL5VpvekWBCPMRFkPcDSCUEsuTZY14O/sPZlg
         ZxQg==
X-Gm-Message-State: AOJu0YwuNabbXm/MhvcIVnY0B2CSXmzCHAQ5AytPcVvax22J++3eJ1IX
	1zJc9hH8QBhA0pfYq0jLaNU6wMPplRw8IVtpQKvRzO50xErURW1RqLwHI8sDp9e33d9yI6/5Ds6
	jg0TFCA==
X-Google-Smtp-Source: AGHT+IHE2bCB8dOm7+iUfEAfCfbCbFO9C1AaQid7KY5KdNtus7AVSoPFC3fScj3f7Yc/6P7VhYp0SgTRcLtU
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a05:6902:987:b0:dc2:2847:b34a with SMTP id
 bv7-20020a056902098700b00dc22847b34amr672ybb.9.1706056750785; Tue, 23 Jan
 2024 16:39:10 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Wed, 24 Jan 2024 00:38:57 +0000
In-Reply-To: <20240124003858.3954822-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240124003858.3954822-1-mizhang@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240124003858.3954822-3-mizhang@google.com>
Subject: [PATCH 2/2] KVM: x86/pmu: Remove vcpu_get_perf_capabilities()
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aaron Lewis <aaronlewis@google.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove vcpu_get_perf_capabilities() helper and directly use the
vcpu->arch.perf_capabilities which now contains the true value of
IA32_PERF_CAPABILITIES if exposed to guest (and 0 otherwise). This should
slightly improve performance by avoiding the runtime check of
X86_FEATURE_PDCM.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index a6216c874729..7cbee2d16ed9 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -158,17 +158,9 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
 	return &counters[array_index_nospec(idx, num_counters)];
 }
 
-static inline u64 vcpu_get_perf_capabilities(struct kvm_vcpu *vcpu)
-{
-	if (!guest_cpuid_has(vcpu, X86_FEATURE_PDCM))
-		return 0;
-
-	return vcpu->arch.perf_capabilities;
-}
-
 static inline bool fw_writes_is_enabled(struct kvm_vcpu *vcpu)
 {
-	return (vcpu_get_perf_capabilities(vcpu) & PMU_CAP_FW_WRITES) != 0;
+	return (vcpu->arch.perf_capabilities & PMU_CAP_FW_WRITES) != 0;
 }
 
 static inline struct kvm_pmc *get_fw_gp_pmc(struct kvm_pmu *pmu, u32 msr)
@@ -207,13 +199,13 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
 	case MSR_CORE_PERF_FIXED_CTR_CTRL:
 		return kvm_pmu_has_perf_global_ctrl(pmu);
 	case MSR_IA32_PEBS_ENABLE:
-		ret = vcpu_get_perf_capabilities(vcpu) & PERF_CAP_PEBS_FORMAT;
+		ret = vcpu->arch.perf_capabilities & PERF_CAP_PEBS_FORMAT;
 		break;
 	case MSR_IA32_DS_AREA:
 		ret = guest_cpuid_has(vcpu, X86_FEATURE_DS);
 		break;
 	case MSR_PEBS_DATA_CFG:
-		perf_capabilities = vcpu_get_perf_capabilities(vcpu);
+		perf_capabilities = vcpu->arch.perf_capabilities;
 		ret = (perf_capabilities & PERF_CAP_PEBS_BASELINE) &&
 			((perf_capabilities & PERF_CAP_PEBS_FORMAT) > 3);
 		break;
@@ -577,7 +569,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	bitmap_set(pmu->all_valid_pmc_idx,
 		INTEL_PMC_MAX_GENERIC, pmu->nr_arch_fixed_counters);
 
-	perf_capabilities = vcpu_get_perf_capabilities(vcpu);
+	perf_capabilities = vcpu->arch.perf_capabilities;
 	if (cpuid_model_is_consistent(vcpu) &&
 	    (perf_capabilities & PMU_CAP_LBR_FMT))
 		x86_perf_get_lbr(&lbr_desc->records);
-- 
2.43.0.429.g432eaa2c6b-goog


