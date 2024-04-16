Return-Path: <linux-kernel+bounces-147394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032F08A734D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35E66B22903
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBE3134429;
	Tue, 16 Apr 2024 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mAjJXpqh"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B909B12EBF5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713292515; cv=none; b=Da40a+A664ox5FL5XfRlYTcF30Erkr1bo8C/BJO8129uqfOqJjNmXdl3eNtLltazI/HmS1Im1bSjNHNvAJWkr72H+/MwsEO8GeCconNP8UtgAg6hIpLBEwzFvvyz4gPYHdB5dUc2jZhZYcUNt7xS/1475unkKs8Cz+cfjAA72Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713292515; c=relaxed/simple;
	bh=2DmfH0iZuBeBaf9fmZxw8bxd/Na/JJLdrJnni9XYYsI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A5s/iCz4IOLfDal6FTM2Gq/m9I1gwHLSj4kqoVNrWZb9YRs/J/4k99UpSlh9DOdc9xzw39IDQPSgGLGam1C8uFSo39XDKfwLxoTAtaPD4w9jJ6iyeyTWTwhf93fcqTS8xNSLozyKG4wwQWd/queJLGyE8WM1G4KdGivDLCez54c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mAjJXpqh; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e4ad1c0fc8so53412835ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713292513; x=1713897313; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4IcmDFg9mXfsOm+KYa9etM9trKW2oRgOEYJLX5Llhs=;
        b=mAjJXpqhNpvZHQD00GZO0U/Oz751ABA9G+j4q35BGnuTiqi1/cVAM2sOQCZ/cnwEUS
         Zc92UALDTpfzuN9r9LHlhQ9BR+YIYqKSEDNa8PK7AumZVSOyHVXqpHM5+On/iggdWbLA
         90vUzEu0vyHlgrGZmPRIW7EppLWhdhkKEY8nFm/mvo2Y2IhZS5i3z/i9SSRE0xE3UShQ
         A+PUVOHg554RzM6UM+r8RbC7oydSTbn+vNNc3wLaXrAPdORAeJT0tN2RkD6J10oN09NT
         pASk5elribF1Er6BZYJll0uASG7BiDh7wZJ7OXtH2L7gu3eZv30PjdP2M2ECTAN0ruPl
         lNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713292513; x=1713897313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4IcmDFg9mXfsOm+KYa9etM9trKW2oRgOEYJLX5Llhs=;
        b=FvdrETifF9F2rB2IUhB1s0eBoF6tN61ymJve8OQ34hXYvWNfwhmQMZsTAjLkzRnodZ
         6Xn12VarVrI/I00D5n/J8EOxOAjMm5IybRS6ViFTEQdCrOjivh80/8WX4d18rV11CC1G
         dQ7iWmyEB8L+T/IKBNAPQi/YcUj2ua+7rHSZMewfeTbsqn4l9R1P+7hLwpMNxWmz6xO6
         Wi7FM/lvQePOuIGQw3EmTZOCzlsUmeQoRPy9jpjU2Jlt28XacfB7BUBnATUfAJ8rFQj3
         G4TYrMw42VWQu7BEGSTlFJCdTzm8f34b52edEGM2gwZa+NQTooWj3nu/S8eSl62remhj
         GgTA==
X-Forwarded-Encrypted: i=1; AJvYcCWzqYrRrPB43eP6RZEXxN2jEy1BS/lrQYtaRLadG0EQnG6QgVjtWtECUCI81iGkMaGsos219NZYT2JjsNMQef6izrb+PYDyNCWwmvoO
X-Gm-Message-State: AOJu0YySr7KtXOjMa/LwFHo8/GdSNmpsh8jrKnhxtQxYD62XzPutgmHF
	kHxt6y4OTLnHDxvnx/++konYnsH8lm1J5CjPhJWFe16Roc6vpVAxJE9a5LGeuXKnHZPdE4WshfL
	WvQ==
X-Google-Smtp-Source: AGHT+IH2l/4Q1X0kmlazvUCeA2LxIdHYVFqddoS+Vcjn6XdYq8l7HIp0PwRH0csKmwi+ILtTtyM7Ra+SNYM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e80b:b0:1e3:ff3a:7a07 with SMTP id
 u11-20020a170902e80b00b001e3ff3a7a07mr93926plg.6.1713292513069; Tue, 16 Apr
 2024 11:35:13 -0700 (PDT)
