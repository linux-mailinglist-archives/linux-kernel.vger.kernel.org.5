Return-Path: <linux-kernel+bounces-66924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EDB8563AC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FBBC1C23BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2763612F367;
	Thu, 15 Feb 2024 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QrdIVAfe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AA312EBE4;
	Thu, 15 Feb 2024 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001417; cv=none; b=EJ8JzGHd4cLUcQDHcqwX/+enpZTQT+/gRwfrzSvlwto/2AcZzBusSlgc67CYCWG7w4np6xHh9T7fUQbCRmJtpd4PZ1bXMSX0t8/+ylu7SAP7GO/zsZgAJpzEp2RtXS16ZrPCqwW+1YMNQSfrAKKjR5O1NzxRZ7jxuS1qEYH2WaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001417; c=relaxed/simple;
	bh=nBIC9Bm1TLQ17m0KlQHQyvQ35lnC216nQhZJl1gxfNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8KLhkxC/o8Xl5lS8S3JFX+kwh7WlfFEQ7Xo7eMeOPvzDY3OBZxk544RqJJZOZXh42vdB99bXg8c0Cmh2atkhi8sucDkhZ2JXLaKcUkhR7sNS44SFiM89WHvOARaWpUx2pZ3j1SEok3d7WK97o4YjM8pzuIcM6Xm8qiMku0va80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QrdIVAfe; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708001414; x=1739537414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nBIC9Bm1TLQ17m0KlQHQyvQ35lnC216nQhZJl1gxfNw=;
  b=QrdIVAfeEpNcfSpVe5gRd8Wzk4EZrcJSbSK37HNyllaN0BDXr8CpUAMr
   AOt/SiFhfP4jTbej1ZDUGrANgfAYkvXDHpsokpXPkF7FcFJcDbrIXmY83
   RBY8+G4+Ia6FZBw5ZEWsR3IG7FNRgZZdNpkufPOE2pBg1s++wkd1VzTsE
   3l1tS2rkWz1GcDG1BC0AjTtLUqFarx17FOnFS7PJLzO2BvL2pVp8mjAdf
   KIDbKQOta+QOhZf/BeA4pu1Gw2T4Rdqun1pdh1lJoteH0ibnz2uSfu9Qc
   bLE70RF/l3ZCCVResLLH1hngf2KHN4o5d9d+OXaVP9MbycCPzOWBxvVua
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2228243"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="2228243"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 04:50:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3869490"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 04:50:13 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id D849211F871;
	Thu, 15 Feb 2024 14:50:09 +0200 (EET)
Date: Thu, 15 Feb 2024 12:50:09 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: Matthias Fend <matthias.fend@emfend.at>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	linux-media@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] media: i2c: imx335: Drop setting of 0x3a00
 register
Message-ID: <Zc4IgUFFsjA-LC6T@kekkonen.localdomain>
References: <20240131055208.170934-1-umang.jain@ideasonboard.com>
 <20240131055208.170934-2-umang.jain@ideasonboard.com>
 <170669477439.1011926.18210850208916698098@ping.linuxembedded.co.uk>
 <d3abce5f-5e99-4a8b-a45b-29b706bc8481@emfend.at>
 <8bc8bf66-cde9-16c4-e8bd-389940ceeeb6@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bc8bf66-cde9-16c4-e8bd-389940ceeeb6@ideasonboard.com>

Hi folks,

On Wed, Feb 07, 2024 at 09:51:32AM +0530, Umang Jain wrote:
> Hi,
> 
> On 1/31/24 4:02 PM, Matthias Fend wrote:
> > Hi Kieran,
> > 
> > Am 31.01.2024 um 10:52 schrieb Kieran Bingham:
> > > Hi Umang,
> > > 
> > > + Cc: Matthias
> > > 
> > > Quoting Umang Jain (2024-01-31 05:52:04)
> > > > Register 0x3a00 is a reserved field as per the IMX335 datasheet,
> > > > hence shouldn't be set by the driver.
> > > 
> > > We still need to explain more about why we're dropping this register
> > > write, and what effects it causes.
> > > 
> > > Matthias - I believe this stemmed from the work you did, and I think I
> > > recall that you stated this register write broke the CSI2 configuration?
> > > 
> > > Can you clarify anything here for us please?
> > 
> > yes, that's correct.
> > 
> > Since this driver originally did not work in my setup, I came across
> > this register while searching for differences to my working reference
> > configuration.
> > With the default value of this register (0x00), the driver works
> > perfectly. With the value previously written to it by the driver (0x01),
> > I cannot receive any frames.
> > The problem may depend on the link frequency used.
> > I can only use and test a frequency of 445.5MHz on my hardware. Since
> > only link frequencies of 594MHz were supported so far, this may not have
> > been a problem.
> > 
> > Unfortunately I do not have a description of this register, so I can
> > only speculate about the exact cause.
> 
> Is it worth to frame the commit message around this speculation ?
> 
> My setup has no effect with this register being set or not.

Very interesting case indeed.

Please elaborate this a little in the commit message, but the message
shouldn't be that because the register is marked rewerved, it shouldn't be
written (it's a commonplace when it comes to sensors :().

-- 
Regards,

Sakari Ailus

