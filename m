Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46147EE8DE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 22:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjKPVn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 16:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKPVn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 16:43:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0D2D4D;
        Thu, 16 Nov 2023 13:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700171031; x=1731707031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SwVG/jvEau5UTgAvdXPnimEGYlUsxriyeiBCVMkNrtM=;
  b=XfyRIGvxjoFeFU4Uf1OZpPyWfkK6cBpOU/95iqVFzld5ZUy5s9u2AKSH
   GX8Es34Qd971avt2Q7AUZ4//gwkg9c/682YODPjdx/U/4AXZSUUQnJhls
   NrnqFWmKDc9KBYUeU7l5ZeVveg52a9/LkKuasSsN+fwu447kJyhRlJ/b7
   yiqwRwI8htTmMX/8gCTVj5cydXEplPWNXdZCmJbvV0qtaOdb3XQoBA+Dk
   3WUKpBck5Wcf3eBZr8CY6lpXjr7rM8nJsI1/LwdLSiU08BGAoatdj9q21
   kAc44GnNwmsyNmwzPPWQYKQVBxuYpbRdY/QCI8HTIu7SHa+P+Ft1A1F64
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="390043766"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="390043766"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 13:43:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="835874525"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="835874525"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 16 Nov 2023 13:43:43 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3k9F-00025L-2N;
        Thu, 16 Nov 2023 21:43:41 +0000
Date:   Fri, 17 Nov 2023 05:42:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH 27/32] s390/string: Add KMSAN support
Message-ID: <202311170550.bSBo44ix-lkp@intel.com>
References: <20231115203401.2495875-28-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115203401.2495875-28-iii@linux.ibm.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilya,

kernel test robot noticed the following build errors:

