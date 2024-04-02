Return-Path: <linux-kernel+bounces-127464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E372E894BF5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209841C21B1E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C832C68F;
	Tue,  2 Apr 2024 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W98QVcbY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F75D2C18D;
	Tue,  2 Apr 2024 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041071; cv=none; b=jrOFkM3fJKDjBHvcGnwRprJG/qk+IxhL33yP/38ayGIh99PR7qstZJiPxJ7eBJ6F4Rs/Pq7tspBIOjfrYJJL/J/lbGmUmaV1VhJsxk7jlg+/JYGvVkgY0KfaiO/5W1HKTXk3gdl7x673EjIIJ7O9S5t3i4M78g7anEVtDwSlapc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041071; c=relaxed/simple;
	bh=C9VufDIku+v7A3R5bMpDMYs7kJPjF5QoKcrVsdVl56I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piR0eC07d8BxM3VMC4ME457EDkG0+uEjX8CfdyM2i41uMVESmwG7ukpdk+//VG8y+eqSfoxjKjA1nq58KwLHqyLkQ1UhH0s2nePL47iv5YyspM1QVo/jtGp7CQyA0FBh6GXkvSUUGpeIqXO89E79aAOizdI8HK+VwEvnYYzwLrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W98QVcbY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712041069; x=1743577069;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=C9VufDIku+v7A3R5bMpDMYs7kJPjF5QoKcrVsdVl56I=;
  b=W98QVcbYcj7bmpBX2nQtQ1aTYf3WEXZ4W1XRE5g56QJaI8p24eIeD67y
   Xe3jYUd9vWgvseJheeR46Et5faQn7Wmpg4Qi7BPiGRQ+ACqg/CCJyZHYc
   JJpESWNkVpLNox5R7Tq6Q9dDpuaFeblTpjbLtwXO1umBWUSj4QyKKKMV0
   opu9l6Y2zVSIjDig9ub0iStD0DL65Op3t7uJOQ0ZDipLtVrohJd5KEQ/F
   pAxdckazB2QPs/10RuEhl3vsfOH7XQZz6Tl2C96Chz6sDZldOBghREg3z
   zrevPeBQX89Q/prjyvVgozCyN2WkBnjEZW4Dvz4EHtYL9OeLMmE9Q583l
   A==;
X-CSE-ConnectionGUID: KdII90wSTe2CmLF8Ate07A==
X-CSE-MsgGUID: tOC8/gaoT3G/chtI3mR+Lw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="32592787"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="32592787"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 23:57:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="18044671"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa007.fm.intel.com with ESMTP; 01 Apr 2024 23:57:39 -0700
Date: Tue, 2 Apr 2024 14:52:48 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Russ Weight <russ.weight@linux.dev>
Cc: Peter Colberg <peter.colberg@intel.com>,
	Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Lee Jones <lee@kernel.org>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org, Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH] mfd: intel-m10-bmc: Change staging size to a variable
Message-ID: <ZgurQETbga0Q/PVE@yilunxu-OptiPlex-7050>
References: <20240328233559.6949-1-peter.colberg@intel.com>
 <ZgqCdfCSatazEkIj@yilunxu-OptiPlex-7050>
 <20240401170905.v2xin3fzoe3m3tmz@4VRSMR2-DT.corp.robot.car>
 <20240401171947.dncdvc3gxna33nxq@4VRSMR2-DT.corp.robot.car>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240401171947.dncdvc3gxna33nxq@4VRSMR2-DT.corp.robot.car>

On Mon, Apr 01, 2024 at 10:19:47AM -0700, Russ Weight wrote:
> 
> On Mon, Apr 01, 2024 at 10:09:05AM -0700, Russ Weight wrote:
> > On Mon, Apr 01, 2024 at 05:46:29PM +0800, Xu Yilun wrote:
> > > On Thu, Mar 28, 2024 at 07:35:59PM -0400, Peter Colberg wrote:
> > > > From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > 
> > > > The size of the staging area in FLASH for FPGA updates is dependent on the
> > > > size of the FPGA. Currently, the staging size is defined as a constant.
> > > > Larger FPGAs are coming soon and it will soon be necessary to support
> > > 
> > > Soon? When? You cannot add some feature without a user case. If you do
> > > have a use case, put the patch in the same patchset.
> > 
> > There may never be an up-streamed use-case. This is a very small
> > change intended to make it easier for a third-party vendor to
> > build a card that requires a larger staging area in FLASH. They
> > would have to add a new "struct m10bmc_csr_map", but they
> > wouldn't have to refactor this code as part of the change

I'm OK with this description.

Peter, is that what you mean? Or you do have a board type to follow, in
which case you need to submit the new board type as well.

> > 
> > This change does not introduce an unused function or variable.
> > It is more of a clean-up, making the code more flexible.
> > 
> > Can it not be taken as is?
> 
> Would it be acceptable to just change the commit message to something
> like:
> 
> Do not hardwire the staging size in the secure update driver. Move
> the staging size to the m10bmc_csr_map structure to make the size
> assignment more flexible.

That would be much better.

Thanks,
Yilun

