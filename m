Return-Path: <linux-kernel+bounces-62895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4378527A0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DD57B240D1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50F58C1B;
	Tue, 13 Feb 2024 02:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXFLQ4oB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0355A8BEB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 02:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707793156; cv=none; b=b+NYLSEK2j4c00RWsXcqoLAIuqZreOXKNTz98/ajNHzDAjnk3+5wjcoMKiV/Ibl4GDo0bWjULGZUpuuwNZ4PYdRZl7EaCAZiKfAZ3GwAgfHc1nDQRJBab8Y6DCwMNJtxPfi28Oo5KfwBKTQPcl5MFPcwnXhLYrx+uNmWaRMc4Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707793156; c=relaxed/simple;
	bh=gQ46DN6D1yvoNqoRdUsU1YbJhGgGueJQzMWJCt/g+dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSOQMo2TjxwPUDXNnU0Sb/2ki63/Qlpy632RMmtuENgU0expd/cr5/Ns7Dxzcz60WrnsdBbyrFDj3+dgRGGjGSuR3Ry4ha/s8gb4YDm4uJ4VBSxzbuROSZq5ygBvo8+sEqmmFHg8pZ5lv7bQ8+z2h2TGWH9HHPfLjLLZR7CQ5fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXFLQ4oB; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707793155; x=1739329155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gQ46DN6D1yvoNqoRdUsU1YbJhGgGueJQzMWJCt/g+dE=;
  b=JXFLQ4oBL2FVcDd3uFMpuz0aqONiUVDzYqo/wlfNIwXB0RwhsRbRW0Hm
   iFzGWHVUpEsO3hvS01nbPy4A/ASgdTzsU/XqYxnPEURwzzSCZ5ylfXHvO
   oiLTFjGWjS28cHGKEZuFwolmrL7VppZfXEff8uoXWMmQ52m3hE2p4jYVv
   fFkmF3c5xPs7sI9UlXnBwjk6tGdFs6m8wqdnFOUdPfGK1ukKUYCWYq1Ui
   3T/D2jn487+vYyBvG1iFNZEOf9IFRdT773XWWhV+L82EnfO/82KvP18dl
   eI5iODEp9jz5v1VH2iTswNTiP/QZH98ggeV2CaC3urorPB5iuVMdKddy+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="12882611"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="12882611"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 18:59:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="2809521"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 12 Feb 2024 18:59:12 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZj0n-0007Tq-0O;
	Tue, 13 Feb 2024 02:59:09 +0000
Date: Tue, 13 Feb 2024 10:58:23 +0800
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
Message-ID: <202402131047.2NVZWHma-lkp@intel.com>
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
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240213/202402131047.2NVZWHma-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project c08b90c50bcac9f3f563c79491c8dbcbe7c3b574)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240213/202402131047.2NVZWHma-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402131047.2NVZWHma-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/firmware/arm_scmi/clock.c:853:8: error: call to undeclared function 'scmi_clock_domain_lookup'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     853 |         clk = scmi_clock_domain_lookup(ci, src_id);
         |               ^
>> drivers/firmware/arm_scmi/clock.c:853:6: error: incompatible integer to pointer conversion assigning to 'struct scmi_clock_info *' from 'int' [-Wint-conversion]
     853 |         clk = scmi_clock_domain_lookup(ci, src_id);
         |             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


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

