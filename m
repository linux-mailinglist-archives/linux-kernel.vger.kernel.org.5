Return-Path: <linux-kernel+bounces-52620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF62E849A7F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AB81282383
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6254D1C6A3;
	Mon,  5 Feb 2024 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XQOtvsZf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF51D2C84C;
	Mon,  5 Feb 2024 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136588; cv=none; b=GURVY4eUpirlt/Y7+FNHqBZ3WMcoOPeARr623sJiWk/2jDVkZx5OZrilMRqjfitXxwoBZxLTvEojfZwueVenKCiniZNZYR4FksHuG0mNDE5+tSn/F6m3edcDFKpKoqHvlNW7IEZU/wMxkhS+AmgPWmmT8vK/ozyCHjbbvkgYeVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136588; c=relaxed/simple;
	bh=dA7t09iSTZBR9qJHJtb0Kd3uzZQ9x94EEo0iVVGv9CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWuGtPGnwibQUUK6WDkLlyfoyq7tlHM1wPFpEVg46tdsIgBRqMFvtjEdVu8aJ36jf493dW23A0uy+9FCZSWAdMimnAe7iASNuqRIPFrsuS9MYnPfSY+ec7Rm3+KCR/24Ap0HXwec20kydL0+NPBL8aTa1aGTXpx0KXQv56krh+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XQOtvsZf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707136587; x=1738672587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dA7t09iSTZBR9qJHJtb0Kd3uzZQ9x94EEo0iVVGv9CQ=;
  b=XQOtvsZfDcCHaNEEwcjg/9ht4M9H7yys5U5r8WW/hm2/anlNXoUQDZh1
   fP2PisfvwxkWkuItOgIkfW3YqSLL6L1kCIV/qvZ8ibJDrYnVdGBJjCg0O
   AOheK7vUSxLwBviprztBpcFPTC+bixqO+yIBHsqKwXeJW83+rnXicBBrV
   7K5a3TqNL0zXtsvU7QLIix6xgsNgEW7vvDFHoLPiPvuCobDpVj/ZXDsxZ
   BLrTYr+7qQzmZ7HX106RFn97MIb+B9oLqHcjn1J70On1HbggfMsjKPrg+
   aXIZt4OBjST9znbWIKbfMW435rYenLHVE3dCb3L/de/kx3Vsq2O39zMUt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="11883184"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11883184"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 04:36:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="909285570"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="909285570"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 04:36:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rWyCy-0000000248J-0zC9;
	Mon, 05 Feb 2024 14:36:20 +0200
Date: Mon, 5 Feb 2024 14:36:19 +0200
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
Subject: Re: [PATCH v2 2/2] of: dynamic: flush devlinks workqueue before
 destroying the changeset
Message-ID: <ZcDWQ52BGix3ocUC@smile.fi.intel.com>
References: <20240205-fix-device-links-overlays-v2-0-5344f8c79d57@analog.com>
 <20240205-fix-device-links-overlays-v2-2-5344f8c79d57@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205-fix-device-links-overlays-v2-2-5344f8c79d57@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 05, 2024 at 01:09:33PM +0100, Nuno Sa via B4 Relay wrote:
> From: Nuno Sa <nuno.sa@analog.com>
> 
> Device links will drop their supplier + consumer refcounts
> asynchronously. That means that the refcount of the of_node attached to
> these devices will also be dropped asynchronously and so we cannot
> guarantee the DT overlay assumption that the of_node refcount must be 1 in
> __of_changeset_entry_destroy().
> 
> Given the above, call the new fwnode_links_flush_queue() helper to flush
> the devlink workqueue so we can be sure that all links are dropped before
> doing the proper checks.

Have you seen my comments against v1?

> +++ b/drivers/of/dynamic.c
> @@ -14,6 +14,7 @@
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/proc_fs.h>
> +#include <linux/fwnode.h>

Try to squeeze this to make it ordered (with given context it may go before
linux/s* ones, but maybe you may find a better spot).

..

> +	/*
> +	 * device links drop their device references (and hence their of_node

Device links...

> +	 * references) asynchronously on a dedicated workqueue. Hence we need
> +	 * to flush it to make sure everything is done before doing the below
> +	 * checks.
> +	 */

-- 
With Best Regards,
Andy Shevchenko



