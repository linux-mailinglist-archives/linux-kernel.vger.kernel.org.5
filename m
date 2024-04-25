Return-Path: <linux-kernel+bounces-158836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D19F58B2588
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9591C21D3F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA8914C58A;
	Thu, 25 Apr 2024 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="HMZCcv4d"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FC614A600;
	Thu, 25 Apr 2024 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059987; cv=none; b=bdHLhNSv/NML4pT/ecpmKLSiiZ+ypXL21HKC80MpCoA5AFxKz6Q4oFdJB5pvO4o4NOlvm4F/GWy5CWtr+ylWeNkFYIdNkMi3a+UdC/LRkbwL7VvzniRUf/GcqRJK4OtaMv3xHnUNdg1IH/TAGdqDFRmFMpRg+vAQDbe9CP8wySg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059987; c=relaxed/simple;
	bh=BdnPwz8X5VjIlyxGHTHB1xmygmV3v31FLtNCSVMN0D4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8IzXX26VG5FoljMm0PUZhyg5jwdhUYBL+FcmU1jCUoTM+keO8JN34qdnDbzaEGNvVUsjUIqfZqQ00evQ5lFcBu9WfQlD61qVVVMoRwMjXXIMmIuLCi2ZoU3tFCToKs8R+Sp/gO4tgYtq/731Kw1x6Sov6sARVpptcq6wsg7L8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=HMZCcv4d; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1714059977; x=1714319177;
	bh=7jYU4x9SG+HzxaQPBZY9kv9tKEO30Ph+k3fkjG3u5NU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=HMZCcv4d0BzKDpblcZGIwbOk3RmoAhA/+tFRH63hwaUiN4O86P6ylvMu1HKbeE+AU
	 zHAQgUzL8N5vjrvfWjPFkgEYnyyhHV5d6r04PJAym1bBsX9T7e8adQy0u4bSQtu3BX
	 bpZbFiu5Hzc4KnKODFcP9smXpANOcclBMQDmNDF0TfxBuHRMxD4szqeHKx8PJXi5nu
	 C7AO959VexM/iJIJ5YeoFsfGh+kErnwPHeR3Or8pvg0aOkf/BygIY9DER4fGM1Z4Dr
	 S6ha4tT7WwlKX5BemzU210QuVwlmAV+qregOx2x9knfQ0UdbnngE7U5pJSapoBQShZ
	 m+IUKkNmNsVGg==
Date: Thu, 25 Apr 2024 15:46:14 +0000
To: Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] WIP: drm: Introduce rvkms
Message-ID: <c04294b3-a08a-44af-b74a-27f6b873c6b8@proton.me>
In-Reply-To: <6a16f0023b62beba4658677bebcc4786da1ea4be.camel@redhat.com>
References: <20240322221305.1403600-1-lyude@redhat.com> <20240322221305.1403600-3-lyude@redhat.com> <b41f707d-7e06-4c1a-93f0-d74ee242b650@proton.me> <6a16f0023b62beba4658677bebcc4786da1ea4be.camel@redhat.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 045ae0f74a45c39b91a85c78c275bb36ea47dee4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22.04.24 03:54, Lyude Paul wrote:
> On Wed, 2024-03-27 at 21:06 +0000, Benno Lossin wrote:
>> On 22.03.24 23:03, Lyude Paul wrote:
>>> +
>>> +pub(crate) type Connector =3D connector::Connector<DriverConnector>;
>>> +
>>> +impl connector::DriverConnector for DriverConnector {
>>> +    type Initializer =3D impl PinInit<Self, Error>;
>>> +
>>> +    type State =3D ConnectorState;
>>> +
>>> +    type Driver =3D RvkmsDriver;
>>> +
>>> +    type Args =3D ();
>>> +
>>> +    fn new(dev: &Device<Self::Driver>, args: Self::Args) ->
>>> Self::Initializer {
>>
>> And then here just return `Self`.
>>
>> This works, since there is a blanket impl `PinInit<T, E> for T`.
>>
>> Looking at how you use this API, I am not sure if you actually need
>> pin-init for the type that implements `DriverConnector`.
>> Do you need to store eg `Mutex<T>` or something else that needs
>> pin-init in here in a more complex driver?
>=20
> Most likely yes - a lot of drivers have various private locks contained
> within their subclassed mode objects. I'm not sure we will in rvkms's
> connector since vkms doesn't really do much with connectors - but we at
> a minimum be using pinned types (spinlocks and hrtimers) in our
> DriverCrtc implementation once I've started implementing support for
> vblanks[1]
>=20
> [1]
> https://www.kernel.org/doc/html/v6.9-rc5/gpu/drm-kms.html?highlight=3Dvbl=
ank#vertical-blanking
>=20
> In nova (the main reason I'm working on rvkms in the first place),
> we'll definitely have locks in our connectors and possibly other types.

I see, in that case it would be a good idea to either have an RFC of
the nova driver (or something else that needs pinned types) as
motivation for why it needs to be pin-initialized.

--=20
Cheers,
Benno


