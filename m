Return-Path: <linux-kernel+bounces-97739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 687AD876E9F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 02:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD0E28264A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 01:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52A62D03B;
	Sat,  9 Mar 2024 01:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1um5wWwV"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938DD22F07
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 01:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709948210; cv=none; b=LkVH4/otgjWCssaembt4vnpG3tfOcTQxK0Gl1H9uAlag/LOaCHxkwThLqfL89PImp8uA2cP68QtPJy8JZk5KqoDcLNZKt3TMn/+sI4jxkK98Nac5R5P43YKj8I9HbnOr30aeTxIZjizC0GOnsFC/gW3kRauujnu4LMwozrPEOiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709948210; c=relaxed/simple;
	bh=SWsPpADQLluvQvp2PRySI9bpj5F6vQcm7E3y70V4Wao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=USIlB3d8BBVPghac4LMgtq6gscuWS6RAwIYa/nM3heG0Xnt/NqIuGQUGHMsgAhHiyOMSbHQYr/OdNJBRqxLYe6eYJrTy9/nARnjFDOLUhb0p3VH83sH6r1VOxfs8NV9V5XihL8Dk3e0hlDEZb7QRhG8pOWwcIgAb6mQt+AQ0TB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1um5wWwV; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcf22e5b70bso2651854276.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 17:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709948207; x=1710553007; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rCwYO/7ilSpOBa4ppOSKCckO3uqB/kQ100+4pH+GXZY=;
        b=1um5wWwVzvKeIcQ4osLWCCjiUOwsPI8wZM+fFTDqJeGa3S5wAEA45vMVF4QvlTOvq6
         0Hj24Hu/hHbZ1SEUCy+IuWQM43KaPE79KFDduwdeoo/ymuCe0krgG7mqfQY1Z/99JQt5
         7NGSGkdtzaOLLEddIjY8WwMhgvvD2/9f8niXya6omOzXkWP0oXKUSlEbvaH6Z65LLjAC
         KK9q8LSX4z9BQ6rJfk+ZhsMnNvAs6m42/GG157FGg81jtc1RA7luBv7xdpOop43RwqGE
         gKtS38CzNrcGpG11inBe3vrMHOCZFffTdstcedBLbrO6BKHYMhFuBPHhzKQvwPfN/4/p
         hNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709948207; x=1710553007;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCwYO/7ilSpOBa4ppOSKCckO3uqB/kQ100+4pH+GXZY=;
        b=OaoYgYtgtgGO7tUxc2kqgUoAnNxqfbwWDm05FsapH8wpNU25hY+iwdOEL7kzkAuYKj
         2n/jBTYw6iqGxSw9CNsUnF1P7A+knreAuKtFlxqKKhR/k5ARKna+ZLjN+orp7Ncsd0Wa
         4B2wXJGiPfIFw+R2E+ZpwE9AefbzcEeg3a4cgs3yJ8OS00qKAem6mcTY/sSOf+1b9vcb
         Q0vWovmhBvZRdrCy9r+Pvww5uAOkpi3xY0hM2TeGDEnWTY9boEb14V339zvu/mVJkaet
         +d+D/O75mqgf4KVeHZ5zRIUzRMrLI2dmtT145iP3ps8m4L57WrUjIiC7Z+sRamjK4FZg
         M60A==
X-Forwarded-Encrypted: i=1; AJvYcCVWRn5hzb4WoHtIG4geyFO9K66BdGZXjpdkGsbaFqnmDG5EbauTRBaEdFDbnn2UhseHrDdmmJAhPhucKgyTEK27KIH03tZweymTsjSv
X-Gm-Message-State: AOJu0Yw3UZTjF2+ckZk0S7D/qm3qqqf13SyTopIF83A11vmLemOq7eia
	o5nua0V8KX9B1QF8n/e7o0EhzqSpBZyJhqjkq+xH+JtLIPf5vW/sXPaZyKpcaUpR8kYGgGzhVTE
	bQA==
X-Google-Smtp-Source: AGHT+IFvwDv/b0ydhsjPUXHw+jUb9gLdfBmL+i1F0ATMcxKeC9RIVzkgTlzWkZAwh4wYWsQF1XGiHgwcQwY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:100d:b0:dcc:8be2:7cb0 with SMTP id
 w13-20020a056902100d00b00dcc8be27cb0mr40937ybt.0.1709948207688; Fri, 08 Mar
 2024 17:36:47 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 Mar 2024 17:36:41 -0800
In-Reply-To: <20240309013641.1413400-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309013641.1413400-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240309013641.1413400-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: selftests: Verify post-RESET value of
 PERF_GLOBAL_CTRL in PMCs test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Babu Moger <babu.moger@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Like Xu <like.xu.linux@gmail.com>, Mingwei Zhang <mizhang@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Add a guest assert in the PMU counters test to verify that KVM stuffs
the vCPU's post-RESET value to globally enable all general purpose
counters.  Per Intel's SDM,

  IA32_PERF_GLOBAL_CTRL:  Sets bits n-1:0 and clears the upper bits.

and

  Where "n" is the number of general-purpose counters available in
  the processor.

For the edge case where there are zero GP counters, follow the spirit
of the architecture, not the SDM's literal wording, which doesn't account
for this possibility and would require the CPU to set _all_ bits in
PERF_GLOBAL_CTRL.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index 29609b52f8fa..26c85815f7e9 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -416,12 +416,30 @@ static void guest_rd_wr_counters(uint32_t base_msr, uint8_t nr_possible_counters
 
 static void guest_test_gp_counters(void)
 {
+	uint8_t pmu_version = guest_get_pmu_version();
 	uint8_t nr_gp_counters = 0;
 	uint32_t base_msr;
 
-	if (guest_get_pmu_version())
+	if (pmu_version)
 		nr_gp_counters = this_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS);
 
+	/*
+	 * For v2+ PMUs, PERF_GLOBAL_CTRL's architectural post-RESET value is
+	 * "Sets bits n-1:0 and clears the upper bits", where 'n' is the number
+	 * of GP counters.  If there are no GP counters, require KVM to leave
+	 * PERF_GLOBAL_CTRL '0'.  This edge case isn't covered by the SDM, but
+	 * follow the spirit of the architecture and only globally enable GP
+	 * counters, of which there are none.
+	 */
+	if (pmu_version > 1) {
+		uint64_t global_ctrl = rdmsr(MSR_CORE_PERF_GLOBAL_CTRL);
+
+		if (nr_gp_counters)
+			GUEST_ASSERT_EQ(global_ctrl, GENMASK_ULL(nr_gp_counters - 1, 0));
+		else
+			GUEST_ASSERT_EQ(global_ctrl, 0);
+	}
+
 	if (this_cpu_has(X86_FEATURE_PDCM) &&
 	    rdmsr(MSR_IA32_PERF_CAPABILITIES) & PMU_CAP_FW_WRITES)
 		base_msr = MSR_IA32_PMC0;
-- 
2.44.0.278.ge034bb2e1d-goog


