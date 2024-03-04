Return-Path: <linux-kernel+bounces-90596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D99358701ED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 160871C22523
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23653D3BE;
	Mon,  4 Mar 2024 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6udMehQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F2D17C62
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 13:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557326; cv=none; b=Bj1hL5Kynwnv2M7IaSGe2KEk+H1enEFiVLhp2mFvQ2f/GiEsxQr47ub83DZ+3kk7bpnzswFIPXxbncUcUJRffWuQgmRlNnkTDPQ+PorUCNyyvuVumUIhFGupnOdF4FfFtT+/A+chhGeRqiV1liEOXI5v/8Szew1KDUB/TDtgv8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557326; c=relaxed/simple;
	bh=OIq1GSC2Asx+nhf1HO80avSwemP0Jz8lS4ttehqA8ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h22A7lx6mwRHskO3pVKlMXxKegUI6vHyl+8dHqAPfWJmxZM8NCmiYZ7yqoIVCWj1tqUWMJCCNjkrSEdZxuEaFwtSVVvAnKIgojNgSyW9su0VtIwlbPkKNHytrSa1oZbA2D6TsWraaeBvxer9DVMN183Ly5IsQAf4Z+vZs806o74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6udMehQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA9AC433C7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 13:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709557325;
	bh=OIq1GSC2Asx+nhf1HO80avSwemP0Jz8lS4ttehqA8ZU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R6udMehQjtGtAmCDZAgC2ey6ZZa2Fpc/S37zT4e/Fz4fKNGZkVChcMbHvkTFveoGM
	 NnPBVlNnGBeQNSFy/lSpBEtrZ1wT2/JFHMTL7pG/OBXGT6HX1wUTkbDocayN8MKH/5
	 QSUh376bb+5TpGQ05AWlTqXDFLDHDmR30hdlwZXjM6cjhY0Obo0hpyguC/9qY1MYgG
	 ztT/7WDnMYHXxiNtmcrJrSmlc5ikKtJJOtzcwr1miWI40llHyeAPJAr/OFb9mQEZqn
	 UwNWjmVveUB5B0wwZzXTEh93FepK8Z9PPNnwC4aJ9TmMTn6VLaKqT0tEHPEXq+mRCL
	 vAn7tpvgG0giw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d27fef509eso61261751fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 05:02:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXmOGHng20ohAcEbwtqwXh8sPQIBhwxc2Nlw13SwxzwxY1jWZY7Q7xiQd1XhbeghEwFcTKkevuWS7FXA8ASTddd5jTq2Yn0ZRJJzNy+
X-Gm-Message-State: AOJu0YzUaaA39lJeaJhp44EmF9AQ8nSQlK1hhnC4/YaDT8OLslMf0R7Q
	Z2KjBPRVxydqPtBt+ZokpCiUuAv7TjP6ejEWFYOBH769xbi6zJP7/h5UGp9I8pOt/e1d8wXX/DR
	E1x2e2mtG+r6o9+Di8eYoxcw5TB0=
X-Google-Smtp-Source: AGHT+IG/OA7ZMcjudPV6N8aicvGiKXhcJmEswxwxeWIXUritE6emx8GV5K/5qAJZF0zwdxS1l9ICWj5NavvClL6iM/Q=
X-Received: by 2002:a2e:240c:0:b0:2d2:d9b2:b310 with SMTP id
 k12-20020a2e240c000000b002d2d9b2b310mr5659217ljk.47.1709557323922; Mon, 04
 Mar 2024 05:02:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvG9KE15PGNoLu+SBVyShe+u5HBLQ81+kK9Zop6u=ywmw@mail.gmail.com>
 <338c89bb-a70b-4f35-b71b-f974e90e3383@app.fastmail.com> <20240304112441.707ded23@donnerap.manchester.arm.com>
 <1baf9a7f-b0e4-45d8-ac57-0727a213d82d@app.fastmail.com> <20240304114546.4e8e1e32@donnerap.manchester.arm.com>
 <badf279a-f1fa-4938-a5d2-492b89d7c27c@app.fastmail.com>
In-Reply-To: <badf279a-f1fa-4938-a5d2-492b89d7c27c@app.fastmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 4 Mar 2024 14:01:52 +0100
X-Gmail-Original-Message-ID: <CAMj1kXENYqUx=esK9b_pGd4wpwE43fNaGRCUhJLK_4MQzrAQeg@mail.gmail.com>
Message-ID: <CAMj1kXENYqUx=esK9b_pGd4wpwE43fNaGRCUhJLK_4MQzrAQeg@mail.gmail.com>
Subject: Re: arm: ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko]
 undefined!
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andre Przywara <andre.przywara@arm.com>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-sunxi@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, lkft-triage@lists.linaro.org, 
	Maxime Ripard <mripard@kernel.org>, Dave Airlie <airlied@redhat.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 13:35, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Mar 4, 2024, at 12:45, Andre Przywara wrote:
> > On Mon, 04 Mar 2024 12:26:46 +0100
> > "Arnd Bergmann" <arnd@arndb.de> wrote:
> >
> >> On Mon, Mar 4, 2024, at 12:24, Andre Przywara wrote:
> >> > On Mon, 04 Mar 2024 12:11:36 +0100 "Arnd Bergmann" <arnd@arndb.de> wrote:
> >> >>
> >> >> This used to be a 32-bit division. If the rate is never more than
> >> >> 4.2GHz, clock could be turned back into 'unsigned long' to avoid
> >> >> the expensive div_u64().
> >> >
> >> > Wouldn't "div_u64(clock, 200)" solve this problem?
> >>
> >> Yes, that's why I mentioned it as the worse of the two obvious
> >> solutions. ;-)
> >
> > Argh, should have cleaned my glasses first ;-)
> >
> > I guess I was put somehow put off by the word "expensive". While it's
> > admittedly not trivial, I wonder if we care about the (hidden) complexity
> > of that function? I mean it's neither core code nor something called
> > frequently?
>
> It's not critical if this is called infrequently, and as Maxime
> just replied, the 64-bit division is in fact required here.
> Since we are dividing by a constant value (200), there is a good
> chance that this will be get turned into fairly efficient
> multiply/shift code.
>

Clang does not implement that optimization for 64-bit division. That
is how we ended up with this error in the first place.

Perhaps it is worthwhile to make div_u64() check its divisor, e.g.,

--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -127,6 +127,9 @@
 static inline u64 div_u64(u64 dividend, u32 divisor)
 {
        u32 remainder;
+
+       if (IS_ENABLED(CONFIG_CC_IS_GCC) && __builtin_constant_p(divisor))
+               return dividend / divisor;
        return div_u64_rem(dividend, divisor, &remainder);
 }
 #endif

