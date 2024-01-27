Return-Path: <linux-kernel+bounces-41191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FCB83ED33
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29161C2170D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 13:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA522561D;
	Sat, 27 Jan 2024 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPpdFgeE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515992557F;
	Sat, 27 Jan 2024 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706361359; cv=none; b=Y1UGK5re3ac34IOZPHCXCAiNo9J97TainNFE5d+WXVhj/OJHgDgQOkkYG21udjHwNK1kki20/BQOmrjw+1LKe67XUC3UG3IzOxCpUgW60oX36kvkBFEYg2AEJIKS0Y70J8+ZO0XJ8joUmlbF7EbcT7DACjIneG9HaHRLSRb7GQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706361359; c=relaxed/simple;
	bh=E4mMh2ShPetQT/YuLHaTdv2SJvBmf/1otD9A5JgabtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZzFyjR7/sC++D4IDYHNWGKF4ZxDiYwCP+FPzJ6Jukiq059bsUehiPwNnrcXDVzj1krSoNqMQ21sQPnwVIT/wESHWfjc04yAJuUalR2laOGK0tOWLCyn2bnO22QyTmqDye7Yb2hCfq/yg9UH3V5O30DZisQgGspjuMrD8sUbLLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPpdFgeE; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706361358; x=1737897358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E4mMh2ShPetQT/YuLHaTdv2SJvBmf/1otD9A5JgabtI=;
  b=TPpdFgeEJRBsOZOHWYlFUEqis9Uw54xF/4NVrQXSPV3KwFGppV//IJo6
   ly0C5XFAEeFR6AdQ4zDOmKe26ouG9w2Iu8mLTNkiJEX/fTtnBa4BiseHX
   0z3mdQiOBuzGRxC5grwMupNFdntTL0OJc/8bd6NIPjaIfSDNLX9bERzbk
   TQR2PbGnz3G2bUy6KT63tvBBKi9gJIRBTmqzjpWpHeZMFVZf16qdefk/n
   pwRGl6TypDnjyodZQj7WTeWV3XqpvhanVaf0hxC8q4T1wQJMy/FLZ/T5F
   um6FH8/DlQrtFbRcmPGzwUvX9RC7OvqlgPJ4e0C3z5JRe/4XDSBMNB07I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9428494"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="9428494"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 05:15:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="35709003"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 27 Jan 2024 05:15:54 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTiXH-0002LF-38;
	Sat, 27 Jan 2024 13:15:51 +0000
Date: Sat, 27 Jan 2024 21:15:49 +0800
From: kernel test robot <lkp@intel.com>
To: Matthew Wood <thepacketgeek@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	leitao@debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/8] net: netconsole: cache userdata
 formatted string in netconsole_target
Message-ID: <202401272022.r5Z4OtUg-lkp@intel.com>
References: <20240126231348.281600-7-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126231348.281600-7-thepacketgeek@gmail.com>

Hi Matthew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wood/net-netconsole-cleanup-formatting-lints/20240127-072017
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240126231348.281600-7-thepacketgeek%40gmail.com
patch subject: [PATCH net-next v2 6/8] net: netconsole: cache userdata formatted string in netconsole_target
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20240127/202401272022.r5Z4OtUg-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240127/202401272022.r5Z4OtUg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401272022.r5Z4OtUg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/netconsole.c: In function 'update_userdata':
>> drivers/net/netconsole.c:649:26: warning: variable 'ud' set but not used [-Wunused-but-set-variable]
     649 |         struct userdata *ud;
         |                          ^~


vim +/ud +649 drivers/net/netconsole.c

   644	
   645	static void update_userdata(struct netconsole_target *nt)
   646	{
   647		int complete_idx = 0, child_count = 0;
   648		struct list_head *entry;
 > 649		struct userdata *ud;
   650	
   651		/* Clear the current string in case the last userdatum was deleted */
   652		nt->userdata_length = 0;
   653		nt->userdata_complete[0] = 0;
   654	
   655		ud = to_userdata(&nt->userdata_group.cg_item);
   656		list_for_each(entry, &nt->userdata_group.cg_children) {
   657			struct userdatum *udm_item;
   658			struct config_item *item;
   659	
   660			if (child_count >= MAX_USERDATA_ITEMS)
   661				break;
   662			child_count++;
   663	
   664			item = container_of(entry, struct config_item, ci_entry);
   665			udm_item = to_userdatum(item);
   666	
   667			/* Skip userdata with no value set */
   668			if (strnlen(udm_item->value, MAX_USERDATA_VALUE_LENGTH) == 0)
   669				continue;
   670	
   671			/* This doesn't overflow userdata_complete since it will write
   672			 * one entry length (1/MAX_USERDATA_ITEMS long), entry count is
   673			 * checked to not exceed MAX items with child_count above
   674			 */
   675			complete_idx += scnprintf(&nt->userdata_complete[complete_idx],
   676						  MAX_USERDATA_ENTRY_LENGTH, "%s=%s\n",
   677						  item->ci_name, udm_item->value);
   678		}
   679		nt->userdata_length = strnlen(nt->userdata_complete,
   680					      sizeof(nt->userdata_complete));
   681	}
   682	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

