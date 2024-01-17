Return-Path: <linux-kernel+bounces-28386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1329182FDDF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4ACA28B368
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E936B2C9E;
	Wed, 17 Jan 2024 00:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CL0HZHXA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B695610F7;
	Wed, 17 Jan 2024 00:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705449766; cv=none; b=T9Giux722Vus3l50BThnfa3U92XcP1Ba61cyqSuJfcRr2mlARWqxSTK8Qxu7k42viqP/AinUITkYvNir+PzePKRx0Xx7lBr5gT2nHyO3SSc/NKRxZsDa4uRozD3/biK43pw2LMOJgnT7gZHC241QqrssmMm0YlluAmhNAhPfcOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705449766; c=relaxed/simple;
	bh=aePeyFduRfjV06agsTSgcBO9WyTyujZeq0WIAUBMi3I=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k/ybBIi9hWDG8bUFiHl7LjfnWEoJKl3CV/gmHcJ+nH0qC0+I5QmEeTVK17vtkFWRlXTM1LUQQtH4NrGGmOjZ6fcg0SEIkVBN145w70zgKaibx8V5XhnPTW8FxAcGwhaXil4qo8CU1kCZDPFghn+nPqUW66lZ0w3RMfcZZFtnWTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CL0HZHXA; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705449765; x=1736985765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aePeyFduRfjV06agsTSgcBO9WyTyujZeq0WIAUBMi3I=;
  b=CL0HZHXA1eABc1acOnM6dthnsy2TGcXkgHf3C/EsfLk5IeuhsPy/tQjq
   FcrHydWEe56TsJjBK89Sch122WOlgUTUYA1MX6cSaf51YrzezUrkHbTpp
   AgQc3KSzTuqezLlfCfxz5Vipn75KthsWJKsovFhvEpgFsAbKkDSqWFnkJ
   TZ3gRBtw/bXt2vAqTNCX26Ib/6k5dFsS847ObfJSydEAAl6D5ZtaxbWsd
   Fo5HVhQCWH6fSYFZuSi3YYVGez0s43GskYpQA73ktq795/b0qBKsEDn7/
   uYHAwsKUMgL+3DMRfuvrTsvbu5IslAYeRV4rDIH0IH+8sQxglkEAsFiJy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="6732073"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="6732073"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 16:02:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="818331734"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="818331734"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 16 Jan 2024 16:02:36 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPtO5-0001Ne-2l;
	Wed, 17 Jan 2024 00:02:33 +0000
Date: Wed, 17 Jan 2024 08:02:11 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, v9fs@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, kernel@pengutronix.de,
	Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: Re: [PATCH 1/3] usb: gadget: function: 9pfs
Message-ID: <202401170734.7rHBG2LF-lkp@intel.com>
References: <20240116-ml-topic-u9p-v1-1-ad8c306f9a4e@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116-ml-topic-u9p-v1-1-ad8c306f9a4e@pengutronix.de>

Hi Michael,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 052d534373b7ed33712a63d5e17b2b6cdbce84fd]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Grzeschik/usb-gadget-function-9pfs/20240116-095914
base:   052d534373b7ed33712a63d5e17b2b6cdbce84fd
patch link:    https://lore.kernel.org/r/20240116-ml-topic-u9p-v1-1-ad8c306f9a4e%40pengutronix.de
patch subject: [PATCH 1/3] usb: gadget: function: 9pfs
config: microblaze-randconfig-r132-20240117 (https://download.01.org/0day-ci/archive/20240117/202401170734.7rHBG2LF-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240117/202401170734.7rHBG2LF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401170734.7rHBG2LF-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/usb/gadget/function/f_9pfs.c:825:12: sparse: sparse: symbol 'usb9pfs_modinit' was not declared. Should it be static?
>> drivers/usb/gadget/function/f_9pfs.c:838:13: sparse: sparse: symbol 'usb9pfs_modexit' was not declared. Should it be static?

vim +/usb9pfs_modinit +825 drivers/usb/gadget/function/f_9pfs.c

   824	
 > 825	int __init usb9pfs_modinit(void)
   826	{
   827		int ret;
   828	
   829		INIT_LIST_HEAD(&usbg_function_list);
   830	
   831		ret = usb_function_register(&usb9pfsusb_func);
   832		if (!ret)
   833			v9fs_register_trans(&p9_usbg_trans);
   834	
   835		return ret;
   836	}
   837	
 > 838	void __exit usb9pfs_modexit(void)
   839	{
   840		usb_function_unregister(&usb9pfsusb_func);
   841		v9fs_unregister_trans(&p9_usbg_trans);
   842	}
   843	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

