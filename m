Return-Path: <linux-kernel+bounces-99698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507C1878BEC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71AF31C214E2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DF763C;
	Tue, 12 Mar 2024 00:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3/Xcn34j"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A556B19B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 00:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710203151; cv=none; b=Q5r23g8tQEmneVnmv5bHUkykNROjLLBig2Uc0nc1/c7sQTF4LkrkOQuk/PzXTueuIYcsTrr8pBt+mktS9AOxU2Bqe9mu3QdNCUOr0SpQGvYa51KitIyaCeMm03DBhJtCBu7op409f/iwi/feKEPpZlWPyTLI4dH4LQ/fKkbqm5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710203151; c=relaxed/simple;
	bh=DN4kgqkguxDqDuzpxWOfE0S71IXcgVo6miwC7b+9qOw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bwMlUZanSC8uzDDh0VxbQ7SEE4jqFrfgHfepMGuzoEuWqexdLnc905K2ZoNKESDYyvVNj91Pp60WlVWmyMvyyKe2b8WRqtBtPE3HyRYWh7+f3SVy9ta5rpLVpcqYLQpccE+MpcDzBUxiDDdaOL6JRNqsLEJEF6lKF2OjHGlJJQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3/Xcn34j; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60832a48684so74375647b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710203149; x=1710807949; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DSKE9dynpVDGdnjTP2PPz0UtHmW2LY6em1fpB/+NyBg=;
        b=3/Xcn34j/nGHh3CzJjVJwx5sC5qPTQNUUoZAmSVL2XfV1iKowyqSj/WJLHalLEdYLr
         BY3WjtBhABWunzDKuv0wI2AvencPnZNTZktMkF77HsreOXEcBuKzdSIYGlhT8uAb7N5n
         kBnoFxXICP9tok1lvDDbeli/h4rcV8lCK9wBi4A63BbKYxguvs810DGY/L5fL0fiEnNE
         NCIopgKPosSfAmu7Tg+E20YmGZq1BrsxvxgW6Keeyq0gDAuVRIihPVYqG4e8ffUMq6yX
         apV1AHbYUGzbP4BQe8dBgB98WZ7EcQ2XUzVTq9YbM8wmx9pTtF8axl+XaeM6j+CdzT5h
         vrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710203149; x=1710807949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSKE9dynpVDGdnjTP2PPz0UtHmW2LY6em1fpB/+NyBg=;
        b=SsPK074CFV84M5y7CFOFVqi7plVRfIH79+O0SzvPBwZUC4CHQWoGbQodPTh0Ju+rzR
         SGuvoKZEAgVCod+Ke1D/te4Dpp5yTM9Xrmt2y4jwmik9TtISsdXbD3AIXx0CXBdKZokF
         zSDKOrx9XdudBmoLoKQHUMZxmNreD3Tol51LdYxAnB7X2qLJU/PtxH141uugxjszBpqB
         QgY/tFVt8QqSwTIuIOR5KgI14TFhvu6avU5XbvWRzCBF0WsBLVzIdlRrXWxaSucST6sF
         B8I8UOz3KkRILfnGdlDkfxqPRCKw9+xLOz/bqLKtL1RA0vHGcA6v4YqtXmHh4wtOb33/
         bkqw==
X-Forwarded-Encrypted: i=1; AJvYcCW9e9hjJ8SqSM6L+GO6pVF3dnjwZEFhDqShz2Y7n9uaCh6BvDsgAcdzIGnRlqdKfWOh8RtYldg3f69XLneKiHc11HdmPkWVod51j71Z
X-Gm-Message-State: AOJu0YzoJr0SH3Gwcqdf5w10cKxTX7ZvSPqGLNzPCjRjpmwwCSTZUApm
	vkInuKLaDwAssgkxWQoKKBwphE7yRvFAXmMkHdMQ3mpbURhgPcjMP4CE45aLlk2bh2SqrIHOIHd
	TCg==
X-Google-Smtp-Source: AGHT+IGzoNaeLD5UF6HPjQNHq3cJfFHLeuCdtnN3G+/43PHfTFE8knrmObKsB05Sk+y7M0LF1sr9r44xtTU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d486:0:b0:60a:2eb9:539a with SMTP id
 w128-20020a0dd486000000b0060a2eb9539amr1057117ywd.2.1710203148785; Mon, 11
 Mar 2024 17:25:48 -0700 (PDT)
Date: Mon, 11 Mar 2024 17:25:47 -0700
In-Reply-To: <Ze5bee/qJ41IESdk@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309010929.1403984-1-seanjc@google.com> <20240309010929.1403984-6-seanjc@google.com>
 <Ze5bee/qJ41IESdk@yzhao56-desk.sh.intel.com>
