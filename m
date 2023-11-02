Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F9B7DF088
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347286AbjKBKrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346647AbjKBKrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:47:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3849012E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 03:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698922033; x=1730458033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KH7vT1lEeEU0uB3WixM0UBZSUFvdyaK2lluLFuQhe+k=;
  b=lKuEEFJdHkRmcgtd8rR6DkcA+jOol3qcjCj2ZBi9f4LR4uyXMrXx+wPw
   2S6TMY/3mgXxJxIgoBKAnzasuCQS4vRPDOtia0r/0VxSMR44Qk4nPTsXq
   /mp0TlWWz4g39jSR69jgvHT5ls6IOienVpYexLgLq0G4pTfbVvjtxQw/+
   X93G5k+vr9rqH7S+YSqL7WKjMiqnuABhTW9aIsmPGRI2uzA3Hv58t2tuF
   P23J52xCzGYKGmX7VUmia1e8wkdm018AfIUirwNhJiZA/eRnAyKNXxct3
   bEONiqsOU/mjtRtE7/3Jqvlimkc0KSTJ30Z2sQc2ShEojlGx0vxDlgEBN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="419795664"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="419795664"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 03:47:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="790351817"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="790351817"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 02 Nov 2023 03:47:09 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyVEA-0001Q4-1m;
        Thu, 02 Nov 2023 10:47:06 +0000
Date:   Thu, 2 Nov 2023 18:46:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Danilo Krummrich <dakr@redhat.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     oe-kbuild-all@lists.linux.dev, nouveau@lists.freedesktop.org,
        Danilo Krummrich <dakr@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH drm-misc-next v8 09/12] drm/gpuvm: reference count
 drm_gpuvm structures
Message-ID: <202311021833.q8aYDJnr-lkp@intel.com>
References: <20231101233113.8059-10-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101233113.8059-10-dakr@redhat.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3c6c7ca4508b6cb1a033ac954c50a1b2c97af883]

url:    https://github.com/intel-lab-lkp/linux/commits/Danilo-Krummrich/drm-gpuvm-convert-WARN-to-drm_WARN-variants/20231102-073332
base:   3c6c7ca4508b6cb1a033ac954c50a1b2c97af883
patch link:    https://lore.kernel.org/r/20231101233113.8059-10-dakr%40redhat.com
patch subject: [PATCH drm-misc-next v8 09/12] drm/gpuvm: reference count drm_gpuvm structures
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20231102/202311021833.q8aYDJnr-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231102/202311021833.q8aYDJnr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311021833.q8aYDJnr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/drm_gpuvm.c:810: warning: expecting prototype for drm_gpuvm_bo_put(). Prototype was for drm_gpuvm_put() instead


vim +810 drivers/gpu/drm/drm_gpuvm.c

   801	
   802	/**
   803	 * drm_gpuvm_bo_put() - drop a struct drm_gpuvm reference
   804	 * @gpuvm: the &drm_gpuvm to release the reference of
   805	 *
   806	 * This releases a reference to @gpuvm.
   807	 */
   808	void
   809	drm_gpuvm_put(struct drm_gpuvm *gpuvm)
 > 810	{
   811		if (gpuvm)
   812			kref_put(&gpuvm->kref, drm_gpuvm_free);
   813	}
   814	EXPORT_SYMBOL_GPL(drm_gpuvm_put);
   815	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
