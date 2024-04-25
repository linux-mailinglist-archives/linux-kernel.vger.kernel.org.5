Return-Path: <linux-kernel+bounces-158446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C14F8B2041
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91679B258B3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA4412BE86;
	Thu, 25 Apr 2024 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GnFK4Zcy"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0C112AAE1;
	Thu, 25 Apr 2024 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714044618; cv=none; b=TJNc/A87wPyq8auLrTE5E/J4PPEH7byjR3E7FDzpwxUfiBNxQxL6G5en5mftwe94qu63HrXNwdFfCNp4+wGw1tBzwFJwOqFmoIA/0vkh2yLvkVZab7NY+MOG9UyXr7Qq3JZINz7RHi7JfS185qC5rDhMCVbRbG4TZh/mx/Uu2IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714044618; c=relaxed/simple;
	bh=ngh9dyGBNBQ3gt7J8bclBNcbWH/V4l/vqS6IC2Y0V08=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kAOEOAQLRD/hrNw68lFEEge87K1RNrDb4G0xm4N+B75xdS1771LTqfgWFbOKBIDyeTVNPHXlEoYMWgahEh7MPpeYyL7MATA07o39/MMdh5IUNDEh6Ou9mm26AU/oA3+ZodLYbr0GE22yxSOOoKZLRCxEVrWn5XEemXKoMaYvGOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GnFK4Zcy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43PBKulU028240;
	Thu, 25 Apr 2024 11:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=t10rlvX7rxBvHSysJVI0diYkG8Lb0HfMqWi4O/A9Byc=;
 b=GnFK4ZcyKvgYR4bBPhAknxHmJ3iMiGOTRxz39n4YAUlMkIeyurBll9AiDWbM8/GhCM/Y
 0QfajS0ZZGFRWLOkhl2HGmmQQ/pEfTyVvS0mFxBQUQDunTnw/5MTbG9oVCaJL/3BdM27
 XJznhJ5zHFeO6HYpgzL2U7hu5iJxs39qbRjHdjSajLJKKNpbieHuW+AG6+lU60aew9PY
 4CZ7uGk6Bvub7Wks7tojBRpUwa2yplJC/QzVbTSE+1ELEhjCb3ccfd6MnoNukeim1jvh
 PIhY5LvJFzw35rCXYKQyYWYeXraTxB2kE0Ek9Ck2tYTKtAIo6V4G9mn42mtNhxdCma3Y Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqp7gr0rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 11:30:05 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43PBU5TG009638;
	Thu, 25 Apr 2024 11:30:05 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqp7gr0r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 11:30:05 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43P8g5dH023068;
	Thu, 25 Apr 2024 11:30:04 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xms1p9ewq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 11:30:04 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43PBU0vT46400128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 11:30:02 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C798558052;
	Thu, 25 Apr 2024 11:30:00 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1439158069;
	Thu, 25 Apr 2024 11:29:58 +0000 (GMT)
Received: from [9.171.19.157] (unknown [9.171.19.157])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Apr 2024 11:29:57 +0000 (GMT)
Message-ID: <fdb3a792-c9ed-4de6-80e8-686a695d3bbc@linux.ibm.com>
Date: Thu, 25 Apr 2024 13:29:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wenjia Zhang <wenjia@linux.ibm.com>
Subject: Re: [PATCH net-next v6 01/11] net/smc: decouple ism_client from SMC-D
 DMB registration
To: Alexandra Winter <wintera@linux.ibm.com>,
        Wen Gu
 <guwen@linux.alibaba.com>, twinkler@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20240414040304.54255-1-guwen@linux.alibaba.com>
 <20240414040304.54255-2-guwen@linux.alibaba.com>
 <c7f6be91-6591-4b00-95c3-48417bf98ac1@linux.ibm.com>
Content-Language: en-GB
In-Reply-To: <c7f6be91-6591-4b00-95c3-48417bf98ac1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Tq_GrZG8Vy1A2pXLWK6Co-wJMNEyetf4
X-Proofpoint-ORIG-GUID: cgjDypTh5ka5n5aLFIM1S_ZAxE32Tooj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_11,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404250083



On 15.04.24 10:41, Alexandra Winter wrote:
> 
> 
> On 14.04.24 06:02, Wen Gu wrote:
>> The struct 'ism_client' is specialized for s390 platform firmware ISM.
>> So replace it with 'void' to make SMCD DMB registration helper generic
>> for both Emulated-ISM and existing ISM.
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
> 
> Just a thought:
> The client concept is really specific to s390 platform firmware ISM.
> So wouldn't it be nice to do something like:
> 
> diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
> index 78cca4839a31..37dcdf2bc044 100644
> --- a/drivers/s390/net/ism_drv.c
> +++ b/drivers/s390/net/ism_drv.c
> @@ -747,10 +747,9 @@ static int smcd_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
>          return ism_query_rgid(smcd->priv, rgid->gid, vid_valid, vid);
>   }
> 
> -static int smcd_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
> -                            struct ism_client *client)
> +static int smcd_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
>   {
> -       return ism_register_dmb(smcd->priv, (struct ism_dmb *)dmb, client);
> +       return ism_register_dmb(smcd->priv, (struct ism_dmb *)dmb, &smc_ism_client);
>   }
> 
>   static int smcd_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
> 
> --------------
> 
> This is not a real patch, just a sketch, but I hope you
> get the idea.
> 
> 
> This may be a step in the direction of moving the ism_client concept from
> net/smc/smc_ism.c to drivers/s390/net/ism*
> 
> 
> I know that there are several dependencies to consider.
> And I haven't looked at the other patches in this series yet in detail, to see how you solve
> things like smcd_register_dev. Seems like smcd_register_dmb() is the only one of the smcd_ops
> that you need for loopback and uses ism_client.
> 
> 
> 
> Wenjia, Gerd, and others what do you think?


IMO, the idea is not bad, but it should not belong to this patch series.

