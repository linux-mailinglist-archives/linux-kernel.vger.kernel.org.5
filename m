Return-Path: <linux-kernel+bounces-148322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4839A8A80F0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA001C210F5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AABB13BC1B;
	Wed, 17 Apr 2024 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvtIceW5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC3412CD91
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713349732; cv=none; b=kQeq4cijLqA9lIZZkPDH+wDR3GlaOEwiJ+TnWP5igk2sL6a9XxsWizHwaAR666mzgXtfrnhEePDqNW/Het7QRT2Vc4viKLBG3VYIS+IgFwbzd52pb2qAMsSKBn4DDMxhQr5toZ06pyPXL4oNUleLCjc9/OMDCi30LW6Gl4jbM4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713349732; c=relaxed/simple;
	bh=w9/j/Je+o73zYIJxkI4ihGGFo9ICotiVF5tQW2c+m+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTB0dL8Yy+DD5fP4Cj+DQFKwrzsRGhPi5ABBnnXDiIhXMrGJKYCqevjJSQzEkUad/Bww9lCGIXlgEqRfEOHeESgH4hofLonuPhM4TgI6AztRFtnqJwfEbpQYWJnhKYLL41HyMnbm976Rjlm9VXP8tIR/T+wc0jYjrDVUmVqHwIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XvtIceW5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713349730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O85bb4GMOKWlSLPww3MfE2bfVcvNnZa2l+DfV3fmaMQ=;
	b=XvtIceW5MDN6miq6TFePW75qwYPdMhUILhK5MUGqFdFPH8irdijgHrEk6nLtEJC/Cz7vAS
	Vhgew8Pos10dYNy3X8e8Rd7jJvuSEv1ssQ+BBDWaI8h/Ahow8jPm3+Q1PiYoyFAPYC2PJA
	s/iNlPhUxfZ/EfhwKKRkDVhyOSmcVew=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-WjCGFWYDNautd4ZFFrW29g-1; Wed, 17 Apr 2024 06:28:48 -0400
X-MC-Unique: WjCGFWYDNautd4ZFFrW29g-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-519296de7cfso1371554e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 03:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713349727; x=1713954527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O85bb4GMOKWlSLPww3MfE2bfVcvNnZa2l+DfV3fmaMQ=;
        b=vHIkh75a416jeslJGW3HZqfTiEioH+ZdAuSNmPWKXJtjhFBbaJtEv6jMe7GTEV6+Qw
         ptwr7ezbLKVxFJweXQVJqICmpaeKc60y/g60DPqnShV6VZr1O7vGWFYTMNUuxjCNlQVu
         NjFpNcXwrzawbo7rkMwJOHRXlxHdChHLjy5AakAcz/AOrkfZ9zkjJur50K5x7BL7vDs3
         DdjcDIrc6SqA5PugJaFOMWiBNu0K5pKXA+9USPgvYDuI7D0hkTCeKyCaZwmUFTPryS/Y
         /pDGm6nZ8u5HsFznMs9NuXwsiGP3rLD1iXKcOnqRAJKqHppBrdxht9D0WXb775XCXirR
         n5Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXHPYr5+zadGMG2O7hgbKUQs27bYmOWewKahPvjoBy84da29rrL7iJhrHSHwpIY3ysHyZ5q7iedPnLYWP3OncU79boId8/64LqbtFPu
X-Gm-Message-State: AOJu0YyJglhZZBTRTEDSVa2g5RUInLKzrTTQackdGRWol3/m5lLN5ulk
	CwvWJ3Xggfj1CrD+PHnSydKqqAL4jxCukNIL+BmhWIpdzPjErjr4TckWuTcCIn72LIU82ERoUa2
	1usPfqyeuxQnsT7BD0/HuEwNGhHnSBTIBVN3t6EQJ8wXq6lb5vRcmAlQBa2ux1OgRMPvWOpEhCA
	ItnkZsoHGg20ecOEaw2xNRgTjKCGhZCbrhbwNS
