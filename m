Return-Path: <linux-kernel+bounces-70106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9460859324
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 23:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4868A1F21CD5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDCA8004F;
	Sat, 17 Feb 2024 22:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IGuZAJv4"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18AE7E579;
	Sat, 17 Feb 2024 22:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708208530; cv=none; b=EkXle9+ZUY/sbFw1DzSQugopmY5a6urkKKMpFvrrv2AuJVrtuMDHROGkwTme78lVWgJd1UqsZZKQCQEJvGVLeuWphD22PSaso+q58Q4/Ica4NXfUxzjcIbIvAAuFF3zChpfM7AWRZRXBDImfCi2BAxX0zlqiqZ8eaY0hJpKwbWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708208530; c=relaxed/simple;
	bh=50i9ll5m3n7Dob7+vPwV679xDA+8IF0BSI+30JunILA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmxFNNcwiyPK3ljHdglv9PlrUlH2Qt1p7kjF45iyEInAglSqExp2uHcn1gEIXkp+hMHMEeUzVZZHPflCi6wzUs0HuE+UJimzTGtgOa8o+ELuSUD76LjX1UPPvASfyXziOIX4f33imJUPSwI67buYo6v9Jpqzn1aqcoq4Mr7zIOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IGuZAJv4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=d/y5qpq3uF2po3jkaK8CtNhWm1biK0mglGlG7nCOk+Q=; b=IGuZAJv46IilCO1EOeTEdr/OKc
	Ekt8q/pK20nszsr5XQFOS0VjbUq9e84AIARYog7v8zSxVav9pnVXl/Qsc1FGCRLAka6kjqQx1zysx
	oN5p07q8ZALxEMPQ0kZHo4sazDApO7BcIzOcHiw/nJ7IQVZqcErgi7xkp7DsrgSE7eR0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rbT44-0085gT-3i; Sat, 17 Feb 2024 23:21:44 +0100
Date: Sat, 17 Feb 2024 23:21:44 +0100
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
Message-ID: <a804e21d-fe1d-41e8-90fd-64b260c9bcc7@lunn.ch>
References: <20240217194116.8565-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217194116.8565-1-ansuelsmth@gmail.com>

On Sat, Feb 17, 2024 at 08:41:11PM +0100, Christian Marangi wrote:
> Posting as RFC due to the massive change to a fundamental struct.
> 
> While adding some PHY ID for Aquantia, I notice that there is a
> big problem with duplicating OPs with each PHY.
> 
> The original idea to prevent this was to use mask on the PHY ID
> and identify PHY Family. Problem is that OEM started to use all
> kind of PHY ID and this is not doable, hence for PHY that have
> the same OPs, we have to duplicate all of them.
> 
> This is present in Aquantia PHY, but is much more present in
> other PHY, especially in the BCM7XXX where they use a big macro
> for common PHYs.
> 
> To reduce patch delta, I added the additional variable without
> adding tabs as this would have resulted in a massive patch.
> Also to have patch bisectable, this change has to be in one go
> hence I had to use this trick to reduce patch delta.

To me, this makes the code look ugly. I also expect many text editors
which understand indentation will be unhappy, saying the indentation is
wrong.

>  64 files changed, 737 insertions(+), 291 deletions(-)

These statistics are not good. If you had deleted more lines than you
added, then maybe it might be an O.K. idea.

Sometimes KISS is best.

	Andrew

