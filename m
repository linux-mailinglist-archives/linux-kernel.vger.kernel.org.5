Return-Path: <linux-kernel+bounces-101544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 039A687A889
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2570B1C22D83
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C754594C;
	Wed, 13 Mar 2024 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WdH3f50a"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5654745010
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336848; cv=none; b=S2EWsjiCokl5j9NlUeXtaq1MGRHhlpDzzVuiEfTj40u2hZdu6K+kYikoPd0p3HkIubxO5uuI8MpUxa0gHW6fWo83niY+yIZZry0yrREPSeNO06EVhDzVbh+HIxpkq1QHhXW7t5FbUP1ReIZCe/ILcLCtx4q3D4GhlEvrWzEhEWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336848; c=relaxed/simple;
	bh=YtYXHrh16rFL2dlK6AeuHKPIT11j+xPYazuoPkbjZLc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dw1kDEDgj64QigBmCawDqiXWrMLNe6EVMlt6ZiXpK1+JT5MlZ7vYsT+P7LHIACpJIrd2UaDFNv0PrzVJsNo6uplsOC6ya5hNhvTc8821FFZBuOwJoa+oLsRL3xS+ilhtqeB2KtYjpKGfLP2/9Q+9MVkY6Io6iwh3LXz2/N8VgEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WdH3f50a; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a54004e9fso44576107b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 06:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710336845; x=1710941645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EeDuCrW/OzuKfmQ7trx25bc/3MeStGmMLBCg0AQiaHs=;
        b=WdH3f50aYLRfhaIpGyF4J/uhRxpyHr1gXlnRTH6Noa3fju8EhzbYu5UkxL10y9l/Bl
         zFEksM9UGcOdBG9WzPp1NYn2rj/Qu7INfb55jLgoawARiFNU314cLesKZGZY/6ih5wt8
         6FsFq1+L3+j4jyDzGiLLbO5A9dv3nQ5q6P/ZHZ43QAIkNaq4/JDOsPDeaQii1t95f5tX
         pldM1UEy8YTh8awwEsbyF0atLYgZl0c3NEESQlUOgCpvy7+OWok7iQQzmKFgo+eC2Og9
         XS8mgF5IYz8KIj3Hq9Gjm0brD9FhsPLiIVaw3D32XdT0BaYp7lB0eJ8k77LhQ1PMoJtX
         +vAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710336845; x=1710941645;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EeDuCrW/OzuKfmQ7trx25bc/3MeStGmMLBCg0AQiaHs=;
        b=C7cWTWf0HUwP3VLmJA+AWyToVnL2+7L9xtc6illTBRw4IYb2eprvJS7P38beXAPJEH
         2xr/qgsHThYgw+DIkRtFsYGqi49+xP0ipRvzuB75oPMTsHqcXlhYsN6EsCSNPlvPff//
         ypWw+LyeU6wQRppxQw+gWGRcg+U7Rr4Gx7la163xNTSzoTsOLV7zP9Ye6niODGjaQQ1m
         7cNeko0lZqqeaAjk4B6d0eoCCOgLp1hLxMsiebj+0DojPBJDlaZSloIIgTIkNW83bWOH
         pEaT+6l3S27p3wB5XmBzHnGEpxtuuIByG1HdZ4qRu4M9+hlsO3/QTBCQnysGhzxLpj6b
         cwpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHBSV8BQAcCEOZDsAMEXLGHyAARUginXHBVbutnSouaqRoHPFbmDUP3YAPbfKvT4kTfYNYP7QkBpYjlBkCnABBs4uAWmMi8oIcz3wQ
X-Gm-Message-State: AOJu0Yw9LGIPjrZJOYLI8hPs5C9yKSwwJLearA2zfOpaqMNMprBRdWuv
	z0aK5FJoCKcKWkPpwW0RFRkECfAGUfuJUR0G2taOpz+BQ7hdoZiHdAjN6ZGiy200YAK8xMT/UKw
	oYQ==
X-Google-Smtp-Source: AGHT+IGzeTp0Kd/KVSxA1L/KjVh99PquENLfknjJ/YqzT8MDcFuAl63vKayUBQvut1tAWWM0sBlPgMKxY1Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:9251:0:b0:60c:b1d4:a9f9 with SMTP id
 j78-20020a819251000000b0060cb1d4a9f9mr277116ywg.10.1710336845403; Wed, 13 Mar
 2024 06:34:05 -0700 (PDT)
