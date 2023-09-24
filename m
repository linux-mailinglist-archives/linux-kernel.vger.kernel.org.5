Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4592D7AC72D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 10:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjIXIyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 04:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjIXIyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 04:54:19 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D41100;
        Sun, 24 Sep 2023 01:54:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VsiANs2_1695545648;
Received: from 30.13.48.111(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VsiANs2_1695545648)
          by smtp.aliyun-inc.com;
          Sun, 24 Sep 2023 16:54:09 +0800
Message-ID: <41d1f41f-737a-7705-c09d-f3678387f8d4@linux.alibaba.com>
Date:   Sun, 24 Sep 2023 16:54:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 12/18] net/smc: implement DMB-related operations
 of loopback
To:     kernel test robot <lkp@intel.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1695134522-126655-13-git-send-email-guwen@linux.alibaba.com>
 <202309232327.nzXalNsH-lkp@intel.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <202309232327.nzXalNsH-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/23 23:24, kernel test robot wrote:
> Hi Wen,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Wen-Gu/net-smc-decouple-ism_dev-from-SMC-D-device-dump/20230920-010019
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/1695134522-126655-13-git-send-email-guwen%40linux.alibaba.com
> patch subject: [PATCH net-next 12/18] net/smc: implement DMB-related operations of loopback
> config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20230923/202309232327.nzXalNsH-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230923/202309232327.nzXalNsH-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309232327.nzXalNsH-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>     net/smc/smc_loopback.c: In function 'smc_lo_register_dmb':
>>> net/smc/smc_loopback.c:107:30: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>       107 |         dmb_node->dma_addr = (dma_addr_t)dmb_node->cpu_addr;
>           |                              ^
> 
> 

Will fix it on v4. Thanks!

> vim +107 net/smc/smc_loopback.c
> 
>      76	
>      77	static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
>      78				       void *client_priv)
>      79	{
>      80		struct smc_lo_dmb_node *dmb_node, *tmp_node;
>      81		struct smc_lo_dev *ldev = smcd->priv;
>      82		int sba_idx, rc;
>      83	
>      84		/* check space for new dmb */
>      85		for_each_clear_bit(sba_idx, ldev->sba_idx_mask, SMC_LODEV_MAX_DMBS) {
>      86			if (!test_and_set_bit(sba_idx, ldev->sba_idx_mask))
>      87				break;
>      88		}
>      89		if (sba_idx == SMC_LODEV_MAX_DMBS)
>      90			return -ENOSPC;
>      91	
>      92		dmb_node = kzalloc(sizeof(*dmb_node), GFP_KERNEL);
>      93		if (!dmb_node) {
>      94			rc = -ENOMEM;
>      95			goto err_bit;
>      96		}
>      97	
>      98		dmb_node->sba_idx = sba_idx;
>      99		dmb_node->cpu_addr = kzalloc(dmb->dmb_len, GFP_KERNEL |
>     100					     __GFP_NOWARN | __GFP_NORETRY |
>     101					     __GFP_NOMEMALLOC);
>     102		if (!dmb_node->cpu_addr) {
>     103			rc = -ENOMEM;
>     104			goto err_node;
>     105		}
>     106		dmb_node->len = dmb->dmb_len;
>   > 107		dmb_node->dma_addr = (dma_addr_t)dmb_node->cpu_addr;
>     108	
>     109	again:
>     110		/* add new dmb into hash table */
>     111		get_random_bytes(&dmb_node->token, sizeof(dmb_node->token));
>     112		write_lock(&ldev->dmb_ht_lock);
>     113		hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_node->token) {
>     114			if (tmp_node->token == dmb_node->token) {
>     115				write_unlock(&ldev->dmb_ht_lock);
>     116				goto again;
>     117			}
>     118		}
>     119		hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
>     120		write_unlock(&ldev->dmb_ht_lock);
>     121	
>     122		dmb->sba_idx = dmb_node->sba_idx;
>     123		dmb->dmb_tok = dmb_node->token;
>     124		dmb->cpu_addr = dmb_node->cpu_addr;
>     125		dmb->dma_addr = dmb_node->dma_addr;
>     126		dmb->dmb_len = dmb_node->len;
>     127	
>     128		return 0;
>     129	
>     130	err_node:
>     131		kfree(dmb_node);
>     132	err_bit:
>     133		clear_bit(sba_idx, ldev->sba_idx_mask);
>     134		return rc;
>     135	}
>     136	
> 
