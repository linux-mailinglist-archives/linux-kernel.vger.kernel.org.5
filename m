Return-Path: <linux-kernel+bounces-48858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7A2846271
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8221C24AAA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC273E497;
	Thu,  1 Feb 2024 21:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="GNaUeSe7"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03413CF6B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821623; cv=none; b=LItjmFbmq+QiWzSyenLDSnDRS1ZwVofzXbwcP50PwuUlUsaLAvAau52QEtLaOobCCD5yk4NQMW8hHNP8BuGhez23fVsDwTUYEFO4cjPhfpeWg6AvKxnt1FS/4Ym9Vw8n6ifg3aBLN9FroWK/MeO5jRdvLP7mklwkKqhmMboFrSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821623; c=relaxed/simple;
	bh=oPJOZv03hwxbqkYwudlxIPTDiQRZpFGwDc+SB/ATHDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTwQNK8Fh77cbzftZ5N87HOO6Lrt5OZxyZkk9yNpadyn9s6obGQS5Tb+Df01ZIrF9rw/2JspcwK8j68N1jDt8YY2yO+LXeQLyYlJ5mskauEmiYrmrQyReTxNr5/Vvcj+Dm9FW8TgjrTdaYIBD91N6lN6XZa9jQY6hZS2guMO/PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=GNaUeSe7; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60406f4e1d0so14110267b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 13:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1706821619; x=1707426419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yt7e5kW67jPJRZM8ErOQj6BquenTsqSTjJPhbNcD7fw=;
        b=GNaUeSe7A3mHBwARmu5PgQQlF34wzp2roJJMQ7FBpM4dmXq1y9eWsulUwONYwZU2Kr
         Z/KmrVBxiM4Z28O8v/6lDo8JySTh0XUAUh3zvteIUhw1MyA8Vy77y1T33EqdbxX8SLjg
         Cs+7yenilbNn4n90l71QyQqV2c32lBgr3Z1qJfhPRX8DHdIy/pf62utIN7sW4bvpgZKY
         rG9D8s/0S+8AYeo7USUHQqcWuO+xlhqvN+7dxKP0M9KAXoJhvhODld7HGJtziUgO0HoW
         H4f/ZcB3X653UyUjEUWsF/GIhQfYl+3c+JJiBMz7Vz3/JRqH2wdxB+EivncC7mimpqRX
         TdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706821619; x=1707426419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yt7e5kW67jPJRZM8ErOQj6BquenTsqSTjJPhbNcD7fw=;
        b=OcTKHyVlODVYRt/AT5QA0WPJcpSJOzrSR9Dfv5DN9HWrGFcoNitxPThHRIrQ1xjgOl
         6mZ6TKbwFxTCh2Jci9d1jB7Cto6ZRvxq7CwZPZLlo55AipbpYBueB1Fsi1vikpHAgDUL
         h315+54wWQWNx9RiQkAyBCjMvT0RYfU40qCoXN8srqXUgGVGAAGSIIvJuQ+Gbmn+BLTW
         MlQWiMGLCs0/j21g6cmQyfQ7V/CreUnVeb4M2r5/ylMmp+VDSXGIBppoYyQyWpOERhff
         KZeSzji9Iw9BADa/e4sl2BuoSQ0fJPjtFmIOIKws9WaJ1DxNkYXLaM46LUZ3WJcVPtKU
         0Y2A==
X-Gm-Message-State: AOJu0Yy/mIfwE8NBGVQKCRmdO//Qu0Cg6yRpNf/w6fSaXDfo/3rA0e+8
	Ve8P8mQr/SS0jfxyx04oLSthj080CujdnIA3JTY404oySiDEaxjkfScJ2GFMcviv+p2ZP7PZ0Sm
	kz8UTphWjgrlJoPtUNpIIRE+/gjjxTIymYKQbgw==
X-Google-Smtp-Source: AGHT+IGEUKSA0ksa3LSL8TqJTFxwolHbJCZbeQLC+r6L2WGPwgMdAzKp16oStnHvrtxqabrcInoFkHb1EhGBbU2VoDs=
X-Received: by 2002:a81:4813:0:b0:602:9f2e:c513 with SMTP id
 v19-20020a814813000000b006029f2ec513mr3819062ywa.4.1706821618780; Thu, 01 Feb
 2024 13:06:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201-rockchip-rust-phy_depend-v2-0-c5fa4faab924@christina-quast.de>
 <20240201-rockchip-rust-phy_depend-v2-3-c5fa4faab924@christina-quast.de>
