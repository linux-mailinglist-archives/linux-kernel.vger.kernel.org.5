Return-Path: <linux-kernel+bounces-117640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C63388AD9F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE05E1C3F360
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CDB6F515;
	Mon, 25 Mar 2024 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gfwlD+gr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B2A5DF0E;
	Mon, 25 Mar 2024 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389133; cv=none; b=BJ5ikneBKW8PriFQRfrTYVOr5AuI4v2NPPH673m+5r4yeu5eKbAkoS0qKX7I4y6G7PkGbPKZvP6TfzBs3c7qwB2rsV6jB39IZ1wzZtAtOvzp+u/26xbP8pFijrpt79XNsQBFG9Q5Qvv2itdkc88y4HAVsvvSRHGdKAug2QzHeH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389133; c=relaxed/simple;
	bh=td2xF43H2VanMjVI5gkm78ixcmwa+nB0cEceFdwTAZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNDgHQHVazUrYXGOTl4WEuJMsocemP7uzVWKHOqF6SE23k62CfPvaToMUnXrc7GlrtGjS9xbWNthpy8ai8gsRSeHtwY3q16osnklKD73ndBHK/RxFetCjciR+tLV5QqUYF+BRDJK7eUfunZYq6UIrBsShAVEYIwfgQzAyamiFzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gfwlD+gr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711389131; x=1742925131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=td2xF43H2VanMjVI5gkm78ixcmwa+nB0cEceFdwTAZo=;
  b=gfwlD+grZruvfWWJh/7I1auWCwDiSmEGDHfXo2ayxnmeH2PhNun/cOtO
   a16W8e3mhYzpJ7CQ5U0HpUokrD6bLrWhHKViNaEgZrWJN6iYu/rDNKC6y
   Ty2c9bc671InSfwG84oVqAqlKLtg4rMlMlECOwYYjKJAKCHh71oldE+ZM
   nujbx/bHmEcPLndMAPcyc1MzMyXS3T87Swmkg2Z2ktji1Ef6LAkuLdWe+
   ri3Iok/pVZ/BT2Tr6XR4qv4X6tNGCdcUyjAGup4vLaJvoK+ULNVX0wiGd
   dfxOp2yP6J4JO6XogtDAJ+xcwEbBfIHpGaFMPc/AW3KvecCQoQZXFGVsT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6345346"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6345346"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 10:52:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="20418698"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 10:52:10 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 5336111FB81;
	Mon, 25 Mar 2024 19:52:06 +0200 (EET)
Date: Mon, 25 Mar 2024 17:52:06 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: v4l2-subdev: Support enable/disable_streams for
 single-pad subdevs
Message-ID: <ZgG5xt07XQ7DJ1_W@kekkonen.localdomain>
References: <20240325-single-pad-enable-streams-v1-1-142e19896a72@ideasonboard.com>
 <20240325125055.GC23988@pendragon.ideasonboard.com>
 <ZgF10EVLrfF7cl57@kekkonen.localdomain>
 <0ad9841d-bb51-4512-9388-f9ce36372677@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ad9841d-bb51-4512-9388-f9ce36372677@ideasonboard.com>

Moi,

On Mon, Mar 25, 2024 at 03:43:01PM +0200, Tomi Valkeinen wrote:
> On 25/03/2024 15:02, Sakari Ailus wrote:
> > Moi,
> > 
> > Thanks for the patch.
> > 
> > On Mon, Mar 25, 2024 at 02:50:55PM +0200, Laurent Pinchart wrote:
> > > Hi Tomi,
> > > 
> > > On Mon, Mar 25, 2024 at 02:43:23PM +0200, Tomi Valkeinen wrote:
> > > > Currently a subdevice with a single pad, e.g. a sensor subdevice, must
> > > > use the v4l2_subdev_video_ops.s_stream op, instead of
> > > > v4l2_subdev_pad_ops.enable/disable_streams. This is because the
> > > > enable/disable_streams machinery requires a routing table which a subdev
> > > > cannot have with a single pad.
> > > > 
> > > > Implement enable/disable_streams support for these single-pad subdevices
> > > > by assuming an implicit stream 0 when the subdevice has only one pad.
> > > > 
> > > > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > > > ---
> > > > Even though I did send this patch, I'm not sure if this is necessary.
> > > > s_stream works fine for the subdevs with a single pad. With the upcoming
> > > > internal pads, adding an internal pad to the subdev will create a
> > > > routing table, and enable/disable_streams would get "fixed" that way.
> > 
> > I'd like to get rid of a redundant way to control streaming.
> 
> We can't get rid of it anyway, can we? We're not going to convert old
> drivers to streams.

I'd expect to do that but it'd take a long time. That being said, I think
we need to consider devices without pads (VCMs) so it may well be this
would remain after all.

> 
> For new drivers, yes, we shouldn't use s_stream. But is the answer for new
> sensor drivers this patch, or requiring an internal pad?

For new drivers I'd like to see an internal pad in fact.
{enable,disable}_streams is still internal to the kernel.

> 
> > > > So perhaps the question is, do we want to support single-pad subdevs in
> > > > the future, in which case something like this patch is necessary, or
> > > > will all modern source subdev drivers have internal pads, in which
> > > > case this is not needed...
> > > 
> > > I think the latter would be best. I however can't guarantee we won't
> > > have valid use cases for (enable|disable)_streams on single-pad subdevs
> > > though, so you patch could still be interesting.
> > 
> > Instead of the number of pads, could we use instead the
> > V4L2_SUBDEV_FL_STREAMS flag or whether g_routing op is supported to
> > determine the need for this?
> 
> Maybe, but are they better? Do you see some issue with checking for the
> number of pads? I considered a few options, but then thought that the most
> safest test for this case is 1) one pad 2) enable/disable_streams
> implemented.

I think I'd actually prefer {enable,disable}_streams in fact.

-- 
Terveisin,

Sakari Ailus

