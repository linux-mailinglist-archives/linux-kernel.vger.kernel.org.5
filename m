Return-Path: <linux-kernel+bounces-81696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FC9867927
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0468328F658
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065BB145334;
	Mon, 26 Feb 2024 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6rrwwPH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67491420DF;
	Mon, 26 Feb 2024 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958240; cv=none; b=aesMy1QjzRTFW1pD025NyKrunwINcxv4XKOjljFO/4ZjJmo7WbFy/qAiGgE/jpYVgI5qIqIdADaRua7tU6UtBFbJcndgN11iWue0lZ9Cu1x801Dvf0TrxQboy4AyaxhKZn94HJec+k8FZrXt8hXW9kcP82Wa0IdHKcH32pnns80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958240; c=relaxed/simple;
	bh=ASCStbbadCwY+pa29PI3g+LnHSlVBBJ8vQnqpkE72ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2QLn+hb5qVc2yeaxoWD4imMprYdXjN0h1rp5RmS8n6FsJBPYI+KhhrZdMk2BaHia4lma6zurUAwlDepSimoxcQZ1QQ/WjgqLKazVp3ZyamtjzgSC0IafAsYMWxq7aAEWYr5bkwgFMGRAtZ29dQGXJtX+tTmP9eRl8lWPNTAm3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6rrwwPH; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708958239; x=1740494239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ASCStbbadCwY+pa29PI3g+LnHSlVBBJ8vQnqpkE72ek=;
  b=d6rrwwPHuqLetuP0Cu7WrLeAP+Psw6X2HTuXUBVOy3InMSUYvPP2ppv/
   8Eo5TAlrg9bi4ilegrx17SgX1IoiPa5GrfeExTmQouhwD234RVTig+VgL
   A96WmMoDtfm+XM1kevn2eXsmjUBR96hVbpUCXk6GFGnvU2kxzIbkxsYBG
   9IQTh2Q0wdrgZxM0KVtGcgvFOG3LGdm88w9PsthlGKZdn3HGYE+1aUc6q
   j/INP22U16CS6k4WWo2ltYSSmXxS5wTNSSA1JkMiidCTNNu+ZITCqxHbT
   2NovjvwxfB19i1BxEolcUdi1ul9Kt90eLFzytE1AcFVwGcWAAyokAkctc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14680281"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="14680281"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:37:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="913873542"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="913873542"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:37:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rec6T-00000007hmJ-1Rj4;
	Mon, 26 Feb 2024 16:37:13 +0200
Date: Mon, 26 Feb 2024 16:37:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mike Looijmans <mike.looijmans@topic.nl>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ti-ads1298: Fix error code in probe()
Message-ID: <ZdyiGV1vKFMoC2DL@smile.fi.intel.com>
References: <5f393a87-ca8b-4e68-a6f4-a79f75a91ccb@moroto.mountain>
 <e315c126-619c-48a1-a5d8-001e5ed01930@topic.nl>
 <20240224181354.76842da7@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224181354.76842da7@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Feb 24, 2024 at 06:13:54PM +0000, Jonathan Cameron wrote:
> On Thu, 22 Feb 2024 08:10:25 +0100
> Mike Looijmans <mike.looijmans@topic.nl> wrote:
> 
> > Good catch on both patches.
> > 
> > If so desired, you have my
> > 
> > Acked-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> Dan, here is a classic example of why I think any series with more than
> 1 patch could benefit from a cover letter. It gives somewhere for
> reviewers to give tags for the lot in a fashion b4 can understand.
> 
> Otherwise great find and applied to the togreg branch of iio.git
> with Mike's tag added to both of them!  Hopefully the fixes tags will
> remain stable - whilst in theory that tree doesn't get rebased, in practice
> it might if I messed anything up enough :( 

I even added this to be automatically done when I use my script [1].
Dunno if b4 relay (or what is there to send patch series?) can handle
that.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko



