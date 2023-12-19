Return-Path: <linux-kernel+bounces-5160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FFF81875D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B3F2853E6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CBB18651;
	Tue, 19 Dec 2023 12:22:45 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A311D18E16;
	Tue, 19 Dec 2023 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Vyqx4q8_1702988557;
Received: from 30.221.130.243(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vyqx4q8_1702988557)
          by smtp.aliyun-inc.com;
          Tue, 19 Dec 2023 20:22:38 +0800
Message-ID: <b7ae6ca1-efb4-0f35-8f83-ecd28ab16632@linux.alibaba.com>
Date: Tue, 19 Dec 2023 20:22:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v7 07/10] net/smc: compatible with 128-bits
 extended GID of virtual ISM device
To: Simon Horman <horms@kernel.org>
Cc: wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kgraul@linux.ibm.com, jaka@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 raspl@linux.ibm.com, schnelle@linux.ibm.com,
 guangguan.wang@linux.alibaba.com, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231219084536.8158-1-guwen@linux.alibaba.com>
 <20231219084536.8158-8-guwen@linux.alibaba.com>
 <20231219115952.GL811967@kernel.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20231219115952.GL811967@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/12/19 19:59, Simon Horman wrote:
> On Tue, Dec 19, 2023 at 04:45:33PM +0800, Wen Gu wrote:
>> According to virtual ISM support feature defined by SMCv2.1, GIDs of
>> virtual ISM device are UUIDs defined by RFC4122, which are 128-bits
>> long. So some adaptation work is required. And note that the GIDs of
>> existing platform firmware ISM devices still remain 64-bits long.
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> 
> ...
> 
>> @@ -1023,9 +1041,12 @@ smcd_clc_prep_confirm_accept(struct smc_connection *conn,
>>   	if (version == SMC_V1) {
>>   		clc->hdr.length = htons(SMCD_CLC_ACCEPT_CONFIRM_LEN);
>>   	} else {
>> -		clc->d1.chid = htons(smc_ism_get_chid(smcd));
>> +		chid = smc_ism_get_chid(smcd);
>> +		clc->d1.chid = htons(chid);
>>   		if (eid && eid[0])
>>   			memcpy(clc->d1.eid, eid, SMC_MAX_EID_LEN);
>> +		if (__smc_ism_is_virtual(chid))
>> +			clc->d1.gid_ext = htonll(smcd_gid.gid_ext);
> 
> Hi Wen Gu,
> 
> The type of clc->d1.gid_ext is u64 (host byte-order)
> but here it is being assigned a big endian value.
> This does not seem correct.
> 
> Flagged by Smatch.

Oh, thank you Simon! That's a regression. I mistakenly changed the type
to u64 instead of __be64 in previous versions when fixing conflicts.
Thank you very much for the catch.

> 
>>   		len = SMCD_CLC_ACCEPT_CONFIRM_LEN_V2;
>>   		if (first_contact) {
>>   			*fce_len = smc_clc_fill_fce_v2x(fce_v2x, ini);
> 
> ...
> 

