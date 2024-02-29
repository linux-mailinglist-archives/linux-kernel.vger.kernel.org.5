Return-Path: <linux-kernel+bounces-86039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC3D86BED8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA621F24186
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465B436B16;
	Thu, 29 Feb 2024 02:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzubYY1D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875F236B00;
	Thu, 29 Feb 2024 02:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709172988; cv=none; b=Y5zERrmrroRrqfEsy+e0rhpp+1eZvCJW+ZcwRo42F7yfsKKZapg6xv8/NZo9TtuwjH9UovVWmNktEV5NeLkpZUVC5k/S903wy3SuM9BXlgWe6ZmNF2nP7CZgyN4OuFl4D7BzdruXxp1IA0Wugha6UjE53MRMEN+hfQY9N/gAQcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709172988; c=relaxed/simple;
	bh=YREW50Mm9XizXo3Vg/YslHDwW+mx1PNC7jtuWaFg0Og=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=NEmXu1dQlOD5TQ+otfNa5xHCvHN3bkmI9877gE2MWtfFnnWP0J0nf0c8+ekL0/OOwM+hG8YOFslJqvy5bmTRDorWobEt0WhQUMsZAsUUpJ4kmm8c3RbAko2dNTb6GIC+31jHxfp/FN5bE3AoXypCwgQS41g8+TKKvPBSD4QJzGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzubYY1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B4BC43390;
	Thu, 29 Feb 2024 02:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709172987;
	bh=YREW50Mm9XizXo3Vg/YslHDwW+mx1PNC7jtuWaFg0Og=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=SzubYY1DA+zhhrxp2Mg+Lfzw2OlCQL7NDf0xc1Tem4Nyoahhnnn0Yv5jnWdiQZLgV
	 lryrljDAnssddQ4XoFhjBM0NVLBIHz6ijKMKhHDSEwIphU2sMRUEKuKxqlVwl7SlBs
	 s1N2ySkzySaHatpuow//fODH/lcrgCgvGNOoWsGmZ8aneHzx+EwVlHiNkbdOkLMsuA
	 KnYmfwZj59tx46ceWYi6FRtHzd1oy8J1aalOiut2k7cyOMirHZ/wE28IU5EKxAlFln
	 Nl1TLXlRsuwZd/T49d4UbwOPfLAwaNvZLtxSR5Nm3t3j8QU4lolDuMFX7HCSYpchuu
	 5fjFHxwd7O5cA==
Message-ID: <e4c1e89450aa91ec684a48797bb5d132.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9922942e-ea9e-4cdb-a091-5b8ea0a180d8@salutedevices.com>
References: <20240126201433.1830600-1-jan.dakinevich@salutedevices.com> <c79909e4e55badc8f094d2ff8c4d34ca.sboyd@kernel.org> <9922942e-ea9e-4cdb-a091-5b8ea0a180d8@salutedevices.com>
Subject: Re: [PATCH] clk: allow to skip clk_core_req_round_rate_nolock()
From: Stephen Boyd <sboyd@kernel.org>
Cc: kernel@salutedevices.com
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 28 Feb 2024 18:16:24 -0800
User-Agent: alot/0.10

Quoting Jan Dakinevich (2024-02-23 13:47:35)
>=20
>=20
> On 2/23/24 02:20, Stephen Boyd wrote:
> > Quoting Jan Dakinevich (2024-01-26 12:14:33)
> >> Calling of clk_core_req_round_rate_nolock() can be time-consuming in a
> >> case of deep hierarchy with multiple dividers/parents. But if the clock
> >> already has exactly the same rate as desired, there is no need to
> >> determine how it could be rounded.
> >=20
> > What exactly are you trying to avoid? Is this an optimization or a bug
> > fix? TL;DR: I'm unlikely to apply this patch.
> >=20
>=20
> It is an optimization, not a bug. The problem is that=20
> clk_core_req_round_rate_nolock() is quite expensive, and I faced with=20
> cases, where it takes tens and hundreds milliseconds (depending on SoC).
>=20
> As I see, it is irremovable feature of clk_core_req_round_rate_nolock()=20
> design itself. Lets imagine, we have some clock, and its parent is a=20
> divider. When clk_core_req_round_rate_nolock() is being called the=20
> execution is walked through the following path:
>=20
> clk_core_determine_round_nolock
>   core->ops->determine_rate
>     divider_determine_rate
>      clk_divider_bestdiv
>=20
> Inside clk_divider_bestdiv() for each possible divider=20
> clk_hw_round_rate() is called for parent of the clock, which in turn=20
> calls clk_core_determine_round_nolock().
>=20
> So, each divider and multiplexer in clock path multiplies many times an=20
> amount of iteration required to execute=20
> clk_core_req_round_rate_nolock(). When there are a lot of them the time=20
> consumed by clk_core_req_round_rate_nolock() becomes sufficient.

Do you have a more concrete example? I wonder if perhaps you've split up
the clk hardware into multipliers and dividers, when they really could
all be combined into one clk that does all the math at once without
traversing the tree. But if the problem is really just that the
clk_divider_bestdiv() implementation is slow then that's good to know.

>=20
> > I could see some driver implementing round_rate()/determine_rate() in a
> > way that rounds the rate passed in, so that even if the rate is what the
> > clk is running at _right now_, it still wants to change it to something
> > else, or at least call down into the driver to call the set_rate clk_op.
> > Applying this patch will break that. The contract is that
> > clk_set_rate(rate) =3D=3D clk_set_rate(clk_round_rate(rate)). It doesn't
> > look like anything needs to change.
>=20
> If I am not mistaken, clocks's rate is either equal to its parent rate=20
> or calculated by ->recalc_rate(). I suppose, this callback should return =

> valid rate value that is based on current clock parameters.
>=20
> Now, suppose the clock has rate "rateA" and we called clk_set_rate() to=20
> set "rateA", but clk_core_req_round_rate_nolock() inside clk_set_rate()=20
> rounds it to "rateB". Thus, although the clock is able to run on desired =

> rate (and actually run on it), ->determine_rate() and ->round_rate() are =

> unable to choose clocks's parameters for that value. Is it correct=20
> behavior for clock driver?
>=20

It's not really a question for the clk framework. If the clk driver
wants to round rateA to rateB then it can. It could be that the
recalc_rate() clk_op calculates a slightly different rate than what
round_rate() clk op did, because maybe the driver has frequency tables
and the rate the clk runs at is something like 933333Hz but the driver
just says that's 930000Hz for simplicity. If that happens, recalc_rate()
gives us the "true" rate, while round_rate() gives us the "approximate"
rate. Either way, the set_rate() clk_op knows that 930000Hz means set
some clk rate, even if that doesn't match what recalc_rate() returns
once the rate is changed.

This is very much a real case, because this is essentially how the qcom
clk driver works.

