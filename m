Return-Path: <linux-kernel+bounces-121997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA7A88F07C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8D91C289BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491AF15350A;
	Wed, 27 Mar 2024 20:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OZATpAA2"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC56514F9D7;
	Wed, 27 Mar 2024 20:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711572658; cv=none; b=GJVjrSg0aqnsQpc+UX+a7rJh80cPaLM72RVRPzBk3FslGY27njp4yfwrsxt9dGvfB0wAWuJwB8LU19dw+bP4cfgs87o9r6hhgtY+HmqBoxHuxDKJssKSDEO3TNs8/HVQPDYjZNl4j8+aBfba9ST5fxjpeCpI3z95ZIlHGQzM4qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711572658; c=relaxed/simple;
	bh=ecYiF3LQleWO2eJWakbWwxOepT7U6SM8Ty5eSgD+pf4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2oFWe26X4H5MqOrcPDgghJmVawxuqRRS3xVhf3PBki8fCHA10Pc+50+Pwrt3XsqGqSgbk9vJZ/whibZch2ZcqlpiIU4FIZCSf9XhAvoE2pH2GmVuyBJueZ8DKjSQqEIY4fZxCsUkVo+njecvkEbO9slz7NhV9++qdxc5UWWrYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OZATpAA2; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711572647; x=1711831847;
	bh=Q/iz2zOOWcC6GoMvllWnFGxZfFo5UxgnI33gxsE3uvU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OZATpAA2GN+yg7TWfSRcOcphct4vymBRaLAYLlyyZs/iQAyzE5x1bilo6G/92AKU0
	 Qwfzu7H5sOuM2xYrP46wcHnxEmB9E/3Mjknpuk+ihYZXxPTpW8aLvyHBYZ7Spe8Cgy
	 rem6NLYzuKrQiBYINHSk6fCBkfLcf3lbWxwp6Q+11Zjb4SzIA7N/7pUS9m7+VJhjOI
	 9YpI8TK7Az2LAOahprCZ817TZijFzrIVesyinZSVhlfsNR/OlRZvc84dgI/YrG7nXB
	 QDQneQLAEgm6bNFFXcQK5gd7cJXFWBZz7/6g4YYCe1ATTb8yEmMsufKhBuJk+W0vb0
	 lGMcDGNAdCL4Q==
Date: Wed, 27 Mar 2024 20:50:41 +0000
To: Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Asahi Lina <lina@asahilina.net>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Danilo Krummrich <dakr@redhat.com>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/4] WIP: rust: Add basic KMS bindings
Message-ID: <0785452f-7714-4384-838b-879e0b224c3c@proton.me>
In-Reply-To: <20240322221305.1403600-2-lyude@redhat.com>
References: <20240322221305.1403600-1-lyude@redhat.com> <20240322221305.1403600-2-lyude@redhat.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I just took a quick look and commented on the things that stuck
out to me. Some general things:
- several `unsafe` blocks have missing SAFETY comments,
- missing documentation and examples.

On 22.03.24 23:03, Lyude Paul wrote:
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/bindings/bindings_helper.h  |   4 +
>  rust/helpers.c                   |  17 ++
>  rust/kernel/drm/device.rs        |   2 +
>  rust/kernel/drm/drv.rs           | 115 +++++++--
>  rust/kernel/drm/kms.rs           | 146 +++++++++++
>  rust/kernel/drm/kms/connector.rs | 404 +++++++++++++++++++++++++++++++
>  rust/kernel/drm/kms/crtc.rs      | 300 +++++++++++++++++++++++
>  rust/kernel/drm/kms/encoder.rs   | 175 +++++++++++++
>  rust/kernel/drm/kms/plane.rs     | 300 +++++++++++++++++++++++
>  rust/kernel/drm/mod.rs           |   1 +
>  10 files changed, 1448 insertions(+), 16 deletions(-)

Please try to break this up into smaller patches. It makes review
a lot easier!

[...]

