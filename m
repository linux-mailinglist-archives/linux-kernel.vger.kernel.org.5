Return-Path: <linux-kernel+bounces-122710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8702E88FBE9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F421F2B1F6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3627BAFF;
	Thu, 28 Mar 2024 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m+A08gF5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A947B3C1;
	Thu, 28 Mar 2024 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619010; cv=none; b=rgqYDdmiFXFJNtp7g4hA7y8tsUvR0gyMUau2pXdp+7AsemS3P+x3mEmV39zWa/tDMmZCSwYBN+wEkYLafe9Foe9AzU8SkBVoe8OToXymnbupc3JeCU/4wbvmxuYSC5VJHKOFwMo67sHuqBl/peGxXPjohtzkZcNT5hCNPGZrn8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619010; c=relaxed/simple;
	bh=DsOYXRT/v11AAbXEmr9oFC35rGzLxKHOc/GmW81UJXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JQdU2xxskidrCUQzqt40jUl7IXfLUGMrElPyKCshC535A3c1yNQmn+f1bOCx/imM5+qhT8AIySLnoGPnhWyw62r8/RUn9pIsb/YV7N2mK1sa9t5C41X6suKpbz/qm3NmtuRIqsztOp9b/yXiZ8GX6b3Ts2J/tnD/4z7gjzDYJ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m+A08gF5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S9f3aF002634;
	Thu, 28 Mar 2024 09:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=4ACx3BzRLnkSLELQdhTON0qmLJABnyra3fg9okQ/1v8=; b=m+
	A08gF5zUjjvRo+CvPdSeb96NwYWdf+2A+IFSWPy693+ZLWVZZaqfA3PlRoetgqyW
	PansN4cfY1n+MRmoJI4uEjXgF1rOz1R7bX6r99LR3BIBOFaGfnr/YOD7gOkZJbvu
	HPuTNmYlObgXNwL4gdG42QQFSMk7mJjWSMRVe8lLei6ZNPAvmlcfT8VwNboFKK3H
	QQRMQCwUAuhWuDS9zJBjx16dCf2YEYNb7o53B+F4deRD6Kjd81RS423yoXQcyZBZ
	/kSQcyJmPNpLjQLtRo4axBtZvc5LHc7Lnd2cC9JvcbFPS3J47SobBT/dWDPcgt6s
	byNvyT5mFBvZlpPOEaRQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x53nxgnah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 09:42:56 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S9gtF1008864
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 09:42:55 GMT
Received: from [10.218.19.46] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Mar
 2024 02:42:49 -0700
Message-ID: <ee2db6f0-7fab-9a45-27ba-bf6e58bcf3b1@quicinc.com>
Date: Thu, 28 Mar 2024 15:12:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 4/5] clk: qcom: Add camera clock controller driver for
 SM8150
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Michael
 Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Abhishek Sahu <absahu@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Taniya
 Das" <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20240229-camcc-support-sm8150-v1-0-8c28c6c87990@quicinc.com>
 <20240229-camcc-support-sm8150-v1-4-8c28c6c87990@quicinc.com>
 <18567989-fb60-49ae-92e6-94e1bc2fa1c7@linaro.org>
 <83fd1995-a06e-b76a-d91b-de1c1a6ab0ea@quicinc.com>
 <4817a5b0-5407-4437-b94a-fc8a1bfcd25d@linaro.org>
 <e2627a99-307f-1e10-abfd-ce688cc2ec03@quicinc.com>
 <CAA8EJpogCOQ4W26hkBm6v_yemZ2F30z2TsO5vLKLUqRKkfYxvg@mail.gmail.com>
From: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
In-Reply-To: <CAA8EJpogCOQ4W26hkBm6v_yemZ2F30z2TsO5vLKLUqRKkfYxvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pbvZ-_yj-kL7_jxmIZ3bXC6Wc11X3dFt
X-Proofpoint-ORIG-GUID: pbvZ-_yj-kL7_jxmIZ3bXC6Wc11X3dFt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_09,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280064


On 3/8/2024 5:24 PM, Dmitry Baryshkov wrote:
> On Fri, 8 Mar 2024 at 12:47, Satya Priya Kakitapalli (Temp)
> <quic_skakitap@quicinc.com> wrote:
>>
>> On 3/6/2024 7:25 PM, Bryan O'Donoghue wrote:
>>> On 06/03/2024 08:30, Satya Priya Kakitapalli (Temp) wrote:
>>>>> Anyway I suspect the right thing to do is to define a
>>>>> titan_top_gdsc_clk with shared ops to "park" the GDSC clock to 19.2
>>>>> MHz instead of turning it off.
>>>>>
>>>>> You can get rid of the hard-coded always-on and indeed represent the
>>>>> clock in /sysfs - which is preferable IMO to just whacking registers
>>>>> to keep clocks always-on in probe anyway.
>>>>>
>>>>> Please try to define the titan_top_gdsc_clk as a shared_ops clock
>>>>> instead of hard coding to always on.
>>>>>
>>>> Defining the gdsc clk allows consumers to control it, we do not want
>>>> this clock to be disabled/controlled from consumers. Hence it is
>>>> better to not model this clock and just keep it always on from probe.
>>> Not if you mark it critical
>>>
>> Marking the clock as critical keeps the associated power domain
>> always-on which impacts power. For this reason we are not using
>> CLK_IS_CRITICAL and instead making them always on from probe.
> Please consider using pm_clk instead. This is a cleaner solution
> compared to keeping the clocks always on.


In this case i think we cannot use pm_clk because, the clock that we are 
trying to keep always on here belongs to same camcc and it is not 
possible to create a PM dependency with the same dev that is camcc itself.


>>> static struct clk_branch cam_cc_gdsc_clk = {
>>>          .halt_reg = 0xc1e4,
>>>          .halt_check = BRANCH_HALT,
>>>          .clkr = {
>>>                  .enable_reg = 0xc1e4,
>>>                  .enable_mask = BIT(0),
>>>                  .hw.init = &(struct clk_init_data){
>>>                          .name = "cam_cc_gdsc_clk",
>>>                          .parent_hws = (const struct clk_hw*[]){
>>>                                  &cam_cc_xo_clk_src.clkr.hw
>>>                          },
>>>                          .num_parents = 1,
>>>                          .flags = CLK_IS_CRITICAL | CLK_SET_RATE_PARENT,
>>>                          .ops = &clk_branch2_ops,
>>>                  },
>>>          },
>>> };
>>>
>>> and then add this to your camss clocks
>>>
>>> <&clock_camcc CAM_CC_GDSC_CLK>;
>>>
>>> The practice we have of just whacking clocks always-on in the probe()
>>> of the clock driver feels lazy to me, leaving the broken cleanups we
>>> have aside.
>>>
>>> As a user of the system I'd rather see correct/complete data in
>>> /sys/kernel/debug/clk/clk_summary
>>>
>>> Anyway I'm fine with setting the clock always on, I can always send
>>> out a series to address this bug-bear myself.
>>>
>>> So yeah just fix the cleanup and then please feel free to add my
>>>
>>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>

