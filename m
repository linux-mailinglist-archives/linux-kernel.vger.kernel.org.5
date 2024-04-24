Return-Path: <linux-kernel+bounces-156048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013C98AFD31
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B043B289376
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E571FDD;
	Wed, 24 Apr 2024 00:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hqZI5KMz"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB232360;
	Wed, 24 Apr 2024 00:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713917426; cv=none; b=YH0XZ8o1auN3g5Tu16gs/2WNOTHeJQqnm+ptKzaFwhMyubojrPFVcGJxVGsWVfi4NiqtHTd6W2YVrSvh2Rt+LHVn45DPzpq9LvKIk1Ht7Btm7LYlj8rRBfGrRtM7J4eK+bpiQxHenvd5vIp1sI/oNB/6c8CBqOO4Ktdg+sjeEFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713917426; c=relaxed/simple;
	bh=+e77a+C/J0EbHdPMVlryo4fU+rbbPqxpXXwvZkzEPGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivYLN8iotRgYohmDpPk3DrXjWtrfObhTcfnWA2i63wPYo0PRMmgDKvYayLDGYUgWMMkn9w5dX5cKJLNdlEGPYK2KeFvdop4iAh3GFY8fQiLD1sdbha8dFrGHT0qTIT5GDjB3Sg0nGL/iaLDgOS8dDBlU7atv30s/EcRvEQ+dE5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hqZI5KMz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pzRCOhxxTMceX5xt8k8dO7gOOB7+2i2mEsUZDbxon5k=; b=hqZI5KMzeSWaNWG1s3d5GJRN8b
	0hCmkgcv5l8RFOYBlcjS5FFJqrEBroviP6fL+6mzI/WSZ7h1mA1XDd6t78s7a1vgb4WrEKJGt8Eg4
	KAdfQKksxm81djJnu8GndVcHGGyge0o5Ql/VXEXTc9kxVs61WYJD19PIEsiElQOMWFbI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzQDH-00DlMB-SM; Wed, 24 Apr 2024 02:10:15 +0200
Date: Wed, 24 Apr 2024 02:10:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 10/12] net: ethernet: oa_tc6: implement
 mac-phy interrupt
Message-ID: <d6f1a60c-7719-4aff-9b2c-21a4147ad404@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-11-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418125648.372526-11-Parthiban.Veerasooran@microchip.com>

On Thu, Apr 18, 2024 at 06:26:46PM +0530, Parthiban Veerasooran wrote:
> The MAC-PHY interrupt is asserted when the following conditions are met.
> 
> Receive chunks available - This interrupt is asserted when the previous
> data footer had no receive data chunks available and once the receive
> data chunks become available for reading. On reception of the first data
> header this interrupt will be deasserted.
> 
> Transmit chunk credits available - This interrupt is asserted when the
> previous data footer indicated no transmit credits available and once the
> transmit credits become available for transmitting transmit data chunks.
> On reception of the first data header this interrupt will be deasserted.
> 
> Extended status event - This interrupt is asserted when the previous data
> footer indicated no extended status and once the extended event become
> available. In this case the host should read status #0 register to know
> the corresponding error/event. On reception of the first data header this
> interrupt will be deasserted.
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

