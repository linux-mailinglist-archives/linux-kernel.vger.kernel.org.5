Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A777BDC44
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376409AbjJIMhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346437AbjJIMhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:37:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A26AAC;
        Mon,  9 Oct 2023 05:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696855033; x=1728391033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rw32ScfJPeLaNgNAcjsRTBfEMkPu9/ApTs6pmxzg8bI=;
  b=dhRPmYjDj43O4ywCR4QUu1VAevDFJphpU+nH+zyhNIDTHf6popbJ+zRI
   2m374XTKcDD8Exhx8TvT8GfFnhKGeGF+2T/2JKgNkNorddGw0Vt2RdQdp
   Af5b9hMIis07Lh3XjuQhANy/NTDh2zEVu1mvY/VogJqM86BjdqCc9drEG
   pl1E21PeZ+410UNNhkSh5KZWcWyIWfGhbK8osgQwwP74FsYc1fvnLkOS6
   m0BNG9O0RGARlHLeFYuk2M6ZtmgV9wbuOwrTkt/0ghuevOfk0Hr0nJxWE
   kdg2PQj1s0KC+h95886/aHcCKpEAHDc/BeyGpg3QnNwTORwFMHgaFxchD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="450631022"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="450631022"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 05:37:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="753003189"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="753003189"
Received: from lkp-server02.sh.intel.com (HELO 4ed589823ba4) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 09 Oct 2023 05:37:07 -0700
Received: from kbuild by 4ed589823ba4 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qppVQ-0000Cu-2E;
        Mon, 09 Oct 2023 12:37:04 +0000
Date:   Mon, 9 Oct 2023 20:36:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, x86@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, eranian@google.com, ananth.narayan@amd.com,
        ravi.bangoria@amd.com, santosh.shukla@amd.com, sandipan.das@amd.com
Subject: Re: [PATCH v2 2/6] perf/x86/amd/uncore: Move discovery and
 registration
