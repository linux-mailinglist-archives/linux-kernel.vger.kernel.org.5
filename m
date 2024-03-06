Return-Path: <linux-kernel+bounces-94448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1A3873FF1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ECB01C23542
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D52B13E7D3;
	Wed,  6 Mar 2024 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1WVXpZde"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E20F13BAD2;
	Wed,  6 Mar 2024 18:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709750925; cv=none; b=kEJ+gYjYfaRKPNPg/JW5N+yq4WQQUErj+xYawRa2UdwxCmaiWHMIKwDhAoyuwGl9cvr0pHw4URF+X8QK5EHdeYJ6+MhqzXHFuiZX2DhZ5ZO7ucpAujAyhK8zStUJpQzOCVvyis5Ksg+QrIR+JuMa2Zdn/BEqAbP3wkRn6MLXYbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709750925; c=relaxed/simple;
	bh=Zg4PWX/cxBWr054h/DiOcpPuN7gKgXEixtzB1KbTE04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+K2pZLyDPJju1B9xAnPaaGR6+3SQNn0/RkHmZWs91eWmjjZG2aNhAwcsHAxGwd7puEeZ9eDU376LAG84hWAbmamVsO/Jkpjz0Dn8KH4rQbSL3Mlq1cGwsPgj/n57i+xBH3Q22gdS9KSIHWDWvndzhGBBr/Wiz5XPRAOk08qwzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1WVXpZde; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=QtNK4I/BmaQ7AXWlF2NqA6aFJQal3RUHHfvBgUEkqHs=; b=1W
	VXpZdeeUbISXlyPnjWR90nu4n7QuGLHlMZdOE28KcaxiKCnxiI/ujQvnCA6jZliT9mZGiZ90/uUpr
	ecj/CALEQFttbrCcCm+MJsXquxwxs0bIKHyfx56kn4MKVEWF+WrHndYn7QeuNAu+Yshr+dj6Qsk4H
	keA8g1LQ7J25Z2Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhwK1-009WQI-Ag; Wed, 06 Mar 2024 19:48:57 +0100
Date: Wed, 6 Mar 2024 19:48:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Conor Dooley <conor@kernel.org>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
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
Subject: Re: [PATCH net-next v3 12/12] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Message-ID: <4c5968a3-c043-45fc-8fff-2a9eaa6de341@lunn.ch>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-13-Parthiban.Veerasooran@microchip.com>
 <20240306-spree-islamist-957acf0ee368@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240306-spree-islamist-957acf0ee368@spud>

> > +description:
> > +  The LAN8650/1 combines a Media Access Controller (MAC) and an Ethernet
> > +  PHY to enable 10BASE‑T1S networks. The Ethernet Media Access Controller
> > +  (MAC) module implements a 10 Mbps half duplex Ethernet MAC, compatible
> > +  with the IEEE 802.3 standard and a 10BASE-T1S physical layer transceiver
> > +  integrated into the LAN8650/1. The communication between the Host and
> > +  the MAC-PHY is specified in the OPEN Alliance 10BASE-T1x MACPHY Serial
> > +  Interface (TC6).
> > +
> > +allOf:
> > +  - $ref: ethernet-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - const: microchip,lan8650
> > +          - const: microchip,lan8651
> 
> The order here is wrong, lan8561 needs to come before the fallback of
> lan8650.

I don't think it is a fallback. There are two devices, and hence two
different compatibles. So i suspect the -items: is wrong here?

	  Andrew

