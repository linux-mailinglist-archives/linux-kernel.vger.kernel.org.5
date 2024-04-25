Return-Path: <linux-kernel+bounces-158662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F25E58B2393
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3104D1C20A76
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1623D14A4C7;
	Thu, 25 Apr 2024 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uzpqxT4t"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C68149E0F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714054217; cv=none; b=n+74/Lc6iUJaFcAO5yAKN6UZwGQ6aN+Cb0clY1CvRau9d6L98kZw3i9NG51TMM7XlIvuRLUiXq1K1TNu9Ct5qsMWRY8IsmVxV5MVx//Zv94M4JVDtLDnicsUr/MNdmxtUVYr+NjqHiC0gwuL4FmlB+uJDgDHy+ns+GkSqjfFutQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714054217; c=relaxed/simple;
	bh=BItV8R6H9q+R+pZ30mC6aRJAXYs4oMTWPeQORV5rSpA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CeZQpDQOo0GR17nFAjr09pGwdzpGFkbvygAI+6NrkMCYkjYxjMuGbc/t9lSmGUlYdlssCtpNNanYsQwWljDKc8ugniWGTuv67idG3HCuMNpDymsl0A1u6vOgCKfgw+wI1KW94Oi//cUvJ1xM2k8HWwQZ3WMJ7keQY52ts89Lsuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uzpqxT4t; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61b7a24b843so16720327b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714054214; x=1714659014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ny6k5In1yh/dXdoAix2kKCvHY5SPtsFGuRUZpDcPe/0=;
        b=uzpqxT4tJtpGc8OCKCA894g0fUkvcbHhG50Kz2J34kc4Pq8Rycd9yo1u3hc8r+p8iY
         dhMrAoc1UcoXSZgnOGFvPBrqBwl/z2t/+4A5H2p27WioEcHIV9W9RG6ALzxwqBazrc2q
         Ed0oQNQH80LFsDBriaWbYzXlwiKIoDWm5+JwuqZFMRZ4Jb+X6iJwGs2V1Lxf7B5Y63N4
         0TMZS2LG+GXpcA5BGNqF7pErHgwuv2GYNky/FSTc70cKNHJUNhmUTnsHq9fMLre2gs+5
         LLcCSysOsHuRi1pucIPMc7GBj6EM3zH84kXruHb4rRr9hPu2X6JDzYFChQ3UYBWGwVNy
         PQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714054214; x=1714659014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ny6k5In1yh/dXdoAix2kKCvHY5SPtsFGuRUZpDcPe/0=;
        b=V9cwCHiOnDCj3NgFBUXePL5CPS+0CeYTXJT01K2r2qDt3Ex15/QKzFaVW9IlJau8Vg
         zgxDaWAdj9dYST2MFGaW1EBWw/kS7pBFFoiU9EdtpODZWN8VTHlKpwv23OyPLV6+W32r
         gx3zm1SAcicel6zuKH51hV+2NWpQVd+EPXZaYcm5Zvu42WrTXUkfUS4YOiJUP1B2QTsB
         1XHD9GmPAnCb10ztn89MT8vuURo0T0XUZKGSgx71mSdgFRXGCNthMMqDB2xkXCzJkBdo
         dIsNdThOv8O9wW2F+y1VyOpKDZr+oBddZyerIqLxMg/bsFm1q79/0Nx/f8jgNaB3v7X6
         rqrg==
X-Forwarded-Encrypted: i=1; AJvYcCWV3j3Vq0sZqovGz7odEq+MQg9rUmX/OiXeOtJnGHC0a/Jguo5cjyNuAtBjuWHAzO504SJ7gC2wEpIyfTtz0hdOzPEgsuPSewCJegye
X-Gm-Message-State: AOJu0YxfUVolqd86+jzt6iDkw2+8fkeWLHayjlftBzGoqwGeSkd7zlVa
	rWGBLJxtp+p1vgQkSpCQ5pvyh3cpYK25f46c37SneBEFZ9NcCKQu2A8iLaHMlvIg2yQM0DSFcsK
	8Mg==
