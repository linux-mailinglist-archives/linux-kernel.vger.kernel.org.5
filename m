Return-Path: <linux-kernel+bounces-94801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06244874568
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D69283639
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58AC4A28;
	Thu,  7 Mar 2024 01:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="22oIZVTw"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37451879
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 01:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709773288; cv=none; b=M+cw3qWzl7hyA7IV6Ei20qBE2/ZswONi1iolGtJH+Fpz+NdT7GD3i+cgztu6EIdccDVgONBh2DZkray2+CnqwonzOAeByqtijj1p6W6IY3vL/krt9qdxNTz9kQDNtHtwHM7MCRRWmiw6VrJgxLgL3d3+HO/Ye2mAEw1uQQiR844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709773288; c=relaxed/simple;
	bh=Y4kUrnue3EZY1EGSrXHEbnh72bjZS/mb0XRvJStSWHk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mROTTm0tl2Xim8ChZejb8SrN8rFZwTMUY2JAu9VozkWjuzOxXzwqnmCBQ6eeLGSFb468aENTm4JbzyrK3J0KPoI+hNjQg2Msn85CdhX4J3LLHylsajjmoBM2MTWtcAV7UUKhyE+vV0ybEOwRa/c48EFG9bDaB7pOGe4HtU9+DA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=22oIZVTw; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5dc4ffda13fso1232054a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 17:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709773286; x=1710378086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZlgJYygJYHQHiDndRSnH1C84bNZnosw6HlMLsiapoI=;
        b=22oIZVTwZNHaderoffRMGD4E3P14UYiw0RRPDhIPcBmuSK/V/JFWHi0iMCSVhbztJo
         WhclS+alqgwyj4NjHX0Rru+nMLyNyJzs1KZ7v8WTybNgqrkrEHSAiQoMBLmyFBPjVPKi
         Rmg2WNsqrclOA7MHDKOslRHJecJRJisBiH6j2FgMwQ3VZ5AnR7VqQ0IZCFnVnxbTflb7
         mlRCVnsEkKo/qEC4bBC1rrkTBMxnRuzRuNLGFMyNV/1mVzheCnnN1H98UQbBh00KegyI
         2p6xbKzjwO+5aEjyQ1vwTdulII0CPyZ4xO3V8+pQa+QOJ2SDDmO2J2n4/HivsiFVNu11
         IccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709773286; x=1710378086;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZlgJYygJYHQHiDndRSnH1C84bNZnosw6HlMLsiapoI=;
        b=X+W2QT0P2RoKC0ZTMDm8hTfIHujNN9Eoq1CSnDXyDE91BFcbKrJMyk5Rhgfg7Euaxj
         VBPizGmsH+b20eQZdOGLOlLIwlRxCRz13sXhNW0frVVsMgYdEKTxpNCDA35EQmfsKYh/
         Rt+L31y5wrKfa+s2dPmfm6YFgH9OMau2XMJpP0/0SI6Ti52YZH1soVnokxuB4uBszDZ8
         QXd2Eqz4U4zExAOecDNONa9tBMXqU7u9dUca6Bt/S+4w+LlUDUN31lH9VkWe3YtM2g50
         bDqDKlHrX3DcYb2oEKjC8cVhCHND7gST2iF5dN37qH5xdKUcvccCeRDPzsU5sArpLz69
         coVg==
X-Forwarded-Encrypted: i=1; AJvYcCVXLVWzdtUfuZ3dE2LCMlbTCKQ7M1t1CtcVv4OLCIxS+ytjhPiQnq1i4/MFkI5vBW7kKZWriwhieZ301qEyhIHWuD2EdrcUjNbqriuM
X-Gm-Message-State: AOJu0YybvXzBbZIdC9LK6vq+Cc/U5llWy5OBCdJZ4fgIlNifBEn72MGu
	ya7+oIEZBf+u/Ks6XItijBgsAy/OEjse+i1JlFRP424/lUS6/VAxyjMYDu0SCKL//KP9P5T4dlZ
	DVw==
X-Google-Smtp-Source: AGHT+IF1rh6o5D7ewPymuDgv6YF26aXud0lJlwQ5o2IVgcmib3JwNZW0YZx8b6H85dAZdVuKAqrGWoI3EtE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1809:b0:29b:312b:fbf5 with SMTP id
 lw9-20020a17090b180900b0029b312bfbf5mr0pjb.2.1709773284070; Wed, 06 Mar 2024
 17:01:24 -0800 (PST)
Date: Wed, 6 Mar 2024 17:01:22 -0800
In-Reply-To: <57e68a47-42fb-4029-a46a-c81d1522f7ff@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228024147.41573-1-seanjc@google.com> <20240228024147.41573-15-seanjc@google.com>
 <57e68a47-42fb-4029-a46a-c81d1522f7ff@intel.com>
Message-ID: <ZekR4j-hsXDFD6K2@google.com>
Subject: Re: [PATCH 14/16] KVM: x86/mmu: Set kvm_page_fault.hva to
 KVM_HVA_ERR_BAD for "no slot" faults
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 07, 2024, Kai Huang wrote:
> 
> 
> On 28/02/2024 3:41 pm, Sean Christopherson wrote:
> > Explicitly set fault->hva to KVM_HVA_ERR_BAD when handling a "no slot"
> > fault to ensure that KVM doesn't use a bogus virtual address, e.g. if
> > there *was* a slot but it's unusable (APIC access page), or if there
> > really was no slot, in which case fault->hva will be '0' (which is a
> > legal address for x86).
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/kvm/mmu/mmu.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 4dee0999a66e..43f24a74571a 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -3325,6 +3325,7 @@ static int kvm_handle_noslot_fault(struct kvm_vcpu *vcpu,
> >   	fault->slot = NULL;
> >   	fault->pfn = KVM_PFN_NOSLOT;
> >   	fault->map_writable = false;
> > +	fault->hva = KVM_HVA_ERR_BAD;
> >   	/*
> >   	 * If MMIO caching is disabled, emulate immediately without
> 
> Not sure why this cannot be merged to the previous one?

Purely because (before the previous patch) kvm_faultin_pfn() only paved over pfn,
slot, and map_writable.  I highly doubt clobbering hva will break anything, but
just in case...

