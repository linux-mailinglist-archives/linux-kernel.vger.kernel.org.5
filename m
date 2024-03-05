Return-Path: <linux-kernel+bounces-92548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39228872207
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D92E0B223CC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D6B126F0F;
	Tue,  5 Mar 2024 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TEPaKGFv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939166127;
	Tue,  5 Mar 2024 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650437; cv=none; b=CjjGPC1BvGLHVkWG+AIvYfMkYYk0PAziihexq8Y2Zbq9o3P6MA2wOTLNLGIRdGd0sWgCdQU3k7t6daBc2/bqh/kNQgEjyVGUTKcLMpYR5lDWP+Y+RnBMbjH3F/1uk7eHasNnhusbBJ1ugikq/TIZkQ6mbyFc3bspC44tSdAa2L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650437; c=relaxed/simple;
	bh=0dOILnGFoAvtiNpVkLvJTAajQBVZzcEdsS8kcLekRAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swzlYumg/4WPqHRVDUcDI5dKQ21E7Bbm1yMSD+YxdGI/mFwyCHR+uONLG8rgwawCkPTW3OzYU5TYgHuYBhEz8nsHo6G3/2y/zNsZhUMVCap/U7lj9ihYVbkGjDFWfWiXXWUU94VK3V6WvMVlLzmNQmnDwCkxUt2Zo4YDXLy/Sa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TEPaKGFv; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709650436; x=1741186436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0dOILnGFoAvtiNpVkLvJTAajQBVZzcEdsS8kcLekRAc=;
  b=TEPaKGFvWY0hSvQij4TZB+K3ESCJ5/d3jYP1MVe4uWN0o/yvsjmhOFJZ
   z5uTkgFHNEkss2pwJV208iGppNMKGPqVDjVZ/yjSLGItzIm/ywro1NeRT
   7mrrwkEEhE7qrBf23XOfdESRcmjG2HtXH8O2oWl0LePlkGoUgYMdCsnH1
   L7UEm7D8xWBtxZEKdPrMrXoOOCUdU3KaWa6sHAG9J8NmagEjQlmMO5P5n
   WnSotjtozsobgSlkDErGxxddfRf/ufoRlcUQfM+czA9su0WzVW+KKXMwe
   AJZsGrCmDywPRmzL3RC3Xm9hcTVfA3vxSdaL7ueIjl2HMw8rHiltQgGy9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="29628512"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="29628512"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 06:53:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="914142173"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="914142173"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 06:53:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rhWAt-0000000A0d6-1ywE;
	Tue, 05 Mar 2024 16:53:47 +0200
Date: Tue, 5 Mar 2024 16:53:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 0/5] Add support for QMC HDLC
Message-ID: <Zecx-3mbOtb33DdB@smile.fi.intel.com>
References: <20240229141554.836867-1-herve.codina@bootlin.com>
 <ZeChdAsAhrC8a75t@smile.fi.intel.com>
 <20240305120226.791bfe9a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305120226.791bfe9a@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 05, 2024 at 12:02:26PM +0100, Herve Codina wrote:
> On Thu, 29 Feb 2024 17:23:32 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

..

> > I think it's a good series and next version will be final. The only question is
> > possible use of the returned values from bitmap_scatter()/bitmap_gather(), the
> > rest are minors.
> 
> I replied about the reason why I didn't return any values from
> bitmap_{scatter,gather}() in that patch 4 discussion.
> 
> Are you ok to keep them returning void in this series ?

Sure. We can amend that later if needed.

-- 
With Best Regards,
Andy Shevchenko