Date: Wed, 13 Mar 2024 06:34:03 -0700
In-Reply-To: <72285e50-6ffc-4f24-b97b-8c381b1ddf8e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229025759.1187910-1-stevensd@google.com> <ZeCIX5Aw5s1L0YEh@infradead.org>
 <CAD=HUj7fT2CVXLfi5mty0rSzpG_jK9fhcKYGQnTf_H8Hg-541Q@mail.gmail.com> <72285e50-6ffc-4f24-b97b-8c381b1ddf8e@amd.com>
Message-ID: <ZfGrS4QS_WhBWiDl@google.com>
Subject: Re: [PATCH v11 0/8] KVM: allow mapping non-refcounted pages
From: Sean Christopherson <seanjc@google.com>
To: "Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>
Cc: David Stevens <stevensd@chromium.org>, Christoph Hellwig <hch@infradead.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024, Christian K=C3=B6nig wrote:
> Am 13.03.24 um 05:55 schrieb David Stevens:
> > On Thu, Feb 29, 2024 at 10:36=E2=80=AFPM Christoph Hellwig <hch@infrade=
ad.org> wrote:
> > > On Thu, Feb 29, 2024 at 11:57:51AM +0900, David Stevens wrote:
> > > > Our use case is virtio-gpu blob resources [1], which directly map h=
ost
> > > > graphics buffers into the guest as "vram" for the virtio-gpu device=
.
> > > > This feature currently does not work on systems using the amdgpu dr=
iver,
> > > > as that driver allocates non-compound higher order pages via
> > > > ttm_pool_alloc_page().
> > > .. and just as last time around that is still the problem that needs
> > > to be fixed instead of creating a monster like this to map
> > > non-refcounted pages.
> > >=20
> > Patches to amdgpu to have been NAKed [1] with the justification that
> > using non-refcounted pages is working as intended and KVM is in the
> > wrong for wanting to take references to pages mapped with VM_PFNMAP
> > [2].
> >=20
> > The existence of the VM_PFNMAP implies that the existence of
> > non-refcounted pages is working as designed. We can argue about
> > whether or not VM_PFNMAP should exist, but until VM_PFNMAP is removed,
> > KVM should be able to handle it. Also note that this is not adding a
> > new source of non-refcounted pages, so it doesn't make removing
> > non-refcounted pages more difficult, if the kernel does decide to go
> > in that direction.
>=20
> Well, the meaning of VM_PFNMAP is that you should not touch the underlyin=
g
> struct page the PTE is pointing to. As far as I can see this includes
> grabbing a reference count.
>=20
> But that isn't really the problem here. The issue is rather that KVM assu=
mes
> that by grabbing a reference count to the page that the driver won't chan=
ge
> the PTE to point somewhere else.. And that is simply not true.

No, KVM doesn't assume that.

> So what KVM needs to do is to either have an MMU notifier installed so th=
at
> updates to the PTEs on the host side are reflected immediately to the PTE=
s
> on the guest side.

KVM already has an MMU notifier and reacts accordingly.

> Or (even better) you use hardware functionality like nested page tables s=
o
> that we don't actually need to update the guest PTEs when the host PTEs
> change.

That's not how stage-2 page tables work.=20

> And when you have either of those two functionalities the requirement to =
add
> a long term reference to the struct page goes away completely. So when th=
is
> is done right you don't need to grab a reference in the first place.

The KVM issue that this series is solving isn't that KVM grabs a reference,=
 it's
that KVM assumes that any non-reserved pfn that is backed by "struct page" =
is
refcounted.

What Christoph is objecting to is that, in this series, KVM is explicitly a=
dding
support for mapping non-compound (huge)pages into KVM guests.  David is arg=
uing
that Christoph's objection to _KVM_ adding support is unfair, because the r=
eal
problem is that the kernel already maps such pages into host userspace.  I.=
e. if
the userspace mapping ceases to exist, then there are no mappings for KVM t=
o follow
and propagate to KVM's stage-2 page tables.

