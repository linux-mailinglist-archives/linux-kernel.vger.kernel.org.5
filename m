Return-Path: <linux-kernel+bounces-92624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD61872306
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7451287C3A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ADB12882E;
	Tue,  5 Mar 2024 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l7B3LSMF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA0C1272DE;
	Tue,  5 Mar 2024 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653215; cv=none; b=qPHYZoe58JMxLh52Trnv3FsRr0mmd0WpVVWJLTUODmSQZT/99HvBESNnAXc9UTrtIx47YFmqDImQUVVEJ2iek1FEH2vtaqmBcz35M4BbwZTwsULhwuIbIeOMccJB+w3UmimrfRuHESAtlvwI/EeFnUnwWin3kTpS7uvKuBOKQOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653215; c=relaxed/simple;
	bh=HQ8LElIrX/sLoGmlzmqY66LOagmGK5gMS7TguVW+4Jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ABpJ+bqunBTmoVZPU2BrABXIoMgPPhacQoSGD+hl/oXNI176zXjQvK7qklWHDrKrt25Pr2j2c01uKtKPymGAFofY0XAlLJE28Pl+vTvnGevmu2BCiEBSrbbfPXt3TpePXOZldOBRlxeGoY2URa7jyisy/W6NX8B0hh3B3k9uPCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l7B3LSMF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 425EgpvG030820;
	Tue, 5 Mar 2024 15:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=mUhQ9NC4uDpSL805AO4NNumQdKUkJS0ItnGbPImrg5k=; b=l7
	B3LSMF//ly4WIKMhNJlpVYVWjJCFdWZ3MWMZzr1nLU1sJU0sp8BKvodvuOapnbqS
	leZx/o03alqJDu4mcMg1TyAbSrL+CrEEluo/nJSGxh5ECtBtshaeo7CgxJw2m/Yp
	N1dLQT6rb2Tmtiv1WvkecbTmLvs2XB90/oz84Qu8MeG3gGxYbC3JYRcWp+jzH2f7
	OSbjQTK3WqsGpEi+TcEOleqyD70Ne9FITmpYv329fguT57LyVm73FvRPFsB88851
	mWEgpnjH5kC7XRGQQ19mhi3kKQwIJr48/cJNjqVPXLhBt4B7Jf2VVb6ByiDTK9eG
	rqjeQm+pNWlDk1U8ua3Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnucrsd3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 15:40:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 425Fe57Y028651
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 15:40:05 GMT
Received: from [10.216.49.73] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Mar
 2024 07:40:00 -0800
Message-ID: <f329cf0c-6fce-43ae-bff8-ceb02a246068@quicinc.com>
Date: Tue, 5 Mar 2024 21:09:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 7/9] usb: dwc3: qcom: Refactor IRQ handling in glue
 driver
To: Johan Hovold <johan@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi
	<balbi@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>
References: <20240216005756.762712-1-quic_kriskura@quicinc.com>
 <20240216005756.762712-8-quic_kriskura@quicinc.com>
 <ZeHd5Hh3-cDByLd-@hovoldconsulting.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZeHd5Hh3-cDByLd-@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NkQBllxYU4f3h0JeqWq_DvvFR9T3N06G
X-Proofpoint-ORIG-GUID: NkQBllxYU4f3h0JeqWq_DvvFR9T3N06G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050125



On 3/1/2024 7:23 PM, Johan Hovold wrote:

[...]

>> +
>>   struct dwc3_acpi_pdata {
>>   	u32			qscratch_base_offset;
>>   	u32			qscratch_base_size;
>>   	u32			dwc3_core_base_size;
>> -	int			qusb2_phy_irq_index;
>> -	int			dp_hs_phy_irq_index;
>> -	int			dm_hs_phy_irq_index;
>> -	int			ss_phy_irq_index;
>> +	/*
>> +	 * The phy_irq_index corresponds to ACPI indexes of (in order)
>> +	 * DP/DM/SS/QUSB2 IRQ's respectively.
>> +	 */
>> +	int			phy_irq_index[NUM_PHY_IRQ];
>>   	bool			is_urs;
>>   };
> 
> I asked you to add a port structure and get rid of the PHY indexes in
> v13, and so you did for the diver data below, but you still have an
> array of indexes here for the ACPI data.
> 
> I don't think ever got around to actually reviewing the ACPI hack (and
> maybe I was hoping that we'd be able to drop ACPI support before merging
> multi-port support), but removing these fields and replacing them with
> an array is a step in the wrong direction (e.g. making the code harder
> to read).
> 
> Why can't you just add a helper function which returns one of these
> fields based on the interrupt name string?

I think since [1] has been accepted, this comment has been taken care of.

