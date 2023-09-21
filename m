Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67BD7A9F92
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjIUUX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjIUUX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:23:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA94D317B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695320637; x=1726856637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FER1jYQhc8M1tjEdNOGxkEPhK/JmbN1nNqfHGK27t6I=;
  b=VlyYWtiKMSMUUlEHXOJl6DHjEHSgUw+uMcDK9pOck8RnM0YJWaOG3f32
   8KhhtdoAchLcnsDCdlNOViJokRU6038PVVuhjl8eJqzo7a9Yj9w4y97i/
   rgHzv9spNHhhJK8YobQ/vb1DxG4NAdh5zgOC48QUdXHfJQRg9+qDS93SL
   YRqqbmVLj3pmanQ5w9T+XG2yfBNAEBK9s8jX95UJ9DxBPXzY9tJkCSn21
   SzLfFGoi/fdQ/b/5H/DmRQ1R9lKuzb0CPBSGJPAWGWxDsIjqUouOTgcbk
   rkpgAlaIw3ns1J5ASGfFM8o0SBuqzONKFkbK3pd/ubsMxHPDekirSAj8m
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="444727682"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="444727682"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 11:23:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="782305204"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="782305204"
Received: from lkp-server02.sh.intel.com (HELO b77866e22201) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 21 Sep 2023 11:23:51 -0700
Received: from kbuild by b77866e22201 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjOL6-0000EZ-2P;
        Thu, 21 Sep 2023 18:23:48 +0000
Date:   Fri, 22 Sep 2023 02:23:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        linux-coco@lists.linux.dev, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virt: tdx-guest: Add Quote generation support using
 TSM_REPORTS
Message-ID: <202309220210.xtVRFXD8-lkp@intel.com>
References: <20230914031349.23516-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914031349.23516-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuppuswamy,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on linus/master v6.6-rc2 next-20230921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuppuswamy-Sathyanarayanan/virt-tdx-guest-Add-Quote-generation-support-using-TSM_REPORTS/20230914-111637
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20230914031349.23516-1-sathyanarayanan.kuppuswamy%40linux.intel.com
patch subject: [PATCH v2] virt: tdx-guest: Add Quote generation support using TSM_REPORTS
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230922/202309220210.xtVRFXD8-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230922/202309220210.xtVRFXD8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309220210.xtVRFXD8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/virt/coco/tdx-guest/tdx-guest.c:18:10: fatal error: linux/tsm.h: No such file or directory
      18 | #include <linux/tsm.h>
         |          ^~~~~~~~~~~~~
   compilation terminated.


vim +18 drivers/virt/coco/tdx-guest/tdx-guest.c

  > 18	#include <linux/tsm.h>
    19	#include <linux/sizes.h>
    20	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
