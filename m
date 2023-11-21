Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B207F3989
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbjKUWwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbjKUWwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:52:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D0ED51;
        Tue, 21 Nov 2023 14:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700607146; x=1732143146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Td2JHfbNsKOAb89T6hM4eAx8IpnMCzx9WqWHq/PDql4=;
  b=h5UhmADJQTvEteGaP30lVbl6fGOg8w50009t+RBhfEpu3oNxcE3nrWCu
   wMFqIwiOdkwZiIf/0ECy0cuMBlFRSQRmS/bATmATzJMqMu5RJtCyyqClR
   OBi3F2BtY7Nvg1jGw3/tBun8dgeCbcIws9ykpIaDKcYo2IP/Lgy5MA8/R
   4UoN8b1lgiwaGVUHWvI6f4S0XxG3gLclcvOX8oPAtUHi/WUNEpFQV9wD5
   T0xeZlZdbzbdS7B3eSrwNnEE4PG795UOqcH3OCywQ8mLnU8CKN9j4NDp6
   /hDWgf9kuy4s77hi7//wwk4pXTnIpfBJu+xEgGW/MLse2GyRdS+lfUG08
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="371290752"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="371290752"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 14:52:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="837191861"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="837191861"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 21 Nov 2023 14:52:20 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5ZbO-0008Mt-1Y;
        Tue, 21 Nov 2023 22:52:18 +0000
Date:   Wed, 22 Nov 2023 06:51:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        schakrabarti@microsoft.com, paulros@microsoft.com,
        Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Subject: Re: [PATCH V2 net-next] net: mana: Assigning IRQ affinity on HT cores
