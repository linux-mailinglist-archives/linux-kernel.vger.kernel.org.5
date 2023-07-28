Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C8876650F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjG1HQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbjG1HQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:16:22 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05725212A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690528580; x=1722064580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RqAKBI2brZz0iglwT4+ws3oysl4sVcuHnFYFiwjZ04w=;
  b=Nvzfsi5lYXC5dm5LjD54LryhhJgRaZGqBMZGsqoXaqRWfhONUzbBmLcX
   jNtA8plhh88PrhJ/FcGId+Sip74OD6BwRkO7GrhtLmGYNxUjNbptGHYoa
   OZQHg3SWkcZdAX1DFBd4MVGke+89yK9fhcUTYf+UJG6k63zOXxbJR4+9K
   rvdf/Caz0K4wBkwfqS/lfgCwwhSmkDXhYuL5A18d2WZwq8tQ8OCscbI2p
   hlBhlp/04b2bNEd8s6j68aqg/VHePzG8Q9Zby1GFC19POQ34b0G/ZxZgp
   GHp+s2LGRkWm2KygI0AAWIuWXMlJyxmI7nUKc2TaFaHimh1S1Vl+v9Ehh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="432340444"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="432340444"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 00:15:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="870759216"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jul 2023 00:15:56 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPHha-0002yB-14;
        Fri, 28 Jul 2023 07:15:54 +0000
Date:   Fri, 28 Jul 2023 15:15:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Laight <David.Laight@aculab.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH next resend 5/5] minmax: Relax check to allow comparison
 between int and small unsigned constants.
