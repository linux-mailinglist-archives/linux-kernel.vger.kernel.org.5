Return-Path: <linux-kernel+bounces-25359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE84882CE35
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 19:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F881C20D26
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 18:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E434D6123;
	Sat, 13 Jan 2024 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnBMUv8d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5FBD297
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705171520; x=1736707520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DiKdK26Z+8poFs8WzHPup5a3zK6NjPvep1ZdekuTEEI=;
  b=dnBMUv8diME1AomAMI4b9E/ApIhwkP+DM8dbnvTukK3+AJwLV1Aqrgqj
   DxHCWggI3eYwh3yO5EY2O5lZqntW+iDbUw1CvIAN/BhpOIcH9nhsLWlNE
   TsPk/0JreaIvSTTcyS0JQGXKdKHLDonfRBCkBb21ybP7SPz4ms0R4NP7d
   IxjasURSfK1KqFvsXwljsYMHWe/rymdSLdVcd6zSDYigSAo577Om0y3Ib
   aExY3EfJmhed1eOtALyLiSSFvJWOCxKAus4e3p4oBhIeLgAfuvZQlE//m
   EP1F2eMF7oeV3mzfWy2DCO7IB1Sj3j7/oRNpkTHk1CeAcK+eaWv6nEc8r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="6756351"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="6756351"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 10:45:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="817410207"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="817410207"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 13 Jan 2024 10:45:14 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOj0K-000AoW-1G;
	Sat, 13 Jan 2024 18:45:12 +0000
Date: Sun, 14 Jan 2024 02:45:06 +0800
From: kernel test robot <lkp@intel.com>
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 3/5] crash_dump: retrieve dm crypt key in kdump kernel
Message-ID: <202401140240.upb0a18s-lkp@intel.com>
References: <20240110071522.1308935-4-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110071522.1308935-4-coxu@redhat.com>

