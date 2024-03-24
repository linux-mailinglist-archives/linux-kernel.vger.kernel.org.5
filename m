Return-Path: <linux-kernel+bounces-112726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 268F7887D76
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 16:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB231C20ADF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 15:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6317C18659;
	Sun, 24 Mar 2024 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eJiQuMTb"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1852107;
	Sun, 24 Mar 2024 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711293960; cv=none; b=WBqSjuS9nf+1jI/4WkOeL9i9BkBpvCGKw7WDaLXXMitpm5ABn0vlrRQTGJlyQCmgcko6JVzcbqw9sj7Disa55k2CfznwepBS2uxkCTZjqX6ZHi1YoOepBqdHb/z6FKuiXX5oP+YCk6INg5S1JqWJx4JWIu719ISE5X/L8xUIAm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711293960; c=relaxed/simple;
	bh=4uehC6kd6vVBhjMWaG54gnvU5tDXuRlGD+paJ+A4wNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJjyN1JqRM77nh0sGcO9NV7NEGCy8kFi04e3T1x8Mj8mhlOxFvCivlitGSqIQ8W8z1hRHLox+ami86qXHKsQLuNE3C0/KoAV+rXMIb4QsBkaAO8ON1Zw7F0CzuY4K8mPC5VGuX+tX0nsZxIEtXZCY4+ZHhDtvfSwRhbpW9tXkXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eJiQuMTb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Tp7gUCtuROuSbcpwnhbXJLwSPqSbYkCqzDSlfDFnpWI=; b=eJ
	iQuMTbTSPacdDPPXFm8ZF4DcIkLkDalxUt5Be8FAhI9Cxe9N9sTkqhJxo1YoVsJ+qlSixIYJnp9Ei
	Kx1NrE41BOIg66jSUd+W+fbyjGar30/kc8pbKGLrFn3ufJgAMoE9qY8hbDBB6wvLCT2OWkYgRp0RI
	wBgP3Xaa8kGp8cM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1roPiy-00B6N8-ED; Sun, 24 Mar 2024 16:25:28 +0100
Date: Sun, 24 Mar 2024 16:25:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Elad Nachman <enachman@marvell.com>
Cc: Taras Chornyi <taras.chornyi@plvision.eu>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"dkirjanov@suse.de" <dkirjanov@suse.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v2 0/5] Fix prestera driver fail to probe
 twice
Message-ID: <6dae31dc-8c4f-4b8d-80e4-120619119326@lunn.ch>
References: <20240320172008.2989693-1-enachman@marvell.com>
 <4104387a-d7b5-4029-b822-060ef478c6e3@lunn.ch>
 <BN9PR18MB42517F8E84C8C18078E45C37DB322@BN9PR18MB4251.namprd18.prod.outlook.com>
 <89a01616-57c2-4338-b469-695bdc731dee@lunn.ch>
 <BL1PR18MB42488523A5E05291EA57D0AEDB372@BL1PR18MB4248.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL1PR18MB42488523A5E05291EA57D0AEDB372@BL1PR18MB4248.namprd18.prod.outlook.com>

> > > Originally, the pain point for Kory was the rmmod + insmod re-probing
> > > failure, Which is only fixed by the first two commits, so I see little
> > > point in submitting 3-5 alone, Without fixing Kory's problem.
> > 
> > I thought Kory's problem was actually EPROBE_DEFER? The resources needed
> > for the PoE are not available, so probing the switch needs to happen again
> > later, when PoE can get the resources it needs.
> 
> No, the PoE is the general high level application where he noted the problem.
> There is no PoE code nor special PoE resources in the Prestera driver.

So here is Köry email:

https://lore.kernel.org/netdev/20240208101005.29e8c7f3@kmaincent-XPS-13-7390/T/#mb898bb2a4bf07776d79f1a19b6a8420716ecb4a3

I don't see why the prestera needs to be involved in PoE itself. It is
just a MAC. PoE happens much lower down in the network stack. Same as
Prestera uses phylink, it does not need to know about the PHYs or the
SFP modules, phylink manages them, not prestera.

> The problem was caused because the module exit was lacking the so called
> "switch HW reset" API call which would cause the firmware to exit to the firmware
> loader on the firmware CPU, and move to the state in the state machine when
> it can receive new firmware from the host CPU (running the Prestera switchDev
> driver).
> 
> > 
> > But if that is going to take 30 seconds, i'm not sure we can call EPROBE_DEFER
> > solved.
> > 
> > The later patches are pretty simple, don't need discussion, so could be
> > merged. However, i think we need to explore different possible solutions for
> > firmware {re}loading.
> > 
> > > The problem is not with the hardware, but with the existing firmware
> > > code on the Firmware cpu, most probably secure-boot protected, which
> > > lacks the ABIs to report to The kernel what is loaded, what version, what
> > state, etc.
> > 
> > Can you at least tell if it is running firmware?
> 
> There is no existing API/ABI for that.

Do you at least have the ability to determine if an API call exists or
not? It sounds like your firmware needs extending to support returning
the version. If the API is missing, you know it is 4.1 or older. If it
does exist, it will return 4.2 or higher.

> > Can you explain the boot in a bit more detail. Are you saying it could be
> > running an old firmware when the driver first loads? So you need to hit it with
> 
> Exactly.
> 
> > a reset in order to load the firmware for /lib/firmware, which might be newer
> > than what it is already running?
> 
> Right. And there is also the configuration. There is no telling what kind of
> Configuration the existing firmware is running. Just using the existing firmware
> Will lead to the situation where Linux kernel side will report certain configuration
> (via ip link / ip addr / tc , etc.) but the firmware configuration is completely different.

Well, during probe and -EPRODE_DEFER, linux has no configuration,
since the driver failed to probe. However, for a rmmod/modprobe, the
firmware could have stale configuration. However pretty much every
device i've come across has the concept of a software reset which
clears out the configuration. Seems to be something else your firmware
is missing.

	Andrew

