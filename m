Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959F87ACCE6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 01:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjIXXaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 19:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjIXXaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 19:30:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CBDE3;
        Sun, 24 Sep 2023 16:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695598205; x=1727134205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YHZ6WWFMihmwwYSimo0khu4TlbPVE2K5QH/2yj5Cfa8=;
  b=Suyol8ikmWGenCqpyfT3Vi/Ru/29eKynGY5ZhzD4xmRGZiEafsHp/aK5
   7RlW3njRYFDW6fSCQ/C3PsByj/PiZtpWbHTx7RiEHY0hRe6pPPStgl+aC
   k/hj090SYoN3vVB+OtbFvn8wLDpOp+u93qR0KeagIAMeI1gxkf7GlGVm1
   YIumWav4RA5o8+Ywd0UUQwOCvDnXe4B2NUrDYa/Z7qUrx3d/+hAFUgrZi
   u9c0rU3Pu5ALuf0dd7rDP/LwpIzQSX1Gf3RXVCv8+l0E44PMXcFtBGfSc
   sEOwxza3ZF6VhBQtGsptFrjIqHm9tmH5ZFl//XSQlx4OCDoL2dXes0yr5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360519181"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="360519181"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 16:30:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="995169635"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="995169635"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 24 Sep 2023 16:30:00 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qkYY2-0000bV-0W;
        Sun, 24 Sep 2023 23:29:58 +0000
Date:   Mon, 25 Sep 2023 07:29:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev, wintera@linux.ibm.com,
        schnelle@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, guwen@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 12/18] net/smc: implement DMB-related
 operations of loopback
Message-ID: <202309250749.LB7ZUUGJ-lkp@intel.com>
References: <1695568613-125057-13-git-send-email-guwen@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695568613-125057-13-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wen,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Wen-Gu/net-smc-decouple-ism_dev-from-SMC-D-device-dump/20230924-231933
base:   net-next/main
patch link:    https://lore.kernel.org/r/1695568613-125057-13-git-send-email-guwen%40linux.alibaba.com
patch subject: [PATCH net-next v4 12/18] net/smc: implement DMB-related operations of loopback
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20230925/202309250749.LB7ZUUGJ-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230925/202309250749.LB7ZUUGJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309250749.LB7ZUUGJ-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   net/smc/smc_loopback.c: In function 'smc_lo_register_dmb':
>> net/smc/smc_loopback.c:102:30: error: implicit declaration of function 'vzalloc'; did you mean 'kvzalloc'? [-Werror=implicit-function-declaration]
     102 |         dmb_node->cpu_addr = vzalloc(dmb->dmb_len);
         |                              ^~~~~~~
         |                              kvzalloc
>> net/smc/smc_loopback.c:102:28: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     102 |         dmb_node->cpu_addr = vzalloc(dmb->dmb_len);
         |                            ^
   net/smc/smc_loopback.c: In function 'smc_lo_unregister_dmb':
>> net/smc/smc_loopback.c:159:9: error: implicit declaration of function 'vfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
     159 |         vfree(dmb_node->cpu_addr);
         |         ^~~~~
         |         kvfree
   cc1: some warnings being treated as errors


vim +102 net/smc/smc_loopback.c

    79	
    80	static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
    81				       void *client_priv)
    82	{
    83		struct smc_lo_dmb_node *dmb_node, *tmp_node;
    84		struct smc_lo_dev *ldev = smcd->priv;
    85		int sba_idx, rc;
    86	
    87		/* check space for new dmb */
    88		for_each_clear_bit(sba_idx, ldev->sba_idx_mask, SMC_LODEV_MAX_DMBS) {
    89			if (!test_and_set_bit(sba_idx, ldev->sba_idx_mask))
    90				break;
    91		}
    92		if (sba_idx == SMC_LODEV_MAX_DMBS)
    93			return -ENOSPC;
    94	
    95		dmb_node = kzalloc(sizeof(*dmb_node), GFP_KERNEL);
    96		if (!dmb_node) {
    97			rc = -ENOMEM;
    98			goto err_bit;
    99		}
   100	
   101		dmb_node->sba_idx = sba_idx;
 > 102		dmb_node->cpu_addr = vzalloc(dmb->dmb_len);
   103		if (!dmb_node->cpu_addr) {
   104			rc = -ENOMEM;
   105			goto err_node;
   106		}
   107		dmb_node->len = dmb->dmb_len;
   108		dmb_node->dma_addr = SMC_DMA_ADDR_INVALID;
   109	
   110	again:
   111		/* add new dmb into hash table */
   112		get_random_bytes(&dmb_node->token, sizeof(dmb_node->token));
   113		write_lock(&ldev->dmb_ht_lock);
   114		hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_node->token) {
   115			if (tmp_node->token == dmb_node->token) {
   116				write_unlock(&ldev->dmb_ht_lock);
   117				goto again;
   118			}
   119		}
   120		hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
   121		write_unlock(&ldev->dmb_ht_lock);
   122	
   123		dmb->sba_idx = dmb_node->sba_idx;
   124		dmb->dmb_tok = dmb_node->token;
   125		dmb->cpu_addr = dmb_node->cpu_addr;
   126		dmb->dma_addr = dmb_node->dma_addr;
   127		dmb->dmb_len = dmb_node->len;
   128	
   129		return 0;
   130	
   131	err_node:
   132		kfree(dmb_node);
   133	err_bit:
   134		clear_bit(sba_idx, ldev->sba_idx_mask);
   135		return rc;
   136	}
   137	
   138	static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
   139	{
   140		struct smc_lo_dmb_node *dmb_node = NULL, *tmp_node;
   141		struct smc_lo_dev *ldev = smcd->priv;
   142	
   143		/* remove dmb from hash table */
   144		write_lock(&ldev->dmb_ht_lock);
   145		hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
   146			if (tmp_node->token == dmb->dmb_tok) {
   147				dmb_node = tmp_node;
   148				break;
   149			}
   150		}
   151		if (!dmb_node) {
   152			write_unlock(&ldev->dmb_ht_lock);
   153			return -EINVAL;
   154		}
   155		hash_del(&dmb_node->list);
   156		write_unlock(&ldev->dmb_ht_lock);
   157	
   158		clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
 > 159		vfree(dmb_node->cpu_addr);
   160		kfree(dmb_node);
   161	
   162		return 0;
   163	}
   164	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
