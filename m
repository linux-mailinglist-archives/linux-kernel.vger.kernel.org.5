Return-Path: <linux-kernel+bounces-42483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A718401F3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40740284E3B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9315578A;
	Mon, 29 Jan 2024 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GApgcaWN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DA954FB2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521458; cv=none; b=FaaAABCRjIbIJi79tP/R8s9rbZJTHnLScCso5FDfvSqp7iuQ1v7SHoPS+z621+ca3nBJQKqYCkrSE1n+f89YFDn84KNXFXwUC9mPpbTkQ6u/EKR7VqpWN5+bppCz2662gFYdAgPkQS5xb0N5Rvw1OCp8pIlGbWRq2k8CUO3ShUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521458; c=relaxed/simple;
	bh=qDCHEW29ggobcosrJPkx3qZwMM1MmpCYr382y2sMQW4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=icdNeEaBupoLNgsAxOsFjkX9CicZ/xrZIuOsNIqzzqftRlEb9CHBUGzRHaMlSoijeX/XXcRToDr7gme6cF+spwHioqbDXT8fo+tHIXZaPnhvlgag6Ln/4mlEooY+3AystwxU5XpdFaGNigNUqPgX99KPjRvbPR3j0UUiH4mtwVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GApgcaWN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706521457; x=1738057457;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qDCHEW29ggobcosrJPkx3qZwMM1MmpCYr382y2sMQW4=;
  b=GApgcaWNkvBLCaQjhlMC+uDMN9WBcC4zzbhSc1aJkrUxwdt5Zzamtj0m
   kxJCEYJsZjvZwrH5iZEkbTa85cubtXTCTapjr0kN7kHSKyhX2d/cEgYyC
   A83PUtdvD+aAxzxtzNx5OYCtW/KmIr5ElFig/YBvp8U41jGcaIHkN079n
   NDgDMaKaJxh7sDd0r9WDoePphMvp1Y7AtnK9wOmRHHuY7zRNO11CFAGHm
   E3NP2ZPcJAPphYmI0dsVY2MA2TanlR0P/Hsvfl1ekO21toDvZxNUKmnrH
   3rO4jdoisZEjzGtr13Wma1PgVDoij2rUjit0livtH10K2GTnzTi6uJLAU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="2732991"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="2732991"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 01:44:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="858043828"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="858043828"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jan 2024 01:44:14 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUOBY-0004Cp-38;
	Mon, 29 Jan 2024 09:44:12 +0000
Date: Mon, 29 Jan 2024 17:43:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: drivers/of/unittest.c:573:43: error: 'struct device_node' has no
 member named 'kobj'
