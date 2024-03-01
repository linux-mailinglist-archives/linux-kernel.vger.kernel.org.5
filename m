Return-Path: <linux-kernel+bounces-89012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B9386E971
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC91288FBA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC96B3A8ED;
	Fri,  1 Mar 2024 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2oQl1kTH"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F90525623
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321071; cv=none; b=kdgdCXx9XHVy7ywsFhR68nmLKxZb1VZNop+haO0c4tKtvhMWrbjWL5RgBUK8CM1ZPU7RuvojXixdurEtOIukyxCjezzHc9stP95Xr9QKk52JW+s1JpQlAkZIfqvqXNSVgDkaKkyBa+9Cr4DVvjKFftO2qpBJbMtCFqItEx0ONHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321071; c=relaxed/simple;
	bh=umgf9/Xh2fiEs38aP0Wij2OiHd8/uhV+11hOzUYf1uQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0DqMG6scDndvdwLoZBTMsbJEiUZpTfxBfp5MnkD8O/yS/Hj3fKmDMJMjresaI+K5VaerHR1qV1E9mTk6evCsZGVoZ/OQ5yY7/AWTo3+V75FWKLfC15+3AO67wuCT2V0HvDX5gBFXdYXNn2+nJwCwr0jSGW8C9rnB4bOeoL4TA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2oQl1kTH; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso14410a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 11:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709321068; x=1709925868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDuPeEH5wsG8B80wWhr2QXdeB+S1bWAHLXQ9jR96lHc=;
        b=2oQl1kTHnCt60tj71ozCMPfS+yM3Wbr8xdZeAUfE0y6A0ZX7HBCYCzOJ8N8+RKTlB/
         1/08cldk/tKUK8DgdoaYMjhicN+NmZlhH2UWb7hbc2fZ463qxoaxmb+pOIPTxX23YP/i
         9gmFYt5R+8QskTXjRLdWi2gFqDJjColg+HhlYbyzSkFZYICPbKBuP/BoF+opCBvRwa0j
         u1WiOcD1hTzuz6dgq4F8D5qf2hxeqIHCvxOv63xTL/OItvB2UXViDTlMjPPrX3IzahEQ
         m6pTnKpFSYOGWEoJ3cQjcTQhXCf+01KOFPtDOEGWHj0SGv85mwyDVFKkCK6e5AXEXARk
         rNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709321068; x=1709925868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDuPeEH5wsG8B80wWhr2QXdeB+S1bWAHLXQ9jR96lHc=;
        b=i2mNrz9/j1Nel7/GGIo0Doa4DhKORbDktS1XZQZDj+AywxRoPnumqzjbcN4/Omv9xb
         7bZ7/xbQB74aEAbZsdRPwyuWAy/lvq+jas0BI5GcMJhxTGkhJ8hZKf7zei1AMoNrBwLe
         AJPA1gFcwt09iV039ixLyroAwLMFMx24KRVzxcg6E39MTlZ/u0AdjhbWu4PiKmW2B1nX
         q6KgdDKw1xZIbxAXFWs7dJdHnIs/WAa6GrZSMZv+nmuFq37kMKoTHuLEkZEM6j7jjnEI
         AZjJtqHUd3d9F3fulPVPM3i8nHYMdhXnkAq4iGkS3KbjUrDhGnlE8SvX/MvilMSUEY8I
         hq4w==
X-Forwarded-Encrypted: i=1; AJvYcCVmxDxw9sE+0DCqgcLrNXUglzvKe6c9ca1s1aV7eV/5GOiIS+KI/iNbVvTTGfF43hC6M5w9Jczhuz8LtGd9eQVMWinnVSg1vWoJUWkb
X-Gm-Message-State: AOJu0YxzGM9irLJF+1JAy6vX4gmiCuf5ma9oNe06EPsqCOkgwnynH3/a
	lReQBnYKWgkAJrl4BW6by5GG31/PAiTRFCul5FZ486tTq1/Nd+A6yK9odFYP2gKRwshiHVk6npa
	7YZI4Vucm4tErqqns0dU/rxMJ8xkNnzo1SWJu
X-Google-Smtp-Source: AGHT+IFQ0gnP6qnKKDdSZv1A5AwEYM2+CsTYjoZPo8yzDomIX1ZoElk/kzrghH7WVuOGDi2oFtU7dFMuwrTDybDo3xo=
X-Received: by 2002:a05:6402:5215:b0:566:f626:229b with SMTP id
 s21-20020a056402521500b00566f626229bmr28826edd.7.1709321067574; Fri, 01 Mar
 2024 11:24:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301074423.643779-1-sandipan.das@amd.com>
In-Reply-To: <20240301074423.643779-1-sandipan.das@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 1 Mar 2024 11:24:11 -0800
Message-ID: <CALMp9eRbOQpVsKkZ9N1VYTyOrKPWCmvi0B5WZCFXAPsSkShmEA@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Do not mask LVTPC when handling a PMI on AMD platforms
To: Sandipan Das <sandipan.das@amd.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, seanjc@google.com, 
	pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	mlevitsk@redhat.com, vkuznets@redhat.com, mizhang@google.com, 
	tao1.su@linux.intel.com, andriy.shevchenko@linux.intel.com, 
	ravi.bangoria@amd.com, ananth.narayan@amd.com, nikunj.dadhania@amd.com, 
	santosh.shukla@amd.com, manali.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 11:44=E2=80=AFPM Sandipan Das <sandipan.das@amd.com=
> wrote:
>
> On AMD and Hygon platforms, the local APIC does not automatically set
> the mask bit of the LVTPC register when handling a PMI and there is
> no need to clear it in the kernel's PMI handler.

I don't know why it didn't occur to me that different x86 vendors
wouldn't agree on this specification. :)

> For guests, the mask bit is currently set by kvm_apic_local_deliver()
> and unless it is cleared by the guest kernel's PMI handler, PMIs stop
> arriving and break use-cases like sampling with perf record.
>
> This does not affect non-PerfMonV2 guests because PMIs are handled in
> the guest kernel by x86_pmu_handle_irq() which always clears the LVTPC
> mask bit irrespective of the vendor.
>
> Before:
>
>   $ perf record -e cycles:u true
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.001 MB perf.data (1 samples) ]
>
> After:
>
>   $ perf record -e cycles:u true
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.002 MB perf.data (19 samples) ]
>
> Fixes: a16eb25b09c0 ("KVM: x86: Mask LVTPC when handling a PMI")
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  arch/x86/kvm/lapic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 3242f3da2457..0959a887c306 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2768,7 +2768,7 @@ int kvm_apic_local_deliver(struct kvm_lapic *apic, =
int lvt_type)
>                 trig_mode =3D reg & APIC_LVT_LEVEL_TRIGGER;
>
>                 r =3D __apic_accept_irq(apic, mode, vector, 1, trig_mode,=
 NULL);
> -               if (r && lvt_type =3D=3D APIC_LVTPC)
> +               if (r && lvt_type =3D=3D APIC_LVTPC && !guest_cpuid_is_am=
d_or_hygon(apic->vcpu))

Perhaps we could use a positive predicate instead:
guest_cpuid_is_intel(apic->vcpu)?

>                         kvm_lapic_set_reg(apic, APIC_LVTPC, reg | APIC_LV=
T_MASKED);
>                 return r;
>         }
> --
> 2.34.1
Reviewed-by: Jim Mattson <jmattson@google.com>