Message-ID: <202311220507.k0uewCr0-lkp@intel.com>
References: <1700574877-6037-1-git-send-email-schakrabarti@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1700574877-6037-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Souradeep,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Souradeep-Chakrabarti/net-mana-Assigning-IRQ-affinity-on-HT-cores/20231121-215912
base:   net-next/main
patch link:    https://lore.kernel.org/r/1700574877-6037-1-git-send-email-schakrabarti%40linux.microsoft.com
patch subject: [PATCH V2 net-next] net: mana: Assigning IRQ affinity on HT cores
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231122/202311220507.k0uewCr0-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311220507.k0uewCr0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311220507.k0uewCr0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/microsoft/mana/gdma_main.c:1253:5: warning: variable 'avail_cpus' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
           if(!alloc_cpumask_var(&filter_mask, GFP_KERNEL)
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/microsoft/mana/gdma_main.c:1343:19: note: uninitialized use occurs here
           free_cpumask_var(avail_cpus);
                            ^~~~~~~~~~
   drivers/net/ethernet/microsoft/mana/gdma_main.c:1253:5: note: remove the '||' if its condition is always false
           if(!alloc_cpumask_var(&filter_mask, GFP_KERNEL)
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/microsoft/mana/gdma_main.c:1249:39: note: initialize the variable 'avail_cpus' to silence this warning
           cpumask_var_t filter_mask, avail_cpus;
                                                ^
                                                 = NULL
>> drivers/net/ethernet/microsoft/mana/gdma_main.c:1253:5: warning: variable 'core_id_list' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if(!alloc_cpumask_var(&filter_mask, GFP_KERNEL)
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/microsoft/mana/gdma_main.c:1344:6: note: uninitialized use occurs here
           if (core_id_list)
               ^~~~~~~~~~~~
   drivers/net/ethernet/microsoft/mana/gdma_main.c:1253:2: note: remove the 'if' if its condition is always false
           if(!alloc_cpumask_var(&filter_mask, GFP_KERNEL)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/microsoft/mana/gdma_main.c:1253:5: warning: variable 'core_id_list' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
           if(!alloc_cpumask_var(&filter_mask, GFP_KERNEL)
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/microsoft/mana/gdma_main.c:1344:6: note: uninitialized use occurs here
           if (core_id_list)
               ^~~~~~~~~~~~
   drivers/net/ethernet/microsoft/mana/gdma_main.c:1253:5: note: remove the '||' if its condition is always false
           if(!alloc_cpumask_var(&filter_mask, GFP_KERNEL)
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/microsoft/mana/gdma_main.c:1248:28: note: initialize the variable 'core_id_list' to silence this warning
           unsigned int *core_id_list;
                                     ^
                                      = NULL
   3 warnings generated.


vim +1253 drivers/net/ethernet/microsoft/mana/gdma_main.c

  1245	
  1246	static int irq_setup(int *irqs, int nvec, int start_numa_node)
  1247	{
  1248		unsigned int *core_id_list;
  1249		cpumask_var_t filter_mask, avail_cpus;
  1250		int i, core_count = 0, cpu_count = 0, err = 0, node_count = 0;
  1251		unsigned int cpu_first, cpu, irq_start, cores = 0, numa_node = start_numa_node;
  1252	
> 1253		if(!alloc_cpumask_var(&filter_mask, GFP_KERNEL)
  1254				     || !alloc_cpumask_var(&avail_cpus, GFP_KERNEL)) {
  1255			err = -ENOMEM;
  1256			goto free_irq;
  1257		}
  1258		cpumask_copy(filter_mask, cpu_online_mask);
  1259		cpumask_copy(avail_cpus, cpu_online_mask);
  1260		/* count the number of cores
  1261		 */
  1262		for_each_cpu(cpu, filter_mask) {
  1263			cpumask_andnot(filter_mask, filter_mask, topology_sibling_cpumask(cpu));
  1264			cores++;
  1265		}
  1266		core_id_list = kcalloc(cores, sizeof(unsigned int), GFP_KERNEL);
  1267		cpumask_copy(filter_mask, cpu_online_mask);
  1268		/* initialize core_id_list array */
  1269		for_each_cpu(cpu, filter_mask) {
  1270			core_id_list[core_count] = cpu;
  1271			cpumask_andnot(filter_mask, filter_mask, topology_sibling_cpumask(cpu));
  1272			core_count++;
  1273		}
  1274	
  1275		/* if number of cpus are equal to max_queues per port, then
  1276		 * one extra interrupt for the hardware channel communication.
  1277		 */
  1278		if (nvec - 1 == num_online_cpus()) {
  1279			irq_start = 1;
  1280			cpu_first = cpumask_first(cpu_online_mask);
  1281			irq_set_affinity_and_hint(irqs[0], cpumask_of(cpu_first));
  1282		} else {
  1283			irq_start = 0;
  1284		}
  1285	
  1286		/* reset the core_count and num_node to 0.
  1287		 */
  1288		core_count = 0;
  1289	
  1290		/* for each interrupt find the cpu of a particular
  1291		 * sibling set and if it belongs to the specific numa
  1292		 * then assign irq to it and clear the cpu bit from
  1293		 * the corresponding avail_cpus.
  1294		 * Increase the cpu_count for that node.
  1295		 * Once all cpus for a numa node is assigned, then
  1296		 * move to different numa node and continue the same.
  1297		 */
  1298		for (i = irq_start; i < nvec; ) {
  1299	
  1300			/* check if the numa node has cpu or not
  1301			 * to avoid infinite loop.
  1302			 */
  1303			if (cpumask_empty(cpumask_of_node(numa_node))) {
  1304				numa_node++;
  1305				if (++node_count == num_online_nodes()) {
  1306					err = -EAGAIN;
  1307					goto free_irq;
  1308				}
  1309			}
  1310			cpu_first = cpumask_first_and(avail_cpus,
  1311						     topology_sibling_cpumask(core_id_list[core_count]));
  1312			if (cpu_first < nr_cpu_ids && cpu_to_node(cpu_first) == numa_node) {
  1313				irq_set_affinity_and_hint(irqs[i], cpumask_of(cpu_first));
  1314				cpumask_clear_cpu(cpu_first, avail_cpus);
  1315				cpu_count = cpu_count + 1;
  1316				i = i + 1;
  1317	
  1318				/* checking if all the cpus are used from the
  1319				 * particular node.
  1320				 */
  1321				if (cpu_count == nr_cpus_node(numa_node)) {
  1322					numa_node = numa_node + 1;
  1323					if (numa_node == num_online_nodes())
  1324						numa_node = 0;
  1325	
  1326					/* wrap around once numa nodes
  1327					 * are traversed.
  1328					 */
  1329					if (numa_node == start_numa_node) {
  1330						node_count = 0;
  1331						cpumask_copy(avail_cpus, cpu_online_mask);
  1332					}
  1333					cpu_count = 0;
  1334					core_count = 0;
  1335					continue;
  1336				}
  1337			}
  1338			if (++core_count == cores)
  1339				core_count = 0;
  1340		}
  1341	free_irq:
  1342		free_cpumask_var(filter_mask);
  1343		free_cpumask_var(avail_cpus);
  1344		if (core_id_list)
  1345			kfree(core_id_list);
  1346		return err;
  1347	}
  1348	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
