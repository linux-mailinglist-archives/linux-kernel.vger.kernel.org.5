Return-Path: <linux-kernel+bounces-110860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 274708864DA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89C61B22898
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E6B1854;
	Fri, 22 Mar 2024 01:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dcPjfT7n"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCA010E3;
	Fri, 22 Mar 2024 01:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711071475; cv=none; b=bJL/tdI+kzbvXBVtINh1im8i1hFc5v/ZrrNQM3k34zcA87Gc17Itl2ZnQG8Q7E894cq7GpJQ9AHfOfga8s9jN2g3HQvjMYUezW12xg1TdTxbNqTqa76cPVwkgfvGnbOdKWaMtKp8+BAqi/YOPv5tuQRPXwPR1wM4QhCIgB2bdfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711071475; c=relaxed/simple;
	bh=8lYMDJpUx/aLm0fHI9/bew2MPturqTZ6eLFlyr/lTDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DrFywSssVCFT43M8JhxtMdqTifNiTBP0xYusuhgv8Hy2UR9MedxX+KOK8iwCIEHEkmk9HHXUmrbiuzdeqeySTT+UEb23tY/RmESCVfz+/SM0mnebBsk/RtvPHuBMZNkn/wCpD3cX7JTquMhcA8xwsqiV3JN1LNCUpPInjL2uknk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dcPjfT7n; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711071469; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=apJWPV3ytW4HLunpb5+1fnBaCMME7Wey6HMt3Ik1kG8=;
	b=dcPjfT7nYK0QwimOiV16UPYwftbAQKUz9Q1+p6feKDaNJ99+NPtmXzNltQk8/csUaT+LyjBfGdmeE+0EhS5pFlusCNQKxcGkA34DQoXP/HEFhYLXfSWgBR09F+mh0RkwrgXfeBpzH3PptFEIOMl3R1KVAxub9qmOIefsPZGtOVY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W305t6s_1711071453;
Received: from 30.221.130.60(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W305t6s_1711071453)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 09:37:48 +0800
Message-ID: <8bf123c3-4835-46c5-ada3-6d94fab34e65@linux.alibaba.com>
Date: Fri, 22 Mar 2024 09:37:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v4 03/11] net/smc: implement ID-related
 operations of loopback-ism
To: Jan Karcher <jaka@linux.ibm.com>, wintera@linux.ibm.com,
 twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240317100545.96663-1-guwen@linux.alibaba.com>
 <20240317100545.96663-4-guwen@linux.alibaba.com>
 <468c16e7-b546-4017-8876-358b87f70f84@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <468c16e7-b546-4017-8876-358b87f70f84@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/3/21 16:12, Jan Karcher wrote:
> 
> 
> On 17/03/2024 11:05, Wen Gu wrote:
>> This implements GID and CHID related operations of loopback-ism device.
>> loopback-ism acts as an ISMv2. It's GID is generated randomly by UUIDv4
>> algorithm and CHID is reserved 0xFFFF.
> 
> Hi Wen Gu,
> 
> Please add that loopback-ism uses an extended GID instead of a GID here aswell.
> 

OK, will add that. Thanks!
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>>   net/smc/smc_loopback.c | 62 ++++++++++++++++++++++++++++++++++++++----
>>   net/smc/smc_loopback.h |  3 ++
>>   2 files changed, 60 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
>> index e9170d86e58f..7656a2474500 100644
>> --- a/net/smc/smc_loopback.c
>> +++ b/net/smc/smc_loopback.c
>> @@ -19,11 +19,62 @@
>>   #include "smc_loopback.h"
>>   #if IS_ENABLED(CONFIG_SMC_LO)
>> +#define SMC_LO_V2_CAPABLE    0x1 /* loopback-ism acts as ISMv2 */
>> +
>>   static const char smc_lo_dev_name[] = "loopback-ism";
>>   static struct smc_lo_dev *lo_dev;
>> +static void smc_lo_generate_id(struct smc_lo_dev *ldev)
>> +{
>> +    struct smcd_gid *lgid = &ldev->local_gid;
>> +    uuid_t uuid;
>> +
>> +    uuid_gen(&uuid);
>> +    memcpy(&lgid->gid, &uuid, sizeof(lgid->gid));
>> +    memcpy(&lgid->gid_ext, (u8 *)&uuid + sizeof(lgid->gid),
>> +           sizeof(lgid->gid_ext));
>> +
>> +    ldev->chid = SMC_LO_CHID;
>> +}
> 
> Minor comment. The function name implies that there is one id set whle
> there are two different ones. The chid assignment can be easily looked over. Maybe changing the function name to 
> `smc_lo_generate_ids` would prevent this. What do you think?
> 

