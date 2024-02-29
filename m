Return-Path: <linux-kernel+bounces-86045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF33A86BEE7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6355BB23131
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75F636B17;
	Thu, 29 Feb 2024 02:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwOLrFOm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D9536AFF;
	Thu, 29 Feb 2024 02:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709173521; cv=none; b=mzkXXhJgMhfoo6Vg4vKawJB5XrpdS5XHBdasKI8sMAkMTf6PDtGJGzkNMNQ6D++xXkYlYFgweZeaO2wZQpyG2WVasZwF5Bj2C/E9Rrq7n9FJxb9WtzWhpiJF+8ZcO6DTCl6+I96ameAWJKX+pNTzhujR4mxFnXhmNrHWAvGxTBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709173521; c=relaxed/simple;
	bh=UUh7OtZMUzTLBTUCodbE+kumzzkS37Zl5mKx4qDLAik=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Bs1247f/ePCwqlpMHftuwimZCbwkX9iHPsYNzGfq2GeWe+y7NrJGIfS+ySAZtBGKKSFxhwiX/TVdmzb+1wKjGaF9UKMREFfVUf/57pgAGYXSuVRhuVEexPH2hIMx95KRI7jk3+hSg1LP/Wh6o/yVW5vcMHvClzfUPJoERQtnX/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwOLrFOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF04C433C7;
	Thu, 29 Feb 2024 02:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709173520;
	bh=UUh7OtZMUzTLBTUCodbE+kumzzkS37Zl5mKx4qDLAik=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=gwOLrFOm75NZsUJPAZOW4Y/OTPCsRdCOcUqoJvcLHHAR189Rq3h2ihzQL2dRGVojH
	 nhygq+kJdcz5fxW0j4Z5X4w/xLm/enn4KbROVyW/4LMBPYjsDToZgFLHw+fy4t9bE3
	 2f6zKTguhxYv65wOjLNTwTeyR94SRcT2n00B9CA/S4yLDoWCHuADMM6MTPH6WDClg4
	 CxLKRReGTKaxNGPzlm+15aP7F+16MLYjbXFp3VAafuOQSDkU1yk8geSTJtcAjnmmfO
	 hwFBbh4xQlvKjTtJEgk8C2+J/ZrahkOeq7sOxs/K6C522VDFyusk2CtJryL0O9exvu
	 7dmH83qnZWD1A==
Message-ID: <f8bcec654f618f8639a882bf70273618.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <SEZPR06MB69597E78EA08D5BDF66DBEBC965F2@SEZPR06MB6959.apcprd06.prod.outlook.com>
References: <20240224-mux-v1-1-608cc704ef43@outlook.com> <0db752d31016823ccd3799925255a74a.sboyd@kernel.org> <SEZPR06MB69597E78EA08D5BDF66DBEBC965F2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Subject: Re: [PATCH RESEND] clk: set initial best mux parent to current parent when determining rate
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Yang Xiwen <forbidden405@outlook.com>, Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Wed, 28 Feb 2024 18:25:18 -0800
User-Agent: alot/0.10

Quoting Yang Xiwen (2024-02-28 18:13:04)
> On 2/29/2024 9:58 AM, Stephen Boyd wrote:
> > Quoting Yang Xiwen via B4 Relay (2024-02-23 09:18:52)
> >> From: Yang Xiwen <forbidden405@outlook.com>
> >>
> >> Originally, the initial clock rate is hardcoded to 0, this can lead to
> >> some problem when setting a very small rate with CLK_MUX_ROUND_NEAREST.
> >=20
> > Did you mean CLK_MUX_ROUND_CLOSEST?
>=20
> You are right :).
>=20
> >=20
> >>
> >> For example, if the lowest possible rate privided by the mux is 1000Hz,
> >=20
> > s/privided/provided/
> >=20
> >> setting a rate below 500Hz will fail, because no clock can provide a
> >> better rate than the non-existant 0. But it should succeed with 1000Hz
> >> being set.
> >>
> >> Setting the initial best parent to current parent could solve this bug
> >> very well.
> >>
> >> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> >> ---
> >> This is actually a v2 of [1], but seems too simple to have a unittest.
> >> It's tested in a mmc host driver.
> >=20
> > It's not too simple for a unittest.
> >=20
> >>
> >> [1]: https://lore.kernel.org/linux-clk/20230421-clk-v3-1-9ff79e7e7fed@=
outlook.com/
> >=20
> > In that thread I asked you to please Cc Maxime. Please do that.
> >=20
> >> ---
> >>  drivers/clk/clk.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> >> index 2253c154a824..d98cebd7ff03 100644
> >> --- a/drivers/clk/clk.c
> >> +++ b/drivers/clk/clk.c
> >> @@ -649,6 +649,10 @@ int clk_mux_determine_rate_flags(struct clk_hw *h=
w,
> >> =20
> >>         /* find the parent that can provide the fastest rate <=3D rate=
 */
> >>         num_parents =3D core->num_parents;
> >> +       if (core->parent) {
> >> +               best_parent =3D core->parent;
> >> +               best =3D clk_core_get_rate_nolock(best_parent);
> >> +       }
> >=20
> > Is the problem that we're not using abs_diff()?
>=20
>=20
> No, i think. It has nothing to do with the code here. It's because of
> the initial best_parent/best_parent_rate.

Alright.

>=20
> >=20
> > ----8<----
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index a3bc7fb90d0f..91023345595f 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -542,7 +542,7 @@ static bool mux_is_better_rate(unsigned long rate, =
unsigned long now,
> >                          unsigned long best, unsigned long flags)
> >  {
> >       if (flags & CLK_MUX_ROUND_CLOSEST)
> > -             return abs(now - rate) < abs(best - rate);
> > +             return abs_diff(now, rate) < abs_diff(best, rate);
>=20
> Without this patch, the initial `best` rate would be always 0. This is
> wrong for most cases, 0Hz might (usually) be unavailable. We should use
> a valid rate(i.e. current rate) initially.

Ok. But you set best to the parent rate. So why not use 'core->rate'
directly as 'best'?