> diff --git a/rust/kernel/drm/kms.rs b/rust/kernel/drm/kms.rs
> new file mode 100644
> index 0000000000000..b55d14415367a
> --- /dev/null
> +++ b/rust/kernel/drm/kms.rs
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +
> +//! KMS driver abstractions for rust.
> +
> +pub mod connector;
> +pub mod crtc;
> +pub mod encoder;
> +pub mod plane;
> +
> +use crate::{
> +    drm::{drv, device::Device},
> +    prelude::*,
> +    types::ARef,
> +    private::Sealed
> +};
> +use core::{
> +    ops::Deref,
> +    ptr,
> +};
> +use bindings;
> +
> +#[derive(Copy, Clone)]
> +pub struct ModeConfigInfo {
> +    /// The minimum (w, h) resolution this driver can support
> +    pub min_resolution: (i32, i32),
> +    /// The maximum (w, h) resolution this driver can support
> +    pub max_resolution: (i32, i32),
> +    /// The maximum (w, h) cursor size this driver can support
> +    pub max_cursor: (u32, u32),
> +    /// The preferred depth for dumb ioctls
> +    pub preferred_depth: u32,
> +}
> +
> +// TODO: I am not totally sure about this. Ideally, I'd like a nice way =
of hiding KMS-specific
> +// functions for DRM drivers which don't implement KMS - so that we don'=
t have to have a bunch of
> +// random modesetting functions all over the DRM device trait. But, unfo=
rtunately I don't know of
> +// any nice way of doing that yet :(

I don't follow, can't you put the KMS specific functions into the
KmsDriver trait?

> +
> +/// An atomic KMS driver implementation
> +pub trait KmsDriver: drv::Driver { }
> +
> +impl<T: KmsDriver> Device<T> {
> +    pub fn mode_config_reset(&self) {
> +        // SAFETY: The previous build assertion ensures this can only be=
 called for devices with KMS
> +        // support, which means mode_config is initialized
> +        unsafe { bindings::drm_mode_config_reset(self.drm.get()) }
> +    }
> +}
> +
> +/// Main trait for a modesetting object in DRM
> +pub trait ModeObject: Sealed + Send + Sync {
> +    /// The parent driver for this ModeObject
> +    type Driver: KmsDriver;
> +
> +    /// Return the `drv::Device` for this `ModeObject`
> +    fn drm_dev(&self) -> &Device<Self::Driver>;
> +}

[...]

