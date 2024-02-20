Return-Path: <linux-kernel+bounces-72675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EE285B70F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68CE11C24122
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECEC5F49B;
	Tue, 20 Feb 2024 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DXdJVTNd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7D7482D1;
	Tue, 20 Feb 2024 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420650; cv=none; b=Lh8qKkTJiKsrCjv1QPGKg65y6O7KSVAm7r2Z2K+Om/vo1I78KQzBml+TAyjNNBucIjmAsCOwpyFhEDzeJn5/FQCLsqtdtq9BUmp2Ocv9SFZQTtOhz9Ez7XSFec2IBHOleR4UWkFwWZWBM3TtuMO2SGoNbavptDsJjLcxpdglnkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420650; c=relaxed/simple;
	bh=OpVDXGdwnO7ThSle8DqmEJO/1F2fU3O04+8aMmj69JA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S0TGDmSpkSDJqrxoq5B1TW3KP8svh/e9HnNeJQHA9PlKJULOoWlZo/1JkKk0irz5Ze7UYDOjgu1rWTEp88Jl0tPDTXepFMoCB5mWtzjb+rEgk6zu9nvPxKIyWwYJT1CVdHcnAj+iSh5eeYZybMeVExMKu7qQuz6JgVUyjaNs064=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DXdJVTNd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41K6xCqF025678;
	Tue, 20 Feb 2024 09:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=u/nDscEgr3PQKZPl5jkaOnMAm17XyF+XZVEyKYKfXqk=; b=DX
	dJVTNd2heTBF3BKFhAZUFss0VkdE8QxdKKAUgavtY4dUzzl0mhxpymfpM4kR7XwL
	lm2d4ZLMLWP9NCJfaSYLjYtDSPuOYMEsv7XR5D2AzgTIR4sxmuOVCg/NcE/KD7u9
	2OnH5lCSpzRH69q6Iti9/NO6sofpzXVuC9YB7WTQcwPjriuxOVkP+0oUIbbKlXdt
	YSmnliwggqWp+MALp4gS/GAXJ3BPW4MTKo2cYdPhwl2XdyY3SDDNa6pT5MJAeGai
	gWqrTvrsJFsLQ46n8JIcHDbf2MPuVJ0q/xiKQl/TKECaJgTA8zYwD9ju30IJnAXZ
	aHtLGOJZjtuyAUyJ2kIw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wcn15rghy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 09:17:25 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41K9H5XT017572
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 09:17:05 GMT
Received: from [10.233.21.53] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 01:16:59 -0800
Message-ID: <9685991e-6577-4f96-a17f-b0a65d8d1260@quicinc.com>
Date: Tue, 20 Feb 2024 17:16:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/6] arm64: dts: qcom: add base AIM500 dtsi
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <kernel@quicinc.com>, Tingwei Zhang <quic_tingweiz@quicinc.com>
References: <20240205115721.1195336-1-quic_jingyw@quicinc.com>
 <20240205115721.1195336-6-quic_jingyw@quicinc.com>
 <CAA8EJpr7tHXZHcH1Sbcy0-MCZfMxKBjaPXGdpg3cqyyFjTZOeA@mail.gmail.com>
From: Jingyi Wang <quic_jingyw@quicinc.com>
In-Reply-To: <CAA8EJpr7tHXZHcH1Sbcy0-MCZfMxKBjaPXGdpg3cqyyFjTZOeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: K1UCLmE-9T9o54i-Nk4aBbabbtm7ZamE
X-Proofpoint-GUID: K1UCLmE-9T9o54i-Nk4aBbabbtm7ZamE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200066

Hi Dmitry,

On 2/5/2024 10:23 PM, Dmitry Baryshkov wrote:
> On Mon, 5 Feb 2024 at 14:00, Jingyi Wang <quic_jingyw@quicinc.com> wrote:
>>
>> Introduce aim500 board dtsi.
> 
> So, is it a board or a module?
> 
aim500 is a module, will fix the descrption.

