Return-Path: <linux-kernel+bounces-28481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54D282FF15
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 462D5B22516
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381584685;
	Wed, 17 Jan 2024 03:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fV8Tbotb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4C11C05;
	Wed, 17 Jan 2024 03:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705460574; cv=none; b=jgFvcaSI0H4AXZI4gv3GadyDUHgbipxxtYPEuBvp1tZxxk1X2P4GbcEuiH82t6erpOUMGBm5KF11UXE/fuVIy4lxLEwDKkF4yHQlV6jYlsFtkjFsxyYpadRV5Bt0YX6VZ2Wr55Ib/M7zmbzavNzk0fIwUXc+iKwVz5y/HxtHJ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705460574; c=relaxed/simple;
	bh=DQvtSdEir8QJQGzNyD6XFq8fOIpXUl/qDoxIW+OuhHc=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=G89dUszDTzU/wmHdk7U+fvjVbH5/yd4wLwfnYe7nWNRQxwsXNIeQiu31bOK0VmNdi/cFf+mIdweQqpKdLaXbdcO1yuBPzuyY4IzIHu93jdfIVSnReQfRFzi7QAFs/vKi6EkGuBtx2KjQ3CoG2anZ0GSDMIr7DGdtibaMiuH/riE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fV8Tbotb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H2elEB003827;
	Wed, 17 Jan 2024 03:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tlH1cHFj6QYJ353pHoD7rD+rxyAp2OnGNl2luTyRGfQ=; b=fV
	8TbotbI/Hv0lIXFCw/M2RdK7V7EkyhsQtDlPTS2UWU3EDrezfjR5ffN3Uqwjus5H
	/Jg7RtP+gUZdvZf2JbvzTX5DKV7WJpndL/02xEnj8oF1jVi193xpAjrFU8c03VlE
	tvj/s/iVRenxo8OCK9p1HM4gsuVeShX7wRy0pgIhWigJX/+z1NmH1RaXqtkx2Gmy
	8IkuCmzOWl9y6vLcAZ7xzHeI7PXFLG6aOt667M0i9Md+8YjtrmPONihDP8DhhXkq
	TAYW6y9uwOUw04808oD6tvvP7WBvB5AomCYAfKwXGLdWjE9TPiSXvTHuCSzvdrsC
	GY9kp6d5I+QZ8EK7Opzw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnymj0y40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 03:02:49 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40H32lUu026314
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 03:02:48 GMT
Received: from [10.238.139.231] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 16 Jan
 2024 19:02:44 -0800
Message-ID: <44ab50c4-c63b-436c-af46-9b4543181446@quicinc.com>
Date: Wed, 17 Jan 2024 11:02:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] arm64: dts: qcom: qcm6490-idp: Add definition for
 three LEDs
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_fenglinw@quicinc.com>
References: <20240115-lpg-v5-1-3c56f77f9cec@quicinc.com>
 <CAA8EJpoemnXTmshWrArVOCm0GRSkWZ5tH557nbAjRL1Tgg-Dig@mail.gmail.com>
 <e16f5ff1-9b12-4f90-89d5-f95cbfb859e7@quicinc.com>
 <6c29ce72-e303-406a-bb75-5b36b0cd8ee4@linaro.org>
From: hui liu <quic_huliu@quicinc.com>
In-Reply-To: <6c29ce72-e303-406a-bb75-5b36b0cd8ee4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Hg--S2Fqs2Usbx3cDu_QUZlr5um41jIg
X-Proofpoint-GUID: Hg--S2Fqs2Usbx3cDu_QUZlr5um41jIg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_14,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=838
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401170019



On 1/15/2024 6:26 PM, Krzysztof Kozlowski wrote:
> On 15/01/2024 11:18, hui liu wrote:
>>
>>
>> On 1/15/2024 5:56 PM, Dmitry Baryshkov wrote:
>>> On Mon, 15 Jan 2024 at 11:48, Hui Liu via B4 Relay
>>> <devnull+quic_huliu.quicinc.com@kernel.org> wrote:
>>>>
>>>> From: Hui Liu <quic_huliu@quicinc.com>
>>>>
>>>> Add definition for three LEDs to make sure they can
>>>> be enabled base on QCOM LPG LED driver.
>>>
>>> The "function" property is still placed incorrectly. Posting the next
>>> iteration before concluding the discussion on the previous one is not
>>> the best idea.
>> Do you mean I should update it as below? Seems there is no consumer to
>> use the function config, do we need to add now?
> 
> Paste the output of dtbs_check for your board (or CHECK_DTBS=y for your
> Makefile target).
I checked the dt-binding file of LPG LED, I will update the dts as 
below, if you think it's correct, I will push v6.

+&pm8350c_pwm {
+       #address-cells = <1>;
+       #size-cells = <0>;
+       status = "okay";
+
+       led@1 {
+               reg = <1>;
+               color = <LED_COLOR_ID_RED>;
+		function = LED_FUNCTION_STATUS;
+       };
+
+       led@2 {
+               reg = <2>;
+               color = <LED_COLOR_ID_GREEN>;
+		function = LED_FUNCTION_STATUS;
+       };
+
+       led@3 {
+               reg = <3>;
+               color = <LED_COLOR_ID_BLUE>;
+		function = LED_FUNCTION_STATUS;
+       };
+};
+

Thanks,
Hui
> 
> Best regards,
> Krzysztof
> 

