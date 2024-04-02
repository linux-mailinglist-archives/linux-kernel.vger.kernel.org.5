Return-Path: <linux-kernel+bounces-127623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E169894E87
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36511F237DB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D179C5788F;
	Tue,  2 Apr 2024 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hM5vBdEX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69CB5731E;
	Tue,  2 Apr 2024 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712049677; cv=none; b=ocA8csYsvtxWUMyU8EFGWtatZphPE+1K70d0SkKk1acj/zMpve64tuLwP3lPJSXMX9Z35PQ368BDzLOVsXpwMC8A7rIUSpgTF/HcTZYNjJtDTHLCr/wyQ+UrBt9wW/jvn7brPTMDH8TEkZhqJQJcFXkYeJV1oVwDK/Lek4hE0Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712049677; c=relaxed/simple;
	bh=Eqv+J/G8QDaPSz4YHEzz2rEQqjnD/zYLA18kwsleRu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XDIGw9KkurDgkyfhfdNnn1CjNs7QIn7+YVztiGnfsW5hRQNKbL90YAQsYsfdLAXP94KnlHg4BwHV63IV8HNsrWyJOLq9XYBRcgUTXpE5woqun0Um2KeJUtjY4pb5sMZEGce0rbA/KdosLNdDXOnH+BSOVjA+e5Ei1z7/bj62s2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hM5vBdEX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4328MSfU014330;
	Tue, 2 Apr 2024 09:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=pwVN48TC02wisPlvjwOGCqrWo60YyF0/BsQFmG2idY0=; b=hM
	5vBdEX5ISE2GbzpWdDFGBL9sPfuomnuQH8/qqtqiynripjeXvr5yNYLo8A7wr2Ng
	1p8jVVFbC2tSPDhaMktmoSV17YSR+BxtcOgpdHeTOv/GLo2f/0dtN4HoezQoE4hE
	+i3p94RSoBuGV166CTLUtXffC7cnGGwdfivLQj3gvYKxL9ALcq4BlxAywa6UnKo6
	s0s2H+66tuXQgGeHZznV0yteIHoqt6P6g30URmL+/Ve7akgwEJQfBmWLdTRXSmya
	Nco2IiHEKecirUKvIt0OxeW3gGhxBtq0cSoSP7mnqDjikUQ13sq+FY1ugag6gnpX
	UulcClPda1pJdOiQsTmw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x81wdhheq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 09:21:05 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4329L3wn001578
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 09:21:03 GMT
Received: from [10.216.25.199] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 2 Apr 2024
 02:20:59 -0700
Message-ID: <7cd89939-e0d0-c43b-fa2a-224bf60f4166@quicinc.com>
Date: Tue, 2 Apr 2024 14:50:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 2/2] ASoC: qcom: qcm6490: Add machine driver for
 qcm6490
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <broonie@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <lgirdwood@gmail.com>, <tiwai@suse.com>, <quic_rohkumar@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-sound@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20240327113228.1706975-1-quic_mohs@quicinc.com>
 <20240327113228.1706975-3-quic_mohs@quicinc.com>
 <CAA8EJpqh0emOFUPSj8rPaKr2hZRWwOh9NNTco8fyJCtwXe9sSA@mail.gmail.com>
 <92b449da-1569-40f9-d8c9-48949c986853@quicinc.com>
 <CAA8EJprLB6+i4H5tK9LbJYOEH8v9QF78u-+HMmqPqfpvz5J8zw@mail.gmail.com>
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
In-Reply-To: <CAA8EJprLB6+i4H5tK9LbJYOEH8v9QF78u-+HMmqPqfpvz5J8zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 53sTLWqDduGBXBvpBpergwhhBHBrJl1w
X-Proofpoint-GUID: 53sTLWqDduGBXBvpBpergwhhBHBrJl1w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_03,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=750
 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404020065

On 3/30/2024 12:09 AM, Dmitry Baryshkov wrote:
> Hi,
> 
> On Fri, 29 Mar 2024 at 17:20, Mohammad Rafi Shaik <quic_mohs@quicinc.com> wrote:
>>
>>
>> On 3/27/2024 6:39 PM, Dmitry Baryshkov wrote:
>>
>> On Wed, 27 Mar 2024 at 13:34, Mohammad Rafi Shaik <quic_mohs@quicinc.com> wrote:
> 
> Please turn off HTML mail composition and never ever send HTML email
> to OSS mailing lists.
> Now quotation levels are broken...
> 
>>
>> Add machine driver for qcm6490 SoC.
>>
>> This initial supports which includes WSA883x Speakers with onboard DMIC
>> connected to internal LPASS codec via VA macros respectively and also
>> WCD937x based headset.
>>
>> Add compatible for sound card on Qualcomm qcs6490 boards.
>>
>> Granted that qcm6490 is similar to sc7280, is there any reason why you
>> can not use one of the existing sound card drivers? Like sc7280.c or
>> sc8280xp.c?
>>
>> The qcs6490/qcm6490 has additional interfaces like MI2S, which requires additional machine driver modification.
>>
>> Example : Required new DAPM widget change in machine driver for MI2S interface which is specific to qcs6490/qcm6490.
>>
>> So, using new qcm6490 machine driver.
>>
>> Will try to use existing sc8280xp.c machine driver.
> 
> What about sc7280? In the end, qcm6490 is sc7280 with different firmware / spin.
> 
>

The sc7280 is tightly linked with realtek codec. which will only support 
for chrome.

The sc8280xp.c machine driver is more suitable for qcm6490, will use 
same sc8280xp.


