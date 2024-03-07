Return-Path: <linux-kernel+bounces-94820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799C1874596
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8351C21D73
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC5015EA6;
	Thu,  7 Mar 2024 01:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ioaFdpy"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FFBEACC
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 01:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709774034; cv=none; b=auNwsHdYxX77+4yKpo+S4up3YqqvHxl4XVh46twTRZ2RB8hW1eqsud/VfvvM+vN+NHFwXiG01yjYoiJ6q5s2TMSFk1G7jlL9oKWEQaPYcQ+elFGnR78SB33La7c9pSOZhVpZEVoX6mO5URxICylFRKc4jeJjb8DUWakIQvHQZNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709774034; c=relaxed/simple;
	bh=pcz2Ucn1DKGCTxS7gDvUH85jIc5cUh+bswUIUHMbqQs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tH7BoJGd/W/uQL9X7H09QNLyv2acWzoQuuDpPFSRDANsPGd0gCUNsnJKIMB9N/ZuNDwKtXSmgdfO4XVljQV7asbkX0zxWhJNLSvGFpPEIP76HPp0bBTK0gWEcewxNxEIMiofC6RwfciwWykZ+qbuBfimn2rgwPml0XUX5DwBZ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ioaFdpy; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso502363276.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 17:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709774032; x=1710378832; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=o3SxNJAQq8uZUj+l9JJTY3oE5/SJJ0Uc20+Uo+WJGNo=;
        b=1ioaFdpyZxEXxdv2HY6mKQNHhCecMQVUURH7MuC7VO+LPCuF9+8i94oRIK3eTrXoJV
         sOdjhtccLwZju1iiiCWcjpWcsoabmFaXEo5IcCI0DFAxk5S6LXxbdnkZLGsHO6PNo1sB
         kOfqFuXt93LvkTr+7k+n+hK61KJPwxy6FGVWjwrrPdB79LTf51R7tvkhdZZ0xuWzVXv3
         qKvqU1h9Wolr2T+k+ESJVW+JWrb8M/qWyBMRtuMNV3YawIKOPyZGn4bTN3kicMJpyq8j
         F5zuz0K1XHPlJfM8uq45LVP2WwUxfDi8s6CUVldXvkW17yyTefnIi8D7e2a1opOOb9yM
         b1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709774032; x=1710378832;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o3SxNJAQq8uZUj+l9JJTY3oE5/SJJ0Uc20+Uo+WJGNo=;
        b=DAtPsKK64vMLhQzxpIp492S/lRYeHWtgEGD9Rm45tHK7rv/WsflBiULd/cVUoVyCbq
         eEL7tq6YWle2AZUl4Xloh810A4El2MdFiursn5MPTsBWi4jSfuI/w2UBS/nCjsrmBfR8
         shZ30idJvUhTTuiM/Bzs9m00WuK+hh6h+G/pAT9nh84u0Iu2GTnL8b8T4YFTiNWGZ1Jb
         rNfAdt+9hPM59paaXKGVBc4TqJQiAP/PVCXH8g9VrI901b4l/9eIidvax9rXbyRgEAy+
         VoexAWRDtFfyzYWjx2fqIdj311BNpdozonL6+/Islh1e7eixb0z7S1nWDTfkuEammGaN
         gJWA==
X-Forwarded-Encrypted: i=1; AJvYcCVkb8KNHB7GPvbl1v5L85UXVZ6/bEx9oOECqRGHA1RSzmkMCOWpH+xudhCRgVpGvRHc6k6P6/qEVfPPmQ+iW2Xv3gOTxM9CeycmtKDe
X-Gm-Message-State: AOJu0YwBJ8G/pTZXXGL8OULlonNVDE4R0ADo5y7rAxwZatpnJiqk++Tq
	eKvqhN4gtci3YXw9qxuIb5CQRn7s4iyQK4I5YDM/fOKpOJbn/4dsJHrlILcKPQeNNj1sZRR5Mfb
	2cQ==
X-Google-Smtp-Source: AGHT+IGeL/DjPRgCNBVl+V/SB3gCWNCNZ4LpSUf0yDvzT/PpyTaaBz/Gs5dkdOT3yZ6PloXBBo6wJVf66G8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:aaa3:0:b0:dc6:db9b:7a6d with SMTP id
 t32-20020a25aaa3000000b00dc6db9b7a6dmr665270ybi.13.1709774032394; Wed, 06 Mar
 2024 17:13:52 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Mar 2024 17:13:44 -0800
In-Reply-To: <20240307011344.835640-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307011344.835640-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307011344.835640-4-seanjc@google.com>
Subject: [PATCH 3/3] KVM: VMX: Disable LBR virtualization if the CPU doesn't
 support LBR callstacks
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Disable LBR virtualization if the CPU doesn't support callstacks, which
were introduced in HSW (see commit e9d7f7cd97c4 ("perf/x86/intel: Add
basic Haswell LBR call stack support"), as KVM unconditionally configures
the perf LBR event with PERF_SAMPLE_BRANCH_CALL_STACK, i.e. LBR
virtualization always fails on pre-HSW CPUs.

Simply disable LBR support on such CPUs, as it has never worked, i.e.
there is no risk of breaking an existing setup, and figuring out a way
to performantly context switch LBRs on old CPUs is not worth the effort.

Fixes: be635e34c284 ("KVM: vmx/pmu: Expose LBR_FMT in the MSR_IA32_PERF_CAPABILITIES")
Cc: Mingwei Zhang <mizhang@google.com>
Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2a7cd66988a5..25a7652bee7c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7859,7 +7859,15 @@ static __init u64 vmx_get_perf_capabilities(void)
 
 	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR)) {
 		x86_perf_get_lbr(&vmx_lbr_caps);
-		if (vmx_lbr_caps.nr)
+
+		/*
+		 * KVM requires LBR callstack support, as the overhead due to
+		 * context switching LBRs without said support is too high.
+		 * See intel_pmu_create_guest_lbr_event() for more info.
+		 */
+		if (!vmx_lbr_caps.has_callstack)
+			memset(&vmx_lbr_caps, 0, sizeof(vmx_lbr_caps));
+		else if (vmx_lbr_caps.nr)
 			perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
 	}
 
-- 
2.44.0.278.ge034bb2e1d-goog


