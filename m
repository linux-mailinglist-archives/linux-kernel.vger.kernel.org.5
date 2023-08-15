Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA3D77C7CD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbjHOGbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbjHOGbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:31:16 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363A91733;
        Mon, 14 Aug 2023 23:31:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VpqfC0f_1692081067;
Received: from 30.221.106.14(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0VpqfC0f_1692081067)
          by smtp.aliyun-inc.com;
          Tue, 15 Aug 2023 14:31:09 +0800
Message-ID: <9f4292c4-4004-b73b-1079-41ce7b1a5750@linux.alibaba.com>
Date:   Tue, 15 Aug 2023 14:31:06 +0800
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
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <a7ed9f2d-5c50-b37f-07d4-088ceef6aeac@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/10 00:04, Wenjia Zhang wrote:
> 
> 
> On 07.08.23 08:27, Guangguan Wang wrote:
>> Support max connections per lgr negotiation for SMCR v2.1,
>> which is one of smc v2.1 features.
...
>> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
>> index 6aa3db47a956..5de1fbaa6e28 100644
>> --- a/net/smc/smc_core.c
>> +++ b/net/smc/smc_core.c
>> @@ -895,9 +895,11 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
>>               lgr->uses_gateway = ini->smcrv2.uses_gateway;
>>               memcpy(lgr->nexthop_mac, ini->smcrv2.nexthop_mac,
>>                      ETH_ALEN);
>> +            lgr->max_conns = ini->max_conns;
>>           } else {
>>               ibdev = ini->ib_dev;
>>               ibport = ini->ib_port;
>> +            lgr->max_conns = SMC_RMBS_PER_LGR_MAX;
> 
> 
> It is kind of confused sometimes SMC_RMBS_PER_LGR_MAX is used and sometimes SMC_CONN_PER_LGR_MAX. IMO, you can use SMC_CONN_PER_LGR_MAX in the patches series for the new feature, because they are the same value and the name is more suiable.

OK, I will re-define the macros like this:
#define SMC_CONN_PER_LGR_MAX 255
#define SMC_CONN_PER_LGR_MIN 16
#define SMC_CONN_PER_LGR_PREFER 255 //vendors or distrubutions can modify this to a value between 16-255 as needed. 

...
>> @@ -472,6 +473,9 @@ int smc_llc_send_confirm_link(struct smc_link *link,
>>       confllc->link_num = link->link_id;
>>       memcpy(confllc->link_uid, link->link_uid, SMC_LGR_ID_SIZE);
>>       confllc->max_links = SMC_LLC_ADD_LNK_MAX_LINKS;
>> +    if (link->lgr->smc_version == SMC_V2 &&
>> +        link->lgr->peer_smc_release >= SMC_RELEASE_1)
>> +        confllc->max_conns = link->lgr->max_conns;
>>       /* send llc message */
>>       rc = smc_wr_tx_send(link, pend);
>>   put_out:
> 
> Did I miss the negotiation process somewhere for the following scenario?
> (Example 4 in the document)
> Client                 Server
>     Proposal(max conns(16))
>     ----------------------->
> 
>     Accept(max conns(32))
>     <-----------------------
> 
>     Confirm(max conns(32))
>     ----------------------->

Did you mean the accepted max conns is different(not 32) from the Example 4 when the proposal max conns is 16?

As described in (https://www.ibm.com/support/pages/node/7009315) page 41:
...
2. Max conns and max links values sent in the CLC Proposal are the client preferred values.
3. The v2.1 values sent in the Accept message are the final values. The client must accept the values or
DECLINE the connection.
4. Max conns and links values sent in the CLC Accept are the final values (server dictates). The server can
either honor the client’s preferred values or return different (negotiated but final) values. 
...

If I understand correctly, the server dictates the final value of max conns, but how the server dictates the final
value of max conns is not defined in SMC v2.1. In this patch, the server use the minimum value of client preferred
value and server preferred value as the final value of max conns. The max links is negotiated with the same logic.

Client                 Server
     Proposal(max conns(client preferred))
     ----------------------->
 
     Accept(max conns(accepted value)) accepted value=min(client preferred, server preferred)
     <-----------------------
 
     Confirm(max conns(accepted value))
     ----------------------->

I also will add this description into commit message for better understanding.

Thanks,
Guangguan Wang


