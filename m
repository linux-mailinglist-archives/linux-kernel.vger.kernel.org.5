Return-Path: <linux-kernel+bounces-35882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEA583981D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA20E2845E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89227823B9;
	Tue, 23 Jan 2024 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kPO3habK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6912381217;
	Tue, 23 Jan 2024 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035538; cv=none; b=F6FAUhmFMll/awMQDMKVv88d5sT2gkctxFKDV9NaPLGhhd2sQp60YB97cEJ+ApcOy7Wq0YkB4axGqnsCLmqSqIJOQvVP1BEKLVU9AC99wp8RnYD/wsNCL2ku3Zvw3MbD91tZFQplKqWVj8u9x8U7b0Wu/NRVn+P2SCF0IBNKW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035538; c=relaxed/simple;
	bh=9Y3gZLMDAO/ZiqXH+H2JOVRgL+9SRPuL/r8AXWwdHSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DR2XASxUf8fLw24RP7aY+KIlWQfqMZr+GjbSUKyN7BWXWbunJ3hEVmxROfvXS6bBZJZPV+HE790Gx1ZMQEs8Ma9C169lm8LdDwE8S31VpGFOtRCgghDR0+Fl5BWkfsIOKt1dyEIHd3Llwymk4CvqMtP0I69ZLNTFHjSAo5JfH/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kPO3habK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706035536; x=1737571536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Y3gZLMDAO/ZiqXH+H2JOVRgL+9SRPuL/r8AXWwdHSA=;
  b=kPO3habKBzMdMCf8Zm2r1qPT11+SEXqSP/CFeKn7QRsMUM6ooQWn5/uZ
   W1xCNLj+tQDsPJ1gsDCRh5YKijVyeVkiosc0lISuTslaL0v/DctUZfUKI
   G3utlacW8hs6zjy9lSQY58B4yosuxkCtAu2JjTPo17MuG6+TF3D/T3a6v
   76fP4Tk9EdhNwc/uEuHuWesJb2U2KKVvi3nSRiTtHDJCwMQSe9Eku9xFw
   ouXcaI71g9sUwErF44eYqI93e43wi1eqqlGXJ/rlwvXxzdQzTzG6sNSKO
   YdVnu6bwnNandf6ItRgV2Z7Ifc4FPWgpPtwh/98X5nC4q/LRYcEzlRkDV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8980484"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="8980484"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:45:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="929419840"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="929419840"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jan 2024 10:45:32 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rSLm6-0007br-1O;
	Tue, 23 Jan 2024 18:45:30 +0000
Date: Wed, 24 Jan 2024 02:45:29 +0800
From: kernel test robot <lkp@intel.com>
To: Yi Sun <yi.sun@unisoc.com>, axboe@kernel.dk, mst@redhat.com,
	jasowang@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	pbonzini@redhat.com, stefanha@redhat.com,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.sun@unisoc.com,
	zhiguo.niu@unisoc.com, hongyu.jin@unisoc.com, sunyibuaa@gmail.com
Subject: Re: [PATCH 1/2] blk-mq: introduce
 blk_mq_tagset_wait_request_completed()
Message-ID: <202401240242.k3K7SkiZ-lkp@intel.com>
References: <20240122110722.690223-2-yi.sun@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122110722.690223-2-yi.sun@unisoc.com>

Hi Yi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v6.8-rc1 next-20240123]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yi-Sun/blk-mq-introduce-blk_mq_tagset_wait_request_completed/20240122-192222
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20240122110722.690223-2-yi.sun%40unisoc.com
patch subject: [PATCH 1/2] blk-mq: introduce blk_mq_tagset_wait_request_completed()
config: i386-buildonly-randconfig-002-20240123 (https://download.01.org/0day-ci/archive/20240124/202401240242.k3K7SkiZ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240124/202401240242.k3K7SkiZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401240242.k3K7SkiZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> block/blk-mq-tag.c:498: warning: Function parameter or struct member 'tagset' not described in 'blk_mq_tagset_wait_request_completed'


vim +498 block/blk-mq-tag.c

   490	
   491	/**
   492	 * blk_mq_tagset_wait_request_completed - Wait for all inflight requests
   493	 * to become completed.
   494	 *
   495	 * Note: This function has to be run after all IO queues are shutdown.
   496	 */
   497	void blk_mq_tagset_wait_request_completed(struct blk_mq_tag_set *tagset)
 > 498	{
   499		while (true) {
   500			unsigned int count = 0;
   501	
   502			blk_mq_tagset_busy_iter(tagset,
   503					blk_mq_tagset_count_inflight_rqs, &count);
   504			if (!count)
   505				break;
   506			msleep(20);
   507		}
   508	}
   509	EXPORT_SYMBOL(blk_mq_tagset_wait_request_completed);
   510	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

