Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5AE7D76C6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjJYV0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjJYV0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:26:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B331A6;
        Wed, 25 Oct 2023 14:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698269200; x=1729805200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QcRbBDBn8sT6LCxeJ7pPH2h7F8dhTxOz4sMgSXosL4c=;
  b=UKTCnw2fK3L++u4iJojX0f6Hy/3wX293pc0R5Pwu9yrfaXHl4ayLB8J4
   lLmI4YaKiR1SRezn31GpFTu23Y6HJxmk6EamO715UQ/Kh5v6KUlad9sae
   7aUUbYR7jMOuUyL7gg/uFZcZdRMfAddS78BasuB+vWHh70gKIsvTN5okt
   sHROKJLuFb3wMauLGaFv9VcTqlX2WrWwAJ7mwp+UlWJfjj3aqdqWsnVRW
   aSEFyrPwRSZYqTGasyN99q91I5ugPosceHiXbJv7saQvW16BglQsxBmly
   v5kzLkhNH75pHh7R1Rt8WRlGWGBfrhwHR8MAm/keE0sZai5KlX1bSqLjp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="366750725"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="366750725"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 14:26:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="902697016"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="902697016"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2023 14:24:12 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qvlOc-0009D4-02;
        Wed, 25 Oct 2023 21:26:34 +0000
Date:   Thu, 26 Oct 2023 05:26:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     jeshwank <JESHWANTHKUMAR.NK@amd.com>, thomas.lendacky@amd.com,
        john.allen@amd.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, jens.wiklander@linaro.org,
        sumit.garg@linaro.org, jarkko.nikula@linux.intel.com,
        mario.limonciello@amd.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     oe-kbuild-all@lists.linux.dev, Mythri.Pandeshwarakrishna@amd.com,
        Devaraj.Rangasamy@amd.com, Rijo-john.Thomas@amd.com,
        nimesh.easow@amd.com, JESHWANTHKUMAR.NK@amd.com
Subject: Re: [PATCH 2/3] crypto: ccp - Use psp_tee_alloc_buffer() and
 psp_tee_free_buffer()
Message-ID: <202310260529.GEey5HQc-lkp@intel.com>
References: <20231025065700.1556152-3-JESHWANTHKUMAR.NK@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025065700.1556152-3-JESHWANTHKUMAR.NK@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi jeshwank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on herbert-crypto-2.6/master]
[also build test WARNING on linus/master v6.6-rc7]
[cannot apply to herbert-cryptodev-2.6/master next-20231025]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/jeshwank/crypto-ccp-Add-function-to-allocate-and-free-memory-using-DMA-APIs/20231025-150420
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git master
patch link:    https://lore.kernel.org/r/20231025065700.1556152-3-JESHWANTHKUMAR.NK%40amd.com
patch subject: [PATCH 2/3] crypto: ccp - Use psp_tee_alloc_buffer() and psp_tee_free_buffer()
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231026/202310260529.GEey5HQc-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231026/202310260529.GEey5HQc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310260529.GEey5HQc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/crypto/ccp/tee-dev.c:123:24: warning: no previous prototype for 'tee_alloc_cmd_buffer' [-Wmissing-prototypes]
     123 | struct psp_tee_buffer *tee_alloc_cmd_buffer(struct psp_tee_device *tee)
         |                        ^~~~~~~~~~~~~~~~~~~~


vim +/tee_alloc_cmd_buffer +123 drivers/crypto/ccp/tee-dev.c

   122	
 > 123	struct psp_tee_buffer *tee_alloc_cmd_buffer(struct psp_tee_device *tee)
   124	{
   125		struct tee_init_ring_cmd *cmd;
   126		struct psp_tee_buffer *cmd_buffer;
   127	
   128		cmd_buffer = psp_tee_alloc_buffer(sizeof(*cmd),
   129						  GFP_KERNEL | __GFP_ZERO);
   130		if (!cmd_buffer)
   131			return NULL;
   132	
   133		cmd = (struct tee_init_ring_cmd *)cmd_buffer->vaddr;
   134		cmd->hi_addr = upper_32_bits(tee->rb_mgr.ring_buf->paddr);
   135		cmd->low_addr = lower_32_bits(tee->rb_mgr.ring_buf->paddr);
   136		cmd->size = tee->rb_mgr.ring_buf->size;
   137	
   138		dev_dbg(tee->dev, "tee: ring address: high = 0x%x low = 0x%x size = %u\n",
   139			cmd->hi_addr, cmd->low_addr, cmd->size);
   140	
   141		return cmd_buffer;
   142	}
   143	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
