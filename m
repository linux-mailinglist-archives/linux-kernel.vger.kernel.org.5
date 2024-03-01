Return-Path: <linux-kernel+bounces-88847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1151986E76D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239C71C2094A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE322575F;
	Fri,  1 Mar 2024 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eNjJPaaE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0490E8C17;
	Fri,  1 Mar 2024 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314584; cv=none; b=ayHEeZFRKSm2Z29uOwDCo887p6tKW/eLOYY4xNHAyZQ63jz64/q7/0t0NdY6WEbW528WXvTgz/nxtQy5LEUO582DxlNJA4oQ/TRi4O5dQr9LioOLiNwk/MXiBxnVxCp2XFOJyYhGaaCDFNeItPL0vrVtTXcXvf5ETofnE01a2Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314584; c=relaxed/simple;
	bh=BLPKOOcms3NtQtohwHJmJbLW39B8h2SU5IMAJvs5Bio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4jB1R1gN1mCtvPeV3r9XULGyvvv9eRD81vZwFvkLwWdYyvbjwOE7NruLbdgoNGjn5c+ghhZOHpN3KhWjS8BrIeyqIWoDyPJz+VI0CttiqKBfbDP8lQWFEyZNUhVbXU6IxzaWHjZRZZKd8tjaUd53VHWVHuBExH6CNq8pPI4irc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eNjJPaaE; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709314583; x=1740850583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BLPKOOcms3NtQtohwHJmJbLW39B8h2SU5IMAJvs5Bio=;
  b=eNjJPaaEmbg5eU4PYKJXt7RlYuL7t1g+L3qcnQS+9F0xAIrrrsHwEr8I
   vQ8TQ6/uB11yIz/EXdgKbUfM7y2QojghqM4jbSjPZ4n+DqoMDZ7k+65lm
   IdSpIVfMPaOpDrIIHG1Co0m76FDjymFtmt26sddYUey1xsOpCP0eWSRh5
   wgBb+oN9pNuEcpYRF/tc9Hck558u/4KVXMAFpmkxZvebmizfcODDsYbXd
   WRHs0CKQpPwodKKPd44dsS8hABDQpi7+LtYoZu3ZlVuSChydInifL50ii
   W3uxM5oQXtnoEAcksl4AKE+gX0ER//JzlSHDCXZOaxJnDXr52LZ+OuwOa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3724003"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="3724003"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 09:36:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="914021132"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="914021132"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 09:36:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rg6nx-00000009168-3emF;
	Fri, 01 Mar 2024 19:36:17 +0200
Date: Fri, 1 Mar 2024 19:36:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Markus Elfring <Markus.Elfring@web.de>, linux-media@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: i2c: ds90ub960: Delete duplicate source code in
 ub960_parse_dt_rxports()
Message-ID: <ZeISEYXTaiyA-b4K@smile.fi.intel.com>
References: <79fa4854-976d-4aad-86ac-c156b0c4937e@web.de>
 <ZeGV_siWFkfqSEgZ@kekkonen.localdomain>
 <db1d7227-f9a4-42fa-89ba-b484e1260e0b@ideasonboard.com>
 <ZeGZsRtH6YLx2FiM@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeGZsRtH6YLx2FiM@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 01, 2024 at 09:02:41AM +0000, Sakari Ailus wrote:
> On Fri, Mar 01, 2024 at 10:49:19AM +0200, Tomi Valkeinen wrote:
> > On 01/03/2024 10:46, Sakari Ailus wrote:
> > > On Fri, Mar 01, 2024 at 08:46:25AM +0100, Markus Elfring wrote:
> > > > From: Markus Elfring <elfring@users.sourceforge.net>
> > > > Date: Fri, 1 Mar 2024 08:23:24 +0100
> > > > 
> > > > Avoid the specification of a duplicate fwnode_handle_put() call
> > > > in this function implementation.
> > > > 
> > > > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > > > ---
> > > >   drivers/media/i2c/ds90ub960.c | 5 +----
> > > >   1 file changed, 1 insertion(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/media/i2c/ds90ub960.c b/drivers/media/i2c/ds90ub960.c
> > > > index ffe5f25f8647..eb708ed7b56e 100644
> > > > --- a/drivers/media/i2c/ds90ub960.c
> > > > +++ b/drivers/media/i2c/ds90ub960.c
> > > > @@ -3486,10 +3486,7 @@ static int ub960_parse_dt_rxports(struct ub960_data *priv)
> > > >   		}
> > > >   	}
> > > > 
> > > > -	fwnode_handle_put(links_fwnode);
> > > > -
> > > > -	return 0;
> > > > -
> > > > +	ret = 0;
> > > 
> > > I think it'd be nicer to initialise ret as zero, then you can just drop the
> > > assignment above.

I think tearing apart the assignment and its actual user is not good.

> > I don't like successful execution entering error paths. That's why there's
> > the return 0.
> 
> It could be called a common cleanup path as what you really want to do here
> is to put the fwnode handle, independently of whether there was an error.
> I think the current code is of course fine, too.
> 
> Soon you can do
> 
> 	struct fwnode_handle *links_fwnode __free(fwnode_handle);
> 
> and forget about putting it (but you must need putting it).

Let's wait for the Jonathan's patches to land (v6.9-rc1 I hope) and then
we may modify drivers if needed.

-- 
With Best Regards,
Andy Shevchenko



