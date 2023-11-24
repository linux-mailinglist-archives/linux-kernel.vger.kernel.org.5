Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38817F79F4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 18:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346014AbjKXRA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 12:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbjKXRAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 12:00:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FE81FCA;
        Fri, 24 Nov 2023 09:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700845224; x=1732381224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CsPU2FoPcijKvs590lWs+PQl80hznLAFh85H8dFyWBo=;
  b=KjOE6EI6oztSxVG+fXW2brqC1gb7YbXzvGljechsOG46K3k2/CIT6sy2
   PgROhmH2+fXG7FyGjkNKzUyyBHkBk0eIF0/itthuO8iFqoozWqtVyJylc
   cHXr4AhsBmZ8PNlKBly5sKD6RbGZRk6kFTDjHdzv0D/mAsAKEmyA5xNz/
   JWB7E9HEzXnBJfWl4VfGmFcB63EhT/Fi+grCNV20bZNeNoaF7SrR6OQdY
   jNCjKcjMf+63Sgro2R6DcouXqsXIFZysYZITtNy9aa+SiTNsMvX+kcY4J
   cXR+jqNLbTzRVD4Z1lVWKNEckl03jEEBw3EtllG99GxnLZOhOmAkUf1CL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="372608744"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="372608744"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 09:00:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="717422043"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="717422043"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Nov 2023 09:00:20 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6ZXN-00036C-2w;
        Fri, 24 Nov 2023 17:00:17 +0000
Date:   Sat, 25 Nov 2023 00:59:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Li Dong <lidong@vivo.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhaimingbing <zhaimingbing@cmss.chinamobile.com>
Subject: Re: [PATCH] perf help:Fail check on dynamic allocation
Message-ID: <202311242306.fuT56YtA-lkp@intel.com>
References: <20231124083910.10169-1-zhaimingbing@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124083910.10169-1-zhaimingbing@cmss.chinamobile.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhaimingbing,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/perf/core]
[also build test ERROR on perf-tools/perf-tools acme/perf/core linus/master v6.7-rc2 next-20231124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/zhaimingbing/perf-help-Fail-check-on-dynamic-allocation/20231124-164725
base:   tip/perf/core
patch link:    https://lore.kernel.org/r/20231124083910.10169-1-zhaimingbing%40cmss.chinamobile.com
patch subject: [PATCH] perf help:Fail check on dynamic allocation
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231124/202311242306.fuT56YtA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311242306.fuT56YtA-lkp@intel.com/

All errors (new ones prefixed by >>):

   Makefile.config:1153: libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev
     PERF_VERSION = 6.7.rc1.g299992a2f4e2
   builtin-help.c: In function 'add_man_viewer':
>> builtin-help.c:200:24: error: 'return' with a value, in function returning void [-Werror=return-type]
     200 |                 return NULL;
         |                        ^~~~
   builtin-help.c:191:13: note: declared here
     191 | static void add_man_viewer(const char *name)
         |             ^~~~~~~~~~~~~~
   builtin-help.c: In function 'do_add_man_viewer_info':
   builtin-help.c:218:24: error: 'return' with a value, in function returning void [-Werror=return-type]
     218 |                 return NULL;
         |                        ^~~~
   builtin-help.c:212:13: note: declared here
     212 | static void do_add_man_viewer_info(const char *name,
         |             ^~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
   make[6]: *** [tools/build/Makefile.build:105: tools/perf/builtin-help.o] Error 1
   make[6]: *** Waiting for unfinished jobs....
   make[5]: *** [Makefile.perf:678: tools/perf/perf-in.o] Error 2
   make[5]: *** Waiting for unfinished jobs....
   make[4]: *** [Makefile.perf:242: sub-make] Error 2
   make[3]: *** [Makefile:70: all] Error 2

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
