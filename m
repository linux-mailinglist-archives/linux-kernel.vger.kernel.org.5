Return-Path: <linux-kernel+bounces-60869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E730850A5F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950171F220E3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4125C5FE;
	Sun, 11 Feb 2024 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C9tN2k5l"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A91F59B77
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707670506; cv=none; b=SQZ44d9h13kX0pzNRc80wjuW8kmSfuB48EyGjmfDB8zuXs3RMmS5rEvKcOor0byYsTEZK7n1iKiZec2K9Wn4Oo+4QARL4HE5rSrAfcPXJnQlaHfL4CMLymF9Wezn3QQ/GLqNCf6OXYeUR7PYphqYq7lXkf6n/OuoHtUzD49z6Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707670506; c=relaxed/simple;
	bh=IlT0PE1+gzAIEgJBXEZNWl6K0AeSvuJjkOi8ljZAQ14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blLERvwCYn/VERPDhHw0buVJZq0Jujrfsg4W6N4sXwxQEIo3GZAHaTxNyqRjvWt6s/LX98GVOlrKjHNtmyLebacb48079RNoSFN+6vBfBOwBibaqlTAgTn48qSebMNEvQj9mb9OqqmZlQRdl00c/6SDcbCY3HRYUxnuExsvADyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C9tN2k5l; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707670504; x=1739206504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IlT0PE1+gzAIEgJBXEZNWl6K0AeSvuJjkOi8ljZAQ14=;
  b=C9tN2k5lFMLJ+9Dbm/vQsSz/uBOXe3eITJ7dK7sfEl79ODci4rqocROa
   XSnX5Udf1OyFjpUWHUTByERtTyw4DdVMqulsv5rThIJQJeOcGG6T9IT0Q
   W8YdnpRrxVUGzyyYa0k2RSa8ELDW1MZt6khWYs7EuJJwOBJTEGIlD+m37
   DP5sMGlEu4/M8d1DyjtR3scMA3aCMn4XK9cMVz5ZmUX3QDJy8HL/t3k+0
   URCOf0MPPaQoVxz/fFAjmdriuK1Xw9b8YeDz9o7/y2ACXSTfQdP7HDpG1
   v8D3X1zGHRZMrA8ujSDV5n564e57NAWm3cAhmUTLhEO/3DQa+wORyDqYp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="4611769"
X-IronPort-AV: E=Sophos;i="6.05,261,1701158400"; 
   d="scan'208";a="4611769"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 08:55:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,261,1701158400"; 
   d="scan'208";a="7149548"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 11 Feb 2024 08:55:02 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZD6Z-0006gI-2N;
	Sun, 11 Feb 2024 16:54:59 +0000
Date: Mon, 12 Feb 2024 00:54:57 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH v3 02/35] include: remove unnecessary #include directives
Message-ID: <202402120009.8KkmWOh4-lkp@intel.com>
References: <20240211123000.3359365-3-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211123000.3359365-3-max.kellermann@ionos.com>

