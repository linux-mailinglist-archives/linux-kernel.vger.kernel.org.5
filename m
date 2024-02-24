Return-Path: <linux-kernel+bounces-79804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E7D8626FF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E4BDB215A9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4266F4C618;
	Sat, 24 Feb 2024 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oa4CL+23"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823B4EDE;
	Sat, 24 Feb 2024 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708802750; cv=none; b=Y6gIsC2k1mbkwsLYydQGq8ZRfkLEoMo2FiHtDOk4icx8eRSJHpY6gS0THdDKia7JxAsjj5j+vAlsS2ZYvlgKxtlQskkDGxlrkYtdBaVc7U5Kf1m2/UWh1VFli1KXvLF9EDy6uF4eMY2n4bYKYMpWjdKVQDpsiPE3xTbw1bzHJos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708802750; c=relaxed/simple;
	bh=/VIjT2iavaAdUja5QLc5Xf6ymkBMCy+/xJXiyGfwSlk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4dU/hpDiXdJRQNN7lYWyLmjVhVdCwNhliYVt1ewClZgBB30tTo1WWJzwlMVUtAMP8poHHy00yiy6TzaEtrj1u5V3GQC2jwmQ6sS/+bJsfCikbahgjUIqySvqWY+sgjRyzfXwcZsavCiUEKzmXEsnBLRhM5w+1rqhkXCL9KvoGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oa4CL+23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8756C433F1;
	Sat, 24 Feb 2024 19:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708802750;
	bh=/VIjT2iavaAdUja5QLc5Xf6ymkBMCy+/xJXiyGfwSlk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Oa4CL+23TdJX/2YlespJJTd3Aqmz4AFZZAMGkxXRSRs48CgJ62B5spjqfIGqrM4r4
	 TqDjn/8+dLOCKd85hfNy6aSN812QylVsTMosNOnP1p9ZqdH8bJ+qwpk8B3MaA6QpKx
	 9QImKMewbf3o9TRn7vBhgRubanM6neNH8gnbJPzBPAFzh3CjJ4dMzQFZpQjHDRX4LM
	 2Imi7A/khEa0Fo7IAWMjB96mpyb6EoRNdivT3cjhrhD8cJGqCVPPVqbQEoEb4Ge0gG
	 4sMdYJpS70Gm4UMHcAtKbOmTk2RKdnG1P7yXrNIIgWTnvNScL1B0GA+WqhdHntWfeI
	 dvMHeH63XCCvw==
Date: Sat, 24 Feb 2024 19:25:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Quentin Schulz <foss+kernel@0leil.net>, Lars-Peter Clausen
 <lars@metafoo.de>, Heiko Stuebner <heiko@sntech.de>, AngeloGioacchino Del
 Regno <angelogioacchino.delregno@collabora.com>, Shreeya Patel
 <shreeya.patel@collabora.com>, Simon Xue <xxm@rock-chips.com>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH 0/3] iio: adc: rockchip_saradc: fix bitmasking and
 remove custom logic for getting reset
Message-ID: <20240224192535.237933de@jic23-huawei>
In-Reply-To: <CAHp75VfmsDeTP97srRJU09gA988xw68+ZHsXvXT3W_wv1HEauA@mail.gmail.com>
References: <20240223-saradcv2-chan-mask-v1-0-84b06a0f623a@theobroma-systems.com>
	<CAHp75VfmsDeTP97srRJU09gA988xw68+ZHsXvXT3W_wv1HEauA@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Feb 2024 15:01:30 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Feb 23, 2024 at 2:46=E2=80=AFPM Quentin Schulz <foss+kernel@0leil=
net> wrote:
> >
> > The mask for the channel selection is incorrect as it's specified to be
> > 16b wide by is actually only 4.
> >
> > Also, the 16 lower bits in the SARADC_CONV_CON register are write
> > protected. Whatever their value is can only be written to the hardware
> > block if their associated bit in the higher 16 bits is set. Considering
> > that the channel bitmask is 4b wide but that we can write e.g. 0 in
> > there, we shouldn't use the value shifted by 16 as a mask but rather the
> > bitmask for that value shifted by 16. This is currently NOT an issue
> > because the only SoC with SARADCv2 IP is the RK3588 which has a reset
> > defined in the SoC DTSI. When that is the case, the reset is asserted
> > before every channel conversion is started. This means the registers are
> > reset so effectively, we do not need to write zeros so the wrong mask
> > still works because where we should be writing zeroes, there are already
> > zeroes. However, let's fix this in case there comes a day there's an SoC
> > which doesn't require to reset the controller before every channel
> > conversion is started.
> >
> > Lastly, let's use the appropriate function from the reset subsystem
> > for getting an optional exclusive reset instead of rolling out our own
> > logic.
> >
> > Those three patches should not be changing any behavior. =20
>=20
> Nice series, I have the comments in patch 3, but no need to resend
> until Jonathan asks for. He might address that whilst applying.
>=20
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>=20

I've take the series through the togreg branch as we are so near the
merge windows.  Note (despite Linus not liking it :)) I use links
in my git tags so anyone really searching for Quentin can find
the discussion.

I'm usually a bit lazy on cleaning out what I would consider unnecessary
CC tags but given Andy comment on these I've dropped the extra
one.

Patches 1 and 2 marked for stable.

Jonathan

