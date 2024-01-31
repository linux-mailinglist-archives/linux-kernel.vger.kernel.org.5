Return-Path: <linux-kernel+bounces-45559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F40843261
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64C461C21365
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1AB125B9;
	Wed, 31 Jan 2024 00:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tSzberRR"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2446FC17
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706662786; cv=none; b=UTJbdRvvIigopUmGTomi5FgNc9frTLrm8rdk6T0wy6DdKofQsJKB2Uo2SZApawunuV6GJTI4YgxoInho03a0OgA3du2tlPYC2lihP3dEjWmLlImNrT/JurAHquwQ9wF56iOGew/0q59vZrsfTjINyj+syRGiFOicSHGctzW34Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706662786; c=relaxed/simple;
	bh=D/frGuZFNwtasYAo0fSYO1cwyri07HXbYlHtikiVLSA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WrQW96hmL2+KKRsYjaTW4i+NVi53OurITjYckgCI6gfIjHI8hXGgQyBiEzwvWPAJS5v+sz6ZpStgpRpYdchMsBb+0bTeL35ItCsk8Ksf0A2zt5Zo3MJmpuqcMylK6UySf4UXnF1OnMG50KQxIIxqKeNR7PhsA++qnkqqXnP/L5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tSzberRR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso960967276.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706662783; x=1707267583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1fqv5bzO/lnUuecKv/WibjcAFbqFIyrU4xWqB/+epsY=;
        b=tSzberRRhta72sy1sZ/Ke10uJkyDBPleKwtdYhW3YLgaliwTDvTm8RTuwKqDT7WAXX
         kJ/EIU+1uMH4fkl5pEbIvIwkRiNC9V4KFsOzJ5NeN/5pV0jCUALf06tkGRdx/8ee4+cM
         rxeeRb4lc92gxDi9Xtlc72L3fSzOFz64Mpprl9xyrec6BNX1rz4D6W6/0eUwzzGJiP6B
         S06aV8xwWKSEkhGBI/oSWLFllXiKdxatJnArU56v59m0yPNcCtyh5wZ+y8WFw71lRUCp
         9vPHQP2DVbLLJDBno78ar2EaIq4YW+fkzXT+isZvN6vgl5oWN+IQCGVi/hIC1OBsGdEu
         niAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706662783; x=1707267583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1fqv5bzO/lnUuecKv/WibjcAFbqFIyrU4xWqB/+epsY=;
        b=viTQCtcddSjvLyX96FJPX2n9l9CFPACUK7aqBmN9B8YfYQzuDxqUI/13BwnVpjsoBV
         NeRZC0FKt1ugyAfwv7ntoGogTwJKz18oIQTt5Lsul17rUERvObqiGQw9fQEr3DpOqbtD
         eKp1nJWx6OVsBCDl5UKfrcjzEC549oO7mbOA6VgV6m52Q1we8E+ArbZYdZUz1d2EfM+k
         Q0DlKXXICxTN8sRjj12y4j8YwX8pOlBnZkGTF0XFAtGnq9aVSoG0XGn2upTcRgEGDILh
         IUK1i9kQXSVAgj3H+j94wQok9sS39Si0FEDufYAjy96PsYVdiNx+4O0HukRcqFYibvAp
         JpjA==
X-Gm-Message-State: AOJu0Yx/g3vjgKa+7Zyyg2U4RtcJU2c/QiNWq8XCgjI83mScQtSzUbOG
	S4HFD660uB+ldudewoODZ9ywtc2T1i2n0nyJ+LcB/LcadG8a/Ocdx8NOz+1E6ydHbARvcdgEmgr
	/qQ==
X-Google-Smtp-Source: AGHT+IF+M9T/r2O8+FQIfZ7jDO15q5toNqSryRmmbveMM7RENwtQmbwPI6eijK9SmHdyzJCm9x+/zVmVWOM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:230d:b0:dc2:354a:f191 with SMTP id
 do13-20020a056902230d00b00dc2354af191mr60328ybb.10.1706662783734; Tue, 30 Jan
 2024 16:59:43 -0800 (PST)
Date: Tue, 30 Jan 2024 16:59:19 -0800
In-Reply-To: <20240109230250.424295-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240109230250.424295-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <170666267480.3861961.1911322891711579495.b4-ty@google.com>
Subject: Re: [PATCH v10 00/29] KVM: x86/pmu: selftests: Fixes and new tests
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Jinrong Liang <cloudliang@tencent.com>, 
	Aaron Lewis <aaronlewis@google.com>, Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 09 Jan 2024 15:02:20 -0800, Sean Christopherson wrote:
> Knock wood, _this_ is the final of fixes and tests for PMU counters.  New
> in v10 is a small refactor to treat FIXED as a value, not a flag, when
> emulating RDPMC.  Everything else is the same as v9 (although rebased, but
> there were no conflicts).
> 
> v10:
>  - Collect review. [Dapeng]
>  - Treat the FIXED type in RDPMC's ECX as a value, not a flag. [Jim]
> 
> [...]

