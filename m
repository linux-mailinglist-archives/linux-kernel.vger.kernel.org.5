Return-Path: <linux-kernel+bounces-106984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E99A687F64C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89CA81F21A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459937C08F;
	Tue, 19 Mar 2024 04:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lgNWNKmY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AF07BAFE;
	Tue, 19 Mar 2024 04:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710821330; cv=none; b=lmjY+FU+Gog3m7iFGFCWN1B0c3r647oDYaf11cQp8Hp/krBQD2eGMCvPFNNik+bOjR8Z2SQOoBkXpQ/ca3nVJvalYL1TAG9NVFgqKcEh2E22FcDTJKCOl1QiILgELjR78jR4aHOpXvnmKLRKkIfLXeWN4zONokBUOJn4/KPnQnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710821330; c=relaxed/simple;
	bh=FXJUWaXDFajafiGH9N/Lk6GWxmCJ3Z1AE7/I+I2yb60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvIjxc8rXTiMpXI7B+Y9NyA2w+X6oqaNYYn4uUShV1esia5gUKd8Ckzb9PoTeGovKy+P2YPyXcWawTKBCbejPdgC0SVwFAnowa5IBhnD/8mKXq7EJqj6sh9St7zutfM33ARA9AA5l3Br9KmOU0hyjHn+O8rdmeSavSLct6UuO0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lgNWNKmY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710821329; x=1742357329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FXJUWaXDFajafiGH9N/Lk6GWxmCJ3Z1AE7/I+I2yb60=;
  b=lgNWNKmYoIp55fPt+7/MkjjnnWqiSzq9u4msetrwfnjplwOamyhDZ3LW
   kFt7u4C6G3UEfxjZZPN5dw5ltHy/hpfKoCJ0Pur25Ehx1ZX38wB8DSnhn
   C3V5rneWXF5Jo1hL/WefwWdyVEPXrwZ3k6C6skMqN0F7+slKCls3jr9rk
   F0wwGe2aeWRFLmOeKsOPuCw5Z7NhwMlNXLsm8kbaHEWNXX10GfpJgbi1o
   OmkqwDcLNEFxvHeIcTs27+StkSABIUTNW+ldvdbMmRE8jJq1ppw2g6hTx
   lyAFhdons97eAVSYpgfDRDgemzyZNesHxoUT/nnk3Nbcpdx9hPZP7tc0C
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="31100354"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="31100354"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 21:08:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="13566078"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 18 Mar 2024 21:08:45 -0700
Date: Tue, 19 Mar 2024 12:04:13 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Tull <atull@opensource.altera.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: Re: [PATCH v6] fpga: manager: add owner module and take its refcount
Message-ID: <ZfkOvXslEjgU+fc1@yilunxu-OptiPlex-7050>
References: <20240305192926.84886-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305192926.84886-1-marpagan@redhat.com>

On Tue, Mar 05, 2024 at 08:29:26PM +0100, Marco Pagani wrote:
> The current implementation of the fpga manager assumes that the low-level
> module registers a driver for the parent device and uses its owner pointer
> to take the module's refcount. This approach is problematic since it can
> lead to a null pointer dereference while attempting to get the manager if
> the parent device does not have a driver.
> 
> To address this problem, add a module owner pointer to the fpga_manager
> struct and use it to take the module's refcount. Modify the functions for
> registering the manager to take an additional owner module parameter and
> rename them to avoid conflicts. Use the old function names for helper
> macros that automatically set the module that registers the manager as the
> owner. This ensures compatibility with existing low-level control modules
> and reduces the chances of registering a manager without setting the owner.
> 
> Also, update the documentation to keep it consistent with the new interface
> for registering an fpga manager.
> 
> Other changes: opportunistically move put_device() from __fpga_mgr_get() to
> fpga_mgr_get() and of_fpga_mgr_get() to improve code clarity since the
> manager device is taken in these functions.
> 
> Fixes: 654ba4cc0f3e ("fpga manager: ensure lifetime with of_fpga_mgr_get")
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Marco Pagani <marpagan@redhat.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Will apply to v6.9-rc1