X-Google-Smtp-Source: AGHT+IFL9wPrQFDopC/chIeNLVS3VPuSmUroG6L2BUybtR2TPtd/K09nmBBgvgCzzy630jRdsmnmqufyNAM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:bb4f:0:b0:614:428:e4f9 with SMTP id
 a15-20020a81bb4f000000b006140428e4f9mr1132555ywl.6.1714054214658; Thu, 25 Apr
 2024 07:10:14 -0700 (PDT)
Date: Thu, 25 Apr 2024 07:10:13 -0700
In-Reply-To: <DS0PR11MB6373B95FF222DD6939CFEFC6DC172@DS0PR11MB6373.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423221521.2923759-1-seanjc@google.com> <20240423221521.2923759-2-seanjc@google.com>
 <DS0PR11MB6373B95FF222DD6939CFEFC6DC172@DS0PR11MB6373.namprd11.prod.outlook.com>
Message-ID: <ZipjhYUIAQMMkXci@google.com>
Subject: Re: [PATCH 1/4] KVM: x86: Add a struct to consolidate host values,
 e.g. EFER, XCR0, etc...
From: Sean Christopherson <seanjc@google.com>
To: Wei W Wang <wei.w.wang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 25, 2024, Wei W Wang wrote:
> On Wednesday, April 24, 2024 6:15 AM, Sean Christopherson wrote:
> > @@ -403,7 +403,7 @@ static void vmx_update_fb_clear_dis(struct kvm_vcpu
> > *vcpu, struct vcpu_vmx *vmx)
> >  	 * and VM-Exit.
> >  	 */
> >  	vmx->disable_fb_clear
> > = !cpu_feature_enabled(X86_FEATURE_CLEAR_CPU_BUF) &&
> > -				(host_arch_capabilities &
> > ARCH_CAP_FB_CLEAR_CTRL) &&
> > +				(kvm_host.arch_capabilities &
> > ARCH_CAP_FB_CLEAR_CTRL) &&
> 
> The line of code appears to be lengthy. It would be preferable to limit it to under
> 80 columns per line.

I agree that staying under 80 is generally preferred, but I find this

	vmx->disable_fb_clear = (kvm_host.arch_capabilities & ARCH_CAP_FB_CLEAR_CTRL) &&
				!boot_cpu_has_bug(X86_BUG_MDS) &&
				!boot_cpu_has_bug(X86_BUG_TAA);

much more readable than this

	vmx->disable_fb_clear = (kvm_host.arch_capabilities &
			 	 ARCH_CAP_FB_CLEAR_CTRL) &&
				!boot_cpu_has_bug(X86_BUG_MDS) &&
				!boot_cpu_has_bug(X86_BUG_TAA);

We should shorten the name to arch_caps, but I don't think that's a net positive,
e.g. unless we do a bulk rename, it'd diverge from several other functions/variables,
and IMO it would be less obvious that the field holds MSR_IA32_ARCH_CAPABILITIES.

> >  				!boot_cpu_has_bug(X86_BUG_MDS) &&
> >  				!boot_cpu_has_bug(X86_BUG_TAA);
> > 

> > @@ -325,11 +332,8 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu,
> > gpa_t cr2_or_gpa,
> >  			    int emulation_type, void *insn, int insn_len);
> > fastpath_t handle_fastpath_set_msr_irqoff(struct kvm_vcpu *vcpu);
> > 
> > -extern u64 host_xcr0;
> > -extern u64 host_xss;
> > -extern u64 host_arch_capabilities;
> > -
> >  extern struct kvm_caps kvm_caps;
> > +extern struct kvm_host_values kvm_host;
> 
> Have you considered merging the kvm_host_values and kvm_caps into one unified
> structure?

No really.  I don't see any benefit, only the downside of having to come up with
a name that is intuitive when reading code related to both.

> (If the concern is about naming, we could brainstorm a more encompassing term
> for them)

