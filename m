Return-Path: <linux-kernel+bounces-37452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CF383B045
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27951C21CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B825E85C44;
	Wed, 24 Jan 2024 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ucR4+2gD"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B423F7E789
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118242; cv=none; b=DFt74ugcSoKEkyGIarQ5z0pcZ87V956NrgEjLrkPREZKayrJNtb8BUD4xtXQO+SYI9oBewCYF+CnyxjoUoMOAqgJBYgCfbymraIWrY6szqeENjTJk211yqqHQetW8H9WH0rogHvzH8NkI7HurOdLd0WuLR1dwiEHFgHK2Pd3dBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118242; c=relaxed/simple;
	bh=MZHuAtNiL03oEoJHa6bf7Od5Fg8D8o9NBf7iVEHZ9ag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UMJfBKOLYAJO/F5ipTAcxhzWacmHf5qBY30iIH6r1msWvb8juFQ6CMOEnBgaR1pVxBG/vCEBsZ1cb98ZSHRpSlmfx0pPr+DNaXXKCpENJDTfrSCyGX1Am5Rev7jhmaarhMvpBIjKiCw2uKHGeMFoo2Yczup6hM17WAV+NYQVimA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ucR4+2gD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5ca4ee5b97aso2708479a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706118240; x=1706723040; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=phLGUzO1dl3tbnC30bhE9/nw1oePNjTydqU1ZrBpVgU=;
        b=ucR4+2gDmiF/NDBhyFKzVAnIRpM6+RRFEjKVocLTvKqe+S3ZNF3WKjQHdcr8Tsln5w
         bwJ6d2E9h1LPkW4JGqW7aOcfI3yBXFoIjH7sZY+ui+S6roMemn00rIaIyBYogcW+z67X
         r5Ya3XFPCIx6/ynmJhG/PuXNcx8ev3vU96oIHU/7f0Gg65fi1dQdRRkmRvWBM1pWh4m5
         4ZnT/YUZg0SWL1OgkHfXt53o4D3ybfuhnC5pkdokeRTqNYN0PaHE8i3TulN3WUl0D11T
         1SyPH9wLB+sz6AVWUi1XcXqgaR8jOmwSbKEE8QYcI45i4XAQ+5S0AqF0txU3SSv5QOsD
         lhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706118240; x=1706723040;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phLGUzO1dl3tbnC30bhE9/nw1oePNjTydqU1ZrBpVgU=;
        b=eydUR0ald7bFTUA7lIepI+AIyLhm4GEXeoxu5qbGLQfnMOyRSCcjyGoK/ohOqRILPT
         R/vUleyWSooetPLsOxVJdg+gAstSZSB36fI+ELHuMtpgvL2/tyDASZQXdTmN/pUXEwnj
         asYMPKHPkTTRAUqHBMmekYzZi2o2OpnykUaS2BP4TMspszB/yvzsyRj2C7Oabhz1XfhD
         C3w0nXbTGyDQygLwK78Fi8N8pd8163iWH5LUrksRm/hP7bd7+BcJnnHDE0tAUbG/0YIW
         2oTriuddGwh0ikuvCVXDIKFle/a7HySjHDU8ybhH/O+L6REwCbhZwHEk9IKla/KnJNoI
         2MXQ==
X-Gm-Message-State: AOJu0Yxz4H+rrjvca4kv1qjarSPfgRn4KQ3eDlloK9l9KNrEIvPTijd/
	riX5ShG9E6MIE1XP2zEUPd5bGh3UqSyaNu0FPG58w0T5/i7MLjSgRJ4GF5tS2Ivv+aSoG8BvTMW
	MGg==
X-Google-Smtp-Source: AGHT+IH50wrWLE+dOd9vXG84ZvByuwmloXUXoNDIkK2WvQj7QWsB8hpAZLXMXP/PyBpBzNHdQEpsB43YjN8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:5652:0:b0:5ca:31a3:c70c with SMTP id
 g18-20020a635652000000b005ca31a3c70cmr42150pgm.3.1706118239933; Wed, 24 Jan
 2024 09:43:59 -0800 (PST)
Date: Wed, 24 Jan 2024 09:43:58 -0800
In-Reply-To: <20240124170243.93-1-moehanabichan@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZbE7kd9W8csPRjvU@google.com> <20240124170243.93-1-moehanabichan@outlook.com>
Message-ID: <ZbFMXtGmtIMavZKW@google.com>
Subject: Re: Re: [PATCH] KVM: x86: Check irqchip mode before create PIT
From: Sean Christopherson <seanjc@google.com>
To: moehanabi <moehanabichan@gmail.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pbonzini@redhat.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jan 25, 2024, moehanabi wrote:
> > On Thu, Jan 25, 2024, Brilliant Hanabi wrote:
> > > As the kvm api(https://docs.kernel.org/virt/kvm/api.html) reads,
> > > KVM_CREATE_PIT2 call is only valid after enabling in-kernel irqchip
> > > support via KVM_CREATE_IRQCHIP.
> > > 
> > > Without this check, I can create PIT first and enable irqchip-split
> > > then, which may cause the PIT invalid because of lacking of in-kernel
> > > PIC to inject the interrupt.
> > 
> > Does this cause actual problems beyond the PIT not working for the guest?  E.g.
> > does it put the host kernel at risk?  If the only problem is that the PIT doesn't
> > work as expected, I'm tempted to tweak the docs to say that KVM's PIT emulation
> > won't work without an in-kernel I/O APIC.  Rejecting the ioctl could theoertically
> > break misconfigured setups that happen to work, e.g. because the guest never uses
> > the PIT.
> 
> I don't think it will put the host kernel at risk. But that's exactly what
> kvmtool does: it creates in-kernel PIT first and set KVM_CREATE_IRQCHIP then.

Right.  My concern, which could be unfounded paranoia, is that rejecting an ioctl()
that used to succeed could break existing setups.  E.g. if a userspace VMM creates
a PIT and checks the ioctl() result, but its guest(s) never actually use the PIT
and so don't care that the PIT is busted.

> I found this problem because I was working on implementing a userspace PIC
> and PIT in kvmtool. As I planned, I'm going to commit a related patch to 
> kvmtool if this patch will be applied.
> 
> > > Signed-off-by: Brilliant Hanabi <moehanabichan@gmail.com>
> > > ---
> > >  arch/x86/kvm/x86.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index 27e23714e960..3edc8478310f 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -7016,6 +7016,8 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
> > >  		r = -EEXIST;
> > >  		if (kvm->arch.vpit)
> > >  			goto create_pit_unlock;
> > > +		if (!pic_in_kernel(kvm))
> > > +			goto create_pit_unlock;
> > 
> > -EEXIST is not an appropriate errno.
> 
> Which errno do you think is better?

Maybe ENOENT?

