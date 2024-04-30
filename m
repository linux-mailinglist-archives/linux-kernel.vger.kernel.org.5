Return-Path: <linux-kernel+bounces-163994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C1C8B76ED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B82701C21D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489E117278D;
	Tue, 30 Apr 2024 13:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hNdLY11M"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAB5171E4F;
	Tue, 30 Apr 2024 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483325; cv=none; b=L6vA0SAPB6zTgImiTkkVbkWv7kpSm0d6tTg5wMg9udr/Fg4kFdNrorVP8h+npxjydbwwaaBdUhNnl5JGgUVuY1nwkjeiONAc8HnnNaRzEmQ8Pkb57mYU7Q+8DCv+xFJKXznyDFRScZY7b/MKEsMF9R0/qHTkS9Ujwu5AfKy7sfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483325; c=relaxed/simple;
	bh=645CpjS+rCjcVeG1uX0G0Qqrq6Dq/rXy/+NHAKfbJ1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYmtxjWSMcMpDF5ZZK8dOD264GfAq3yyYgSiUR/7Hlxlor8JNDz3hg1rmSsl5poL6wF8xQNP0cMM4mvVMjx3FkFuAS4V4yNulXx6153PIQ6HUMt4+98q1MJAn/XswXiVCp2Nzgp4wK5FhhE3CDrQsyQL28baf3xEhclfDG/QPuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hNdLY11M; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TwVm5+lnEYg5CEZ7tfzTszScGuXmoWaijPkjxaNJWew=; b=hNdLY11MBVwiLcsj/KLRRRmmP/
	+UY3ZGxIEL2VvFBxE/WLExR1zJyiE6LBbzELdBA+fc3Uwl75f4ReqFshL4Nn3ECoBUEYCT3QXFn75
	e4dRXSSCQt4hJtfgwWr2fwAkSx8FAErl5RBYCgAxH2oThySmZ6C0A36rYLwesuviP2mY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1nQM-00EL6Y-Kn; Tue, 30 Apr 2024 15:21:34 +0200
Date: Tue, 30 Apr 2024 15:21:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Felix Fietkau <nbd@nbd.name>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Landen Chao <Landen.Chao@mediatek.com>, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: dsa: mt7530: fix impossible MDIO address and
 issue warning
Message-ID: <ab0875ad-b8a8-4055-93f7-7f9f51910098@lunn.ch>
References: <e615351aefba25e990215845e4812e6cb8153b28.1714433716.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e615351aefba25e990215845e4812e6cb8153b28.1714433716.git.daniel@makrotopia.org>

On Tue, Apr 30, 2024 at 12:45:46AM +0100, Daniel Golle wrote:
> The MDIO address of the MT7530 and MT7531 switch ICs can be configured
> using bootstrap pins. However, there are only 4 possible options for the
> switch itself: 7, 15, 23 and 31 (ie. only 3 and 4 can be configured, bit
> 0~2 are always 111). Practically all boards known as of today use the
> default setting which is to have the switch respond to address 31, while
> the built-in switch PHYs respond to address 0~4 in this case.
> 
> However, even in MediaTek's SDK the address of the switch is wrongly
> stated in the device trees as 0 (while in reality it is 31), so warn the
> user about such broken device tree and make a good guess what was
> actually intended.
> 
> This is imporant to not break compatibility with older Device Trees as
> with commit 868ff5f4944a ("net: dsa: mt7530-mdio: read PHY address of
> switch from device tree") the address in device tree will be taken into
> account. Doing so instead of assuming the switch is always at
> address 31 which was previously hard-coded will obviously break things
> for many existing downstream device trees as they contain the wrong
> address (0) which previously didn't matter.
> 
> Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/dsa/mt7530-mdio.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
> index fa3ee85a99c1..119630fd9060 100644
> --- a/drivers/net/dsa/mt7530-mdio.c
> +++ b/drivers/net/dsa/mt7530-mdio.c
> @@ -193,6 +193,19 @@ mt7530_probe(struct mdio_device *mdiodev)
>  			return PTR_ERR(priv->io_pwr);
>  	}
>  
> +	/* Only MDIO bus address 7, 15, 23 and 31 are valid options */
> +	if (~(priv->mdiodev->addr & 0x7) & 0x7) {
> +		/* If the address in DT must be wrong, make a good guess about
> +		 * the most likely intention, and issue a warning.
> +		 */
> +		int correct_addr = ((((priv->mdiodev->addr - 7) & ~0x7) % 0x20) + 7) & 0x1f;
> +
> +		dev_warn(&mdiodev->dev,
> +			 "impossible switch MDIO address in device tree: %d, assuming %d\n",
> +			 priv->mdiodev->addr, correct_addr);

You could include FW_WARN in this, to indicate this is a firmware
issue. It is not used too much with DT, since it was originally
intended for ACPI issues, but a few ARM systems use it with DT.

	 Andrew