>>
>> AIM500 Series is a highly optimized family of modules designed to
>> support AIoT and Generative AI applications based on sm8650p with
>> PMIC and bluetooth functions etc.
>>
>> Co-developed-by: Tingwei Zhang <quic_tingweiz@quicinc.com>
>> Signed-off-by: Tingwei Zhang <quic_tingweiz@quicinc.com>
>> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi | 409 +++++++++++++++++++
>>  1 file changed, 409 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi b/arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi
>> new file mode 100644
>> index 000000000000..cb857da8653b
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi
>> @@ -0,0 +1,409 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> +#include "sm8650p.dtsi"
>> +#include "pm8550.dtsi"
>> +#include "pm8550b.dtsi"
>> +#define PMK8550VE_SID 8
>> +#include "pm8550ve.dtsi"
>> +#include "pm8550vs.dtsi"
>> +#include "pmk8550.dtsi"
>> +
>> +/ {
>> +       aliases {
>> +               serial1 = &uart14;
>> +       };
>> +
>> +       vph_pwr: vph-pwr-regulator { };
> 
> Is this regulator a part of the module or a part of the carrier board?
> If the latter is true, this must go to the carrier board DT file.
> 

the vph_pwr regulator is defined in the aim500-aiot carrier board and used
in aim500 module.

>> +};
>> +
>> +&apps_rsc {
>> +       regulators-0 {
>> +               compatible = "qcom,pm8550-rpmh-regulators";
>> +
>> +               vdd-bob1-supply = <&vph_pwr>;
>> +               vdd-bob2-supply = <&vph_pwr>;
>> +               vdd-l2-l13-l14-supply = <&vreg_bob1>;
>> +               vdd-l3-supply = <&vreg_s1c_1p2>;
>> +               vdd-l5-l16-supply = <&vreg_bob1>;
>> +               vdd-l6-l7-supply = <&vreg_bob1>;
>> +               vdd-l8-l9-supply = <&vreg_bob1>;
>> +               vdd-l11-supply = <&vreg_s1c_1p2>;
>> +               vdd-l12-supply = <&vreg_s6c_1p8>;
>> +               vdd-l15-supply = <&vreg_s6c_1p8>;
>> +               vdd-l17-supply = <&vreg_bob2>;
>> +
>> +               qcom,pmic-id = "b";
> 
> [skipped]
> 
>> +
>> +&qupv3_id_1 {
>> +       status = "okay";
>> +};
> 
> No GPI node being enabled?
> 
will drop this node for there is no client under that.
>> +
>> +&tlmm {
>> +       bt_default: bt-default-state {
>> +               bt-en-pins {
>> +                       pins = "gpio17";
>> +                       function = "gpio";
>> +                       drive-strength = <16>;
>> +                       bias-disable;
>> +               };
>> +
>> +               sw-ctrl-pins {
>> +                       pins = "gpio18";
>> +                       function = "gpio";
>> +                       bias-pull-down;
>> +               };
>> +       };
>> +};
>> +
>> +&uart14 {
>> +       status = "okay";
>> +
>> +       bluetooth {
>> +               compatible = "qcom,wcn7850-bt";
>> +
>> +               clocks = <&rpmhcc RPMH_RF_CLK1>;
>> +
>> +               vddio-supply = <&vreg_l3c_1p2>;
>> +               vddaon-supply = <&vreg_l15b_1p8>;
>> +               vdddig-supply = <&vreg_s3c_0p9>;
>> +               vddrfa0p8-supply = <&vreg_s3c_0p9>;
>> +               vddrfa1p2-supply = <&vreg_s1c_1p2>;
>> +               vddrfa1p9-supply = <&vreg_s6c_1p8>;
>> +
>> +               max-speed = <3200000>;
>> +
>> +               enable-gpios = <&tlmm 17 GPIO_ACTIVE_HIGH>;
>> +               swctrl-gpios = <&tlmm 18 GPIO_ACTIVE_HIGH>;
>> +
>> +               pinctrl-0 = <&bt_default>;
>> +               pinctrl-names = "default";
>> +       };
>> +};
>> --
>> 2.25.1
>>
>>
> 
> 
Thanks,
Jingyi

