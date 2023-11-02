Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145EF7DEEBA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345481AbjKBJSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjKBJSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:18:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B056D139;
        Thu,  2 Nov 2023 02:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698916709; x=1730452709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WfXqmrEzL647g4xsumirECpBC8Tog1OcRNDIdE0JiIY=;
  b=ACPxe9hau5lNujwaKukcaiiyC/2bSuK3jrF7m0J9//U/OtMk53Ws3qrB
   ZUx605HbHBcLn1AeCDgyn6lgopmyOT7cQW/sThxCSNMK2nBZz9VOr3PCA
   7AGx64pbxnFctBc+XOdJppFozJ1xSGxZbU51ZQwUb9WrGa86idozDPhyQ
   03Lav+v9icphNOmXaSm5uCRjguwFdFwtflszIwuaxcbeFC8iW1BgmdPQg
   +RB8w9RPg05EM5AfS4z2hisHAcJHRnxSacaMn0M9uQl8vnz2Qx1wkfDyd
   rqC7frlo42ZyVdaHs9hKtXoS//14lzdOuPSmMo0/qKoG4mVQQud7raN26
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="388489394"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="388489394"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 02:18:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="796179820"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="796179820"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 02 Nov 2023 02:18:25 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyTqJ-0001JP-1B;
        Thu, 02 Nov 2023 09:18:23 +0000
Date:   Thu, 2 Nov 2023 17:18:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "xinglong.yang" <seanyang230@gmail.com>, xinglong.yang@cixtech.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver: thermal: simplify the traverse of sensor in
 thermal_zone.
Message-ID: <202311021624.jfMQm3Ox-lkp@intel.com>
References: <20231102055120.1192015-1-xinglong.yang@cixtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102055120.1192015-1-xinglong.yang@cixtech.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi xinglong.yang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on linus/master v6.6 next-20231102]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/xinglong-yang/driver-thermal-simplify-the-traverse-of-sensor-in-thermal_zone/20231102-135739
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20231102055120.1192015-1-xinglong.yang%40cixtech.com
patch subject: [PATCH] driver: thermal: simplify the traverse of sensor in thermal_zone.
config: loongarch-randconfig-001-20231102 (https://download.01.org/0day-ci/archive/20231102/202311021624.jfMQm3Ox-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231102/202311021624.jfMQm3Ox-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311021624.jfMQm3Ox-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/thermal/thermal_of.c: In function 'of_thermal_zone_find':
>> drivers/thermal/thermal_of.c:187:28: warning: unused variable 'i' [-Wunused-variable]
     187 |                 int count, i;
         |                            ^


vim +/i +187 drivers/thermal/thermal_of.c

d0c75fa2c17f08 Daniel Lezcano 2022-07-22  169  
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  170  static struct device_node *of_thermal_zone_find(struct device_node *sensor, int id)
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  171  {
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  172  	struct device_node *np, *tz;
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  173  	struct of_phandle_args sensor_specs;
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  174  
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  175  	np = of_find_node_by_name(NULL, "thermal-zones");
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  176  	if (!np) {
9d6792df07367a Daniel Lezcano 2022-08-09  177  		pr_debug("No thermal zones description\n");
9d6792df07367a Daniel Lezcano 2022-08-09  178  		return ERR_PTR(-ENODEV);
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  179  	}
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  180  
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  181  	/*
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  182  	 * Search for each thermal zone, a defined sensor
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  183  	 * corresponding to the one passed as parameter
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  184  	 */
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  185  	for_each_available_child_of_node(np, tz) {
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  186  
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05 @187  		int count, i;
d8c9a37137332e xinglong.yang  2023-11-02  188  		int ret;
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  189  
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  190  		count = of_count_phandle_with_args(tz, "thermal-sensors",
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  191  						   "#thermal-sensor-cells");
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  192  		if (count <= 0) {
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  193  			pr_err("%pOFn: missing thermal sensor\n", tz);
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  194  			tz = ERR_PTR(-EINVAL);
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  195  			goto out;
d8c9a37137332e xinglong.yang  2023-11-02  196  		} else if (count > 1) {
d8c9a37137332e xinglong.yang  2023-11-02  197  			pr_err("%pOFn: number of thermal sensor greater than one\n", tz);
d8c9a37137332e xinglong.yang  2023-11-02  198  			tz = ERR_PTR(-EINVAL);
d8c9a37137332e xinglong.yang  2023-11-02  199  			goto out;
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  200  		}
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  201  
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  202  		ret = of_parse_phandle_with_args(tz, "thermal-sensors",
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  203  						 "#thermal-sensor-cells",
d8c9a37137332e xinglong.yang  2023-11-02  204  						 0, &sensor_specs);
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  205  		if (ret < 0) {
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  206  			pr_err("%pOFn: Failed to read thermal-sensors cells: %d\n", tz, ret);
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  207  			tz = ERR_PTR(ret);
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  208  			goto out;
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  209  		}
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  210  
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  211  		if ((sensor == sensor_specs.np) && id == (sensor_specs.args_count ?
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  212  							  sensor_specs.args[0] : 0)) {
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  213  			pr_debug("sensor %pOFn id=%d belongs to %pOFn\n", sensor, id, tz);
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  214  			goto out;
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  215  		}
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  216  	}
9d6792df07367a Daniel Lezcano 2022-08-09  217  	tz = ERR_PTR(-ENODEV);
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  218  out:
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  219  	of_node_put(np);
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  220  	return tz;
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  221  }
3fd6d6e2b4e80f Daniel Lezcano 2022-08-05  222  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
