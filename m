Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF567AAA95
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjIVHoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjIVHnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:43:53 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C236B19A8;
        Fri, 22 Sep 2023 00:42:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VsccBZP_1695368567;
Received: from 30.221.128.225(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VsccBZP_1695368567)
          by smtp.aliyun-inc.com;
          Fri, 22 Sep 2023 15:42:48 +0800
Message-ID: <d6facfd5-e083-ffc7-05e5-2e8f3ef17735@linux.alibaba.com>
Date:   Fri, 22 Sep 2023 15:42:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next v3 12/18] net/smc: implement DMB-related
 operations of loopback
To:     Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1695302360-46691-1-git-send-email-guwen@linux.alibaba.com>
 <1695302360-46691-13-git-send-email-guwen@linux.alibaba.com>
 <881e43f8-54e0-4847-67c4-82b9c0b3e50c@linux.ibm.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <881e43f8-54e0-4847-67c4-82b9c0b3e50c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/22 07:31, Wenjia Zhang wrote:
> 
> 

<...>

>> +static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
>> +                   void *client_priv)
>> +{
>> +    struct smc_lo_dmb_node *dmb_node, *tmp_node;
>> +    struct smc_lo_dev *ldev = smcd->priv;
>> +    int sba_idx, rc;
>> +
>> +    /* check space for new dmb */
>> +    for_each_clear_bit(sba_idx, ldev->sba_idx_mask, SMC_LODEV_MAX_DMBS) {
>> +        if (!test_and_set_bit(sba_idx, ldev->sba_idx_mask))
>> +            break;
>> +    }
>> +    if (sba_idx == SMC_LODEV_MAX_DMBS)
>> +        return -ENOSPC;
>> +
>> +    dmb_node = kzalloc(sizeof(*dmb_node), GFP_KERNEL);
>> +    if (!dmb_node) {
>> +        rc = -ENOMEM;
>> +        goto err_bit;
>> +    }
>> +
>> +    dmb_node->sba_idx = sba_idx;
>> +    dmb_node->cpu_addr = kzalloc(dmb->dmb_len, GFP_KERNEL |
>> +                     __GFP_NOWARN | __GFP_NORETRY |
>> +                     __GFP_NOMEMALLOC);
> kzalloc()/kmalloc() allocates physically contigueous memory. Are you sure it is suitable for allocating the dmb?
> 

Yes, physically contigueous memory is little expensive here. I initially wanted to see the best performance.

I tried using vzalloc here, and the performance dropped a bit (2%~8%) compared to kzalloc. I think it is acceptable.

- ipc-benchmark
                        kzalloc                vzalloc
Message
rate (msg/s)            152076                 145753(-4.16%)

- sockperf
                        kzalloc                vzalloc
Bandwidth(MBps)       8491.638               8002.380(-5.76%)
Latency(us)              3.222                  3.508(+8.88%)

- nginx/wrk
                        kzalloc                vzalloc
Requests/s           272519.36              256490.94(-5.88%)

- redis-benchmark
                        kzalloc                vzalloc
GET(Requests/s)      123304.56              120084.05(-2.61%)
SET(Requests/s)      122062.87              118800.12(-2.67%)


>> +    if (!dmb_node->cpu_addr) {
>> +        rc = -ENOMEM;
>> +        goto err_node;
>> +    }
>> +    dmb_node->len = dmb->dmb_len;
>> +    dmb_node->dma_addr = (dma_addr_t)dmb_node->cpu_addr;
>> +
>> +again:
>> +    /* add new dmb into hash table */
>> +    get_random_bytes(&dmb_node->token, sizeof(dmb_node->token));
>> +    write_lock(&ldev->dmb_ht_lock);
>> +    hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_node->token) {
>> +        if (tmp_node->token == dmb_node->token) {
>> +            write_unlock(&ldev->dmb_ht_lock);
>> +            goto again;
>> +        }
>> +    }
>> +    hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
>> +    write_unlock(&ldev->dmb_ht_lock);
>> +
>> +    dmb->sba_idx = dmb_node->sba_idx;
>> +    dmb->dmb_tok = dmb_node->token;
>> +    dmb->cpu_addr = dmb_node->cpu_addr;
>> +    dmb->dma_addr = dmb_node->dma_addr;
>> +    dmb->dmb_len = dmb_node->len;
>> +
>> +    return 0;
>> +
>> +err_node:
>> +    kfree(dmb_node);
>> +err_bit:
>> +    clear_bit(sba_idx, ldev->sba_idx_mask);
>> +    return rc;
>> +}
>> +
>> +static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
>> +{
>> +    struct smc_lo_dmb_node *dmb_node = NULL, *tmp_node;
>> +    struct smc_lo_dev *ldev = smcd->priv;
>> +
>> +    /* remove dmb from hash table */
>> +    write_lock(&ldev->dmb_ht_lock);
>> +    hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
>> +        if (tmp_node->token == dmb->dmb_tok) {
>> +            dmb_node = tmp_node;
>> +            break;
>> +        }
>> +    }
>> +    if (!dmb_node) {
>> +        write_unlock(&ldev->dmb_ht_lock);
>> +        return -EINVAL;
>> +    }
>> +    hash_del(&dmb_node->list);
>> +    write_unlock(&ldev->dmb_ht_lock);
>> +
>> +    clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
>> +    kfree(dmb_node->cpu_addr);
>> +    kfree(dmb_node);
>> +
>> +    return 0;
>> +}
>> +

