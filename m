Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964527AC335
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 17:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjIWPYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 11:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjIWPYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 11:24:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D904193;
        Sat, 23 Sep 2023 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695482673; x=1727018673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ojI4s1wPBBnFIMYvl5fmYJRtR96GMyfGr6X3iwZe/dc=;
  b=ZZYRH1+7CtIiLeqBauUmKLCLF+Xh4T8fp5JvAagRK1Zrjm5vCQck375L
   ksL41bJ9h7vk1VfRDmTz07Nl+D98TuR2TEIB7U8uw2mtv1RBr19sbe+/i
   vFzqxCGs4M7YwJ1zO0XMnTJ+Xea1FwvNwSwyZqWsq4DJ3WCZufQwHIL1P
   SfMjh6QFRfdOhFNcbXWElGl4S3NGxAAqdgswS0Doz8EhsYm7gCLLXx0zg
   wpggFghpK13OlDOAY9o/84giFXNG+rDbHFlZdduhrX+zzA/i4vksL0HiM
   bYRCmK1763qaKrdDgcte4UvN+Xh5mkw9R3kJuMNvvakp1w4bS5Be1R+3k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="383786109"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="383786109"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2023 08:24:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="777189471"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="777189471"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 23 Sep 2023 08:24:29 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qk4Uc-0002Vv-2w;
        Sat, 23 Sep 2023 15:24:26 +0000
Date:   Sat, 23 Sep 2023 23:24:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 12/18] net/smc: implement DMB-related operations
 of loopback
Message-ID: <202309232327.nzXalNsH-lkp@intel.com>
References: <1695134522-126655-13-git-send-email-guwen@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695134522-126655-13-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Wen-Gu/net-smc-decouple-ism_dev-from-SMC-D-device-dump/20230920-010019
base:   net-next/main
patch link:    https://lore.kernel.org/r/1695134522-126655-13-git-send-email-guwen%40linux.alibaba.com
patch subject: [PATCH net-next 12/18] net/smc: implement DMB-related operations of loopback
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20230923/202309232327.nzXalNsH-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230923/202309232327.nzXalNsH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309232327.nzXalNsH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/smc/smc_loopback.c: In function 'smc_lo_register_dmb':
>> net/smc/smc_loopback.c:107:30: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     107 |         dmb_node->dma_addr = (dma_addr_t)dmb_node->cpu_addr;
         |                              ^


vim +107 net/smc/smc_loopback.c

    76	
    77	static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
    78				       void *client_priv)
    79	{
    80		struct smc_lo_dmb_node *dmb_node, *tmp_node;
    81		struct smc_lo_dev *ldev = smcd->priv;
    82		int sba_idx, rc;
    83	
    84		/* check space for new dmb */
    85		for_each_clear_bit(sba_idx, ldev->sba_idx_mask, SMC_LODEV_MAX_DMBS) {
    86			if (!test_and_set_bit(sba_idx, ldev->sba_idx_mask))
    87				break;
    88		}
    89		if (sba_idx == SMC_LODEV_MAX_DMBS)
    90			return -ENOSPC;
    91	
    92		dmb_node = kzalloc(sizeof(*dmb_node), GFP_KERNEL);
    93		if (!dmb_node) {
    94			rc = -ENOMEM;
    95			goto err_bit;
    96		}
    97	
    98		dmb_node->sba_idx = sba_idx;
    99		dmb_node->cpu_addr = kzalloc(dmb->dmb_len, GFP_KERNEL |
   100					     __GFP_NOWARN | __GFP_NORETRY |
   101					     __GFP_NOMEMALLOC);
   102		if (!dmb_node->cpu_addr) {
   103			rc = -ENOMEM;
   104			goto err_node;
   105		}
   106		dmb_node->len = dmb->dmb_len;
 > 107		dmb_node->dma_addr = (dma_addr_t)dmb_node->cpu_addr;
   108	
   109	again:
   110		/* add new dmb into hash table */
   111		get_random_bytes(&dmb_node->token, sizeof(dmb_node->token));
   112		write_lock(&ldev->dmb_ht_lock);
   113		hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_node->token) {
   114			if (tmp_node->token == dmb_node->token) {
   115				write_unlock(&ldev->dmb_ht_lock);
   116				goto again;
   117			}
   118		}
   119		hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
   120		write_unlock(&ldev->dmb_ht_lock);
   121	
   122		dmb->sba_idx = dmb_node->sba_idx;
   123		dmb->dmb_tok = dmb_node->token;
   124		dmb->cpu_addr = dmb_node->cpu_addr;
   125		dmb->dma_addr = dmb_node->dma_addr;
   126		dmb->dmb_len = dmb_node->len;
   127	
   128		return 0;
   129	
   130	err_node:
   131		kfree(dmb_node);
   132	err_bit:
   133		clear_bit(sba_idx, ldev->sba_idx_mask);
   134		return rc;
   135	}
   136	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
