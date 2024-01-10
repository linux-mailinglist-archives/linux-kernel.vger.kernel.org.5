Return-Path: <linux-kernel+bounces-22461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4102829E05
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E0D1F29434
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E524C601;
	Wed, 10 Jan 2024 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ADB3nMVw"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CD34BAB0;
	Wed, 10 Jan 2024 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40AEnpx2010921;
	Wed, 10 Jan 2024 15:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=M1x94nggq8LdhSeujsxvuxzsQ7Q9QHrmlhYOHEI3Q5I=;
 b=ADB3nMVw2jnagow3OGDsz5wj4T8CHn+QOEO+qJiiUJPww7ssOJaPcDb4exn0TnIisWlK
 zK/GBbmPDX22TjEy2KJNWhy/ny4CwFCZMx+cNDJjEJQoSxsTZfGE4aFdJvg2uMm5AAPr
 0zMlF0z631CfdGGlJSo3vc6m/4ceZwbH04NBhoFRBf1/SDk0o2Rfl3i5xI3WBMLM019Q
 r/PQmBqKJW0yKIHXkEuBsST+WVUA6gp/ObZk4fmMDfoAb4AajLPP25qkJ4oRdpWsu9ci
 xhS/8TgcCjtlueqdowPm+3c5h8JNvhKz56phj9in4ly0APo9Py0wBfparzAmyiQav9SE Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhtygp6nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 15:54:23 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40AFToc5012080;
	Wed, 10 Jan 2024 15:54:22 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhtygp6n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 15:54:22 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40AFPEGN023399;
	Wed, 10 Jan 2024 15:54:21 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfj6np45c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 15:54:21 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40AFsK8U34734678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 15:54:20 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D5F958060;
	Wed, 10 Jan 2024 15:54:20 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1B745803F;
	Wed, 10 Jan 2024 15:54:19 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jan 2024 15:54:19 +0000 (GMT)
Message-ID: <385b06e9-1daa-408a-a0ed-7b09d7d539df@linux.ibm.com>
Date: Wed, 10 Jan 2024 09:54:19 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/8] tpm: tis-i2c: Add more compatible strings
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, joel@jms.id.au,
        andrew@codeconstruct.com.au, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, johannes.holland@infineon.com, broonie@kernel.org,
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
 <73381bb0-7fa7-4a9e-88df-ab0063058e26@roeck-us.net>
 <20231212-mouth-choice-40a83caa34ec@spud>
 <2946fbb1-2a47-4d21-83dc-8e45bf6ba5a9@roeck-us.net>
 <60c8bbdb-4e08-44f0-88d4-ab164d4843b5@linux.ibm.com>
 <20240109-pep-coerce-2a86ae88753d@spud>
 <01974929-dfbf-4989-ba39-369e521827d0@linux.ibm.com>
 <3d194e84-bf1a-48e4-a376-e5c327c6508d@linaro.org>
 <2dd37d2b-28da-4e73-9047-61ec5d64bdb5@linux.ibm.com>
 <edbefdfd-eb59-4d86-ad07-feb066a21082@linaro.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <edbefdfd-eb59-4d86-ad07-feb066a21082@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ClzU1lg6nO0jo1U0wZR4R1Ct_tngOkk0
X-Proofpoint-ORIG-GUID: yRfIySWjXJbIE0eYhTmuHQKN9CUs3ttz
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
 definitions=2024-01-10_07,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401100128

Hello Krzysztof,


On 1/10/24 09:37, Krzysztof Kozlowski wrote:
> On 10/01/2024 15:31, Ninad Palsule wrote:
>> Hello Krzysztof,
>>
>>
>>
>>>>>> I have send it as a separate commit. https://lore.kernel.org/linux-kernel/20231214144954.3833998-1-ninad@linux.ibm.com/
>>>>> Why did you do that? It now just adds undocumented compatibles to the
>>>>> driver. Please, as Rob requested, work with Lukas on his series to make
>>>>> sure that these devices are documented.
>>>> I think krzysztof kozlowski suggested to send these patches separately:
>>>> https://lore.kernel.org/linux-kernel/1c5ace65-2fd8-4503-b22f-e0f564d1c83f@linaro.org/
>>>>
>>>> Did I misunderstood it? Do you guys want me to include that commit again?
>>> My comment was in DTS thread under specific DTS patch. How did you
>>> figure out it applies to driver and bindings? This does not make sense.
>> Sorry for the misunderstanding. Where do you want me to add driver
>> patch? Before all DTS patches or after all DTS patches?
> Does not matter, why do you insist on combining them with DTS? Drivers
> and bindings are going together. DTS better separate, although depending
> on the case can be together.
>
I have combined DTS and Driver because DTS was using compatibility 
string which is not upstream yet hence I thought it is logical to send 
it under same patchset.

Conor and Rob, Do you have preference?

Thanks & Regards,

Ninad Palsule


