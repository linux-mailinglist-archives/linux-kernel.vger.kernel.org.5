Return-Path: <linux-kernel+bounces-87417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BFC86D423
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C742B24986
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B341428E5;
	Thu, 29 Feb 2024 20:23:25 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FD5144020;
	Thu, 29 Feb 2024 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238204; cv=none; b=gydbKKbXZ1SjfCjhdKyYMN9VTFhhPAptqYZ/9+jhVgF5zeHzNE/fP1XNLCz300C9vJrfp7tDH61zLIb3DiitD8gIm8Iz/T/xpDJOp+2UtrUV9G2S5+ON8rix+IBDyxzrmfW9SCGalkwhoGjLSQ3t3llIIw36HPiavjhvVyYtduM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238204; c=relaxed/simple;
	bh=oidxrFMFky//oZmuKsuam5uavRaPx5WUjsO/uxunEv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HU02Vt4GKndq/Pqr3ktj7BEn1nRHMHWiYZ6ixn3JwWmpeozbcfX5vMQgmRLXvF3cU4qhmS1BxPOUmiZ1iPEPRMftwyMKzLQlj4Sv4mj2+N7NqJXim0BHP7jwyB4JP2X1Xw01LPR2BA9w29Ezsc5b79c8D/Nqa/6W5gcmrffQ01U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 1039A1403E6; Thu, 29 Feb 2024 21:13:26 +0100 (CET)
Date: Thu, 29 Feb 2024 21:13:25 +0100
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: HaoTien Hsu <haotienh@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Sing-Han Chen <singhanc@nvidia.com>,
	Utkarsh Patel <utkarsh.h.patel@intel.com>,
	Jon Hunter <jonathanh@nvidia.com>, Wayne Chang <waynec@nvidia.com>,
	WK Tsai <wtsai@nvidia.com>
Subject: Re: [PATCH CFT] usb: ucsi_ccg: Fix command completion handling
Message-ID: <ZeDlZZ694gCPF43l@cae.in-ulm.de>
References: <20240215101024.764444-1-lk@c--e.de>
 <2024021504-oven-worst-5c15@gregkh>
 <Zc39d88ikvCO+XVK@cae.in-ulm.de>
 <4c61b43c-1dd0-4f8a-b65f-48752b1cc439@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c61b43c-1dd0-4f8a-b65f-48752b1cc439@nvidia.com>


Hi Haotien,

On Thu, Feb 29, 2024 at 07:18:44AM +0000, HaoTien Hsu wrote:
> On 2/15/24 20:03, Christian A. Ehrhardt wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Hi Greg,
> > 
> > On Thu, Feb 15, 2024 at 12:07:20PM +0100, Greg Kroah-Hartman wrote:
> >> On Thu, Feb 15, 2024 at 11:10:24AM +0100, Christian A. Ehrhardt wrote:
> >>> In case of a spurious or otherwise delayed interrupt
> >>> it is possible that CCI still reports the previous completion.
> >>> For this reason the UCSI spec provides different completion
> >>> bits for normal commands and for UCSI_ACK_CC_CI.
> >>>
> >>> Only complete a sync command if the correct completion bit
> >>> is set.
> >>>
> >>> This should avoid the need to clear out CCI before starting
> >>> a command. Thus remove this code.
> >>>
> >>> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> >>> Fixes: e32fd989ac1c ("usb: typec: ucsi: ccg: Move to the new API")
> >>
> >> What does "CFT" in your subject line mean?
> > 
> > It's supposed to mean "Call For Testers". More info in the
> > "Additional Information" section of the original mail.
> > 
> > I think the change is necessary and good but I do not have the HW
> > to test it.
> > 
> > I did test a similar change for ucsi_acpi.c that got merged and this
> > is the ping for ucsi_ccg.c people that they probably need this, too.
> > 
> >     regards   Christian
> > 
> > 
> 
> Hi Christian,
> 
> If we don't clean the CCI cache in ucsi_ccg_async_write(), there might 
> be a potential problem when the driver is polling the results.
> 
> In ucsi_init(), we may get EPROBE_DEFER from ucsi_register_port().
> Then it does ucsi_reset_ppm() before returning the error code, and we 
> will get  UCSI_CCI_RESET_COMPLETE and store it in the CCI cache.
> If we don't clean the cache, when the UCSI driver calls ucsi_init() 
> again, then in ucsi_reset_ppm(), it will get UCSI_CCI_RESET_COMPLETE 
> from the CCI cache instantly.
> Then the driver will run the next UCSI commands when the HW is not 
> completely reset.

Thanks, I indeed did not think the reset case completely through.
However, the real bugfix is in the other hunk of the diff and this
is a genuine bugfix on its own. I found that the corresponding
diff was neccessary for ucsi_acpi.c. Should I resend without the
CCI cleaning?

Thanks   Christian


