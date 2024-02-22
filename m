Return-Path: <linux-kernel+bounces-77148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2448601AD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB9E1C22664
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB53143C59;
	Thu, 22 Feb 2024 18:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SbhntPsG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1C1125CE;
	Thu, 22 Feb 2024 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626762; cv=none; b=Lwj0vHwHpfBIdvF7JWEMksHidHrUstBqVeTvdaUOgqLO3S69L1fc4wxk6kaTnvUJiwgT00PZUIC3mgm8IzvR1VwNGV2glvE5u8goW+ZUqs7VELsprf0XkJQir+dm3NUxzkruvAnx6y4Gw8T8QnNckIgFebx9klBudqlPUTAnW7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626762; c=relaxed/simple;
	bh=Dq/WJWzvf8wQHOTJLFRXt3BmVpE2zcnhDDsvnsZo7Q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kMuP35tu6biXrIPJFX70PUHfZBkmxPEtkTQsZ+HP6g86h71cdcaOjo2VvEcD8mXAZjVWhPX0pY7Kf194dqNAtOn75nNWvY/1+nGSV5mpOM2WGD9icEKC0aeYEtKvtuc5oG3L0j1zfZygxsh3NYaeFu7GudhExOVxPH0bKgtSANc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SbhntPsG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MHXd4w011379;
	Thu, 22 Feb 2024 18:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=uBZVc2KAKMD3VrRODtzocPOslJ8eEF/cruNuWqPmlKI=; b=Sb
	hntPsGuukpcjKB4zPplj4GOzJxfsYhuBytggceShdDIlmcH+JehD+Wz2F1sBHE6W
	HkP4GuOrWmP/YSw0gLjTmlXhnaPAmbSS53WQu/Kexo4YcGWZx8yO8iG77hbZ6WVz
	RopOwTy6MDoZZOEi9CCKFjyc8uBDKOvQlF4b1XlhlmZNLcn3zlWVz1rVeoI6ZdKy
	Nus270Dkg6U/9FrRXVnHREQJ5yWXr54tpegIELdhS2V5mj4MtvtVMJ8mA6KER+ny
	nqtroOgX7O9Qt0A9HTSKs7M9jqI+1oQaik9zwEXvL8BPNqls9L8dBQ6ayngwz+DW
	+yw4RuTJpuMnPpB8SvDQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weasbr9eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 18:32:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MIWOTJ011497
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 18:32:24 GMT
Received: from [10.71.109.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 22 Feb
 2024 10:32:23 -0800
Message-ID: <4de8626d-7dc6-42af-85ea-60e6670aef72@quicinc.com>
Date: Thu, 22 Feb 2024 10:32:06 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/9] arm64: dts: qcom: sc7280: Enable MDP turbo mode
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>
CC: Bjorn Andersson <quic_bjorande@quicinc.com>,
        Douglas Anderson
	<dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul
	<sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        "David
 Airlie" <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <cros-qcom-dts-watchers@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com>
 <20240221-rb3gen2-dp-connector-v1-3-dc0964ef7d96@quicinc.com>
 <CAA8EJpo=9vhM+5YzaFxUoYRuEWQyrMS8wLNPSF3K=bN5JwWyDw@mail.gmail.com>
 <8313a7c3-3ace-4dee-ad27-8f51a06cd58c@linaro.org>
 <CAA8EJpqFj5nf8d_=Uoup7qg+nQrxqQU-DHbL3uSP138m9AcXLw@mail.gmail.com>
 <8fcb5816-2d59-4e27-ba68-8e0ed6e7d839@linaro.org>
 <CAA8EJporaUuddHHqpyYHiYSu=toHmrDxSHf9msZUJoym4Nz72g@mail.gmail.com>
Content-Language: en-US
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAA8EJporaUuddHHqpyYHiYSu=toHmrDxSHf9msZUJoym4Nz72g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: g1j4Hzm46QuFIDBMWdiTeBtPETXWT6ay
X-Proofpoint-GUID: g1j4Hzm46QuFIDBMWdiTeBtPETXWT6ay
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_14,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220144



On 2/22/2024 1:46 AM, Dmitry Baryshkov wrote:
> On Thu, 22 Feb 2024 at 11:28, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 2/22/24 10:04, Dmitry Baryshkov wrote:
>>> On Thu, 22 Feb 2024 at 10:56, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>>
>>>>
>>>>
>>>> On 2/22/24 00:41, Dmitry Baryshkov wrote:
>>>>> On Thu, 22 Feb 2024 at 01:19, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>>>>>>
>>>>>> The max frequency listed in the DPU opp-table is 506MHz, this is not
>>>>>> sufficient to drive a 4k@60 display, resulting in constant underrun.
>>>>>>
>>>>>> Add the missing MDP_CLK turbo frequency of 608MHz to the opp-table to
>>>>>> fix this.
>>>>>
>>>>> I think we might want to keep this disabled for ChromeOS devices. Doug?
>>>>
>>>> ChromeOS devices don't get a special SoC
>>>
>>> But they have the sc7280-chrome-common.dtsi, which might contain a
>>> corresponding /delete-node/ .
>>
>> What does that change? The clock rates are bound to the
>> SoC and the effective values are limited by link-frequencies
>> or the panel driver.
> 
> Preventing the DPU from overheating? Or spending too much power?
> 

Running DPU clock in turbo is a requirement to support 4k@60 otherwise 
the pixel rate that high cannot be supported.

sc7280 chrome devices already limit to HBR2

https://lore.kernel.org/all/20230329233416.27152-1-quic_abhinavk@quicinc.com/

So the DPU will not vote more than nominal.

And like others wrote, limiting SOC frequencies is not the way and we 
should filter out required frequencies using link-frequencies.

Hence fwiw, I am fine with this change.


Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>


