Return-Path: <linux-kernel+bounces-66856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B09C8562E1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD85BB2DF94
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6BC12B175;
	Thu, 15 Feb 2024 12:03:09 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4450F129A73;
	Thu, 15 Feb 2024 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998589; cv=none; b=gOrQJcRuLRqiB2ptxCIthRCBBm+vXTyehR6ZGOzamR4NSgjsz5/E9IDeK5VoxQ5dnkf9qxNOqEUyQbHh4UlQkYnX1qUGLJiElJn3106FbMixUaHfijqMPtpoMxBNIe75sfShwxRUk4mHzTLDQ28x+K1RNLri/UU2A0V2f/sNA1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998589; c=relaxed/simple;
	bh=KLEpcqUuMdy0qHBK987rtK7f0TP+ymsMuh1O6QES8mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNAddM4OmhJjVXib5orhNjkEWyOMhcLPP3I6KiHwEwnOudKnD6419dMFwDK1RdHpkr6vi5625vFSOEsE9/kFN8leqBQA4o/E5vprU8fcx9NbJqanmU2cTeNPYO5wQJncCHnlEMWNGp5Gl6rS1S9YmVGS6fyQFNKqpzBlkAlMHW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id C91441403D1; Thu, 15 Feb 2024 13:03:03 +0100 (CET)
Date: Thu, 15 Feb 2024 13:03:03 +0100
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Sing-Han Chen <singhanc@nvidia.com>,
	Haotien Hsu <haotienh@nvidia.com>,
	Utkarsh Patel <utkarsh.h.patel@intel.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Wayne Chang <waynec@nvidia.com>, WK Tsai <wtsai@nvidia.com>
Subject: Re: [PATCH CFT] usb: ucsi_ccg: Fix command completion handling
Message-ID: <Zc39d88ikvCO+XVK@cae.in-ulm.de>
References: <20240215101024.764444-1-lk@c--e.de>
 <2024021504-oven-worst-5c15@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021504-oven-worst-5c15@gregkh>


Hi Greg,

On Thu, Feb 15, 2024 at 12:07:20PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 15, 2024 at 11:10:24AM +0100, Christian A. Ehrhardt wrote:
> > In case of a spurious or otherwise delayed interrupt
> > it is possible that CCI still reports the previous completion.
> > For this reason the UCSI spec provides different completion
> > bits for normal commands and for UCSI_ACK_CC_CI.
> > 
> > Only complete a sync command if the correct completion bit
> > is set.
> > 
> > This should avoid the need to clear out CCI before starting
> > a command. Thus remove this code.
> > 
> > Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> > Fixes: e32fd989ac1c ("usb: typec: ucsi: ccg: Move to the new API")
> 
> What does "CFT" in your subject line mean?

It's supposed to mean "Call For Testers". More info in the
"Additional Information" section of the original mail.

I think the change is necessary and good but I do not have the HW
to test it.

I did test a similar change for ucsi_acpi.c that got merged and this
is the ping for ucsi_ccg.c people that they probably need this, too.

   regards   Christian


