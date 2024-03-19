Return-Path: <linux-kernel+bounces-108245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A4E880859
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D851F22D65
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A6159B68;
	Wed, 20 Mar 2024 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DmUIK+uj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D6754BE0;
	Wed, 20 Mar 2024 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710892834; cv=none; b=f3au/1kTXF3Q7zOvowzL5xlzCEbkSaO0KBVO6/FCcFRnrgyhm3vP35Orxg2TWePdg8nyd5bVng8sF52iSJ1n8S3FULYWkwmRuSWOlbpRO1KFrRHjlXjac7M4GSJIyzgtC8IBgoZf86CRUKPf5hK2c2aECzw3qI5RhXh285QQ6B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710892834; c=relaxed/simple;
	bh=8Hvra+wPx1zlBKmPjY7x+ZfpSU/X0yd68kwaWXPKPD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTBVtYxzGmDPXl0ZvaoPP8ir/L9ETxJuX5nU5cF4QcBg9W9z9auoQ9gfhZZxAcTKzWvtXebMAzSBWmw9FE91D3irSsIdXdAYEau3XWJVxkHzROkU006WNLBUzQJeHMYC4lKTY3ktNhk3X1pu8SRzh77fvN46la1+pYHxQX/LJ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DmUIK+uj; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710892832; x=1742428832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Hvra+wPx1zlBKmPjY7x+ZfpSU/X0yd68kwaWXPKPD0=;
  b=DmUIK+ujv0gK72LMZDD8Fm183Tem5WLQrDOTB5HozQXbnuLzZs89iqvD
   xMpQ1JR6E71RKbK2Vu0khgdVL7VOmRtYB8gj2kqHGXS3RaTHC9n4XLYTR
   Ul/PPfZCFLsACVB/Ugstwj9kCFYCpU0eUNvwxdk9JhUEiR/MIUe0hdnvX
   Ai+jlhNIkLBEjgSAlKduMML5+1w/HyWTPy5kOrcX9wDvoQ+RBCyhN6wWF
   9GL1avFEWD4vmJA1Ra9efn4QkGn/c4zCXXTEX8noNbeuGZFfNakJ7rqgu
   kwI8gq4POlZujLB41sGpE/mRVMPji2LIihJZqBD/5Bcl4hoeXPPEhtVuN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5972292"
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="5972292"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 17:00:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="18698006"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 19 Mar 2024 17:00:27 -0700
Date: Wed, 20 Mar 2024 07:55:55 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marco Pagani <marpagan@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Alan Tull <atull@opensource.altera.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: Re: [PATCH v6] fpga: manager: add owner module and take its refcount
Message-ID: <ZfomC4W8f6id5gRa@yilunxu-OptiPlex-7050>
References: <20240305192926.84886-1-marpagan@redhat.com>
 <ZfkOvXslEjgU+fc1@yilunxu-OptiPlex-7050>
 <2024031906-radish-handbrake-93b4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024031906-radish-handbrake-93b4@gregkh>

On Tue, Mar 19, 2024 at 09:01:32AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 19, 2024 at 12:04:13PM +0800, Xu Yilun wrote:
> > On Tue, Mar 05, 2024 at 08:29:26PM +0100, Marco Pagani wrote:
> > > The current implementation of the fpga manager assumes that the low-level
> > > module registers a driver for the parent device and uses its owner pointer
> > > to take the module's refcount. This approach is problematic since it can
> > > lead to a null pointer dereference while attempting to get the manager if
> > > the parent device does not have a driver.
> > > 
> > > To address this problem, add a module owner pointer to the fpga_manager
> > > struct and use it to take the module's refcount. Modify the functions for
> > > registering the manager to take an additional owner module parameter and
> > > rename them to avoid conflicts. Use the old function names for helper
> > > macros that automatically set the module that registers the manager as the
> > > owner. This ensures compatibility with existing low-level control modules
> > > and reduces the chances of registering a manager without setting the owner.
> > > 
> > > Also, update the documentation to keep it consistent with the new interface
> > > for registering an fpga manager.
> > > 
> > > Other changes: opportunistically move put_device() from __fpga_mgr_get() to
> > > fpga_mgr_get() and of_fpga_mgr_get() to improve code clarity since the
> > > manager device is taken in these functions.
> > > 
> > > Fixes: 654ba4cc0f3e ("fpga manager: ensure lifetime with of_fpga_mgr_get")
> > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Suggested-by: Xu Yilun <yilun.xu@intel.com>
> > > Signed-off-by: Marco Pagani <marpagan@redhat.com>
> > 
> > Acked-by: Xu Yilun <yilun.xu@intel.com>
> > 
> > Will apply to v6.9-rc1
> 
> It is way too late for -rc1, sorry, this needs to wait for the next
> release.

You're right. I'm sorry, I mean I will apply when v6.9-rc1 comes.

> 
> thanks,
> 
> greg k-h

