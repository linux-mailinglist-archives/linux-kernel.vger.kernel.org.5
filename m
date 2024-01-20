Return-Path: <linux-kernel+bounces-31656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D84A83320C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC4A1C211CB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 01:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180A8A3C;
	Sat, 20 Jan 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DEoSlEre"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263AF7EE;
	Sat, 20 Jan 2024 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705712428; cv=none; b=qaqnEhb4Bzir5MEns7aY3oOViNUilQP+b56gecTIBMRDCTuXVKSAp72DyQuIKHo68TG9i1Bn6m4Oo+ddBuDzZFsI0r6cPUcuhzPO7UoAumZljee+1810GdlazswW5qKR1mmO1m0tJKHjgl2vVnRbIdNSCM0d0V/DkE2mKqNcLQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705712428; c=relaxed/simple;
	bh=UU78AjLsRGIao+d+hsqQWmqvxCN9e2tC4cM0iwRrczs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJmyZX5LodRNUqrULBFvfD9kvcHyh3hl5rhbUa4VC5/m+gZOLjsj2fa+sFQyUMEJnVAd2pd4y+45X8MqUggof9aQ3IwhFVGf6VcGwde1Q5RRAaH3AWXQ/7ikirwSzSyKOImE0g9MkxFsjxTCi5NyhCs/cfbXFGMmzaGz5jNJVZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DEoSlEre; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705712423; x=1737248423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UU78AjLsRGIao+d+hsqQWmqvxCN9e2tC4cM0iwRrczs=;
  b=DEoSlEreVENsrCEqqHLvIV5HDmfCCo3BkRJYXYXPpzsMVjNNWzBhksgG
   VdYim1hhFULovhCIBotXdGzgClv5Jm7qC1dHFt/IOjDEriBShR/0ESy7r
   LF2/sK/ORmRdz/mtvFHTdLooxBT6fQZhL9mAtlfUBQ1sRh7qncl4pOPy/
   AMGUFCF38iu1P6zqRZ+bSJLrCcNGoZM6AdoU3yQ8PHmQIeH3zOmNClHT1
   q0CrCaCkmEL6s4jUFArrH+oDmQTMFMP4g0BMJUgllgbWu/pNABseHu31Q
   qIN7oP6ZzdKqCQYeV4fVnahWeq6Rp8JY6KBLz7J0FKdbGCMErTdDZ0TKZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="400543612"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="400543612"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 17:00:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="1032089546"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="1032089546"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jan 2024 17:00:20 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQzic-0004YA-0q;
	Sat, 20 Jan 2024 01:00:18 +0000
Date: Sat, 20 Jan 2024 08:59:53 +0800
From: kernel test robot <lkp@intel.com>
To: Ye Bin <yebin10@huawei.com>, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	yebin10@huawei.com
Subject: Re: [PATCH 1/3] tracing/probes: support '%pd' type for print struct
 dentry's name
Message-ID: <202401200837.b9DEGdBT-lkp@intel.com>
References: <20240119013848.3111364-2-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119013848.3111364-2-yebin10@huawei.com>

Hi Ye,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7 next-20240119]
[cannot apply to rostedt-trace/for-next rostedt-trace/for-next-urgent]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ye-Bin/tracing-probes-support-pd-type-for-print-struct-dentry-s-name/20240119-093912
base:   linus/master
patch link:    https://lore.kernel.org/r/20240119013848.3111364-2-yebin10%40huawei.com
patch subject: [PATCH 1/3] tracing/probes: support '%pd' type for print struct dentry's name
config: i386-defconfig (https://download.01.org/0day-ci/archive/20240120/202401200837.b9DEGdBT-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240120/202401200837.b9DEGdBT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401200837.b9DEGdBT-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/trace_probe.c: In function 'traceprobe_expand_dentry':
>> kernel/trace/trace_probe.c:1106:36: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Wformat=]
     if (snprintf(new_argv, len, "+0x%lx(%s)",
                                     ~~^
                                     %x


vim +1106 kernel/trace/trace_probe.c

  1095	
  1096	static char* traceprobe_expand_dentry(const char *argv)
  1097	{
  1098		#define DENTRY_EXPAND_LEN 7  /* +0xXX() */
  1099		char *new_argv;
  1100		int len = strlen(argv) + 1 + DENTRY_EXPAND_LEN;
  1101	
  1102		new_argv = kmalloc(len, GFP_KERNEL);
  1103		if (!new_argv)
  1104			return NULL;
  1105	
> 1106		if (snprintf(new_argv, len, "+0x%lx(%s)",
  1107			     offsetof(struct dentry, d_name.name), argv) >= len) {
  1108			kfree(new_argv);
  1109			return NULL;
  1110		}
  1111	
  1112		return new_argv;
  1113	}
  1114	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

