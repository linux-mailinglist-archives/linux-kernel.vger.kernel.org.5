Return-Path: <linux-kernel+bounces-109973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA58885867
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4123A1C217C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DCA59162;
	Thu, 21 Mar 2024 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SE/W/CyZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7923417F7;
	Thu, 21 Mar 2024 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020853; cv=none; b=KHELsrI6trOsJt5HI19uxFkmHANa5cKZucVaOaYvN3FP/r10nVaq1DIBvJxwSd/7FnYhBnDEXMjwzBFogyq4Zeb5fPZWkhPcsFp+69oQEUYrAQTcSUmH06X9Q6Lw4SXo/cvtKMbBxdRIH5yCJV1XIpG6MnILllYwU842SHGw4+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020853; c=relaxed/simple;
	bh=W2/gJ2MKgRnlesgFeDrOa3uQwI+oiLcvFiZTpWgi4aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VcGDZUKVms1Kw+8lQ7PQYF5hcvmuS7S6CbAZIBaq1PVv5qNwIYqiIW9ZyQs1IFDi6z6LBCV+Z1GIpQacwaNtoZ6B67zWHL3yGD7tGvMXJipX/TO1smpR88/rkQQ4eLfBYJdqGCLES/daz/s4loBAqDouNJRc82I5int2S/PuM4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SE/W/CyZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42L6XrNa026123;
	Thu, 21 Mar 2024 11:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=rvpAHaDptSDGHjItmcX8AIeewGwgxzt24c489x1bS8Y=; b=SE
	/W/CyZPrZylMX3TIsP705qgx+VoC9l+fJPnGSgqBUuYHUOsC2s4DScZ4MDM2N4xT
	m4sPvmF/y8dVFBPTBrbTfJPXr3UiwZO7hGbPxp258YWfcmvniGO6bka4tso90Hqo
	QJiz0KEhMy/rsX3cQobAaOhcAEaSP82esmDGrcaV2RFbhKHKGcYWvxiiHcgLt7bT
	XsJZpbYFgHJjdysDIGCguWDjZxnWyiStXx/w8UFR2buj+Sm+EFAGd0cjkexQvP0s
	If7wZizQHpeMGRnGJdaO5wOmaef/Kcf52nE0cZ1LZdIOCoA1JxBbnq8U8qDAQojF
	eICxPgeNoJyK0R2Tc9YA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0fqxgm0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 11:33:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42LBXsYG018083
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 11:33:54 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Mar
 2024 04:33:48 -0700
Message-ID: <37942292-fb99-4d3b-9933-50d338e87661@quicinc.com>
Date: Thu, 21 Mar 2024 17:03:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 RESEND 3/6] clk: qcom: videocc-sm8550: Add SM8650 video
 clock controller
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>
References: <20240321092529.13362-1-quic_jkona@quicinc.com>
 <20240321092529.13362-4-quic_jkona@quicinc.com>
 <CAA8EJpq11ZeYrMqdKWrcs3=cx_Pr7wc1Y87SHMqP6B_9XtusVg@mail.gmail.com>
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <CAA8EJpq11ZeYrMqdKWrcs3=cx_Pr7wc1Y87SHMqP6B_9XtusVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bt3LftOV1EX1LBcHb8MIbxP5q2D-YnDu
X-Proofpoint-GUID: bt3LftOV1EX1LBcHb8MIbxP5q2D-YnDu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210081



On 3/21/2024 3:33 PM, Dmitry Baryshkov wrote:
> On Thu, 21 Mar 2024 at 11:27, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>>
>> Add support to the SM8650 video clock controller by extending
>> the SM8550 video clock controller, which is mostly identical
>> but SM8650 has few additional clocks and minor differences.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> 
> 
>> @@ -411,6 +540,7 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
>>   {
>>          struct regmap *regmap;
>>          int ret;
>> +       u32 offset = 0x8140;
> 
> Nit: this variable seems misnamed. Please rename to something like
> sleep_clk_offset;
> 

Thanks Dmitry for your review.

Yes, will rename this in the next series.

Thanks,
Jagadeesh

>>
>>          ret = devm_pm_runtime_enable(&pdev->dev);
>>          if (ret)
>> @@ -426,12 +556,27 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
>>                  return PTR_ERR(regmap);
>>          }
>>
>> +       if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8650-videocc")) {
>> +               offset = 0x8150;
>> +               video_cc_pll0_config.l = 0x1e;
>> +               video_cc_pll0_config.alpha = 0xa000;
>> +               video_cc_pll1_config.l = 0x2b;
>> +               video_cc_pll1_config.alpha = 0xc000;
>> +               video_cc_mvs0_clk_src.freq_tbl = ftbl_video_cc_mvs0_clk_src_sm8650;
>> +               video_cc_mvs1_clk_src.freq_tbl = ftbl_video_cc_mvs1_clk_src_sm8650;
>> +               video_cc_sm8550_clocks[VIDEO_CC_MVS0_SHIFT_CLK] = &video_cc_mvs0_shift_clk.clkr;
>> +               video_cc_sm8550_clocks[VIDEO_CC_MVS0C_SHIFT_CLK] = &video_cc_mvs0c_shift_clk.clkr;
>> +               video_cc_sm8550_clocks[VIDEO_CC_MVS1_SHIFT_CLK] = &video_cc_mvs1_shift_clk.clkr;
>> +               video_cc_sm8550_clocks[VIDEO_CC_MVS1C_SHIFT_CLK] = &video_cc_mvs1c_shift_clk.clkr;
>> +               video_cc_sm8550_clocks[VIDEO_CC_XO_CLK_SRC] = &video_cc_xo_clk_src.clkr;
>> +       }
>> +
>>          clk_lucid_ole_pll_configure(&video_cc_pll0, regmap, &video_cc_pll0_config);
>>          clk_lucid_ole_pll_configure(&video_cc_pll1, regmap, &video_cc_pll1_config);
>>
>>          /* Keep some clocks always-on */
>>          qcom_branch_set_clk_en(regmap, 0x80f4); /* VIDEO_CC_AHB_CLK */
>> -       qcom_branch_set_clk_en(regmap, 0x8140); /* VIDEO_CC_SLEEP_CLK */
>> +       qcom_branch_set_clk_en(regmap, offset); /* VIDEO_CC_SLEEP_CLK */
>>          qcom_branch_set_clk_en(regmap, 0x8124); /* VIDEO_CC_XO_CLK */
>>
>>          ret = qcom_cc_really_probe(pdev, &video_cc_sm8550_desc, regmap);
>> --
>> 2.43.0
>>
>>
> 
> 

