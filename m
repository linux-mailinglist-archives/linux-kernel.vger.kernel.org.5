Return-Path: <linux-kernel+bounces-145432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5441D8A5613
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D44A41F228A4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EF877F08;
	Mon, 15 Apr 2024 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nr59BGyj"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327247602A;
	Mon, 15 Apr 2024 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193928; cv=none; b=eWPdvWIWviVKQIM8yODBCNUN43XOWmH27UEQD3ra82P40fJwN/Hb6PKSAbGFAAaIHpOpjLYN44eTl3LB7j/xda97QcKkiVqowrW5UHyba7jZM2pPfnvVP08UYRMhKObuzUjK9Xk3pmKgIFd6Ow0GD47nsXbY7cyoZ4237MT4828=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193928; c=relaxed/simple;
	bh=AhVsaeNKLsQfSUwDhIxXZ+4WW601PvLgcTzUQdtxoLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+p0sFDFmFfin8bXe8iNe1C3g8AokJoxUb+Q939GxI3duKUY8UfCXspcRl4Qy+AKrhQkibxpmN8rIRDNjKgLpD9fh7q4nF3rooVRfg97m679bE6AsHHN2HFSkKyrWARVhIUlwsP+XLCPnLNpRT9B3stve64ug7FFIlxdaeH3p30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nr59BGyj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FEQUST022136;
	Mon, 15 Apr 2024 15:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=SbyGHHxuAPwJJuDThLJ122fp+48lrH6AHuEX5Eg+hI4=;
 b=Nr59BGyjTTLuEVAphAwrDqYeUDVmW0xhPA1+7bl3HOVsEcnNhCAUjZ8ioDSfcB1/rzM/
 MDlR0joHJeLZjfujjufUfUJSXhG2iB553XDkJz6UiePi+V0RL/mL6mx+g3YspWeZAMV0
 KQQT1u2sjovf++q9nDapUqduQO98yydO3wjzqgi0ppFqAsm4h8yZqnMJmPYNuEUW6CT1
 e+4EweVK8SPmZw+CMcMv21d9TBulDhJgRdhzHb0m78zGp7fHm2JWuKbcd24/CNvAu3Er
 0wooeS9EZvv31z6kgv6QFo/xQaKNAqeCyVtLEwiZljexkPZhv4Q8KLtyqxIYRpsc4VNI 0w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xgyg98xt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:11:57 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43FFBuCD002354;
	Mon, 15 Apr 2024 15:11:56 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xgyg98xsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:11:56 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43FC2MTW018206;
	Mon, 15 Apr 2024 15:11:55 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg4ct0s52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:11:55 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43FFBrIh43188892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 15:11:55 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 937A85806F;
	Mon, 15 Apr 2024 15:11:51 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6456A58071;
	Mon, 15 Apr 2024 15:11:51 +0000 (GMT)
Received: from [9.61.157.174] (unknown [9.61.157.174])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Apr 2024 15:11:51 +0000 (GMT)
Message-ID: <57291e66-fb7d-4ef8-985e-7e85866c90bb@linux.ibm.com>
Date: Mon, 15 Apr 2024 10:11:51 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fsi: occ: Remove usage of the deprecated ida_simple_xx()
 API
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-fsi@lists.ozlabs.org
References: <6e17f2145ce2bbc12af6700c8bd56a8a7bdb103d.1705738045.git.christophe.jaillet@wanadoo.fr>
 <487dcede-4ad3-4987-aff4-937513d2fa14@wanadoo.fr>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <487dcede-4ad3-4987-aff4-937513d2fa14@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 32eBqTWE-IKtnEvp4pNLJHojWrIkxwfY
X-Proofpoint-GUID: 7h145Z6SmaMlnDyrcZaYbqR5ouEXI3q8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_12,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 clxscore=1011 spamscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150099


On 4/14/24 04:00, Christophe JAILLET wrote:
> Le 20/01/2024 à 09:07, Christophe JAILLET a écrit :
>> ida_alloc() and ida_free() should be preferred to the deprecated
>> ida_simple_get() and ida_simple_remove().
>>
>> Note that the upper limit of ida_simple_get() is exclusive, but the 
>> one of
>> ida_alloc_range() is inclusive. So, this upper limit, INT_MAX, should 
>> have
>> been changed to INT_MAX-1.
>>
>> But, it is likely that the INT_MAX 'idx' is valid that the max value 
>> passed
>> to ida_simple_get() should have been 0.
>>
>> So, allow this INT_MAX 'idx' value now.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> The change related to the INT_MAX value is speculative.
>> Review with care. (or I can re-submit with INT_MAX-1, to be safe :))
>> ---
>
> Hi,
>
> polite reminder.


Thank you! Looks good.


>
> CJ
>
>
>
>>   drivers/fsi/fsi-occ.c | 17 ++++++++---------
>>   1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
>> index da35ca9e84a6..f7157c1d77d8 100644
>> --- a/drivers/fsi/fsi-occ.c
>> +++ b/drivers/fsi/fsi-occ.c
>> @@ -656,17 +656,16 @@ static int occ_probe(struct platform_device *pdev)
>>           rc = of_property_read_u32(dev->of_node, "reg", &reg);
>>           if (!rc) {
>>               /* make sure we don't have a duplicate from dts */
>> -            occ->idx = ida_simple_get(&occ_ida, reg, reg + 1,
>> -                          GFP_KERNEL);
>> +            occ->idx = ida_alloc_range(&occ_ida, reg, reg,
>> +                           GFP_KERNEL);
>>               if (occ->idx < 0)
>> -                occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX,
>> -                              GFP_KERNEL);
>> +                occ->idx = ida_alloc_min(&occ_ida, 1,
>> +                             GFP_KERNEL);
>>           } else {
>> -            occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX,
>> -                          GFP_KERNEL);
>> +            occ->idx = ida_alloc_min(&occ_ida, 1, GFP_KERNEL);
>>           }
>>       } else {
>> -        occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX, GFP_KERNEL);
>> +        occ->idx = ida_alloc_min(&occ_ida, 1, GFP_KERNEL);
>>       }
>>         platform_set_drvdata(pdev, occ);
>> @@ -680,7 +679,7 @@ static int occ_probe(struct platform_device *pdev)
>>       rc = misc_register(&occ->mdev);
>>       if (rc) {
>>           dev_err(dev, "failed to register miscdevice: %d\n", rc);
>> -        ida_simple_remove(&occ_ida, occ->idx);
>> +        ida_free(&occ_ida, occ->idx);
>>           kvfree(occ->buffer);
>>           return rc;
>>       }
>> @@ -719,7 +718,7 @@ static int occ_remove(struct platform_device *pdev)
>>       else
>>           device_for_each_child(&pdev->dev, NULL, 
>> occ_unregister_of_child);
>>   -    ida_simple_remove(&occ_ida, occ->idx);
>> +    ida_free(&occ_ida, occ->idx);
>>         return 0;
>>   }
>

