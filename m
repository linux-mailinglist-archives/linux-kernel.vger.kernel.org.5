Return-Path: <linux-kernel+bounces-8214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6614A81B3BD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C405282A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C7267203;
	Thu, 21 Dec 2023 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hVlujhbF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C93D6A00A;
	Thu, 21 Dec 2023 10:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703155043; x=1734691043;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ke4J4uyPnsfHC4InqtLGeta3zbE3qTWCL7jxGbalv6U=;
  b=hVlujhbF1ngPfEcY1kK7/Jzjyj0uNHGOfte+1LYSMGIY3OxWXiqtEK6V
   y0EipQGZMkoxoU0+DjcPDDfzpmhr9IpOUBmtIDMXGwcO9cASj1tRcxcz/
   FUp93IbC4vniMZeOyg+v8h8EMgi/NuednfZ7NnAmPGFP/GHuHEtBPZow0
   b4iZhrdrCD+BdBSzHbKx5QmJRU76rN0k5nkSVSD/YA5tz7FpKRRSy73Jq
   dTH37OrvG0zXjsRs+aWdbb3Dkzv3YZUYNEj43gVPrJQecthCNNFwk6uaS
   GjtO6nqbqf56ZSESjRjiE8gXw0Uq+pRKHMyBVeDBm0+b9U5E0nz4b4Cfm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2789852"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="2789852"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 02:37:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="726393319"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="726393319"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 21 Dec 2023 02:37:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id BBDE4B8; Thu, 21 Dec 2023 12:37:18 +0200 (EET)
Date: Thu, 21 Dec 2023 12:37:18 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg KH <greg@kroah.com>
Cc: Werner Sembach <wse@tuxedocomputers.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Reduce retry timeout to speed up boot for
 some devices
Message-ID: <20231221103718.GC2543524@black.fi.intel.com>
References: <20231220150956.230227-1-wse@tuxedocomputers.com>
 <2e00a0dc-5911-44ee-8c50-a8482eb44197@tuxedocomputers.com>
 <2023122012-spruce-unsteady-e187@gregkh>
 <e7c768aa-a071-4590-ab1a-d80738dce1e5@tuxedocomputers.com>
 <2023122056-snowflake-visor-1262@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023122056-snowflake-visor-1262@gregkh>

Hi,

On Wed, Dec 20, 2023 at 06:30:53PM +0100, Greg KH wrote:
> On Wed, Dec 20, 2023 at 05:41:01PM +0100, Werner Sembach wrote:
> > 
> > Am 20.12.23 um 17:04 schrieb Greg KH:
> > > On Wed, Dec 20, 2023 at 04:23:15PM +0100, Werner Sembach wrote:
> > > > Am 20.12.23 um 16:09 schrieb Werner Sembach:
> > > > > This is a followup to "thunderbolt: Workaround an IOMMU fault on certain
> > > > > systems with Intel Maple Ridge".
> > > > > 
> > > > > It seems like the timeout can be reduced to 250ms. This reduces the overall
> > > > > delay caused by the retires to ~1s. This is about the time other things
> > > > > being initialized in parallel need anyway*, so like this the effective boot
> > > > > time is no longer compromised.
> > > > > 
> > > > > *I only had a single device available for my measurements: A Clevo X170KM-G
> > > > > desktop replacement notebook.
> > > > > 
> > > > > Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> > > > I wonder if this could also land in stable? Or would it be to risky?
> > > If it's really a bugfix now, why would it _not_ be relevant for stable?
> > 
> > Because it changes a timeout that could cause issues if set to low: This
> > Patch sets to to 250ms. Set to 50ms it causes issues, currently it's 2000ms,
> > 2 people tested that 250ms is enough, but i don't know if this is a big
> > enough sample size for stable.
> 
> Remember, the next kernel will be a stable kernel tree, just like the
> one after that.  If it's good enough for Linus's tree, why wouldn't it
> be good enough for all stable trees?  Either it works or it doesn't,
> none of this "we will break things when you move to a new kernel" stuff
> please.

Since this is kind of "improvement" over already functioning code, I
would put it to v6.8 and not to stable trees. This way it gets more some
more exposure before landing to distro kernels.

It would be nice to get Tested-by from the folks involved on that
bugzilla as well, if that's possible. I can try this on my side on a
Maple Ridge based system (that does not have the original issue) so that
we know that it does not cause any issues on them.

