Return-Path: <linux-kernel+bounces-33621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E3A836C63
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A09282182
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F476086F;
	Mon, 22 Jan 2024 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ef6wev5c"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7FE48791
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705938381; cv=none; b=ggRMmSNphlIYt4pAANFqZtgcbEwYTkmrpVblVBpqjzKMs68H82ynT6UWB7UAdo5JajLlgiwPhUp60SU0VEsjx0N6nEiqbMzPVd0/cw8CViUBpFtzVGv8iN90gPW4zLaR4H0RBJy8CY8oT/6PpJr0LEcmCaWcuCIrpFTLb0vRwho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705938381; c=relaxed/simple;
	bh=Q3IypqO28Yb+DzzwNtttB/UgiMayE/ppZJQHO2Ue42Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4bUTPdGN5tvCMYMFx5HXtiIer5AaexQheOcdGX8iwF/gz3R4aFOAU7hYaFy5Ki7Of6fIN8g/VNyStg21lYgPMvChwyPgP3ffSFEDZGyaaBHhqCHoNJKGhhEuuW8PMKmKwLz03QiB4lGFTCg3wAe1zR30rUj3vh+04oNHIJtpyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ef6wev5c; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cce6bb9a74so7393151fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1705938378; x=1706543178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDiX8deGBaeQY+VXPZTuQ9WcGTvy4qXQiQeT5miW9vM=;
        b=ef6wev5cD24ZsEafC+CE9jVPmssf3b9Ylzw9o5PP3yu66YDIIVBP29cUEsr3cdOA2z
         RSOEbncDECOK/kyVkzOOWYCyd3E6ylUx72ROCfLI8NDlUHnDJsLI/WRmN/bglEzfGWtH
         DACMMwzfig7aYcf6L2I8BNoZ8Q8OvrS9gp2vr0HuMxCBRGH+tOng1Nwl7jXYJeYfGhbY
         0GfWlkag7hQgHZ55OFXru/gAWDx+o3B0W7RrEF0VjlozdfXAMk2H/fR+d83HFYGkW2Yd
         oyOGns0yV/WUHll2uAXPktUP/DUYcWbtMXzJdJMMX82Xmf4VzOzOXhEMKlxHDPQwfvwr
         HucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705938378; x=1706543178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDiX8deGBaeQY+VXPZTuQ9WcGTvy4qXQiQeT5miW9vM=;
        b=Es2XMw7beJlLA88X6Fc1OjmxSHq2iJthM3URZ+uyNATE9rBPUJJxwoyMrqH5g5f6+X
         RnP9aJnrs9JwdxxnFI/Wmb4UIk3Xa93mmDzdl/zc57EN4pVqG8yaR2DIfBsVuGh3+J9/
         iUbWvclVbZ0Cmr1dnQ2iwLYRar5wRgqidoL7GaDARJRHfe4odr3wIURTMkMT6YWXLgxS
         /cFrwDLlnzPoETsXFnrBymGZeEc4XV063+dUsQZXGpOjk26ReY4oHpAHVZt93LmzF/YX
         I4zgdNaRJWjm8QOFu+SgEVbVzqOM872J1J3KkCoCnUtAubN74P4E/apXbCfpVNpWt0Ut
         YtRw==
X-Gm-Message-State: AOJu0YwD5DV2EzdCeVMqbZzTXHTsPn5dR7hvGI3h1+ZSN8G/cFWbwpsq
	xdNzuATqgzqLvf+TyTwNf8Hpp/xBxjQGBRltldLRHgQUXa7E40k5BF8eJb9+xpRn5vmCiJj2o9d
	+MRTZJ5n18yXRpgtPX7Qtn1YYzyOGhM9E9rdMxw==