> 
>> +struct dwc3_qcom_port {
>> +	int			dp_hs_phy_irq;
>> +	int			dm_hs_phy_irq;
>> +	int			ss_phy_irq;
>> +};
> 
> And as I've explicitly said before, you should include hs_phy_irq here.
> 
> It's a port interrupt and special casing just this one make no sense at
> all even if there are no multi-port controller that use it.
> 

Okay. Will add it to port structure.
I only kept it outside because there are no real devices which has 
multiple ports and qusb2_phy_irq in them.

>> +
>>   struct dwc3_qcom {
>>   	struct device		*dev;
>>   	void __iomem		*qscratch_base;
>> @@ -74,9 +90,7 @@ struct dwc3_qcom {
>>   	struct reset_control	*resets;
>>   
>>   	int			qusb2_phy_irq;
>> -	int			dp_hs_phy_irq;
>> -	int			dm_hs_phy_irq;
>> -	int			ss_phy_irq;
>> +	struct dwc3_qcom_port	port_info[DWC3_MAX_PORTS];
> 
> Just name the array 'ports' as I already suggested. It's more succinct
> and makes the code that uses it easier to read.
> 
>>   	enum usb_device_speed	usb2_speed;
>>   
>>   	struct extcon_dev	*edev;
>> @@ -91,6 +105,7 @@ struct dwc3_qcom {
>>   	bool			pm_suspended;
>>   	struct icc_path		*icc_path_ddr;
>>   	struct icc_path		*icc_path_apps;
>> +	u8			num_ports;
> 
> Any reason not to keep this one closer to the ports array?
> 
>>   };
>   

[...]

>> -	irq = dwc3_qcom_get_irq(pdev, "ss_phy_irq",
>> -				pdata ? pdata->ss_phy_irq_index : -1);
>> -	if (irq > 0) {
>> -		ret = dwc3_qcom_request_irq(qcom, irq, "ss_phy_irq");
>> -		if (ret)
>> -			return ret;
>> -		qcom->ss_phy_irq = irq;
>> +	for (i = 0; i < irq_count; i++) {
>> +		irq_index = dwc3_qcom_get_irq_index(irq_names[i]);
>> +		if (irq_index == -1) {
>> +			dev_err(&pdev->dev, "Unknown interrupt-name \"%s\" found\n", irq_names[i]);
> 
> This is now spamming the logs with errors like
> 
> 	dwc3-qcom a6f8800.usb: Unknown interrupt-name "pwr_event" found
> 
> which is clearly just broken.
> 
>> +			continue;
>> +		}
>> +		port_index = dwc3_qcom_get_port_index(irq_names[i], irq_index);
>> +		if (port_index == -1) {
>> +			dev_err(&pdev->dev, "Invalid interrupt-name suffix \"%s\"\n", irq_names[i]);
>> +			continue;
>> +		}
>> +
>> +		acpi_index = dwc3_qcom_get_acpi_index(qcom, irq_index, port_index);
>> +
>> +		irq = dwc3_qcom_get_irq(pdev, irq_names[i], acpi_index);
>> +		if (irq > 0) {
>> +			ret = dwc3_qcom_request_irq(qcom, irq, irq_names[i]);
>> +			if (ret)
>> +				return ret;
>> +
>> +			switch (irq_index) {
>> +			case DP_HS_PHY_IRQ_INDEX:
>> +				qcom->port_info[port_index - 1].dp_hs_phy_irq = irq;
>> +				break;
>> +			case DM_HS_PHY_IRQ_INDEX:
>> +				qcom->port_info[port_index - 1].dm_hs_phy_irq = irq;
>> +				break;
>> +			case SS_PHY_IRQ_INDEX:
>> +				qcom->port_info[port_index - 1].ss_phy_irq = irq;
>> +				break;
>> +			case QUSB2_PHY_IRQ_INDEX:
>> +				qcom->qusb2_phy_irq = irq;
>> +				break;
>> +			}
>> +
>> +			if (qcom->num_ports < port_index)
>> +				qcom->num_ports = port_index;
>> +		}
>>   	}
> 
> Why don't you add a port helper for fetching the interrupts instead?
> 
> There are multiple ways that you can use to determine if this is a
> multiport controller or not; you can use OF match data, or simply look
> at one of the interrupts that would always be there for a multiport
> (or single port) controller (e.g. "dp_hs_phy_1").
> 
> You can even determine the number of ports first by parsing the
> interrupts names and looking for the highest port number.
> 
> Then you can iterate over the ports and parse the interrupts for each
> port in turn, which should allow for a much cleaner and less
> error-prone implementation.
> 

With [1] merged, I think I can use your suggestion of going through and 
checking if dp_hs_phy_X is present or not and if present, it is 
multiport and go through dp_hs_phy_{1/2/3/4} to see the num of ports 
present.

That must simplify the code and make it clean as well.

[1]: 
https://lore.kernel.org/all/20240305093216.3814787-1-quic_kriskura@quicinc.com/

Regards,
Krishna,

