Return-Path: <linux-kernel+bounces-154694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D698ADFD4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053C41C21B97
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D188524A6;
	Tue, 23 Apr 2024 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZSJcPr/E"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B96F262BD;
	Tue, 23 Apr 2024 08:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861191; cv=none; b=WG++hm114rrwbjFaHJCmuL6BvtqCKiv3hFA2JHzRba9/Zka4Kodi/oRylzgfjBuhd2/RHWI1HAdYvaC5ksiTUeJSCYSHCL48xu80VLBjPYEX2QWXt/1bJY7boXB1HHrOyPLmYOPuBXO7+UdULqEZjopvAHs3pZtc2slbZqvEz80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861191; c=relaxed/simple;
	bh=hVmRLvRndrBf+S9tZPXFqqcz9HpV8GnsniOu8zvWmlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVcNUGvFwrv36b8bccPiMAO8gUm27Csf0a2RFR0bCMkGeIZWHFFKLIKT5tK54c+KfvvRhyGGgMSTmdcCLDq53ztzoZKC5kL4piN3gysJEqRQSkrq7dIlY9XRCoXBIhgLfY8bU4OZC52mzqHbXMwanPrVJoyim1CZbI6yw1a6s/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZSJcPr/E; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713861190; x=1745397190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hVmRLvRndrBf+S9tZPXFqqcz9HpV8GnsniOu8zvWmlM=;
  b=ZSJcPr/EfHPSFDaYg4nUbOpVZUlNyzoQvl9G4IMe2hDSE/UPp5sSMjmp
   6l35WXRBKyzeaDSkaw1RzbNOT+TQwPdRqruOugO33E7QMh/RbAu2LGSOC
   QZuRKjovFxrZqc6aZ9DPe501UtSuSCzXecZM0MWeHKnWCDc3+B3Uqh/Qr
   X2JY6JP1codY3XAh/069WOlpzyh3uvp550bC9iVhEtWl67QAlxCs6Kbu6
   WVcuHS1aST5eLyWI0BJLZMfOZHIOG9QrOxFDeUweRrcxXerVIRTzQ3qqn
   hreY30Nw1WmyInOK4t3paa2d3TVCLTowxDC6z0YiMrk++4FD6iw+aapSe
   g==;
X-CSE-ConnectionGUID: LIfAZirbRXqTqAWmaPedIQ==
X-CSE-MsgGUID: YMdsTpMdSbWALJtTAqCaGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9652512"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9652512"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 01:33:09 -0700
X-CSE-ConnectionGUID: LoAngRZ9QJG2JogeH+ETtA==
X-CSE-MsgGUID: ZagmzqyKR2Six0phluB9zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="55496468"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 23 Apr 2024 01:33:07 -0700
Date: Tue, 23 Apr 2024 16:27:46 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [RFC PATCH v2 0/9] fpga: dfl: fix kernel warning on port
 release/assign for SRIOV
Message-ID: <ZidxApdiC4cOKYOp@yilunxu-OptiPlex-7050>
References: <20240409233942.828440-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409233942.828440-1-peter.colberg@intel.com>

On Tue, Apr 09, 2024 at 07:39:33PM -0400, Peter Colberg wrote:
> DFL ports are registered as platform devices in PF mode. The port device
> should be removed from the host when the user wants to configure the
> port as a VF and pass through to a virtual machine. The FME device
> ioctls DFL_FPGA_FME_PORT_RELEASE/ASSIGN are designed for this purpose.
> 
> In the previous implementation, the port platform device is not completely
> destroyed on port release: it is removed from the system by
> platform_device_del(), but the platform device instance is retained.
> When the port assign ioctl is called, the platform device is added back by
> platform_device_add(), which conflicts with this comment of device_add():
> "Do not call this routine more than once for any device structure", and
> will cause a kernel warning at runtime.
> 
> This patch tries to completely unregister the port platform device on
> release and registers a new one on assign. But the main work is to remove
> the dependency on struct dfl_feature_platform_data for many internal DFL
> APIs. This structure holds many DFL enumeration infos for feature devices.
> Many DFL APIs are expected to work with these info even when the port
> platform device is unregistered. But with the change the platform_data will
> be freed in this case. So this patch introduces a new structure
> dfl_feature_dev_data for these APIs, which acts similarly to the previous
> dfl_feature_platform_data. The dfl_feature_platform_data then only needs a
> pointer to dfl_feature_dev_data to make the feature device driver work.
> 
> The single monolithic v1 patch is split into multiple, smaller patches
> at the request of the maintainer. The first patch adds temporary macros
> that alias dfl_feature_dev_data ("fdata") to dfl_feature_platform_data
> ("pdata") and associated functions from the "fdata" to the corresponding
> "pdata" variants. Subsequent patches separate out most of the symbol
> name changes required by this patch series, one patch per file. The last

One patch per file is not a requirement, simple replacement across
multiple files won't cause trouble for reviewers. The important thing is
that don't bury the key changes in these symbol replacement so that
people can't get the point.

