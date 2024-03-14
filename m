Return-Path: <linux-kernel+bounces-103028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A3B87BA1F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131511C21F49
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183BD6CDAC;
	Thu, 14 Mar 2024 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ag7GH8pt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A892A6BB5F;
	Thu, 14 Mar 2024 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407649; cv=none; b=ejbseDQCC+02hWbmiHQwZetiT5Ez4v0li2Wnq9xjqZIHBS3R/KCpXDTz3AYL6Efs9o8ng9w0i4K7i3KC878j0U9/ELJNLz4CI9W2z/iC6ngkjn/4fgTCUVPwRDkbPBAnMx5Glp9r0duy8QILpYPG3oDld/upEPCTwBau7Kq5sTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407649; c=relaxed/simple;
	bh=XKtR3XUwL0KpD+s/4Np3/hjUic2pr9Ki9Un2O1E+W6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l9Kq5hklphNw5Bgs5gUNUVyvI+U1elVozEiHzyX7I+D3yNd/KNOPgGqo9l5tz6senMj8Uqc2fv7080+CcLINWZDqEA6UKPe9gj9fpyWSxmZfchzJaMKrcejatl5ukM01ms6ZcJLydI4OQGraW5zN1bs/XSUFKh53W8QGU2NHz40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ag7GH8pt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42E7UEX7010181;
	Thu, 14 Mar 2024 09:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=USm0frasnVP6P/YolL0WYFQ9V0OB47+8oAYKEgDbct8=; b=ag
	7GH8pt/VtUJSYLVJ4WHYBvFvKqKH4czfEJnAusa5e9wQ+771NdGjaKWVkIiKNyGK
	Srjxux3lCPq8SAtOWFstudOs2p8H2YFDYDL7DadY//E9++dGSjSEab6wxgoft5Rl
	rpz0IjBn1LLOBQCL0KMK7eXP3Tdv2mjjNh0Q03vhLlUlp+SQlf/C9Ae03ddqsu7y
	O0sJUwsD9A0W9/bEolRFzT8ziWYYmMi0Jjw/qH/dJZp3tmnqpQU8pkX7FSaqdZ/v
	qmUezdE6czL2TDr9wD1va/mdYWLlK05d1v5VLCL2XYLj0lkqWHulyAmg+/XQerio
	JezEGzSFHRgO3ad7p6Cg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wumkc17j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 09:13:51 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42E9Doih005851
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 09:13:50 GMT
Received: from [10.218.19.46] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 02:13:45 -0700
Message-ID: <1a2a7d7d-ed67-1c90-d3d1-4529dc07effa@quicinc.com>
Date: Thu, 14 Mar 2024 14:43:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8150: Add video clock controller
 node
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh
 Kona" <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20240313-videocc-sm8150-dt-node-v1-0-ae8ec3c822c2@quicinc.com>
 <20240313-videocc-sm8150-dt-node-v1-3-ae8ec3c822c2@quicinc.com>
 <CAA8EJprrrSTLBoLGMSJw3g9BEcL6y+To1tr65b+AzNz01MgjTg@mail.gmail.com>
From: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
In-Reply-To: <CAA8EJprrrSTLBoLGMSJw3g9BEcL6y+To1tr65b+AzNz01MgjTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: auCfX0or9HvqZfpgmMkcyFgxbKdz9EES
X-Proofpoint-ORIG-GUID: auCfX0or9HvqZfpgmMkcyFgxbKdz9EES
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_07,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140064


On 3/14/2024 12:46 AM, Dmitry Baryshkov wrote:
> On Wed, 13 Mar 2024 at 13:11, Satya Priya Kakitapalli
> <quic_skakitap@quicinc.com> wrote:
>> Add device node for video clock controller on Qualcomm
>> SM8150 platform.
>>
>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sa8155p.dtsi |  4 ++++
>>   arch/arm64/boot/dts/qcom/sm8150.dtsi  | 13 +++++++++++++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8155p.dtsi b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
>> index ffb7ab695213..9e70effc72e1 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8155p.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
>> @@ -38,3 +38,7 @@ &rpmhpd {
>>           */
>>          compatible = "qcom,sa8155p-rpmhpd";
>>   };
>> +
>> +&videocc {
>> +       power-domains = <&rpmhpd SA8155P_CX>;
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
>> index a35c0852b5a1..6573c907d7e2 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
>> @@ -14,6 +14,7 @@
>>   #include <dt-bindings/clock/qcom,dispcc-sm8150.h>
>>   #include <dt-bindings/clock/qcom,gcc-sm8150.h>
>>   #include <dt-bindings/clock/qcom,gpucc-sm8150.h>
>> +#include <dt-bindings/clock/qcom,videocc-sm8150.h>
>>   #include <dt-bindings/interconnect/qcom,osm-l3.h>
>>   #include <dt-bindings/interconnect/qcom,sm8150.h>
>>   #include <dt-bindings/thermal/thermal.h>
>> @@ -3715,6 +3716,18 @@ usb_2_dwc3: usb@a800000 {
>>                          };
>>                  };
>>
>> +               videocc: clock-controller@ab00000 {
>> +                       compatible = "qcom,sm8150-videocc";
>> +                       reg = <0 0x0ab00000 0 0x10000>;
>> +                       clocks = <&rpmhcc RPMH_CXO_CLK>,
>> +                                <&gcc GCC_VIDEO_AHB_CLK>;
>> +                       power-domains = <&rpmhpd SM8150_MMCX>;
>> +                       required-opps = <&rpmhpd_opp_low_svs>;
> Should not be necessary anymore.


Whenever the rail is turned on, we want to keep it in low_svs state 
instead of retention, hence added this property , please let me know why 
you think it is not needed?


>> +                       #clock-cells = <1>;
>> +                       #reset-cells = <1>;
>> +                       #power-domain-cells = <1>;
>> +               };
>> +
>>                  camnoc_virt: interconnect@ac00000 {
>>                          compatible = "qcom,sm8150-camnoc-virt";
>>                          reg = <0 0x0ac00000 0 0x1000>;
>>
>> --
>> 2.25.1
>>
>>
>

