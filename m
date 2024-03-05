Return-Path: <linux-kernel+bounces-91894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDAE87180A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09DC1C2142A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20697F48E;
	Tue,  5 Mar 2024 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UnbE/QWz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C77279F2;
	Tue,  5 Mar 2024 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626647; cv=none; b=dl+K1U68eY3Lg8k7qdA28nLfbkWky7VqvlNn2mcJvzWkUjd3VA9lKZ6BesXJM1hg/VY5J/09fiRZsR1C0s07BrnSolmDyMqfhjLBCz5k+L3eMh3/cxJDdFLnNzdkOaHGjPkFGEyDDeL55nkJCvM3sBciLPHNqKQJY/XlkFnJtIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626647; c=relaxed/simple;
	bh=Scq4z644jE8YjDLQKqzdXOBUBpcHsdXLwob6hlsAETw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lJulNJKa0ZNdKo8lmuL2Q+Rpy1aGJo2dg+JqRCoJAXj2kviBIs64lkK4XNHIuehkkkqNLZ2NBHCabE07fVr4Ll1WwOjYTgqQCG+1moivCOsYl+eKwyKFRveNllxhfDY2ew6SjBtn9VwgKBJr0rQTY+eIQmJVEH21tidFIDvQ1WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UnbE/QWz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4257vWqx021648;
	Tue, 5 Mar 2024 08:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=cpxkCg4LuU89alEVCTIshVZabpQiqCVC51QCdIoFkxA=; b=Un
	bE/QWz5iRDauRir1AA8MP4lASbRhgmnQwL2ykKzqgiR6a26p9k+iDu4qQ0zxWumx
	lQhHWq/pXnb9fti/4iDBwJsmyueuhYNDVpeo5lYtxyEfRyasiRqhKiBqLejYWEu8
	1ttOzdz3z1pw2l0hFDYVV5Y6ORdZ7TCzGnMaPDk2uu67FvFln6wQc2mrgUxQP2yF
	+VXr6ycy5aatYWeUpB0mbF+0yZVUsbGGMkK08nf61LnRqgk1ttAvcCjViBPf/dPd
	JE6rg5pH+WKrjaVFMhfg8yTKnaMnBxIh9lqp/hdeZjKJlKaTg4ag3iV+lNMs61yG
	izR88peM+RMyPnQjJ5eA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnarj2pq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 08:17:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4258HHHe029855
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 08:17:17 GMT
Received: from [10.216.49.73] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Mar
 2024 00:17:13 -0800
Message-ID: <0c2c039e-b49e-4172-9c7f-24061e3ac5c6@quicinc.com>
Date: Tue, 5 Mar 2024 13:47:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: qcom: Remove ACPI support from glue driver
To: Johan Hovold <johan@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>
References: <20240305042143.3455101-1-quic_kriskura@quicinc.com>
 <ZebFKlae0a-deBKl@hovoldconsulting.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZebFKlae0a-deBKl@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RuZNma4jQxjzz2EndhVkXrzhs-Bhk-Gc
X-Proofpoint-GUID: RuZNma4jQxjzz2EndhVkXrzhs-Bhk-Gc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_05,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=780 adultscore=0
 spamscore=0 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050065



On 3/5/2024 12:39 PM, Johan Hovold wrote:
> On Tue, Mar 05, 2024 at 09:51:43AM +0530, Krishna Kurapati wrote:
>> Minimal ACPI support was added to the Qualcomm DWC3 glue driver in order to
>> enable USB on SDM850 and SC8180X compute platforms. The support is still
>> functional, but unnoticed regressions in other drivers indicates that no
>> one actually booting any of platforms dependent on this implementation.
>>
>> The functionality provides is the bare minimum and is not expected to aid
>> in the effort of bringing full ACPI support to the driver in the future.
>>
>> Remove the ACPI code from the Qualcomm DWC3 glue driver to aid in the
>> implementation of improvements that are actually used like multiport and
>> flattening device tree.
> 
> With a simple lookup function that returns the ACPI index based on name
> this shouldn't be required to add multiport support even if it may
> simplify it slightly. But IIRC it would help more with the devicetree
> binding rework.
>   

I agree to both your comments.
Actually both series are equally important to me. Adding a lookup 
function must ACPI index must help multiport code without this patch as 
well. But removing this is helping in multiport to write better code and 
definitely helps in flattening series.

>> Commit message by Bjorn Andersson.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/dwc3/dwc3-qcom.c | 273 ++---------------------------------
>>   1 file changed, 11 insertions(+), 262 deletions(-)
> 
> You should update the Kconfig entry for USB_DWC3_QCOM as well and drop
> the ACPI dependency.

Missed it. Thanks for the catch. The following is the one right ?

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 5fc27b20df63..31078f3d41b8 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -131,7 +131,7 @@ config USB_DWC3_QCOM
         tristate "Qualcomm Platform"
         depends on ARCH_QCOM || COMPILE_TEST
         depends on EXTCON || !EXTCON
-       depends on (OF || ACPI)
+       depends on OF


> 
>>   static int dwc3_qcom_probe(struct platform_device *pdev)
>>   {
>>   	struct device_node	*np = pdev->dev.of_node;
>>   	struct device		*dev = &pdev->dev;
>>   	struct dwc3_qcom	*qcom;
>>   	struct resource		*res, *parent_res = NULL;
> 
> You should drop parent_res as well.

Ahh, thanks for the catch.

> 
>> -	struct resource		local_res;
>>   	int			ret, i;
>>   	bool			ignore_pipe_clk;
>>   	bool			wakeup_source;
>> @@ -825,14 +659,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>>   	platform_set_drvdata(pdev, qcom);
>>   	qcom->dev = &pdev->dev;
>>   
>> -	if (has_acpi_companion(dev)) {
>> -		qcom->acpi_pdata = acpi_device_get_match_data(dev);
>> -		if (!qcom->acpi_pdata) {
>> -			dev_err(&pdev->dev, "no supporting ACPI device data\n");
>> -			return -EINVAL;
>> -		}
>> -	}
>> -
>>   	qcom->resets = devm_reset_control_array_get_optional_exclusive(dev);
>>   	if (IS_ERR(qcom->resets)) {
>>   		return dev_err_probe(&pdev->dev, PTR_ERR(qcom->resets),
>> @@ -860,41 +686,18 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>>   	}
>>   
>>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -
>> -	if (np) {
>> -		parent_res = res;
>> -	} else {
>> -		memcpy(&local_res, res, sizeof(struct resource));
>> -		parent_res = &local_res;
>> -
>> -		parent_res->start = res->start +
>> -			qcom->acpi_pdata->qscratch_base_offset;
>> -		parent_res->end = parent_res->start +
>> -			qcom->acpi_pdata->qscratch_base_size;
>> -
>> -		if (qcom->acpi_pdata->is_urs) {
>> -			qcom->urs_usb = dwc3_qcom_create_urs_usb_platdev(dev);
>> -			if (IS_ERR_OR_NULL(qcom->urs_usb)) {
>> -				dev_err(dev, "failed to create URS USB platdev\n");
>> -				if (!qcom->urs_usb)
>> -					ret = -ENODEV;
>> -				else
>> -					ret = PTR_ERR(qcom->urs_usb);
>> -				goto clk_disable;
>> -			}
>> -		}
>> -	}
>> +	parent_res = res;
>>   
>>   	qcom->qscratch_base = devm_ioremap_resource(dev, parent_res);
> 
> And just use res here.

ACK.

> 
>>   	if (IS_ERR(qcom->qscratch_base)) {
>>   		ret = PTR_ERR(qcom->qscratch_base);
>> -		goto free_urs;
>> +		goto clk_disable;
>> }
> 
> Looks good to me otherwise.

Thanks for the review. Wanted to reply to your comments on multiport 
series depending on how this patch goes in upstream.

Can I push out v2 or wait for a couple of days (as a standard practice 
before putting a new version) ?

Regards,
Krishna,

