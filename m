Return-Path: <linux-kernel+bounces-122010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 141F988F0A0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A601C21815
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFAE153510;
	Wed, 27 Mar 2024 21:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VzVU3Au5"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136A015216E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 21:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711573617; cv=none; b=ttwrU0S+MUxYCOziX7QGdRsWtFT443nIzwOtN3q/4VGaZqoLaaYXlruAs5RevKsbqo8D+xrEmtlvy5vd5Ld7a20L8/wSC5ETX0dun9871nuPqp3B+GFLsSgdFjmEZUc/HKb2JomqT6hEuexKePanO8dkP7ZvhPdUGND2K27Gwqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711573617; c=relaxed/simple;
	bh=YrmFkUT787lgt9TKr1idm9VIG50SUrjdiy7+fDVi1tU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZUpyXzc9wgeyw2QXx6/Ic3k3YBOMTPxGJE83GZuep5oa2aFv6dsZCzh/ca/sIFWxXalSIv4IYnaXsRhIicDB8JHfreCP/dreBfKskQKtsShY6j4shDeAgKVZv+3b25cgBaokmg/WmYIJt5ThAEFHTI5UJFYtpzNOB0GX9SQpiDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=VzVU3Au5; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711573609; x=1711832809;
	bh=tmh4P03wZoUNrmGMRDjppoh9LNoMf3SVixBqcaDEGJE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VzVU3Au50Flw9LC5rZqT4ufKGY2RGvXVAD6wqVWwHR3g+HcKuyPqFqKLXbzMVNIq/
	 bB/KSJNYpUi/Z9uUo2mwGyz8MjMqYGBe5jc1cJqmLrv1QFAHguXDxk6d0qkYeunOxu
	 yeUvGtr0AHi/VaWcYtb5ay87EmGVyfvHjrFkKamyeukRgeUMu1taw1uUaeDgRjpTUx
	 UO2Rj++2rE2fvIBpaBA5q2qI45its36ojMnA6d6wIyfaiNaHKw9ueUag5bfUOhoHUZ
	 LPeJO0p9tpaHDHI3ay1MdoFAA5p2/DYsWAl0UBlhNCGAaZqWlwTfRpArIIoBEIm0r1
	 Slcsdqv9eH/sw==
Date: Wed, 27 Mar 2024 21:06:42 +0000
To: Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] WIP: drm: Introduce rvkms
Message-ID: <b41f707d-7e06-4c1a-93f0-d74ee242b650@proton.me>
In-Reply-To: <20240322221305.1403600-3-lyude@redhat.com>
References: <20240322221305.1403600-1-lyude@redhat.com> <20240322221305.1403600-3-lyude@redhat.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22.03.24 23:03, Lyude Paul wrote:
> diff --git a/drivers/gpu/drm/rvkms/connector.rs b/drivers/gpu/drm/rvkms/c=
onnector.rs
> new file mode 100644
> index 0000000000000..40f84d38437ee
> --- /dev/null
> +++ b/drivers/gpu/drm/rvkms/connector.rs
> @@ -0,0 +1,55 @@
> +// TODO: License and stuff
> +// Contain's rvkms's drm_connector implementation
> +
> +use super::{RvkmsDriver, RvkmsDevice, MAX_RES, DEFAULT_RES};
> +use kernel::{
> +    prelude::*,
> +    drm::{
> +        device::Device,
> +        kms::{
> +            connector::{self, ConnectorGuard},
> +            ModeConfigGuard
> +        }
> +    },
> +    prelude::*
> +};
> +use core::marker::PhantomPinned;
> +
> +#[pin_data]
> +pub(crate) struct DriverConnector {
> +    #[pin]
> +    _p: PhantomPinned
> +}

This struct does not need to be annotated with `#[pin_data]`, this
should just work:

pub(crate) struct DriverConnector;

> +
> +pub(crate) type Connector =3D connector::Connector<DriverConnector>;
> +
> +impl connector::DriverConnector for DriverConnector {
> +    type Initializer =3D impl PinInit<Self, Error>;
> +
> +    type State =3D ConnectorState;
> +
> +    type Driver =3D RvkmsDriver;
> +
> +    type Args =3D ();
> +
> +    fn new(dev: &Device<Self::Driver>, args: Self::Args) -> Self::Initia=
lizer {

And then here just return `Self`.

This works, since there is a blanket impl `PinInit<T, E> for T`.

Looking at how you use this API, I am not sure if you actually need
pin-init for the type that implements `DriverConnector`.
Do you need to store eg `Mutex<T>` or something else that needs
pin-init in here in a more complex driver?

--=20
Cheers,
Benno

> +        try_pin_init!(Self { _p: PhantomPinned })
> +    }
> +
> +    fn get_modes(
> +        connector: ConnectorGuard<'_, Self>,
> +        _guard: &ModeConfigGuard<'_, Self::Driver>
> +    ) -> i32 {
> +        let count =3D connector.add_modes_noedid(MAX_RES);
> +
> +        connector.set_preferred_mode(DEFAULT_RES);
> +        count
> +    }
> +}
> +
> +#[derive(Clone, Default)]
> +pub(crate) struct ConnectorState;
> +
> +impl connector::DriverConnectorState for ConnectorState {
> +    type Connector =3D DriverConnector;
> +}


