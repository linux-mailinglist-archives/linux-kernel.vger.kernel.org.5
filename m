Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249B17BC533
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 08:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343604AbjJGGx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 02:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343634AbjJGGxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 02:53:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16007C6;
        Fri,  6 Oct 2023 23:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696661634; x=1728197634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lkjh2DlKGv+XkL1fsm3QR5cpnUjOHFrVxxfgTbR0pBY=;
  b=UJOOnAWxRKgldkQ3bDwobOMLLX8OSzMp6vwiS6NCwWQbglBRgzFtihgM
   YxwUE3YthjotfbhYbWMASb4V9XdnxWf0NMpElx4kuOqvpxIq1tNyYLAZI
   q0I5oRK5oSj6JgKRO/r4AjUV5yzpPx+r/MtzdAQEeQpjZxhH7HsZqZ3DS
   8Qu6Pc0E3VwmlylJo2w79xmJG1vpZYmiYCPyPvfKOIL4DdF+BpaXw3oQE
   DpvJKqeeUIVo34mM+d0jUTwcRSTTGG2mv/HHDHXysnOp7Vic7/xNvU4tn
   nUGvWIKuvzsjYBIeL5tl+Ihf1HLzSp6c3mRlxC8Cf75u9VmQfZJ/XebNB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="386738664"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="386738664"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 23:53:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="868600730"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="868600730"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 Oct 2023 23:53:49 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qp1C7-00043t-0Q;
        Sat, 07 Oct 2023 06:53:47 +0000
Date:   Sat, 7 Oct 2023 14:53:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Raymond <raymod2@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-serial <linux-serial@vger.kernel.org>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        Greg KH <greg@kroah.com>, andriy.shevchenko@linux.intel.com,
        quic_saipraka@quicinc.com, Steven Rostedt <rostedt@goodmis.org>
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4] arch/x86: port I/O tracing on x86
Message-ID: <202310071410.19ffOGGp-lkp@intel.com>
References: <80b84be0-a0ad-d1a9-607a-a87c6cf509e0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80b84be0-a0ad-d1a9-607a-a87c6cf509e0@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

kernel test robot noticed the following build errors:

[auto build test ERROR on be8b93b5cc7d533eb8c9b0590cdac055ecafe13a]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Raymond/arch-x86-port-I-O-tracing-on-x86/20231007-053424
base:   be8b93b5cc7d533eb8c9b0590cdac055ecafe13a
patch link:    https://lore.kernel.org/r/80b84be0-a0ad-d1a9-607a-a87c6cf509e0%40gmail.com
patch subject: [PATCH v4] arch/x86: port I/O tracing on x86
config: x86_64-randconfig-001-20231007 (https://download.01.org/0day-ci/archive/20231007/202310071410.19ffOGGp-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310071410.19ffOGGp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310071410.19ffOGGp-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: arch/x86/realmode/rm/wakemain.o: in function `__inb':
   arch/x86/include/asm/shared/io.h:31: undefined reference to `do_trace_portio_read'
   ld: arch/x86/realmode/rm/wakemain.o: in function `__outw':
   arch/x86/include/asm/shared/io.h:32: undefined reference to `do_trace_portio_write'
   ld: arch/x86/realmode/rm/wakemain.o: in function `__outb':
   arch/x86/include/asm/shared/io.h:31: undefined reference to `do_trace_portio_write'
>> ld: arch/x86/realmode/rm/wakemain.o:(__jump_table+0x8): undefined reference to `__tracepoint_portio_read'
>> ld: arch/x86/realmode/rm/wakemain.o:(__jump_table+0x14): undefined reference to `__tracepoint_portio_write'
   ld: arch/x86/realmode/rm/wakemain.o:(__jump_table+0x20): undefined reference to `__tracepoint_portio_write'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
