Return-Path: <linux-kernel+bounces-49917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2600B847160
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517DE1C221A0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13624779F;
	Fri,  2 Feb 2024 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7aPhw6y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D376146551;
	Fri,  2 Feb 2024 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706881740; cv=none; b=nCje9GNEqeruUbbFh4lmU6s+a7J/k1bYbzoaVG+h1GxHFcgYAQgUZRdjGIok/rHha/o/kmGV/+1yCAg98u5JXWqgOvX6af6V6C7R8B269QqJghF6WU0Zp9mUvuPGOwI3doJvsvE21HSF4xSFxrvFS5iBdhBJYnY4NO+fKOgqEAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706881740; c=relaxed/simple;
	bh=5oAxVFemPM8II0r20k3cx2T21LfwQLuEcMKNm4dSXFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0JgRo1Y8v9tVUeVEUH1oO0r8uTXkVpWQDAeyZDSQHwZUMWkQSEPRHE3Y3XrjM1ukT1Llg/ausICyJa5A5klSQ0smFu9eb0ABgAB3bBz9bOSd+uTsZ0UXQkHrOD7yhg3RZd7VmEkUMJW3J2hwodHwwpZXaVNtwx231GeZaEaUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7aPhw6y; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706881738; x=1738417738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5oAxVFemPM8II0r20k3cx2T21LfwQLuEcMKNm4dSXFg=;
  b=Y7aPhw6yNCEGwNXNgBD5URHq2mPH4UMmAqSflRn1Xeb0JbJI8qYWAj1x
   kiIdqJnRdEh/HRIJ9T1NH+zthAT6rdqTnRKCwc0PGzo3Zo9E5kz58JbEf
   INqIVJoNAFKEgPW1OwoLTTi4gJ3UMzHiEhLkOPXCYE+81bD4Fhs9UUHjW
   abGpZJcs0MIHPGMKCCU5UQvgEUxAB8KH2tIR7L7+oTgWOSZvFiR3k2T0d
   y+HC0Gl0Q9KuX2VP3X7Ft9KholcQJeS1y0flrd3sNthbXl6E+yOC9ozUL
   XMyxgL+KhCm5guI/aZ5ZZChNJQGOxXF2XwsiRq+bBYbMzm8agfMlNsFaF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="4059836"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4059836"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 05:48:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="908579982"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="908579982"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 05:48:55 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 7BCCC1205FA;
	Fri,  2 Feb 2024 15:41:30 +0200 (EET)
Date: Fri, 2 Feb 2024 13:41:30 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: [PATCH 1/1] media: v4l: Fix link frequency helper's kernel-doc
Message-ID: <ZbzxCpxVa8ciu1Wn@kekkonen.localdomain>
References: <20240202145412.336db5b2@canb.auug.org.au>
 <20240202064007.50545-1-sakari.ailus@linux.intel.com>
 <20240202143027.21fe3f5b@coco.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202143027.21fe3f5b@coco.lan>

Hi Mauro,

On Fri, Feb 02, 2024 at 02:30:27PM +0100, Mauro Carvalho Chehab wrote:
> Em Fri,  2 Feb 2024 08:40:07 +0200
> Sakari Ailus <sakari.ailus@linux.intel.com> escreveu:
> 
> > Fix kernel-doc indentation for v4l2_link_freq_to_bitmap().
> > 
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Fixes: a68e88e2cf9e ("media: v4l: Add a helper for setting up link-frequencies control")
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> > Thanks for reporting this, Stephen.
> > 
> >  include/media/v4l2-common.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/media/v4l2-common.h b/include/media/v4l2-common.h
> > index cd2163f24f8a..602738f7741e 100644
> > --- a/include/media/v4l2-common.h
> > +++ b/include/media/v4l2-common.h
> > @@ -563,7 +563,7 @@ u32 v4l2_fraction_to_interval(u32 numerator, u32 denominator);
> >   * Return values:
> >   *	0: Success
> >   *	-ENOENT: No match found between driver-supported link frequencies and
> > - *		 those available in firmware.
> > + *	those available in firmware.
> >   *	-ENODATA: No link frequencies were specified in firmware.
> >   */
> >  int v4l2_link_freq_to_bitmap(struct device *dev, const u64 *fw_link_freqs,
> 
> This won't do what's expected at documentation, as Sphinx will just
> fold everything into a single paragraph, like:
> 
> 	"0: Success -ENOENT: No match found between driver-supported link frequencies and those available in firmware. -ENODATA: No link frequencies were specified in firmware."
> 
> Maybe you could try using (untested):
> 
> 
> 	* Return values:
>         *
> 	* * 0: success
> 	* * -ENOENT: No match found between driver-supported link frequencies and
> 	*     those available in firmware.
>         * * - ENODATA: No link frequencies were specified in firmware.
> 
> Please test it and see if the "make htmldocs" output will be what it would
> be expected.

Hans separately submitted a patch to address this better, it's here:

<URL:https://lore.kernel.org/linux-media/ZbysG-sUu9jf3fwQ@kekkonen.localdomain/T/#t>

So this one can be ignored.

-- 
Regards,

Sakari Ailus

