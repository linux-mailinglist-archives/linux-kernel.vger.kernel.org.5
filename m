Return-Path: <linux-kernel+bounces-100466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B208797DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C581F22A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648457D073;
	Tue, 12 Mar 2024 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LUIH071w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618177CF10;
	Tue, 12 Mar 2024 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258188; cv=none; b=h0Ax0VHw7h7GWvBOoo+dyRnQdAZz+HmyvsSpPxVM4uZkm48AsK/zayRHdIvnRm39qJyceYiLxktSAuRnqZMOUg8AGM/1D/8U0vTgIkNay2wwtDFVto//PlUPMxzkvGhAMu4hfu0Y6Y067jccdGuqSN2pAeYdI8ut2kwK4Gw1Pcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258188; c=relaxed/simple;
	bh=bZ7KFfWAgmonZ5xuDLjCI1VRdG2i0RpJPL/iyHsbdeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/I8hUo3CHofMk1MTZMBmFatu0k4c2BkUdglEIjG2ULea8/5iADJ+F1y+z8nTiaoXE2LNG4xW+dOMLiqyOqmOqXkCjMJwyvNxdYTC9Kg/bsj/s93i04hUeH2WOfIfoqvFgQdaG1ZBd4WP15yVCPvic/qwlPrl6NLEyonvnoRu2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LUIH071w; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710258188; x=1741794188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bZ7KFfWAgmonZ5xuDLjCI1VRdG2i0RpJPL/iyHsbdeM=;
  b=LUIH071wAlNjLERXfleCFJiuLaWQ9EszcCJWJwXzySVVXzm8CwwJ62FT
   YWnYHcS5j3qwwtuyZaXcjbztu9WB8ocS1qJUyqJQwyY2NKyiA4+NlKvb/
   LhPeYYOwWDyBfPy7g3SUIqjFh3y2X/2ArJY5O9mzDfvgkOhKE/trL4QAJ
   QyTglyp2Ftik0hc8TvfWV9dHtdsUye+dY/PiWBAykB8MZUsnCS0YnkyUn
   fxGGQhfYMYns1B/SB/PLNC4RiGd2NyLBj59b9cq5apDpyb5mljMpgkK9q
   cHT8R1N2UXPn66CfdHrYWsZVEYVDz3D+l1OJuMTfV37fN+0scuSbsdf6U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4839026"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4839026"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 08:43:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="914400103"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="914400103"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 08:43:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rk4HN-0000000BvuI-0qCL;
	Tue, 12 Mar 2024 17:43:01 +0200
Date: Tue, 12 Mar 2024 17:43:00 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] lib/bitmap: Fix bitmap_scatter() and bitmap_gather()
 kernel doc
Message-ID: <ZfB4BOknvWRFbn6O@smile.fi.intel.com>
References: <20240312085403.224248-1-herve.codina@bootlin.com>
 <ZfB30-rLXEnJtjrY@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfB30-rLXEnJtjrY@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 12, 2024 at 05:42:11PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 12, 2024 at 09:54:03AM +0100, Herve Codina wrote:
> > The make htmldoc command failed with the following error
> >   ... include/linux/bitmap.h:524: ERROR: Unexpected indentation.
> >   ... include/linux/bitmap.h:524: CRITICAL: Unexpected section title or transition.
> > 
> > Move the visual representation to a literal block.

..

> > This patch fixes de5f84338970 ("lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers")
> > available in net-next and linux-next
> 
> Not sure about rules of net-next, but I would add Fixes FWIW:
> 
> Fixes: de5f84338970 ("lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers")

And probably Reported-by...

-- 
With Best Regards,
Andy Shevchenko



