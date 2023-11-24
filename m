Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7497F730C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjKXLss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjKXLsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:48:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA63D5A;
        Fri, 24 Nov 2023 03:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700826531; x=1732362531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NWTZKPB6947/lzmM2oYhnJ+7TJUw4xxaIF4D9FZKFiY=;
  b=Gmuo1cfMaaVnDT/WjcuqmVQiagM01X0VvcPOUcfnz7EoQk6DXPOMTpk5
   3hXyfw9uGOhxmUZuSi9W4KX9H6Add8r3bhJjH1B8O4ETB+GCfBzw5lACg
   C7s/UrY7hB/cM5DyKxRsWg9s1PE9ZjNaZhHzHafOhg4FS9vIQ7icT9JOJ
   4NRWnFS8yzb5GX+9Bb0QMHXda3VamScgRxZmwY4rZrt9CCnIbFTpEMIrG
   gFCmTyvVYoEa415sy7G4GiPZI0xG7dgxVKPh9fhRfdXqB7FdeNsbC2zri
   bemJ25Ht51gsgrGxOAYBG/8Df1h97z/DBDTMhjiH40hgCOvw8tt6vdUXG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="377449233"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="377449233"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 03:48:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="1014884517"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="1014884517"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 24 Nov 2023 03:48:46 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6Ufr-0002iG-2D;
        Fri, 24 Nov 2023 11:48:43 +0000
Date:   Fri, 24 Nov 2023 19:47:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paran Lee <p4ranlee@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Li Dong <lidong@vivo.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     oe-kbuild-all@lists.linux.dev, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        shjy180909@gmail.com, austindh.kim@gmail.com, honggyu.kp@gmail.com,
        tegongkang@gmail.com, Paran Lee <p4ranlee@gmail.com>
Subject: Re: [PATCH] perf callchain: Support riscv cross-platform
Message-ID: <202311241453.S2nsKqhx-lkp@intel.com>
References: <20231122155548.2449-1-p4ranlee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122155548.2449-1-p4ranlee@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paran,

kernel test robot noticed the following build errors:

[auto build test ERROR on perf-tools-next/perf-tools-next]
[also build test ERROR on tip/perf/core perf-tools/perf-tools linus/master acme/perf/core v6.7-rc2 next-20231124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paran-Lee/perf-callchain-Support-riscv-cross-platform/20231123-000232
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20231122155548.2449-1-p4ranlee%40gmail.com
patch subject: [PATCH] perf callchain: Support riscv cross-platform
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231124/202311241453.S2nsKqhx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311241453.S2nsKqhx-lkp@intel.com/

All errors (new ones prefixed by >>):

   Makefile.config:1176: libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev
     PERF_VERSION = 6.6.rc1.g1f4d296e5f76
   util/unwind-libunwind.c: In function 'unwind__prepare_access':
>> util/unwind-libunwind.c:43:17: error: label 'out_register' used but not defined
      43 |                 goto out_register;
         |                 ^~~~
>> util/unwind-libunwind.c:28:13: error: unused variable 'err' [-Werror=unused-variable]
      28 |         int err;
         |             ^~~
>> util/unwind-libunwind.c:25:38: error: variable 'ops' set but not used [-Werror=unused-but-set-variable]
      25 |         struct unwind_libunwind_ops *ops = local_unwind_libunwind_ops;
         |                                      ^~~
   util/unwind-libunwind.c: At top level:
>> util/unwind-libunwind.c:58:11: error: expected identifier or '(' before 'else'
      58 |         } else if (!strcmp(arch, "riscv64") || !strcmp(arch, "riscv")) {
         |           ^~~~
>> util/unwind-libunwind.c:63:9: error: expected identifier or '(' before 'if'
      63 |         if (!ops) {
         |         ^~
>> util/unwind-libunwind.c:67:13: error: expected '=', ',', ';', 'asm' or '__attribute__' before ':' token
      67 | out_register:
         |             ^
>> util/unwind-libunwind.c:70:9: error: data definition has no type or storage class [-Werror]
      70 |         err = maps__unwind_libunwind_ops(maps)->prepare_access(maps);
         |         ^~~
>> util/unwind-libunwind.c:70:9: error: type defaults to 'int' in declaration of 'err' [-Werror=implicit-int]
>> util/unwind-libunwind.c:70:42: error: 'maps' undeclared here (not in a function)
      70 |         err = maps__unwind_libunwind_ops(maps)->prepare_access(maps);
         |                                          ^~~~
   util/unwind-libunwind.c:71:9: error: expected identifier or '(' before 'if'
      71 |         if (initialized)
         |         ^~
>> util/unwind-libunwind.c:73:9: error: expected identifier or '(' before 'return'
      73 |         return err;
         |         ^~~~~~
>> util/unwind-libunwind.c:74:1: error: expected identifier or '(' before '}' token
      74 | }
         | ^
   util/unwind-libunwind.c: In function 'unwind__flush_access':
>> util/unwind-libunwind.c:76:40: error: declaration of 'maps' shadows previous non-variable [-Werror=shadow]
      76 | void unwind__flush_access(struct maps *maps)
         |                           ~~~~~~~~~~~~~^~~~
   util/unwind-libunwind.c: In function 'unwind__finish_access':
   util/unwind-libunwind.c:84:41: error: declaration of 'maps' shadows previous non-variable [-Werror=shadow]
      84 | void unwind__finish_access(struct maps *maps)
         |                            ~~~~~~~~~~~~~^~~~
   util/unwind-libunwind.c: In function 'unwind__prepare_access':
>> util/unwind-libunwind.c:58:9: error: control reaches end of non-void function [-Werror=return-type]
      58 |         } else if (!strcmp(arch, "riscv64") || !strcmp(arch, "riscv")) {
         |         ^
   util/unwind-libunwind.c: At top level:
>> util/unwind-libunwind.c:16:13: error: 'unwind__register_ops' defined but not used [-Werror=unused-function]
      16 | static void unwind__register_ops(struct maps *maps, struct unwind_libunwind_ops *ops)
         |             ^~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
   make[7]: *** [tools/build/Makefile.build:105: tools/perf/util/unwind-libunwind.o] Error 1
   make[7]: *** Waiting for unfinished jobs....
   make[6]: *** [tools/build/Makefile.build:158: util] Error 2
   make[5]: *** [Makefile.perf:669: tools/perf/perf-in.o] Error 2
   make[5]: *** Waiting for unfinished jobs....
   make[4]: *** [Makefile.perf:242: sub-make] Error 2
   make[3]: *** [Makefile:70: all] Error 2
--
>> diff: tools/arch/riscv/include/uapi/asm/kvm.h: No such file or directory
     diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
     diff -u tools/include/uapi/linux/mount.h include/uapi/linux/mount.h
     diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h
     diff -u tools/arch/x86/include/asm/disabled-features.h arch/x86/include/asm/disabled-features.h
     diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
     diff -u tools/arch/x86/include/uapi/asm/prctl.h arch/x86/include/uapi/asm/prctl.h
     diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/include/uapi/asm/perf_regs.h
     diff -u tools/arch/s390/include/uapi/asm/kvm.h arch/s390/include/uapi/asm/kvm.h
     diff -u tools/arch/riscv/include/uapi/asm/kvm.h arch/riscv/include/uapi/asm/kvm.h
     diff -u tools/arch/riscv/include/uapi/asm/unistd.h arch/riscv/include/uapi/asm/unistd.h

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