Date: Tue, 16 Apr 2024 11:35:11 -0700
In-Reply-To: <ZhkQsqRjy1ba+mRm@chao-email>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240215160136.1256084-1-alejandro.j.jimenez@oracle.com>
 <20240215160136.1256084-4-alejandro.j.jimenez@oracle.com> <ZhTj8kdChoqSLpi8@chao-email>
 <98493056-4a75-46ad-be79-eb6784034394@oracle.com> <ZhkQsqRjy1ba+mRm@chao-email>
Message-ID: <Zh7E3yIYHYGTGGoB@google.com>
Subject: Re: [RFC 3/3] x86: KVM: stats: Add a stat counter for GALog events
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, kvm@vger.kernel.org, 
	pbonzini@redhat.com, linux-kernel@vger.kernel.org, joao.m.martins@oracle.com, 
	boris.ostrovsky@oracle.com, mark.kanda@oracle.com, 
	suravee.suthikulpanit@amd.com, mlevitsk@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 12, 2024, Chao Gao wrote:
> On Tue, Apr 09, 2024 at 09:31:45PM -0400, Alejandro Jimenez wrote:
> >
> >On 4/9/24 02:45, Chao Gao wrote:
> >> > diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> >> > index 4b74ea91f4e6..853cafe4a9af 100644
> >> > --- a/arch/x86/kvm/svm/avic.c
> >> > +++ b/arch/x86/kvm/svm/avic.c
> >> > @@ -165,8 +165,10 @@ int avic_ga_log_notifier(u32 ga_tag)
> >> > 	 * bit in the vAPIC backing page. So, we just need to schedule
> >> > 	 * in the vcpu.
> >> > 	 */
> >> > -	if (vcpu)
> >> > +	if (vcpu) {
> >> > 		kvm_vcpu_wake_up(vcpu);
> >> > +		++vcpu->stat.ga_log_event;
> >> > +	}
> >> > 
> >> 
> >> I am not sure why this is added for SVM only.
> >
> >I am mostly familiar with AVIC, and much less so with VMX's PI, so this is
> >why I am likely missing potential stats that could be useful to expose from
> >the VMX  side. I'll be glad to implement any other suggestions you have.
> >
> >
> >it looks to me GALog events are
> >> similar to Intel IOMMU's wakeup events. Can we have a general name? maybe
> >> iommu_wakeup_event
> >
> >I believe that after:
> >d588bb9be1da ("KVM: VMX: enable IPI virtualization")
> >
> >both the VT-d PI and the virtualized IPIs code paths will use POSTED_INTR_WAKEUP_VECTOR
> >for interrupts targeting a blocked vCPU. So on Intel hosts enabling IPI virtualization,
> >a counter incremented in pi_wakeup_handler() would record interrupts from both virtualized
> >IPIs and VT-d sources.
> >
> >I don't think it is correct to generalize this counter since AMD's implementation is
> >different; when a blocked vCPU is targeted:
> >
> >- by device interrupts, it uses the GA Log mechanism
> >- by an IPI, it generates an AVIC_INCOMPLETE_IPI #VMEXIT
> >
> >If the reasoning above is correct, we can add a VMX specific counter (vmx_pi_wakeup_event?)
> >that is increased in pi_wakeup_handler() as you suggest, and document the difference
> >in behavior so that is not confused as equivalent with the ga_log_event counter.
> 
> Correct. If we cannot generalize the counter, I think it is ok to
> add the counter for SVM only. Thank you for the clarification.

There's already a generic stat, halt_wakeup, that more or less covers this case.
And despite what the comment says, avic_ga_log_notifier() does NOT schedule in
the task, kvm_vcpu_wake_up() only wakes up blocking vCPUs, no more, no less.

I'm also not at all convinced that KVM needs to differentiate between IPIs and
device interrupts that arrive when the vCPU isn't in the guest.  E.g. this can
kinda sorta be used to confirm IRQ affinity, but if the vCPU is happily running
in the guest, such a heuristic will get false negatives.

And for confirming that GA logging is working, that's more or less covered by the
proposed APICv stat.  If AVIC is enabled, the VM has assigned devices, and GA logging
*isn't* working, then you'll probably find out quite quickly because the VM will
have a lot of missed interrupts, e.g. vCPUs will get stuck in HLT.

