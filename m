Return-Path: <linux-kernel+bounces-54367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A767084AE4B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411141F234FA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E326B83CCE;
	Tue,  6 Feb 2024 06:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+1z29Ik"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D1483CC6;
	Tue,  6 Feb 2024 06:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707199353; cv=none; b=jj4opvWnaj+MPWwC3Mi3kit/xNdMjfLTfH+WEAmpTk27QfyyzIPSMNzZwgnIw586Yyk6UK2RhRfcshkXbLV5PF/7FRww/8UN0Qt0KjJ4if7xc8FwYBi6teEJZw8IsreCDfy2Wh/pVt79XpSkBuqkobK+uvtn7P4hYZNhg1fTX+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707199353; c=relaxed/simple;
	bh=hB05gtlxMlHze26xB4Tioi2Ammlau2ihD4ZXFEPKVAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxziqh6gS5C1a1qA7xcRzBFfaKhjDp1wQIhGTUBWLTN+oQe2QUvjhKMPJ/tFwCmv5/QFhhny1BUuqlqKn5ZOHgSMbf80vN6KCMBWZJOyxF7MVreSZwiMb/6o/Sjg3xtmqa/cxUB4mDm/WoB7jIja395W43yLYX3g8jKqZls2V8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+1z29Ik; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707199351; x=1738735351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hB05gtlxMlHze26xB4Tioi2Ammlau2ihD4ZXFEPKVAo=;
  b=T+1z29IkIsE8/CRVJzozNU55ECfw/isE4gocjk2cdvSzDFX0WKMjxE6c
   VUNs1W24//avasWEXikVozpg0FPHW8C12wlf+xq3FO+y/Ghi/F+eFbZjY
   2S4gSOPWdwuvRJscHXWFgeBjUs3ztMG0nqXeE8aKT6xhs9rYOcs9AHEme
   KubdubKZ63zCiIHl9gQHT2s2Dlz75IJkP7DD7dKEjm9/5iOw+bA7ADsx8
   1bN9+3pk5nk83eDgDE+icyp4tL+qInbSiZu5uNRGCqWM05mntUVsxbpyT
   VBGBc5S6OiBA/Oy22TfJ7dA4TRN552QiGg+Hu0zaGDmdIMB38fOgqH2QK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="395096941"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="395096941"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 22:02:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="5524021"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 05 Feb 2024 22:02:28 -0800
Date: Tue, 6 Feb 2024 13:58:53 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>, Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: make dfl_bus_type const
Message-ID: <ZcHKnTlPYmqUt+QO@yilunxu-OptiPlex-7050>
References: <20240204-bus_cleanup-fpga-v1-1-dae8b5bf7220@marliere.net>
 <2024020559-floss-appear-5f4d@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024020559-floss-appear-5f4d@gregkh>

On Mon, Feb 05, 2024 at 04:50:05AM -0800, Greg Kroah-Hartman wrote:
> On Sun, Feb 04, 2024 at 01:14:05PM -0300, Ricardo B. Marliere wrote:
> > Now that the driver core can properly handle constant struct bus_type,
> > move the dfl_bus_type variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next.

Thanks.
> 

