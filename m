Return-Path: <linux-kernel+bounces-37809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2890783B5C4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2AB2288296
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA28136677;
	Wed, 24 Jan 2024 23:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g6jRY67m"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B72312C532
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 23:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706140779; cv=none; b=KPyAn6OsUmg6YA0HEhdVoFjPQuAGT7ouYK3xuYVWFazmVOfjTnXbs0IrMqTWW2l36TMwSn67sI5fbBA/Q1tXASUesF6S8yHcgtWUcwBb8x2kbMdAeOocDNg/EOPaGgCQG56gsNqZh60icvzf8NH12wTfjIz5Y7CwjrVQ7Yv2jI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706140779; c=relaxed/simple;
	bh=scENOXkY1wABPly8RGgZYqWRLrty6coqRZ73vXcMm0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r8wOlQMGdIeaZKxzz5Uo9SWHUg6F568txLp4uOwOaz6gNFGSpbDffbuGFVubaxzVCE6wbTfPRpT0arPw8AAj3vDrn+MPd74v1AO1dwjBsv6H6iwDE26+4bXXZUGERHI9dqUiuZYvU6fXgdhZJ863+dnFWAOYR7uVkogQAOB/+kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g6jRY67m; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5c5c8ef7d0dso3587183a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 15:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706140777; x=1706745577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KYf0G/iha9uYMgJquZY7B6AN3rc0OYW7kIi56vMpuic=;
        b=g6jRY67mIC3xapYBwdxUnaPQ1XxnCymYaIJzRUqpKkm/upL83ByOMwI+3ZejbwR1+B
         Kg1PoQvo+KvcsC0Ls8KqX9G88y5u630mqvm78rRp89oMCS0tei7mpBJbvilt8OOpzn7v
         TJhnogH8er0rnlwgXrAXdopshlgJ062hOmOI0NWXIc4OlQDDRrTMXQYBO+TsTDc5+YOQ
         gTlTCC/P7UZ2gWdp4kMwhoMlAi6UptcKXqREjvn+L8CxMGaZSFI4Aucuti1ZDj7gkq2u
         FKU+kYjhOXFHxHGncpJO1b38e0lr+AUMxYZ8HQppjCOjQYvD0a5CFTNzMpM75bM28yPa
         fSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706140777; x=1706745577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYf0G/iha9uYMgJquZY7B6AN3rc0OYW7kIi56vMpuic=;
        b=aL3rM+Kqb++4sJGJIEyQb50jpsNfSID1FyTMVZo7qcqc72qMmdi3xJyaI/qXhkkyRM
         knWWTLotnE/cX1Ai1L8X1UhCf8INKudNuXGjJwJYpDG/yNw6GA/Upz1gFD2FYNOmvaB9
         sQYmwpTwBob/QYRS9Z9cU0QFlp3PSu1EDCxZNsvyI+iDptTrjclOuWiPLKAM86XfbNAm
         bzwVCZLZtHzcQSqGulsyKJxjJmZpM+3XlQb3oWvdb2SI3NRyJV33hrClUUsgF+bzsNPy
         oNqB6y4vrrraBvTmseeB3qF/qokuy/DQMbDqJaGA/BhvqHWvQx6oDQfZTjQDxCB5k1ud
         w3FA==
X-Gm-Message-State: AOJu0Yz0oRO8neOYdO6GWAxOZnc/IA0ZfBnhM0a55kbFnXVOwGmbKFkv
	AN52jJhxLm5O/r1nXxiVBMS3jbA6zmIIuupdTRTY3CJ1p0uzJ+jWUSMOUKZdQDnIABp2izYyjNZ
	bog==
X-Google-Smtp-Source: AGHT+IGriMVgnsOLni0yAcaVoR6zDhSN+dZ55FV93lTp2LIDR22wkfjbtYKhrBRkbGfhxNjinrpfLzqmaUU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:59d:b0:5cd:fa8d:f3e1 with SMTP id
 by29-20020a056a02059d00b005cdfa8df3e1mr9pgb.4.1706140776563; Wed, 24 Jan 2024
 15:59:36 -0800 (PST)
