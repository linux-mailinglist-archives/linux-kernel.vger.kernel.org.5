Return-Path: <linux-kernel+bounces-58932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E1B84EEC4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CCC9B2683D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9413B1859;
	Fri,  9 Feb 2024 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DA4qlwvZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EF11368;
	Fri,  9 Feb 2024 02:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707444043; cv=none; b=rjdPgaB6dcHwLZbyaTKKSG1J908gmxq6quFAdONdkHYbaHc13TtV02LAkUbqkMTdyEasFPXr3B36MXuU9PO4AeWuHt2ILwd0Y/t0AWtUADetgnaHyoH/E6+JeG7UGQuT7UAKRzyzBVsSHwGebgzqY7BJ49UdCnAK9u5lBfezYgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707444043; c=relaxed/simple;
	bh=+wcDFFazTAih6M0I3X/kEqFY8bwxCIFWui8YBFb8oNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HNmla0HA0mj/rd99UbNBXykETsV7pseSn2/IjexsQF74pw3ithWOFzyECikxdxHbHMaJrxaBqF7R97RSkARuMZqwAMeIiEYly51t6mP7yLd9qU7HgtMT/ZHe34VJgxI6QCgtnKaNOhOFY18+y01sG7fGATubX7SOtE3KV7PhuSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DA4qlwvZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419201aI014974;
	Fri, 9 Feb 2024 02:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=U9Jj/g+FOBdzUcfSgSgTQta5JtNLD2HQfpITIRxWLEI=; b=DA
	4qlwvZTke7dM3r4ZG7wG+yfsyZo9u6F36NKlyr3aaZ5Dl35pNOrqB+kIY8xXu4gn
	BLUDaZRRf8L+AxlAHZ1Qh42+YmrwD+tje9FQNrfygwlVtHSVlXs/SqB2wnp2Iby8
	d059JCk2KBOmQYaurbvZu5Jzso/zkl4R6W4VsIOjtIHXSdmlXCxRMRqXCcI1EWw9
	MDqBPNfH5JL4FGBdsuN4JV6XUaDQu9GP/+wVdyjjuZ5UdVjVd/98xQ5Fx+miN74R
	OTAg9S7Pz5+q/3McCBh5TFAoKETW+FxI7oUAWF8So4FKZyRD5KWH74btVecQ5/BK
	lG1Rd15a02+wXNGqbLeg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4stxjhjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 02:00:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41920Kgr003879
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Feb 2024 02:00:20 GMT
Received: from [10.216.50.33] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 8 Feb
 2024 18:00:15 -0800
Message-ID: <af73110d-e13e-4183-af11-aed869ac0a31@quicinc.com>
Date: Fri, 9 Feb 2024 07:30:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
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
	<conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
 <20240206051825.1038685-3-quic_kriskura@quicinc.com>
 <20240208234154.6jq2oah6ondn3jlq@synopsys.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20240208234154.6jq2oah6ondn3jlq@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TL6DtjOCziYIUOWjhN6C4RsmCfNXUaPG
X-Proofpoint-ORIG-GUID: TL6DtjOCziYIUOWjhN6C4RsmCfNXUaPG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_13,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090012



