Return-Path: <linux-kernel+bounces-47028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55C5844834
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468EC28EA1B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85B53EA93;
	Wed, 31 Jan 2024 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wnstmyq6"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D0E3E49D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706730187; cv=none; b=pHYic26STS+NIJg0KbZV0r10nV25kM16CLK7GXYSOLwjNbttx34HhVwq3w3p0cWHzetuO6RyPo5t0GGOcCdRo2u5cyH8SiCEZ16dHhWoUrP5TnlNE8mI/bDsBA28dEnOLoa+N/sbhRIhCzruzHIBdCN5Wvu+en/GZ8S1dbXW4o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706730187; c=relaxed/simple;
	bh=i4zKc6NhXiMSl9AuIN6/Dd9lQJhIilwgHlR+1G0X1UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvWaJcTmkR1SRTGXmchokXBdHU+N7/Ki8oO770+V1oOwzuVv4CldscdkGQ/iCw9lNRBQlGWiJ5kjlnlPjiRHQGKekMEQdptpLTKbQMpVB1kI0PeXCCL9lsx5OiTMztuexaTk/HuXH1LaB4OnYXYaE1UawbZ20m+kCiKcFpjliMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wnstmyq6; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso176793a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706730185; x=1707334985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cr3/DP7XTiupTVnBc4u5yU3Y9Y+FH/h9EKQ8I83CyCY=;
        b=wnstmyq6/yomqAUwPSvsMekgX0N7AtuzgzhJINNIYohbb3+/7XO+LHSeDSbrXcKVu3
         JdkyNbuqECFaqv+Z7SHiEdp20OwFy472hJUV3be43veAreiPW3kbvHgCkLFNyDnLAw10
         LqhaSkxiAgsQPdBkI/ce41sYsAYsaobupY6NJBLlMrpLABPhvthD1dQTlAurVcrduZAR
         4NnqRlY28q4R493yWYkAFqN/Fwm1kGtfwtOhhsxcNtILVALp5bLt+Mvf2cYHZejCrp+2
         OTE1PXiriZVxmAgs7Alh3u5kodkIRuZsFh1dMC7Ge0CgOm/FdCSG1aBtXDSzDYKWpprP
         JO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706730185; x=1707334985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cr3/DP7XTiupTVnBc4u5yU3Y9Y+FH/h9EKQ8I83CyCY=;
        b=e2n2inCvelpe3wDAokn2f1VzGayw6lTjsUbnYWLFuLXdUcubcJYhKSjqsAAXfgu1KE
         GaNqNIFDGib7pV6O7pl6TICBEvtT/PdW90oEZpAmEDErivJc9qYmX3PpRPfEWx0pj3ZM
         JaiDPk+Q9kAfifzHkvSEjYYhAVrMaMdqFrp0rF4i7mzpdlPOZfMhRYkja48zTv77ARbi
         R6y42qW82p885lULCSm/giPOr4kv74DuOl5cK27FSjvbJ1hkKs6ntGgIxaiLUlhfgj9+
         PukfxLV3FRP7ERhLFliNFR2ydU8Y8f0klOKCPBxnfb9GkGeygC1oaaR3jW9s0Mkt19SE
         UIjA==
X-Gm-Message-State: AOJu0Yxx4UiFn3bAPi5ZXLFaebGTnDwt7TNacd6qaqBzKDGTdaHBKStS
	BM8T9v9EafMkGFzsFCTLUIioX0nKoqABjo/6SgbY/okoL8qx8UxpFI5zbnFGQw==
X-Google-Smtp-Source: AGHT+IErewNCzDxtDqxxve/kaGns/6aAXmrX8n0YftYoz4uvZgGJp1nrQ+douz8Gg1swOGne1Q1TpA==
X-Received: by 2002:a05:6a20:ba7:b0:19c:a980:58d6 with SMTP id i39-20020a056a200ba700b0019ca98058d6mr2532369pzh.2.1706730184553;
        Wed, 31 Jan 2024 11:43:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW+Pmwekr6pGKH43l8LTrTPx/TDT45wLMdyer8MiHn77z1PbTGEAX/+GPDXwv4AgP1vTdvy17rkOYYaZn6Ea7m559tkEgbSRrADfrrclpVj+PoiJclfnEWeatlWnBp6Lfigo/4OEXNez77qvOL+x4NhYyJqheGkBKZGLHJAyyXokB3u6mOHtpe/oq8yIjgf+VHosCqSZ8Jo05W7AA==
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id nc8-20020a17090b37c800b0028c8a2a9c73sm1926517pjb.25.2024.01.31.11.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 11:43:04 -0800 (PST)
Date: Wed, 31 Jan 2024 19:43:00 +0000
From: Mingwei Zhang <mizhang@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Aaron Lewis <aaronlewis@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: x86/pmu: Reset perf_capabilities in vcpu to 0
 if PDCM is disabled
