Return-Path: <linux-kernel+bounces-70119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1E78593A1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 00:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 702C4B213F1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 23:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A1280059;
	Sat, 17 Feb 2024 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CPzKeDAm"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EDB14A86;
	Sat, 17 Feb 2024 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708213734; cv=none; b=uTSNVvhH67K+uli1ofBBtQC3BLBQXFp1Y6C/nXXz3irFXqpU2gs48s2hS3V1ugZ1tlipvFeQ5NnC3X0g9dPtkywsMJisl/lXRD+gAyuLpGhrd8838LPeMZia7NWrlsJFg7kLUFAR7U8sLQPjYpg3r7qivO1ocyHWkBVatB/Fmjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708213734; c=relaxed/simple;
	bh=1g5oK+yNBXpoPw5N07d7muSFkpE6uSYQn/NJNDkMbAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVfeuBnyn9KRrD98uRK9whytyn1oHL99zffE/3LEBnrYFy0Y1/ow71p0SCbpFZ32ANJFBD3YJxC17v6Ma1HK0J+dDCv1cuMOvAo/m06ZHqbw02LtfRBEmKhePPSQ1MEosgnXXZ7wOj1QRrabC7oojC8qQW0A9nsWVj39xY9WpB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CPzKeDAm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FMxvckYePbS1jnoZ5oG6Cm4EypY4Dw/pbZjxC0ZP4yU=; b=CPzKeDAmryQgULRVfeg9ZXkTij
	sV5K4ExtKLQtMWkXBHzzTZujVOaGPUXXKbK1euewjW9lDjsFSr2E4PYT7u1SBA71pkRVI3/BqoQ8P
	Yt5mKJuEZUeqa8K0hBbIQZ8PE6rcAY9Yy7FYlnkXwYiyuiFMNbNKcJjI+wuUfEVpT7gA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rbUPw-0085vH-Pp; Sun, 18 Feb 2024 00:48:24 +0100
Date: Sun, 18 Feb 2024 00:48:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	UNGLinuxDriver@microchip.com, Peter Geis <pgwipeout@gmail.com>,
	Frank <Frank.Sae@motor-comm.com>, Xu Liang <lxu@maxlinear.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Michal Simek <michal.simek@amd.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	Harini Katakam <harini.katakam@amd.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, rust-for-linux@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [net-next RFC PATCH 0/3] net: phy: detach PHY driver OPs from
 phy_driver struct
Message-ID: <a8106d02-e3b0-4f23-8c76-52840493dff2@lunn.ch>
References: <20240217194116.8565-1-ansuelsmth@gmail.com>
 <a804e21d-fe1d-41e8-90fd-64b260c9bcc7@lunn.ch>
 <65d140fb.5d0a0220.81be3.7138@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d140fb.5d0a0220.81be3.7138@mx.google.com>

> Yes, it was done to limit the patch delta, if I had to account for the
> tab for each new section we would be in the order of 2000+ changes I
> think.
> 
> > >  64 files changed, 737 insertions(+), 291 deletions(-)
> > 
> > These statistics are not good. If you had deleted more lines than you
> > added, then maybe it might be an O.K. idea.
> > 
> > Sometimes KISS is best.
> >
> 
> Well IMHO these stats are a bit flawed, the additional code is really
> just extra check if ops is defined and the new .ops variable in each
> phy_driver.
> 
> If you check patch 2 and 3 you can already see some code is removed.

Yes, the problem is, it probably needs another 50 patches to remove
all the duplication. I have to question, is that really going to
happen? Are you going to keep working on this until every driver has
its duplicates removed?

It probably needs some tooling to help. Something which can decode the
object file, and tell you which ops structures are identical. That can
then guide you when editing all the PHY drivers.

     Andrew

