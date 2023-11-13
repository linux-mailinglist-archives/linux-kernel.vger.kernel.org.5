Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4262F7EA069
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjKMPpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjKMPpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:45:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 781501724
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:45:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88267FEC;
        Mon, 13 Nov 2023 07:46:03 -0800 (PST)
Received: from [10.57.83.127] (unknown [10.57.83.127])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C69D43F7B4;
        Mon, 13 Nov 2023 07:45:16 -0800 (PST)
Message-ID: <03b4e787-53bb-4a9c-afa5-dbb51599a8ce@arm.com>
Date:   Mon, 13 Nov 2023 15:45:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
To:     kernel test robot <lkp@intel.com>, loongarch@lists.linux.dev,
        chenhuacai@kernel.org, kernel@xen0n.name
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
References: <202311120926.cjYHyoYw-lkp@intel.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <202311120926.cjYHyoYw-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-12 1:38 am, kernel test robot wrote:
> Hi Robin,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
> commit: f9bd34e3753ea8f1433a3ba70f03a165a1416f98 perf/arm_cspmu: Clean up ACPI dependency
> date:   5 months ago
> config: loongarch-randconfig-r133-20231107 (https://download.01.org/0day-ci/archive/20231112/202311120926.cjYHyoYw-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231112/202311120926.cjYHyoYw-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311120926.cjYHyoYw-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>>> drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
>     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     expected void *ptr
>     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     got unsigned int [noderef] __percpu *

Unpicking the macros, I guess this must stem from:

for_each_sibling_event()
  -> lockdep_assert_event_ctx()
     ->this_cpu_read(hardirqs_enabled)

which appears to be the only obvious place to involve a __percpu pointer 
in this area.

 From there it would seem to be a preexisting Loongarch bug - AFAICS 
__percpu_read() (and presumably at least __percpu_write() as well) 
should not be expecting a raw void * argument, but still the __percpu 
pointer, since the final dereference is done right down in the asm using 
the per-cpu offset stashed in r21?

Thanks,
Robin.

>>> drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
>     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     expected void *ptr
>     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     got unsigned int [noderef] __percpu *
>>> drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
>     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     expected void *ptr
>     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     got unsigned int [noderef] __percpu *
>>> drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
>     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     expected void *ptr
>     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     got unsigned int [noderef] __percpu *
>>> drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
>     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     expected void *ptr
>     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     got int [noderef] __percpu *
>>> drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
>     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     expected void *ptr
>     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     got int [noderef] __percpu *
>>> drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
>     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     expected void *ptr
>     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     got int [noderef] __percpu *
>>> drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
>     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     expected void *ptr
>     drivers/perf/arm_cspmu/arm_cspmu.c:627:9: sparse:     got int [noderef] __percpu *
> 
> vim +627 drivers/perf/arm_cspmu/arm_cspmu.c
> 
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  609
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  610  /*
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  611   * Make sure the group of events can be scheduled at once
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  612   * on the PMU.
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  613   */
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  614  static bool arm_cspmu_validate_group(struct perf_event *event)
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  615  {
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  616  	struct perf_event *sibling, *leader = event->group_leader;
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  617  	struct arm_cspmu_hw_events fake_hw_events;
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  618
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  619  	if (event->group_leader == event)
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  620  		return true;
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  621
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  622  	memset(&fake_hw_events, 0, sizeof(fake_hw_events));
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  623
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  624  	if (!arm_cspmu_validate_event(event->pmu, &fake_hw_events, leader))
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  625  		return false;
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  626
> e37dfd65731dc4f Besar Wicaksono 2022-11-11 @627  	for_each_sibling_event(sibling, leader) {
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  628  		if (!arm_cspmu_validate_event(event->pmu, &fake_hw_events,
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  629  						  sibling))
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  630  			return false;
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  631  	}
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  632
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  633  	return arm_cspmu_validate_event(event->pmu, &fake_hw_events, event);
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  634  }
> e37dfd65731dc4f Besar Wicaksono 2022-11-11  635
> 
> :::::: The code at line 627 was first introduced by commit
> :::::: e37dfd65731dc4f001fa7dfa7f705e6840017d5a perf: arm_cspmu: Add support for ARM CoreSight PMU driver
> 
> :::::: TO: Besar Wicaksono <bwicaksono@nvidia.com>
> :::::: CC: Will Deacon <will@kernel.org>
> 
