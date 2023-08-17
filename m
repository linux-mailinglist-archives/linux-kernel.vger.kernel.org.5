Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFE577EF82
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 05:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347837AbjHQDXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 23:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347831AbjHQDXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 23:23:20 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4659D26BC;
        Wed, 16 Aug 2023 20:23:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VpyCdS._1692242593;
Received: from 30.221.109.120(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0VpyCdS._1692242593)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 11:23:14 +0800
Message-ID: <e6a97304-801d-476c-f8cf-9828175aaf34@linux.alibaba.com>
Date:   Thu, 17 Aug 2023 11:23:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net-next 2/6] net/smc: add vendor unique experimental
 options area in clc handshake
Content-Language: en-US
To:     Jan Karcher <jaka@linux.ibm.com>, wenjia@linux.ibm.com,
        kgraul@linux.ibm.com, tonylu@linux.alibaba.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230816083328.95746-1-guangguan.wang@linux.alibaba.com>
 <20230816083328.95746-3-guangguan.wang@linux.alibaba.com>
 <dc94f888-971b-dbc2-d417-9e14734266fc@linux.ibm.com>
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <dc94f888-971b-dbc2-d417-9e14734266fc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/17 05:49, Jan Karcher wrote:
> Hi Guangguan Wang,
> 
> thank you, some minor thoughts on this one.
> 
> On 16/08/2023 10:33, Guangguan Wang wrote:
...
>>   -static void smc_clc_fill_fce(struct smc_clc_first_contact_ext *fce, int *len, int release_nr)
>> +static int smc_clc_fill_fce(struct smc_clc_first_contact_ext_v2x *fce,
>> +                struct smc_init_info *ini)
>>   {
>> +    int ret = sizeof(*fce);
>> +
>>       memset(fce, 0, sizeof(*fce));
>> -    fce->os_type = SMC_CLC_OS_LINUX;
>> -    fce->release = release_nr;
>> -    memcpy(fce->hostname, smc_hostname, sizeof(smc_hostname));
>> -    (*len) += sizeof(*fce);
>> +    fce->fce_v20.os_type = SMC_CLC_OS_LINUX;
>> +    fce->fce_v20.release = ini->release_nr;
> 
> I don't like that this is called fce_v20.release which can be set to v2.1 here although the struct is named v20. Maybe let us call the struct something like fce_v2_base or fce_base_v2.
> 

fce_v2_base sounds better.


>> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
>> index b923e89acafb..6133276a8839 100644
>> --- a/net/smc/smc_clc.h
>> +++ b/net/smc/smc_clc.h
>> @@ -147,7 +147,9 @@ struct smc_clc_msg_proposal_prefix {    /* prefix part of clc proposal message*/
>>   struct smc_clc_msg_smcd {    /* SMC-D GID information */
>>       struct smc_clc_smcd_gid_chid ism; /* ISM native GID+CHID of requestor */
>>       __be16 v2_ext_offset;    /* SMC Version 2 Extension Offset */
>> -    u8 reserved[28];
>> +    u8 vendor_oui[3];
>> +    u8 vendor_exp_options[5];
>> +    u8 reserved[20];
> 
> Could we either make those variables a bit more self explaining via their name (e.g. vendor_organization_uid) or adding a comment /* vendor organizationally unique identifier */
> 

I will fix it in the next version.

>>   };
>>     struct smc_clc_smcd_v2_extension {
>> @@ -231,8 +233,17 @@ struct smc_clc_first_contact_ext {
>>       u8 hostname[SMC_MAX_HOSTNAME_LEN];
>>   };
>>   +struct smc_clc_first_contact_ext_v2x {
>> +    struct smc_clc_first_contact_ext fce_v20;
> 
> as stated at the top where the release is assigned i'm not completly happy with the naming.
> 

Thanks,
Guangguan Wang
