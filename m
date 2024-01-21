Return-Path: <linux-kernel+bounces-32061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DC28355E1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 13:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152D41C21D01
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EE0376F1;
	Sun, 21 Jan 2024 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBpyWGfb"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CD83716E;
	Sun, 21 Jan 2024 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705841811; cv=none; b=GZxp60OiFKAk5j6n3/rMo2gCASoORQr+inf2+s1dWql6XltQ5R3+t5EJVnbaO1BnOY+gUHsts2ZsDARaP0HDf2VlO8KUY2NIxRNSkXuJl0g1hUEOtAp1ZhzhOslf8/JKJt2Nbhbl57JcO7bDQSHKSi8IHvx6OmUouXze/ALxTzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705841811; c=relaxed/simple;
	bh=krG9LXAznvLj3HPa2eHD/ERGmtdaJKuLzRsIybPzik0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QG1JIQJqNly+Sz7kPLymxd/OX4Y2nDsgGw2QCy5dv0vPLofd3CsZOGyReB/7LzmpmTAmjvUlUvCnaWAljMuoehF+HeZmSw48tHZEYXXXs8k/hhR3NE0l+T/8/gMu7rt5pRE6sfaOM6w2sYxtXZzxYK9/wCI9oWNX35PmjPWstbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBpyWGfb; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705841810; x=1737377810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=krG9LXAznvLj3HPa2eHD/ERGmtdaJKuLzRsIybPzik0=;
  b=DBpyWGfbaVvuay5XWDjZRyG7/cSkLwd5cNfEENYh3SMuS7JWjiVpXkj3
   +ZKHTgpg+89fUP4PmQXgxLNHYrL6Z10INEfCxyLo8ALk/C1NwZuGty2YR
   pL2h3FMi4DR124+od7hWW3KP6WMQxJ2A8WNl/TnzgFIIUsJFRNsGKeVJ/
   b4lVPB3/bYgb1faTWu+IEdCxfS68rBtAliaG6KblRDVO564T9Qpo4TTdn
   rVo+vjHcvZJFeMwb01caDohRGzLZqMDqN2vEOKpTwz/jIV5ll/mzvGE80
   c513jFbUTiTomGnVut9mAGPRq/ny6xqIXLN/gK1pZr/WCreCpYcHzseVs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="398185482"
X-IronPort-AV: E=Sophos;i="6.05,209,1701158400"; 
   d="scan'208";a="398185482"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 04:56:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="875746396"
X-IronPort-AV: E=Sophos;i="6.05,209,1701158400"; 
   d="scan'208";a="875746396"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 04:56:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rRX8j-0000000Fcgz-2pRz;
	Sun, 21 Jan 2024 14:41:29 +0200
Date: Sun, 21 Jan 2024 14:41:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] firmware: coreboot: Generate aliases for coreboot
 modules
Message-ID: <Za0Q-em5R2_9cX7q@smile.fi.intel.com>
References: <20240111151226.842603-1-nfraprado@collabora.com>
 <20240111151226.842603-3-nfraprado@collabora.com>
 <ZaQU_QqGXwkSgU_Y@smile.fi.intel.com>
 <49b42da1-a74b-433c-b018-0742f850f680@notapiano>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49b42da1-a74b-433c-b018-0742f850f680@notapiano>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jan 17, 2024 at 09:53:23AM -0300, Nícolas F. R. A. Prado wrote:
> On Sun, Jan 14, 2024 at 07:08:13PM +0200, Andy Shevchenko wrote:
> > On Thu, Jan 11, 2024 at 12:11:47PM -0300, Nícolas F. R. A. Prado wrote:
> > > Generate aliases for coreboot modules to allow automatic module probing.

..

> > > +/**
> > > + * struct coreboot_device_id - Identifies a coreboot table entry
> > > + * @tag: tag ID
> > > + */
> > > +struct coreboot_device_id {
> > > +	__u32 tag;
> > > +};
> > 
> > Don't you want to have a driver data or so associated with this?
> 
> There's no need for it currently in any driver. This struct is being created
> simply to allow auto modprobe. So it seems reasonable to leave it out and add it
> later when/if needed.

The problem is that you introduce a kinda ABI here, how do you handle this later?

-- 
With Best Regards,
Andy Shevchenko



