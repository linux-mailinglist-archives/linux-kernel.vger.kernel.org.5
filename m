Return-Path: <linux-kernel+bounces-20623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E45082828A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB6C1C23A0F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD6B2575B;
	Tue,  9 Jan 2024 08:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzqdRTPr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7607225D3;
	Tue,  9 Jan 2024 08:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF6EC433F1;
	Tue,  9 Jan 2024 08:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704790562;
	bh=/G+p7T+qYU5A8uYcxrK/0d1avKq1e5cx5+294Ob001c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VzqdRTPr5JzZE23mwwncslyDbDJ0TU4l1rudWzUvbsQl9ND/G9LREX9PhBKZ7GK/1
	 mK1RL0nSkh5UF0lEFhzupoIBAvPPGq5VbL+fYTsWPZYtMKxE5YTGuLpD5CjFBGMXyG
	 CYk2yQXCkkBBJ2X2iiJQHFxppQiCYH6k2OHKaQRY6IPxkm4OnSBBWawO9az5jdPCnw
	 9r4vdS53MCJHin90pYzfJBbgoZjxByjWuMIHvECzBGgJt85q4YieHvWbXWK8GvLVaB
	 74ULsYnNjeZFVTvPlSlJJw5vwDKRF29yfV7teLF9BV5Ny1eMnCBMovLqYL2Pa7QRQc
	 sX2cWxF8t/6Sw==
Date: Tue, 9 Jan 2024 08:55:57 +0000
From: Lee Jones <lee@kernel.org>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Andre Przywara <andre.przywara@arm.com>, fuyao <fuyao1697@cyg.com>,
	Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
	maijianzhang <maijianzhang@allwinnertech.com>
Subject: Re: [PATCH RESEND] iio: adc: sun4i-gpadc-iio: adaptation interrupt
 number
Message-ID: <20240109085557.GG7948@google.com>
References: <YxmR5SPPY18O7LaG@google.com>
 <20231220115412.65bbc8c7@donnerap.manchester.arm.com>
 <20231221152553.GM10102@google.com>
 <4953611.0VBMTVartN@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4953611.0VBMTVartN@jernej-laptop>

On Fri, 22 Dec 2023, Jernej Škrabec wrote:

> Dne četrtek, 21. december 2023 ob 16:25:53 CET je Lee Jones napisal(a):
> > On Wed, 20 Dec 2023, Andre Przywara wrote:
> > 
> > > On Wed, 20 Dec 2023 15:23:17 +0800
> > > fuyao <fuyao1697@cyg.com> wrote:
> > > 
> > > Hi,
> > > 
> > > > __platform_get_irq_byname determinies whether the interrupt
> > > > number is 0 and returns EINVAL.
> > > 
> > > can you please say what this fixes, exactly? Is something not working at
> > > the moment? Can you please provide parts of the error message?
> > > 
> > > And maybe expand the explanation a bit more? For instance mention that the
> > > identifiers are used as IRQ resource numbers, where 0 is treated specially.
> > > 
> > > Cheers,
> > > Andre
> > > 
> > > > 
> > > > Signed-off-by: fuyao <fuyao1697@cyg.com>
> > 
> > You have to use your full real name as well.
> 
> Isn't that enough after
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4563201f33a022fc0353033d9dfeb1606a88330 ?

I believe that change in stance is to be more accepting of people who
are universally known by their pseudonyms, like Tixy, Wookey or Piglet,
to name a few that I'm aware of.  If fuyao is universally known by that
name then sure, it's enough.  It just doesn't look very name-like in its
current guise, due to the shortness and lack of capitalisation.  It
looks to me more like a username, which is not as generally acceptable
AFAIA.

-- 
Lee Jones [李琼斯]

