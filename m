Return-Path: <linux-kernel+bounces-43105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D3C840B9D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9411F24883
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3467C15696F;
	Mon, 29 Jan 2024 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EK6Yi77V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD6A157E71;
	Mon, 29 Jan 2024 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545914; cv=none; b=Ab9uEqyISsrh1oyxdtqKiQJDWhTwGADNXGzCDV5uYxA/Prl8iLHxmsm5BrV5ItYXQp2Al4JQZjdDoz7c0+RNE2Z9oO8fJMmiNNsqNZMMk+FVmEpxGiLGeBFWyGZ6R5HYbRn1rPD8TYPRQuN4KhCP2vca7ehbLdOjFa5U8nCu4Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545914; c=relaxed/simple;
	bh=JWhkThM5HLpNAscJoDRfAdaXQ5RtNuQoWcA3TFK0gy8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6w0Tq650NgnwFTp+IkZCwvRCBjEOQ3TAReTLdwi9VKfmPJLepACEmvsmgGzGi/R0SRv5aoGkh6Mp03yt9delgCsAhp5uXiZ+DNv6tjGv+aGrgdeTnKd3SCvgZVNPY1POXL1856IxxSZZVCZAP0kwScr3/2s43yVTXrSRMi51nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EK6Yi77V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE89C433F1;
	Mon, 29 Jan 2024 16:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706545913;
	bh=JWhkThM5HLpNAscJoDRfAdaXQ5RtNuQoWcA3TFK0gy8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EK6Yi77V6SDCy01q1J50677XZiXDmd8zaLFHmndYsP5/PBrsI3M9gWrvWS5y8FNmk
	 IrRNXVp+jKfunBpgh2wN02+jW0bfOad7roru5CecBPtDECjXe1o8Gv4hhIyvcQtj+h
	 LrzgmXam9MyTeOIxnBV999XtyNfKIeasNWveJfDpF7wkAmYc4P5e25Xg96yYotZhtB
	 xj3HJDnEUw7cYQPa7zTVDqYMp5A+gUOf1xO3bOtaxfbR+6XDDUP46GhqOAHqBEzj9k
	 vlGBd2wFSAcSSGwKniHtIpQh30x99HRyhGPrc4rGVGa92auklVg2GeVpexU7cpyEqi
	 LRMQTql/I4NWA==
Date: Mon, 29 Jan 2024 08:31:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Daniel Golle
 <daniel@makrotopia.org>, Landen Chao <Landen.Chao@mediatek.com>, DENG
 Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, Andrew
 Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3 6/7] net: dsa: mt7530: do not set
 priv->p5_interface on mt7530_setup_port5()
Message-ID: <20240129083152.34d899cd@kernel.org>
In-Reply-To: <431750cc-fb6b-4f7a-9123-b6986d359742@arinc9.com>
References: <20240122-for-netnext-mt7530-improvements-1-v3-0-042401f2b279@arinc9.com>
	<20240122-for-netnext-mt7530-improvements-1-v3-6-042401f2b279@arinc9.com>
	<20240129125241.gu4srgufad6hpwor@skbuf>
	<431750cc-fb6b-4f7a-9123-b6986d359742@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jan 2024 19:22:28 +0300 Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> > I hope this moves the patch set out of the 'deferred' state.
> >=20
> > ---
> > pw-bot: under-review =20
>=20
> I still see deferred. I guess I'll have to submit this again. :/

Took me an hour to fix the mailbot:
https://github.com/kuba-moo/nipa/commit/6766e97e72ac91ffb42ed2259bc8e2ace44=
6d0ef
email is the most quirky thing ever.

