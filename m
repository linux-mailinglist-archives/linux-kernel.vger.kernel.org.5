Return-Path: <linux-kernel+bounces-122474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A3D88F825
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86FCE1F24AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555E24F8BB;
	Thu, 28 Mar 2024 06:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LbsYaQvh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1441DA23;
	Thu, 28 Mar 2024 06:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711608769; cv=none; b=utq1VMGNXzh4GIydbcp5QAjJwwqyzqV4MyegaQWtPOwH8hGjQ2Z+HyLsX9un6jMA79P4Cw/Ju6mxj9V2jwkS7YAq4JZf+IOT+y+5mjjWIPJ78QMIRe0hZYeu8Au74feYP9Uvp2gcHv/Rt9i3NbHsKOXvpqw+/+fx5dVp6C25kn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711608769; c=relaxed/simple;
	bh=4EAw4hrm5SLQWoL6ok0UmCfpnmz3syQ2181RJA575C0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dTY+rt59US+i+JXOJ2Iz9QT16thk3Y6LUreRSdTXQ3ruI5W4jWsdvFLCZieprOL2pQxtov5FmnZtQ1X4Xi9kWmJ1yhUGtBs6E2yjQj4MobJ4eNnjXhFlaNC+3Dr8x0ac7LBMDf1rDx9q/ddrLSJUhGmUEd+SZnhzqu/us/3oB8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LbsYaQvh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S0M7tb013493;
	Thu, 28 Mar 2024 06:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=N2NmkPTrfmlwNwwNOPuDMTNzfMflldO7CI9GXiOZ+fQ=; b=Lb
	sYaQvhsDeGgmoLjL+rq7c4qOY4TpjOZr3yD9HTQvXJC3tV5zIJQoiVZireK/1l+C
	KomUhrrqFv5uG5Fs7p3NCrCrz9o/3rmt+5lVRyNOOujBCf2xG7IsSfO4P8CGLKGx
	vacBXSGn5hldGUQkvMZ6lCtHAWIg2fhEMaxfe4HmVPe7yg9Gi0KinXGgaG5eIr27
	KMFIcmZmE6FgSqPBQj90ETGNywQCtUq5hTah9j6JXvvU51uTTvrSqS9DDu3zrxZa
	N1oK9L+zME3nexAgKf5kdS8m1O5EWgccL0dh/6qO+HxkWcTS28sqY2TUc8C/wGIu
	66zGt/zg7ibPXejQjaow==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u20j80d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 06:52:41 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S6qduS021399
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 06:52:39 GMT
Received: from [10.253.14.163] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 27 Mar
 2024 23:52:36 -0700
Message-ID: <98c668b6-7595-2c0a-ebe5-2f729d29b618@quicinc.com>
Date: Thu, 28 Mar 2024 14:52:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [RESEND PATCH v6 3/3] input: pm8xxx-vibrator: add new SPMI
 vibrator support
Content-Language: en-US
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        <linux-input@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, <quic_kamalw@quicinc.com>,
        <jestar@qti.qualcomm.com>, Luca Weiss
	<luca.weiss@fairphone.com>
References: <20230922083801.3056724-1-quic_fenglinw@quicinc.com>
 <20230922083801.3056724-4-quic_fenglinw@quicinc.com>
 <CAA8EJpoW8DJOTVHBu9_+BQs5DtxyJu3xrCfDNyYHn2MeHZHV4w@mail.gmail.com>
 <12887370-0ada-359b-8a4f-18a28495c69a@quicinc.com>
 <ZRhKAWYBLcBZHc73@google.com>
From: Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <ZRhKAWYBLcBZHc73@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ma9H1W9QcbP1vqR2emR-ZoEwdYE7ALfs
X-Proofpoint-GUID: ma9H1W9QcbP1vqR2emR-ZoEwdYE7ALfs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_05,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403280042



On 2023/10/1 0:17, Dmitry Torokhov wrote:
> On Mon, Sep 25, 2023 at 10:54:45AM +0800, Fenglin Wu wrote:
>>
>>
>> On 9/24/2023 3:07 AM, Dmitry Baryshkov wrote:
>>>> +
>>>> +       switch (vib->data->hw_type) {
>>>> +       case SSBI_VIB:
>>>>                   mask = SSBI_VIB_DRV_LEVEL_MASK;
>>>>                   shift = SSBI_VIB_DRV_SHIFT;
>>>> +               break;
>>>> +       case SPMI_VIB:
>>>> +               mask = SPMI_VIB_DRV_LEVEL_MASK;
>>>> +               shift = SPMI_VIB_DRV_SHIFT;
>>>> +               break;
>>>> +       case SPMI_VIB_GEN2:
>>>> +               mask = SPMI_VIB_GEN2_DRV_MASK;
>>>> +               shift = SPMI_VIB_GEN2_DRV_SHIFT;
>>>> +               break;
>>>> +       default:
>>>> +               return -EINVAL;
>>> Could you please move the switch to the previous patch? Then it would
>>> be more obvious that you are just adding the SPMI_VIB_GEN2 here.
>>>
>>> Other than that LGTM.
>>
>> Sure, I can move the switch to the previous refactoring patch.
> 
> Actually, the idea of having a const "reg" or "chip", etc. structure is
> to avoid this kind of runtime checks based on hardware type and instead
> use common computation. I believe you need to move mask and shift into
> the chip-specific structure and avoid defining hw_type.
> 
> Thanks.

Hi Dmitry,

The v7 changes have been pending for a while, I am not sure if you are 
still insist on this. As I explained, I actually did it this way in v2 
and it got updated to this by following other comments.

Can you respond and tell me if you prefer changes similar to v2? I can 
update and push v8 by following your suggestion.

v7: 
https://lore.kernel.org/linux-arm-msm/20231108-pm8xxx-vibrator-v7-0-632c731d25a8@quicinc.com/

v2: 
https://lore.kernel.org/linux-arm-msm/20230718062639.2339589-3-quic_fenglinw@quicinc.com/

Thanks
> 

