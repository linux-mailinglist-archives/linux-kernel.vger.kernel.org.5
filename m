Return-Path: <linux-kernel+bounces-99711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD88878C17
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E3FB21CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C6B17CD;
	Tue, 12 Mar 2024 01:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Kr3vSSyP"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4961653;
	Tue, 12 Mar 2024 01:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710205398; cv=none; b=S2mQwskGk3x9rpf7uocujA+l68gxnmlf4q/27Hq9Fxp9tmdR0YVG3vhDyKrfflI2KUPW2Y2efE786oUQ9sJ0yokHUwNQlgNmjq7JDZoB+cveX4IofoifSCM83FWk5CpStxrDg7+yTawlc5/sd57jr9fs84+T1vYPTbdaNOH8qos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710205398; c=relaxed/simple;
	bh=4EA1F03Y5lBS4e+B0GkGj9LBCoZMKjVs2nvhaANcl3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKn4ItCb1FHzvUUfYuZRGJhY3WFJywNaTnFYkyHzt8MGaXDVopnp5h+pfBXQQLM4/feh0BDL89GQM4IsksqfpmF5d4fm8SvniJ0NGxxO7tZwLovjgLICkjjJLahg6NlZE6whPNO0ndltXmmFxL7Ux5H+xTj7H73Dzf69k4x8D60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Kr3vSSyP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8OttdZlrG4D6n3/bWArb231lKpBo0dIW6y37zc5CZQ4=; b=Kr3vSSyP3usEfrbHqWqNQT6C3v
	p8ShX6NQ0jQ0h6m7vLjc0kJjht6nXakuEFxRF0jMi95vopHMnAJK96GYqyHC6vlvrPH1hh27rTUwW
	FbNrpLsqLKooJJhCEjSJTbW26m8N8loFhsU10SR0qFZaTnBBI561QPHuuJQ6vh9baJ3k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rjqY5-00A0Ed-2W; Tue, 12 Mar 2024 02:03:21 +0100
Date: Tue, 12 Mar 2024 02:03:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: dsa: mt7530: disable LEDs before reset
Message-ID: <0793ba6a-6cc9-4764-a2eb-f2766d860315@lunn.ch>
References: <20240305043952.21590-1-justin.swartz@risingedge.co.za>
 <6064ba52-2470-4c56-958c-35632187f148@arinc9.com>
 <d45083788db8b0b1ace051adecfe6a3a@risingedge.co.za>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d45083788db8b0b1ace051adecfe6a3a@risingedge.co.za>

> (b) When a cable attached to an active peer is connected to
> Port 3 (lan4) before reset, the incorrect crystal frequency
> selection (0b11 = 25MHz) always occurs:
> 
>               [7]      [8]     [10]    [12]
>               :        :       :       :
>               _________         ______________________________________
> ESW_P4_LED_0           |_______|
>               _________         _______
> ESW_P3_LED_0           |_______|       |______________________________
> 
>                         :     : :     :
>                         [9]...: [11]..:
> 
>  [7] Port 4 LED Off. Port 3 LED Off.
>  [8] Signals inverted. (reset_control_assert; reset_control_deassert)
>  [9] Period of 320 usec.
> [10] Signals inverted.
> [11] Period of 300 usec.
> [12] Signals reflect the bootstrapped configuration.

Shame the patch has already been accepted. The text in this email
would of made a cool commit message.

      Andrew

