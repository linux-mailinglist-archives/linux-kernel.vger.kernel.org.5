Return-Path: <linux-kernel+bounces-118687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C260B88BE07
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044D02E2C86
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E186BB54;
	Tue, 26 Mar 2024 09:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckZ/8nmR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E67645975;
	Tue, 26 Mar 2024 09:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711445452; cv=none; b=dN18+GTUKeOWJ8s0OlpeEDIDXjUehtc0Xw/NLUdzFbfejnaWk9FBM10gRywgh116aCPElahE389+MmczEMMtny+ITcwDp0vf+Vx644Nn0vSdy4iCNkiVoZ0CKRn6ZmK8apELRSfU+6e6R1lvNDMjZh89wy+r7uMN3CUu7GfiTjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711445452; c=relaxed/simple;
	bh=DoVOcfg8BNPIadgIe/CtkKmdfNsnh7VR8WXrrgF7eFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2tVRPUfB/CB0W/VAhrzD7CFU9vQTxpAgb6gXCTuLwxmT51CLfVAgh66UH5him9AIb0wuYs9/6A2xSRl2ZRdWDt8b9dasHmBDyfXY1+YlXqBcE5L1DUfBc5ImLFh6rMQDmAzQGC5hHOwNyFUPp2l7Vk6rBr1nuilDBcmGV+j/qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckZ/8nmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B43C43390;
	Tue, 26 Mar 2024 09:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711445451;
	bh=DoVOcfg8BNPIadgIe/CtkKmdfNsnh7VR8WXrrgF7eFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckZ/8nmRjgO9b8oZdnGFefWgEDnp+WlNYTKAwvk3UJmBT3xiLMbI+jek+vY33nU3x
	 JLbDMY9gFiXBZdmLLSQEUnSy5zw3ssECnZ+GJztXoFfJ1K/0/UFVE6VpUhMkpnyQ18
	 +6T5G8cOWpRiBoTbMPyeRBDA3yoXGp6X7Z7uy6HLUj+LZqIU8CLIzlgMB7D/SuKNow
	 6Jx3F9LBb1fbsUrcQ+nUzEB/1ZN+AzVIkUhkBwhFm8MRTJ4TzoThXQ9pIrvNCkuYiE
	 Td1EOLr2TXxny0r6aFuwxMnvjeid+/mRinvTX+RdZ4e3xJtngu3lGe2TIAAtImuCH1
	 Hainz5Ca1BYrw==
Date: Tue, 26 Mar 2024 09:30:47 +0000
From: Simon Horman <horms@kernel.org>
To: Thomas Perrot <thomas.perrot@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: macb: allow MTU change when the interface
 is up
Message-ID: <20240326093047.GH403975@kernel.org>
References: <20240325152735.1708636-1-thomas.perrot@bootlin.com>
 <20240325205401.GF403975@kernel.org>
 <20240325185647.0ad674e9@kernel.org>
 <277c78a696e27e77e34820ebf2f7a0d0ce5d0633.camel@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <277c78a696e27e77e34820ebf2f7a0d0ce5d0633.camel@bootlin.com>

On Tue, Mar 26, 2024 at 09:49:19AM +0100, Thomas Perrot wrote:
> Hello,
> 
> On Mon, 2024-03-25 at 18:56 -0700, Jakub Kicinski wrote:
> > On Mon, 25 Mar 2024 20:54:01 +0000 Simon Horman wrote:
> > > I'm not sure that it is expected behaviour for an interface
> > > to reset like this when a change of MTU is requested.
> > > While conversely I think it is common (if not entirely desirable)
> > > to prohibit changing the MTU when an interface is up.
> > > What is the problem being addressed here?
> > 
> 
> The problem being addressed here, is that NetworkManager isn't able to
> apply the MTU value set in the connection configuration file because
> the link is already up, then the change_mtu callback returns an error:
> 
> "NetworkManager[412]: <debug> [1709629970.1735] platform: (eth0) link:
> setting mtu 1400                                                      
> NetworkManager[412]: <trace> [1709629970.1737] platform-linux: delayed-
> action: schedule wait-for-response-rtnl (seq 41, timeout in
> 0.199992796, response-type 0)                                         
> NetworkManager[412]: <trace> [1709629970.1737] platform-linux: delayed-
> action: schedule refresh-link (ifindex 2)                             
> NetworkManager[412]: <trace> [1709629970.1738] platform-linux: delayed-
> action: handle refresh-link (ifindex 2)                               
> NetworkManager[412]: <debug> [1709629970.1738] platform-linux: do-
> request-link: 2                                                       
> NetworkManager[412]: <trace> [1709629970.1739] platform-linux: rtnl:
> recvmsg: new message NLMSG_ERROR, flags 0, seq 41                     
> NetworkManager[412]: <debug> [1709629970.1740] platform-linux: rtnl:
> recvmsg: error message from kernel: Device or resource busy (-16) for
> request 41"

Hi Thomas,

I understand this is not ideal. But from a driver level perspective, if the
HW doesn't support changing the MTU while the device is up, rejecting the
change MTU operation is actually the best practice (or least worst
depending on your perspective).

As Jakub pointed out elsewhere in this thread, with your proposed change,
there is a real chance the NIC could drop of the network entirely and not
come back. Whereas the expected outcome is for the NIC to remain on the
network with either the new or old MTU.

