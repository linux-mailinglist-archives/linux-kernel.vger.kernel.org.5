Return-Path: <linux-kernel+bounces-87317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB24986D297
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C54288591
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E39F134423;
	Thu, 29 Feb 2024 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kz0bMdNp"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2AC7A730
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232862; cv=none; b=crBzkDA0+1feDQA952wqQSD3kDbNzvMTzv0Oe72ksttQkG//DQ7thnysBZwXqLZbpdpOQhlcNzCAZ1Zonbnn5ogfGfNPQn0i7mx524hgpiKyYxjsZ0Ipxuu3sxbrQYjRYvRZb2QKtu49LIXNo74bojc4Rq8nW3NPkGwHttp3Qqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232862; c=relaxed/simple;
	bh=c3H3vBFipsXo3Sef6GdzrpDZnYGyG/8rNuySDhgx7MU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rhJQAXfgNwTyFichgFe4tQP3Im13LOiLRrssjzpZEq3Gl5pIvcPRRzO5eSkb5rxmKYwQ31PAemzQlS5Dh9wP4UyEiRttZtbyI+tNpT6nw/ai2TuhUpR1x5VaxJlFSG6wGWkAf5nj5ud3qE+nmBABOllPt1PH3m2FeRfN+Ar+a+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kz0bMdNp; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf216080f5so2079909276.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709232860; x=1709837660; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T5dFvqCRIbO656OOkYJr9SD1ZDKhVN7MuRH/M19ZUc4=;
        b=Kz0bMdNpg5P5GRj0peYH1lYzxhoeGeRPf3eViYvuw487ZCOszgOjq5JPtVBB7OLOUj
         ohGmt69+cBCH2LFBHmS1oquVL1PP9m8VCbjhTKEhpIEXqjdgpp2PPxe0Nbav6OymqJC7
         fztId74OpYOE5fj/7ehdaUIiWZi71biMTBR6pQIyKrA4UBo/XC3RbADz5IhjLc2DnMkB
         euamMARpBXVjAHosqT0ivz+eOju7fDCfZAii+5CDXHXwkIGQU0+EA3QyT/tqaAnek+Hb
         8CUtIbQXNo4eNvMx4hOnR/dhiajbTZzbNQJeQF85QEg/PDqiwFTUGgKJ7e8TS+Uz+VXi
         Xkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709232860; x=1709837660;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5dFvqCRIbO656OOkYJr9SD1ZDKhVN7MuRH/M19ZUc4=;
        b=WsbZA/5GAB2JQrNlP6gK9Ccj+x8S08l++k/eaQcCNk7IdhbeHsUKLPu60lkUJaiAL8
         FMTewLj+ZyYqSveaVBLUEu+IRrcImlDf3DRKV+uC0/+Cfxle36u6KWsnnceVZeo70Rnu
         3Xt9vT3AGB1VZ3N0QTalkRznxx206NtXGMF3MG9BhyvosIXgSIGXC+wzLevkVAjCrv8+
         loSBWE3cJ0/0myfuxxK+FKt5bEjVNquJSK2ZlplkMWReX0QljtgLR1CXqY8f2e5J6W7I
         WpSkGsMX01zMfb/qjZ89dTKaQELSouZj/r99iM6Zd+0KTVGjzuqxmftc1dQEjzPHA5Xi
         5JFA==
X-Forwarded-Encrypted: i=1; AJvYcCVWrB9AyGCR5X4OogJ137S13dLzVRxyKewC1fU2nyyCacH/1i1/4XMWYQygUuODKA6qyAirZT5D8mH5nN0jbs+iG4O/9CwEG91EgO1B
X-Gm-Message-State: AOJu0YzoU6j5vsOXPsh+Ax+CrVooci0AYpgNr4Ofj9U3XUqahNXzPEMk
	2EmQoyvHNH7wv9RYvsxBuu547wKGwQlwSqtN5tFzlQ5N1p9wZXOJU5xU1yU6SjGd8dCTeVxfcge
	V5g==