Agree. I will change the function name to 'smc_lo_generate_ids'. Thanks!

> Thanks
> - Jan
> 
>> +
>> +static int smc_lo_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
>> +                 u32 vid_valid, u32 vid)
>> +{
>> +    struct smc_lo_dev *ldev = smcd->priv;
>> +
>> +    /* rgid should be the same as lgid */
>> +    if (!ldev || rgid->gid != ldev->local_gid.gid ||
>> +        rgid->gid_ext != ldev->local_gid.gid_ext)
>> +        return -ENETUNREACH;
>> +    return 0;
>> +}
>> +
>> +static int smc_lo_supports_v2(void)
>> +{
>> +    return SMC_LO_V2_CAPABLE;
>> +}
>> +
>> +static void smc_lo_get_local_gid(struct smcd_dev *smcd,
>> +                 struct smcd_gid *smcd_gid)
>> +{
>> +    struct smc_lo_dev *ldev = smcd->priv;
>> +
>> +    smcd_gid->gid = ldev->local_gid.gid;
>> +    smcd_gid->gid_ext = ldev->local_gid.gid_ext;
>> +}
>> +
>> +static u16 smc_lo_get_chid(struct smcd_dev *smcd)
>> +{
>> +    return ((struct smc_lo_dev *)smcd->priv)->chid;
>> +}
>> +
>> +static struct device *smc_lo_get_dev(struct smcd_dev *smcd)
>> +{
>> +    return &((struct smc_lo_dev *)smcd->priv)->dev;
>> +}
>> +
>>   static const struct smcd_ops lo_ops = {
>> -    .query_remote_gid    = NULL,
>> +    .query_remote_gid = smc_lo_query_rgid,
>>       .register_dmb        = NULL,
>>       .unregister_dmb        = NULL,
>>       .add_vlan_id        = NULL,
>> @@ -32,10 +83,10 @@ static const struct smcd_ops lo_ops = {
>>       .reset_vlan_required    = NULL,
>>       .signal_event        = NULL,
>>       .move_data        = NULL,
>> -    .supports_v2        = NULL,
>> -    .get_local_gid        = NULL,
>> -    .get_chid        = NULL,
>> -    .get_dev        = NULL,
>> +    .supports_v2 = smc_lo_supports_v2,
>> +    .get_local_gid = smc_lo_get_local_gid,
>> +    .get_chid = smc_lo_get_chid,
>> +    .get_dev = smc_lo_get_dev,
>>   };
>>   static struct smcd_dev *smcd_lo_alloc_dev(const struct smcd_ops *ops,
>> @@ -95,6 +146,7 @@ static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev)
>>   static int smc_lo_dev_init(struct smc_lo_dev *ldev)
>>   {
>> +    smc_lo_generate_id(ldev);
>>       return smcd_lo_register_dev(ldev);
>>   }
>> diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
>> index 9dd44d4c0ca3..55b41133a97f 100644
>> --- a/net/smc/smc_loopback.h
>> +++ b/net/smc/smc_loopback.h
>> @@ -20,10 +20,13 @@
>>   #if IS_ENABLED(CONFIG_SMC_LO)
>>   #define SMC_LO_MAX_DMBS        5000
>> +#define SMC_LO_CHID        0xFFFF
>>   struct smc_lo_dev {
>>       struct smcd_dev *smcd;
>>       struct device dev;
>> +    u16 chid;
>> +    struct smcd_gid local_gid;
>>   };
>>   #endif