Message-ID: <202307281520.WNoM3bxU-lkp@intel.com>
References: <48c2cd0407f14859919d4fcbe526234a@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48c2cd0407f14859919d4fcbe526234a@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.5-rc3 next-20230727]
[cannot apply to next-20230725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Laight/minmax-Allow-min-max-clamp-if-the-arguments-have-the-same-signedness/20230725-204940
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/48c2cd0407f14859919d4fcbe526234a%40AcuMS.aculab.com
patch subject: [PATCH next resend 5/5] minmax: Relax check to allow comparison between int and small unsigned constants.
config: microblaze-randconfig-r092-20230725 (https://download.01.org/0day-ci/archive/20230728/202307281520.WNoM3bxU-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230728/202307281520.WNoM3bxU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307281520.WNoM3bxU-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> crypto/skcipher.c:80:16: sparse: sparse: incompatible types for operation (>=):
>> crypto/skcipher.c:80:16: sparse:    unsigned char [usertype] *start
>> crypto/skcipher.c:80:16: sparse:    int
>> crypto/skcipher.c:80:16: sparse: sparse: bad constant expression type
>> crypto/skcipher.c:80:16: sparse: sparse: incompatible types for operation (>=):
>> crypto/skcipher.c:80:16: sparse:    unsigned char [usertype] *start
>> crypto/skcipher.c:80:16: sparse:    int
>> crypto/skcipher.c:80:16: sparse: sparse: incompatible types for operation (>=):
>> crypto/skcipher.c:80:16: sparse:    unsigned char [usertype] *end_page
>> crypto/skcipher.c:80:16: sparse:    int
>> crypto/skcipher.c:80:16: sparse: sparse: incompatible types for operation (>=):
>> crypto/skcipher.c:80:16: sparse:    unsigned char [usertype] *start
>> crypto/skcipher.c:80:16: sparse:    int
>> crypto/skcipher.c:80:16: sparse: sparse: incompatible types for operation (>=):
>> crypto/skcipher.c:80:16: sparse:    unsigned char [usertype] *end_page
>> crypto/skcipher.c:80:16: sparse:    int
   crypto/skcipher.c:80:16: sparse: sparse: incompatible types for operation (>):
   crypto/skcipher.c:80:16: sparse:    bad type __UNIQUE_ID___x297
   crypto/skcipher.c:80:16: sparse:    bad type __UNIQUE_ID___y298
>> crypto/skcipher.c:80:16: sparse: sparse: incompatible types for operation (>=):
>> crypto/skcipher.c:80:16: sparse:    unsigned char [usertype] *start
>> crypto/skcipher.c:80:16: sparse:    int
>> crypto/skcipher.c:80:16: sparse: sparse: incompatible types for operation (>=):
>> crypto/skcipher.c:80:16: sparse:    unsigned char [usertype] *end_page
>> crypto/skcipher.c:80:16: sparse:    int
   crypto/skcipher.c:80:16: sparse: sparse: incompatible types for operation (>):
   crypto/skcipher.c:80:16: sparse:    bad type __UNIQUE_ID___x297
   crypto/skcipher.c:80:16: sparse:    bad type __UNIQUE_ID___y298
>> crypto/skcipher.c:80:16: sparse: sparse: incompatible types for operation (>=):
>> crypto/skcipher.c:80:16: sparse:    unsigned char [usertype] *start
>> crypto/skcipher.c:80:16: sparse:    int
>> crypto/skcipher.c:80:16: sparse: sparse: incompatible types for operation (>=):
>> crypto/skcipher.c:80:16: sparse:    unsigned char [usertype] *end_page
>> crypto/skcipher.c:80:16: sparse:    int
   crypto/skcipher.c:80:16: sparse: sparse: incompatible types for operation (>):
   crypto/skcipher.c:80:16: sparse:    bad type __UNIQUE_ID___x297
   crypto/skcipher.c:80:16: sparse:    bad type __UNIQUE_ID___y298
>> crypto/skcipher.c:80:16: sparse: sparse: incompatible types for operation (>=):
>> crypto/skcipher.c:80:16: sparse:    unsigned char [usertype] *start
>> crypto/skcipher.c:80:16: sparse:    int
>> crypto/skcipher.c:80:16: sparse: sparse: incompatible types for operation (>=):
>> crypto/skcipher.c:80:16: sparse:    unsigned char [usertype] *end_page
>> crypto/skcipher.c:80:16: sparse:    int
   crypto/skcipher.c:80:16: sparse: sparse: incompatible types for operation (>):
   crypto/skcipher.c:80:16: sparse:    bad type __UNIQUE_ID___x297
   crypto/skcipher.c:80:16: sparse:    bad type __UNIQUE_ID___y298
--
   drivers/gpu/drm/drm_modes.c: note: in included file (through include/drm/drm_plane.h, include/drm/drm_crtc.h):
   include/drm/drm_color_mgmt.h:52:16: sparse: sparse: bad integer constant expression
   include/drm/drm_color_mgmt.h:52:16: sparse: sparse: static assertion failed: "clamp() low limit (typeof(val))(0) greater than high limit (typeof(val))(max)"
>> drivers/gpu/drm/drm_modes.c:2474:29: sparse: sparse: incompatible types for operation (>=):
>> drivers/gpu/drm/drm_modes.c:2474:29: sparse:    char *bpp_end_ptr
>> drivers/gpu/drm/drm_modes.c:2474:29: sparse:    int
>> drivers/gpu/drm/drm_modes.c:2474:29: sparse: sparse: bad constant expression type
>> drivers/gpu/drm/drm_modes.c:2474:29: sparse: sparse: incompatible types for operation (>=):
>> drivers/gpu/drm/drm_modes.c:2474:29: sparse:    char *[addressable] bpp_end_ptr
>> drivers/gpu/drm/drm_modes.c:2474:29: sparse:    int
>> drivers/gpu/drm/drm_modes.c:2474:29: sparse: sparse: incompatible types for operation (>=):
>> drivers/gpu/drm/drm_modes.c:2474:29: sparse:    char *[addressable] refresh_end_ptr
>> drivers/gpu/drm/drm_modes.c:2474:29: sparse:    int
>> drivers/gpu/drm/drm_modes.c:2474:29: sparse: sparse: incompatible types for operation (>=):
>> drivers/gpu/drm/drm_modes.c:2474:29: sparse:    char *[addressable] bpp_end_ptr
>> drivers/gpu/drm/drm_modes.c:2474:29: sparse:    int
>> drivers/gpu/drm/drm_modes.c:2474:29: sparse: sparse: incompatible types for operation (>=):
>> drivers/gpu/drm/drm_modes.c:2474:29: sparse:    char *[addressable] refresh_end_ptr
>> drivers/gpu/drm/drm_modes.c:2474:29: sparse:    int
   drivers/gpu/drm/drm_modes.c:2474:29: sparse: sparse: incompatible types for operation (>):
   drivers/gpu/drm/drm_modes.c:2474:29: sparse:    bad type __UNIQUE_ID___x334
   drivers/gpu/drm/drm_modes.c:2474:29: sparse:    bad type __UNIQUE_ID___y335
--
>> net/ceph/osdmap.c:1773:54: sparse: sparse: incompatible types for operation (>=):
>> net/ceph/osdmap.c:1773:54: sparse:    void *
>> net/ceph/osdmap.c:1773:54: sparse:    int
>> net/ceph/osdmap.c:1773:54: sparse: sparse: bad constant expression type
   net/ceph/osdmap.c:2000:46: sparse: sparse: incompatible types for operation (>=):
   net/ceph/osdmap.c:2000:46: sparse:    void *
   net/ceph/osdmap.c:2000:46: sparse:    int
   net/ceph/osdmap.c:2000:46: sparse: sparse: bad constant expression type
   net/ceph/osdmap.c:2007:57: sparse: sparse: incompatible types for operation (>=):
   net/ceph/osdmap.c:2007:57: sparse:    void *
   net/ceph/osdmap.c:2007:57: sparse:    int
   net/ceph/osdmap.c:2007:57: sparse: sparse: bad constant expression type
>> net/ceph/osdmap.c:1773:54: sparse: sparse: incompatible types for operation (>=):
>> net/ceph/osdmap.c:1773:54: sparse:    void *
>> net/ceph/osdmap.c:1773:54: sparse:    int
>> net/ceph/osdmap.c:1773:54: sparse: sparse: incompatible types for operation (>=):
>> net/ceph/osdmap.c:1773:54: sparse:    void *end
>> net/ceph/osdmap.c:1773:54: sparse:    int
>> net/ceph/osdmap.c:1773:54: sparse: sparse: incompatible types for operation (>=):
>> net/ceph/osdmap.c:1773:54: sparse:    void *
>> net/ceph/osdmap.c:1773:54: sparse:    int
>> net/ceph/osdmap.c:1773:54: sparse: sparse: incompatible types for operation (>=):
>> net/ceph/osdmap.c:1773:54: sparse:    void *end
>> net/ceph/osdmap.c:1773:54: sparse:    int
   net/ceph/osdmap.c:1773:54: sparse: sparse: incompatible types for operation (<):
   net/ceph/osdmap.c:1773:54: sparse:    bad type __UNIQUE_ID___x318
   net/ceph/osdmap.c:1773:54: sparse:    bad type __UNIQUE_ID___y319
   net/ceph/osdmap.c:2000:46: sparse: sparse: incompatible types for operation (>=):
   net/ceph/osdmap.c:2000:46: sparse:    void *
   net/ceph/osdmap.c:2000:46: sparse:    int
   net/ceph/osdmap.c:2000:46: sparse: sparse: incompatible types for operation (>=):
   net/ceph/osdmap.c:2000:46: sparse:    void *end
   net/ceph/osdmap.c:2000:46: sparse:    int
   net/ceph/osdmap.c:2000:46: sparse: sparse: incompatible types for operation (>=):
   net/ceph/osdmap.c:2000:46: sparse:    void *
   net/ceph/osdmap.c:2000:46: sparse:    int
   net/ceph/osdmap.c:2000:46: sparse: sparse: incompatible types for operation (>=):
   net/ceph/osdmap.c:2000:46: sparse:    void *end
   net/ceph/osdmap.c:2000:46: sparse:    int
   net/ceph/osdmap.c:2000:46: sparse: sparse: incompatible types for operation (<):
   net/ceph/osdmap.c:2000:46: sparse:    bad type __UNIQUE_ID___x322
   net/ceph/osdmap.c:2000:46: sparse:    bad type __UNIQUE_ID___y323
   net/ceph/osdmap.c:2007:57: sparse: sparse: incompatible types for operation (>=):
   net/ceph/osdmap.c:2007:57: sparse:    void *
   net/ceph/osdmap.c:2007:57: sparse:    int
   net/ceph/osdmap.c:2007:57: sparse: sparse: incompatible types for operation (>=):
   net/ceph/osdmap.c:2007:57: sparse:    void *end
   net/ceph/osdmap.c:2007:57: sparse:    int
   net/ceph/osdmap.c:2007:57: sparse: sparse: incompatible types for operation (>=):
   net/ceph/osdmap.c:2007:57: sparse:    void *
   net/ceph/osdmap.c:2007:57: sparse:    int
   net/ceph/osdmap.c:2007:57: sparse: sparse: incompatible types for operation (>=):
   net/ceph/osdmap.c:2007:57: sparse:    void *end
   net/ceph/osdmap.c:2007:57: sparse:    int
   net/ceph/osdmap.c:2007:57: sparse: sparse: incompatible types for operation (<):
   net/ceph/osdmap.c:2007:57: sparse:    bad type __UNIQUE_ID___x324
   net/ceph/osdmap.c:2007:57: sparse:    bad type __UNIQUE_ID___y325
--
>> lib/lzo/lzo1x_compress.c:53:54: sparse: sparse: incompatible types for operation (>=):
>> lib/lzo/lzo1x_compress.c:53:54: sparse:    unsigned char const *const ip_end
>> lib/lzo/lzo1x_compress.c:53:54: sparse:    int
>> lib/lzo/lzo1x_compress.c:53:54: sparse: sparse: bad constant expression type
>> lib/lzo/lzo1x_compress.c:53:54: sparse: sparse: incompatible types for operation (>=):
>> lib/lzo/lzo1x_compress.c:53:54: sparse:    unsigned char const *const ip_end
>> lib/lzo/lzo1x_compress.c:53:54: sparse:    int
>> lib/lzo/lzo1x_compress.c:53:54: sparse: sparse: incompatible types for operation (>=):
>> lib/lzo/lzo1x_compress.c:53:54: sparse:    unsigned char const *
>> lib/lzo/lzo1x_compress.c:53:54: sparse:    int
>> lib/lzo/lzo1x_compress.c:53:54: sparse: sparse: incompatible types for operation (>=):
>> lib/lzo/lzo1x_compress.c:53:54: sparse:    unsigned char const *const ip_end
>> lib/lzo/lzo1x_compress.c:53:54: sparse:    int
>> lib/lzo/lzo1x_compress.c:53:54: sparse: sparse: incompatible types for operation (>=):
>> lib/lzo/lzo1x_compress.c:53:54: sparse:    unsigned char const *
>> lib/lzo/lzo1x_compress.c:53:54: sparse:    int
   lib/lzo/lzo1x_compress.c:53:54: sparse: sparse: incompatible types for operation (<):
   lib/lzo/lzo1x_compress.c:53:54: sparse:    bad type __UNIQUE_ID___x182
   lib/lzo/lzo1x_compress.c:53:54: sparse:    bad type __UNIQUE_ID___y183

vim +80 crypto/skcipher.c

b286d8b1a69066 Herbert Xu 2016-11-22  72  
b286d8b1a69066 Herbert Xu 2016-11-22  73  /* Get a spot of the specified length that does not straddle a page.
b286d8b1a69066 Herbert Xu 2016-11-22  74   * The caller needs to ensure that there is enough space for this operation.
b286d8b1a69066 Herbert Xu 2016-11-22  75   */
b286d8b1a69066 Herbert Xu 2016-11-22  76  static inline u8 *skcipher_get_spot(u8 *start, unsigned int len)
b286d8b1a69066 Herbert Xu 2016-11-22  77  {
b286d8b1a69066 Herbert Xu 2016-11-22  78  	u8 *end_page = (u8 *)(((unsigned long)(start + len - 1)) & PAGE_MASK);
b286d8b1a69066 Herbert Xu 2016-11-22  79  
b286d8b1a69066 Herbert Xu 2016-11-22 @80  	return max(start, end_page);
b286d8b1a69066 Herbert Xu 2016-11-22  81  }
b286d8b1a69066 Herbert Xu 2016-11-22  82  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
