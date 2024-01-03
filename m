Return-Path: <linux-kernel+bounces-15579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E91822E64
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40BC31F220AF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE25B1A591;
	Wed,  3 Jan 2024 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1zHnQX+c"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B671A27E;
	Wed,  3 Jan 2024 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=1H++AJiescRoXR5SWrVB1eNQUoip3aAkOmJ/HiZ4zFc=; b=1z
	HnQX+cm/ClYDZS+R5jDLXvXTqeToFIScTgJmaxWCtETaENqsdsnHh5KxQzovCNiLb/Fx8sJa0kTcD
	rMA3pPqTrNa7ZY9R64Wl9LYSxiS80L7yrD82n7/1d5vul9xWJ6tb0SzQemRdx4eK34bqzblhXXsq7
	5dtK8NxHj7Vk330=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rL1K8-004Fxw-12; Wed, 03 Jan 2024 14:30:20 +0100
Date: Wed, 3 Jan 2024 14:30:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	olteanv@gmail.com, hkallweit1@gmail.com, kabel@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: Re: [PATCH net-next] net: phy: Cleanup struct mdio_driver_common
Message-ID: <7367681a-3ef5-42ad-9c2f-173f77cc1b56@lunn.ch>
References: <20231228072350.1294425-1-yajun.deng@linux.dev>
 <ZZRJLg6U0G5CNRQ0@shell.armlinux.org.uk>
 <a5aca886-ca0a-8170-417f-a189ec28c87f@linux.dev>
 <ZZU8I5wwH+y1VsIy@shell.armlinux.org.uk>
 <52ea5dbf-2d60-7a23-e525-9dcae2809554@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52ea5dbf-2d60-7a23-e525-9dcae2809554@linux.dev>

On Wed, Jan 03, 2024 at 07:38:04PM +0800, Yajun Deng wrote:
> 
> On 2024/1/3 18:51, Russell King (Oracle) wrote:
> > On Wed, Jan 03, 2024 at 10:03:14AM +0800, Yajun Deng wrote:
> > > On 2024/1/3 01:34, Russell King (Oracle) wrote:
> > > > I'm not sure why this consistency is even desired, the commit message
> > > > doesn't properly say _why_ this change is being proposed.
> > > Most drivers use device_driver directly. This should be added to the commit.
> > > 
> > > Like this:
> > > 
> > > struct sdio_driver {
> > > 
> > > ... ...
> > > 
> > >          struct device_driver drv;
> > > };
> > > 
> > > 
> > > struct pcie_port_service_driver {
> > > 
> > > ... ...
> > > 
> > >          struct device_driver driver;
> > > };
> > > 
> > > and so on ...
> > ... which is fine for those other drivers because they don't share the
> > same bus. That is not the case here - we have two different classes
> > of drivers on the same bus.
> 
> 
> Yes, that's true. But we can implement it with is_phy_driver(). I don't
> think we need a flag for that.
> 
> > 
> > I don't like a justification that just because other subsystems do
> > something in one particular way, that is the only way things should be
> > done. I think there is good reason to have the structure we have, and
> > thus there needs to be a good reason to change it.
> 
> Its purpose is to clean up struct mdio_driver_common, and make the code
> cleaner.

I have to agree with Russell here. The commit message should explain
the 'Why?'. Why is this better? Why is it cleaner? Why does making it
the same as all other drivers make it better, when in fact we have two
classes of devices stacked on top of it, and making it different to
every other driver actually helps developers realise that?

      Andrew