In-Reply-To: <20240201-rockchip-rust-phy_depend-v2-3-c5fa4faab924@christina-quast.de>
From: Trevor Gross <tmgross@umich.edu>
Date: Thu, 1 Feb 2024 15:06:47 -0600
Message-ID: <CALNs47tnwCgyvM2jBo=bTt1=2AJFt3b6W+JsTHM3Np2tbNJYCA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Rockchip PHY driver
To: Christina Quast <contact@christina-quast.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiko Stuebner <heiko@sntech.de>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 12:07=E2=80=AFPM Christina Quast
<contact@christina-quast.de> wrote:
> +++ b/drivers/net/phy/rockchip_rust.rs
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2024 Christina Quast <contact@christina-quast.de>
> +
> +//! Rust Rockchip PHY driver
> +//!
> +//! C version of this driver: [`drivers/net/phy/rockchip.c`](./rockchip.=
c)
> +use kernel::{
> +    c_str,
> +    net::phy::{self, DeviceId, Driver},
> +    prelude::*,
> +    uapi,
> +};
> +
> +kernel::module_phy_driver! {
> +    drivers: [PhyRockchip],
> +    device_table: [
> +        DeviceId::new_with_driver::<PhyRockchip>(),
> +    ],
> +    name: "rust_asix_phy",
> +    author: "FUJITA Tomonori <fujita.tomonori@gmail.com>",

Tomo wrote this? :)

> +    description: "Rust Asix PHYs driver",
> +    license: "GPL",
> +}
> +
> +
> +const MII_INTERNAL_CTRL_STATUS: u16 =3D 17;
> +const SMI_ADDR_TSTCNTL: u16 =3D 20;
> +const SMI_ADDR_TSTWRITE: u16 =3D 23;
> +
> +const MII_AUTO_MDIX_EN: u16 =3D bit(7);
> +const MII_MDIX_EN: u16 =3D bit(6);
> +
> +const TSTCNTL_WR: u16 =3D bit(14) | bit(10);
> +
> +const TSTMODE_ENABLE: u16 =3D 0x400;
> +const TSTMODE_DISABLE: u16 =3D 0x0;
> +
> +const WR_ADDR_A7CFG: u16 =3D 0x18;

Most of these are clear enough, but could you add comments about what
the more ambiguous constants are for? (e.g. A7CFG).

