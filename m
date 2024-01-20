Return-Path: <linux-kernel+bounces-31717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 959D68332F0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 07:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC2528490B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 06:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368ED1FD2;
	Sat, 20 Jan 2024 06:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bJdcXbsJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02044431;
	Sat, 20 Jan 2024 06:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705732055; cv=none; b=R5HlZ1UtGba5OruYvh08dgw7VwbfSjhFexanc3rP9d8NidbZ8y6rfg0hMGtm5++g88s6FgTXfTJsmVtVuR9r31xWPy3ek44/FrASBYUJUSxcatqa7mYNERgaEgDrJbm9a1NNB+cQNqaO/em4DjBlX/Zu6Ad1muAJtdWGkDenalk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705732055; c=relaxed/simple;
	bh=ENZRDDB6OFNaEid+YRV1CyFYF+SaQ8NAqewKmqAkLW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVzYI16bTsGIAApjySKjVZRzGdvaMnb/H4SoFM9qKeNVvaCngY3y8QxVK0zR8VyfljhP8bbLnFyOKzxjrUbk3Jt2b5LNLLD6lbIefAVIvgenebUBxdoLhIRNFvfPX0F1phawECPWfUjc7maU0DzGQiKseUC6QIUQN5IqAYNe53g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bJdcXbsJ; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705732052; x=1737268052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ENZRDDB6OFNaEid+YRV1CyFYF+SaQ8NAqewKmqAkLW8=;
  b=bJdcXbsJOSCr1Kdh/SGy/e+iw8NAFg25krDP5Vm0OHUc2ITAzojnE+/0
   LKmowH81yfikI5bKyX7Nv8WqT/aHiVtDzo8eSXPwidWHa++surg/jvtkx
   NZc+PJ53y36kzh+6mxYf5PvI+pWxJ38SU0oeJSD8zr3yywjex3b2CVg3Y
   hUK+2BKfNULJGwY6dSG2PXT+eU42RmdSLr+/sWPoO2JPe+L6/gpZ/RxMM
   K5f/BzarsXVX0BlWWYial8cN6/t9xf7MxMQppuK6gShwEda2ggb/8ECCH
   WIyGbJjB2Jg6xqL6fM0tC86giDHq0ZlTKZHHoBSOvp7hO3NMc80wT5WdZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="398079793"
X-IronPort-AV: E=Sophos;i="6.05,207,1701158400"; 
   d="scan'208";a="398079793"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 22:27:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,207,1701158400"; 
   d="scan'208";a="33580656"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 19 Jan 2024 22:27:29 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rR4pC-0004oo-34;
	Sat, 20 Jan 2024 06:27:26 +0000
Date: Sat, 20 Jan 2024 14:27:25 +0800
From: kernel test robot <lkp@intel.com>
To: Ye Bin <yebin10@huawei.com>, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	yebin10@huawei.com
Subject: Re: [PATCH 1/3] tracing/probes: support '%pd' type for print struct
 dentry's name
Message-ID: <202401201403.aTEbo79S-lkp@intel.com>
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
config: i386-randconfig-051-20240120 (https://download.01.org/0day-ci/archive/20240120/202401201403.aTEbo79S-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240120/202401201403.aTEbo79S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401201403.aTEbo79S-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/trace_probe.c:1107:8: warning: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Wformat]
    1106 |         if (snprintf(new_argv, len, "+0x%lx(%s)",
         |                                         ~~~
         |                                         %x
    1107 |                      offsetof(struct dentry, d_name.name), argv) >= len) {
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +1107 kernel/trace/trace_probe.c

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
  1106		if (snprintf(new_argv, len, "+0x%lx(%s)",
> 1107			     offsetof(struct dentry, d_name.name), argv) >= len) {
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