Message-ID: <202401291740.VP219WIz-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   41bccc98fb7931d63d03f326a746ac4d429c1dd3
commit: 4dde83569832f9377362e50f7748463340c5db6b of: Fix double free in of_parse_phandle_with_args_map
date:   3 weeks ago
config: arc-randconfig-r031-20230520 (https://download.01.org/0day-ci/archive/20240129/202401291740.VP219WIz-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240129/202401291740.VP219WIz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401291740.VP219WIz-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/of/unittest.c: In function 'of_unittest_parse_phandle_with_args_map':
>> drivers/of/unittest.c:573:43: error: 'struct device_node' has no member named 'kobj'
     573 |                 prefs[i] = kref_read(&p[i]->kobj.kref);
         |                                           ^~
   drivers/of/unittest.c:696:53: error: 'struct device_node' has no member named 'kobj'
     696 |                 unittest(prefs[i] == kref_read(&p[i]->kobj.kref),
         |                                                     ^~
   drivers/of/unittest.c:42:25: note: in definition of macro 'unittest'
      42 |         bool failed = !(result); \
         |                         ^~~~~~
   In file included from include/asm-generic/bug.h:22,
                    from arch/arc/include/asm/bug.h:30,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from include/linux/memblock.h:12,
                    from drivers/of/unittest.c:8:
   drivers/of/unittest.c:698:54: error: 'struct device_node' has no member named 'kobj'
     698 |                          i, prefs[i], kref_read(&p[i]->kobj.kref));
         |                                                      ^~
   include/linux/printk.h:427:33: note: in definition of macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:498:9: note: in expansion of macro 'printk'
     498 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   drivers/of/unittest.c:45:17: note: in expansion of macro 'pr_err'
      45 |                 pr_err("FAIL %s():%i " fmt, __func__, __LINE__, ##__VA_ARGS__); \
         |                 ^~~~~~
   drivers/of/unittest.c:696:17: note: in expansion of macro 'unittest'
     696 |                 unittest(prefs[i] == kref_read(&p[i]->kobj.kref),
         |                 ^~~~~~~~


vim +573 drivers/of/unittest.c

   548	
   549	static void __init of_unittest_parse_phandle_with_args_map(void)
   550	{
   551		struct device_node *np, *p[6] = {};
   552		struct of_phandle_args args;
   553		unsigned int prefs[6];
   554		int i, rc;
   555	
   556		np = of_find_node_by_path("/testcase-data/phandle-tests/consumer-b");
   557		if (!np) {
   558			pr_err("missing testcase data\n");
   559			return;
   560		}
   561	
   562		p[0] = of_find_node_by_path("/testcase-data/phandle-tests/provider0");
   563		p[1] = of_find_node_by_path("/testcase-data/phandle-tests/provider1");
   564		p[2] = of_find_node_by_path("/testcase-data/phandle-tests/provider2");
   565		p[3] = of_find_node_by_path("/testcase-data/phandle-tests/provider3");
   566		p[4] = of_find_node_by_path("/testcase-data/phandle-tests/provider4");
   567		p[5] = of_find_node_by_path("/testcase-data/phandle-tests/provider5");
   568		for (i = 0; i < ARRAY_SIZE(p); ++i) {
   569			if (!p[i]) {
   570				pr_err("missing testcase data\n");
   571				return;
   572			}
 > 573			prefs[i] = kref_read(&p[i]->kobj.kref);
   574		}
   575	
   576		rc = of_count_phandle_with_args(np, "phandle-list", "#phandle-cells");
   577		unittest(rc == 8, "of_count_phandle_with_args() returned %i, expected 7\n", rc);
   578	
   579		for (i = 0; i < 9; i++) {
   580			bool passed = true;
   581	
   582			memset(&args, 0, sizeof(args));
   583			rc = of_parse_phandle_with_args_map(np, "phandle-list",
   584							    "phandle", i, &args);
   585	
   586			/* Test the values from tests-phandle.dtsi */
   587			switch (i) {
   588			case 0:
   589				passed &= !rc;
   590				passed &= (args.np == p[1]);
   591				passed &= (args.args_count == 1);
   592				passed &= (args.args[0] == 1);
   593				break;
   594			case 1:
   595				passed &= !rc;
   596				passed &= (args.np == p[3]);
   597				passed &= (args.args_count == 3);
   598				passed &= (args.args[0] == 2);
   599				passed &= (args.args[1] == 5);
   600				passed &= (args.args[2] == 3);
   601				break;
   602			case 2:
   603				passed &= (rc == -ENOENT);
   604				break;
   605			case 3:
   606				passed &= !rc;
   607				passed &= (args.np == p[0]);
   608				passed &= (args.args_count == 0);
   609				break;
   610			case 4:
   611				passed &= !rc;
   612				passed &= (args.np == p[1]);
   613				passed &= (args.args_count == 1);
   614				passed &= (args.args[0] == 3);
   615				break;
   616			case 5:
   617				passed &= !rc;
   618				passed &= (args.np == p[0]);
   619				passed &= (args.args_count == 0);
   620				break;
   621			case 6:
   622				passed &= !rc;
   623				passed &= (args.np == p[2]);
   624				passed &= (args.args_count == 2);
   625				passed &= (args.args[0] == 15);
   626				passed &= (args.args[1] == 0x20);
   627				break;
   628			case 7:
   629				passed &= !rc;
   630				passed &= (args.np == p[3]);
   631				passed &= (args.args_count == 3);
   632				passed &= (args.args[0] == 2);
   633				passed &= (args.args[1] == 5);
   634				passed &= (args.args[2] == 3);
   635				break;
   636			case 8:
   637				passed &= (rc == -ENOENT);
   638				break;
   639			default:
   640				passed = false;
   641			}
   642	
   643			unittest(passed, "index %i - data error on node %s rc=%i\n",
   644				 i, args.np->full_name, rc);
   645	
   646			if (rc == 0)
   647				of_node_put(args.np);
   648		}
   649	
   650		/* Check for missing list property */
   651		memset(&args, 0, sizeof(args));
   652		rc = of_parse_phandle_with_args_map(np, "phandle-list-missing",
   653						    "phandle", 0, &args);
   654		unittest(rc == -ENOENT, "expected:%i got:%i\n", -ENOENT, rc);
   655	
   656		/* Check for missing cells,map,mask property */
   657		memset(&args, 0, sizeof(args));
   658	
   659		EXPECT_BEGIN(KERN_INFO,
   660			     "OF: /testcase-data/phandle-tests/consumer-b: could not get #phandle-missing-cells for /testcase-data/phandle-tests/provider1");
   661	
   662		rc = of_parse_phandle_with_args_map(np, "phandle-list",
   663						    "phandle-missing", 0, &args);
   664		EXPECT_END(KERN_INFO,
   665			   "OF: /testcase-data/phandle-tests/consumer-b: could not get #phandle-missing-cells for /testcase-data/phandle-tests/provider1");
   666	
   667		unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
   668	
   669		/* Check for bad phandle in list */
   670		memset(&args, 0, sizeof(args));
   671	
   672		EXPECT_BEGIN(KERN_INFO,
   673			     "OF: /testcase-data/phandle-tests/consumer-b: could not find phandle 12345678");
   674	
   675		rc = of_parse_phandle_with_args_map(np, "phandle-list-bad-phandle",
   676						    "phandle", 0, &args);
   677		EXPECT_END(KERN_INFO,
   678			   "OF: /testcase-data/phandle-tests/consumer-b: could not find phandle 12345678");
   679	
   680		unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
   681	
   682		/* Check for incorrectly formed argument list */
   683		memset(&args, 0, sizeof(args));
   684	
   685		EXPECT_BEGIN(KERN_INFO,
   686			     "OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found 1");
   687	
   688		rc = of_parse_phandle_with_args_map(np, "phandle-list-bad-args",
   689						    "phandle", 1, &args);
   690		EXPECT_END(KERN_INFO,
   691			   "OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found 1");
   692	
   693		unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
   694	
   695		for (i = 0; i < ARRAY_SIZE(p); ++i) {
   696			unittest(prefs[i] == kref_read(&p[i]->kobj.kref),
   697				 "provider%d: expected:%d got:%d\n",
   698				 i, prefs[i], kref_read(&p[i]->kobj.kref));
   699			of_node_put(p[i]);
   700		}
   701	}
   702	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

