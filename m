Return-Path: <linux-kernel+bounces-158766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20D08B24A2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E512C1C21F84
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9F014AD35;
	Thu, 25 Apr 2024 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qcMS9Dci"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD61C14B07A;
	Thu, 25 Apr 2024 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057507; cv=none; b=V60H/8cvK8EC3Q9lu5I2GDxGCOdd5iYzeSBJkVTwewKGWCN/O1THfkA0pxsJMhOeZS3dIHQroFAD9aFazum/+epvsAJa2R75PCFmAgPDpfu6RZExRPEv5nIaRy9Ww1QNBhVcVvBQqzCVw2u/FS6pnVibGkOhb9PlJnLYDPQydsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057507; c=relaxed/simple;
	bh=Ad9CMeQCfwBbypuBlH9YPi1w4Sfr5suUraBUndAtP30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozEnvcJLH0+f7WzjN1zFOnMUcH8kUPGPSVcZ/XfuUKUxt30kSzb4/bHfQNZfr70/MhXagJU9Kn1mMw8pHloqgSIDBmSm9PTkk/+6fNBp192xc8M+wDtvFJoQcjLBEoaFuZ+byKL1KrkFK7WNoF1DHo0m0vFFmgfbwnkx169Bmpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qcMS9Dci; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ce5t81AR4LLzMmw7ptIOBPkiZfOh30AXyQ1jcb4c9X0=; b=qcMS9Dciv3ySUmIgtvGkMaGAdY
	h7bYPEdhfM3QW5df/VVQPAEl41AXD8vzCGBPPRhH6Aa1Ji5E+Jy9MNL+4skbUXRJp63qWDiQyFhGe
	hNIQJYIy2Upvh0Rg+NaG60GKh1dt/clUxZo5JrH40RWLH5fqXVkTWabwgrnQTX7COgaM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s00eY-00DzlT-0q; Thu, 25 Apr 2024 17:04:50 +0200
Date: Thu, 25 Apr 2024 17:04:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH 1/3] net: phy: mediatek: Re-organize MediaTek ethernet
 phy drivers
Message-ID: <8d9ef4a5-9bf5-4f59-89d0-86722f90e8eb@lunn.ch>
References: <20240425023325.15586-1-SkyLake.Huang@mediatek.com>
 <20240425023325.15586-2-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425023325.15586-2-SkyLake.Huang@mediatek.com>

On Thu, Apr 25, 2024 at 10:33:23AM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> Re-organize MediaTek ethernet phy driver files and get ready to integrate
> some common functions and add new 2.5G phy driver.
> mtk-ge.c: MT7530 Gphy on MT7621 & MT7531 Gphy
> mtk-ge-soc.c: Built-in Gphy on MT7981 & Built-in switch Gphy on MT7988
> mtk-2p5ge.c: Planned for built-in 2.5G phy on MT7988
> 
> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

