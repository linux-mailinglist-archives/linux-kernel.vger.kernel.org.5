Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7BC7AACEC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjIVImV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjIVImS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:42:18 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55225FB;
        Fri, 22 Sep 2023 01:42:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Vscql3G_1695372126;
Received: from 30.221.128.225(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vscql3G_1695372126)
          by smtp.aliyun-inc.com;
          Fri, 22 Sep 2023 16:42:07 +0800
Message-ID: <b7684046-39eb-f0a1-a1ff-12580d8db42e@linux.alibaba.com>
Date:   Fri, 22 Sep 2023 16:42:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next v3 05/18] net/smc: reserve CHID range for SMC-D
 virtual device
To:     Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1695302360-46691-1-git-send-email-guwen@linux.alibaba.com>
 <1695302360-46691-6-git-send-email-guwen@linux.alibaba.com>
 <0a150c58-5fdc-5e8d-1ea6-861406f2c70a@linux.ibm.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <0a150c58-5fdc-5e8d-1ea6-861406f2c70a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/22 07:32, Wenjia Zhang wrote:
> 
> 
> On 21.09.23 15:19, Wen Gu wrote:
>> This patch reserve CHID range from 0xFF00 to 0xFFFF for SMC-D virtual
>> device and introduces helpers to identify them.
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>>   net/smc/smc_ism.h | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
>> index 14d2e77..2ecc8de 100644
>> --- a/net/smc/smc_ism.h
>> +++ b/net/smc/smc_ism.h
>> @@ -15,6 +15,9 @@
>>   #include "smc.h"
>> +#define SMC_VIRT_ISM_CHID_MAX        0xFFFF
>> +#define SMC_VIRT_ISM_CHID_MIN        0xFF00
>> +
>>   struct smcd_dev_list {    /* List of SMCD devices */
>>       struct list_head list;
>>       struct mutex mutex;    /* Protects list of devices */
>> @@ -57,4 +60,16 @@ static inline int smc_ism_write(struct smcd_dev *smcd, u64 dmb_tok,
>>       return rc < 0 ? rc : 0;
>>   }
>> +static inline bool __smc_ism_is_virtdev(u16 chid)
>> +{
>> +    return (chid >= SMC_VIRT_ISM_CHID_MIN && chid <= SMC_VIRT_ISM_CHID_MAX);
>> +}
>> +
>> +static inline bool smc_ism_is_virtdev(struct smcd_dev *smcd)
>> +{
>> +    u16 chid = smcd->ops->get_chid(smcd);
>> +
>> +    return __smc_ism_is_virtdev(chid);
>> +}
>> +
> I'm wondering if barrier is needed here.

I think this helper doesn't involve memory race or multi-threaded/multi-processor
cases that needs enforcing ordering and synchronization of memory operations.

So IMHO barrier is no very necessary here.

Thank you.

>>   #endif
