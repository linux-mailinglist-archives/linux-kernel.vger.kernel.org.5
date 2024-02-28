Return-Path: <linux-kernel+bounces-85473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0568586B680
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335DA1C208DB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFEF15E5BB;
	Wed, 28 Feb 2024 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d8Mo8pbh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5817422F1E;
	Wed, 28 Feb 2024 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142908; cv=none; b=lESpJkEMnM+GOM3cpnqarumg5RpAcYervG1KrRzLH6hXLbgYFJV+GCgZkntEvwtPdNsiaepBRXPwZ+e07wv4J4hij1lyEayhwrXRODMJXzlM4Rtzd6KrYPSgDXtzvAo8o9LvTjkTl7Wug/O96z5ts9ZuckqO74vnIGr+eh5ZQMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142908; c=relaxed/simple;
	bh=D2mdh06x71kvdd/IuVGC06Jqb09qp6TGuvYg0KhqyCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rJ+U/1Pu0UnAdWq9B9U+0Fc/F45LbcKgaRnwvqSIVCgCHdZYIifZoIiDeqT9tBGPmyxQpSHovOCEFDsqMWAw9QYpTZ8ZZE8CGsKkAPbRcPDzBGOJW0ZedXm5SKCJrDzyK/DGP5+y1GCktuMMNaorhiDUu1GhskvdUEFUJ54sGDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d8Mo8pbh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41SBeNZi028064;
	Wed, 28 Feb 2024 17:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=KZKU8VPZmtWhrDwvgSSiI+7GXe3XJ3zqdVi0P+KcTb4=; b=d8
	Mo8pbh4MKHJom36oprs1uW9tc0IfOk59Y7JnxaiOp6bQ6s0SGlzTYXwdZ87WNVqn
	BiJ82Jng06wPdFQjRK5Gw6oNDdBRozwMr//xq0bX6HGG7dKIwQYtEwh05fqQ+1Mu
	q1PsVIupmudsSj4D6xdSHa1xnpPZehNKWxcclW4nl9hzWxD3D9WtOqeliKbucqGt
	7hv8iz+ISvhr/UruoRr7IxM4fobPNc298nBDtKya+n7L6LQqbUH2EzY/xht045Pm
	4omq3E8W9EU8m/EhK5GR3um6e4mYm1yRJw1KSHouLcU+VZRfcmZwgIifhGLBumJr
	NoeEW+ImAy4KIMW0Ks0w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wj458h3r0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 17:55:01 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SHt0O0008005
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 17:55:00 GMT
Received: from [10.71.111.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 09:54:57 -0800
Message-ID: <0a49c117-90d7-472d-987a-f26f099b6198@quicinc.com>
Date: Wed, 28 Feb 2024 09:54:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dt-bindings: arm: msm: Add llcc Broadcast_AND
 register
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <cover.1708551850.git.quic_uchalich@quicinc.com>
 <93143410af20807c8451539db7fca7cddf31e7b4.1708551850.git.quic_uchalich@quicinc.com>
 <26feb928-55e8-4f6e-8727-44ef8e045b4c@linaro.org>
 <68a81c2e-8398-441f-b33d-374c37f39e06@quicinc.com>
 <b9ed4403-bf3a-4ff4-a92b-22badb845527@linaro.org>
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
In-Reply-To: <b9ed4403-bf3a-4ff4-a92b-22badb845527@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kHZ-QDpbR6s8qCT0Bt9ku5yMdV8xsPlj
X-Proofpoint-ORIG-GUID: kHZ-QDpbR6s8qCT0Bt9ku5yMdV8xsPlj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 phishscore=0 mlxlogscore=374 mlxscore=0 spamscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280141

On 2/27/2024 11:14 PM, Krzysztof Kozlowski wrote:
> On 28/02/2024 02:04, Unnathi Chalicheemala wrote:
>> On 2/27/2024 7:47 AM, Krzysztof Kozlowski wrote:
>>> On 23/02/2024 00:07, Unnathi Chalicheemala wrote:
>>>> The LLCC block in SM8450, SM8550 and SM8650 have a new register
>>>> space for Broadcast_AND region. This is used to check that all
>>>> channels have bit set to "1", mainly in SCID activation/deactivation.
>>>>
>>>> Previously we were mapping only the Broadcast_OR region assuming
>>>> there was only one broadcast register region. Now we also map
>>>> Broadcast_AND region.
>>>>
>>>> Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
>>>
>>> Why did you ignore the tags? Qualcomm upstreaming guide covers this
>>> case, so please read it before sending patches.
>>>
>>
>> I was asked to remove the Reviewed-by tag as the previous version of the
>> patch gave errors on running 'make DT_CHECKER_FLAGS=-m dt_binding_check',
>> that's why I dropped it.
>> It was sometime ago, https://lore.kernel.org/all/d78b4bce-7bcd-4ab0-a76b-135cee3ec9b0@linaro.org/
> 
> And where is it explained/mentioned? Every tag drop should be documented.
> 

I understand, thanks for pointing out. I will record such tag drops in the change log.

> Best regards,
> Krzysztof
> 

