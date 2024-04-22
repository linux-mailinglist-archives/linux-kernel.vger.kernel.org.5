Return-Path: <linux-kernel+bounces-153981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05978AD5A2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57FE7280CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DDA1553AE;
	Mon, 22 Apr 2024 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="g+rxy39V"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF2C15534A;
	Mon, 22 Apr 2024 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713816466; cv=none; b=E6+M0eulEB/nAKuJyH6tR/Z7i2sZ53FgmbohUWIUXMylMx7y3pKcZw51g3h3LTOXJiulWxPbn4E01bjPI743bi8wKQbkbQ3a4YCQPPPOamjrtjfq1F5AKd0IcjcjeRPnU0orJb4KS3ItXPxUEOXw9dwCpBNpdS2O1a94J3Xgi1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713816466; c=relaxed/simple;
	bh=YwB3B7Ax1N+hcIIIexsiYQywXNfrCXaxhG8ux0IuDWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5JNO4Uvs24IskpqyA0rgsPllDKgvZjkwy5wl3SkrcUhuxaslV3JCH1/O5nCnfcRbWESuLkfV9a8dObuT5HkEZRoI4sfEcDRowen66Za+e+mNde7FfLdMybCnZ6EBjOAzv4QUeICa660N0+3NVI59FWgelMnubOeJ9Q4rhHIi2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=g+rxy39V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TU14y8FTwcIUu8V8KvTbGpugfd4H2ENzIeZb0l05KiQ=; b=g+rxy39VeCVO17Y8nhBHPyk9IM
	Uuf5Qn+YixYxykhUqVz+jSm+UIRt2T72KgWAWdRvI4AC2Co6TrGqzgnQoUjAC7mcanyJVxTgb+7Lc
	vR8QymzRPUDqicNvDmhCa4W/kj1bjhIV+M5ESXly/OL2jq+848uE39gur8+HEgKLN8/g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ryzwh-00DeFV-5e; Mon, 22 Apr 2024 22:07:23 +0200
Date: Mon, 22 Apr 2024 22:07:23 +0200
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
Subject: Re: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Message-ID: <2526cd6a-2300-47f2-bf94-3c697dda87e0@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>

On Thu, Apr 18, 2024 at 06:26:36PM +0530, Parthiban Veerasooran wrote:
> This patch series contain the below updates,
> - Adds support for OPEN Alliance 10BASE-T1x MACPHY Serial Interface in the
>   net/ethernet/oa_tc6.c.
>   Link to the spec:
>   -----------------
>   https://opensig.org/download/document/OPEN_Alliance_10BASET1x_MAC-PHY_Serial_Interface_V1.1.pdf
> 
> - Adds driver support for Microchip LAN8650/1 Rev.B1 10BASE-T1S MACPHY
>   Ethernet driver in the net/ethernet/microchip/lan865x/lan865x.c.
>   Link to the product:
>   --------------------
>   https://www.microchip.com/en-us/product/lan8650

I will get around to reviewing this soon, i promise.

To the OnSemi people: Have you tried your driver/device using this
framework? It would be good to have a second vendors device using it,
just to show no vendor specific code has slipped into the framework.

Thanks
	Andrew

