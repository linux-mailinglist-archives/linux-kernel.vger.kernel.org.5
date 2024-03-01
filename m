Return-Path: <linux-kernel+bounces-88109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A020286DD6D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D400282A1A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A1C6A01C;
	Fri,  1 Mar 2024 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VDJTUczH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BC21D6BD;
	Fri,  1 Mar 2024 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282822; cv=none; b=bqHPNbzyIXpCQK18A+265GdHepKZ7hLudibT6242ruvZ9tHES4iphWGPtauzlubohd2i1/bMs8pirikMa9gOiPKpc0gC9SqIlKps77bj/rzPzgBxHgyAGyOwphTJ9ZYXmXfNFP1tdt1MXSQl38JJWx48gTvyH6P+qgWIRKpi2I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282822; c=relaxed/simple;
	bh=mBL8PGXV/JmsDTo9f1jc418xkycUcDbyqjWYl05TJoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lH8U7fp0C5Om56taIIfkiF/8trQ1Fu/rPeOY6tpMN6o5Mhiacd73Wwctoph1w0rPn2EaVY3ZXhrxQflpSl/HczA4vsSMITkfpJVba3MC589DlGhoPMD1Y/vzdmFjZqp1BrVPO1iOKufjZiaKPCZvzyvfEB++84RL5wH+0nBzanY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VDJTUczH; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709282821; x=1740818821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mBL8PGXV/JmsDTo9f1jc418xkycUcDbyqjWYl05TJoY=;
  b=VDJTUczHd55h2tHmNZgRBOhNbCXfL50NcYIDYz0LtN7gGKk5ob6d98qY
   ASn2o++ia8fAkZo77Z+AZ6uRkza7pf4dDU4d7pNLx2rcplQ88WQGnyuC9
   s1Uca1t6yG2HmWfDepd1b5FoMLBIUzaaJFY5karCg8XxbJB2KpSd3exCK
   0HgY+8JslXdnn2fyaoO7ZBVz34wI5csbT3TICdlp4rUSPSaknlzO1o1ZK
   2/A+nQQDkXCKiifOxx5IjVfQ6l9VzIILHoN7xTfw6O2K2a3b8+Wi5Ly41
   9Glc3d0n4yB8EixCjYMBurgTQ50fH4m8UzFGVWMcTZaNIGPidXs2nh4YI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="6760270"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="6760270"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 00:47:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="12814752"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 00:46:58 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id C8A0911F811;
	Fri,  1 Mar 2024 10:46:54 +0200 (EET)
Date: Fri, 1 Mar 2024 08:46:54 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: i2c: ds90ub960: Delete duplicate source code in
 ub960_parse_dt_rxports()
Message-ID: <ZeGV_siWFkfqSEgZ@kekkonen.localdomain>
References: <79fa4854-976d-4aad-86ac-c156b0c4937e@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79fa4854-976d-4aad-86ac-c156b0c4937e@web.de>

Hi Markus,

On Fri, Mar 01, 2024 at 08:46:25AM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 1 Mar 2024 08:23:24 +0100
> 
> Avoid the specification of a duplicate fwnode_handle_put() call
> in this function implementation.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/media/i2c/ds90ub960.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/media/i2c/ds90ub960.c b/drivers/media/i2c/ds90ub960.c
> index ffe5f25f8647..eb708ed7b56e 100644
> --- a/drivers/media/i2c/ds90ub960.c
> +++ b/drivers/media/i2c/ds90ub960.c
> @@ -3486,10 +3486,7 @@ static int ub960_parse_dt_rxports(struct ub960_data *priv)
>  		}
>  	}
> 
> -	fwnode_handle_put(links_fwnode);
> -
> -	return 0;
> -
> +	ret = 0;

I think it'd be nicer to initialise ret as zero, then you can just drop the
assignment above.

>  err_put_links:
>  	fwnode_handle_put(links_fwnode);
> 

-- 
Regards,

Sakari Ailus

