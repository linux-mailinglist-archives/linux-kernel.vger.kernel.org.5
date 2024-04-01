Return-Path: <linux-kernel+bounces-126976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD2489454B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098041C217D8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1206C51C4F;
	Mon,  1 Apr 2024 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z0zRcgao"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2E0F9DF;
	Mon,  1 Apr 2024 19:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711998587; cv=none; b=Unxw5WAkBdxafwIOq87jUqLs6AakVpP25qMNgg38v/HjwPxT4F1BRq4wL0+qjP9ff4vpO3ToNKBOCc6uzrJOKNU3e+tLZJEIOleRHqKkKxAPaGOIfafS1+U7xiimxcd+vuS6Sic1pBDn4576zWUq+CaKviByhkkbZPmz+mtsoOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711998587; c=relaxed/simple;
	bh=3GU6VuD545qjvcRHOveubHexktKTPPe9aqWlMT/cWA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcaKsd7Y06SFvHhJPlC+iV7aM5s1S148Pg3LmqDoXpIviQS9Y2qgCHwBajlXoS1UoM7H9fNM0SVPLO9I6Aql/r1k23eK19lsrG8uC+5XcFXDzOqxkDzCHRVbixAUxfZjiDqCb0mhLWZCZPgVhuyetZoG9xlzlwWPcFvgdJWGGRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z0zRcgao; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711998586; x=1743534586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3GU6VuD545qjvcRHOveubHexktKTPPe9aqWlMT/cWA0=;
  b=Z0zRcgaoXR8BvbQ3WIGW3CFFE9w4dNhze/eM8gnr8sW0ZiM2SExbPqbX
   ohE0syTPH7NBdCzoI/l4qslViqHrpUNuB088QsBNIbr0rNWFcY1U7PNQg
   lWbZ5lugWmXd4SyV24+Or2xfysHgiQPhgdWN/43f5VTngknpaYM8ms6ET
   cePVNE6gFEluA0h6z+BDGhHXKpJoK3JdhM60gXE8YCufXiRZEsodW1W3G
   PJaJJMzlqyrdWVxrqtBO7x9ns2MXOnL8mI1f1kp7bnt0uyz/g/WxFMEIR
   YBO+nxFy+wlJmePo8VJNgh6gYBfM0otmH/ftZdKOHM6YQtAYCp5o1jAv1
   Q==;
X-CSE-ConnectionGUID: jraIirAVRBy8vjKCQy0TAw==
X-CSE-MsgGUID: KmQPrGIhRb2a6/Q6J5j+TA==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="29618035"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="29618035"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 12:09:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="17836281"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.66.56])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 12:09:43 -0700
Date: Mon, 1 Apr 2024 12:09:42 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Kwangjin Ko <kwangjin.ko@sk.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com
Subject: Re: [PATCH 2/2] cxl/core: Fix incorrect array index in
 cxl_clear_event_record()
Message-ID: <ZgsGdvUfp8uz2xgb@aschofie-mobl2>
References: <20240401091057.1044-1-kwangjin.ko@sk.com>
 <20240401091057.1044-2-kwangjin.ko@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401091057.1044-2-kwangjin.ko@sk.com>

On Mon, Apr 01, 2024 at 06:10:56PM +0900, Kwangjin Ko wrote:
> The variable 'i' should be incremented after dev_dbg(), or print
> gen->hdr.handle instead. Otherwise, the handle value of the next loop
> will be printed. Furthermore, in the final loop, accessing 'handles[i]'
> will cause a buffer overflow.

This fix is already queued:
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/?h=fixes

> 
> Signed-off-by: Kwangjin Ko <kwangjin.ko@sk.com>
> ---
>  drivers/cxl/core/mbox.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index a38531a055c8..84014aa01c95 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -913,9 +913,9 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  		struct cxl_event_record_raw *raw = &get_pl->records[cnt];
>  		struct cxl_event_generic *gen = &raw->event.generic;
>  
> -		payload->handles[i++] = gen->hdr.handle;
>  		dev_dbg(mds->cxlds.dev, "Event log '%d': Clearing %u\n", log,
> -			le16_to_cpu(payload->handles[i]));
> +			le16_to_cpu(gen->hdr.handle));
> +		payload->handles[i++] = gen->hdr.handle;
>  
>  		if (i == max_handles) {
>  			payload->nr_recs = i;
> -- 
> 2.34.1
> 