Message-ID: <202310092019.yMh3nlyD-lkp@intel.com>
References: <e6c447e48872fcab8452e0dd81b1c9cb09f39eb4.1696425185.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6c447e48872fcab8452e0dd81b1c9cb09f39eb4.1696425185.git.sandipan.das@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandipan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/perf/core]
[also build test WARNING on perf-tools/perf-tools acme/perf/core linus/master v6.6-rc5 next-20231009]
[cannot apply to perf-tools-next/perf-tools-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sandipan-Das/perf-x86-amd-uncore-Move-discovery-and-registration/20231006-005053
base:   tip/perf/core
patch link:    https://lore.kernel.org/r/e6c447e48872fcab8452e0dd81b1c9cb09f39eb4.1696425185.git.sandipan.das%40amd.com
patch subject: [PATCH v2 2/6] perf/x86/amd/uncore: Move discovery and registration
config: i386-randconfig-061-20231009 (https://download.01.org/0day-ci/archive/20231009/202310092019.yMh3nlyD-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231009/202310092019.yMh3nlyD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310092019.yMh3nlyD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/x86/events/amd/uncore.c:601:10: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got union amd_uncore_info * @@
   arch/x86/events/amd/uncore.c:601:10: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/events/amd/uncore.c:601:10: sparse:     got union amd_uncore_info *
   arch/x86/events/amd/uncore.c:730:10: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got union amd_uncore_info * @@
   arch/x86/events/amd/uncore.c:730:10: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/events/amd/uncore.c:730:10: sparse:     got union amd_uncore_info *
>> arch/x86/events/amd/uncore.c:847:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected union amd_uncore_info *[noderef] info @@     got union amd_uncore_info [noderef] __percpu * @@
   arch/x86/events/amd/uncore.c:847:30: sparse:     expected union amd_uncore_info *[noderef] info
   arch/x86/events/amd/uncore.c:847:30: sparse:     got union amd_uncore_info [noderef] __percpu *
>> arch/x86/events/amd/uncore.c:881:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __percpu *__pdata @@     got union amd_uncore_info *[noderef] info @@
   arch/x86/events/amd/uncore.c:881:43: sparse:     expected void [noderef] __percpu *__pdata
   arch/x86/events/amd/uncore.c:881:43: sparse:     got union amd_uncore_info *[noderef] info
   arch/x86/events/amd/uncore.c:904:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __percpu *__pdata @@     got union amd_uncore_info *[noderef] info @@
   arch/x86/events/amd/uncore.c:904:35: sparse:     expected void [noderef] __percpu *__pdata
   arch/x86/events/amd/uncore.c:904:35: sparse:     got union amd_uncore_info *[noderef] info
   arch/x86/events/amd/uncore.c:358:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got union amd_uncore_info * @@
   arch/x86/events/amd/uncore.c:358:39: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/events/amd/uncore.c:358:39: sparse:     got union amd_uncore_info *
>> arch/x86/events/amd/uncore.c:358:39: sparse: sparse: dereference of noderef expression
   arch/x86/events/amd/uncore.c:358:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got union amd_uncore_info * @@
   arch/x86/events/amd/uncore.c:358:39: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/events/amd/uncore.c:358:39: sparse:     got union amd_uncore_info *
>> arch/x86/events/amd/uncore.c:358:39: sparse: sparse: dereference of noderef expression
   arch/x86/events/amd/uncore.c:601:10: sparse: sparse: dereference of noderef expression
>> arch/x86/events/amd/uncore.c:593:31: sparse: sparse: invalid access past the end of 'info' (4 8)
   arch/x86/events/amd/uncore.c:598:48: sparse: sparse: invalid access past the end of 'info' (4 8)
   arch/x86/events/amd/uncore.c:365:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got union amd_uncore_info * @@
   arch/x86/events/amd/uncore.c:365:39: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/events/amd/uncore.c:365:39: sparse:     got union amd_uncore_info *
   arch/x86/events/amd/uncore.c:365:39: sparse: sparse: dereference of noderef expression
   arch/x86/events/amd/uncore.c:730:10: sparse: sparse: dereference of noderef expression
   arch/x86/events/amd/uncore.c:724:31: sparse: sparse: invalid access past the end of 'info' (4 8)
   arch/x86/events/amd/uncore.c:365:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got union amd_uncore_info * @@
   arch/x86/events/amd/uncore.c:365:39: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/events/amd/uncore.c:365:39: sparse:     got union amd_uncore_info *
   arch/x86/events/amd/uncore.c:365:39: sparse: sparse: dereference of noderef expression
   arch/x86/events/amd/uncore.c:848:22: sparse: sparse: dereference of noderef expression
   arch/x86/events/amd/uncore.c:880:21: sparse: sparse: dereference of noderef expression
   arch/x86/events/amd/uncore.c:881:37: sparse: sparse: dereference of noderef expression
   arch/x86/events/amd/uncore.c:882:25: sparse: sparse: dereference of noderef expression
   arch/x86/events/amd/uncore.c:901:22: sparse: sparse: dereference of noderef expression
   arch/x86/events/amd/uncore.c:904:29: sparse: sparse: dereference of noderef expression
   arch/x86/events/amd/uncore.c:905:17: sparse: sparse: dereference of noderef expression

vim +601 arch/x86/events/amd/uncore.c

   582	
   583	static
   584	void amd_uncore_df_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
   585	{
   586		union cpuid_0x80000022_ebx ebx;
   587		union amd_uncore_info info;
   588	
   589		if (!boot_cpu_has(X86_FEATURE_PERFCTR_NB))
   590			return;
   591	
   592		info.split.aux_data = 0;
 > 593		info.split.num_pmcs = NUM_COUNTERS_NB;
   594		info.split.cid = topology_die_id(cpu);
   595	
   596		if (pmu_version >= 2) {
   597			ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
   598			info.split.num_pmcs = ebx.split.num_df_pmc;
   599		}
   600	
 > 601		*per_cpu_ptr(uncore->info, cpu) = info;
   602	}
   603	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
