Return-Path: <linux-kernel+bounces-154188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732198AD8FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35941281742
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7461E4502B;
	Mon, 22 Apr 2024 23:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="m7MwPPQ8"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1553D556;
	Mon, 22 Apr 2024 23:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713828198; cv=none; b=X0Yj3rtnUwxCsriP1QXLgmC7FuJispgFDYFt93PAXcNiIKcoYDvClqfXGVYQ9MWO7RJmO9/OYwmhP/PEFS3hH3pKDUnTBEg0FNT2LXJAssLCBJT3pEeY3eJLTXrA1m3DuRus1721buljkuZ1eOR/K9UE861OsL7LeFocspIf+HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713828198; c=relaxed/simple;
	bh=tGAT0/KqXPZ7vFH5lIixRoGblBIPTLyL1oM6f4j2m8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pc3QJ1MVfxYxmIZmIRYigLhV2gG0+SkmCjf5hI9h3GpWLOzdzEBGpDBIvDSBS6DBSxgvaXULgjvoaS7tkAE8l6kSeVWvTyNiKG8Szok4DrOlKrThwEZhrsKyGxT1Mj3NhT1g8cfICBxTA5BcT/YOVkInIUFk98DCeGqY+pdYpuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=m7MwPPQ8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w34AumCooKNrepQz/ik6t7UXw9d+51JDT8B8iDo0sjE=; b=m7MwPPQ8WIdS0lTbrJdaFt9Qyn
	voDDkEXLUa8uQwIeHR7B3sSC6U3+FOHni4V5XfS/x9ynl40WeWnAX93xU6bhH6E7xhae1XQ5e4TTn
	T2125yHuHHdHOjNu/+YEqc60mZrQpdrcbjn9iWrBaKXEiO9qWLrEZ/Nb1Iz1MoXpl0Zw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rz301-00Desf-Dp; Tue, 23 Apr 2024 01:23:01 +0200
Date: Tue, 23 Apr 2024 01:23:01 +0200
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
Message-ID: <32160a96-c031-4e5a-bf32-fd5d4dee727e@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <5f73edc0-1a25-4d03-be21-5b1aa9e933b2@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f73edc0-1a25-4d03-be21-5b1aa9e933b2@lunn.ch>

On Mon, Apr 22, 2024 at 10:08:23PM +0200, Andrew Lunn wrote:
> > Testing Details:
> > ----------------
> > The driver performance was tested using iperf3 in the below two setups
> > separately.
> > 
> > Setup 1:
> > --------
> > Node 0 - Raspberry Pi 4 with LAN8650 MAC-PHY 
> > Node 1 - Raspberry Pi 4 with EVB-LAN8670-USB USB Stick
> > 
> > Setup 2:
> > --------
> > Node 0 - SAMA7G54-EK with LAN8650 MAC-PHY 
> > Node 1 - Raspberry Pi 4 with EVB-LAN8670-USB USB Stick
> 
> Would it be possible to chain these two setups together by adding two
> USB dongles to one of the Ri 4s? If i remember correctly, there were
> reports of issues when two devices were using the framework at once.

Sorry, that makes no sense. Your USB device is unlikely to be doing
USB->SPI->MAC-PHY. Do you have two LAN8650 MAC-PHY you can connect to
one host?

    Andrew

