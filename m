Return-Path: <linux-kernel+bounces-141369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DC98A1D58
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F069287F1F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939D651C42;
	Thu, 11 Apr 2024 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUrBy+mZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1F14F21D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854998; cv=none; b=G+A0cKUsnl+rpZNRU7mHhpcg69HQa9IRik1TLNsj88EkBeQ/W0cFXkQh9Kz/mUZt3r65CJMS3kWoAk8XmZY3KSz7ReTPm/XXnowYTKfq5CfL7w09YPfsJW8l6FLXw/Yce/N3WqF1/GlLB6uN1+suuL9qfXVyfvt/9QbGOmf5tfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854998; c=relaxed/simple;
	bh=4EYHwbvv4HIFO4JBzELmE6tVDYNgoClUAwwxysMJGbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sfOiVsG8qoY0iRhIen+rcVNq6FfOfQySzrmUts94L9iTUUazOqYIRBWRHtNd4tww64rqsuDIR8K+LMZmKxAnT7r1mcqwzH10LIyIdTDfPkDp4PJI3+ZkFhxrRlbU2q2ZohJfAXUd9si8qEkSJv6r7LeqrIDLf9nLm0kcbDJg8WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUrBy+mZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712854996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rIl2A2MygLWpv/rbleE/UxTsNVifg5YFIjMI1ad1PoU=;
	b=XUrBy+mZvdSf/TQluIyNuiYRGD9Qn4lfSqmrsPB+izKeMSbfzB4RrxodreuedHxlCPJPHt
	AzUfk1d7vcEHj/wOLClQ2ixgDFTAxmBrk5cEjta6rsFDm54N2ZcUnNif4kZ+lIBGiV74+4
	4f1/trAhJQKya1Em/+JGJLI0DdfrQnw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-bnxM6LWfPqG062S0c3i8zA-1; Thu, 11 Apr 2024 13:03:14 -0400
X-MC-Unique: bnxM6LWfPqG062S0c3i8zA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d6fcb884bbso69613081fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712854993; x=1713459793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIl2A2MygLWpv/rbleE/UxTsNVifg5YFIjMI1ad1PoU=;
        b=Qm/s/CODU7XYNLMtcgrOeaNyV+KiiS+qLUcHvuaaDSvyM+fhUbP7YgEvVHNja9rwbb
         HVQUVwA8Ix7gQ/iACM/Srh+yffmsspHGwgiT2Ghxf0Sc9zoD3t/Ag+9SPBJjsmq670eo
         pOEOyXWLV3ch9S6Q1uyRMnja0RENT0GLq9Zp2LCpMMEuJ61tObaXevGe5C8Nl5GzHweT
         gyKIyUPR5N13eOdZ8p1X2fT46oyy9XDXFhbcDw9hrCTiMoaYJvt/wWfHQ+KJvZeKSWvW
         2uaBfB2lM5NHm/0nteFLmHSR3wwkOXzIMQlTQJIzYlKjVzpAamAO9FRH0uPVNox+xb5H
         n8Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWLCW7lgn/9j44e6baDHdcSs2mK84aHELNj6Xex5iEQi/RbYueV445wzh8ylBK31w+YxH5RyuqyCHxLR/zTWtYOOM1OH9yp4z3Gwe90
X-Gm-Message-State: AOJu0YwrJtiO6nBCU1b4yKO92ewaDaQ/jh3MqYBl/X62ISlQtxeNO9AT
	c2hXIeTmynzVbkwIAlOgVYDFXLnVP4H2r6vrOqmPhJhK3hzAhUrr2TwZVVsbbwl/6b9qqNpRZ7K
	5GESxYPhDalAyxHjl4Ua6aT8iPPnZQGat+elNBEH9Lfmc1C2ErYaUn7zNkDfwXnR8LbF6qnRHmW
	/EOEPIGW8YKC52efhugM1LGO9ERlHPRTbz4VhB
