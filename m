Return-Path: <linux-kernel+bounces-94671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D084C8742EC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666411F22E62
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEA81C294;
	Wed,  6 Mar 2024 22:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a0QuFOVj"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4431FA4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 22:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709765037; cv=none; b=AXD7K6c6lrgf0Z7h7JIEdgtUXwzwDYzy2ObNvx9bLNCjhTj4fVZp2KvOkE5NDLbzDuLUHwwORTR/erng2w5hhbzZiNg58J9DLrpY+A2aeTX3r6PLejj+RKgAhChZs5Tr1M4FQWG1wR7nw4PXUR8IJvwTUYRcVJ2kdXFjK/0t2ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709765037; c=relaxed/simple;
	bh=/HhmgHY9Vyo2JQaInrFC98id0ADUFYLs567EtUvXnXw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u+hzYfmeSqY9d25S6ihVoz5nzzqZMWUlCtZbQLQDqbpaC/HjiO82XGLEuiLR2/mDfU5Bal8Plf2HgYJH7m//hIui+43xVVjPjy6MkhUkxEsKTy4uRjOT8wvY0mvyNBA5vT/YaMNt4NNNIS/OSYCLwz/Ftf/Qs96ad5UO1lq0Okw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a0QuFOVj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609f015e386so592557b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 14:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709765034; x=1710369834; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kYeF/kACf7fpncWg98H8xfi7RXLHudnXWCpEy+NEJ2g=;
        b=a0QuFOVjcDcIIAy4T76L90YwKpTits+1HtAvGasuZR2unuVp75Egd+4kwtib2nLUaC
         VoB1fycOqjd6YrnpgzRr0HqQFSdW1lbbgbP1vOa6pvAukRTds96OJ+kWK85oZZ1sxPMR
         pgNgdpinDnYc6CO12RgccF9E9G6l8+afE3T31EYhnMhTBTt/sUsIOf3spAFZX/GOed6W
         y4hzlM1tjWEtrHxGmbe1NVXbj28A+2lnyHcQLPdRp46pDO9iAUldeNbSBkmYNlzHLpQY
         1ERBp7nniX2VvEdOqSj70JMowNY55zxC92osIAaUO5UpKUD8U3rbpRIH87b+vspwn8u+
         BfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709765034; x=1710369834;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kYeF/kACf7fpncWg98H8xfi7RXLHudnXWCpEy+NEJ2g=;
        b=uSOj2x7MMx3yjxKceMb6b/V6taZyHw4LwKSKd7+bncHKOKCEYPCGsQyZIKWKt9KHJA
         SpDgGglHIHBd5E81l3EjRMP/s4R7YjPJXh0oIQSUF+IAR9WTUtD/sPtR5Y+XXtoOqtUU
         MYLNkkwW4QJeHcPhxI9pW5gCJ58cBcLPGuJIxrtdGII0WVmr9/l4eutPwsmDsxPRagbM
         Z+HFD53oEv6jVL8BhJ9Pt+mYUXPQ84UZos/sh17n9+niTDAc3sVUem4129vt7Ahp+tmS
         /HoSUe+EpJmm+N7ZGLzEYgtPd1MPWROLrht+GdmyBYcQkW5pHBifnqE6vuPSwDyoof2p
         CSbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvoA6E14mhudDGpzroCKJTduQF41flEkGVkKuAm60N5OroUgd2ul6iUFbFeBQWRdMVzJOWBfiE1SmIDie7xd+eX+bbVi4L0wnITEgI
X-Gm-Message-State: AOJu0YyNfYVx0W0RwAw9OWMKeqVvJ0vmnxLrUXqkeWBn6fWlQG+AiBfu
	qOUGuithjkj/tp78w9DEfjMpIj0a+H3qicG+BzuTW99abOpwxrLh4MScbtiSmEYzv6/xum2tYj4
	qMA==
X-Google-Smtp-Source: AGHT+IE0lG2XpGXkBwtp0+gcBIrfYiqpLawDQO9qlP+0KYjaaDjD9LVzh573CU0NXKCcbck1ASNBIpC3STo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:110a:b0:dc7:49a9:6666 with SMTP id
 o10-20020a056902110a00b00dc749a96666mr4059310ybu.3.1709765034707; Wed, 06 Mar
 2024 14:43:54 -0800 (PST)
Date: Wed, 6 Mar 2024 14:43:53 -0800
In-Reply-To: <0a05d5ec-5352-4bab-96ae-2fa35235477c@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228024147.41573-1-seanjc@google.com> <20240228024147.41573-12-seanjc@google.com>
 <0a05d5ec-5352-4bab-96ae-2fa35235477c@intel.com>
Message-ID: <ZejxqaEBi3q0TU_d@google.com>
Subject: Re: [PATCH 11/16] KVM: x86/mmu: Explicitly disallow private accesses
 to emulated MMIO
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
> > Explicitly detect and disallow private accesses to emulated MMIO in
> > kvm_handle_noslot_fault() instead of relying on kvm_faultin_pfn_private()
> > to perform the check.  This will allow the page fault path to go straight
> > to kvm_handle_noslot_fault() without bouncing through __kvm_faultin_pfn().
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/kvm/mmu/mmu.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 5c8caab64ba2..ebdb3fcce3dc 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -3314,6 +3314,11 @@ static int kvm_handle_noslot_fault(struct kvm_vcpu *vcpu,
> >   {
> >   	gva_t gva = fault->is_tdp ? 0 : fault->addr;
> > +	if (fault->is_private) {
> > +		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> > +		return -EFAULT;
> > +	}
> > +
> 
> As mentioned in another reply in this series, unless I am mistaken, for TDX
> guest the _first_ MMIO access would still cause EPT violation with MMIO GFN
> being private.
> 
> Returning to userspace cannot really help here because the MMIO mapping is
> inside the guest.

That's a guest bug.  The guest *knows* it's a TDX VM, it *has* to know.  Accessing
emulated MMIO and thus taking a #VE before enabling paging is nonsensical.  Either
enable paging and setup MMIO regions as shared, or go straight to TDCALL.

> 
> I am hoping I am missing something here?

