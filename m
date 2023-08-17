Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BA677EF77
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 05:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347821AbjHQDT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 23:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347799AbjHQDSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 23:18:55 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687151724;
        Wed, 16 Aug 2023 20:18:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VpyDhcI_1692242328;
Received: from 30.221.109.120(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0VpyDhcI_1692242328)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 11:18:49 +0800
Message-ID: <2a494003-c41d-c8a6-6e3f-df6280494715@linux.alibaba.com>
Date:   Thu, 17 Aug 2023 11:18:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net-next 1/6] net/smc: support smc release version
 negotiation in clc handshake
Content-Language: en-US
To:     Jan Karcher <jaka@linux.ibm.com>, wenjia@linux.ibm.com,
        kgraul@linux.ibm.com, tonylu@linux.alibaba.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230816083328.95746-1-guangguan.wang@linux.alibaba.com>
 <20230816083328.95746-2-guangguan.wang@linux.alibaba.com>
 <36db51b2-ff88-0419-1e9b-cae2b111e570@linux.ibm.com>
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <36db51b2-ff88-0419-1e9b-cae2b111e570@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/16 22:14, Jan Karcher wrote:
> 
> 
> On 16/08/2023 10:33, Guangguan Wang wrote:
>> Support smc release version negotiation in clc handshake based on
>> SMC v2, where no negotiation process for different releases, but
>> for different versions. The latest smc release version was updated
>> to v2.1. And currently there are two release versions of SMCv2, v2.0
>> and v2.1. In the release version negotiation, client sends the preferred
>> release version by CLC Proposal Message, server makes decision for which
>> release version to use based on the client preferred release version and
>> self-supported release version (here choose the minimum release version
>> of the client preferred and server latest supported), then the decision
>> returns to client by CLC Accept Message. Client confirms the decision by
>> CLC Confirm Message.
>>
>> Client                                    Server
>>        Proposal(preferred release version)
>>       ------------------------------------>
>>
>>        Accept(accpeted release version)
>>   min(client preferred, server latest supported)
>>       <------------------------------------
>>
>>        Confirm(accpeted release version)
>>       ------------------------------------>
>>
>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>> Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
>> ---
>>   net/smc/af_smc.c   | 18 ++++++++++++++++--
>>   net/smc/smc.h      |  5 ++++-
>>   net/smc/smc_clc.c  | 14 +++++++-------
>>   net/smc/smc_clc.h  | 23 ++++++++++++++++++++++-
>>   net/smc/smc_core.h |  1 +
>>   5 files changed, 50 insertions(+), 11 deletions(-)
>>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index a7f887d91d89..97265691bc95 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -1187,6 +1187,9 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
>>               return SMC_CLC_DECL_NOINDIRECT;
>>           }
>>       }
>> +
>> +    ini->release_nr = fce->release;
>> +
> 
> why would we do this and vvvvv
>>       return 0;
>>   }
>>   @@ -1355,6 +1358,13 @@ static int smc_connect_ism(struct smc_sock *smc,
>>           struct smc_clc_msg_accept_confirm_v2 *aclc_v2 =
>>               (struct smc_clc_msg_accept_confirm_v2 *)aclc;
>>   +        if (ini->first_contact_peer) {
>> +            struct smc_clc_first_contact_ext *fce =
>> +                smc_get_clc_first_contact_ext(aclc_v2, true);
>> +
>> +            ini->release_nr = fce->release;
>> +        }
>> +
> 
> this two times?
> Can't we put this together into __smc_connect where those functions get called (via smc_connect_rdma and smc_connect_ism)?
> 
> Please provide reasoning, it might be that i oversaw the reasoning behind this duplication.
> 
ini->release_nr is assigned only when doing first connect, thus this depends on the value test of 
ini->first_contact_peer. I have to follow the ini->first_contact_peer code logic, which may also
make us wonder that why not put ini->first_contact_peer together into __smc_connect.

Indeed, both of ini->first_contact_peer and ini->release_nr can put together into __smc_connect.
But I think it is better to start a new patch series to refactor those code, not in v2.1 features.


> Also note: Even if there is a reason to set this information seperate for SMC-D and SMC-R think about using your very neat helper function (smc_get_clc_first_contact_ext) in smc_connect_rdma_v2_prepare as well.
> 

OK, I will replace the code to smc_get_clc_first_contact_ext.

Thanks,
Guangguan Wang