X-Received: by 2002:a05:6512:ea8:b0:516:d14b:435f with SMTP id bi40-20020a0565120ea800b00516d14b435fmr290344lfb.14.1712854993420;
        Thu, 11 Apr 2024 10:03:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFutZJ2p2r6Cty2gQb2/vJIjMq3jVZM8kakoZXZ0giBYkFkzFrmT9tbghEfOGtOfjJRs93FbfMvN+KhbZ68DCI=
X-Received: by 2002:a05:6512:ea8:b0:516:d14b:435f with SMTP id
 bi40-20020a0565120ea800b00516d14b435fmr290332lfb.14.1712854993008; Thu, 11
 Apr 2024 10:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405235603.1173076-1-seanjc@google.com>
In-Reply-To: <20240405235603.1173076-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 Apr 2024 19:03:00 +0200
Message-ID: <CABgObfZoj1zqwnZ8FbZar7aT+AjrhFWbDUu_Vu-rmLfB3FPvaQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] KVM: x86: Fix LVTPC masking on AMD CPUs
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sandipan Das <sandipan.das@amd.com>, Jim Mattson <jmattson@google.com>, 
	Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 1:56=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> This is kinda sorta v2 of Sandipan's fix for KVM's incorrect setting of
> the MASK bit when delivering PMIs through the LVTPC.
>
> It's a bit rushed, as I want to get Sandipan's fix applied early next
> week so that it can make its way to Linus' tree for -rc4.  And I didn't
> want to apply Sandipan's patch as-is, because I'm a little paranoid that
> the guest CPUID check could be noticeable slow, and it's easy to avoid.
>
> My plan is to grab patches 1-2 for 6.9 asap, and let the rest simmer for
> much, much longer (they are *very* lightly tested).

Oops---I missed your queuing message and pushed the same to kvm/master.

Is it okay if you use commit 49ff3b4aec51e as the basis for any 6.10
topic branches that may conflict (or that build open the first two
patches)?

Paolo


Paolo

>
> As for why this looks wildy different than Sandipan's compat_vendor idea,
> when I started looking at KVM's various AMD vs. Intel checks, I realized
> it makes no sense to support an "unknown" vendor.  KVM can't do *nothing*=
,
> and so practically speaking, an "unknown" vendor vCPU would actually end
> up with a weird mix of AMD *and* Intel behavior, not AMD *or* Intel
> behavior.
>
> Sandipan Das (1):
>   KVM: x86/pmu: Do not mask LVTPC when handling a PMI on AMD platforms
>
> Sean Christopherson (9):
>   KVM: x86: Snapshot if a vCPU's vendor model is AMD vs. Intel
>     compatible
>   KVM: x86/pmu: Squash period for checkpointed events based on host
>     HLE/RTM
>   KVM: x86: Apply Intel's TSC_AUX reserved-bit behavior to Intel compat
>     vCPUs
>   KVM: x86: Inhibit code #DBs in MOV-SS shadow for all Intel compat
>     vCPUs
>   KVM: x86: Use "is Intel compatible" helper to emulate SYSCALL in
>     !64-bit
>   KVM: SVM: Emulate SYSENTER RIP/RSP behavior for all Intel compat vCPUs
>   KVM: x86: Allow SYSENTER in Compatibility Mode for all Intel compat
>     vCPUs
>   KVM: x86: Open code vendor_intel() in string_registers_quirk()
>   KVM: x86: Bury guest_cpuid_is_amd_or_hygon() in cpuid.c
>
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/cpuid.c            | 13 ++++++
>  arch/x86/kvm/cpuid.h            | 16 ++------
>  arch/x86/kvm/emulate.c          | 71 ++++++++++-----------------------
>  arch/x86/kvm/kvm_emulate.h      |  1 +
>  arch/x86/kvm/lapic.c            |  3 +-
>  arch/x86/kvm/mmu/mmu.c          |  2 +-
>  arch/x86/kvm/pmu.c              |  2 +-
>  arch/x86/kvm/svm/svm.c          | 14 +++----
>  arch/x86/kvm/x86.c              | 30 ++++++++------
>  10 files changed, 68 insertions(+), 85 deletions(-)
>
>
> base-commit: 8cb4a9a82b21623dbb4b3051dd30d98356cf95bc
> --
> 2.44.0.478.gd926399ef9-goog
>


