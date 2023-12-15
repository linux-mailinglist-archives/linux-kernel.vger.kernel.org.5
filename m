Return-Path: <linux-kernel+bounces-704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AF28144E0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A411C22B47
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3EC18B10;
	Fri, 15 Dec 2023 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Tong0rwi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC15182A3;
	Fri, 15 Dec 2023 09:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IpNMOaelJu1m+OhxDMKyjTfEg8jKBGFhtAqTcShaIjk=; b=Tong0rwiixvKY5rAH76RgCywX6
	nX7jU0Pk2KlDbWdbuarsRpeLYLb2pV0EWo0l9vEUsTwqeXpygWNrq/ihXAutMW09v0ErHAy+Ky/pv
	xP/lmJpkWqc+2D9a/FzhuMhZPOopJzYodfFRNZDPcT3Q53d/QS3QrBgWj1kNkD+Hz480=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rE4sf-0030SP-30; Fri, 15 Dec 2023 10:53:17 +0100
Date: Fri, 15 Dec 2023 10:53:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: skip LED triggers on PHYs on SFP modules
Message-ID: <fac3e5c3-4a0c-441e-8bf4-14ab36e8cf3f@lunn.ch>
References: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
 <20231214183123.0f0af377@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214183123.0f0af377@kernel.org>

On Thu, Dec 14, 2023 at 06:31:23PM -0800, Jakub Kicinski wrote:
> On Tue, 12 Dec 2023 00:05:35 +0000 Daniel Golle wrote:
> > Calling led_trigger_register() when attaching a PHY located on an SFP
> > module potentially (and practically) leads into a deadlock.
> > Fix this by not calling led_trigger_register() for PHYs localted on SFP
> > modules as such modules actually never got any LEDs.
> 
> Any suggestion of a Fixes tag?
> Looks like the triggers were added a while back, are we only seeing it
> now because we started exercising the code more?

How about:

Fixes: 01e5b728e9e4 ("net: phy: Add a binding for PHY LEDs")

       Andrew

