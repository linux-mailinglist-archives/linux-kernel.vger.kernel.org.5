Return-Path: <linux-kernel+bounces-163516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 227528B6C66
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A5E1F23128
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB024652F;
	Tue, 30 Apr 2024 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Wci2KBcs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA5B405F2;
	Tue, 30 Apr 2024 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714464143; cv=none; b=TS/BRL83nWDXZ3misLstPqMCHBMIl5bn3g53Rz2LXiuDLxg4Ctx5FgnMcpXc66xXcVvqBMo9I5tCdIWRH/dAt/seMJcljmrx+g7R5DB1Ps3ktD8rTApiV3CemQcweCwiwv8tPur4r0GcDnEYP+tEb/JpyjLbGR2xfGix+wJmn0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714464143; c=relaxed/simple;
	bh=yVJdK01yhCnUukA30JdDhN5ZSKoRK85R+ezjnS2GijM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lSKnzHzOYFnnCllhcrl8M7Y9GT0WGUkGu2fSjKoQlbxtSZQyyiUxDZ1WThwPDz+xdveFqIxbpvv5N1aZMuzqAOLBSQnIRurJMCTxGHjgULfaX6T+3+ka1tbK/yHSOdC0E9Prcc/l2lCssNX6DfsBDmfRaRhrqjUmHouo/UfiNMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Wci2KBcs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U3tGxi028667;
	Tue, 30 Apr 2024 08:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GbwTd6BSjMG9RMTPFLFiWPip1PAsE7tlTno/hl5oWyc=; b=Wc
	i2KBcsfht+cUMJKoqoB3EdqTZh6AduhAAH+HsCPqs5ajqiGHVRVpTEMkvclbRipM
	x09kwYuCYoH0le70E6aLmknVp5fvTLvFgXtNFPZ7aa4bQrrorhiMQw9KgUCzufqf
	/EJ8beUBFumjECZNGB2kWcGPZnldJjPpLVvoWcK6MT/nFRW5rdE1uqgn247NZ/L1
	/u2qvAjm7wAuttXX1UlLjv+qlDlV0Jo33cRjEnus+jxbxZPVk7mhXxvzdb+h0JJe
	4GzVe105ObdfaMfYAP4Pae6Jke554uusHFVOJniLhL7lroaRMam1HCO3uihVsAAs
	nsXnUdkHSu52Hwz5c95Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtqkr8vc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 08:01:36 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U81Z3I021417
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 08:01:35 GMT
Received: from [10.110.61.50] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 01:01:34 -0700
Message-ID: <9707364c-9743-83e2-2fc6-86c76322a1da@quicinc.com>
Date: Tue, 30 Apr 2024 01:01:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v20 22/41] ASoC: usb: Add PCM format check API for USB
 backend
To: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
	<amadeuszx.slawinski@linux.intel.com>,
        <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
References: <20240425215125.29761-1-quic_wcheng@quicinc.com>
 <20240425215125.29761-23-quic_wcheng@quicinc.com>
 <3d70c19f-bab8-4e50-9551-de406a0e0314@linux.intel.com>
Content-Language: en-US
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <3d70c19f-bab8-4e50-9551-de406a0e0314@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: btr3Xp9rudx4won1D-9fWNtZMOuVnQ-Y
X-Proofpoint-ORIG-GUID: btr3Xp9rudx4won1D-9fWNtZMOuVnQ-Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_04,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=874 malwarescore=0
 phishscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300057

Hi Amadeusz,

On 4/26/2024 6:25 AM, Amadeusz Sławiński wrote:
> On 4/25/2024 11:51 PM, Wesley Cheng wrote:
>> Introduce a helper to check if a particular PCM format is supported by 
>> the
>> USB audio device connected.  If the USB audio device does not have an
>> audio profile which can support the requested format, then notify the USB
>> backend.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
> 
> (...)
> 
>> +/**
>> + * snd_soc_usb_find_format() - Check if audio format is supported
>> + * @card_idx: USB sound chip array index
>> + * @params: PCM parameters
>> + * @direction: capture or playback
>> + *
>> + * Ensure that a requested audio profile from the ASoC side is able 
>> to be
>> + * supported by the USB device.
>> + *
>> + * Return 0 on success, negative on error.
>> + *
>> + */
>> +int snd_soc_usb_find_format(int card_idx, struct snd_pcm_hw_params 
>> *params,
>> +            int direction)
> 
> Perhaps name function similar to its snd_usb equivalent, so 
> snd_soc_usb_find_supported_format?
> 

Will do.

Thanks
Wesley Cheng