X-Received: by 2002:a05:6512:ad5:b0:515:ab7f:b13e with SMTP id n21-20020a0565120ad500b00515ab7fb13emr15605110lfu.33.1713349727155;
        Wed, 17 Apr 2024 03:28:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2PEEkflUhPutOPlvakp0mNMrz5x9jX77kM+J7Wf/TGaRQaWFZLDemYgspwVl/1Bu5SKeZowYgQMhGHAMyeu8=
X-Received: by 2002:a05:6512:ad5:b0:515:ab7f:b13e with SMTP id
 n21-20020a0565120ad500b00515ab7fb13emr15605089lfu.33.1713349726809; Wed, 17
 Apr 2024 03:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712785629.git.isaku.yamahata@intel.com>
 <2f1de1b7b6512280fae4ac05e77ced80a585971b.1712785629.git.isaku.yamahata@intel.com>
 <116179545fafbf39ed01e1f0f5ac76e0467fc09a.camel@intel.com>
 <Zh2ZTt4tXXg0f0d9@google.com> <CABgObfZq9dzvq3tsPMM3D+Zn-c77QrVd2Z1gW5ZKfb5fPu_8WA@mail.gmail.com>
 <Zh8DHbb8FzoVErgX@google.com>
In-Reply-To: <Zh8DHbb8FzoVErgX@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 17 Apr 2024 12:28:34 +0200
Message-ID: <CABgObfbPXSFnupedTw56CXSOe74W_Z=dT+RJoPVebMtQ8HfojQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] KVM: x86: Always populate L1 GPA for KVM_MAP_MEMORY
To: Sean Christopherson <seanjc@google.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kai Huang <kai.huang@intel.com>, 
	"federico.parola@polito.it" <federico.parola@polito.it>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, "dmatlack@google.com" <dmatlack@google.com>, 
	"michael.roth@amd.com" <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:00=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
> > > > Hmm... For the non-TDX use cases this is just an optimization, righ=
t? For TDX
> > > > there shouldn't be an issue. If so, maybe this last one is not so h=
orrible.
> >
> > It doesn't even have to be ABI that it gives an error. As you say,
> > this ioctl can just be advisory only for !confidential machines. Even
> > if it were implemented, the shadow MMU can drop roots at any moment
>
> Sure, but there's a difference between KVM _potentially_ dropping roots a=
nd
> guaranteed failure because userspace is trying to do something that's uns=
upported.
> But I think this is a non-issue, because it should really just be as simp=
le as:
>
>         if (!mmu->pre_map_memory)
>                 return -EOPNOTSUPP;
>
> Hmm, or probably this to avoid adding an MMU hook for a single MMU flavor=
:
>
>         if (!tdp_mmu_enabled || !mmu->root_role.direct)
>                 return -EOPNOTSUPP;
>
> > and/or kill the mapping via the shrinker.
>
> Ugh, we really need to kill that code.

Ok, so let's add a KVM_CHECK_EXTENSION so that people can check if
it's supported.

> > That said, I can't fully shake the feeling that this ioctl should be
> > an error for !TDX and that TDX_INIT_MEM_REGION wasn't that bad. The
> > implementation was ugly but the API was fine.
>
> Hmm, but IMO the implementation was ugly in no small part because of the =
contraints
> put on KVM by the API.  Mapping S-EPT *and* doing TDH.MEM.PAGE.ADD in the=
 same
> ioctl() forced KVM to operate on vcpu0, and necessitated shoving temporar=
y data
> into a per-VM structure in order to get the source contents into TDH.MEM.=
PAGE.ADD.

That's because it was trying to do two things with a single loop. It's
not needed - and in fact KVM_CAP_MEMORY_MAPPING forces userspace to do
it in two passes.

> And stating the obvious, TDX_INIT_MEM_REGION also doesn't allow pre-mappi=
ng memory,
> which is generally useful, and can be especially beneficial for confident=
ial VMs
> (and TDX in particular) due to the added cost of a page fault VM-Exit.
>
> I'm not dead set on this generic ioctl(), but unless it ends up being a t=
rain wreck
> for userspace, I think it will allow for cleaner and more reusable code i=
n KVM.

Yes, this ioctl() can stay. Forcing it before adding memory to TDX is
ugly, but it's not a blocker. I'll look at it closely and see how far
it is from being committable to kvm-coco-queue.

Paolo


