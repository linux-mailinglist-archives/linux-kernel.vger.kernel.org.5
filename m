Return-Path: <linux-kernel+bounces-62527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3742F85225E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E874328437D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C234F88C;
	Mon, 12 Feb 2024 23:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B5thEsZG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E39D4F611
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 23:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780069; cv=none; b=hbMYNjPygMtTKc7wnCG7oRbQnJBeB/CHefEIc+SR0UBFy6laBGotq3P700CuFXLjk/sjUThgQgLw8i5DfC9j5Y8WZ756LVtESuyjZv3hfuc+9QCKJEk9e58h8EFbYddGKjrNy+lB9z17HM5hhTfMZ9DcTFSJJTRitY+0RxDizC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780069; c=relaxed/simple;
	bh=sEnlAnPtx/b3N5OPsMnT5S5yhEA8bixB/wz+9/zOvWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8KPrIVfrORAURahFEo7IDaLd1E4oe1yIZpA3ao8DI8Vx7k8a8niF/UUHD4Fw24NyW29WiOExzwpQQi+jU9lY+pKb9S7HmJGdYQL7Vlp0hiu9+dCgfRm4jfir5YtQqPRv5GkcRjkG61OxWfzpTM0sJWNuMYwXxBCxBMOM46eh6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5thEsZG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707780068; x=1739316068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sEnlAnPtx/b3N5OPsMnT5S5yhEA8bixB/wz+9/zOvWk=;
  b=B5thEsZGbsgCc5ON0y698xu1nwrAs4QTKBCsV8JIWfYTNFjtDVdJ2iRJ
   5SjPK2byxJ7wEUKd/j4gZ91y5ejfFhe8fnEDF9hRF0+u3EDjvkiwiv0i5
   SAFg+Iu/Pyn19BOs6cA1CZlZSeQe+/Ctn5/BNG0Ift7gk0+3HlpeneB9U
   c6G5+ryxjsiU7IJ2y3Q5/46ewfWJ2GaG0LttVSE0xeNwPPfUvfVOelQvK
   aA4fIOltB5ltUqtMJGvCEvrl0KXcXL+y3S2C+/CAduiUD2a78UAdXcQME
   nwrZY4V+QJePxuOg0yUbgrNbephzcHiuAblE+vJmmycaqLgLjTSBN7eYS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="12867752"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="12867752"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 15:21:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="2678247"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 12 Feb 2024 15:21:03 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZfbh-0007PW-1A;
	Mon, 12 Feb 2024 23:21:01 +0000
Date: Tue, 13 Feb 2024 07:20:24 +0800
From: kernel test robot <lkp@intel.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	sudeep.holla@arm.com, vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	quic_nkela@quicinc.com, souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH 06/11] firmware: arm_scmi: Implement Clock
 .is_notify_supported callback
Message-ID: <202402130758.vkfAqrx0-lkp@intel.com>
References: <20240212123233.1230090-7-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212123233.1230090-7-cristian.marussi@arm.com>

Hi Cristian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.8-rc4 next-20240212]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Marussi/firmware-arm_scmi-Check-for-notification-support/20240212-203727
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20240212123233.1230090-7-cristian.marussi%40arm.com
patch subject: [PATCH 06/11] firmware: arm_scmi: Implement Clock .is_notify_supported callback
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240213/202402130758.vkfAqrx0-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240213/202402130758.vkfAqrx0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402130758.vkfAqrx0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/firmware/arm_scmi/clock.c:853:8: error: implicit declaration of function 'scmi_clock_domain_lookup' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           clk = scmi_clock_domain_lookup(ci, src_id);
                 ^
>> drivers/firmware/arm_scmi/clock.c:853:6: warning: incompatible integer to pointer conversion assigning to 'struct scmi_clock_info *' from 'int' [-Wint-conversion]
           clk = scmi_clock_domain_lookup(ci, src_id);
               ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +853 drivers/firmware/arm_scmi/clock.c

   842	
   843	static bool scmi_clk_notify_supported(const struct scmi_protocol_handle *ph,
   844					      u8 evt_id, u32 src_id)
   845	{
   846		bool supported;
   847		struct scmi_clock_info *clk;
   848		struct clock_info *ci = ph->get_priv(ph);
   849	
   850		if (evt_id >= ARRAY_SIZE(evt_2_cmd))
   851			return false;
   852	
 > 853		clk = scmi_clock_domain_lookup(ci, src_id);
   854		if (IS_ERR(clk))
   855			return false;
   856	
   857		if (evt_id == SCMI_EVENT_CLOCK_RATE_CHANGED)
   858			supported = clk->rate_changed_notifications;
   859		else
   860			supported = clk->rate_change_requested_notifications;
   861	
   862		return supported;
   863	}
   864	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

