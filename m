Return-Path: <linux-kernel+bounces-88137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4292986DDCA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5BB41F230FC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C647D6A33A;
	Fri,  1 Mar 2024 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EecX3Ws6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFB767E7A;
	Fri,  1 Mar 2024 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283769; cv=none; b=lZR0jqgnECyZ46vd+51yWAJNQ/4WngMjPOxHxd2PJQShOA5u9gwLp2uoopEq9BgAQ6odovPj7Tgnsoo7yzeY4gu+ULNFvPMXaEpOWYvhLwtvhyts8fOJGAqFJHFNoNXB6Uwl9yGOjY4wAdDklnLN3rZov/R8rpBa4lvPY8PXcYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283769; c=relaxed/simple;
	bh=rg/9tIV+l6rkm6nBFZtaGTD9o47J4VCrowIfSPkATgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSVyY1eL/cmjO0hftSXCdHX/XZK4DlbPU/89FbK0GEaHScNwifanZect9Unx7c73fF7FlLDBErskBlXI8yHkVZ17CaHGPSzmuTtczAmcM6QuvCM+GXFaj4MT71slixH6I96Nxd9O5F93yFTz9W7XDoo4HMXrt+2ZT2Fi/4+ZCdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EecX3Ws6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709283768; x=1740819768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rg/9tIV+l6rkm6nBFZtaGTD9o47J4VCrowIfSPkATgw=;
  b=EecX3Ws6lW1uJpBxuBmm09vDErzA+OQNFPSUETeRoL7OA/Sr7UYSiPwM
   pfnrB9d0ejgAbV4moq2gzNODaWsNoa1KSOIHceej/TfqTc/Y4qvwPF5fH
   nw32wytvNI9qNCDZJFR+9JS2y3N382a93kHfvNJXaJATuKonl0KhL0WM1
   CYqq5DZ1CgMvrQmq5LGJwzr5ZWL0sk1VGOiYhpTlGA8n/oZc+O6JbfNMN
   3C3sXMfU0hQcePMKEz7nNe6aOinZG12BR5pfqlcpbEaPoDFeHryFR8ngn
   lO53sVt0IaM+MEhNGRfGuC/9V2R17yVDb3RRMcqeITsEIbYuam2vDq5ik
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="15223600"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="15223600"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 01:02:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="39156675"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 01:02:44 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 60C9511F811;
	Fri,  1 Mar 2024 11:02:41 +0200 (EET)
Date: Fri, 1 Mar 2024 09:02:41 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-media@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: i2c: ds90ub960: Delete duplicate source code in
 ub960_parse_dt_rxports()
Message-ID: <ZeGZsRtH6YLx2FiM@kekkonen.localdomain>
References: <79fa4854-976d-4aad-86ac-c156b0c4937e@web.de>
 <ZeGV_siWFkfqSEgZ@kekkonen.localdomain>
 <db1d7227-f9a4-42fa-89ba-b484e1260e0b@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db1d7227-f9a4-42fa-89ba-b484e1260e0b@ideasonboard.com>

Huomenta,

On Fri, Mar 01, 2024 at 10:49:19AM +0200, Tomi Valkeinen wrote:
> Hi,
> 
> On 01/03/2024 10:46, Sakari Ailus wrote:
> > Hi Markus,
> > 
> > On Fri, Mar 01, 2024 at 08:46:25AM +0100, Markus Elfring wrote:
> > > From: Markus Elfring <elfring@users.sourceforge.net>
> > > Date: Fri, 1 Mar 2024 08:23:24 +0100
> > > 
> > > Avoid the specification of a duplicate fwnode_handle_put() call
> > > in this function implementation.
> > > 
> > > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > > ---
> > >   drivers/media/i2c/ds90ub960.c | 5 +----
> > >   1 file changed, 1 insertion(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/media/i2c/ds90ub960.c b/drivers/media/i2c/ds90ub960.c
> > > index ffe5f25f8647..eb708ed7b56e 100644
> > > --- a/drivers/media/i2c/ds90ub960.c
> > > +++ b/drivers/media/i2c/ds90ub960.c
> > > @@ -3486,10 +3486,7 @@ static int ub960_parse_dt_rxports(struct ub960_data *priv)
> > >   		}
> > >   	}
> > > 
> > > -	fwnode_handle_put(links_fwnode);
> > > -
> > > -	return 0;
> > > -
> > > +	ret = 0;
> > 
> > I think it'd be nicer to initialise ret as zero, then you can just drop the
> > assignment above.
> 
> I don't like successful execution entering error paths. That's why there's
> the return 0.

It could be called a common cleanup path as what you really want to do here
is to put the fwnode handle, independently of whether there was an error.
I think the current code is of course fine, too.

Soon you can do

	struct fwnode_handle *links_fwnode __free(fwnode_handle);

and forget about putting it (but you must need putting it).

-- 
Terveisin,

Sakari Ailus

