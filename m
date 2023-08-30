Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79A578D28A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 05:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbjH3DaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 23:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241810AbjH3DRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 23:17:21 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0232D1A4;
        Tue, 29 Aug 2023 20:17:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VqtENhb_1693365430;
Received: from 30.221.109.125(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0VqtENhb_1693365430)
          by smtp.aliyun-inc.com;
          Wed, 30 Aug 2023 11:17:12 +0800
Message-ID: <8eb02141-9c5e-8380-285c-d96e6184f539@linux.alibaba.com>
Date:   Wed, 30 Aug 2023 11:17:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v2 net-next 4/6] net/smc: support max connections per
 lgr negotiation
Content-Language: en-US
To:     Wenjia Zhang <wenjia@linux.ibm.com>, jaka@linux.ibm.com,
        kgraul@linux.ibm.com, tonylu@linux.alibaba.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230807062720.20555-1-guangguan.wang@linux.alibaba.com>
 <20230807062720.20555-5-guangguan.wang@linux.alibaba.com>
 <a7ed9f2d-5c50-b37f-07d4-088ceef6aeac@linux.ibm.com>
 <9f4292c4-4004-b73b-1079-41ce7b1a5750@linux.alibaba.com>
 <2dbf25a0-05a6-d899-3351-598e952a927d@linux.ibm.com>
 <484c9f62-748c-6193-9c02-c41449b757b4@linux.alibaba.com>
 <e1cba3b8-1333-3b30-04f2-c7634bf02da1@linux.ibm.com>
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <e1cba3b8-1333-3b30-04f2-c7634bf02da1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/29 21:18, Wenjia Zhang wrote:
> 
> 
> On 29.08.23 04:31, Guangguan Wang wrote:
>>
>>
>> On 2023/8/28 20:54, Wenjia Zhang wrote:
>>>
>>>
>>> On 15.08.23 08:31, Guangguan Wang wrote:
>>>>
>>>>
>>>> On 2023/8/10 00:04, Wenjia Zhang wrote:
>>>>>
>>>>>
>>>>> On 07.08.23 08:27, Guangguan Wang wrote:
>>>>>> Support max connections per lgr negotiation for SMCR v2.1,
>>>>>> which is one of smc v2.1 features.
>>>> ...
>>>>>> @@ -472,6 +473,9 @@ int smc_llc_send_confirm_link(struct smc_link *link,
>>>>>>         confllc->link_num = link->link_id;
>>>>>>         memcpy(confllc->link_uid, link->link_uid, SMC_LGR_ID_SIZE);
>>>>>>         confllc->max_links = SMC_LLC_ADD_LNK_MAX_LINKS;
>>>>>> +    if (link->lgr->smc_version == SMC_V2 &&
>>>>>> +        link->lgr->peer_smc_release >= SMC_RELEASE_1)
>>>>>> +        confllc->max_conns = link->lgr->max_conns;
>>>>>>         /* send llc message */
>>>>>>         rc = smc_wr_tx_send(link, pend);
>>>>>>     put_out:
>>>>>
>>>>> Did I miss the negotiation process somewhere for the following scenario?
>>>>> (Example 4 in the document)
>>>>> Client                 Server
>>>>>       Proposal(max conns(16))
>>>>>       ----------------------->
>>>>>
>>>>>       Accept(max conns(32))
>>>>>       <-----------------------
>>>>>
>>>>>       Confirm(max conns(32))
>>>>>       ----------------------->
>>>>
>>>> Did you mean the accepted max conns is different(not 32) from the Example 4 when the proposal max conns is 16?
>>>>
>>>> As described in (https://www.ibm.com/support/pages/node/7009315) page 41:
>>>> ...
>>>> 2. Max conns and max links values sent in the CLC Proposal are the client preferred values.
>>>> 3. The v2.1 values sent in the Accept message are the final values. The client must accept the values or
>>>> DECLINE the connection.
>>>> 4. Max conns and links values sent in the CLC Accept are the final values (server dictates). The server can
>>>> either honor the client’s preferred values or return different (negotiated but final) values.
>>>> ...
>>>>
>>>> If I understand correctly, the server dictates the final value of max conns, but how the server dictates the final
>>>> value of max conns is not defined in SMC v2.1. In this patch, the server use the minimum value of client preferred
>>>> value and server preferred value as the final value of max conns. The max links is negotiated with the same logic.
>>>>
>>>> Client                 Server
>>>>        Proposal(max conns(client preferred))
>>>>        ----------------------->
>>>>          Accept(max conns(accepted value)) accepted value=min(client preferred, server preferred)
>>>>        <-----------------------
>>>>          Confirm(max conns(accepted value))
>>>>        ----------------------->
>>>>
>>>> I also will add this description into commit message for better understanding.
>>>>
>>>> Thanks,
>>>> Guangguan Wang
>>>>
>>>>
>>>>
>>>
>>> Sorry for the late answer, I'm just back from vacation.
>>>
>>> That's true that the protocol does not define how the server decides the final value(s). I'm wondering if there is some reason for you to use the minimum value instead of maximum (corresponding to the examples in the document). If the both prefered values (client's and server's) are in the range of the acceptable value, why not the maximum? Is there any consideration on that?
>>>
>>> Best,
>>> Wenjia
>>
>> Since the value of the default preferred max conns is already the maximum value of the range(16-255), I am wondering
>> whether it makes any sense to use the maximum for decision, where the negotiated result of max conns is always 255.
>> So does the max links.
>>
>> Thanks,
>> Guangguan
> 
> I don't think the server's default maxconns must be the maximum value, i.e 255. Since the patches series are already applied, we say the previous implementation uses maximus value because the maxconns is not tunable, so that we choose an appropriate value as the default value.
> Now the value is negotiable, the default value could be also the server's prefer value.
If the server's default maxconns could be other value rather than maximum value, it's OK to use other decision algorithm(minimum, maximum or others).
But it is still a question that how to tune the default maxconns, maybe it is different from different linux distributions and different vendors of rdma nic.

> But regarding maxlinks, I'm fine with the minimus, and actually it should be, because it should not be possible to try to add another link if one of the peers can and want to support only one link, i.e. down-level.
Agree with you.

> Any opinion?
> 
> Best,
> Wenjia

Thanks,
Guangguan Wang
