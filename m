Return-Path: <linux-kernel+bounces-78373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A37D8612A2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9141F22733
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515467EF06;
	Fri, 23 Feb 2024 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hM9QgcT3"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43AA7CF07;
	Fri, 23 Feb 2024 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694809; cv=none; b=hiIRJ8UI8JKj4zkxmz8jOqdk03NTkBFBaVWa6ZlC01ZT1hz/HPHSZwS4Wx2BYXWwOeAaGp0yDf0NehauSw4Cnk+DaTy7r7NCfUB+h4AMbErFHmMuhT9r73rEnhk6SuWTlrlKDzLd/c4hDg1PPWS2HkCC8bPe8Gg3xsd44uzwDf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694809; c=relaxed/simple;
	bh=OtPRWfESSfEQkRfDcdFlgXEhqSSM5H6y889bGCwyA+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YS3I3NlE0U1DKEDLFrplDspnpUvJx8MotO8Z3HfbvquQwcagtgIObiD3Q1vTi2PdQSwUBkpOjir3Y6YYoYd2clguU8YNwYJUaeML43qry4VfQNv3ItqhE9Cwt8vDRmkthUc2qU9Rx4/3wkltLK/nWr6PnvGngk5nRWEaqOwRYHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hM9QgcT3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nv3TXV0frQDnlMTQXgGRhHxlWDyQTPRVr6JrvnqZ9KA=; b=hM9QgcT3o4dcrvqpIOzsKShBxx
	c+EShPPwHrzSD1ZwkiQPcEn9exa9y6LO4PzkMQpw/FmR92uZLfqkLU9unqgYrPGefEo2ByhDe7qd2
	tHR4zkDBcmTx1m582jpK1qpu0wBrLAsr+ara4BNztks8aZTlfRWKUmeFQPEaR7I3h1a8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rdVZi-008XYC-VH; Fri, 23 Feb 2024 14:26:50 +0100
Date: Fri, 23 Feb 2024 14:26:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@armlinux.org.uk, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [PATCH net-next v2 3/4] net: macb: Enable queue disable and WOL
Message-ID: <8c0efb9a-d92c-4b9b-be75-498d460f67bd@lunn.ch>
References: <20240222153848.2374782-1-vineeth.karumanchi@amd.com>
 <20240222153848.2374782-4-vineeth.karumanchi@amd.com>
 <024fd8e1-8d1c-4073-99ff-ae8c5d123baa@lunn.ch>
 <78730bb7-4588-4038-9336-eec6e2635a75@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78730bb7-4588-4038-9336-eec6e2635a75@amd.com>

> It is not specific to AMD versions. All Cadence GEM IP versions have the
> capability, but specific vendors might enable or disable it as per their
> requirements.

Do you mean it is an option to synthesizer it or not? So although the
basic IP licensed from Cadence has it, a silicon vendor could remove
it?

> WOL was previously enabled via the device-tree attribute. Some users might
> not leverage it.

This is not typical. If the hardware supports it, we let the end user
decided if they want to use it or not.

So if all silicon should have it, enable it everywhere. If there is an
option to save some gates and leave it out of the silicon, then we do
need some per device knowledge, or a register which tells us what the
synthesis options where.

	Andrew

