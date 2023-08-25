Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0B5788E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 19:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjHYR5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 13:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjHYR4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:56:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706AD128;
        Fri, 25 Aug 2023 10:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692986212; x=1724522212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5mA1BB1ng/pSxiO+3a+3POJ6E3J5KrUpZIQcxCG61Bo=;
  b=SvEg80qwAUYA2YgTDmWECetQPNljXEzTyTmOWGWf+K0LCdyUddP4mN1c
   T6NSR/eSGi0jXiyFZk1BrOB7lOD6ebXx6Uuo39Qla5w1p6GfEOC0mGDfY
   KdLY9IAw4pQDgkjYeNZU+LWeTqWAVSc1sNN3dpAOBKfMIfq9rt/QQGKJ3
   pbRPzW17dYjIQOPDg0hN5dWOmRQtiGz3lEO9RZa1MzoLzzZNbqWLtc8tW
   ciSzU39qYIKpr4Qxy9U2x59xCCMW17iafDkh3tu+GAAJDXU16rSznagqS
   fGRJS4O/Y03zrdmkNF5MiWEG+v3m58kf1/CfFd6jI6EE0RT0a2VtVynqR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="364964595"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="364964595"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 10:56:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="911346167"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="911346167"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 10:56:50 -0700
Date:   Fri, 25 Aug 2023 10:56:48 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v4 7/7] selftests/resctrl: Adjust effective L3 cache size
 when SNC enabled
Message-ID: <ZOjrYB1UgtRchbXK@agluck-desk3>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230722190740.326190-1-tony.luck@intel.com>
 <20230722190740.326190-8-tony.luck@intel.com>
 <dc06f2ea-ed1e-60e5-f2d7-ccf7facde25b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc06f2ea-ed1e-60e5-f2d7-ccf7facde25b@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 10:33:43AM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 7/22/2023 12:07 PM, Tony Luck wrote:
> > Sub-NUMA Cluster divides CPUs sharing an L3 cache into separate NUMA
> > nodes. Systems may support splitting into either two or four nodes.
> > 
> > When SNC mode is enabled the effective amount of L3 cache available
> > for allocation is divided by the number of nodes per L3.
> > 
> > Detect which SNC mode is active by comparing the number of CPUs
> > that share a cache with CPU0, with the number of CPUs on node0.
> > 
> > Reported-by: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
> > Closes: https://lore.kernel.org/r/TYAPR01MB6330B9B17686EF426D2C3F308B25A@TYAPR01MB6330.jpnprd01.prod.outlook.com
> 
> This does not seem to be the case when looking at
> https://lore.kernel.org/all/TYAPR01MB6330A4EB3633B791939EA45E8B39A@TYAPR01MB6330.jpnprd01.prod.outlook.com/

Correct. I'll drop the "Closes:" tag.  I'm not sure what
the status is. Shaopeng didn't respond to my suggestion
to try "taskset(1)" when running the tests to check if
NUMA effects are causing the test to fail.

> 
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  tools/testing/selftests/resctrl/resctrl.h   |  1 +
> >  tools/testing/selftests/resctrl/resctrlfs.c | 57 +++++++++++++++++++++
> >  2 files changed, 58 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> > index 87e39456dee0..a8b43210b573 100644
> > --- a/tools/testing/selftests/resctrl/resctrl.h
> > +++ b/tools/testing/selftests/resctrl/resctrl.h
> > @@ -13,6 +13,7 @@
> >  #include <signal.h>
> >  #include <dirent.h>
> >  #include <stdbool.h>
> > +#include <ctype.h>
> >  #include <sys/stat.h>
> >  #include <sys/ioctl.h>
> >  #include <sys/mount.h>
> > diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> > index fb00245dee92..79eecbf9f863 100644
> > --- a/tools/testing/selftests/resctrl/resctrlfs.c
> > +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> > @@ -130,6 +130,61 @@ int get_resource_id(int cpu_no, int *resource_id)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Count number of CPUs in a /sys bit map
> > + */
> > +static int count_sys_bitmap_bits(char *name)
> > +{
> > +	FILE *fp = fopen(name, "r");
> > +	int count = 0, c;
> > +
> > +	if (!fp)
> > +		return 0;
> > +
> > +	while ((c = fgetc(fp)) != EOF) {
> > +		if (!isxdigit(c))
> > +			continue;
> > +		switch (c) {
> > +		case 'f':
> > +			count++;
> > +		case '7': case 'b': case 'd': case 'e':
> > +			count++;
> > +		case '3': case '5': case '6': case '9': case 'a': case 'c':
> > +			count++;
> > +		case '1': case '2': case '4': case '8':
> > +			count++;
> > +		}
> > +	}
> > +	fclose(fp);
> > +
> > +	return count;
> > +}
> > +
> > +/*
> > + * Detect SNC by compating #CPUs in node0 with #CPUs sharing LLC with CPU0
> > + * Try to get this right, even if a few CPUs are offline so that the number
> > + * of CPUs in node0 is not exactly half or a quarter of the CPUs sharing the
> > + * LLC of CPU0.
> > + */
> > +static int snc_ways(void)
> > +{
> > +	int node_cpus, cache_cpus;
> > +
> > +	node_cpus = count_sys_bitmap_bits("/sys/devices/system/node/node0/cpumap");
> > +	cache_cpus = count_sys_bitmap_bits("/sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_map");
> > +
> > +	if (!node_cpus || !cache_cpus) {
> > +		fprintf(stderr, "Warning could not determine Sub-NUMA Cluster mode\n");
> > +		return 1;
> > +	}
> > +
> > +	if (4 * node_cpus >= cache_cpus)
> > +		return 4;
> > +	else if (2 * node_cpus >= cache_cpus)
> > +		return 2;
> > +	return 1;
> > +}
> > +
> >  /*
> >   * get_cache_size - Get cache size for a specified CPU
> >   * @cpu_no:	CPU number
> > @@ -190,6 +245,8 @@ int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size)
> >  			break;
> >  	}
> >  
> > +	if (cache_num == 3)
> > +		*cache_size /= snc_ways();
> >  	return 0;
> >  }
> >  
> 
> I am surprised that this small change is sufficient. The resctrl
> selftests are definitely not NUMA aware and the CAT and CMT tests
> are not taking that into account when picking CPUs to run on. From
> what I understand LLC occupancy counters need to be added in this
> scenario but I do not see that done either.

This is a first step (the tests are definitely going to fail if
they have incorrect information about the cache size).

For a fully reliable set of tests some major surgery will be required
to bind to CPUs and memory to control allocation and access.

> 
> Reinette

-Tony