Hi Coiby,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on v6.7]
[cannot apply to linus/master next-20240112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/kexec_file-allow-to-place-kexec_buf-randomly/20240110-151859
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20240110071522.1308935-4-coxu%40redhat.com
patch subject: [PATCH v2 3/5] crash_dump: retrieve dm crypt key in kdump kernel
config: i386-buildonly-randconfig-003-20240113 (https://download.01.org/0day-ci/archive/20240114/202401140240.upb0a18s-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240114/202401140240.upb0a18s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401140240.upb0a18s-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/crash_dump_dm_crypt.c:29:16: warning: no previous prototype for 'dm_crypt_key_read' [-Wmissing-prototypes]
      29 | ssize_t __weak dm_crypt_key_read(char *buf, size_t count, u64 *ppos)
         |                ^~~~~~~~~~~~~~~~~
   kernel/crash_dump_dm_crypt.c:83:6: warning: no previous prototype for 'wipe_dm_crypt_key' [-Wmissing-prototypes]
      83 | void wipe_dm_crypt_key(void)
         |      ^~~~~~~~~~~~~~~~~
   kernel/crash_dump_dm_crypt.c: In function 'crash_load_dm_crypt_key':
   kernel/crash_dump_dm_crypt.c:207:16: error: variable 'kbuf' has initializer but incomplete type
     207 |         struct kexec_buf kbuf = {
         |                ^~~~~~~~~
   kernel/crash_dump_dm_crypt.c:208:18: error: 'struct kexec_buf' has no member named 'image'
     208 |                 .image = image,
         |                  ^~~~~
   kernel/crash_dump_dm_crypt.c:208:26: warning: excess elements in struct initializer
     208 |                 .image = image,
         |                          ^~~~~
   kernel/crash_dump_dm_crypt.c:208:26: note: (near initialization for 'kbuf')
   kernel/crash_dump_dm_crypt.c:209:18: error: 'struct kexec_buf' has no member named 'buf_min'
     209 |                 .buf_min = 0,
         |                  ^~~~~~~
   kernel/crash_dump_dm_crypt.c:209:28: warning: excess elements in struct initializer
     209 |                 .buf_min = 0,
         |                            ^
   kernel/crash_dump_dm_crypt.c:209:28: note: (near initialization for 'kbuf')
   kernel/crash_dump_dm_crypt.c:210:18: error: 'struct kexec_buf' has no member named 'buf_max'
     210 |                 .buf_max = ULONG_MAX,
         |                  ^~~~~~~
   In file included from include/linux/limits.h:7,
                    from include/linux/kernel.h:17,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/nospec-branch.h:14,
                    from arch/x86/include/asm/irqflags.h:9,
                    from include/linux/irqflags.h:17,
                    from include/linux/rcupdate.h:26,
                    from include/linux/rbtree.h:24,
                    from include/linux/key.h:15,
                    from kernel/crash_dump_dm_crypt.c:2:
   include/vdso/limits.h:13:25: warning: excess elements in struct initializer
      13 | #define ULONG_MAX       (~0UL)
         |                         ^
   kernel/crash_dump_dm_crypt.c:210:28: note: in expansion of macro 'ULONG_MAX'
     210 |                 .buf_max = ULONG_MAX,
         |                            ^~~~~~~~~
   include/vdso/limits.h:13:25: note: (near initialization for 'kbuf')
      13 | #define ULONG_MAX       (~0UL)
         |                         ^
   kernel/crash_dump_dm_crypt.c:210:28: note: in expansion of macro 'ULONG_MAX'
     210 |                 .buf_max = ULONG_MAX,
         |                            ^~~~~~~~~
   kernel/crash_dump_dm_crypt.c:211:18: error: 'struct kexec_buf' has no member named 'top_down'
     211 |                 .top_down = false,
         |                  ^~~~~~~~
   kernel/crash_dump_dm_crypt.c:211:29: warning: excess elements in struct initializer
     211 |                 .top_down = false,
         |                             ^~~~~
   kernel/crash_dump_dm_crypt.c:211:29: note: (near initialization for 'kbuf')
   kernel/crash_dump_dm_crypt.c:212:18: error: 'struct kexec_buf' has no member named 'random'
     212 |                 .random = true,
         |                  ^~~~~~
   kernel/crash_dump_dm_crypt.c:212:27: warning: excess elements in struct initializer
     212 |                 .random = true,
         |                           ^~~~
   kernel/crash_dump_dm_crypt.c:212:27: note: (near initialization for 'kbuf')
   kernel/crash_dump_dm_crypt.c:207:26: error: storage size of 'kbuf' isn't known
     207 |         struct kexec_buf kbuf = {
         |                          ^~~~
   kernel/crash_dump_dm_crypt.c:222:20: error: 'KEXEC_BUF_MEM_UNKNOWN' undeclared (first use in this function)
     222 |         kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
         |                    ^~~~~~~~~~~~~~~~~~~~~
   kernel/crash_dump_dm_crypt.c:222:20: note: each undeclared identifier is reported only once for each function it appears in
   kernel/crash_dump_dm_crypt.c:223:15: error: implicit declaration of function 'kexec_add_buffer' [-Werror=implicit-function-declaration]
     223 |         ret = kexec_add_buffer(&kbuf);
         |               ^~~~~~~~~~~~~~~~
   kernel/crash_dump_dm_crypt.c:207:26: warning: unused variable 'kbuf' [-Wunused-variable]
     207 |         struct kexec_buf kbuf = {
         |                          ^~~~
   cc1: some warnings being treated as errors


vim +/dm_crypt_key_read +29 kernel/crash_dump_dm_crypt.c

    25	
    26	/*
    27	 * Architectures may override this function to read dm crypt key
    28	 */
  > 29	ssize_t __weak dm_crypt_key_read(char *buf, size_t count, u64 *ppos)
    30	{
    31		struct kvec kvec = { .iov_base = buf, .iov_len = count };
    32		struct iov_iter iter;
    33	
    34		iov_iter_kvec(&iter, READ, &kvec, 1, count);
    35		return read_from_oldmem(&iter, count, ppos, false);
    36	}
    37	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

