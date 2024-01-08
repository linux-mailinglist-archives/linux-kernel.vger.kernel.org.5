Return-Path: <linux-kernel+bounces-20068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECC68278EA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D6E282360
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121895577B;
	Mon,  8 Jan 2024 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dBZD3Nol"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7006755774;
	Mon,  8 Jan 2024 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 408JCQBm017167;
	Mon, 8 Jan 2024 20:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=5Rl5b4kNz1Iyh9nA9DJopv7up/07gSPUzt3uEewWmYY=;
 b=dBZD3NolpiIPP7X5QVH14LW+AyvPjEULG6z7E1HlO0bD1eUX4arZ25DwebFKA7Kmhd9W
 Cxr6sZ+bzHPAG+yklQ/bf2bBoBmY2TGXyJE7xiDbioDMaZV6W5jO2BG/MogvGWVQ7Ffo
 pcTInIAkoE7eby5oLx1GdTfbb4f6XXDrHv9HztC7gbVSJG3tcE4I4gLzQscLsy7J34bq
 9WQdlJdJ6bjYnZFTf7ZzdgMtuDtp89WUS3HXPXeno2Qo0J7Kxzf6pXXxbgU3k79o+VJM
 gbustWlDj1epw3dEMi8II4GaR7jJPZCKpyldgZIybIEaV1swIrJ+1uIlY8UP5pBrcwgP ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vgq0f96hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 20:04:47 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 408JkeIt028792;
	Mon, 8 Jan 2024 20:04:46 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vgq0f96h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 20:04:46 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 408Jx0Qw000400;
	Mon, 8 Jan 2024 20:04:44 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfh6stj7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 20:04:44 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 408K4iqR28181140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jan 2024 20:04:44 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0151A58054;
	Mon,  8 Jan 2024 20:04:44 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78B7958050;
	Mon,  8 Jan 2024 20:04:42 +0000 (GMT)
Received: from [9.61.145.235] (unknown [9.61.145.235])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jan 2024 20:04:42 +0000 (GMT)
Message-ID: <d5b2ce4b-ada0-46d3-98b1-8648127dec2b@linux.ibm.com>
Date: Mon, 8 Jan 2024 14:04:42 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/8] tpm: tis-i2c: Add more compatible strings
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com,
        johannes.holland@infineon.com, linux@roeck-us.net, broonie@kernel.org,
        patrick.rudolph@9elements.com, vincent@vtremblay.dev,
        peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com, bhelgaas@google.com,
        naresh.solanki@9elements.com, alexander.stein@ew.tq-group.com,
        festevam@denx.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-hardening@vger.kernel.org, geissonator@yahoo.com
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-8-ninad@linux.ibm.com>
 <20231212-avid-grill-dbead068fac8@spud>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20231212-avid-grill-dbead068fac8@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BcrSbIDUA20AqXyea8yQeaJgquxaRGP_
X-Proofpoint-ORIG-GUID: t6ymHn9VIXq4mcG7cAxPC29lgDsKcsDm
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-08_09,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 clxscore=1015 spamscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401080166

Hello Conor,

On 12/12/23 11:15, Conor Dooley wrote:
> On Tue, Dec 12, 2023 at 10:40:03AM -0600, Ninad Palsule wrote:
>> From: Joel Stanley <joel@jms.id.au>
>>
>> The NPCT75x TPM is TIS compatible. It has an I2C and SPI interface.
>>
>> https://www.nuvoton.com/products/cloud-computing/security/trusted-platform-module-tpm/
>>
>> Add a compatible string for it, and the generic compatible.
>>
>> OpenBMC-Staging-Count: 3
> Delete this from every patch that it appears from.
Removed.
>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Link: https://lore.kernel.org/r/20220928043957.2636877-4-joel@jms.id.au
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>>   drivers/char/tpm/tpm_tis_i2c.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
>> index a897402cc36a..9511c0d50185 100644
>> --- a/drivers/char/tpm/tpm_tis_i2c.c
>> +++ b/drivers/char/tpm/tpm_tis_i2c.c
>> @@ -383,6 +383,8 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
>>   #ifdef CONFIG_OF
>>   static const struct of_device_id of_tis_i2c_match[] = {
>>   	{ .compatible = "infineon,slb9673", },
>> +	{ .compatible = "nuvoton,npct75x", },
>> +	{ .compatible = "tcg,tpm-tis-i2c", },
> What's the point of the generic compatible if you are adding the device
> specific ones to the driver anyway?
>
> Thanks,
> Conor.

I have removed this commit from this patchset and send it as a separate 
patch.

Regards,

Ninad


