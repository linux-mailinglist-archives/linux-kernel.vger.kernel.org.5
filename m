Return-Path: <linux-kernel+bounces-85444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2482186B60A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E691F25B44
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A512159588;
	Wed, 28 Feb 2024 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dmw4ekwZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06183FBA2
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141574; cv=none; b=GKXbEucXF4IbVK7Eya733vmPPU0e9w2OPtLd3Bvevc7KxR6rgVKV1E0YH0D5R3+OMSSf1sB7QKAR4oZYpZg04839X9xyR4AymvvTRXXZBxScjpRtPjvK26DZJxr0W1PnrOrOiV5sNTYPmFenGkqgZPKqw5B7Oi5a1bbT0zxC5yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141574; c=relaxed/simple;
	bh=fYS13N9NZSFLqL5gwUsUap5mM8K5OiN8syZJhBDVxbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYgnHrD9zxeHlvWzT4+CR3jumPq4P2yotpNSWkvvSz/CWiI+1g3J1fDTKPbUpnT5L3furfdx+Y9NJ+tOYhfJ35lNnVLuerIN7T2dUnwqb+yG8EdQVvAuzeBecS560gZxOyongAnTV3zOxX5nGJXv84BHso9A7Tb9AjiwydkUuco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dmw4ekwZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709141571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmXoF31qoxcztznnZL7H+L5aSF9s4S/rqGoBb/y1mxw=;
	b=Dmw4ekwZ1LOfwh0SpiEHn33v+b7H2PB4vL5/qFdg1LY35wK6MNFA6ITo+FlZP8qRPmPSYo
	QMU4mnbAy8ic8z04zkTF9h5lXf08el+qW96NgVIFmahLVO8DNlvwRYAuhJM3f2FCLMj7ml
	JZ3dDxC2h34KvLopexjcR/rWy50NP+Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-R8p7WTMpPlGwctQj7sdpzQ-1; Wed, 28 Feb 2024 12:32:50 -0500
X-MC-Unique: R8p7WTMpPlGwctQj7sdpzQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4129b426bdaso29365e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:32:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709141569; x=1709746369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmXoF31qoxcztznnZL7H+L5aSF9s4S/rqGoBb/y1mxw=;
        b=bCTtKyHLMg1rS7L3L1tDqP75XotygsuivujBX+wWXAenA11UznEJjqURjfhBM+no7Q
         1LLSf1tDi/bJNCrncU8+Z5WEOsWHY5191qzyjWvq5nh0ME++Ai9g5jQGadNMYNc9akV4
         exHNi1q9+lnJmx4G/wd3vnuwxTnggqqGm7cSafotl5KdMDkleWI4hKGRknOvBzwqiWUD
         Agd19QwQXQz+mxzsCkjrIFTYTLpusIi46eFe/45JmPXZEK5pWQpHgpmK3xjYykWZzPdn
         W5/mfqTwx+rnLl+mWVmB7grDT16OfjsLzKOFUXtNxDq0UcTS79CTa8dbJwh8lnCNrtr3
         2TUw==
X-Gm-Message-State: AOJu0YxqFl6BYkCATsI9gyj1N8zhXwTAnqyt6C8TlqEdH6fZMs+F+Zfb
	vL1U01Xm2vzIqZ+KWvcyN37SFLhe/uzkXUsv1jyRko1I39RP6UVPh9vWRYag+1qSGtGB21mNnFj
	IT/P2V8ZrVzqdL04XwoOgSNvClHWl4wnCIV/ncgiXBN791Wm029/LIuWLIJBxzSUKdqnMkk7JDz
	dRUYmh0ScJCv78q25ncSvYph7cUS86G4034jnv
X-Received: by 2002:adf:e488:0:b0:33e:202:277a with SMTP id i8-20020adfe488000000b0033e0202277amr164348wrm.46.1709141569076;
        Wed, 28 Feb 2024 09:32:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxcghLhChHEAIG27LGbO9eqn7L5dVgSGoWWA3BJFwSP4LoUv8zzPOjUYDW9wZ+F93WhzORVl0bdNLPnNOtaFg=
X-Received: by 2002:adf:e488:0:b0:33e:202:277a with SMTP id
 i8-20020adfe488000000b0033e0202277amr164333wrm.46.1709141568784; Wed, 28 Feb
 2024 09:32:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227232100.478238-1-pbonzini@redhat.com> <20240227232100.478238-11-pbonzini@redhat.com>
 <Zd6T06Qghvutp8Qw@google.com>
In-Reply-To: <Zd6T06Qghvutp8Qw@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 28 Feb 2024 18:32:37 +0100
Message-ID: <CABgObfaPodSSzArO99Hkn=vpGotO1wZ-0dZKEZHx9EqLZ7M_XQ@mail.gmail.com>
Subject: Re: [PATCH 10/21] KVM: SEV: Use a VMSA physical address variable for
 populating VMCB
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com, 
	isaku.yamahata@intel.com, thomas.lendacky@amd.com, 
	Ashish Kalra <ashish.kalra@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 3:00=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Feb 27, 2024, Paolo Bonzini wrote:
> > From: Tom Lendacky <thomas.lendacky@amd.com>
> >
> > In preparation to support SEV-SNP AP Creation, use a variable that hold=
s
> > the VMSA physical address rather than converting the virtual address.
> > This will allow SEV-SNP AP Creation to set the new physical address tha=
t
> > will be used should the vCPU reset path be taken.
>
> No, this patch belongs in the SNP series.  The hanlding of vmsa_pa is bro=
ken
> (KVM leaks the page set by the guest; I need to follow-up in the SNP seri=
es).
> On top of that, I detest duplicat variables, and I don't like that KVM ke=
eps its
> original VMSA (kernel allocation) after the guest creates its own.
>
> I can't possibly imagine why this needs to be pulled in early.  There's n=
o way
> TDX needs this, and while this patch is _small_, the functional change it=
 leads
> to is not.

Well, the point of this series (and there will be more if you agree)
is exactly to ask "why not" in a way that is more manageable than
through the huge TDX and SNP series. My reading of the above is that
you believe this is small enough that it can even be merged with "KVM:
SEV: Support SEV-SNP AP Creation NAE event" (with fixes), which I
don't disagree with.

Otherwise, if the approach was good there's no reason _not_ to get it
in early. It's just a refactoring.

Talking in general: I think I agree about keeping the gmem parts in a
kvm-coco-queue branch (and in the meanwhile involving the mm people if
mm/filemap.c changes are needed). #VE too, probably, but what I
_really_ want to avoid is that these series (the plural is not a typo)
become a new bottleneck for everybody. Basically these are meant to be
a "these seem good to go to me, please confirm or deny" between
comaintainers more than a real patch posting; having an extra branch
is extra protection against screwups but we should be mindful that
force pushes are painful for everyone.

If you think I'm misguided, please do speak out or feel free to ask me
to talk on voice.

Paolo


