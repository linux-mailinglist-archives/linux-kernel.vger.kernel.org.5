Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0792C7A71D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjITFSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjITFSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:18:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F5AAB;
        Tue, 19 Sep 2023 22:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695187089; x=1726723089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vgocaKsbmdpjMaJx3xBQwNzNeJ/8n5uXEO7B6NpSHU4=;
  b=oADKTr2DFtzWBehzbU1b0dT+mrZZy3zWDyc9MBFFQirNhbUlVSKHkGKu
   S7jYZv6nbBrWsdQZcMkhMSyeSOf2/icYFuy+2N9BS++jZbjfeGoIoFbR0
   p2WHMIAeGCPfCa5eKNwz4LF+LFgHHkBIvrS4Bbazg/JA80+pEO7addN0t
   VNYMIWYZSZTFG/UKvE5zWKajG66DFGkxVpDy7Dd8g5nBv9xrElaGhN86e
   X6FeMU2bT1xO5RVAWPu+UR0PMBxX+ixeWL0748wjHfwVESREDyaTy/9t/
   KSWm768hyYpIBSsq1rFqbF23cVssppfiF8ErtSOhpTmfQtC7zt9K8NnH5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="383972294"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="383972294"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 22:18:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="775838770"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="775838770"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 19 Sep 2023 22:18:06 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qipb9-0008Km-36;
        Wed, 20 Sep 2023 05:18:03 +0000
Date:   Wed, 20 Sep 2023 13:17:11 +0800
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
Message-ID: <202309201331.S2c1JL2h-lkp@intel.com>
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
config: i386-randconfig-003-20230920 (https://download.01.org/0day-ci/archive/20230920/202309201331.S2c1JL2h-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230920/202309201331.S2c1JL2h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309201331.S2c1JL2h-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/acpi/acpica/utdebug.c: In function 'acpi_debug_print':
>> drivers/acpi/acpica/utdebug.c:145:13: warning: unused variable 'nesting_level' [-Wunused-variable]
     145 |         u32 nesting_level;
         |             ^~~~~~~~~~~~~


vim +/nesting_level +145 drivers/acpi/acpica/utdebug.c

   113	
   114	/*******************************************************************************
   115	 *
   116	 * FUNCTION:    acpi_debug_print
   117	 *
   118	 * PARAMETERS:  requested_debug_level - Requested debug print level
   119	 *              line_number         - Caller's line number (for error output)
   120	 *              function_name       - Caller's procedure name
   121	 *              module_name         - Caller's module name
   122	 *              component_id        - Caller's component ID
   123	 *              format              - Printf format field
   124	 *              ...                 - Optional printf arguments
   125	 *
   126	 * RETURN:      None
   127	 *
   128	 * DESCRIPTION: Print error message with prefix consisting of the module name,
   129	 *              line number, and component ID.
   130	 *
   131	 ******************************************************************************/
   132	
   133	void ACPI_INTERNAL_VAR_XFACE
   134	acpi_debug_print(u32 requested_debug_level,
   135			 u32 line_number,
   136			 const char *function_name,
   137			 const char *module_name,
   138			 u32 component_id, const char *format, ...)
   139	{
   140		acpi_thread_id thread_id;
   141		va_list args;
   142	#ifdef ACPI_APPLICATION
   143		int fill_count;
   144	#endif
 > 145		u32 nesting_level;
   146	
   147		/* Check if debug output enabled */
   148	
   149		if (!ACPI_IS_DEBUG_ENABLED(requested_debug_level, component_id)) {
   150			return;
   151		}
   152	
   153		/*
   154		 * Thread tracking and context switch notification
   155		 */
   156		thread_id = acpi_os_get_thread_id();
   157		if (thread_id != acpi_gbl_previous_thread_id) {
   158			if (ACPI_LV_THREADS & acpi_dbg_level) {
   159				acpi_os_printf
   160				    ("\n**** Context Switch from TID %u to TID %u ****\n\n",
   161				     (u32)acpi_gbl_previous_thread_id, (u32)thread_id);
   162			}
   163	
   164			acpi_gbl_previous_thread_id = thread_id;
   165			WRITE_ONCE(acpi_gbl_nesting_level, 0);
   166		}
   167	
   168		/*
   169		 * Display the module name, current line number, thread ID (if requested),
   170		 * current procedure nesting level, and the current procedure name
   171		 */
   172		acpi_os_printf("%9s-%04d ", module_name, line_number);
   173	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