Date: Wed, 24 Jan 2024 15:59:34 -0800
In-Reply-To: <20240124190158.230-1-moehanabichan@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZbFMXtGmtIMavZKW@google.com> <20240124190158.230-1-moehanabichan@outlook.com>
Message-ID: <ZbGkZlFmi1war6vq@google.com>
Subject: Re: Re: Re: [PATCH] KVM: x86: Check irqchip mode before create PIT
From: Sean Christopherson <seanjc@google.com>
To: Brilliant Hanabi <moehanabichan@gmail.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	pbonzini@redhat.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jan 25, 2024, Brilliant Hanabi wrote:
> > On Thu, Jan 25, 2024, moehanabi wrote:
> > > > On Thu, Jan 25, 2024, Brilliant Hanabi wrote:
> > > > > As the kvm api(https://docs.kernel.org/virt/kvm/api.html) reads,
> > > > > KVM_CREATE_PIT2 call is only valid after enabling in-kernel irqchip
> > > > > support via KVM_CREATE_IRQCHIP.
> > > > > 
> > > > > Without this check, I can create PIT first and enable irqchip-split
> > > > > then, which may cause the PIT invalid because of lacking of in-kernel
> > > > > PIC to inject the interrupt.
> > > > 
> > > > Does this cause actual problems beyond the PIT not working for the guest?  E.g.
> > > > does it put the host kernel at risk?  If the only problem is that the PIT doesn't
> > > > work as expected, I'm tempted to tweak the docs to say that KVM's PIT emulation
> > > > won't work without an in-kernel I/O APIC.  Rejecting the ioctl could theoertically
> > > > break misconfigured setups that happen to work, e.g. because the guest never uses
> > > > the PIT.
> > > 
> > > I don't think it will put the host kernel at risk. But that's exactly what
> > > kvmtool does: it creates in-kernel PIT first and set KVM_CREATE_IRQCHIP then.
> > 
> > Right.  My concern, which could be unfounded paranoia, is that rejecting an ioctl()
> > that used to succeed could break existing setups.  E.g. if a userspace VMM creates
> > a PIT and checks the ioctl() result, but its guest(s) never actually use the PIT
> > and so don't care that the PIT is busted.
> 
> Thanks for your review. In my opinion, it is better to avoid potential bugs
> which is difficult to detect, as long as you can return errors to let
> developers know about them in advance, although the kernel is not to blame
> for this bug.

Oh, I completely agree that explict errors are far better.  My only concern is
that there's a teeny tiny chance that rejecting an ioctl() that used to work
could break userspace.

> > > I found this problem because I was working on implementing a userspace PIC
> > > and PIT in kvmtool. As I planned, I'm going to commit a related patch to 
> > > kvmtool if this patch will be applied.
> > > 
> > > > > Signed-off-by: Brilliant Hanabi <moehanabichan@gmail.com>
> > > > > ---
> > > > >  arch/x86/kvm/x86.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > > 
> > > > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > > > index 27e23714e960..3edc8478310f 100644
> > > > > --- a/arch/x86/kvm/x86.c
> > > > > +++ b/arch/x86/kvm/x86.c
> > > > > @@ -7016,6 +7016,8 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
> > > > >  		r = -EEXIST;
> > > > >  		if (kvm->arch.vpit)
> > > > >  			goto create_pit_unlock;
> > > > > +		if (!pic_in_kernel(kvm))
> > > > > +			goto create_pit_unlock;
> > > > 
> > > > -EEXIST is not an appropriate errno.
> > > 
> > > Which errno do you think is better?
> > 
> > Maybe ENOENT?
> >
> 
> I'm glad to send a new version patch if you're willing to accept the
> patch.

Go ahead and send v2.  I'll get Paolo's thoughts on whether or not this is likely
to break userspace and we can go from there.

