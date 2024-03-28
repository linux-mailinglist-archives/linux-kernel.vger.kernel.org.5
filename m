Return-Path: <linux-kernel+bounces-123790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC67890DD7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76021C28979
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CED40875;
	Thu, 28 Mar 2024 22:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n0sYZ3f0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82C43FBA1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711666295; cv=none; b=mzDtCM0/6IeJN8KMeVEdcvnEnijpXZQPMPfJpbqjoCC5G0RQlC/xRQCoRYBya898kimQA3xJ2RvmFqhDD4/FaabLVVa7K8RmnkZAXJM8MB2EZPbyAes4R4EHXPCPque1H8ABhJh/VLDv7oyDtePBnbTabE74+nNesyprY7Ev4YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711666295; c=relaxed/simple;
	bh=NifpSitZFwDIGKmPZazznM78PsJ/sym0i+5/IJ4O9zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMpmhx/nM9gc2S6YA+ImS3SE4p+NpJgfdZdqwP4YObKQ1anG0lxjDr5TYbVEHXHtuPxsOyVTHA5u6NvhnejLwRwQGpYHhcrgm+QLgXVsFJ/4GW1XY86gOsNmYxQtqp2cuQytkzMk2Yif9VbNd932WV/1eMO1oLQN6LcIcuHSdSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n0sYZ3f0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711666293; x=1743202293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NifpSitZFwDIGKmPZazznM78PsJ/sym0i+5/IJ4O9zU=;
  b=n0sYZ3f0sTTxY7V6IoyJib78JcQzlxje71GMA0Kux/sd3drSKfpbhvdu
   zSxWfZt+9QQdEjagkf9WP/8pwVjAr4bzWzPCkoN72LtuRk0H4QHaro6W3
   yTnttylt3hHPPgS6B4cZ6GHGQ+ra0qYm59dFytjkPdOv8ysPvQk0lQM7I
   FvXXSTxEKdZJTE7n2dpKxOeKulm8mOhi2/yVpCw7OS5IAzvIFP87M8fFh
   D9SPgns4uWoVME9voLYPjmCVNJ40ST85F96ljoTJJ2UndT7eUUh+6Exq3
   O4dkq5YOsPvKrlRr3cwc2H4v97+oyl+rgDpy9AEQZ/6tC7CGi2qHl2jiI
   w==;
X-CSE-ConnectionGUID: uR67kKMISaevaN18LztdJw==
X-CSE-MsgGUID: jvdUqBfjR5+uzD0UTOHOVA==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="32252377"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="32252377"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 15:51:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16839134"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.99.22])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 15:51:33 -0700
Date: Thu, 28 Mar 2024 15:51:31 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: TaheraFahimi <fahimitahera@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: gdm724x: Align descendant argument to the open
 parenthesis
Message-ID: <ZgX0c7mTJkipSkmQ@aschofie-mobl2>
References: <ZgXupx0nXwIOjy7F@tahera-OptiPlex-5000>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgXupx0nXwIOjy7F@tahera-OptiPlex-5000>

On Thu, Mar 28, 2024 at 04:26:47PM -0600, TaheraFahimi wrote:
> Mute the following checkpatch error:
> 	CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>

Tahera,

I'm seeing this from checkpatch:

WARNING: From:/Signed-off-by: email name mismatch: 'From: TaheraFahimi <fahimitahera@gmail.com>' != 'Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>'

Folks sometimes miss checkpatch reports if they only run checkpatch
on their head commit. Please run it on the formatted patch before
sending it.  

Please refer to checkpatch documentation, but if it's useful, here's
what I do:

While developing a patch do this:
$ git show HEAD | scripts/checkpatch.pl --strict --codespell

Confirm with this before sending a patch to a mailing list:
$ scripts/checkpatch.pl --no-tree --strict --codespell $1
($1 is the formatted patch and that location is usually out of tree
in my development environment.)

--Alison

> ---
>  drivers/staging/gdm724x/gdm_tty.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> index 15c246d3b1a3..bd80cd48fb44 100644
> --- a/drivers/staging/gdm724x/gdm_tty.c
> +++ b/drivers/staging/gdm724x/gdm_tty.c
> @@ -272,8 +272,8 @@ int register_lte_tty_driver(void)
>  	int ret;
>  
>  	for (i = 0; i < TTY_MAX_COUNT; i++) {
> -		tty_driver = tty_alloc_driver(GDM_TTY_MINOR,
> -				TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
> +		tty_driver = tty_alloc_driver(GDM_TTY_MINOR, TTY_DRIVER_REAL_RAW |
> +						TTY_DRIVER_DYNAMIC_DEV);
>  		if (IS_ERR(tty_driver))
>  			return PTR_ERR(tty_driver);
>  
> -- 
> 2.34.1
> 
> 

