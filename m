Return-Path: <linux-kernel+bounces-133711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C38C989A7A7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63BE6B23439
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279A1482E2;
	Fri,  5 Apr 2024 23:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="exk7qQwt"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DD33A8D0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 23:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712361374; cv=none; b=HpIOybmLfecy+hJopgGG2GHHBDGgObnHU1OEo8jYDg7QpDWLBY55+u1hrg2OZyAkU637YXb0lASUqf+F51XwnQTz392b9TLzwVBVbxvQ5Cf+py1/9qhf7KhFFqh0vKPtUAYj2K91pP6eglMm+nd0LofOJuEKY0EVLA9aqv+L5x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712361374; c=relaxed/simple;
	bh=xbZiBhFR1GD8yrF6sLlU6H1LX9EPZovTo0hzoXLG8aU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lf18f5UF0LvO680ex/DvUuR/ODK+O4mGfJ4yea/Qflu0CJSG0xof0SDwNUD6TxV0DeCPY5VQMoqxVemfmcX2K+8QXl36eogs5TSaxAOlB+mWmGzaFm9mS5l+ofb77GeVqI+5YIkLtEc7j7ClSZK8QVCN/f1y2kCfGrrRISLLNPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=exk7qQwt; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cc00203faso46402017b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 16:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712361372; x=1712966172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=A9lrggeLpLCqzlw5rBZRk9JnCRZ4h79aA0odPmKt0/Y=;
        b=exk7qQwt2tFgGQFALCYzNz62cfq1uCdAj2elVfWgXOU5ISBdrUO9XBHUtHlG/s0D15
         ysNo6oRJkJm2J1A6jj9OXv15OdetgJFvuHR9wnPurMsNVqv2ksLvyndqeZ7e7LUhKxlu
         Cz7gryjgRzcd8z7ONh11dR0ICAvgNaH1z7D+5kvIRikBh8fP+QKXPHtv+Wx31aosjZbO
         9RwjostrYObLlaa+LSGKuSDtxbHK50JwNwPAUPIoKJO5gw8n7+/iB7Mi/t251t2sra8c
         Yf62OpIU5LkyTvvQL52MaVdU/DfbHTWutpgmSI9LTnWzlO2vdqCShEy6li0aEs1q5agf
         085A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712361372; x=1712966172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9lrggeLpLCqzlw5rBZRk9JnCRZ4h79aA0odPmKt0/Y=;
        b=Vp+UVB4Q8BtofA3X+qyUL+PuTh7pLbY6axDrp2O/wGHHZa7jZMATpkZnFWujbv8HfK
         0CmXILsZe9ddycy7DMVoNjrYMptaHRGE7SNcGiCtjwTV+eo9uzX4L9ALiOMPe8k+3G3+
         A40PG4B0CcRvQ/MP5wOy11tSRrxejLP3KShb9QUqS+fIBkgpoMatpA4yYs/NXAWXR3gr
         aOkfac+bHeAgukO7U7hrtVaOGSKR2qLa3NfutUXqMuiPWHb+lDoSZhPl9szlTbfl4q6c
         FbA00Qm3wfVgK4crK+xYHPd41HJGls8nSMqxIGsL7NO3bxMHbjuLXlz87wlitRcuW+2Z
         CftA==
X-Forwarded-Encrypted: i=1; AJvYcCXMtGX9o+jLmRjvFQNM8gfu1GO7p4aDeDm+YkexFHVA5yo2B9O7tQhNACAx6MEHFOor8hB6o4bNaGBA8bbEEnW2N94DLa7rAK+a4HNk
X-Gm-Message-State: AOJu0Yyn93DK7CO3J183XheydY6pcJK1PbfVMNXIDghI3y3a40SsV1Y+
	oRQZ6+M5uzJJjY4OYGz4Sjl5NzY56kQsbLntm5lk9jeV2NiBktZCiOhtE6koTtFHW4EFQCdh0uq
	Tgg==
X-Google-Smtp-Source: AGHT+IHxX7pBb2sUjx5QNvzOVxofCju8D1fTDdX9zEtiJP7uYXUfRHPoMknf9MR/69TMULXioiY7atftN3k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:944:0:b0:dcd:4286:4498 with SMTP id
 x4-20020a5b0944000000b00dcd42864498mr170623ybq.6.1712361371935; Fri, 05 Apr
 2024 16:56:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Apr 2024 16:55:55 -0700
In-Reply-To: <20240405235603.1173076-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405235603.1173076-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405235603.1173076-3-seanjc@google.com>
Subject: [PATCH 02/10] KVM: x86/pmu: Do not mask LVTPC when handling a PMI on
 AMD platforms
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sandipan Das <sandipan.das@amd.com>, Jim Mattson <jmattson@google.com>, 
	Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Sandipan Das <sandipan.das@amd.com>

On AMD and Hygon platforms, the local APIC does not automatically set
the mask bit of the LVTPC register when handling a PMI and there is
no need to clear it in the kernel's PMI handler.

For guests, the mask bit is currently set by kvm_apic_local_deliver()
and unless it is cleared by the guest kernel's PMI handler, PMIs stop
arriving and break use-cases like sampling with perf record.

This does not affect non-PerfMonV2 guests because PMIs are handled in
the guest kernel by x86_pmu_handle_irq() which always clears the LVTPC
mask bit irrespective of the vendor.

Before:

  $ perf record -e cycles:u true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.001 MB perf.data (1 samples) ]

After:

  $ perf record -e cycles:u true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.002 MB perf.data (19 samples) ]

Fixes: a16eb25b09c0 ("KVM: x86: Mask LVTPC when handling a PMI")
Cc: stable@vger.kernel.org
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
[sean: use is_intel_compatible instead of !is_amd_or_hygon()]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index cf37586f0466..ebf41023be38 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2776,7 +2776,8 @@ int kvm_apic_local_deliver(struct kvm_lapic *apic, int lvt_type)
 		trig_mode = reg & APIC_LVT_LEVEL_TRIGGER;
 
 		r = __apic_accept_irq(apic, mode, vector, 1, trig_mode, NULL);
-		if (r && lvt_type == APIC_LVTPC)
+		if (r && lvt_type == APIC_LVTPC &&
+		    guest_cpuid_is_intel_compatible(apic->vcpu))
 			kvm_lapic_set_reg(apic, APIC_LVTPC, reg | APIC_LVT_MASKED);
 		return r;
 	}
-- 
2.44.0.478.gd926399ef9-goog


