Return-Path: <linux-kernel+bounces-74546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDE985D5C3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3891C22B31
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADBE2E835;
	Wed, 21 Feb 2024 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oCJEdybu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCB05228;
	Wed, 21 Feb 2024 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511935; cv=none; b=gSkL8BdBDqufc/h3SvpeH5EdErITomAi7xm7SfifW3MjTxhJEjay9iPnRy23osw9uCLGL5KXrmtT7DkIJbkZ4Y3rfSNt4GSPdwFCmkFgIvK3v2X467lb3Qk5T3KC5HyK1jlKUvhoqDBhUDcBaCfLvfI7dbBpLSW4xnCmkKmma7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511935; c=relaxed/simple;
	bh=nLif9cPksOec0uY6ZKcQ/m571IwMSv06xDWhdi4HLKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kOG8g+V8dH2FFKnFxBwX0RrrUhIc85DQVC8rdNLOL9V2pSEddneplprUuvdG2LOh+6ETsmYTq4ZFg1csGsGqutxB1W5dN91kGxq7sWrmBhB5SEVd5hBji09Z5JO2a9+JMjy5vLfrYcweKX+m5iTpMWTdrOt7+Sb7mGTbuU5BNfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oCJEdybu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L4KGUU022184;
	Wed, 21 Feb 2024 10:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=eQgXE2HnmbPldfjmzZ6CFMqQA6IzURGK0LKsk3Uwytk=; b=oC
	JEdybuG4yDwR8lC0k0V9/xCaW7eXwbUpjaKNGjcsEX2EtaAd1W04EKaW7jORpOg2
	5fHfokyeh1egbqECKsNdXtvEdUYV9/Ib0Cocl71MRwXOKw9AhOiLzTaPveO91Vf4
	VyJ+978Hy6ADgVMzaOpGV4BYZhszozcnU7h+7RvNWopFDnE+/AVFM1zpuipv1I1B
	BNCu4amNUWq6Glpm2yJiw71HXe2GovPXLM6Rk4LfMr7VBneZyuENUOr9YL4sSTZP
	S0bEO7Ue6NtygCBq2RZYKoGj5QAPtWpu6E5I0Zr0f9/UhHsg+TZXfrgSBzF1izPz
	wogjVPkp/wZmRRoIHC1Q==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wd22rhnrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 10:38:40 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LAcd7P030110
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 10:38:39 GMT
Received: from [10.216.62.93] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 02:38:33 -0800
Message-ID: <6035a0d2-f784-c55d-acd5-aa3ffc470246@quicinc.com>
Date: Wed, 21 Feb 2024 16:08:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/5] drivers: mtd: nand: Add qpic_common API file
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <manivannan.sadhasivam@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240215134856.1313239-3-quic_mdalam@quicinc.com>
 <CAA8EJpquDwDg+OrZKeJrTWEtokCF7uyHMyzCFK2etSsDip8_6Q@mail.gmail.com>
 <c574c9ab-0a47-2dc8-9ddd-c08f1b770d7e@quicinc.com>
 <CAA8EJprkwv0QstJTveM+06DbMjgBCEVBRhBb5i2QM6LxmmCQug@mail.gmail.com>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <CAA8EJprkwv0QstJTveM+06DbMjgBCEVBRhBb5i2QM6LxmmCQug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PW6hze-lDCO-9iz0EAnxMZPpRzq_s9t4
X-Proofpoint-GUID: PW6hze-lDCO-9iz0EAnxMZPpRzq_s9t4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=900 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210082



