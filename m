Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76829782D78
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbjHUPr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjHUPr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:47:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4662EA1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692632874; x=1724168874;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d3pZfZEawwrZHOIzz7hdHhVIqdF64cGYlDu1k/VBMg4=;
  b=B631HFJRVSUbEe5i0bUvqmSi+3fP/NRNSMoFHRxn9CY4FCruG/Znkk0J
   gNL7mFjG+o/8eVDPlElce/c7ql4uwO1b4zX1KHEHobjqmtF5+vkJJFFfZ
   +/jhrtfiDjDcPzbryAliYz7aW+rzFDQnmw5hAThJxTv9N4CFiBwtjD02p
   NIj2HUipUkHFHC0HcSeteBjZ1B5hYZje07yFrOm58T6Zm2zBdw4Sqh+uC
   rlw/5fnbpFr3skOMDaibCyI4HPS+drch7KUWH+QPAIEyyKWn5L1l+2Eh2
   k8eiQ6Hzg6ysp9lYbr6t1No+AiuO70nnwic2ssID3WX3Rw/GL5yK1BGGk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="372526456"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="372526456"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 08:47:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="712828472"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="712828472"
Received: from lkp-server02.sh.intel.com (HELO 6809aa828f2a) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 21 Aug 2023 08:47:50 -0700
Received: from kbuild by 6809aa828f2a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qY789-0000eK-1z;
        Mon, 21 Aug 2023 15:47:49 +0000
Date:   Mon, 21 Aug 2023 23:47:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: shadow.c:(.text+0x80): multiple definition of `memset';
 arch/x86/lib/memset_64.o:(.noinstr.text+0x0): first defined here
Message-ID: <202308212351.kgRGqTiM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f7757129e3dea336c407551c98f50057c22bb266
commit: 69d4c0d3218692ffa56b0e1b9c76c50c699d7044 entry, kasan, x86: Disallow overriding mem*() functions
date:   7 months ago
config: um-randconfig-r036-20230821 (https://download.01.org/0day-ci/archive/20230821/202308212351.kgRGqTiM-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230821/202308212351.kgRGqTiM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308212351.kgRGqTiM-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: mm/kasan/shadow.o: in function `memset':
>> shadow.c:(.text+0x80): multiple definition of `memset'; arch/x86/lib/memset_64.o:(.noinstr.text+0x0): first defined here
   ld: mm/kasan/shadow.o: in function `memmove':
>> shadow.c:(.text+0x100): multiple definition of `memmove'; arch/x86/lib/memmove_64.o:(.noinstr.text+0x0): first defined here
   ld: mm/kasan/shadow.o: in function `memcpy':
>> shadow.c:(.text+0x180): multiple definition of `memcpy'; arch/x86/lib/memcpy_64.o:(.noinstr.text+0x0): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
