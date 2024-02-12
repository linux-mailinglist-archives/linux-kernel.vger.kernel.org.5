Return-Path: <linux-kernel+bounces-61289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E207F851067
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205F31C21A97
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198A4182AF;
	Mon, 12 Feb 2024 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nE+DVXHz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C581804A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707732901; cv=none; b=TLI3mbmwVpAAQjsd1EatC8zzPAN1GNij7MFDR/f7bt8dcvDygz1s14dyzKDMQc1dt4TPltLHfmbWwYtYGenF78lj69wltz1wE5mZFTqeYRCR7P1zXvhnk2E5/zUBYAUQMXfY8eEx9CJ/6hRrljNe7CL3MILyGoRsU2DbdRF5Ess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707732901; c=relaxed/simple;
	bh=CWJ/MFKYCbhsiN64n9KR0XkaQPc+SgsXxhtc0auXCr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEt8WeY/AFTnRMsAosJNIaqKOrtshqivDF5T2EvD8yyobIABlNebYRlCsH9U5rAuels8vMZAB/ve02B6MfezmG3M5I+1tYxBiKdqsY/ydbUVPd2YY6forkvbAzjl7cLcc23XrX0yOqItYry9QIQBoZGqy8nXTnDKLeuCOkGLAOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nE+DVXHz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707732900; x=1739268900;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CWJ/MFKYCbhsiN64n9KR0XkaQPc+SgsXxhtc0auXCr8=;
  b=nE+DVXHzps/VRoK27Jn4qfmptD5jEhIyraKyVHj0YMksGUqQv9C/UBqq
   qJh+a1894bpUPJVI/hTLsp1OhJUUNZeXUOeVqaWvk+lU7cmaaBIDHEDLg
   E+EHVa20Cr91SkZIbxmtYpa7NH8EiRklM4GDc5EWPSUt2NO/s0iTrsQZa
   TaQVtVe+n7Vx71bugHLZYbIeqysPOiVlbKHIXGpIZ/Jx0/Ed17K/3oTh3
   kzFODS+KhvF8FFZJvBxddZjLeysOaBdl8TpwYiYZLlR5DZnGsJ11dfFp7
   /m3AEeUOsu5KTL2qMSjgqyharqAOVMVBTTkZt3+Nxk1pu3+DeEZ9FzNok
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="5540883"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="5540883"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 02:15:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="40008328"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 02:14:58 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id DED7D11F86A;
	Mon, 12 Feb 2024 12:14:54 +0200 (EET)
Date: Mon, 12 Feb 2024 10:14:54 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Wentong Wu <wentong.wu@intel.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] mei: vsc: Assign pinfo fields in variable declaration
Message-ID: <ZcnvnjAYDTRcNBFm@kekkonen.localdomain>
References: <20240212094618.344921-1-sakari.ailus@linux.intel.com>
 <20240212094618.344921-4-sakari.ailus@linux.intel.com>
 <2024021210-freeway-unblessed-d966@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021210-freeway-unblessed-d966@gregkh>

Hi Greg,

Thanks for the review.

On Mon, Feb 12, 2024 at 11:02:04AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Feb 12, 2024 at 11:46:18AM +0200, Sakari Ailus wrote:
> > Assign all possible fields of pinfo in variable declaration, instead of
> > just zeroing it there.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/misc/mei/vsc-tp.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
> > index 200af14490d7..1eda2860f63b 100644
> > --- a/drivers/misc/mei/vsc-tp.c
> > +++ b/drivers/misc/mei/vsc-tp.c
> > @@ -447,11 +447,16 @@ static int vsc_tp_match_any(struct acpi_device *adev, void *data)
> >  
> >  static int vsc_tp_probe(struct spi_device *spi)
> >  {
> > -	struct platform_device_info pinfo = { 0 };
> > +	struct vsc_tp *tp;
> > +	struct platform_device_info pinfo = {
> > +		.name = "intel_vsc",
> > +		.data = &tp,
> > +		.size_data = sizeof(tp),
> > +		.id = PLATFORM_DEVID_NONE,
> > +	};
> 
> But now you have potential stack data in the structure for the fields
> that you aren't assigning here, right?  Is that acceptable, or will it
> leak somewhere?

Hmm. I'm not quite sure what you mean.

The patch changes where the fields are assigned but the variable is only
used when the assignment is done in any case, so this doesn't change
anything.

> 
> This is why we generally do not do this type of style.  So unless you
> are fixing an issue here, please don't do it.

The only caveat in initialising a struct is that the possible holes due to
ABI aren't initialised, which generally is a concern with UAPI or network
(i.e. not here, and the patch doesn't change that anyway).

-- 
Regards,

Sakari Ailus