> +struct PhyRockchip;
> +
> +impl PhyRockchip {

Remove the `helper_` prefix for these functions, and change the docs.
Their use as helpers is obvious enough based on where they are called,
better to say what they actually accomplish.

Since they don't take `self`, these could also just be standalone
functions rather than in an `impl PhyRockchip` block. This makes
calling them a bit cleaner since you don't need the `PhyRockchip::`
prefix.

> +   /// Helper function for helper_integrated_phy_analog_init
> +    fn helper_init_tstmode(dev: &mut phy::Device) -> Result {
> +        // Enable access to Analog and DSP register banks
> +        dev.write(SMI_ADDR_TSTCNTL, TSTMODE_ENABLE)?;
> +        dev.write(SMI_ADDR_TSTCNTL, TSTMODE_DISABLE)?;
> +        dev.write(SMI_ADDR_TSTCNTL, TSTMODE_ENABLE)
> +    }

For consistency, just make the last write also end with `?;` and add a
`Ok(())` line.

> +
> +    /// Helper function for helper_integrated_phy_analog_init
> +    fn helper_close_tstmode(dev: &mut phy::Device) -> Result {
> +        dev.write(SMI_ADDR_TSTCNTL, TSTMODE_DISABLE)
> +    }
> +
> +    /// Helper function for rockchip_config_init
> +    fn helper_integrated_phy_analog_init(dev: &mut phy::Device) -> Resul=
t {
> +        Self::helper_init_tstmode(dev)?;
> +        dev.write(SMI_ADDR_TSTWRITE, 0xB)?;
> +        dev.write(SMI_ADDR_TSTCNTL, TSTCNTL_WR | WR_ADDR_A7CFG)?;
> +        Self::helper_close_tstmode(dev)
> +    }
> +
> +    /// Helper function for config_init
> +    fn helper_config_init(dev: &mut phy::Device) -> Result {
> +        let val =3D !MII_AUTO_MDIX_EN & dev.read(MII_INTERNAL_CTRL_STATU=
S)?;
> +        dev.write(MII_INTERNAL_CTRL_STATUS, val)?;
> +        Self::helper_integrated_phy_analog_init(dev)
> +    }
> +
> +    fn helper_set_polarity(dev: &mut phy::Device, polarity: u8) -> Resul=
t {
> +        let reg =3D !MII_AUTO_MDIX_EN & dev.read(MII_INTERNAL_CTRL_STATU=
S)?;
> +        let val =3D match polarity as u32 {
> +            // status: MDI; control: force MDI
> +            uapi::ETH_TP_MDI =3D> Some(reg & !MII_MDIX_EN),
> +            // status: MDI-X; control: force MDI-X
> +            uapi::ETH_TP_MDI_X =3D> Some(reg | MII_MDIX_EN),
> +            // uapi::ETH_TP_MDI_AUTO =3D> control: auto-select
> +            // uapi::ETH_TP_MDI_INVALID =3D> status: unknown; control: u=
nsupported
> +            _ =3D> None,

Is receiving an invalid value not an error? I.e.

    uapi::ETH_TP_MDI_AUTO | uapi::ETH_TP_MDI_INVALID =3D> None,
    _ =3D> return Err(...)

I know the current implementation came from the C version, just
wondering about correctness here.

> +        };
> +        if let Some(v) =3D val {
> +            if v !=3D reg {
> +                return dev.write(MII_INTERNAL_CTRL_STATUS, v);
> +            }
> +        }

In the match statement above - I think you can replace `=3D> None` with
`=3D> return Ok(())` and drop the `Some(...)` wrappers. Then you don't
need to destructure val here.

> +        Ok(())
> +
> +    }
> +}
> +
> +#[vtable]
> +impl Driver for PhyRockchip {
> +    const FLAGS: u32 =3D 0;
> +    const NAME: &'static CStr =3D c_str!("Rockchip integrated EPHY");
> +    const PHY_DEVICE_ID: DeviceId =3D DeviceId::new_with_custom_mask(0x1=
234d400, 0xfffffff0);
> +
> +    fn link_change_notify(dev: &mut phy::Device) {
> +    // If mode switch happens from 10BT to 100BT, all DSP/AFE
> +    // registers are set to default values. So any AFE/DSP
> +    // registers have to be re-initialized in this case.

Comment indent

> +        if dev.state() =3D=3D phy::DeviceState::Running && dev.speed() =
=3D=3D uapi::SPEED_100 {
> +            if let Err(e) =3D Self::helper_integrated_phy_analog_init(de=
v) {
> +                pr_err!("rockchip: integrated_phy_analog_init err: {:?}"=
, e);
> +            }
> +        }
> +    }
> +
> +    fn soft_reset(dev: &mut phy::Device) -> Result {
> +        dev.genphy_soft_reset()
> +    }
> +
> +    fn config_init(dev: &mut phy::Device) -> Result {
> +        PhyRockchip::helper_config_init(dev)
> +    }
> +
> +    fn config_aneg(dev: &mut phy::Device) -> Result {
> +        PhyRockchip::helper_set_polarity(dev, dev.mdix())?;
> +        dev.genphy_config_aneg()
> +    }
> +
> +    fn suspend(dev: &mut phy::Device) -> Result {
> +        dev.genphy_suspend()
> +    }
> +
> +    fn resume(dev: &mut phy::Device) -> Result {
> +        let _ =3D dev.genphy_resume();

Why not `?` the possible error?

> +
> +        PhyRockchip::helper_config_init(dev)
> +    }
> +}
>
> --
> 2.43.0
>

As Greg and Dragan mentioned, duplicate drivers are generally not
accepted in-tree to avoid double maintenance and confusing config. Is
there a specific goal?

It is quite alright to request feedback on Rust drivers (and I have
provided some) or even ask if anyone is willing to help test it out,
but please use RFC PATCH and make it clear that this is for
experimentation rather than upstreaming.

Netdev has seemed relatively open to adding Rust drivers for new phys
that don't have a C implementation, but these phys are of course
tougher to find.

Also for future reference, changes intended for the net tree should be
labeled [PATCH v? net-next].

Best regards,
Trevor

