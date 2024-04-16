Return-Path: <linux-kernel+bounces-147543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3558A7606
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E91B21BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177525A0FC;
	Tue, 16 Apr 2024 20:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H3On6KNN"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA634642B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 20:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713301125; cv=none; b=AvZEC+VQXI6nNDyzs0VOPL2X4oesPX8n8c2B78ruujkKLbCyh57fUpnyx1tcDYJ+Lwp0kz2Jzx3tUsejtWHrqw7McR8QUO9smeexDkIGZPgKrAeYls1QPWoeGACFBFnLdokDKvz653c09/vx7PqsJcCxM6tr776hcx3E6bNApc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713301125; c=relaxed/simple;
	bh=bjjR/fURKyfHFmb8z6eyjmRhKvFUd2k2glmj1sFt8TY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EXSinby4VajmninhuYOR8fAUJQ8c94mmYNP4p/nBusi3JDDKRvZB4JSmrW92pL8x5vbRwbYmblQtX9PkEPEQfjoay61R/FlOeZls6+ZVsy5TVQHlNGOwt52XnRMTHGmHluHsIB1QcCUwtzPk8XSiGS26mIB7rW97SS3Yf5UkLL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H3On6KNN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e2bbb6049eso40646085ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 13:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713301123; x=1713905923; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IagCFOK7GndGvbu+ZDoWmNTm5/xYC3EkHGls/RBs+eE=;
        b=H3On6KNNg2ioDvTnm28tUZx/2XnVZVpWM+yHDvimb2uNZQ9S/nqSaXiO4uKlKPIpsG
         lyzvwAWhjHKZciWICEqFyaT70PG75cMalF4C6T0A7NbtA2JDtezStpqoeszEgeerRbT1
         UpBsSl/R43nueyWZkToJuV9DDPGNA0q3XSFeDMSNNvrGfQRajvsT4lZ1tkmRhKMSXtbx
         FrY3f9Zjwwpa+jVhbe62MNpd0fMk0F4OsAuIUpuQU8Q/S6znO35g52TPUHtA5hfFt0Z7
         bHXVRp/u+IG48+54GaAu1dZGOrHlqBPbOVXHYumLTPQoSzugDSXXIbyCs3RjZHMCXEYM
         iaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713301123; x=1713905923;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IagCFOK7GndGvbu+ZDoWmNTm5/xYC3EkHGls/RBs+eE=;
        b=gAIINOfkEk6aH/3B3piXRZ0ISaBHa40v7hpF6n0yoSdpd21hWFMGnK3qRc4Nfm0yiK
         TwAgNwIfFkMjia5huGM9hl0jc2W2bU6MIX67X+7sJU0xWxKiTYqGmb3APVsR3uU04sG5
         uW/R//BFdO5/KsgZv/gIx6hy/nEV7zgF0D2xTdFLIzfjhs6Z+HVP4WzALnAYTaWDeMOI
         EmnYa0fJPpZBbJbVwX1bnuNGQMaHqbFzRTFugNxQHMKfa/fJ2Jdl/W2WS8xaEo8f4B6n
         YTDXvemSmmuNC7o6HJSodF3Rq95UJ2loLKtRXlja0OFPbqjw/wAKe3LNtU4jBZ/2UDM3
         M8KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXif/FtpaC2s9fOVWuPLrP/sGjmHo+nTZJTRG7wcc2TQ6WEIoLBXxEc++3BLs+DXD7sPLfiZVr0CPP9RQjuzQ0/xb8o0zTpcafxny1o
X-Gm-Message-State: AOJu0YxboO6gYH4PV30hj5e37FtYi72rZpcOpMpTfvIdBo4QKjf7waoF
	0EauLMdTrU6DgoYRr1+zZt3g7ozX5Mbo9Hzc8bX9u1gwojeXKLqyiMQumycgy1VY+oiC+nsxqJb
	/fQ==
X-Google-Smtp-Source: AGHT+IHM0igWGyveTIsywC1hHuxGax11ZYRkRW3LmLhKG0+KgIA6kBXRwvb0slBN7N43sMi/dsG5kwiUI0M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e88a:b0:1e6:624c:f849 with SMTP id
 w10-20020a170902e88a00b001e6624cf849mr544995plg.4.1713301123335; Tue, 16 Apr
 2024 13:58:43 -0700 (PDT)
Date: Tue, 16 Apr 2024 13:58:41 -0700
In-Reply-To: <6cd2a9ce-f46a-44d0-9f76-8e493b940dc4@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1708933498.git.isaku.yamahata@intel.com>
 <f028d43abeadaa3134297d28fb99f283445c0333.1708933498.git.isaku.yamahata@intel.com>
 <d45bb93fb5fc18e7cda97d587dad4a1c987496a1.camel@intel.com>
 <20240322212321.GA1994522@ls.amr.corp.intel.com> <461b78c38ffb3e59229caa806b6ed22e2c847b77.camel@intel.com>
 <ZhawUG0BduPVvVhN@google.com> <8afbb648-b105-4e04-bf90-0572f589f58c@intel.com>
 <Zhftbqo-0lW-uGGg@google.com> <6cd2a9ce-f46a-44d0-9f76-8e493b940dc4@intel.com>
Message-ID: <Zh7KrSwJXu-odQpN@google.com>
Subject: Re: [PATCH v19 023/130] KVM: TDX: Initialize the TDX module when
 loading the KVM intel kernel module
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>, Tina Zhang <tina.zhang@intel.com>, 
	Hang Yuan <hang.yuan@intel.com>, Bo Chen <chen.bo@intel.com>, 
	"sagis@google.com" <sagis@google.com>, "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Erdem Aktas <erdemaktas@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"isaku.yamahata@linux.intel.com" <isaku.yamahata@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 12, 2024, Kai Huang wrote:
> On 12/04/2024 2:03 am, Sean Christopherson wrote:
> > On Thu, Apr 11, 2024, Kai Huang wrote:
> > > I can certainly follow up with this and generate a reviewable patchset if I
> > > can confirm with you that this is what you want?
> > 
> > Yes, I think it's the right direction.  I still have minor concerns about VMX
> > being enabled while kvm.ko is loaded, which means that VMXON will _always_ be
> > enabled if KVM is built-in.  But after seeing the complexity that is needed to
> > safely initialize TDX, and after seeing just how much complexity KVM already
> > has because it enables VMX on-demand (I hadn't actually tried removing that code
> > before), I think the cost of that complexity far outweighs the risk of "always"
> > being post-VMXON.
> 
> Does always leaving VMXON have any actual damage, given we have emergency
> virtualization shutdown?

Being post-VMXON increases the risk of kexec() into the kdump kernel failing.
The tradeoffs that we're trying to balance are: is the risk of kexec() failing
due to the complexity of the emergency VMX code higher than the risk of us breaking
things in general due to taking on a ton of complexity to juggle VMXON for TDX?

After seeing the latest round of TDX code, my opinion is that being post-VMXON
is less risky overall, in no small part because we need that to work anyways for
hosts that are actively running VMs.

> > Within reason, I recommend getting feedback from others before you spend _too_
> > much time on this.  It's entirely possible I'm missing/forgetting some other angle.
> 
> Sure.  Could you suggest who should we try to get feedback from?
> 
> Perhaps you can just help to Cc them?

I didn't have anyone in particular in mind, I just really want *someone* to weigh
in as a sanity check.