Message-ID: <Ze-hC8NozVbOQQIT@google.com>
Subject: Re: [PATCH 5/5] KVM: VMX: Always honor guest PAT on CPUs that support self-snoop
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, kvm@vger.kernel.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Tian <kevin.tian@intel.com>, Yiwei Zhang <zzyiwei@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 11, 2024, Yan Zhao wrote:
> On Fri, Mar 08, 2024 at 05:09:29PM -0800, Sean Christopherson wrote:
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 17a8e4fdf9c4..5dc4c24ae203 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -7605,11 +7605,13 @@ static u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
> >  
> >  	/*
> >  	 * Force WB and ignore guest PAT if the VM does NOT have a non-coherent
> > -	 * device attached.  Letting the guest control memory types on Intel
> > -	 * CPUs may result in unexpected behavior, and so KVM's ABI is to trust
> > -	 * the guest to behave only as a last resort.
> > +	 * device attached and the CPU doesn't support self-snoop.  Letting the
> > +	 * guest control memory types on Intel CPUs without self-snoop may
> > +	 * result in unexpected behavior, and so KVM's (historical) ABI is to
> > +	 * trust the guest to behave only as a last resort.
> >  	 */
> > -	if (!kvm_arch_has_noncoherent_dma(vcpu->kvm))
> > +	if (!static_cpu_has(X86_FEATURE_SELFSNOOP) &&
> > +	    !kvm_arch_has_noncoherent_dma(vcpu->kvm))
> >  		return (MTRR_TYPE_WRBACK << VMX_EPT_MT_EPTE_SHIFT) | VMX_EPT_IPAT_BIT;
> 
> For the case of !static_cpu_has(X86_FEATURE_SELFSNOOP) &&
> kvm_arch_has_noncoherent_dma(vcpu->kvm), I think we at least should warn
> about unsafe before honoring guest memory type.

I don't think it gains us enough to offset the potential pain such a message
would bring.  Assuming the warning isn't outright ignored, the most likely scenario
is that the warning will cause random end users to worry that the setup they've
been running for years is broken, when in reality it's probably just fine for their
use case.

I would be quite surprised if there are people running untrusted workloads on
10+ year old silicon *and* have passthrough devices and non-coherent IOMMUs/DMA.
And anyone exposing a device directly to an untrusted workload really should have
done their homework.

And it's not like we're going to change KVM's historical behavior at this point.

> Though it's a KVM's historical ABI, it's not safe in the security perspective
> because page aliasing without proper cache flush handling on CPUs without
> self-snoop may open a door for guest to read uninitialized host data.
> e.g. when there's a noncoherent DMA device attached, and if there's a memory
> region that is not pinned in vfio/iommufd side, (e.g. memory region in vfio's
> skipped section), then though the guest memory from this memory region is not
> accessible to noncoherent DMAs, vCPUs can still access this part of guest memory.
> Then if vCPUs use WC as guest type, it may bypass host's initialization data in
> cache and read stale data in host, causing information leak.
> 
> My preference is still to force WB
> (i.e. (MTRR_TYPE_WRBACK << VMX_EPT_MT_EPTE_SHIFT) | VMX_EPT_IPAT_BIT) in case of
> !static_cpu_has(X86_FEATURE_SELFSNOOP) && kvm_arch_has_noncoherent_dma(vcpu->kvm).
> Firstly, it's because there're few CPUs with features VMX without self-snoop;

This is unfortunately not true.  I don't know the details, but apparently all
Intel CPUs before Ivy Bridge had a one or more related errata.

/*
 * Processors which have self-snooping capability can handle conflicting
 * memory type across CPUs by snooping its own cache. However, there exists
 * CPU models in which having conflicting memory types still leads to
 * unpredictable behavior, machine check errors, or hangs. Clear this
 * feature to prevent its use on machines with known erratas.
 */
static void check_memory_type_self_snoop_errata(struct cpuinfo_x86 *c)
{
	switch (c->x86_model) {
	case INTEL_FAM6_CORE_YONAH:
	case INTEL_FAM6_CORE2_MEROM:
	case INTEL_FAM6_CORE2_MEROM_L:
	case INTEL_FAM6_CORE2_PENRYN:
	case INTEL_FAM6_CORE2_DUNNINGTON:
	case INTEL_FAM6_NEHALEM:
	case INTEL_FAM6_NEHALEM_G:
	case INTEL_FAM6_NEHALEM_EP:
	case INTEL_FAM6_NEHALEM_EX:
	case INTEL_FAM6_WESTMERE:
	case INTEL_FAM6_WESTMERE_EP:
	case INTEL_FAM6_SANDYBRIDGE:
		setup_clear_cpu_cap(X86_FEATURE_SELFSNOOP);
	}
}

> Secondly, security takes priority over functionality :)

Yeah, but not breaking userspace for setups that have existed for 10+ years takes
priority over all of that :-)

