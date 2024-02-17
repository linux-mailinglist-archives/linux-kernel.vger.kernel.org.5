Return-Path: <linux-kernel+bounces-70109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A8385932C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 23:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F9C1C21885
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBABA7E776;
	Sat, 17 Feb 2024 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="qOyWBu8C"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A14134A4
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708209474; cv=none; b=M94XR8VzYh7fROOy9tqGT9n2b38syiRhonC6rknwfEF+NYrwvx08LG/ipX8cVG9pA4js7pWB1qaH/eT3dZrLf2dT8pb7j0xmgHgMJasv6IXQWMrnvxj8Rb1kEBLqBo13Y/eRyZzCL3Gp+49AUHOZIkrQnvXre6ZMAz9onXkCiXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708209474; c=relaxed/simple;
	bh=mXba6hqy4dCzrYQ6io3X7C/CsiKFmU6NoraJTKNqLl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTAyEksZ6s8kqgmtypoTt1IZQ0JUBcUF54ZihhO5URv39ZjVmaH8b1JVjI2jgfgOQeBZxKopCppZ+2qpHQdTWRQyAcdBbHn8AB3glCbT1srnSTu8W6haEcafhW1qGzvrwu28bdxDPPPS3VkISYfnK78VRpT6aGdxoUHwqayGse0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=qOyWBu8C; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so3010592276.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 14:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1708209471; x=1708814271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Si25AaPYYhYTOkmgXRWHuRBAH3Xq06xq/4sUPyQ+50s=;
        b=qOyWBu8CeO4cY/rLgb2cb6WD+aaGYdzbtb7PVGCY571mb3qrMFdfRLeYTuDirJHz2Q
         gHPdjx/e6LUleYX52S8sWwL+EKCz58tP+pkxKWvM3vd+SSmLCAyf7JKG6yBX2L5QqPRn
         UIqh5mADFkdgmWCiItMSC9WfET7gna2dV8gUCsvGaesjDo2X+Vx+kN6VuD7H3RjD85m8
         bx0H4aQaDnShU/eoIy/6ZLAJVgPfIWl6MLgk1r7Y2yGigbLeIseq9QaxZE28kARSdJdv
         +wXf5wpeA22YeHCLqHnzjoa7m6x27hvKQ0zb6YcG1YYO+QeW1OxtSZ/UFXDdgOCUG5kO
         2ipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708209471; x=1708814271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Si25AaPYYhYTOkmgXRWHuRBAH3Xq06xq/4sUPyQ+50s=;
        b=qtk+p5Np1lSkgBVuFoytf9PrqzJqfXBCcmdd/Qbes569bPiOWikJDbQKk/p8F44qc8
         bwO/eszspQmceDOUG6CkNwfUJ4qQPc7L/xViwiaBsgeGViEKu1kcvMQE6RYwN4YXp3C1
         YmTLw5DutwubPWZAfmNvj7F42IPLzs8yqzydqGjw1SG1lNt/ja18PKx1UON0qWrdNWx7
         x11GZIPMjv9JOJWNyDLXORnCcMWAJ2GHJEqqb+JWkWdFn6oAC/gzS5/Bii+KPoCXC3RI
         TQoPgb+jhmyIMdYdE3/DxDMfnvza9yaIApP7U4hPuKtvD3nmWLEfWqCR+Kp/8ucIAzsq
         wScQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPrzUPlemDhylF2SIjyV04j2ieit4e1imdICR4cg/Xwj3IemWUshzrtRC2zlX7pxY9S4MIVLXhcUEgikb2l/yS6lSOSk3c5I6z7tlJ
X-Gm-Message-State: AOJu0YwhQ131XrGFUDme6rg5Y1uq9GQ6bjC7srWt6rdE0d41EwZweFZL
	Z/Nm+oiP5k1/yRCAil3p3fw0jJnhz+4F0RB6PswpAheBghckjJVwK6vTBUuTSYp8prBIMMlgtWj
	y5NI5tGtLmCdVFcKl8nKFeX64QEtG3qNCihpMmA==
X-Google-Smtp-Source: AGHT+IETMFjsYK3d6///nf/q6zU3UY5udQD41mjum77p14dyrbBbJatI8RG3wLWwYuGYzjxvZjlhJjf+lR1NXXadsAE=
X-Received: by 2002:a25:a027:0:b0:dcd:2f2d:7a05 with SMTP id
 x36-20020a25a027000000b00dcd2f2d7a05mr8428908ybh.35.1708209470967; Sat, 17
 Feb 2024 14:37:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217194116.8565-1-ansuelsmth@gmail.com>
In-Reply-To: <20240217194116.8565-1-ansuelsmth@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sat, 17 Feb 2024 17:37:39 -0500
Message-ID: <CALNs47szQu9RB8stBkdn+q3ejKrQgUFCDzhS8Wzy+WENeL=xAw@mail.gmail.com>
Subject: Re: [net-next RFC PATCH 0/3] net: phy: detach PHY driver OPs from
 phy_driver struct
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Richard Cochran <richardcochran@gmail.com>, 
	=?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	Daniel Golle <daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>, 
	SkyLake Huang <SkyLake.Huang@mediatek.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Arun Ramadoss <arun.ramadoss@microchip.com>, UNGLinuxDriver@microchip.com, 
	Peter Geis <pgwipeout@gmail.com>, Frank <Frank.Sae@motor-comm.com>, 
	Xu Liang <lxu@maxlinear.com>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, 
	Andrei Botila <andrei.botila@oss.nxp.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
	Michal Simek <michal.simek@amd.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Robert Marko <robimarko@gmail.com>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, 
	David Epping <david.epping@missinglinkelectronics.com>, 
	Harini Katakam <harini.katakam@amd.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 2:41=E2=80=AFPM Christian Marangi <ansuelsmth@gmail=
com> wrote:
>
> I took care to compile-test all the PHY, only exception is the unique
> RUST driver, where I still have to learn that funny language and
> I didn't had time to update it, so that is the only driver that
> I think require some fixup.

This will only need an update in the abstraction at
rust/kernel/net/phy.rs, roughly (untested)

@@ -5,15 +5,22 @@ pub const fn create_phy_driver<T: Driver>() -> DriverV
         flags: T::FLAGS,
         phy_id: T::PHY_DEVICE_ID.id,
         phy_id_mask: T::PHY_DEVICE_ID.mask_as_int(),
-        soft_reset: if T::HAS_SOFT_RESET {
-            Some(Adapter::<T>::soft_reset_callback)
-        } else {
-            None
+        phy_driver_ops: &bindings::phy_driver_ops {
+            soft_reset: if T::HAS_SOFT_RESET {
+                Some(Adapter::<T>::soft_reset_callback)
+            } else {
+                None
+            },
+            get_features: if T::HAS_GET_FEATURES {
+                Some(Adapter::<T>::get_features_callback)
+            } else {
+                None
+            },
+            // ... Other fields now in phy_driver_ops
+
+            // SAFETY: The rest is zeroed out to finalize `struct
phy_driver_ops`,
+            // which expects null function pointers for unused fields
+            ..unsafe {
core::mem::MaybeUninit::<bindings::phy_driver_ops>::zeroed().assume_init()
}
         },
-        get_features: if T::HAS_GET_FEATURES {
-            Some(Adapter::<T>::get_features_callback)
-        } else {
-            None
-        },
     }))
 }

We can send a patch if needed once this series moves out of RFC.

- Trevor