Message-ID: <ZbqixOTlp61Lp-JV@google.com>
References: <20240124003858.3954822-1-mizhang@google.com>
 <20240124003858.3954822-2-mizhang@google.com>
 <ZbExcMMl-IAzJrfx@google.com>
 <CAAAPnDFAvJBuETUsBScX6WqSbf_j=5h_CpWwrPHwXdBxDg_LFQ@mail.gmail.com>
 <ZbGAXpFUso9JzIjo@google.com>
 <ZbGOK9m6UKkQ38bK@google.com>
 <ZbGUfmn-ZAe4lkiN@google.com>
 <b0b5ba26-505e-4247-b30d-9ba2bb0301c1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0b5ba26-505e-4247-b30d-9ba2bb0301c1@redhat.com>

On Mon, Jan 29, 2024, Paolo Bonzini wrote:
> On 1/24/24 23:51, Sean Christopherson wrote:
> > > If we follow the suggestion by removing the initial value at vCPU
> > > creation time, then I think it breaks the existing VMM code, since that
> > > requires VMM to explicitly set the MSR, which I am not sure we do today.
> > Yeah, I'm hoping we can squeak by without breaking existing setups.
> > 
> > I'm 99% certain QEMU is ok, as QEMU has explicitly set MSR_IA32_PERF_CAPABILITIES
> > since support for PDCM/PERF_CAPABILITIES was added by commit ea39f9b643
> > ("target/i386: define a new MSR based feature word - FEAT_PERF_CAPABILITIES").
> > 
> > Frankly, if our VMM doesn't do the same, then it's wildly busted.  Relying on
> > KVM to define the vCPU is irresponsible, to put it nicely.
> 
> Yes, I tend to agree.

Discussed with Sean offline. Yes, I also agree that this should be
handled at VMM level. MSR_IA32_PERF_CAPABILITIES should be regarded as
part of the CPUID, or sort of. The diff is that its own
"KVM_GET_SUPPORTED_CPUID" (ie., the default value) should come from
KVM_GET_MSRS of the device ioctl.

Providing the default value for MSR_IA32_PERF_CAPABILITIES is really
making things messed. KVM has to always guard access to the cached guest
value with the checking of X86_FEATURE_PDCM. I believe
guest_cpuid_has(vcpu, X86_FEATURE_PDCM) will take runtime cost.

> 
> What QEMU does goes from the squeaky clean to the very debatable depending
> on the parameters you give it.
> 
> With "-cpu Haswell" and similar, it will provide values for all CPUID and
> MSR bits that match as much as possible values from an actual CPU model.  It
> will complain if there are some values that do not match[1].
> 
> With "-cpu host", it will copy values from KVM_GET_SUPPORTED_CPUID and from
> the feature MSRs, but only for features that it knows about.
> 
> With "-cpu host,migratable=no", it will copy values from
> KVM_GET_SUPPORTED_CPUID and from the feature MSRs, but only for *feature
> words* (CPUID registers, or MSRs) that it knows about.  This is where it
> becomes debatable, because a CPUID bit could be added without QEMU knowing
> the corresponding MSR.  In this case, the user probably expects the MSR to
> have a nonzero.  On one hand I agree that it would be irresponsible, on the
> other hand that's the point of "-cpu host,migratable=no".
> 
> If you want to proceed with the change, I don't have any problem with
> considering it a QEMU bug that it doesn't copy over to the guest any unknown
> leaves or MSRs.
> 
reply from another thread: CrosVM issue is not related to this one. It
might have something to do with KVM_GET_MSR_INDEX_LIST. I will come up
details later.
> Paolo
> 
> [1] Unfortunately it's not fatal because there are way way too many models,
> and also because until recently TCG lacked AVX---and therefore could only
> emulate completely some very old CPU models.  But with "-cpu
> Haswell,enforce" then everything's clean.
> 

