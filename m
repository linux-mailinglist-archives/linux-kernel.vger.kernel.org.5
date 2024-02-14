Return-Path: <linux-kernel+bounces-65378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CF2854C20
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB06D28A730
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DE65BAC2;
	Wed, 14 Feb 2024 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NySjlmxc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3295A7AB;
	Wed, 14 Feb 2024 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707922999; cv=none; b=FrHRsSCMghJOpMFFrS/jS6tTDXEeKWhmEbuiOtC/139N5cE7Yaik3i4zIyDDhXLv8Z4obRdbep+94evkhQa1oBVZnPGb7oefLxSbQDm0PNJv/00yMpJzsh/SQ62cy7CcY0Mk3oXPlZEW84XOHRc03UwqVuGvv/W3oMAseGtqLLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707922999; c=relaxed/simple;
	bh=cQAcIl/QAXBjiQTatIWRdXIYxEQLnd6fhBzv453xy/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7AK6+cFZ1is1oBkj2aCtFEBV8sspZQATtirOMvS5wiVPABPQcoobwF7w8HXofO//5Vinhr1ix/0modXRd5KQO4KlulZSzCD6WgakpuBDYhT0sWdni2E+vwbGWs37YwxjR5Y+H7Gbj3gHbHtlKamkyKus4/vGd7u5yXULX0RqFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NySjlmxc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707922998; x=1739458998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cQAcIl/QAXBjiQTatIWRdXIYxEQLnd6fhBzv453xy/I=;
  b=NySjlmxcvuSnYeCLEz6bQxSI1B5xYPlZTQu+WOCRdW5vOQpu2rp/VqHD
   jhvUOGJlugJm7XUS+ftsholcledwtwAn21lMil88w0yrX3u+OTuU4O+uT
   n88ouCMdmCBEN0bXA6w6AlDuSVvNbtuzbLx2XdWhNqdTEA53QgF0Xepow
   auJKLsh9L/wOvYjbvVOHbXVwtgLAoyFmlnvYYDDofCTNMAHXRiZrg2H/4
   70ILG8pbK2TMYQ6L1U8LQi3IQ8K/oz4YRSmR4Ht2VPst5OKxMHDMKE7Pu
   Ffn0NDXH5NCGdOraiUsTXONsHz4OOKpGoNUbw2rWanFbyk2J5KR4m1LTH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1839137"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="1839137"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 07:03:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="3202959"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 07:03:17 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 2B31F11F871;
	Wed, 14 Feb 2024 17:03:13 +0200 (EET)
Date: Wed, 14 Feb 2024 15:03:13 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] media: v4l: marvell: select CONFIG_V4L2_ASYNC where
 needed
Message-ID: <ZczWMRuSYABtDsVu@kekkonen.localdomain>
References: <20240213095555.454392-1-arnd@kernel.org>
 <24cbf7b2-a091-440e-92cc-5c9828d52260@xs4all.nl>
 <ZcyW8zn14iIbn45X@kekkonen.localdomain>
 <2027d488-a245-4492-bc17-27e17af575fd@app.fastmail.com>
 <6067898e-eaac-4266-b4a3-388db9a918fa@xs4all.nl>
 <7ec182c6-bd52-4433-bf06-dbc71f186184@app.fastmail.com>
 <3e5b41c0-1249-4546-a146-7c832cbfff28@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e5b41c0-1249-4546-a146-7c832cbfff28@xs4all.nl>

On Wed, Feb 14, 2024 at 01:42:55PM +0100, Hans Verkuil wrote:
> On 14/02/2024 11:58, Arnd Bergmann wrote:
> > On Wed, Feb 14, 2024, at 11:54, Hans Verkuil wrote:
> >> On 14/02/2024 11:48, Arnd Bergmann wrote:
> >>
> >>> It was definitely working before ff3cc65cadb5 ("media: v4l: async,
> >>> fwnode: Improve module organisation") in linux-5.13, but it's not
> >>> clear if that is the culprit. It's probably safe to backport
> >>> to v5.15 and higher.
> >>
> >>
> >> If it has been broken for so long, then should we bother with v6.8?
> >>
> >> I'm not saying we should, I just like to get your opinion on this.
> > 
> > I don't have a strong opinion either way, there is very little
> > risk and very little benefit in backporting.
> > 
> > If we apply it to 6.8 at all, I think it should also be in
> > v5.15+ LTS and vice versa, but only queuing it for 6.9 is
> > fine with me, too.
> 
> OK, I'll just take this patch as-is for v6.9. I'm preparing a PR
> anyway, so I'll include this patch.
> 
> Thank you for the quick replies!

Feel free to add:

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

