Return-Path: <linux-kernel+bounces-162976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4CD8B62EC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058F0280D54
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FBF13DB9B;
	Mon, 29 Apr 2024 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2t3m+Y7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B44213541D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420463; cv=none; b=uCgMUP2U1SeuiGgmzgzKLgjuNa4inbbo52d6Qiu0t7rVlsItiPFcKUVSjQGNg8hGU47VG/0SCSzOr5c+cSmt/kEOY2sxmIX/NXHQAVJh2i6fqpsrantp0J/6wE1mLsoBiq9Lh7lFgXJRsUWlsOZLke8FnJIILEWC2LkV04cobSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420463; c=relaxed/simple;
	bh=F7qRuBo9bDIeO33UDBYG1EwRLafgO1luvegessTm0gc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p9rgL/us/eodFNzA6FxCPf+ksMp9qUQOjDXlnhE1721wWb+jWkPQDmCGtCCR5ZEWA4hyOsrMtG+Ab0Tz27oRRDRs/JwQFJCPwF3Lv1hR67uA9TqBWe7UMiJX1d01Q16CIsQFGMcF3/Fxafby6lsFIKJ/P03c4zvvFffVopbJ7zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2t3m+Y7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714420460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7qRuBo9bDIeO33UDBYG1EwRLafgO1luvegessTm0gc=;
	b=d2t3m+Y7HNUYcZD8G5Xm8veag2zdy1HaDIpFewo3/7QqK/4MwNxmPIwbzUqjeVf979e1FE
	DqFlg3mfchD/0wzDJtqeLfOcv+W2zYn4L/XOlwVQAxInDDuQ4oJDd8iQbuFFGhqZ+fgyNy
	P3y2E1Cm0lBfBZTWlJ9rGsyVmw1MKwI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-pCtTYVBYP9SlXzsn0URMkA-1; Mon, 29 Apr 2024 15:54:19 -0400
X-MC-Unique: pCtTYVBYP9SlXzsn0URMkA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6a0cf116f7aso16271986d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420458; x=1715025258;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F7qRuBo9bDIeO33UDBYG1EwRLafgO1luvegessTm0gc=;
        b=skWoZoK8kJKD65qJHVfTtHmvs9iNw4SJGWB1cq0PtoWfkE3YqTBBtfhtr7h7/Z1Grl
         SWGxc1F3aTkoJ4SIfthp7lVIXXwEvyc/8uzfP1/8h5gL925aX5OmgULLn9KwAWEFTSsu
         9gwJPuJDxEtSNbe8nOQeX3CUVkoE2/tgonNe/S4GL8xU7wo+19PKs0i8z0HPCqvHJ2QE
         o5CEj8UZKdInKK4iLHJijVcrctEMpyUkSk7CawsLmuK2KAWBX0+RVYIkFc3PcVr5bScC
         WhhsDbiurCxAZttei1sn/5KJjeQXccnzQlfyC3WJ2j/n7FAvhVOkMKNZKpuoLNakZE7C
         s2lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpz/j7EvFn/AJNVnmHu0geEfYtTy7tK7rfdnI/AUSg7LhwWLumbqAKy7/g3q1TsXbGqOkl0+HMFU2zl8J/kW1msrJyygu0MngoR4NJ
X-Gm-Message-State: AOJu0YxKw7vlRZSVcruZ+NNzjzKmIHxEmdUcNeQj4Lhsj+bsN+ftSXpI
	sH/AgCwBc8v0FMf65mqoTmMoNmLz6dhH/PZYa8ZC60pmkHKGKe7v7m663Pim/CaVfDKoX4KKt5i
	+EZJq6uN1JowiRufggYLVVw712QZHRu+khF/J/+sueqrzSkro9jF8aAxON/nhww==
X-Received: by 2002:a05:6214:29e9:b0:6a0:c903:7243 with SMTP id jv9-20020a05621429e900b006a0c9037243mr652404qvb.55.1714420458653;
        Mon, 29 Apr 2024 12:54:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETtawo5gEjbTl6O1TAaKUtgT93NT1ezpNX07riI/aXk/bxrM7LeNOuwA7+rVilVaCsnFTLcQ==
