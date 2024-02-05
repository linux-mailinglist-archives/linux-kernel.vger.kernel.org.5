Return-Path: <linux-kernel+bounces-52757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1068849C58
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965631F257CB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045E122EFD;
	Mon,  5 Feb 2024 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRo/3YVC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1DF2D042;
	Mon,  5 Feb 2024 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141331; cv=none; b=g1YIZPAG8V8WcFbkFzMlpbbNNc5FbKXVWgwJMskx4H1Ltkedb9Hp2qnodO9nsW66rTul/TPJKxgJxM1BySVasuya36gDjbRwBShC7lChA2mAtf8sdZogpxaJuSc/LVEpjysaWQk9UjfcE7OMn4GEJ5TkdUEXslWEH6KEP/K4Zjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141331; c=relaxed/simple;
	bh=lcZLONYVrndWga+bH1977BM0C3a0z6Uk4Z/ZxsrYK+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t9UAsvkAcw3v7UVTbHfZREt4pE4jHP+oW50v3VFHo0BqrtbgykDyz/Ro02Bvs5I7C7SrNkUFNiAqwOPU5iOlEEZvW5Gwk1TrqYJDI/3T9yNX9ZFrBN+PKGnHZ9DIR8A8qAGErUJhk+D1CVcQFojvprxGJyZqNF0+Kfap27MtoiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRo/3YVC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707141330; x=1738677330;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lcZLONYVrndWga+bH1977BM0C3a0z6Uk4Z/ZxsrYK+Y=;
  b=SRo/3YVCx4yl2dFo8nq/NRAZOJK/7AR+uFX8HpEfIobOvLDtfwWBlS+K
   x1ynTj7RyFKEfgmfz4K7nMqNITH1Wg2sedFtU49NXLrfmTMqTEiglehNL
   mrjIUnRaewiLxXEF/ZgBuOYTAdz2O6Un9qcwWtfLQG/9b0m8ilzuOg6JX
   pM68Mult5nB2Px/doeTYfK+swxHzaw6vq2Ffn5dZoszkvvy7PL+3v8uia
   7sVMv5uvDZAbBsXLOcs/tAIG16TgCT7eQrTBjtjbbyc3woqNLPOXoxgL9
   NHTohV/CxOD6nipD1By8+7hNEfzEqvdnkImAUWt6LDE/NflIxnLuBsArx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="431916"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="431916"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:55:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="909301134"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="909301134"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:55:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rWzRT-000000025wU-02ax;
	Mon, 05 Feb 2024 15:55:23 +0200
Date: Mon, 5 Feb 2024 15:55:22 +0200
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
Subject: Re: [PATCH 1/2] driver: core: add dedicated workqueue for devlink
 removal
Message-ID: <ZcDoyvAEGr6jsCdj@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo


On Fri, Feb 02, 2024 at 01:18:16PM +0100, Nuno Sa via B4 Relay wrote:
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

> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -213,5 +213,6 @@ extern bool fw_devlink_is_strict(void);
>  int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup);
>  void fwnode_links_purge(struct fwnode_handle *fwnode);
>  void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
> +void fwnode_links_flush_queue(void);

Can it be grouped like

  void fwnode_links_flush_queue(void);
  void fwnode_links_purge(struct fwnode_handle *fwnode);
  void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);

?

(devlinks namespaces seems a bit messy to me, but I'm not familiar with that
 code at all)

-- 
With Best Regards,
Andy Shevchenko



