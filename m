Return-Path: <linux-kernel+bounces-62513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299A9852232
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58EA91C2256E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81E44F8A1;
	Mon, 12 Feb 2024 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbMoyjx5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194A14EB3D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 23:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778870; cv=none; b=tqNAoUxsiaIr/6e15klX8JLeo+WMKpheHAlM506EFMx2fSWVa+NerG2M8xpzXPFj+RHoI0GoJzEqp6eo0Q/INGz1OGU7fFhYstC6ZU8EBP73pymSV5GYHoQJlgtpDW9tG1mJKnKuTlBmDa13vokVMc7OyKeJ6dpt1dXpF35+NTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778870; c=relaxed/simple;
	bh=8LHnGgzWPky93CofKSFQtD84mMH96b/653GC9OgJAE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oo0/T9kzZsfnND+30FCNQWgIVMfkMDQqDr7Fox5vJzEw8ukfRHF/hmZdw0zbfc5GF2uSAqyzeP1qOXqel+FXHumyyUSCEMmlFvCvWgqFTNBCEb/kI8CIhlo6wl/RL5zlUZTBUyTwmOvboOwHn/yUQuLZVUDd6K8UDXFOygZXI8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbMoyjx5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707778867; x=1739314867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8LHnGgzWPky93CofKSFQtD84mMH96b/653GC9OgJAE0=;
  b=UbMoyjx5b8aZQ2IWiFTpOdnsRHAsmK18zq6NRGn88EWUsT528xdFWALP
   HDfZHiPAPergUJNjHBaSCSmGtIN1vFUaYWFhft53FRyeZzgDzISbQbDlP
   T/GqPEOLax5ELQT6bhGOrGbHydns0G60PKgSTZBeZsldX7KAZMQoAw508
   CCF3h4R2CdDmFmjPmXKz/9PnR+WA+l9qzv1fUN99n6SXvGFNgJ1y8mPr3
   hgnj5Zmcw7EBtKW3V5tT0MbFlslVbgG7CboYdfNJ9q2TaSlqN3DYKn98/
   eoocP6KLCiOxP04r6nj/vMIM64PqsP35RD7zL3SbiTKo82fWckdikSKTl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19286825"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="19286825"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 15:01:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="3093271"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 12 Feb 2024 15:01:04 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZfIK-0007PK-2x;
	Mon, 12 Feb 2024 23:01:00 +0000
Date: Tue, 13 Feb 2024 07:00:06 +0800
From: kernel test robot <lkp@intel.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, sudeep.holla@arm.com,
	vincent.guittot@linaro.org, peng.fan@oss.nxp.com,
	michal.simek@amd.com, quic_sibis@quicinc.com,
	quic_nkela@quicinc.com, souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH 06/11] firmware: arm_scmi: Implement Clock
 .is_notify_supported callback
Message-ID: <202402130607.H0A5KJ1C-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v6.8-rc4 next-20240212]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Marussi/firmware-arm_scmi-Check-for-notification-support/20240212-203727
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20240212123233.1230090-7-cristian.marussi%40arm.com
patch subject: [PATCH 06/11] firmware: arm_scmi: Implement Clock .is_notify_supported callback
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240213/202402130607.H0A5KJ1C-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240213/202402130607.H0A5KJ1C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402130607.H0A5KJ1C-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/firmware/arm_scmi/clock.c: In function 'scmi_clk_notify_supported':
>> drivers/firmware/arm_scmi/clock.c:853:15: error: implicit declaration of function 'scmi_clock_domain_lookup' [-Werror=implicit-function-declaration]
     853 |         clk = scmi_clock_domain_lookup(ci, src_id);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/firmware/arm_scmi/clock.c:853:13: warning: assignment to 'struct scmi_clock_info *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     853 |         clk = scmi_clock_domain_lookup(ci, src_id);
         |             ^
   cc1: some warnings being treated as errors


vim +/scmi_clock_domain_lookup +853 drivers/firmware/arm_scmi/clock.c

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

