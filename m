Return-Path: <linux-kernel+bounces-38368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB1C83BE68
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BB58B22F42
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C581CA81;
	Thu, 25 Jan 2024 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HDuo/eue"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF771BDCE;
	Thu, 25 Jan 2024 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177608; cv=none; b=LWAYuuEyy8suLQhO3MgY4oxIVfcLtALZTi1JDI2UZ3777vb1ldqsqkauORupu8LZrJxN0G0VZIKWUXn++1hhm5Q7Wa5/NVklO74JaPgoqVEYoiD7g1Pu7uvNL1AmHagGjla3o4pFE/LiKbT6Yyn8qUBG8bUiAjcruZLO+C4kxp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177608; c=relaxed/simple;
	bh=19wsUBvWr9AyJ8rEvzCJlZcAgDpfrwMvGtsNo6lA6Nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=byZdVPL+70z9sM5wl2/NF45nxQyGW+8EAgwxQO6X1WeqUXCPTAeNyDzlpcry6PPj3miVn7jvnutt+dRoNMPZ0EVSwMxijIsVLWIkWmP+RLiwNtIUA3AgxyO42+AOmMbGar9UGdJmH9I5o0JjvCXV7D+9ZQWduKd5OGblt/6huM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HDuo/eue; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P31JFo006530;
	Thu, 25 Jan 2024 10:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/Lmt658XHei/YTYu+MA0LY9n7IDvawBEOz497OhPBCk=; b=HD
	uo/eueXSHH/+6KL4HzvFfvIthBKNZus1t3Uj5Hlafpd4Ubmo7FmoDnXyZpyQXKka
	TUJGu9gIXXyVNVlm4dLpnZUdrnRWs9X69U+nO1kt/tSMG8AxfO+kzQcTHaEHKuRS
	4dHbUZLb4FIjpnFpH4qnKjXIUGhst26lCnY6j60gqZn2r6F/rs5vlyZDgftSF6Kj
	+obAQT/17/cY6bDuxqQ76ZcDuWDPDhvIvnL/w6HR30K8FwCKcacJLM6/vP44Qcpw
	VMW/sF/gm+3k5ijvx8VkMQ7mdF0LTejLVzeSQZy+hIuBGxaj7mXJm4RIswHJQH/b
	Ms7QQW5/xsRXkPJoEE3g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vufc80va1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 10:13:16 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PADFmK002157
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 10:13:15 GMT
Received: from [10.239.34.220] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 02:13:12 -0800
Message-ID: <b214fc0c-8beb-4e5e-b8d8-e4c609106448@quicinc.com>
Date: Thu, 25 Jan 2024 18:13:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] phy: qcom: qmp-pcie: Update PCIe PHY settings for
 SM8550
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <neil.armstrong@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>
References: <1703742157-69840-1-git-send-email-quic_qianyu@quicinc.com>
 <e6b8befb-82e8-4803-929c-32e86d1e825a@linaro.org>
 <0a3f486d-0135-454e-9da6-b888e516a39e@quicinc.com>
 <aa445a92-e640-4f1d-969c-20cafefcf44e@linaro.org>
 <aa2d61d5-ada1-485a-aed8-7cd360adf744@linaro.org>
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <aa2d61d5-ada1-485a-aed8-7cd360adf744@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: y9RrHQIh0438GnlteZ4yndHiNo-vDIH0
X-Proofpoint-GUID: y9RrHQIh0438GnlteZ4yndHiNo-vDIH0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_05,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=642 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250069


On 1/25/2024 5:51 PM, Konrad Dybcio wrote:
>
>
> On 1/25/24 08:53, neil.armstrong@linaro.org wrote:
>> On 25/01/2024 03:59, Qiang Yu wrote:
>>>
>>> On 1/24/2024 4:58 PM, neil.armstrong@linaro.org wrote:
>>>> On 28/12/2023 06:42, Qiang Yu wrote:
>>>>> Align PCIe0/PCIe1 PHY settings with SM8550 latest PCIe PHY Hardware
>>>>> Programming Guide.
>>>>>
>>>>> Can Guo (1):
>>>>>    phy: qcom: qmp-pcie: Update PCIe1 PHY settings for SM8550
>>>>>
>>>>> Qiang Yu (1):
>>>>>    phy: qcom: qmp-pcie: Update PCIe0 PHY settings for SM8550
>>>>>
>>>>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c             | 20 
>>>>> ++++++++++++++------
>>>>>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h      | 2 ++
>>>>>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h   | 2 ++
>>>>>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h        | 1 +
>>>>>   .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h   | 2 ++
>>>>>   5 files changed, 21 insertions(+), 6 deletions(-)
>>>>>
>>>>
>>>> - On SM8550-HDK:
>>>> # lspci
>>>> 0000:00:00.0 PCI bridge: Qualcomm Device 0113
>>>> 0000:01:00.0 Network controller: Qualcomm Device 1107 (rev 01)
>>>> 0001:00:00.0 PCI bridge: Qualcomm Device 0113
>>>> 0001:01:00.0 Non-Volatile memory controller: Phison Electronics 
>>>> Corporation E12 NVMe Controller (rev 01)
>>>>
>>>>
>>>> # lspci -nvv
>>>> 0000:00:00.0 0604: 17cb:0113 (prog-if 00 [Normal decode])
>>>>         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L0s L1, 
>>>> Exit Latency L0s <4us, L1 <8us
>>>>         LnkSta:    Speed 5GT/s, Width x2
>>>> 0001:00:00.0 0604: 17cb:0113 (prog-if 00 [Normal decode])
>>>>         LnkCap:    Port #0, Speed 16GT/s, Width x2, ASPM L0s L1, 
>>>> Exit Latency L0s <4us, L1 <8us
>>>>         LnkSta:    Speed 8GT/s, Width x2
>>>>
>>>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-HDK
>>>>
>>>> - On SM8550-QRD:
>>>> # lspci
>>>> 00:00.0 PCI bridge: Qualcomm Device 0113
>>>> 01:00.0 Network controller: Qualcomm Device 1107 (rev 01)
>>>>
>>>> # lspci -nvv
>>>>         LnkCap:    Port #0, Speed 8GT/s, Width x2, ASPM L0s L1, 
>>>> Exit Latency L0s <4us, L1 <8us
>>>>         LnkSta:    Speed 5GT/s, Width x2
>>>>
>>>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
>>>>
>>>> Thanks,
>>>> Neil
>>>
>>> Hi Neil,
>>>
>>> Thanks for testing this patch. I verified on aim300, did not see 
>>> speed downgrade. Let me have a try on HDK8550.
>>
>> I haven't seen speed downgrade either on the HDK8550
>
> I'm guessing the 5 GT/s link goes to the Wi-Fi chip, which may
> be negotiating a lower PCIe gen in order to save power.
>
> Konrad

Hi Konrad,Neil. OK, I see. I misunderstood. Thanks.


