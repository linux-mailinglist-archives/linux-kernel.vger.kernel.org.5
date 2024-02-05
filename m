Return-Path: <linux-kernel+bounces-52746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C06D849C32
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BBCD2850A6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E84921103;
	Mon,  5 Feb 2024 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4xqhGSZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7427520DCB
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140962; cv=none; b=txskNzH4P92iXwruTni3upRAIg2J6Ml4MYCtdDOVSV6XP3Jw9ckeqwfb9BkCM9+JRgMpQ+/BktFZgZTw4n66lggbsbagnJbYcfMsAyMJcJoE7Qtwy1D5ASr9BzFxtP0MRirTxLvy1GHJcDeHzY56cdMzxPS12FRpZrHqVFPkHYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140962; c=relaxed/simple;
	bh=uXJZxp5n5dwGpzBxC8nui0Wglon/mdw6pK6qMj//NbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lhj7jGykGsYmhaeAPXOLSbgt+MEn9UiP8qXJXhWB3x67ZVUTDoVBIdXlegGDJl7uSXrpaXEGlV1qB4gll8z5RmetEMpe9YEw02LZ4B9n6OIQJsTmTOHo3llRZ7mthKwlXfEYgygTrYJk6OKKhJKtEeCZCBY9nv9kCRcyMh+H1I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4xqhGSZ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707140960; x=1738676960;
  h=resent-from:resent-date:resent-message-id:resent-to:date:
   from:to:cc:subject:message-id:references:mime-version:
   in-reply-to;
  bh=uXJZxp5n5dwGpzBxC8nui0Wglon/mdw6pK6qMj//NbE=;
  b=R4xqhGSZhyDiDZCrF8t0Ei6oDXV/UvYznJ/JAghZL7EltmXNgIig/NL2
   YmrnmuHqsinh0udxu7pcgEyRouRWcjB1NJkcpr93NxFxk+qeaictn5XmF
   NCCVrHOa3XUiRjnP3H5sbjyKr8wucbTSvkt/ApFvkHlief/Gptd6B1lTf
   v1t1dzK2mGKhs/BsImuhkMtahjhrP4+Z1eCtYp/MDuS17BYaSICFlFqlx
   S6VbbhOFdduVwgwml9cvOm44gEkxyUcVsmmN/IerML+kPJ3MTW1m8M9wq
   Q96fsMbuUSxGicCQwkfYgkKLBvBBcisN7/a91C8B3KnhMjOTuM27XUqh4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="431016"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="431016"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:49:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="909300506"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="909300506"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:49:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rWzLY-000000025q1-0lnP;
	Mon, 05 Feb 2024 15:49:16 +0200
Resent-From: Andy Shevchenko <andriy.shevchenko@intel.com>
Resent-Date: Mon, 5 Feb 2024 15:49:15 +0200
Resent-Message-ID: <ZcDnWztXAl4OljXP@smile.fi.intel.com>
Resent-To: nuno.sa@analog.com, linux-kernel@vger.kernel.org
Date: Mon, 5 Feb 2024 14:35:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: nuno.sa@analog.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] driver: core: add dedicated workqueue for devlink
 removal
Message-ID: <ZcDV9epWJf_oTCMK@smile.fi.intel.com>
References: <20240205-fix-device-links-overlays-v2-0-5344f8c79d57@analog.com>
 <20240205-fix-device-links-overlays-v2-1-5344f8c79d57@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205-fix-device-links-overlays-v2-1-5344f8c79d57@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 05, 2024 at 01:09:32PM +0100, Nuno Sa via B4 Relay wrote:
> From: Nuno Sa <nuno.sa@analog.com>
> 
> Let's use a dedicated queue for devlinks since releasing a link happens
> asynchronously but some code paths, like DT overlays, have some
> expectations regarding the of_node when being removed (the refcount must
> be 1). Given how devlinks are released that cannot be assured. Hence, add a
> dedicated queue so that it's easy to sync against devlinks removal.
> 
> While at it, make sure to explicitly include <linux/workqueue.h>.

..

> +++ b/include/linux/fwnode.h
> @@ -213,5 +213,6 @@ extern bool fw_devlink_is_strict(void);
>  int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup);
>  void fwnode_links_purge(struct fwnode_handle *fwnode);
>  void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
> +void fwnode_links_flush_queue(void);

I am not sure if you have seen my comment against v1.

I find the namespace a bit messy for devlinks. And to me seems the best place
for this line is to be before fwnode_links_purge().

-- 
With Best Regards,
Andy Shevchenko



