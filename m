Return-Path: <linux-kernel+bounces-86021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D38B86BEA5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC031C2262C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D26F36AEC;
	Thu, 29 Feb 2024 01:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppqXCoRE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDAE22F13;
	Thu, 29 Feb 2024 01:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171901; cv=none; b=Nzwn9DQccp2zTIfSUGPvlYLa9LhSNdtZPEqzcakfhMXkhW8y/EAtlamB1ZryIiBd3Rhy8b1Pzfxs+FsXr6Y1/yI+hOY/0EnmOkOsGGenRTgxBvheUcMw7fSFrYpR+zpJHsmtbZOveCYnMp/NFpRI0dctnFTuUrvkcVSjn8anSKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171901; c=relaxed/simple;
	bh=J41cmZC7bQsegjax8yQD7VpQyLCqWbWDH7KNEl/+hnA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=fJcPiULOL6XtkqMIZYuliMpJLnoZBM68KYSEmWVt4oanbEx2tHgURsqltv9sw5pIqD3v7kV/0rl0llffcB4O+WL8PtD0v4mypy/GjGdmuFzQx0/aa3SP8VBz6u/mlotndiJu1kr36iNb4LNKisjaL7I3atHSBtGvNaQY1HSAlJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppqXCoRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE00C433F1;
	Thu, 29 Feb 2024 01:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709171900;
	bh=J41cmZC7bQsegjax8yQD7VpQyLCqWbWDH7KNEl/+hnA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ppqXCoRECb8qXQoHJV/NedfjPoAvUrCzaLZWrdv36y63x9YACBjE83Eip0svG9PBf
	 lngFZh81/sv5eDP0xqh+DP9e55gJN9nUSINtJ7SDCGddGHywnAG9VF9O9sfnwpDvc2
	 0DApIgUKBUF6iPHDCAtlJ1DK0gKip1voMF7pZ86nP9sOb7kjkWPfHqhxj77yh/sBOa
	 2q3EsdbMQVAEfZwDuQMVAuuZpDuJzOJC7kxaTC+BIP9+j/2B1z4PTHwh0CN0xmeuIJ
	 TCfGVBP7w7kadNgohRjctolPlhaclQhNnuqOvYyBZN1Hfa5EWDb+GWJwCmuxqzHi7B
	 1OW1E2HfMn97A==
Message-ID: <0db752d31016823ccd3799925255a74a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240224-mux-v1-1-608cc704ef43@outlook.com>
References: <20240224-mux-v1-1-608cc704ef43@outlook.com>
Subject: Re: [PATCH RESEND] clk: set initial best mux parent to current parent when determining rate
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>, forbidden405@outlook.com
Date: Wed, 28 Feb 2024 17:58:18 -0800
User-Agent: alot/0.10

Quoting Yang Xiwen via B4 Relay (2024-02-23 09:18:52)
> From: Yang Xiwen <forbidden405@outlook.com>
>=20
> Originally, the initial clock rate is hardcoded to 0, this can lead to
> some problem when setting a very small rate with CLK_MUX_ROUND_NEAREST.

Did you mean CLK_MUX_ROUND_CLOSEST?

>=20
> For example, if the lowest possible rate privided by the mux is 1000Hz,

s/privided/provided/

> setting a rate below 500Hz will fail, because no clock can provide a
> better rate than the non-existant 0. But it should succeed with 1000Hz
> being set.
>=20
> Setting the initial best parent to current parent could solve this bug
> very well.
>=20
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
> This is actually a v2 of [1], but seems too simple to have a unittest.
> It's tested in a mmc host driver.

It's not too simple for a unittest.

>=20
> [1]: https://lore.kernel.org/linux-clk/20230421-clk-v3-1-9ff79e7e7fed@out=
look.com/

In that thread I asked you to please Cc Maxime. Please do that.

> ---
>  drivers/clk/clk.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 2253c154a824..d98cebd7ff03 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -649,6 +649,10 @@ int clk_mux_determine_rate_flags(struct clk_hw *hw,
> =20
>         /* find the parent that can provide the fastest rate <=3D rate */
>         num_parents =3D core->num_parents;
> +       if (core->parent) {
> +               best_parent =3D core->parent;
> +               best =3D clk_core_get_rate_nolock(best_parent);
> +       }

Is the problem that we're not using abs_diff()?

----8<----
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index a3bc7fb90d0f..91023345595f 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -542,7 +542,7 @@ static bool mux_is_better_rate(unsigned long rate, unsi=
gned long now,
 			   unsigned long best, unsigned long flags)
 {
 	if (flags & CLK_MUX_ROUND_CLOSEST)
-		return abs(now - rate) < abs(best - rate);
+		return abs_diff(now, rate) < abs_diff(best, rate);
=20
 	return now <=3D rate && now > best;
 }

