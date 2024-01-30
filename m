Return-Path: <linux-kernel+bounces-44277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAF5841FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4644F1C268F2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CCC60BB0;
	Tue, 30 Jan 2024 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eypLwKGX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4E96086F;
	Tue, 30 Jan 2024 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706607545; cv=none; b=PVsflpM5TiWq50b8bSe991PoYREKgkAttSvEljWuP0hHdmfx5rzYRTnqRISu7eMBu2xaG2BLb+ljQI/p0J5JrIX2+ndu8p+0hW2vUyMjhFuWgbNUSrq8HbNLyuTa5HHNTFEIbCn8AQrwpo1P3LSGpak2Ne4fSAXnVyTkEQyb+ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706607545; c=relaxed/simple;
	bh=8PcqJlxljF/zb8Mml8cpcqus23dWCdPL2CEfWjg6wIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuTh3Q7OIJeArwohURycfQIsRO6vk115TxI8cw3iu/TljlAl/UIRBMCXkII9Dv7zoSNc1hqKnwGAk9JAhBlxpRKTH3CrCWIf8l8hEBxwIxoITJqa1FySADQTqdOACf0UXxmJSjycOVKpdgjl+4klPKAWp1NLtT02h/XxZ7agPjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eypLwKGX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706607543; x=1738143543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8PcqJlxljF/zb8Mml8cpcqus23dWCdPL2CEfWjg6wIk=;
  b=eypLwKGXEw3D8JytZRhy0+EylE6I0Rx5BXUP8fQVBLDeecarglGX0NGO
   MYbyRg1APoVyW+tX7KbaCcG56PurQJYp9hy2k/PE06183laEYR2davDqh
   zNQcEa1nra3fZZhbqrpjRtmPAg4L87YLEsVGwew57kDNVzxjBHWK/kPtY
   1f07+AYlDm4n4WiGkbW2Tt8JU8OsnuE27bc5bfWyi2mwISq4VNRna0eHw
   6ZLVdCXiWedPNA4m0XokmV1D4ibt69uTEnsbs1/hPadBOANMT7hYndkjZ
   0TRU9L2UhZh9S9hwqZsw1rbF39YyYMLB2L49o8/cuCiYjZcb1ae86LHTM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="16755554"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="16755554"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:39:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="878382637"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="878382637"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jan 2024 01:39:00 -0800
Date: Tue, 30 Jan 2024 17:35:35 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: matthew.gerlach@linux.intel.com
Cc: hao.wu@intel.com, trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: afu: update initialization of port_hdr driver
Message-ID: <ZbjC501oRClByual@yilunxu-OptiPlex-7050>
References: <20240122172433.537525-1-matthew.gerlach@linux.intel.com>
 <Za8ibeJc82Xkbpct@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2401241106550.77559@sj-4150-psse-sw-opae-dev2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2401241106550.77559@sj-4150-psse-sw-opae-dev2>

On Wed, Jan 24, 2024 at 11:40:05AM -0800, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Tue, 23 Jan 2024, Xu Yilun wrote:
> 
> > On Mon, Jan 22, 2024 at 09:24:33AM -0800, Matthew Gerlach wrote:
> > > Revision 2 of the Device Feature List (DFL) Port feature has
> > > slightly different requirements than revision 1. Revision 2
> > > does not need the port to reset at driver startup. In fact,
> > 
> > Please help illustrate what's the difference between Revision 1 & 2, and
> > why revision 2 needs not.
> 
> I will update the commit message to clarify the differences between revision
> 1 and 2.
> 
> > 
> > > performing a port reset during driver initialization can cause
> > > driver race conditions when the port is connected to a different
> > 
> > Please reorganize this part, in this description there seems be a
> > software racing bug and the patch is a workaround. But the fact is port
> > reset shouldn't been done for a new HW.
> 
> Reorganizing the commit message a bit will help to clarify why port reset
> should not be performed during driver initialization with revision 2 of the
> hardware.
> 
> > 
> > BTW: Is there a way to tell whether the port is connected to a different
> > PF? Any guarantee that revision 3, 4 ... would need a port reset or not?
> 
> The use of revision 2 of the port_hdr IP block indicates that the port can
> be connected multiple PFs, but there is nothing explicitly stating which PFs

Sorry, I mean any specific indicator other than enumerate the revision
number? As you said below, checking revision number may not make further
things right, then you need to amend code each time.

Thanks,
Yilun

> the port is connected to.
> 
> It is hard to predict the requirements and implementation of a future
> revision of an IP block. If a requirement of a future revision is to work
> with existing software, then the future revision would not require a port
> reset at driver initialization.
> 

