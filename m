Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3892E7A722E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjITFiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjITFiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:38:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288488F;
        Tue, 19 Sep 2023 22:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695188292; x=1726724292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FJO6+FSsESzpwq9dG2x+ZpAjL1+/pV+QIsmIVesyPyg=;
  b=ELpjZ4jepI3TPKPl1ypZydRb9gwQUN/9kfy4Zf+f/EkEuFAIjkyShayc
   DBtOYz7/bYKx3rI9AtW3QvoyC5fx3oa58nRcJwHTBaMhMvzu3Vvl5aosK
   /Ro55gMKM1L6GrUYkO2z6zAzi4hYi4MvXWKJGwoooklZK1t44FtHplkuL
   aDrZSag6z+9n2gE6DL4+gUIH8rAETjN0aGxfYRWzya78Sxr6/mDOKBE+1
   2Zdhr7D1OCErQbSv1yZ9g/PuYe9nFfiUPfBf1mgQD80fUoX/FzEiCR04o
   OepQEw2U1fwQdPdszdFXeMDnHvFG5NqahWhkfyTEM9zVlatgCh0rJTRDh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="360386013"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="360386013"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 22:38:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="775843575"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="775843575"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 19 Sep 2023 22:38:08 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qipuY-0008Lx-1J;
        Wed, 20 Sep 2023 05:38:06 +0000
Date:   Wed, 20 Sep 2023 13:37:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Jung-uk Kim <jkim@freebsd.org>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: Re: [PATCH v1 1/1] acpica: use spinlocks to fix the data-races
 reported by the KCSAN
Message-ID: <202309201308.5ZBJFbjh-lkp@intel.com>
References: <20230920000139.15533-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920000139.15533-1-mirsad.todorovac@alu.unizg.hr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mirsad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc2 next-20230920]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mirsad-Goran-Todorovac/acpica-use-spinlocks-to-fix-the-data-races-reported-by-the-KCSAN/20230920-080345
base:   linus/master
patch link:    https://lore.kernel.org/r/20230920000139.15533-1-mirsad.todorovac%40alu.unizg.hr
patch subject: [PATCH v1 1/1] acpica: use spinlocks to fix the data-races reported by the KCSAN
config: i386-randconfig-012-20230920 (https://download.01.org/0day-ci/archive/20230920/202309201308.5ZBJFbjh-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230920/202309201308.5ZBJFbjh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309201308.5ZBJFbjh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/spinlock.h:89,
                    from include/linux/wait.h:9,
                    from include/linux/pid.h:6,
                    from include/linux/sched.h:14,
                    from include/acpi/platform/aclinux.h:55,
                    from include/acpi/platform/acenv.h:160,
                    from include/acpi/acpi.h:22,
                    from drivers/acpi/acpica/utdebug.c:12:
>> drivers/acpi/acpica/utdebug.c:19:24: warning: 'acpi_utdebug_lock' defined but not used [-Wunused-variable]
      19 | static DEFINE_SPINLOCK(acpi_utdebug_lock);
         |                        ^~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:43:39: note: in definition of macro 'DEFINE_SPINLOCK'
      43 | #define DEFINE_SPINLOCK(x) spinlock_t x = __SPIN_LOCK_UNLOCKED(x)
         |                                       ^


vim +/acpi_utdebug_lock +19 drivers/acpi/acpica/utdebug.c

    11	
  > 12	#include <acpi/acpi.h>
    13	#include "accommon.h"
    14	#include "acinterp.h"
    15	
    16	#define _COMPONENT          ACPI_UTILITIES
    17	ACPI_MODULE_NAME("utdebug")
    18	
  > 19	static DEFINE_SPINLOCK(acpi_utdebug_lock);
    20	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