X-Google-Smtp-Source: AGHT+IGy7cy+CsI630B50Nc5GYMwlKcoDrJ/CHzlWTNRj7zzuz8ZyLkMc3db8YwqGl9a0Vqfx/M/rZSQf+k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:188d:b0:dcc:54d0:85e0 with SMTP id
 cj13-20020a056902188d00b00dcc54d085e0mr768688ybb.11.1709232859989; Thu, 29
 Feb 2024 10:54:19 -0800 (PST)
Date: Thu, 29 Feb 2024 10:54:18 -0800
In-Reply-To: <87h6hrmmox.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228101837.93642-1-vkuznets@redhat.com> <20240228101837.93642-3-vkuznets@redhat.com>
 <Zd_BY8Us6TYNBueI@google.com> <87h6hrmmox.fsf@redhat.com>
Message-ID: <ZeDS2nhkK_QDBJS0@google.com>
Subject: Re: [PATCH 2/3] KVM: x86: Use actual kvm_cpuid.base for clearing KVM_FEATURE_PV_UNHALT
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Li RongQing <lirongqing@baidu.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 29, 2024, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > Am I missing something, or can we just swap() the new and old, update the new
> > in the context of the vCPU, and then undo the swap() if there's an issue?
> > vcpu->mutex is held, and accessing this state from a different task is wildly
> > unsafe, so I don't see any problem with temporarily having an in-flux state.
> >
> 
> I don't see why this approach shouldn't work and I agree it looks like
> it would make things better but I can't say that I'm in love with
> it.

Agreed, but the lack of atomicity is a pre-existing problem, though as proposed,
my idea would make it worse.  More below.

> Ideally, I would want to see the following "atomic" workflow for all
> updates:
> 
> - Check that the supplied data is correct, return an error if not. No
> changes to the state on this step.
> - Tweak the data if needed.
> - Update the state and apply the side-effects of the update. Ideally,
> there should be no errors on this step as rollback can be
> problemmatic. In the real world we will have to handle e.g. failed
> memory allocations here but in most cases the best course of action is
> to kill the VM.
> 
> Well, kvm_set_cpuid() is not like that. At least:
> - kvm_hv_vcpu_init() is a side-effect but we apply it before all checks
> are complete. There's no way back.
> - kvm_check_cpuid() sounds like a pure checker but in reallity we end up
> mangling guest FPU state in fpstate_realloc()

Yeah, I really, really don't like the call to fpu_enable_guest_xfd_features().
But to not make it worse, that call could be hoisted out of kvm_check_cpuid()
so that it can be performed after kvm_cpuid_check_equal(), i.e. be kept dead last
(and with a comment saying it needs to be dead last due to side effects that are
visible to serspace).

> Both are probably "no big deal" but certainly break the atomicity.
>
> > If we want to be paranoid, we can probably get away with killing the VM if the
> > vCPU has run and the incoming CPUID is "bad", e.g. to guard against something
> > in kvm_set_cpuid() consuming soon-to-be-stale state.  And that's actually a
> > feature of sorts, because _if_ something in kvm_set_cpuid() consumes the vCPU's
> > CPUID, then we have a bug _now_ that affects the happy path.
> >
> > Completely untested (I haven't updated the myriad helpers), but this would allow
> > us to revert/remove all of the changes that allow peeking at a CPUID array that
> > lives outside of the vCPU.
> 
> Thanks, assuming there's no urgency

Definitely no urgency.

> let me take a look at this in the course of the next week or so.

No need, it was more of an "FYI, this is what I may go futz with".  Specifically,
it will impact what I want to do with guest cpu_caps[*], hopefully in a good way.
My plan is to play around with it when I get back to that series.

[*] https://lore.kernel.org/all/20231110235528.1561679-1-seanjc@google.com