X-Received: by 2002:a05:6214:29e9:b0:6a0:c903:7243 with SMTP id jv9-20020a05621429e900b006a0c9037243mr652390qvb.55.1714420458348;
        Mon, 29 Apr 2024 12:54:18 -0700 (PDT)
Received: from chopper.lyude.net ([2600:4040:5c6c:a300::789])
        by smtp.gmail.com with ESMTPSA id v8-20020a0ced48000000b006a0d21ba03asm927283qvq.60.2024.04.29.12.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:54:17 -0700 (PDT)
Message-ID: <3cdd429f0c4c1e87cb68977199564af4848d0587.camel@redhat.com>
Subject: Re: [PATCH 2/4] WIP: drm: Introduce rvkms
From: Lyude Paul <lyude@redhat.com>
To: Benno Lossin <benno.lossin@proton.me>, dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida
 Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Date: Mon, 29 Apr 2024 15:54:16 -0400
In-Reply-To: <c04294b3-a08a-44af-b74a-27f6b873c6b8@proton.me>
References: <20240322221305.1403600-1-lyude@redhat.com>
	 <20240322221305.1403600-3-lyude@redhat.com>
	 <b41f707d-7e06-4c1a-93f0-d74ee242b650@proton.me>
	 <6a16f0023b62beba4658677bebcc4786da1ea4be.camel@redhat.com>
	 <c04294b3-a08a-44af-b74a-27f6b873c6b8@proton.me>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-25 at 15:46 +0000, Benno Lossin wrote:
> On 22.04.24 03:54, Lyude Paul wrote:
> > On Wed, 2024-03-27 at 21:06 +0000, Benno Lossin wrote:
> > > On 22.03.24 23:03, Lyude Paul wrote:
> > > > +
> > > > +pub(crate) type Connector =3D
> > > > connector::Connector<DriverConnector>;
> > > > +
> > > > +impl connector::DriverConnector for DriverConnector {
> > > > +=C2=A0=C2=A0=C2=A0 type Initializer =3D impl PinInit<Self, Error>;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 type State =3D ConnectorState;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 type Driver =3D RvkmsDriver;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 type Args =3D ();
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0 fn new(dev: &Device<Self::Driver>, args: Self::=
Args) ->
> > > > Self::Initializer {
> > >=20
> > > And then here just return `Self`.
> > >=20
> > > This works, since there is a blanket impl `PinInit<T, E> for T`.
> > >=20
> > > Looking at how you use this API, I am not sure if you actually
> > > need
> > > pin-init for the type that implements `DriverConnector`.
> > > Do you need to store eg `Mutex<T>` or something else that needs
> > > pin-init in here in a more complex driver?
> >=20
> > Most likely yes - a lot of drivers have various private locks
> > contained
> > within their subclassed mode objects. I'm not sure we will in
> > rvkms's
> > connector since vkms doesn't really do much with connectors - but
> > we at
> > a minimum be using pinned types (spinlocks and hrtimers) in our
> > DriverCrtc implementation once I've started implementing support
> > for
> > vblanks[1]
> >=20
> > [1]
> > https://www.kernel.org/doc/html/v6.9-rc5/gpu/drm-kms.html?highlight=3Dv=
blank#vertical-blanking
> >=20
> > In nova (the main reason I'm working on rvkms in the first place),
> > we'll definitely have locks in our connectors and possibly other
> > types.
>=20
> I see, in that case it would be a good idea to either have an RFC of
> the nova driver (or something else that needs pinned types) as
> motivation for why it needs to be pin-initialized.

I mean - I'll happily include this with the RFC of nova if nova is
ready at that point, but the purpose of rvkms is to exercise enough of
this API to justify merging it :P - and I think it's a lot likely rvkm
is probably going to be ready well before nova gets to the point of
modesetting. And we will definitely have some uses of pinned types in
rvkms once the driver's ready for submission.

>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat


