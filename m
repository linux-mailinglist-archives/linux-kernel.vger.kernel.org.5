Return-Path: <linux-kernel+bounces-57395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCCD84D7E6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A922841FD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CAB1BC40;
	Thu,  8 Feb 2024 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Fl7l18II"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA6E1E893;
	Thu,  8 Feb 2024 02:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707360024; cv=none; b=msaGmeb/XGlIjDlrPdXta4UnrS1/eaL/sbBuLVCJ1C5bk99PZOHg/RGnrUMDJvfTaf/lB/eV3vPPBI/+aY4wobvmTpBSTIxAJrnx1AZ8jIs1swapWmbN1HUQjp21w7sI+HHe7C8uifVRD9UOu/sx4g1hfGt23DoNByXChuBHoz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707360024; c=relaxed/simple;
	bh=YfUA8bYcjPPdkHKmp+0pbCt9snSvyjAV+Ek9TOcTOZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EmguykzqV09B8lZLx78oZnwcROu4NSNQXgIzcOe8LVQ2aH0i2TKrNnBPNsGK1vaNEPw1mqN1oegZc5ZJB6IHtJVn5Q0/GKUnNxlLaW4jXmDa5sSHd73gi63kMCRbEJcDTtv7MKRCSYDWG6zKqTI5VPLIUGy9ILuC6jnsJrJYZ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Fl7l18II; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4180R5Uk003257;
	Thu, 8 Feb 2024 02:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=r36MAqpN75U9/o+bC5YhUOJXFz6fuk0pNIH1qiuTQ7A=; b=Fl
	7l18IIdvqF916PBEPxEd6xR1BoLGr/izdTzyALff3dlWBRBSlRFdNvqOMFWTxWrc
	HpojJmfAPfFZVi1sC10EjnGb2IkoolZa1x9QZ/b7TpmFO1c4mSp8OwStKiqly3xo
	GixHd2Gt9lIXSqygoLrP65qJ6v78rquje4RX5i3Oshi/t4vvwPWYmqLSU32JW/jC
	DgjPigQL0PqUyEChnX+vACTXGAvIPx7zd/MAWFcVgw3mDg2/Z4+gMIenPyrZSZ2J
	6PmpjaHBJ2mXZI+e8b7+lxwVtvARVdbdO1EiXltxu+TKAxr1fJt5l2l/2q54nXVA
	ofFtwOlqonk1anKA833g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4h0ugjvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 02:40:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4182eIoR028142
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 02:40:18 GMT
Received: from [10.216.53.86] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 7 Feb
 2024 18:40:14 -0800
Message-ID: <fd4f4cc8-3366-485b-b540-b05ef59dd5d4@quicinc.com>
Date: Thu, 8 Feb 2024 08:10:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sa8295p: Enable tertiary controller
 and its 4 USB ports
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Rob Herring <robh+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>
References: <20240206114745.1388491-1-quic_kriskura@quicinc.com>
 <20240206114745.1388491-3-quic_kriskura@quicinc.com>
 <CAA8EJpoed-hu4hPXAcwQxmJAaNRwJ2y5q9qybWaPP8bdMnz_oA@mail.gmail.com>
 <0470a930-d629-4467-b619-58d3e76f59a7@quicinc.com>
 <CAA8EJppJAdHXoVs_2VqQf=_Wk_LoEcNMY2H-Xzqu8KzeaN8i0g@mail.gmail.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CAA8EJppJAdHXoVs_2VqQf=_Wk_LoEcNMY2H-Xzqu8KzeaN8i0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 55FaGuf4DUzEYbqwjkf0V5s-AoZ1OkcA
X-Proofpoint-GUID: 55FaGuf4DUzEYbqwjkf0V5s-AoZ1OkcA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=731 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402080011



On 2/6/2024 6:54 PM, Dmitry Baryshkov wrote:
> On Tue, 6 Feb 2024 at 14:28, Krishna Kurapati PSSNV
> <quic_kriskura@quicinc.com> wrote:
>>
>>
>>
>> On 2/6/2024 5:43 PM, Dmitry Baryshkov wrote:
>>> On Tue, 6 Feb 2024 at 14:03, Krishna Kurapati <quic_kriskura@quicinc.com> wrote:
>>>>
>>>> Enable tertiary controller for SA8295P (based on SC8280XP).
>>>> Add pinctrl support for usb ports to provide VBUS to connected peripherals.
>>>
>>> These are not just pinctrl entries. They hide VBUS regulators. Please
>>> implement them properly as corresponding vbus regulators.
>>>
>>
>> Hi Dmitry. Apologies, can you elaborate on your comment. I thought this
>> implementation was fine as Konrad reviewed it in v13 [1]. I removed his
>> RB tag as I made one change of dropping "_state" in labels.
> 
> My comment is pretty simple: if I'm not mistaken, your DT doesn't
> reflect your hardware design.
> You have actual VBUS regulators driven by these GPIO pins. Is this correct?
> If so, you should describe them properly in the device tree rather
> than describing them just as USB host's pinctrl state.
> 

Hi Dmitry,

  I have very little idea about the gpio controller regulators. I will 
go through it and see how I can implement it. I just found this : 
https://www.kernel.org/doc/Documentation/devicetree/bindings/regulator/gpio-regulator.txt

One query. If we model it as a regulator, do we need to add it as a 
supply and call regulator_enable in dwc3_qcom probe again ?

Regards,
Krishna,

