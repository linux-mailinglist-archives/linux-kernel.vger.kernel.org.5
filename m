Return-Path: <linux-kernel+bounces-136243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3BC89D1AE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA65286F58
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B15524AF;
	Tue,  9 Apr 2024 04:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ffBJyQM8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8828C18C22;
	Tue,  9 Apr 2024 04:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712638649; cv=none; b=nn0iKegetvXO/08Gj2dSnEntT+s+MyYrsR+E37fOJE84DhzyaBVI9JSXyNG+FZ4/gOF39wAvU9M76//6Y/OuiDcLrMMKr70MChrQbJN0AXIBgzWGYoJtnz10wr/ZHrWhezkhm/auhbCIq28iyTncEP5f76+PNn9m+3L85ixXpJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712638649; c=relaxed/simple;
	bh=y3DPqrmDYg+MO0wxN9GdgxxnrMB3pGs4A5+jP7hLYOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VM1szrftcbcTXfMmBb4HXvuOYMIvjkGP3ujjk5ufSyXEB92lJ5qltYFtmPpn0U0Uziicyoe24vQ7nLxxtlV5t8+FVsesEBxi6R8b/6X/RICpSTH0qwyPI7cZ9tA9HVsyZetbUGR2Gd1Dmv4gopPQ++ngQEN3e6bDmGexolTXE1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ffBJyQM8; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712638648; x=1744174648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y3DPqrmDYg+MO0wxN9GdgxxnrMB3pGs4A5+jP7hLYOQ=;
  b=ffBJyQM8E1sLKb8X5Y8+5rzuoUr34bRMLML7wO8xdZxjZaM81d2V5LMx
   Nch7zMBeNbZquWWo0k2rnAonQHGNK+xbjhHXLC5jCHc77+Z6uvHC33rfS
   tQJI4Qz4HQa7KCY14WFdNEb/0EfThtoJAFpZwlMP91vtT6BotCi3/qRjc
   Wi8ICbpjL4xlBWaFZZPXifMabvOBb/J+7VAvJh7D7JKtJId3BQ671jYb/
   qrs6W13jo2FKLDtQB9DO23VXAuA0RtYd1zNQ6InCsnSWXZsHofTyF7IeV
   GfdNH7q/CAvWoAm5k3uE7B+zOJ0EtPD+2Uv7Ut3bW/b9sdY8cschPuGvw
   A==;
X-CSE-ConnectionGUID: TSML/XADScCZBBR8HQRmOg==
X-CSE-MsgGUID: /MrgmMRGRs+3MMyMIIoifQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="18507204"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="18507204"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 21:57:27 -0700
X-CSE-ConnectionGUID: 9R9JY7zIQcS9rJf31x4vNQ==
X-CSE-MsgGUID: kgeVztYLTC6i9mpR7cz60w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="24808411"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 08 Apr 2024 21:57:25 -0700
Date: Tue, 9 Apr 2024 12:52:24 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Russ Weight <russ.weight@linux.dev>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: tests: use KUnit devices instead of platform
 devices
Message-ID: <ZhTJiJmtewFbAJ/2@yilunxu-OptiPlex-7050>
References: <20240329174849.248243-1-marpagan@redhat.com>
 <ZgujpnLfHTp+WRNL@yilunxu-OptiPlex-7050>
 <9d49402e-c5d4-4002-954f-7d2c48fdcfe4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d49402e-c5d4-4002-954f-7d2c48fdcfe4@redhat.com>

On Wed, Apr 03, 2024 at 03:40:20PM +0200, Marco Pagani wrote:
> 
> 
> On 2024-04-02 08:20, Xu Yilun wrote:
> > On Fri, Mar 29, 2024 at 06:48:47PM +0100, Marco Pagani wrote:
> >> KUnit now provides helper functions to create fake devices, so use them
> >> instead of relying on platform devices.
> >>
> >> Other changes: remove an unnecessary white space in the fpga region suite.
> >>
> >> Reviewed-by: Russ Weight <russ.weight@linux.dev>
> >> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> > 
> > Acked-by: Xu Yilun <yilun.xu@intel.com>
> > 
> > Does this patch has dependency on module owner changes for fpga-mgr/bridge/region?
> 
> There is no dependency on module owner changes for mgr/bridge/region.

Fine. Applied to for-next.

> 
> Thanks,
> Marco
> 

