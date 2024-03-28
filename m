Return-Path: <linux-kernel+bounces-123107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84280890241
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245B51F2132C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A43312D745;
	Thu, 28 Mar 2024 14:52:01 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id BB9508121F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637520; cv=none; b=u/ffLIQGHjYAhgPQOxD+jCRwllGx9qSiPcJq166DWL9buh8rtedOB+s3tDTfdJcaUj/22DOSJDc5a1SSqw/ELz6BOQIYPerfLcyAFfnMGJVLkLLOI0sYFM/CrJIR29tFZFsSzkdSCQTM1PKFk2UBvAanMMnElPkzRKsqMzOeNMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637520; c=relaxed/simple;
	bh=fDPLCIyTGAjC+KUo0nZjfOc6qxfhbVrcbWZOLvzn1+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaEJ+yEwYQxjk2nNgTHp654GHdW0muacc1Ml+1VitsP+LDFrq+DSxws21+V8yv7cvfB7cJRUSifKEpRCwyTeYz11FtuOLoO73bMioZmtKZI5QFwiEWJRYWC1ybg75dn4tF/RdbtH9VPxzpXjB07ldenGFW55UeM9WBS+Q3yQPXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 961409 invoked by uid 1000); 28 Mar 2024 10:51:51 -0400
Date: Thu, 28 Mar 2024 10:51:51 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Norihiko Hama <norihiko.hama@alpsalpine.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
  "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
  "usb-storage@lists.one-eyed-alien.net" <usb-storage@lists.one-eyed-alien.net>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb-storage: Optimize scan delay more precisely
Message-ID: <0c99daaf-c727-467f-b8c1-ba8846d8a9ab@rowland.harvard.edu>
References: <20240327055130.43206-1-Norihiko.Hama@alpsalpine.com>
 <2024032757-surcharge-grime-d3dd@gregkh>
 <TYVPR01MB107814D7A583CB986884AD4B290342@TYVPR01MB10781.jpnprd01.prod.outlook.com>
 <a446cdf4-3a9b-43d8-b22b-78c20cce2b4f@rowland.harvard.edu>
 <TYVPR01MB10781AA8B37E147E318597B46903B2@TYVPR01MB10781.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYVPR01MB10781AA8B37E147E318597B46903B2@TYVPR01MB10781.jpnprd01.prod.outlook.com>

On Thu, Mar 28, 2024 at 03:04:47AM +0000, Norihiko Hama wrote:
> > On Wed, Mar 27, 2024 at 07:39:55AM +0000, Norihiko Hama wrote:
> > > > Sorry, but module parameters are from the 1990's, we will not go back to that if at all possible as it's not easy to maintain and will not work properly for multiple devices.
> > > >
> > > > I can understand wanting something between 1 and 0 seconds, but adding yet-another-option isn't probably the best way, sorry.
> > > 1 second does not meet with performance requirement.
> > > I have no good idea except module parameter so that we can maintain backward compatibility but be configurable out of module.
> > > Do you have any other better solution?
> >
> > Can you accomplish what you want with a quirk flag?
> 
> I think that it's hard to do that because 'quirk' is specified for a device
> but it's difficult to identify the devices to make quirk, especially for future introduced devices.
> 
> Can we change the design of existing 'delay_use' ?
> For example, 'delay_use' is 32-bit value and the value "1000 secs" does not make sense to set it,
> So if it's set to '1100', it's treated as "100 / 1000 = 0.1 sec". Is this possible?

Here's an approach that Greg might accept.

Since we already have a delay_use module parameter, we could add a 
delay_use_ms parameter.  The two module parameters would display the 
same value, but delay_use_ms would be in milliseconds instead of in 
seconds.  (This is similar to what we did for the autosuspend and 
autosuspend_delay_ms sysfs attributes.)

To make it work, you would have to add the new module parameter and 
store its value in milliseconds.  You would also have to change the 
existing module_param() definition for delay_use to module_param_cb() so 
that the get/set routines could divide/multiply the 
delay_use_ms/user-specified value by 1000 to convert to/from seconds.

When you write the patch, don't forget to update
Documentation/admin-guide/kernel-parameters.txt.

Alan Stern

