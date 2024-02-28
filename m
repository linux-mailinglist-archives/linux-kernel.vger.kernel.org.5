Return-Path: <linux-kernel+bounces-84299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D5D86A4B7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01281C2479E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6435E185E;
	Wed, 28 Feb 2024 01:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PKRFbXIv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B5CEBB;
	Wed, 28 Feb 2024 01:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709082287; cv=none; b=COldIIrKA3doyL6H7VW3cvKOeM2GDzgmCJZTsk0AB87Jvgbih1leevw1xGJ+9aflxG5acQATZrOYxPo+unReBFZ6n+bYJhFK1dcGipc9FzKp4oJa6rUcUfptMkGPFwQd5Np4pZYdr/opOXpyFPW9LfOkaYakrgkT66ej62hLeHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709082287; c=relaxed/simple;
	bh=y4EbocHBjzb8YLN19w32Y+oyYTU0WC/XsB9nHtwhtxc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=DPLMFVUZ8NOA8N6+XwV6kwEjhhuO+S8L7EPMicthJhj+BYxSSbQ7VqvAOP68qfsmfW3snTg+yaESwcKn7kYAE2jc+7tMAbofjQgBkiPIDXvRm7Oh2/pO9atB0M0yw/WzAsAbmMaLjqCfh89LASdbGOkviwrUNTZc7lH1mVfmJuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PKRFbXIv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S0ZP7L001645;
	Wed, 28 Feb 2024 01:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:subject:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=iDHpj8RtdXNSzJUy/ZXF41IwodzwjQrHJQGPyTTtckQ=; b=PK
	RFbXIvGLL9r/vlRawzMAjUrBTKU1w1UW+U2zhUY6H4irxwPnUr79M4DlI+yfsEkz
	sjyYtpiVmPVuHQ+p+jUoE5mGyJD84GpCigNHVZRwz7i9AJ4b/Myqw+6R9IBIudfS
	9D0+uYoP2i2Rl5GDlrlbF7Ek7rkHiSuXzfpoIC/LRSEbdKUllj+s127KRc8INxlU
	9Oj6fTpMJtGziaNMrWR+8dw7PWS1bskSJBLFyfJ1QYDI8bUwwpt5aYB6tHb43NVO
	w7Se8mfyAXRwMTdGIIsIl5ofRdllWNN+XO2tk9iOtR2wAz0YDRBfbZG21tkv4xuM
	HnmnWl/1YcpLtmoWADKg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh8aujpjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 01:04:42 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41S14fxh019737
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 01:04:41 GMT
Received: from [10.71.111.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 17:04:38 -0800
Message-ID: <68a81c2e-8398-441f-b33d-374c37f39e06@quicinc.com>
Date: Tue, 27 Feb 2024 17:04:34 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: arm: msm: Add llcc Broadcast_AND
 register
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
Content-Language: en-US
In-Reply-To: <26feb928-55e8-4f6e-8727-44ef8e045b4c@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XAEgvSUmTp9j_2reBsQ22_pEtBUZcIkf
X-Proofpoint-GUID: XAEgvSUmTp9j_2reBsQ22_pEtBUZcIkf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=251 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280006

On 2/27/2024 7:47 AM, Krzysztof Kozlowski wrote:
> On 23/02/2024 00:07, Unnathi Chalicheemala wrote:
>> The LLCC block in SM8450, SM8550 and SM8650 have a new register
>> space for Broadcast_AND region. This is used to check that all
>> channels have bit set to "1", mainly in SCID activation/deactivation.
>>
>> Previously we were mapping only the Broadcast_OR region assuming
>> there was only one broadcast register region. Now we also map
>> Broadcast_AND region.
>>
>> Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
> 
> Why did you ignore the tags? Qualcomm upstreaming guide covers this
> case, so please read it before sending patches.
> 

I was asked to remove the Reviewed-by tag as the previous version of the
patch gave errors on running 'make DT_CHECKER_FLAGS=-m dt_binding_check',
that's why I dropped it.
It was sometime ago, https://lore.kernel.org/all/d78b4bce-7bcd-4ab0-a76b-135cee3ec9b0@linaro.org/

> Best regards,
> Krzysztof
> 

