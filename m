Return-Path: <linux-kernel+bounces-78983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 832F0861BAC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7DF1C20B13
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7870F10A33;
	Fri, 23 Feb 2024 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bb9woXN1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4E14A00
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 18:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708713154; cv=none; b=ZSOT3kUq9lk9AL1Tdwxm1w+T2r8uefUoPO9ikVO32fCIESe2iUuRAQ5DRKXC2ae6iiqOKKsjimsL9Fch2DlvXsHvzE6lleVF/e1iMlr4APP3WHvaNDqAqCFhptJAO6VZcpK+QJO3hBCmTV9qFWcY1qoln7rO9Fh3sqPO+GhdIoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708713154; c=relaxed/simple;
	bh=CrtaOL50aGokRIFP8Xi9mClwNApwI/04qRj31Y+3gjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcjIrGx1p0BYQF//ps6aLBDJvGrbLLhVKQSsYfMjA547xBD89awmgV5VgdaQxf4JBszrtNHX0v7UTt0WsbWF0Q8G5oQ0IPIYSc/s6TwKOFCYsYgrIM80DZXLSJgWa1PNNC840birwBZ2J+Mce5hw/8sIcwT5ZRAB8GBDlMu+RV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bb9woXN1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708713152; x=1740249152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CrtaOL50aGokRIFP8Xi9mClwNApwI/04qRj31Y+3gjU=;
  b=bb9woXN1v4WVex5ZoaDmZeuUJFl77oOedAJClIwvQ065d9zpSO/ymoBv
   MHHIzXXSjQ2f2lBY3cDdnvdbeBjDQYpfvEahNiNCmBaAtH4+B+I4HTD6r
   2DclH1PyXmHznaY0ZAZUpzMWAwieBFmo5iMzWg2VBySRZEi4E5kRZzHJ+
   AO4V7pieh2qwcZdSAj876zE0NgZox8y5E5hlNd1Mm9AxHppUi+GgzRGII
   Xa8DE4l2bJ15ooMoGbpo7NTmbIFXrk9dfEVBFqIu6gvTSPy8OFxoPHOeA
   fdwBTpKZjk1OMVx936R+qK5InqWVoRZAKpw6Su5wWaXRgmIVLCyrVGunB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="13605521"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="13605521"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 10:32:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="913753358"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="913753358"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 10:32:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdaLT-00000006yNy-3e4s;
	Fri, 23 Feb 2024 20:32:27 +0200
Date: Fri, 23 Feb 2024 20:32:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Ruhl, Michael J" <michael.j.ruhl@intel.com>
Cc: "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] clkdev: Update clkdev id usage to allow for longer
 names
Message-ID: <Zdjku0kxCvMl2HcU@smile.fi.intel.com>
References: <20240223163516.796606-1-michael.j.ruhl@intel.com>
 <ZdjZCrpP52Hfbs6L@smile.fi.intel.com>
 <DS0PR11MB64248E0C15C0B86A1CCF945BC1552@DS0PR11MB6424.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB64248E0C15C0B86A1CCF945BC1552@DS0PR11MB6424.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 23, 2024 at 06:22:13PM +0000, Ruhl, Michael J wrote:
> >From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >Sent: Friday, February 23, 2024 12:43 PM
> >On Fri, Feb 23, 2024 at 11:35:16AM -0500, Michael J. Ruhl wrote:

..

> I will remove.

Not remove, but move to the comments/changelog (after '---' line)

> I see your script automatically does a cover page...will use that format int
> the future.

Only if there are more than a single patch.

..

> >[1]: https://github.com/andy-shev/home-bin-
> >tools/blob/master/ge2maintainer.sh
> 
> Using your script I got:
> 
> To: "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
>         linux-arm-kernel@lists.infradead.org,
>         linux-kernel@vger.kernel.org
> Cc: Russell King <linux@armlinux.org.uk>
> 
> My list (using get_maintainers.pl) is:
> 
> linux@armlinux.org.uk
> linux-arm-kernel@lists.infradead.org
> linux-kernel@vger.kernel.org
> 
> They appear to be the same....

Ah, the Russel's email looked like a mailing list, that what confused me.

> I don't have the plain text part on Russel's email (linxu@armlinux.org.uk)... Is that what is missing?

Yes :-)
But my script also uses a heuristics (which is not visible here) to add active
developers of the code in question based on the git history.

> Not sure what CCF is?

Common Clock Framework (This is how it's advertised in MAINTAINERS)

-- 
With Best Regards,
Andy Shevchenko



