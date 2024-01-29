Return-Path: <linux-kernel+bounces-42083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 375FF83FC18
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93F38B2211F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AF0EEDB;
	Mon, 29 Jan 2024 02:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ky39gwYF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBA0EADD;
	Mon, 29 Jan 2024 02:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706494624; cv=none; b=BZ09s/RCYTQ+kJq04346Hjdt4FB98zpMmC3blY8PEJUVgf++53GnTh3Qaw7Uzx73uc2fdRB42r92BKoox709vVxvz2GqdJamtH8oGlgKikTgA64QHhjSG6XaMI8ZvvQY91u7wn6UmTO/WUv31YAe5sAk+T/0n8ZtLlGo22osgeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706494624; c=relaxed/simple;
	bh=wPPloFGC7eRb/BPuoQd8XaVTHf6sLjRfp0fiTh87kWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4gKsLtrW1/5dgUyg0p5BKrWTHPJqjb+7d85cwKxIdfySJKG6f7FbJNCHQCY5KuTcg4nA/ENG39OPsjXHcG4rs0iPfVciFByXUeHT/9IBImpRNuROcWHUZnpB+B2cY93LkGZU4wPajiuctfxeMiBeNe9yjaNKmrD4GCPIeBh/R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ky39gwYF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706494622; x=1738030622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wPPloFGC7eRb/BPuoQd8XaVTHf6sLjRfp0fiTh87kWs=;
  b=ky39gwYFrTVIDH6sP9sJXLXjbzcTIYJujUtuldiRmQV/T9Kp/hVJQTPJ
   IdqGqK5RVKRSwu8KrmQApTUvQ0aAH95oqe8j5PrJgFCcbthEtKoWpJ8jz
   0qisoPotLM1VwbPZCqqyG4ggkRRL/ZjxP8ne4eP0MU2XWxoLMDVilMfrc
   QiJGDO3qyRqWwPtuFGHxetg3CT0x1YiBGdd+RZgfedKDErKBBsIE2XVSv
   KgIYWLAgruy3MPILUOHKRk/jsuHqzZLo/msF91Or3y02bfzS0ur8ltlP8
   YEgS2ZzHNe0nqbIqzSmF8FFX+8L7z8GIuk5IPrjE90GbZkEepSR5V6n5Z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="10216460"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="10216460"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 18:17:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="737240503"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="737240503"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Jan 2024 18:16:55 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUHCf-0003xe-1f;
	Mon, 29 Jan 2024 02:16:53 +0000
Date: Mon, 29 Jan 2024 10:16:20 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Davis <afd@ti.com>, Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>,
	Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-spi@vger.kernel.org, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH 4/4] firmware: ti_sci: Use devm_register_restart_handler()
Message-ID: <202401291053.Bc9G6QTc-lkp@intel.com>
References: <20240123164443.394642-5-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123164443.394642-5-afd@ti.com>

Hi Andrew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-leds/for-leds-next]
[also build test WARNING on linus/master v6.8-rc1 next-20240125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrew-Davis/kernel-reboot-Deprecate-register_restart_handler/20240124-005424
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git for-leds-next
patch link:    https://lore.kernel.org/r/20240123164443.394642-5-afd%40ti.com
patch subject: [PATCH 4/4] firmware: ti_sci: Use devm_register_restart_handler()
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240129/202401291053.Bc9G6QTc-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240129/202401291053.Bc9G6QTc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401291053.Bc9G6QTc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firmware/ti_sci.c:120: warning: Excess struct member 'nb' description in 'ti_sci_info'


vim +120 drivers/firmware/ti_sci.c

aa276781a64a5f Nishanth Menon 2016-10-18   85  
aa276781a64a5f Nishanth Menon 2016-10-18   86  /**
aa276781a64a5f Nishanth Menon 2016-10-18   87   * struct ti_sci_info - Structure representing a TI SCI instance
aa276781a64a5f Nishanth Menon 2016-10-18   88   * @dev:	Device pointer
aa276781a64a5f Nishanth Menon 2016-10-18   89   * @desc:	SoC description for this instance
912cffb4ed8612 Nishanth Menon 2016-10-18   90   * @nb:	Reboot Notifier block
aa276781a64a5f Nishanth Menon 2016-10-18   91   * @d:		Debugfs file entry
aa276781a64a5f Nishanth Menon 2016-10-18   92   * @debug_region: Memory region where the debug message are available
aa276781a64a5f Nishanth Menon 2016-10-18   93   * @debug_region_size: Debug region size
aa276781a64a5f Nishanth Menon 2016-10-18   94   * @debug_buffer: Buffer allocated to copy debug messages.
aa276781a64a5f Nishanth Menon 2016-10-18   95   * @handle:	Instance of TI SCI handle to send to clients.
aa276781a64a5f Nishanth Menon 2016-10-18   96   * @cl:		Mailbox Client
aa276781a64a5f Nishanth Menon 2016-10-18   97   * @chan_tx:	Transmit mailbox channel
aa276781a64a5f Nishanth Menon 2016-10-18   98   * @chan_rx:	Receive mailbox channel
aa276781a64a5f Nishanth Menon 2016-10-18   99   * @minfo:	Message info
aa276781a64a5f Nishanth Menon 2016-10-18  100   * @node:	list head
e69a35531589a2 Nishanth Menon 2018-08-28  101   * @host_id:	Host ID
aa276781a64a5f Nishanth Menon 2016-10-18  102   * @users:	Number of users of this instance
aa276781a64a5f Nishanth Menon 2016-10-18  103   */
aa276781a64a5f Nishanth Menon 2016-10-18  104  struct ti_sci_info {
aa276781a64a5f Nishanth Menon 2016-10-18  105  	struct device *dev;
aa276781a64a5f Nishanth Menon 2016-10-18  106  	const struct ti_sci_desc *desc;
aa276781a64a5f Nishanth Menon 2016-10-18  107  	struct dentry *d;
aa276781a64a5f Nishanth Menon 2016-10-18  108  	void __iomem *debug_region;
aa276781a64a5f Nishanth Menon 2016-10-18  109  	char *debug_buffer;
aa276781a64a5f Nishanth Menon 2016-10-18  110  	size_t debug_region_size;
aa276781a64a5f Nishanth Menon 2016-10-18  111  	struct ti_sci_handle handle;
aa276781a64a5f Nishanth Menon 2016-10-18  112  	struct mbox_client cl;
aa276781a64a5f Nishanth Menon 2016-10-18  113  	struct mbox_chan *chan_tx;
aa276781a64a5f Nishanth Menon 2016-10-18  114  	struct mbox_chan *chan_rx;
aa276781a64a5f Nishanth Menon 2016-10-18  115  	struct ti_sci_xfers_info minfo;
aa276781a64a5f Nishanth Menon 2016-10-18  116  	struct list_head node;
e69a35531589a2 Nishanth Menon 2018-08-28  117  	u8 host_id;
aa276781a64a5f Nishanth Menon 2016-10-18  118  	/* protected by ti_sci_list_mutex */
aa276781a64a5f Nishanth Menon 2016-10-18  119  	int users;
aa276781a64a5f Nishanth Menon 2016-10-18 @120  };
aa276781a64a5f Nishanth Menon 2016-10-18  121  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