> diff --git a/rust/kernel/drm/kms/connector.rs b/rust/kernel/drm/kms/conne=
ctor.rs
> new file mode 100644
> index 0000000000000..88dfa946d306b
> --- /dev/null
> +++ b/rust/kernel/drm/kms/connector.rs
> @@ -0,0 +1,404 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +
> +//! Rust bindings for DRM connectors
> +
> +use crate::{
> +    bindings,
> +    sync::ArcBorrow,
> +    drm::{
> +        drv::{Driver, FEAT_MODESET},
> +        device::Device,
> +    },
> +    types::{AlwaysRefCounted, Opaque, ARef},
> +    prelude::*,
> +    init::Zeroable,
> +    error::{to_result, from_result},
> +    build_error,
> +};
> +use core::{
> +    marker::PhantomPinned,
> +    ptr::null_mut,
> +    mem,
> +    ptr::{self, NonNull},
> +    ffi::*,
> +    ops::Deref,
> +};
> +use super::{
> +    ModeObject,
> +    ModeConfigGuard,
> +    encoder::{Encoder, DriverEncoder},
> +    KmsDriver,
> +};
> +use macros::pin_data;
> +
> +// XXX: This is :\, figure out a better way at some point?
> +pub use bindings::{
> +    DRM_MODE_CONNECTOR_Unknown,
> +    DRM_MODE_CONNECTOR_VGA,
> +    DRM_MODE_CONNECTOR_DVII,
> +    DRM_MODE_CONNECTOR_DVID,
> +    DRM_MODE_CONNECTOR_DVIA,
> +    DRM_MODE_CONNECTOR_Composite,
> +    DRM_MODE_CONNECTOR_SVIDEO,
> +    DRM_MODE_CONNECTOR_LVDS,
> +    DRM_MODE_CONNECTOR_Component,
> +    DRM_MODE_CONNECTOR_9PinDIN,
> +    DRM_MODE_CONNECTOR_DisplayPort,
> +    DRM_MODE_CONNECTOR_HDMIA,
> +    DRM_MODE_CONNECTOR_HDMIB,
> +    DRM_MODE_CONNECTOR_TV,
> +    DRM_MODE_CONNECTOR_eDP,
> +    DRM_MODE_CONNECTOR_VIRTUAL,
> +    DRM_MODE_CONNECTOR_DSI,
> +    DRM_MODE_CONNECTOR_DPI,
> +    DRM_MODE_CONNECTOR_WRITEBACK,
> +    DRM_MODE_CONNECTOR_SPI,
> +    DRM_MODE_CONNECTOR_USB,
> +};
> +
> +/// A DRM connector implementation
> +pub trait DriverConnector: Send + Sync + Sized {
> +    /// The return type of the new() function. Should be `impl PinInit<S=
elf, Error>`.
> +    /// TODO: Remove this when return_position_impl_trait_in_trait is st=
able.
> +    type Initializer: PinInit<Self, Error>;

This has been stabilized in 1.75.0, so now you should be able to write

     fn new(dev: &Device<Self::Driver>, args: Self::Args) -> impl PinInit<S=
elf, Error>;

> +
> +    /// The data type to use for passing incoming arguments for new `Con=
nector<T>` instances
> +    /// Drivers which don't care about this can just use `()`
> +    type Args;
> +
> +    /// The parent driver for this DRM connector implementation
> +    type Driver: KmsDriver;
> +
> +    /// The atomic state implementation for this DRM connector implement=
ation
> +    type State: DriverConnectorState;
> +
> +    /// Create a new instance of the private driver data struct for this=
 connector in-place
> +    fn new(dev: &Device<Self::Driver>, args: Self::Args) -> Self::Initia=
lizer;
> +
> +    /// Retrieve a list of available display modes for this connector
> +    fn get_modes<'a>(
> +        connector: ConnectorGuard<'a, Self>,
> +        guard: &ModeConfigGuard<'a, Self::Driver>
> +    ) -> i32;
> +}

[...]

> diff --git a/rust/kernel/drm/kms/crtc.rs b/rust/kernel/drm/kms/crtc.rs
> new file mode 100644
> index 0000000000000..3d072028a4884
> --- /dev/null
> +++ b/rust/kernel/drm/kms/crtc.rs
> @@ -0,0 +1,300 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +
> +//! KMS driver abstractions for rust.
> +
> +use super::{
> +    plane::*,
> +    ModeObject,
> +    StaticModeObject,
> +    KmsDriver
> +};
> +use crate::{
> +    bindings,
> +    drm::{drv::Driver, device::Device},
> +    device,
> +    prelude::*,
> +    types::Opaque,
> +    init::Zeroable,
> +    sync::Arc,
> +    error::to_result,
> +};
> +use core::{
> +    cell::UnsafeCell,
> +    marker::PhantomPinned,
> +    ptr::{null, null_mut},
> +    ops::Deref,
> +};
> +use macros::vtable;
> +
> +/// A typed KMS CRTC with a specific driver.
> +#[repr(C)]
> +#[pin_data]
> +pub struct Crtc<T: DriverCrtc> {
> +    // The FFI drm_crtc object
> +    pub(super) crtc: Opaque<bindings::drm_crtc>,
> +    /// The driver's private inner data
> +    #[pin]
> +    inner: T,
> +    #[pin]
> +    _p: PhantomPinned,

Instead of adding this field, you can mark the `crtc` field above as
`#[pin]`. This is because of 0b4e3b6f6b79 ("rust: types: make `Opaque`
be `!Unpin`").

--=20
Cheers,
Benno

> +}
> +
> +/// KMS CRTC object functions, which must be implemented by drivers.
> +pub trait DriverCrtc: Send + Sync + Sized {
> +    /// The return type of the new() function. Should be `impl PinInit<S=
elf, Error>`.
> +    /// TODO: Remove this when return_position_impl_trait_in_trait is st=
able.
> +    type Initializer: PinInit<Self, Error>;
> +
> +    /// The data type to use for passing incoming arguments for new `Crt=
c<T>` instances
> +    /// Drivers which don't care about this can just use `()`
> +    type Args;
> +
> +    /// The parent driver implementation
> +    type Driver: KmsDriver;
> +
> +    /// The type for this driver's drm_crtc_state implementation
> +    type State: DriverCrtcState;
> +
> +    /// Create a new CRTC for this driver
> +    fn new(device: &Device<Self::Driver>, args: Self::Args) -> Self::Ini=
tializer;
> +}


