Return-Path: <linux-kernel+bounces-103441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C0087BF63
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA33284457
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373FA71733;
	Thu, 14 Mar 2024 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MpEymUlu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B005129CE3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428272; cv=none; b=NF8ajsWXmS4/5UU8c9Au18Y40m3q5r81/jrKKJek0Dl2M1zzd+cZyMIZNa9GqD1unKm5HoBbsEPKfuD+/vGTuLanzZU/0U9eCLfQ9OLZUZ6j/UOlFtEywF1JHH4G8yKLmehMyHafY6V10SWs+SZtPlCFXe9jUBYRcH3ciGDS3Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428272; c=relaxed/simple;
	bh=GiGl93VrTTcHdoR89IlFEwgp3me63640M18VdjKtCDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3/Fn1TNQx5FmKSvRJGOc8xxRv3Y1DG4A7HOZ+s3/4a3QzpC/FyfhW3oe4jdwX20Ft3s4XZp0hPHhfq3n03gJiWm76g54eJ6bZm0EGy73bHS6+z1kAQO6y9PXAS7YAHCVyUPLmc7yIaSsQf7wovP11Y0Z6LuaBgEHfGy7hA6O4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MpEymUlu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710428271; x=1741964271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GiGl93VrTTcHdoR89IlFEwgp3me63640M18VdjKtCDQ=;
  b=MpEymUluFVKTnaixJZ1yolGFgELCysuFNSDx0sFkdz2MPunMQV1LtaUV
   teobgz+oJdOM4KpHwr46K0Q0iKbLWBiD9uGbM+yLE92VFY6OgvbQnbkiE
   T51r2Ga40hjLnvz82fyj/OH1fBoHkGKo7jswmWbMEdr0nK8XclbL5hXxp
   t2FG7zRtadS5qOcsasgc0T6YCnePuXFA3cbsYS4u9y1wIVeGicyaMTaXM
   TD4aDlIICB51/3n9b8fWgpw4tZ/rKw7DHoXZwrgBVPoZ3nJFDCiJnnfOh
   dpckzoyUYya9AJe+2XxBAdpEUFtzaEdAJWVOI5UllSrQjMJouF8DtSu/0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="27721432"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="27721432"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 07:57:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="49738178"
Received: from jandre-mobl.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.72.214])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 07:57:49 -0700
Date: Thu, 14 Mar 2024 07:57:48 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ayush Tiwari <ayushtiw0110@gmail.com>, Larry.Finger@lwfinger.net,
	florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: greybus: add comment for mutex
Message-ID: <ZfMQbIzZ6lKhxhkM@aschofie-mobl2>
References: <ZfHuokO3pQXMOxcC@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
 <ZfJhtBrsL3elRve8@aschofie-mobl2>
 <41239f06-596e-4c17-95ed-4bf06ba9f9ec@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41239f06-596e-4c17-95ed-4bf06ba9f9ec@moroto.mountain>

On Thu, Mar 14, 2024 at 10:37:29AM +0300, Dan Carpenter wrote:
> On Wed, Mar 13, 2024 at 07:32:20PM -0700, Alison Schofield wrote:
> > On Wed, Mar 13, 2024 at 11:51:22PM +0530, Ayush Tiwari wrote:
> > > This patch adds descriptive comment to mutex within the struct
> > > gbaudio_codec_info to clarify its intended use and to address
> > > checkpatch checks.
> > 
> > Hi Ayush-
> > 
> > You may be right, but you need to convince your patch reviewers
> > why your comment accurately describes this mutex.
> > 
> > That's always the ask with this kind of patch.
> 
> Heh.  Yeah.  The comment wasn't right in this case.  The lock has
> nothing to do with registers or register access.
> 
> > 
> > BTW - Don't start your commit log with 'This patch...'.
> > 
> 
> Outreachy folk are a more particular about some of this stuff than I am.
> Which is fine.  Could you do me a favor though?  Could you ack patches
> once you're happy with them?

Dan -
Sure. In practice, the patches are often 'Reviewed-by' someone else
by the time I get back around to it (thanks to the different time
zones and plentiful reviewers) But I understand, I'll make it a 
habit of at Ack'ing after I've asked for something to change.
Alison


> 
> regards,
> dan carpenter
> 

