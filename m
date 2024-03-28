Return-Path: <linux-kernel+bounces-122634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C2988FAAB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067DF2987A1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ED25F865;
	Thu, 28 Mar 2024 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OyARpCuB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00CF535C8;
	Thu, 28 Mar 2024 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711616765; cv=none; b=Tyq/uk8xtz6gaYO7alzx2oW/Eo4dYWGoqmO/7k60/6FZJGrj+t499V+wqLcYvhb2cHhTLngNbq4/kGnqXEKnPXPvv3eSZuPiII0K8p+NNhPkTE58ZRv0dPnSqPn5z0AxtJ020drgD2AFF3yfEdRfh+JSO2wd4DFRf7sU7gsKPL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711616765; c=relaxed/simple;
	bh=/aSry/tvH4Kn2+KvvLdokxm+tTIRQW4w1k0pfVZBoUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoIsyhbn2laLtekagNhN/yIMcMuZ6RpCQG2Pwt5XTOapugZFRgIwDk+IFDPEusnkoSmFz13+2wZS/cpmoddsyCzRpLa2gzykffv8zgTI6BLutpIGy4Qr73l8EI8qc40EHPf4fenfIOmd+qM4zSTpiS4Ooo5r2srZd3VRSbKzTWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OyARpCuB; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711616762; x=1743152762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/aSry/tvH4Kn2+KvvLdokxm+tTIRQW4w1k0pfVZBoUA=;
  b=OyARpCuBOUWiKEhSBRf7aQZcS+HxnTQzeF0J1AJgNa/8yPbAvaoV0BcZ
   I3huY/UdmVh9+PBojjR0pUovGaLYT7RaViN6Exd1ODuDt49i1mtooMtmW
   dMiRg2xLOzRxQRaBh3u9buABkgqPCeb32aCdXkNDBXP9kzIg11Mw394/y
   oeBcYXhX+ndgMiopN3RzxgFV41N5wqnMMwfLwcFTRi3BudiWH9PHGUfbp
   Wvrs0JxUYS3xMmwl/m++Ex6tNQCcTxHUQUwRflOB/Az9PiYV0j+gtsfAx
   uIZO9XGJYLiGUw8DF3EqJbNnpJCAn5TCt4i5sjry0D4VjpqtxTkZedIj/
   A==;
X-CSE-ConnectionGUID: M2i41u7/RSW2hal4xlIKvQ==
X-CSE-MsgGUID: oIuvPsrqT9iJ3SBYMGqemA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="7356546"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="7356546"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 02:06:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="21079288"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 28 Mar 2024 02:06:00 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rplhu-0001yw-00;
	Thu, 28 Mar 2024 09:05:58 +0000
Date: Thu, 28 Mar 2024 17:05:19 +0800
From: kernel test robot <lkp@intel.com>
To: Pavan Holla <pholla@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Pavan Holla <pholla@chromium.org>
Subject: Re: [PATCH 3/3] platform/chrome: cros_ec_ucsi: Implement UCSI PDC
 driver
Message-ID: <202403281639.AVfLPAVm-lkp@intel.com>
References: <20240325-public-ucsi-h-v1-3-7c7e888edc0a@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325-public-ucsi-h-v1-3-7c7e888edc0a@chromium.org>

Hi Pavan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4cece764965020c22cff7665b18a012006359095]

url:    https://github.com/intel-lab-lkp/linux/commits/Pavan-Holla/usb-typec-ucsi-Provide-interface-for-UCSI-transport/20240326-074003
base:   4cece764965020c22cff7665b18a012006359095
patch link:    https://lore.kernel.org/r/20240325-public-ucsi-h-v1-3-7c7e888edc0a%40chromium.org
patch subject: [PATCH 3/3] platform/chrome: cros_ec_ucsi: Implement UCSI PDC driver
config: x86_64-randconfig-123-20240328 (https://download.01.org/0day-ci/archive/20240328/202403281639.AVfLPAVm-lkp@intel.com/config)
compiler: gcc-12 (Ubuntu 12.3.0-9ubuntu2) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240328/202403281639.AVfLPAVm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403281639.AVfLPAVm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/platform/chrome/cros_ec_ucsi.c:119:24: sparse: sparse: symbol 'cros_ucsi_ops' was not declared. Should it be static?

vim +/cros_ucsi_ops +119 drivers/platform/chrome/cros_ec_ucsi.c

   118	
 > 119	struct ucsi_operations cros_ucsi_ops = {
   120		.read = cros_ucsi_read,
   121		.async_write = cros_ucsi_async_write,
   122		.sync_write = cros_ucsi_sync_write,
   123	};
   124	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

