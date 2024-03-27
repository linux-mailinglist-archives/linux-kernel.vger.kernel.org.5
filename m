Return-Path: <linux-kernel+bounces-120510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A396D88D88D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE2A29E68C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5A72D604;
	Wed, 27 Mar 2024 08:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uFSGxBkF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B219823D7;
	Wed, 27 Mar 2024 08:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527331; cv=none; b=MbFuWBW0lYSEAgvDIn3ZrR7RdUFUahLjrvpYOwyLTlhfbXDz1f5KIPfFtKdh/wrRS+QIBdZRUW2fSJjh5umfa53cGo/TcIb3UHUCRJYA/Ul4iZJGSCxY9VvBrxPfTDBTkANv4T7qESMqDkqurQzkreQodIfT+pnma560WgoPncA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527331; c=relaxed/simple;
	bh=xVHaqZ1u760s+2uA6tdl2keH+dzuvpVmNgm8RSxlN50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MH5ih2EwJ9JxvxmFJGLxfJFnQVx6rVuvT0I0/9HjgY3l6BwV4zFKCjh+pEvHElcBCnObG2a4rK5vVp8wOAOLhVWNgRC8evcwgUA/PvrWMXOuIBh5K7NfdyWSpTffzOGOOn1rjwl31jI0lKwYLEX1kkv24orcvcTkMtBBL5WZ+hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uFSGxBkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2025C433C7;
	Wed, 27 Mar 2024 08:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711527331;
	bh=xVHaqZ1u760s+2uA6tdl2keH+dzuvpVmNgm8RSxlN50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uFSGxBkFaIMIAEsa4zemQnwPcMOfoNFWZPB+2Ka9mznGd0UGAhY2D69zeimXf6RGX
	 y5Gx28eXDgyHIrcyobJexzf4puxWw2sk840SLc+c12F6CXH2HlqI4RJk1ozhgzyGlB
	 1N++CXZZE7EOCtBsPWCzQtOa7OidhTh3LGSxsdNc=
Date: Wed, 27 Mar 2024 09:15:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Norihiko Hama <norihiko.hama@alpsalpine.com>
Cc: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"usb-storage@lists.one-eyed-alien.net" <usb-storage@lists.one-eyed-alien.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb-storage: Optimize scan delay more precisely
Message-ID: <2024032750-violator-trivial-90a3@gregkh>
References: <20240327055130.43206-1-Norihiko.Hama@alpsalpine.com>
 <2024032757-surcharge-grime-d3dd@gregkh>
 <TYVPR01MB107814D7A583CB986884AD4B290342@TYVPR01MB10781.jpnprd01.prod.outlook.com>
 <2024032745-transfer-dazzler-2e15@gregkh>
 <TYVPR01MB10781723CBD338DC3EEB5F20590342@TYVPR01MB10781.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYVPR01MB10781723CBD338DC3EEB5F20590342@TYVPR01MB10781.jpnprd01.prod.outlook.com>

On Wed, Mar 27, 2024 at 07:57:52AM +0000, Norihiko Hama wrote:
> On Wed, Mar 27, 2024 at 07:39:55AM +0000, Norihiko Hama wrote:
> > > > Sorry, but module parameters are from the 1990's, we will not go back to that if at all possible as it's not easy to maintain and will not work properly for multiple devices.
> > > >
> > > > I can understand wanting something between 1 and 0 seconds, but adding yet-another-option isn't probably the best way, sorry.
> > > 1 second does not meet with performance requirement.
> >
> > Who is requiring such a performance requirement?  The USB specification?
> > Or something else?
> This is our customer requirement.

If it is impossible to do, why are they making you do it?  :)

> > > I have no good idea except module parameter so that we can maintain backward compatibility but be configurable out of module.
> > > Do you have any other better solution?
> > How long do you exactly need to wait?  Why not figure out how long the device takes and if it fails, slowly back off until the full time delay happens and then you can abort?
> It's IOP issue and difficult to figure out because it depends on device itself.

Agreed.

> I know we have multiple devices with delay_use=0, but then it's recovered and detected by reset after 30s timeout, that is too long than 1 sec.

So how do you know that making this smaller will help?  There are many
many odd and broken devices out there that take a long time to spin up
before they are able to be accessed.  That's what that option is there
for, if you "know" you don't need to wait, you don't have to wait.
Otherwise you HAVE to wait as you do not know how long things take.

sorry,

greg k-h