[auto build test ERROR on s390/features]
[also build test ERROR on akpm-mm/mm-everything linus/master vbabka-slab/for-next v6.7-rc1 next-20231116]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ilya-Leoshkevich/ftrace-Unpoison-ftrace_regs-in-ftrace_ops_list_func/20231116-045608
base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
patch link:    https://lore.kernel.org/r/20231115203401.2495875-28-iii%40linux.ibm.com
patch subject: [PATCH 27/32] s390/string: Add KMSAN support
config: s390-debug_defconfig (https://download.01.org/0day-ci/archive/20231117/202311170550.bSBo44ix-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231117/202311170550.bSBo44ix-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311170550.bSBo44ix-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390-linux-ld: arch/s390/mm/vmem.o: in function `crst_table_init':
>> arch/s390/include/asm/pgalloc.h:33:(.text+0x1ba): undefined reference to `memset64'
   s390-linux-ld: arch/s390/mm/vmem.o: in function `vmem_pte_alloc':
>> arch/s390/mm/vmem.c:68:(.ref.text+0x1ec): undefined reference to `memset64'
   s390-linux-ld: arch/s390/mm/pgalloc.o: in function `base_pgt_alloc':
>> arch/s390/mm/pgalloc.c:241:(.text+0x184): undefined reference to `memset64'
   s390-linux-ld: arch/s390/mm/pgalloc.o: in function `crst_table_init':
   arch/s390/include/asm/pgalloc.h:33:(.text+0x3e8): undefined reference to `memset64'
>> s390-linux-ld: arch/s390/include/asm/pgalloc.h:33:(.text+0x568): undefined reference to `memset64'
   s390-linux-ld: arch/s390/mm/pgalloc.o:arch/s390/include/asm/pgalloc.h:33: more undefined references to `memset64' follow
   s390-linux-ld: lib/test_string.o: in function `memset16_selftest':
>> lib/test_string.c:19:(.init.text+0x94): undefined reference to `memset16'
   s390-linux-ld: lib/test_string.o: in function `memset32_selftest':
>> lib/test_string.c:55:(.init.text+0x234): undefined reference to `memset32'
   s390-linux-ld: lib/test_string.o: in function `memset64_selftest':
>> lib/test_string.c:91:(.init.text+0x3c2): undefined reference to `memset64'
   s390-linux-ld: drivers/video/fbdev/core/fbcon.o: in function `scr_memsetw':
>> include/linux/vt_buffer.h:36:(.text+0x30f6): undefined reference to `memset16'
>> s390-linux-ld: include/linux/vt_buffer.h:36:(.text+0x320a): undefined reference to `memset16'
   s390-linux-ld: include/linux/vt_buffer.h:36:(.text+0x32c4): undefined reference to `memset16'
   s390-linux-ld: include/linux/vt_buffer.h:36:(.text+0x33b8): undefined reference to `memset16'
   s390-linux-ld: include/linux/vt_buffer.h:36:(.text+0x4f60): undefined reference to `memset16'
   s390-linux-ld: drivers/video/fbdev/core/fbcon.o:include/linux/vt_buffer.h:36: more undefined references to `memset16' follow
   s390-linux-ld: drivers/tty/vt/vt.o: in function `vc_uniscr_copy_area':
>> drivers/tty/vt/vt.c:464:(.text+0x107e): undefined reference to `memset32'
>> s390-linux-ld: drivers/tty/vt/vt.c:471:(.text+0x1104): undefined reference to `memset32'
   s390-linux-ld: drivers/tty/vt/vt.c:471:(.text+0x1118): undefined reference to `memset32'
   s390-linux-ld: drivers/tty/vt/vt.c:471:(.text+0x1140): undefined reference to `memset32'
   s390-linux-ld: drivers/tty/vt/vt.o: in function `vc_uniscr_insert':
   drivers/tty/vt/vt.c:374:(.text+0x13a4): undefined reference to `memset32'
   s390-linux-ld: drivers/tty/vt/vt.o:drivers/tty/vt/vt.c:385: more undefined references to `memset32' follow
   s390-linux-ld: drivers/tty/vt/vt.o: in function `scr_memsetw':
   include/linux/vt_buffer.h:36:(.text+0x2844): undefined reference to `memset16'
   s390-linux-ld: include/linux/vt_buffer.h:36:(.text+0x2932): undefined reference to `memset16'
   s390-linux-ld: include/linux/vt_buffer.h:36:(.text+0x2fe8): undefined reference to `memset16'
   s390-linux-ld: include/linux/vt_buffer.h:36:(.text+0x319c): undefined reference to `memset16'
   s390-linux-ld: drivers/tty/vt/vt.o: in function `vc_uniscr_clear_line':
   drivers/tty/vt/vt.c:393:(.text+0x3f78): undefined reference to `memset32'
   s390-linux-ld: drivers/tty/vt/vt.o: in function `vc_uniscr_clear_lines':
   drivers/tty/vt/vt.c:401:(.text+0x3fb8): undefined reference to `memset32'
   s390-linux-ld: drivers/tty/vt/vt.c:401:(.text+0x3fe2): undefined reference to `memset32'
   s390-linux-ld: drivers/tty/vt/vt.o: in function `scr_memsetw':
   include/linux/vt_buffer.h:36:(.text+0x4018): undefined reference to `memset16'
   s390-linux-ld: drivers/tty/vt/vt.o: in function `vc_uniscr_clear_lines':
   drivers/tty/vt/vt.c:401:(.text+0x40de): undefined reference to `memset32'
   s390-linux-ld: drivers/tty/vt/vt.c:401:(.text+0x4114): undefined reference to `memset32'
   s390-linux-ld: drivers/tty/vt/vt.c:401:(.text+0x4134): undefined reference to `memset32'
   s390-linux-ld: drivers/tty/vt/vt.o: in function `vc_uniscr_clear_line':
   drivers/tty/vt/vt.c:393:(.text+0x417c): undefined reference to `memset32'
   s390-linux-ld: drivers/tty/vt/vt.o: in function `vc_uniscr_clear_lines':
   drivers/tty/vt/vt.c:401:(.text+0x41d6): undefined reference to `memset32'
   s390-linux-ld: drivers/tty/vt/vt.o:drivers/tty/vt/vt.c:401: more undefined references to `memset32' follow
   s390-linux-ld: drivers/tty/vt/vt.o: in function `scr_memsetw':
   include/linux/vt_buffer.h:36:(.text+0x46d2): undefined reference to `memset16'
   s390-linux-ld: drivers/tty/vt/vt.o: in function `vc_uniscr_clear_lines':
   drivers/tty/vt/vt.c:401:(.text+0x4736): undefined reference to `memset32'
   s390-linux-ld: drivers/tty/vt/vt.c:401:(.text+0x47b6): undefined reference to `memset32'
   s390-linux-ld: drivers/tty/vt/vt.c:401:(.text+0x47f2): undefined reference to `memset32'
   s390-linux-ld: drivers/tty/vt/vt.c:401:(.text+0x482e): undefined reference to `memset32'
   s390-linux-ld: drivers/tty/vt/vt.o: in function `vc_uniscr_clear_line':
   drivers/tty/vt/vt.c:393:(.text+0x7b1a): undefined reference to `memset32'
   s390-linux-ld: drivers/tty/vt/vt.o: in function `scr_memsetw':
   include/linux/vt_buffer.h:36:(.text+0x7b30): undefined reference to `memset16'
   s390-linux-ld: drivers/tty/vt/vt.o: in function `vc_uniscr_clear_line':
   drivers/tty/vt/vt.c:393:(.text+0x7c7a): undefined reference to `memset32'
   s390-linux-ld: drivers/tty/vt/vt.o: in function `scr_memsetw':
   include/linux/vt_buffer.h:36:(.text+0x7c9c): undefined reference to `memset16'
   s390-linux-ld: drivers/block/zram/zram_drv.o: in function `memset_l':
>> include/linux/string.h:168:(.text+0x1860): undefined reference to `memset64'


vim +168 include/linux/string.h

3b3c4babd89871 Matthew Wilcox 2017-09-08  161  
3b3c4babd89871 Matthew Wilcox 2017-09-08  162  static inline void *memset_l(unsigned long *p, unsigned long v,
3b3c4babd89871 Matthew Wilcox 2017-09-08  163  		__kernel_size_t n)
3b3c4babd89871 Matthew Wilcox 2017-09-08  164  {
3b3c4babd89871 Matthew Wilcox 2017-09-08  165  	if (BITS_PER_LONG == 32)
3b3c4babd89871 Matthew Wilcox 2017-09-08  166  		return memset32((uint32_t *)p, v, n);
3b3c4babd89871 Matthew Wilcox 2017-09-08  167  	else
3b3c4babd89871 Matthew Wilcox 2017-09-08 @168  		return memset64((uint64_t *)p, v, n);
3b3c4babd89871 Matthew Wilcox 2017-09-08  169  }
3b3c4babd89871 Matthew Wilcox 2017-09-08  170  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