X-Google-Smtp-Source: AGHT+IEkmusRehyV+4kG4FZHYzdhCSAz/ElpZ5e9RTnc5yZ4R3DvkXekQLsBvVN/CUhhjcBnlR7vkc81fjOIcU+Hji0=
X-Received: by 2002:a2e:3212:0:b0:2cd:94f2:673d with SMTP id
 y18-20020a2e3212000000b002cd94f2673dmr4146250ljy.0.1705938377923; Mon, 22 Jan
 2024 07:46:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116193542.711482-1-tmenninger@purestorage.com>
 <04d22048-737a-4281-a43f-b125ebe0c896@lunn.ch> <CAO-L_44YVi0HDk4gC9QijMZrYNGoKtfH7qsXOwtDwM4VrFRDHw@mail.gmail.com>
 <da87ce82-7337-4be4-a2af-bd2136626c56@lunn.ch> <CAO-L_46kqBrDdYP7p3He0cBF1OP7TJKnhYK1NR_gMZf2n_928A@mail.gmail.com>
 <20240122123349.cxx2i2kzrhuqnasp@skbuf> <1aab2398-2fe9-40b6-aa5b-34dde946668a@lunn.ch>
 <20240122151251.sl6fzxmfi2f6tokf@skbuf>
In-Reply-To: <20240122151251.sl6fzxmfi2f6tokf@skbuf>
From: Tim Menninger <tmenninger@purestorage.com>
Date: Mon, 22 Jan 2024 07:46:06 -0800
Message-ID: <CAO-L_45_nZ24pvycdahEy0OP2tZjxCw40_o6HE-_C4jmsX3b8g@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: mv88e6xxx: Make *_c45 callbacks agree with
 phy_*_c45 callbacks
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, f.fainelli@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 7:12=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Mon, Jan 22, 2024 at 03:30:20PM +0100, Andrew Lunn wrote:
> > On Mon, Jan 22, 2024 at 02:33:49PM +0200, Vladimir Oltean wrote:
> > > On Tue, Jan 16, 2024 at 05:51:13PM -0800, Tim Menninger wrote:
> > > > My impression is still that the read_c45 function should agree with=
 the
> > > > phy_read_c45 function, but that isn't a hill I care to die on if yo=
u still
> > > > think otherwise. Thoughts?
> > >
> > > FWIW, Tim's approach is consistent with what drivers/net/mdio/mdio-mu=
x.c does.
> > >
> > >             if (parent_bus->read)
> > >                     cb->mii_bus->read =3D mdio_mux_read;
> > >             if (parent_bus->write)
> > >                     cb->mii_bus->write =3D mdio_mux_write;
> > >             if (parent_bus->read_c45)
> > >                     cb->mii_bus->read_c45 =3D mdio_mux_read_c45;
> > >             if (parent_bus->write_c45)
> > >                     cb->mii_bus->write_c45 =3D mdio_mux_write_c45;
> > >
> > > My only objection to his patch (apart from the commit message which
> > > should indeed be more detailed) is that I would have preferred the sa=
me
> > > "if" syntax rather than the use of a ternary operator with NULL.
> >
> > I agree it could be fixed this way. But what i don't like about the
> > current code is how C22 and C45 do different things with error
> > codes. Since the current code is trying to use an error code, i would
> > prefer to fix that error code handling, rather than swap to a
> > different way to indicate its not supported.
> >
> >         Andrew
>
> You did write in commit da099a7fb13d ("net: phy: Remove probe_capabilitie=
s")
> that the MDIO bus API is now this: "Deciding if to probe of PHYs using
> C45 is now determine by if the bus provides the C45 read method."
>
> Do you not agree that Tim's approach is the more straightforward
> solution overall to skip C45 PHY probing, given this API, both code wise
> and runtime wise? Are there downsides to it?
>
> I have no objection to the C22 vs C45 error code handling inconsistency.
> It can be improved, sure. But it also does not matter here, if we agree
> that this problem can be sorted out in a more straightforward way with
> no negative consequences.
>
> I sort of don't understand the desire to have the smallest patch in
> terms of lines of code, when the end result will end up being suboptimal
> compared to something with just a little more lines (1 vs 4).


Andrew, would you feel differently if I added to the patch the same
logic for C22 ops? Perhaps that symmetry should have existed
in the initial patch, e.g.

    bus->read =3D chip->info->ops->phy_read
        ? mv88e6xxx_mdio_read : NULL;
    bus->write =3D chip->info->ops->phy_write
        ? mv88e6xxx_mdio_write : NULL;
    bus->read_c45 =3D chip->info->ops->phy_read_c45
        ? mv88e6xxx_mdio_read_c45 : NULL;
    bus->write_c45 =3D chip->info->ops->phy_write_c45
        ? mv88e6xxx_mdio_write_c45 : NULL;

Vladimir, as far as style I have no objections moving to straightlined
if's. I most prefer to follow the convention the rest of the code follows
and can change my patch accordingly.

