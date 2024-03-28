Return-Path: <linux-kernel+bounces-123230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B968904D4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BFA3296E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252A5132808;
	Thu, 28 Mar 2024 16:18:17 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 0B205131BA0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642696; cv=none; b=jxGSCUcw3IXUoeLFZHWw35LQF7Bbq7NemFsynr4EeAh3GyGzTN0xQa2reapz7wllo/XNMQSfW+mPJJ4+BR5mCyBNruLAfIxGsoO+bSQn7Edz6rspXG0b/9CWGxfHHEqTpVUVVh54EJNIlGXHQb+PqOWFIe4Zk2fmZqeeeSpPXa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642696; c=relaxed/simple;
	bh=/KpgnWg969w9kfQ1LtcLkrkYrqm1vt/23nXsUi0UYKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCmX4bdJ4pd5jCX+TjR7fMgCXrNeR+a22/Sr7VKdE9Do124hBwaRQCQc05CdVBjxAnResvdq91f4WQHkRDAbcUl+ZuoR8l2ee9/TBFRGDDNW36GV6uxWwVSqDJWOo3JcISAlEovZ76liefmFR89LFKQyjhU6iCfbG6DZ1Pf9Tz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 964417 invoked by uid 1000); 28 Mar 2024 12:18:13 -0400
Date: Thu, 28 Mar 2024 12:18:13 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Matthew Dharm <mdharm-usb@one-eyed-alien.net>
Cc: Norihiko Hama <norihiko.hama@alpsalpine.com>,
  Greg KH <gregkh@linuxfoundation.org>,
  "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
  "usb-storage@lists.one-eyed-alien.net" <usb-storage@lists.one-eyed-alien.net>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb-storage: Optimize scan delay more precisely
Message-ID: <2483fb37-8939-4723-ae8d-7a7a7dba3322@rowland.harvard.edu>
References: <20240327055130.43206-1-Norihiko.Hama@alpsalpine.com>
 <2024032757-surcharge-grime-d3dd@gregkh>
 <TYVPR01MB107814D7A583CB986884AD4B290342@TYVPR01MB10781.jpnprd01.prod.outlook.com>
 <a446cdf4-3a9b-43d8-b22b-78c20cce2b4f@rowland.harvard.edu>
 <TYVPR01MB10781AA8B37E147E318597B46903B2@TYVPR01MB10781.jpnprd01.prod.outlook.com>
 <0c99daaf-c727-467f-b8c1-ba8846d8a9ab@rowland.harvard.edu>
 <CAA6KcBBcpug-rOytgnbb=c4O54m-Pfy=divqp12qOMrgmQrz7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA6KcBBcpug-rOytgnbb=c4O54m-Pfy=divqp12qOMrgmQrz7w@mail.gmail.com>

On Thu, Mar 28, 2024 at 08:21:18AM -0700, Matthew Dharm wrote:
> On Thu, Mar 28, 2024 at 7:51 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Thu, Mar 28, 2024 at 03:04:47AM +0000, Norihiko Hama wrote:
> > > > On Wed, Mar 27, 2024 at 07:39:55AM +0000, Norihiko Hama wrote:
> > > > > > Sorry, but module parameters are from the 1990's, we will not go back to that if at all possible as it's not easy to maintain and will not work properly for multiple devices.
> > > > > >
> > > > > > I can understand wanting something between 1 and 0 seconds, but adding yet-another-option isn't probably the best way, sorry.
> > > > > 1 second does not meet with performance requirement.
> > > > > I have no good idea except module parameter so that we can maintain backward compatibility but be configurable out of module.
> > > > > Do you have any other better solution?
> > > >
> > > > Can you accomplish what you want with a quirk flag?
> > >
> > > I think that it's hard to do that because 'quirk' is specified for a device
> > > but it's difficult to identify the devices to make quirk, especially for future introduced devices.
> > >
> > > Can we change the design of existing 'delay_use' ?
> > > For example, 'delay_use' is 32-bit value and the value "1000 secs" does not make sense to set it,
> > > So if it's set to '1100', it's treated as "100 / 1000 = 0.1 sec". Is this possible?
> >
> > Here's an approach that Greg might accept.
> >
> > Since we already have a delay_use module parameter, we could add a
> > delay_use_ms parameter.  The two module parameters would display the
> > same value, but delay_use_ms would be in milliseconds instead of in
> > seconds.  (This is similar to what we did for the autosuspend and
> > autosuspend_delay_ms sysfs attributes.)
> 
> What about just changing the parser on the currently delay_use
> parameter to accept an optional suffix?  If it's just digits, it is in
> seconds.  If it ends in "ms", then interpret it as milliseconds.  This
> would be backwards compatible with existing uses, give you the
> flexibility you want, avoid adding another modules parameter, and
> potentially be expandable in the future (if, for some reason, someone
> wanted microseconds or kiloseconds).

A little unconventional, I think (at least, I don't know offhand of any 
other module parameters or sysfs attributes that work this way), but it 
would work.

Noriko, would you like to write a patch to do this?

Alan Stern

