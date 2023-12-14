Return-Path: <linux-kernel+bounces-188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3D0813D3F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBD6283793
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5C32C690;
	Thu, 14 Dec 2023 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RyeVJezb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2932D2C6AC;
	Thu, 14 Dec 2023 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEMMeU3017468;
	Thu, 14 Dec 2023 22:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=uSsNsrecFwec9uxfp0XGhKAOvRFJk3ghXzM1uZdpbCk=;
 b=RyeVJezbNk8zyu1KXhO+9Q65yM/rmI1M/Pe9/kPHNdVAzivdu63ExGJwFKyCvji1JLGl
 KpMdsHh83jFTPxfCRgupKgZUjkbpotaZFDVhNB9UpezKWAlDYDHZFX0wnT/Ve9A0laxj
 eIcLudf+bl1vRnUHpJNjoNbR1Iq+qQwPYewK4FSt+ncnUwYTw8+y7RuHW7tNxuo+T280
 oij9SZpQhpinQcehTiEh6nqtO+Q9T4xKb4E3S3hHg8Ex2zanHjOUCe0RsU1IK+hKjpTQ
 Kb4pM+YLREOZUu0UO/CMnV9G7QG202bzVGErP/swjDiuPaxRAF+eDXmzyF/EN8P8nxdo OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0aeg80rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 22:23:43 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BEMNgt5020084;
	Thu, 14 Dec 2023 22:23:42 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0aeg80qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 22:23:42 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEJD1ms014803;
	Thu, 14 Dec 2023 22:23:41 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw42kj5yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 22:23:41 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BEMNeej29426394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 22:23:40 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D6DA58052;
	Thu, 14 Dec 2023 22:23:40 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A580B5805D;
	Thu, 14 Dec 2023 22:23:36 +0000 (GMT)
Received: from [9.67.23.198] (unknown [9.67.23.198])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Dec 2023 22:23:36 +0000 (GMT)
Message-ID: <87401432-c9ce-4831-908c-aa3aa922a71b@linux.ibm.com>
Date: Thu, 14 Dec 2023 16:23:35 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/8] dt-bindings: tpm: Add schema for TIS I2C devices
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, joel@jms.id.au,
        andrew@codeconstruct.com.au, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, johannes.holland@infineon.com, linux@roeck-us.net,
        broonie@kernel.org, patrick.rudolph@9elements.com,
        vincent@vtremblay.dev, peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com,
        bhelgaas@google.com, naresh.solanki@9elements.com,
        alexander.stein@ew.tq-group.com, festevam@denx.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        geissonator@yahoo.com
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-3-ninad@linux.ibm.com>
 <20231213161347.GA1204384-robh@kernel.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20231213161347.GA1204384-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L2fs2tyS94Go-JYsyllwR490nfhP7SVw
X-Proofpoint-ORIG-GUID: 4rfl-d4dKL8C9pI4K4cYIkOvQVb6iYHh
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
 definitions=2023-12-14_15,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 impostorscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140158

Hello Rob,

On 12/13/23 10:13, Rob Herring wrote:
> On Tue, Dec 12, 2023 at 10:39:58AM -0600, Ninad Palsule wrote:
>> From: Johannes Holland <johannes.holland@infineon.com>
>>
>> Add a dt schema to support device tree bindings for the generic I2C
>> physical layer. Refer to the TCG PC Client Platform TPM Profile (PTP)
>> Specification for TPM 2.0 v1.04 Revision 14.
>>
>> This includes descriptions for the Nuvoton and Infineon devices.
> This is incomplete and conflicts with this series[1]. Please help
> review and make sure it works for the cases you care about.
>
> Rob
>
> [1] https://lore.kernel.org/all/cover.1701093036.git.lukas@wunner.de/

I will take a look at the patchset. How do you want to handle mine? Do 
you want me to send patch as per the new directory structure?

Thanks for the review.

Regards,

Ninad