On 2/20/2024 9:37 PM, Dmitry Baryshkov wrote:
> On Tue, 20 Feb 2024 at 17:59, Md Sadre Alam <quic_mdalam@quicinc.com> wrote:
>>
>>
>>
>> On 2/15/2024 8:30 PM, Dmitry Baryshkov wrote:
>>> On Thu, 15 Feb 2024 at 15:53, Md Sadre Alam <quic_mdalam@quicinc.com> wrote:
>>>>
>>>> Add qpic_common.c file which hold all the common
>>>> qpic APIs which will be used by both qpic raw nand
>>>> driver and qpic spi nand driver.
>>>>
>>>> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>>> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>>>> ---
>>>>    drivers/mtd/nand/Makefile            |    1 +
>>>>    drivers/mtd/nand/qpic_common.c       |  786 +++++++++++++++++
>>>>    drivers/mtd/nand/raw/qcom_nandc.c    | 1226 +-------------------------
>>>>    include/linux/mtd/nand-qpic-common.h |  488 ++++++++++
>>>>    4 files changed, 1291 insertions(+), 1210 deletions(-)
>>>>    create mode 100644 drivers/mtd/nand/qpic_common.c
>>>>    create mode 100644 include/linux/mtd/nand-qpic-common.h
>>>>
>>>> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
>>>> index 19e1291ac4d5..131707a41293 100644
>>>> --- a/drivers/mtd/nand/Makefile
>>>> +++ b/drivers/mtd/nand/Makefile
>>>> @@ -12,3 +12,4 @@ nandcore-$(CONFIG_MTD_NAND_ECC) += ecc.o
>>>>    nandcore-$(CONFIG_MTD_NAND_ECC_SW_HAMMING) += ecc-sw-hamming.o
>>>>    nandcore-$(CONFIG_MTD_NAND_ECC_SW_BCH) += ecc-sw-bch.o
>>>>    nandcore-$(CONFIG_MTD_NAND_ECC_MXIC) += ecc-mxic.o
>>>> +obj-y += qpic_common.o
>>>> diff --git a/drivers/mtd/nand/qpic_common.c b/drivers/mtd/nand/qpic_common.c
>>>> new file mode 100644
>>>> index 000000000000..4d74ba888028
>>>> --- /dev/null
>>>> +++ b/drivers/mtd/nand/qpic_common.c
>>>> @@ -0,0 +1,786 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * QPIC Controller common API file.
>>>> + * Copyright (C) 2023  Qualcomm Inc.
>>>> + * Authors:    Md sadre Alam           <quic_mdalam@quicinc.com>
>>>> + *             Sricharan R             <quic_srichara@quicinc.com>
>>>> + *             Varadarajan Narayanan   <quic_varada@quicinc.com>
>>>
>>> This is a bit of an exaggeration. You are moving code, not writing new
>>> code. Please retain the existing copyrights for the moved code.
>> Ok
>>>
>>>> + *
>>>> + */
>>>> +
>>>> +#include <linux/mtd/nand-qpic-common.h>
>>>> +
>>>> +struct qcom_nand_controller *
>>>> +get_qcom_nand_controller(struct nand_chip *chip)
>>>> +{
>>>> +       return container_of(chip->controller, struct qcom_nand_controller,
>>>> +                           controller);
>>>> +}
>>>> +EXPORT_SYMBOL(get_qcom_nand_controller);
>>>
>>> NAK for adding functions to the global export namespace without a
>>> proper driver-specific prefix.
>> Ok, will fix in next patch
>>>
>>> Also, a bunch of the code here seems not so well thought. It was fine
>>> for an internal interface, but it doesn't look so good as a common
>>> wrapper. Please consider defining a sensible common code module
>>> interface instead.
>>
>>    QPIC controller will support both raw NAND as well Serial nand interface.
>>    This common API file was the part of raw NAND driver , since for serial
>>    nand most of the APIs from raw nand driver will be re-used that's why i
>>    have created this common API file, so that QPIC serial nand driver
>>    drivers/spi/spi-qpic-snand.c and QPIC raw NAND driver
>>    drivers/mtd/nand/raw/qcom_nandc.c can used these common APIs.
>>
>>    Could you please suggest how I should handle this in batter way.
> 
> Yes. Start by designing common accessor functions that form a
> sufficient and complete API to access the hardware functionality. A
> set of functions blindly moved from the existing driver usually do not
> make such an API, because usually nobody cares enough about the driver
> internals. It should be something that external user (NAND, SPI, etc)
> can use without looking into the actual implementation of these
> functions.
  Thanks for suggestion. Will make the Common API more generic and
  post in next patch.
> 