Hi Max,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240209]
[cannot apply to drm-misc/drm-misc-next media-tree/master mkp-scsi/for-next linus/master v6.8-rc3 v6.8-rc2 v6.8-rc1 v6.8-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Kellermann/include-add-missing-includes/20240211-204508
base:   next-20240209
patch link:    https://lore.kernel.org/r/20240211123000.3359365-3-max.kellermann%40ionos.com
patch subject: [PATCH v3 02/35] include: remove unnecessary #include directives
config: parisc-randconfig-002-20240211 (https://download.01.org/0day-ci/archive/20240212/202402120009.8KkmWOh4-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240212/202402120009.8KkmWOh4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402120009.8KkmWOh4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/debug/debug_core.c:169:1: warning: data definition has no type or storage class
     169 | NOKPROBE_SYMBOL(kgdb_arch_set_breakpoint);
         | ^~~~~~~~~~~~~~~
   kernel/debug/debug_core.c:169:1: error: type defaults to 'int' in declaration of 'NOKPROBE_SYMBOL' [-Werror=implicit-int]
>> kernel/debug/debug_core.c:169:1: warning: parameter names (without types) in function declaration
   kernel/debug/debug_core.c:176:1: warning: data definition has no type or storage class
     176 | NOKPROBE_SYMBOL(kgdb_arch_remove_breakpoint);
         | ^~~~~~~~~~~~~~~
   kernel/debug/debug_core.c:176:1: error: type defaults to 'int' in declaration of 'NOKPROBE_SYMBOL' [-Werror=implicit-int]
   kernel/debug/debug_core.c:176:1: warning: parameter names (without types) in function declaration
   kernel/debug/debug_core.c:206:1: warning: data definition has no type or storage class
     206 | NOKPROBE_SYMBOL(kgdb_arch_pc);
         | ^~~~~~~~~~~~~~~
   kernel/debug/debug_core.c:206:1: error: type defaults to 'int' in declaration of 'NOKPROBE_SYMBOL' [-Werror=implicit-int]
   kernel/debug/debug_core.c:206:1: warning: parameter names (without types) in function declaration
   kernel/debug/debug_core.c:217:1: warning: data definition has no type or storage class
     217 | NOKPROBE_SYMBOL(kgdb_skipexception);
         | ^~~~~~~~~~~~~~~
   kernel/debug/debug_core.c:217:1: error: type defaults to 'int' in declaration of 'NOKPROBE_SYMBOL' [-Werror=implicit-int]
   kernel/debug/debug_core.c:217:1: warning: parameter names (without types) in function declaration
   kernel/debug/debug_core.c:289:1: warning: data definition has no type or storage class
     289 | NOKPROBE_SYMBOL(kgdb_flush_swbreak_addr);
         | ^~~~~~~~~~~~~~~
   kernel/debug/debug_core.c:289:1: error: type defaults to 'int' in declaration of 'NOKPROBE_SYMBOL' [-Werror=implicit-int]
   kernel/debug/debug_core.c:289:1: warning: parameter names (without types) in function declaration
   kernel/debug/debug_core.c:317:1: warning: data definition has no type or storage class
     317 | NOKPROBE_SYMBOL(dbg_activate_sw_breakpoints);
         | ^~~~~~~~~~~~~~~
   kernel/debug/debug_core.c:317:1: error: type defaults to 'int' in declaration of 'NOKPROBE_SYMBOL' [-Werror=implicit-int]
   kernel/debug/debug_core.c:317:1: warning: parameter names (without types) in function declaration
   kernel/debug/debug_core.c:381:1: warning: data definition has no type or storage class
     381 | NOKPROBE_SYMBOL(dbg_deactivate_sw_breakpoints);
         | ^~~~~~~~~~~~~~~
   kernel/debug/debug_core.c:381:1: error: type defaults to 'int' in declaration of 'NOKPROBE_SYMBOL' [-Werror=implicit-int]
   kernel/debug/debug_core.c:381:1: warning: parameter names (without types) in function declaration
   kernel/debug/debug_core.c:514:1: warning: data definition has no type or storage class
     514 | NOKPROBE_SYMBOL(kgdb_io_ready);
         | ^~~~~~~~~~~~~~~
   kernel/debug/debug_core.c:514:1: error: type defaults to 'int' in declaration of 'NOKPROBE_SYMBOL' [-Werror=implicit-int]
   kernel/debug/debug_core.c:514:1: warning: parameter names (without types) in function declaration
   kernel/debug/debug_core.c:562:1: warning: data definition has no type or storage class
     562 | NOKPROBE_SYMBOL(kgdb_reenter_check);
         | ^~~~~~~~~~~~~~~
   kernel/debug/debug_core.c:562:1: error: type defaults to 'int' in declaration of 'NOKPROBE_SYMBOL' [-Werror=implicit-int]
   kernel/debug/debug_core.c:562:1: warning: parameter names (without types) in function declaration
   kernel/debug/debug_core.c:570:1: warning: data definition has no type or storage class
     570 | NOKPROBE_SYMBOL(dbg_touch_watchdogs);
         | ^~~~~~~~~~~~~~~
   kernel/debug/debug_core.c:570:1: error: type defaults to 'int' in declaration of 'NOKPROBE_SYMBOL' [-Werror=implicit-int]
   kernel/debug/debug_core.c:570:1: warning: parameter names (without types) in function declaration
   kernel/debug/debug_core.c:827:1: warning: data definition has no type or storage class
     827 | NOKPROBE_SYMBOL(kgdb_cpu_enter);
         | ^~~~~~~~~~~~~~~
   kernel/debug/debug_core.c:827:1: error: type defaults to 'int' in declaration of 'NOKPROBE_SYMBOL' [-Werror=implicit-int]
   kernel/debug/debug_core.c:827:1: warning: parameter names (without types) in function declaration
   kernel/debug/debug_core.c:872:1: warning: data definition has no type or storage class
     872 | NOKPROBE_SYMBOL(kgdb_handle_exception);
         | ^~~~~~~~~~~~~~~
   kernel/debug/debug_core.c:872:1: error: type defaults to 'int' in declaration of 'NOKPROBE_SYMBOL' [-Werror=implicit-int]
   kernel/debug/debug_core.c:872:1: warning: parameter names (without types) in function declaration
   kernel/debug/debug_core.c:907:1: warning: data definition has no type or storage class
     907 | NOKPROBE_SYMBOL(kgdb_nmicallback);
         | ^~~~~~~~~~~~~~~
   kernel/debug/debug_core.c:907:1: error: type defaults to 'int' in declaration of 'NOKPROBE_SYMBOL' [-Werror=implicit-int]
   kernel/debug/debug_core.c:907:1: warning: parameter names (without types) in function declaration
   kernel/debug/debug_core.c:933:1: warning: data definition has no type or storage class
     933 | NOKPROBE_SYMBOL(kgdb_nmicallin);
         | ^~~~~~~~~~~~~~~
   kernel/debug/debug_core.c:933:1: error: type defaults to 'int' in declaration of 'NOKPROBE_SYMBOL' [-Werror=implicit-int]
   kernel/debug/debug_core.c:933:1: warning: parameter names (without types) in function declaration
   cc1: some warnings being treated as errors


vim +169 kernel/debug/debug_core.c

dc7d552705215a kernel/kgdb.c             Jason Wessel      2008-04-17  148  
dc7d552705215a kernel/kgdb.c             Jason Wessel      2008-04-17  149  /*
dc7d552705215a kernel/kgdb.c             Jason Wessel      2008-04-17  150   * Finally, some KGDB code :-)
dc7d552705215a kernel/kgdb.c             Jason Wessel      2008-04-17  151   */
dc7d552705215a kernel/kgdb.c             Jason Wessel      2008-04-17  152  
dc7d552705215a kernel/kgdb.c             Jason Wessel      2008-04-17  153  /*
dc7d552705215a kernel/kgdb.c             Jason Wessel      2008-04-17  154   * Weak aliases for breakpoint management,
e16c33e290792c kernel/debug/debug_core.c Youling Tang      2020-08-07  155   * can be overridden by architectures when needed:
dc7d552705215a kernel/kgdb.c             Jason Wessel      2008-04-17  156   */
98b54aa1a2241b kernel/debug/debug_core.c Jason Wessel      2012-03-21  157  int __weak kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
dc7d552705215a kernel/kgdb.c             Jason Wessel      2008-04-17  158  {
dc7d552705215a kernel/kgdb.c             Jason Wessel      2008-04-17  159  	int err;
dc7d552705215a kernel/kgdb.c             Jason Wessel      2008-04-17  160  
fe557319aa06c2 kernel/debug/debug_core.c Christoph Hellwig 2020-06-17  161  	err = copy_from_kernel_nofault(bpt->saved_instr, (char *)bpt->bpt_addr,
98b54aa1a2241b kernel/debug/debug_core.c Jason Wessel      2012-03-21  162  				BREAK_INSTR_SIZE);
dc7d552705215a kernel/kgdb.c             Jason Wessel      2008-04-17  163  	if (err)
dc7d552705215a kernel/kgdb.c             Jason Wessel      2008-04-17  164  		return err;
fe557319aa06c2 kernel/debug/debug_core.c Christoph Hellwig 2020-06-17  165  	err = copy_to_kernel_nofault((char *)bpt->bpt_addr,
98b54aa1a2241b kernel/debug/debug_core.c Jason Wessel      2012-03-21  166  				 arch_kgdb_ops.gdb_bpt_instr, BREAK_INSTR_SIZE);
98b54aa1a2241b kernel/debug/debug_core.c Jason Wessel      2012-03-21  167  	return err;
dc7d552705215a kernel/kgdb.c             Jason Wessel      2008-04-17  168  }
4c4197eda710d1 kernel/debug/debug_core.c Daniel Thompson   2020-09-27 @169  NOKPROBE_SYMBOL(kgdb_arch_set_breakpoint);
dc7d552705215a kernel/kgdb.c             Jason Wessel      2008-04-17  170  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