Applied to kvm-x86 pmu, with the fix for the file goof Andrew pointed out.

[01/29] KVM: x86/pmu: Always treat Fixed counters as available when supported
        https://github.com/kvm-x86/linux/commit/5eb7fcbdea63
[02/29] KVM: x86/pmu: Allow programming events that match unsupported arch events
        https://github.com/kvm-x86/linux/commit/cbbd1aa89139
[03/29] KVM: x86/pmu: Remove KVM's enumeration of Intel's architectural encodings
        https://github.com/kvm-x86/linux/commit/db9e008a0f37
[04/29] KVM: x86/pmu: Setup fixed counters' eventsel during PMU initialization
        https://github.com/kvm-x86/linux/commit/61bb2ad795a7
[05/29] KVM: x86/pmu: Get eventsel for fixed counters from perf
        https://github.com/kvm-x86/linux/commit/7a277c22412c
[06/29] KVM: x86/pmu: Don't ignore bits 31:30 for RDPMC index on AMD
        https://github.com/kvm-x86/linux/commit/ecb490770ad4
[07/29] KVM: x86/pmu: Prioritize VMX interception over #GP on RDPMC due to bad index
        https://github.com/kvm-x86/linux/commit/7bb7fce13601
[08/29] KVM: x86/pmu: Apply "fast" RDPMC only to Intel PMUs
        https://github.com/kvm-x86/linux/commit/d652981db08f
[09/29] KVM: x86/pmu: Disallow "fast" RDPMC for architectural Intel PMUs
        https://github.com/kvm-x86/linux/commit/5728a4a0ea79
[10/29] KVM: x86/pmu: Treat "fixed" PMU type in RDPMC as index as a value, not flag
        https://github.com/kvm-x86/linux/commit/7a0fc734c20d
[11/29] KVM: x86/pmu: Explicitly check for RDPMC of unsupported Intel PMC types
        https://github.com/kvm-x86/linux/commit/a634c76b2c1a
[12/29] KVM: selftests: Add vcpu_set_cpuid_property() to set properties
        https://github.com/kvm-x86/linux/commit/d7e68738e1aa
[13/29] KVM: selftests: Drop the "name" param from KVM_X86_PMU_FEATURE()
        https://github.com/kvm-x86/linux/commit/ff76d7712510
[14/29] KVM: selftests: Extend {kvm,this}_pmu_has() to support fixed counters
        https://github.com/kvm-x86/linux/commit/370d53632289
[15/29] KVM: selftests: Add pmu.h and lib/pmu.c for common PMU assets
        https://github.com/kvm-x86/linux/commit/e6faa0497057
[16/29] KVM: selftests: Test Intel PMU architectural events on gp counters
        https://github.com/kvm-x86/linux/commit/4f1bd6b16074
[17/29] KVM: selftests: Test Intel PMU architectural events on fixed counters
        https://github.com/kvm-x86/linux/commit/3e26b825f87d
[18/29] KVM: selftests: Test consistency of CPUID with num of gp counters
        https://github.com/kvm-x86/linux/commit/7137cf751b9b
[19/29] KVM: selftests: Test consistency of CPUID with num of fixed counters
        https://github.com/kvm-x86/linux/commit/c7d7c76ecf78
[20/29] KVM: selftests: Add functional test for Intel's fixed PMU counters
        https://github.com/kvm-x86/linux/commit/787071fd0262
[21/29] KVM: selftests: Expand PMU counters test to verify LLC events
        https://github.com/kvm-x86/linux/commit/b55e7adf633a
[22/29] KVM: selftests: Add a helper to query if the PMU module param is enabled
        https://github.com/kvm-x86/linux/commit/c85e986716b0
[23/29] KVM: selftests: Add helpers to read integer module params
        https://github.com/kvm-x86/linux/commit/45e4755c39fc
[24/29] KVM: selftests: Query module param to detect FEP in MSR filtering test
        https://github.com/kvm-x86/linux/commit/0326cc6b02c8
[25/29] KVM: selftests: Move KVM_FEP macro into common library header
        https://github.com/kvm-x86/linux/commit/00856e17da73
[26/29] KVM: selftests: Test PMC virtualization with forced emulation
        https://github.com/kvm-x86/linux/commit/cd34fd8c758e
[27/29] KVM: selftests: Add a forced emulation variation of KVM_ASM_SAFE()
        https://github.com/kvm-x86/linux/commit/ab3b6a7de8df
[28/29] KVM: selftests: Add helpers for safe and safe+forced RDMSR, RDPMC, and XGETBV
        https://github.com/kvm-x86/linux/commit/b5e66df34cb0
[29/29] KVM: selftests: Extend PMU counters test to validate RDPMC after WRMSR
        https://github.com/kvm-x86/linux/commit/a8a37f555684

--
https://github.com/kvm-x86/linux/tree/next