On 2/9/2024 5:12 AM, Thinh Nguyen wrote:
> On Tue, Feb 06, 2024, Krishna Kurapati wrote:
>> Currently Multiport DWC3 controllers are host-only capable.
>> Temporarily map XHCI address space for host-only controllers and parse
>> XHCI Extended Capabilities registers to read number of usb2 ports and
>> usb3 ports present on multiport controller. Each USB Port is at least HS
>> capable.
>>
>> The port info for usb2 and usb3 phy are identified as num_usb2_ports
>> and num_usb3_ports. The intention is as follows:
>>
>> Wherever we need to perform phy operations like:
>>
>> LOOP_OVER_NUMBER_OF_AVAILABLE_PORTS()
>> {
>> 	phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
>> 	phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
>> }
>>
>> If number of usb2 ports is 3, loop can go from index 0-2 for
>> usb2_generic_phy. If number of usb3-ports is 2, we don't know for sure,
>> if the first 2 ports are SS capable or some other ports like (2 and 3)
>> are SS capable. So instead, num_usb2_ports is used to loop around all
>> phy's (both hs and ss) for performing phy operations. If any
>> usb3_generic_phy turns out to be NULL, phy operation just bails out.
>> num_usb3_ports is used to modify GUSB3PIPECTL registers while setting up
>> phy's as we need to know how many SS capable ports are there for this.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/dwc3/core.c | 62 +++++++++++++++++++++++++++++++++++++++++
>>   drivers/usb/dwc3/core.h |  5 ++++
>>   2 files changed, 67 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 3b68e8e45b8b..965eaad195fb 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -39,6 +39,7 @@
>>   #include "io.h"
>>   
>>   #include "debug.h"
>> +#include "../host/xhci-ext-caps.h"
>>   
>>   #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
>>   
>> @@ -1882,10 +1883,57 @@ static int dwc3_get_clocks(struct dwc3 *dwc)
>>   	return 0;
>>   }
>>   
>> +static int dwc3_read_port_info(struct dwc3 *dwc)
> 
> I think it may fit better to leave this function definition in host.c.
> But you can also argue to leave it here. Let me know what you think.

I'd like to keep it here for now.

> 
>> +{
>> +	void __iomem *base;
>> +	u8 major_revision;
>> +	u32 offset;
>> +	u32 val;
>> +
>> +	/*
>> +	 * Remap xHCI address space to access XHCI ext cap regs since it is
>> +	 * needed to get information on number of ports present.
>> +	 */
>> +	base = ioremap(dwc->xhci_resources[0].start,
>> +		       resource_size(&dwc->xhci_resources[0]));
>> +	if (IS_ERR(base))
> 
> ioremap returns NULL on errors.
> 

Can we keep the above for now if the v14 series goes well. I'll post a 
patch later for this. Incase it turns out I need v15 I will make this 
change in v15.

>> +		return PTR_ERR(base);
>> +
>> +	offset = 0;
>> +	do {
>> +		offset = xhci_find_next_ext_cap(base, offset,
>> +						XHCI_EXT_CAPS_PROTOCOL);
>> +		if (!offset)
>> +			break;
>> +
>> +		val = readl(base + offset);
>> +		major_revision = XHCI_EXT_PORT_MAJOR(val);
>> +
>> +		val = readl(base + offset + 0x08);
>> +		if (major_revision == 0x03) {
>> +			dwc->num_usb3_ports += XHCI_EXT_PORT_COUNT(val);
>> +		} else if (major_revision <= 0x02) {
>> +			dwc->num_usb2_ports += XHCI_EXT_PORT_COUNT(val);
>> +		} else {
>> +			dev_warn(dwc->dev,
>> +				 "unrecognized port major revision %d\n",
>> +							major_revision);
>> +		}
>> +	} while (1);
>> +
>> +	dev_dbg(dwc->dev, "hs-ports: %u ss-ports: %u\n",
>> +		dwc->num_usb2_ports, dwc->num_usb3_ports);
>> +
>> +	iounmap(base);
>> +
>> +	return 0;
>> +}
>> +
> 
>>   static int dwc3_probe(struct platform_device *pdev)
>>   {
>>   	struct device		*dev = &pdev->dev;
>>   	struct resource		*res, dwc_res;
>> +	unsigned int		hw_mode;
>>   	void __iomem		*regs;
>>   	struct dwc3		*dwc;
>>   	int			ret;
>> @@ -1969,6 +2017,20 @@ static int dwc3_probe(struct platform_device *pdev)
>>   			goto err_disable_clks;
>>   	}
>>   
>> +	/*
>> +	 * Currently only DWC3 controllers that are host-only capable
>> +	 * support Multiport.
>> +	 */
>> +	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
>> +	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
>> +		ret = dwc3_read_port_info(dwc);
> 
> The function name here can be reworded as it does more than reading the
> port info. Perhaps dwc3_get_num_ports()?
> 
I am fine either ways. I'll change the func name in v15.

Regards,
Krishna,

