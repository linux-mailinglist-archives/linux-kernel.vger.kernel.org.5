Return-Path: <linux-kernel+bounces-100616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5259879ACA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61038281C07
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BB413956C;
	Tue, 12 Mar 2024 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lAPLBx3+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82B61386D8;
	Tue, 12 Mar 2024 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710265352; cv=none; b=seOI7nmEFPDz1POlgKxX6TXGyTBo/JMntP5rrUVHwQFXnXV3iMJYFUTEBfaxQgDYzYaylf3jOri31C/+7GPT554ZXMx41TSvGqOr/GAd9RbqG5978tbOvUWqLONebcfJXyEO7VFWrDwEKO7QesOWdnymT/W1u0BPyJGFdzM5YuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710265352; c=relaxed/simple;
	bh=Z4Ik8phlcUVlj3tqxGVHV23CtIi0k+ugcQnwd25QMdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iD4B+7DQfPvAtmbHnyvcxHC4imD7tLIbwIFnaDvgo4FX7wqNZWItUiIqdmwV/lX/ziGtrxAIgbsJdZaGXWztJEikJIidms6K/2as38yyPAozvr2QsU5IG97X46xErxddp2rODFSbrn4YIXyUAWA4p3WHkR+r9s/vijTndpxvjJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lAPLBx3+; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710265350; x=1741801350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z4Ik8phlcUVlj3tqxGVHV23CtIi0k+ugcQnwd25QMdg=;
  b=lAPLBx3+FpHfCrG49XCzS80FB6E7eaPFeZUG65QJi9pRs5ACTHBPhLXh
   /ubzhPe2qwJcsE6FpdBK9ztG7T7SoRc7rsS600h9owK/BPUuWBa7KlC1o
   yMiNGm1RPaaOQc9jj9Y5sq52oCxqbUHBx3qyR4TJmU6i+y2P2i/mvTurR
   GAeXxQ5r16OBXdqVPehYJItyXLZkoucZYnMkbdY626MjUYxog2OgZU/st
   PcVA2I5wLD/UQuwmdr1Y32Ww1xSCt4xdRTqxvgjBjK9MF3LHrRmsPGFRx
   XxxeQfXD5t/bluTBB2eE0M1rZc9oqHjRwMa5rFdifY5h6oHA+QE6V1CDy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="15718810"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="15718810"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 10:42:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="914403002"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="914403002"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 10:42:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rk68u-0000000ByQa-2Ogu;
	Tue, 12 Mar 2024 19:42:24 +0200
Date: Tue, 12 Mar 2024 19:42:24 +0200
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
Message-ID: <ZfCUAMS5JWnkTbR5@smile.fi.intel.com>
References: <20240312085403.224248-1-herve.codina@bootlin.com>
 <ZfB30-rLXEnJtjrY@smile.fi.intel.com>
 <ZfB4BOknvWRFbn6O@smile.fi.intel.com>
 <20240312173556.4727ebbf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312173556.4727ebbf@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 12, 2024 at 05:35:56PM +0100, Herve Codina wrote:
> On Tue, 12 Mar 2024 17:43:00 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Mar 12, 2024 at 05:42:11PM +0200, Andy Shevchenko wrote:
> > > On Tue, Mar 12, 2024 at 09:54:03AM +0100, Herve Codina wrote:  

..

> > > Not sure about rules of net-next, but I would add Fixes FWIW:
> > > 
> > > Fixes: de5f84338970 ("lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers")
> 
> I think I cannot add the Fixes tag as the de5f84338970 commit is not yet
> merged in Torvald's tree and I am not sure that the commit hash will not
> change during the merge process.

It may change if and only if there will be rebase done. For the merge the SHA
will be kept the same.

> > And probably Reported-by...

-- 
With Best Regards,
Andy Shevchenko



