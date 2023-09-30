Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995B87B3F80
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 10:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjI3Il4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 04:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjI3Ilz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 04:41:55 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83741A4;
        Sat, 30 Sep 2023 01:41:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Vt5scEN_1696063306;
Received: from 30.236.0.214(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vt5scEN_1696063306)
          by smtp.aliyun-inc.com;
          Sat, 30 Sep 2023 16:41:48 +0800
Message-ID: <643c479a-b8bc-7526-330a-5c3f5547385c@linux.alibaba.com>
Date:   Sat, 30 Sep 2023 16:41:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v4 03/18] net/smc: extract v2 check helper from
 SMC-D device registration
To:     Jan Karcher <jaka@linux.ibm.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     wintera@linux.ibm.com, schnelle@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        dust.li@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1695568613-125057-1-git-send-email-guwen@linux.alibaba.com>
 <1695568613-125057-4-git-send-email-guwen@linux.alibaba.com>
 <902e41df-0c98-c8ef-09cb-a92cf053f9d2@linux.ibm.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <902e41df-0c98-c8ef-09cb-a92cf053f9d2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/28 11:08, Jan Karcher wrote:
> 
> 
> On 24/09/2023 17:16, Wen Gu wrote:
>> This patch extracts v2-capable logic from the process of registering the
>> ISM device as an SMC-D device, so that the registration process of other
>> underlying devices can reuse it.
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>>   net/smc/smc_ism.c | 29 ++++++++++++++++++-----------
>>   net/smc/smc_ism.h |  1 +
>>   2 files changed, 19 insertions(+), 11 deletions(-)
>>
>> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
>> index 455ae0a..8f1ba74 100644
>> --- a/net/smc/smc_ism.c
>> +++ b/net/smc/smc_ism.c
>> @@ -69,6 +69,22 @@ bool smc_ism_is_v2_capable(void)
>>       return smc_ism_v2_capable;
>>   }
>> +/* must be called under smcd_dev_list.mutex lock */
>> +void smc_ism_check_v2_capable(struct smcd_dev *smcd)
>> +{
>> +    u8 *system_eid = NULL;
>> +
>> +    if (smc_ism_v2_capable)
>> +        return;
>> +
>> +    system_eid = smcd->ops->get_system_eid();
>> +    if (smcd->ops->supports_v2()) {
>> +        smc_ism_v2_capable = true;
>> +        memcpy(smc_ism_v2_system_eid, system_eid,
>> +               SMC_MAX_EID_LEN);
>> +    }
>> +}
>> +
>>   /* Set a connection using this DMBE. */
>>   void smc_ism_set_conn(struct smc_connection *conn)
>>   {
>> @@ -423,16 +439,7 @@ static void smcd_register_dev(struct ism_dev *ism)
>>           smc_pnetid_by_table_smcd(smcd);
>>       mutex_lock(&smcd_dev_list.mutex);
>> -    if (list_empty(&smcd_dev_list.list)) {
>> -        u8 *system_eid = NULL;
>> -
>> -        system_eid = smcd->ops->get_system_eid();
>> -        if (smcd->ops->supports_v2()) {
>> -            smc_ism_v2_capable = true;
>> -            memcpy(smc_ism_v2_system_eid, system_eid,
>> -                   SMC_MAX_EID_LEN);
>> -        }
>> -    }
>> +    smc_ism_check_v2_capable(smcd);
> 
> The list_empty check is omitted here which means the smc_ism_check_v2_capable does not touch the list.
> So i think the call could be placed prior the mutex_lock.
> 

Good catch. I omitted the list_empty check in this version but forget to remove 'the
lock comments' and place the helper prior to the mutex_lock. It will be fixed.

Thank you.

>>       /* sort list: devices without pnetid before devices with pnetid */
>>       if (smcd->pnetid[0])
>>           list_add_tail(&smcd->list, &smcd_dev_list.list);
>> @@ -535,10 +542,10 @@ int smc_ism_init(void)
>>   {
>>       int rc = 0;
>> -#if IS_ENABLED(CONFIG_ISM)
>>       smc_ism_v2_capable = false;
>>       memset(smc_ism_v2_system_eid, 0, SMC_MAX_EID_LEN);
>> +#if IS_ENABLED(CONFIG_ISM)
>>       rc = ism_register_client(&smc_ism_client);
>>   #endif
>>       return rc;
>> diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
>> index 832b2f4..14d2e77 100644
>> --- a/net/smc/smc_ism.h
>> +++ b/net/smc/smc_ism.h
>> @@ -42,6 +42,7 @@ int smc_ism_register_dmb(struct smc_link_group *lgr, int buf_size,
>>   void smc_ism_get_system_eid(u8 **eid);
>>   u16 smc_ism_get_chid(struct smcd_dev *dev);
>>   bool smc_ism_is_v2_capable(void);
>> +void smc_ism_check_v2_capable(struct smcd_dev *dev);
>>   int smc_ism_init(void);
>>   void smc_ism_exit(void);
>>   int smcd_nl_get_device(struct sk_buff *skb, struct netlink_callback *cb);
