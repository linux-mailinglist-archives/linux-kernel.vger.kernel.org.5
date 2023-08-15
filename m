Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A3F77C6A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 06:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbjHOEML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 00:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbjHOEKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 00:10:10 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6306D4483;
        Mon, 14 Aug 2023 20:57:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vpq6ttl_1692071851;
Received: from 30.221.106.14(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0Vpq6ttl_1692071851)
          by smtp.aliyun-inc.com;
          Tue, 15 Aug 2023 11:57:33 +0800
Message-ID: <8c5d1a90-6965-f507-a54d-5c420c972306@linux.alibaba.com>
Date:   Tue, 15 Aug 2023 11:57:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v2 net-next 1/6] net/smc: support smc release version
 negotiation in clc handshake
To:     Wenjia Zhang <wenjia@linux.ibm.com>, jaka@linux.ibm.com,
        kgraul@linux.ibm.com, tonylu@linux.alibaba.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230807062720.20555-1-guangguan.wang@linux.alibaba.com>
 <20230807062720.20555-2-guangguan.wang@linux.alibaba.com>
 <ecafff58-c93a-5592-ddaa-d8724cf6bdcc@linux.ibm.com>
Content-Language: en-US
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <ecafff58-c93a-5592-ddaa-d8724cf6bdcc@linux.ibm.com>
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



On 2023/8/10 00:03, Wenjia Zhang wrote:
> 
> 
> On 07.08.23 08:27, Guangguan Wang wrote:
>> Support smc release version negotiation in clc handshake. And set
>> the latest smc release version to 2.1.
>>
> 
> Could you elaborate the changes? Without reading code, it is really difficult to know what you did, and why you did it. Sure, one can read the code and the support document, but the commit message should always be the quick reference. The following information I missed especially:
> - This implementation is based on SMCv2 where no negotiation process for different releases, but for different versions.
> - The Server makes the decision for which release will be used.

Sorry for the lack of descriptions, more descriptions will be added in the next version.

>>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index a7f887d91d89..bac73eb0542d 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -1187,6 +1187,11 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
>>               return SMC_CLC_DECL_NOINDIRECT;
>>           }
>>       }
>> +
>> +    if (fce->release > SMC_RELEASE)
>> +        return SMC_CLC_DECL_VERSMISMAT;
> I'm wondering if this check is necessary, how it could happen?

You are right, I will remove the check.

>>   -static void smc_clc_fill_fce(struct smc_clc_first_contact_ext *fce, int *len)
>> +static void smc_clc_fill_fce(struct smc_clc_first_contact_ext *fce, int *len, int release_ver)
>>   {
>>       memset(fce, 0, sizeof(*fce));
>>       fce->os_type = SMC_CLC_OS_LINUX;
>> -    fce->release = SMC_RELEASE;
>> +    fce->release = release_ver;
>>       memcpy(fce->hostname, smc_hostname, sizeof(smc_hostname));
>>       (*len) += sizeof(*fce);
>>   }
> 
> Personally I'd like release_nr instead of release_ver.


>>   @@ -382,7 +403,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini);
>>   int smc_clc_send_confirm(struct smc_sock *smc, bool clnt_first_contact,
>>                u8 version, u8 *eid, struct smc_init_info *ini);
>>   int smc_clc_send_accept(struct smc_sock *smc, bool srv_first_contact,
>> -            u8 version, u8 *negotiated_eid);
>> +            u8 version, u8 *negotiated_eid, struct smc_init_info *ini);
>>   void smc_clc_init(void) __init;
>>   void smc_clc_exit(void);
>>   void smc_clc_get_hostname(u8 **host);
>> diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
>> index 3c1b31bfa1cf..1a97fef39127 100644
>> --- a/net/smc/smc_core.h
>> +++ b/net/smc/smc_core.h
>> @@ -374,6 +374,7 @@ struct smc_init_info {
>>       u8            is_smcd;
>>       u8            smc_type_v1;
>>       u8            smc_type_v2;
>> +    u8            release_ver;
> 
> Also here, I'd like release_nr more.

OK, I will modify it in the next version.
