Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1847CD6B4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344715AbjJRIfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbjJRIfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:35:44 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7458BBA;
        Wed, 18 Oct 2023 01:35:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VuQCMVo_1697618136;
Received: from 30.221.100.193(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0VuQCMVo_1697618136)
          by smtp.aliyun-inc.com;
          Wed, 18 Oct 2023 16:35:37 +0800
Message-ID: <c7277fd2-cc44-40a1-9f56-9341d3340e2e@linux.alibaba.com>
Date:   Wed, 18 Oct 2023 16:35:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net/smc: correct the reason code in
 smc_listen_find_device when fallback
Content-Language: en-US
To:     dust.li@linux.alibaba.com, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     tonylu@linux.alibaba.com, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231017124234.99574-1-guangguan.wang@linux.alibaba.com>
 <20231017124234.99574-3-guangguan.wang@linux.alibaba.com>
 <20231018070142.GY92403@linux.alibaba.com>
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <20231018070142.GY92403@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/18 15:01, Dust Li wrote:
> On Tue, Oct 17, 2023 at 08:42:34PM +0800, Guangguan Wang wrote:
>> The ini->rc is used to store the last error happened when finding usable
>> ism or rdma device in smc_listen_find_device, and is set by calling smc_
>> find_device_store_rc. Once the ini->rc is assigned to an none-zero value,
>> the value can not be overwritten anymore. So the ini-rc should be set to
>> the error reason only when an error actually occurs.
>>
>> When finding ISM/RDMA devices, device not found is not a real error, as
>> not all machine have ISM/RDMA devices. Failures after device found, when
>> initializing device or when initializing connection, is real errors, and
>> should be store in ini->rc.
>>
>> SMC_CLC_DECL_DIFFPREFIX also is not a real error, as for SMC-RV2, it is
>> not require same prefix.
>>
>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
>> ---
>> net/smc/af_smc.c | 12 +++---------
>> 1 file changed, 3 insertions(+), 9 deletions(-)
>>
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index b3a67a168495..21e9c6ec4d01 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -2163,10 +2163,8 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
>> 	}
>> 	mutex_unlock(&smcd_dev_list.mutex);
>>
>> -	if (!ini->ism_dev[0]) {
>> -		smc_find_device_store_rc(SMC_CLC_DECL_NOSMCD2DEV, ini);
>> +	if (!ini->ism_dev[0])
> 
> Hi Guangguan,
> 
> Generally, I think this is right. Fallback in one kind of device should
> not be the final fallback reason.
> 
> But what if we have more than one device and failed more than once, for
> example:
> Let's say we have an ISM device, a RDMA device. First we looked the ISM device
> and failed during the initialization, we got a fallback reason A. Then we
> looked for the RDMA device, and failed again, with another reason B.
> Finally, we fallback to TCP. What should fallback reason be ?

IMO, the order of finding devices is defined by preference. ISM v2, ISM v1, RDMA v2, RDMA v1, the former the prefer.
I think it should return the most preferred device's failure reason if found and failed during the initialization.
So, here should return the first reason(reason A). 

> 
> OTOH, SMC_CLC_DECL_NOSMCD2DEV is only used here. Removing it would mean
> that we would never see SMC_CLC_DECL_NOSMCD2DEV in the fallback reason,
> which makes it meaningless.
>
 
Is SMC_CLC_DECL_NOSMCD2DEV really necessary? There is no reason names SMC_CLC_DECL_NOSMCR2DEV.

Thanks,
Guangguan Wang

> Best regards,
> Dust
> 
>> 		goto not_found;
>> -	}
>>
>> 	smc_ism_get_system_eid(&eid);
>> 	if (!smc_clc_match_eid(ini->negotiated_eid, smc_v2_ext,
>> @@ -2216,9 +2214,9 @@ static void smc_find_ism_v1_device_serv(struct smc_sock *new_smc,
>> 	rc = smc_listen_ism_init(new_smc, ini);
>> 	if (!rc)
>> 		return;		/* V1 ISM device found */
>> +	smc_find_device_store_rc(rc, ini);
>>
>> not_found:
>> -	smc_find_device_store_rc(rc, ini);
>> 	ini->smcd_version &= ~SMC_V1;
>> 	ini->ism_dev[0] = NULL;
>> 	ini->is_smcd = false;
>> @@ -2267,10 +2265,8 @@ static void smc_find_rdma_v2_device_serv(struct smc_sock *new_smc,
>> 	ini->smcrv2.saddr = new_smc->clcsock->sk->sk_rcv_saddr;
>> 	ini->smcrv2.daddr = smc_ib_gid_to_ipv4(smc_v2_ext->roce);
>> 	rc = smc_find_rdma_device(new_smc, ini);
>> -	if (rc) {
>> -		smc_find_device_store_rc(rc, ini);
>> +	if (rc)
>> 		goto not_found;
>> -	}
>> 	if (!ini->smcrv2.uses_gateway)
>> 		memcpy(ini->smcrv2.nexthop_mac, pclc->lcl.mac, ETH_ALEN);
>>
>> @@ -2331,8 +2327,6 @@ static int smc_listen_find_device(struct smc_sock *new_smc,
>>
>> 	/* check for matching IP prefix and subnet length (V1) */
>> 	prfx_rc = smc_listen_prfx_check(new_smc, pclc);
>> -	if (prfx_rc)
>> -		smc_find_device_store_rc(prfx_rc, ini);
>>
>> 	/* get vlan id from IP device */
>> 	if (smc_vlan_by_tcpsk(new_smc->clcsock, ini))
>> -- 
>> 2.24.3 (Apple Git-128)
