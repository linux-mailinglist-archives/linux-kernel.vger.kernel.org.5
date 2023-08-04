Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A8576FA49
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbjHDGlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbjHDGko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:40:44 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E83A46B1;
        Thu,  3 Aug 2023 23:40:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vp.HeWq_1691131229;
Received: from 30.221.100.251(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0Vp.HeWq_1691131229)
          by smtp.aliyun-inc.com;
          Fri, 04 Aug 2023 14:40:30 +0800
Message-ID: <3e761be7-c441-4629-3539-f067c6d8c1e8@linux.alibaba.com>
Date:   Fri, 4 Aug 2023 14:40:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH net-next 4/6] net/smc: support max connections per lgr
 negotiation
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>
Cc:     wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
        tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230803132422.6280-1-guangguan.wang@linux.alibaba.com>
 <20230803132422.6280-5-guangguan.wang@linux.alibaba.com>
 <ZMvqJ6FYR6gWS+ZK@kernel.org>
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <ZMvqJ6FYR6gWS+ZK@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got it.
I will remove the check in the next version.

Thanks,
Guangguan Wang

On 2023/8/4 01:55, Simon Horman wrote:
> On Thu, Aug 03, 2023 at 09:24:20PM +0800, Guangguan Wang wrote:
>> Support max connections per lgr negotiation for SMCR v2.1,
>> which is one of smc v2.1 features.
>>
>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>> Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
> 
> ...
> 
> Hi Guangguan Wang,
> 
>>  int smc_clc_cli_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
>>  				      struct smc_init_info *ini)
>>  {
>> +	struct smc_clc_first_contact_ext_v2x *fce_v2x =
>> +		(struct smc_clc_first_contact_ext_v2x *)fce;
>> +
>>  	if (ini->release_ver < SMC_RELEASE_1)
>>  		return 0;
>>  
>> +	if (!ini->is_smcd) {
>> +		if (fce_v2x->max_conns > SMC_CONN_PER_LGR_MAX)
> 
> The type of the max_cons field is u8.
> The value of SMC_CONN_PER_LGR_MAX is 255 (in another patch of this series),
> the maximum value that the max_cons field can be assigned.
> So it seems that this condition cannot ever be true.
> 
> As flagged by Smatch.
> 
>> +			return SMC_CLC_DECL_MAXCONNERR;
>> +		ini->max_conns = fce_v2x->max_conns;
>> +	}
>> +
>>  	return 0;
>>  }
> 
> ...
> 
>> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
> 
> ...
> 
>> @@ -236,7 +238,8 @@ struct smc_clc_first_contact_ext {
>>  
>>  struct smc_clc_first_contact_ext_v2x {
>>  	struct smc_clc_first_contact_ext fce_v20;
>> -	u8 reserved3[4];
>> +	u8 max_conns; /* for SMC-R only */
>> +	u8 reserved3[3];
>>  	__be32 vendor_exp_options;
>>  	u8 reserved4[8];
>>  } __packed;		/* format defined in
> 
> ...
> 
>> diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
>> index 1a97fef39127..065369dc6584 100644
>> --- a/net/smc/smc_core.h
>> +++ b/net/smc/smc_core.h
>> @@ -22,6 +22,7 @@
>>  #include "smc_ib.h"
>>  
>>  #define SMC_RMBS_PER_LGR_MAX	255	/* max. # of RMBs per link group */
>> +#define SMC_CONN_PER_LGR_MAX	255	/* max. # of connections per link group */
>>  
>>  struct smc_lgr_list {			/* list of link group definition */
>>  	struct list_head	list;
