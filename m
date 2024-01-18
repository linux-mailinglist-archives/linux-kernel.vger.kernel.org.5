Return-Path: <linux-kernel+bounces-29585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCA7831073
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6AD1C22065
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9A4647;
	Thu, 18 Jan 2024 00:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n054DLKB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B4319A;
	Thu, 18 Jan 2024 00:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705537347; cv=none; b=o16MLDxyv+e8ibwZiJlp4HTvag+5FZkQFDCUGqT5FLWYmSMMejn3vbsKs2z6POVAw8ny3Qhzn2WNSrD/I2qDkBeLSwDgjzl+Wo0b1Z/dZgqPqS0FWKxAsTvM3KXZOpgEjZPUX65nx6n+nt/wJVA2sb4JwoIDFHih6DVpYenTem8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705537347; c=relaxed/simple;
	bh=T+AmGU0gQbfreXKTRLEEHGmLfVo+WczNMBqdEKKglYQ=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=nSOes3KdbjrH9XkH+cLq16KyL/I3xPqb9NSqRdxl9SJVtss+aLrbrgU8KitjFUsCOn6qZLVIsUHeGDurPFi2qBJiFv8978ZSs5ZvtCwYv8dnUsy2YDbgbEs7F4jrfP/vBeuijp4VjCRB9xj7ixDr28HOhOh8+gltNGm7oYoxKCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n054DLKB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705537346; x=1737073346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T+AmGU0gQbfreXKTRLEEHGmLfVo+WczNMBqdEKKglYQ=;
  b=n054DLKBej2Fe/HHp26GdIy+L3OOVUyKr2oS2YEaHMY1SM15hj8iZLM6
   4p4ZWDHfz8LQs8SZWKHwhBN27wBZHnu7+/QZn/fgoYebsGmWh5EyHCVu+
   J5UDmWZn3XhslHXC/PsFFz9Bj3RglUfliI3NR72f7Gcx5XS3m40kIMxEn
   y/PiJSHQ3ZEO0PzTvwpfXZ4TVI34IblC9y/txcKYS7379i6kXXC4tlY2N
   Wrce5nMlm+siJW+7Dquuu09u8HoACVFJtDrBch3E9Wu+MxhMvTX7gZtjt
   CMlcPqwyb18SEkt2HCyCGK3LQFcaLSceRKNY/HHINsUUfbUDpuw71VASy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="13819124"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="13819124"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 16:22:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="18964223"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 17 Jan 2024 16:22:22 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQGAm-0002Ry-0K;
	Thu, 18 Jan 2024 00:22:20 +0000
Date: Thu, 18 Jan 2024 08:21:31 +0800
From: kernel test robot <lkp@intel.com>
To: Haotien Hsu <haotienh@nvidia.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Utkarsh Patel <utkarsh.h.patel@intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Sing-Han Chen <singhanc@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Wayne Chang <waynec@nvidia.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, WK Tsai <wtsai@nvidia.com>,
	Haotien Hsu <haotienh@nvidia.com>
Subject: Re: [PATCH v5] ucsi_ccg: Refine the UCSI Interrupt handling
Message-ID: <202401180801.WsI6B2pq-lkp@intel.com>
References: <20240116060323.844959-1-haotienh@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116060323.844959-1-haotienh@nvidia.com>

Hi Haotien,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus linus/master v6.7 next-20240117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haotien-Hsu/ucsi_ccg-Refine-the-UCSI-Interrupt-handling/20240116-140628
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20240116060323.844959-1-haotienh%40nvidia.com
patch subject: [PATCH v5] ucsi_ccg: Refine the UCSI Interrupt handling
config: loongarch-randconfig-r131-20240117 (https://download.01.org/0day-ci/archive/20240118/202401180801.WsI6B2pq-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240118/202401180801.WsI6B2pq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401180801.WsI6B2pq-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/usb/typec/ucsi/ucsi_ccg.c:341:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] cci @@     got unsigned int [usertype] cci @@
   drivers/usb/typec/ucsi/ucsi_ccg.c:341:19: sparse:     expected restricted __le32 [usertype] cci
   drivers/usb/typec/ucsi/ucsi_ccg.c:341:19: sparse:     got unsigned int [usertype] cci

vim +341 drivers/usb/typec/ucsi/ucsi_ccg.c

   320	
   321	static int ccg_op_region_update(struct ucsi_ccg *uc, u32 cci)
   322	{
   323		u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(UCSI_MESSAGE_IN);
   324		struct op_region *data = &uc->op_data;
   325		unsigned char *buf;
   326		size_t size = sizeof(data->message_in);
   327	
   328		buf = kzalloc(size, GFP_ATOMIC);
   329		if (!buf)
   330			return -ENOMEM;
   331		if (UCSI_CCI_LENGTH(cci)) {
   332			int ret = ccg_read(uc, reg, (void *)buf, size);
   333	
   334			if (ret) {
   335				kfree(buf);
   336				return ret;
   337			}
   338		}
   339	
   340		spin_lock(&uc->op_lock);
 > 341		data->cci = cci;
   342		if (UCSI_CCI_LENGTH(cci))
   343			memcpy(&data->message_in, buf, size);
   344		spin_unlock(&uc->op_lock);
   345		kfree(buf);
   346		return 0;
   347	}
   348	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

