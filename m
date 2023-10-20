Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C6F7D0F05
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377246AbjJTLos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377381AbjJTLog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:44:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCF246B3;
        Fri, 20 Oct 2023 04:43:05 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39K7a7Pe002540;
        Fri, 20 Oct 2023 11:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Bm51Om3gZzpa1v/vxVMnh6BhiJMwyK7YZWgdIj9tKfc=;
 b=bO5ue8tmhYDYsaePp6uQ9DbiUgwiFIbqVlRbqjwidbu1epYkSWWo8DPuue0rLFYw5Qms
 7dGi/QnthVEJFm1MKAONsATel7Q24KzlfyekYbmYh/KY0u7QNf7T11JkMDP9nwMyEX4u
 9ngF/C/socdHK3KfcPA1k6mlJuzNBW5JWFXSd1Ebg0Y8INjIH8clNKIb0qnbo7lJ/hJV
 RQzQg2OZ0c9aLCzPYL4YQyT/1O7IgINZBnBxrWSL9ugNR8VgBHRQwyHIo7MO7cOWTBuD
 hWTiAYrR476QZkmq5G4M31kitn03oC21CkXGGF/EA4kGd3TMjBNysHWN53TlltzcgdLg Jg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tubwr9qvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 11:41:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39KBfvs4025304
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 11:41:57 GMT
Received: from [10.216.47.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 20 Oct
 2023 04:41:49 -0700
Message-ID: <157d1c8d-5aa4-4488-bf85-7806c8fb00bc@quicinc.com>
Date:   Fri, 20 Oct 2023 17:11:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 03/10] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>,
        Harsh Agarwal <quic_harshq@quicinc.com>,
        kernel test robot <lkp@intel.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-4-quic_kriskura@quicinc.com>
 <ZTJPBcyZ_zLXbgE5@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZTJPBcyZ_zLXbgE5@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pUAqABDTDCaqWova7_OUswvp6OdFJFzK
X-Proofpoint-GUID: pUAqABDTDCaqWova7_OUswvp6OdFJFzK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310200097
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2023 3:27 PM, Johan Hovold wrote:
> On Sat, Oct 07, 2023 at 09:17:59PM +0530, Krishna Kurapati wrote:
>> From: Harsh Agarwal <quic_harshq@quicinc.com>
>>
>> Currently the DWC3 driver supports only single port controller
>> which requires at most one HS and one SS PHY.
> 
> Should that not be "at least one HS PHY and at most one SS PHY"?
>   
>> But the DWC3 USB controller can be connected to multiple ports and
>> each port can have their own PHYs. Each port of the multiport
>> controller can either be HS+SS capable or HS only capable
>> Proper quantification of them is required to modify GUSB2PHYCFG
>> and GUSB3PIPECTL registers appropriately.
>>
>> Add support for detecting, obtaining and configuring phy's supported
> 
> "PHYs" for consistency, no apostrophe
> 
>> by a multiport controller and. Limit the max number of ports
> 
> "and." what? Looks like part of the sentence is missing? Or just drop
> " and"?
> 
>> supported to 4 as only SC8280 which is a quad port controller supports
> 
> s/4/four/
> 
> Just change this to
> 
> 	Limit support to multiport controllers with up to four ports for
> 	now (e.g. as needed for SC8280XP).
> 
>> Multiport currently.
> 
> You use capitalised "Multiport" in several places it seems. Is this an
> established term for these controllers or should it just be "multiport"
> or "multiple ports"?
> 
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202309200156.CxQ3yaLY-lkp@intel.com/
> 
> Drop these two lines, as people have already suggested.
> 
>> Co-developed-by: Harsh Agarwal <quic_harshq@quicinc.com>
>> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
>> Co-developed-by:Krishna Kurapati <quic_kriskura@quicinc.com>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> 
> Thinh pointed out the problems with the above which were also reported
> by checkpatch.pl.
> 

I see that removing Co-Developed by tag for Harsh is helping with one 
checkpatch issue. From what I know, although I made Harsh the Primary 
author for the patch, should we still mention his Co-Developed-by along 
with this Signed-Of by ?

>> ---
>> Changes in v13:
>> Compiler issues found by kernel test robot have been fixed and tags added.
>> So removing maintainers reviewed-by tag as we have made a minor change
>> in the patch.
> 
> In general this is the right thing to do when the change in question was
> non-trivial. I'm not sure that's the case here, but the robots tend to
> complain about smaller (but sometimes important) things.
> 

I too had this uncertainity, but I see that we must not add maintainers 
reviewed by tag if we even make one letter of change. Wanted to adhere 
to these rules and so removed Thinh's tag and asked for re-review.

>> @@ -748,23 +781,32 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
>>   static int dwc3_phy_init(struct dwc3 *dwc)
>>   {
>>   	int ret;
>> +	int i;
>> +	int j;
> 
> These could be declared on one line (same throughout).
> 

I did so in v7, but was asked to put them in separate lines:
https://lore.kernel.org/all/20230502221100.ecska23anlzv3iwq@synopsys.com/


>>   	usb_phy_init(dwc->usb2_phy);
>>   	usb_phy_init(dwc->usb3_phy);

				dwc->usb2_generic_phy[i] = NULL;
>> +			else
>> +				return dev_err_probe(dev, ret,
>> +					"failed to lookup phy %s\n", phy_name);
> 
> Continuation lines should be intented at least two tabs further.
> 
> I generally suggest adding brackets around blocks with multiline
> statements to improve readability but if you move the string to the
> previous line and intend the continuation line (phy_name) one tab more I
> guess that's fine.
> 
>> +		}
>> +
>> +		if (dwc->num_usb2_ports == 1)
>> +			sprintf(phy_name, "usb3-phy");
>>   		else
>> -			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
>> +			sprintf(phy_name, "usb3-port%d", i);
>> +
>> +		dwc->usb3_generic_phy[i] = devm_phy_get(dev, phy_name);
>> +		if (IS_ERR(dwc->usb3_generic_phy[i])) {
>> +			ret = PTR_ERR(dwc->usb3_generic_phy[i]);
>> +			if (ret == -ENOSYS || ret == -ENODEV)
>> +				dwc->usb3_generic_phy[i] = NULL;
>> +			else
>> +				return dev_err_probe(dev, ret,
>> +					"failed to lookup phy %s\n", phy_name);
> 
> Same here.
> 
>> +		}
>>   	}
>>   
>>   	return 0;
> 
>> @@ -1892,9 +1975,12 @@ static int dwc3_read_port_info(struct dwc3 *dwc)
>>   
>>   	dev_dbg(dwc->dev, "hs-ports: %u ss-ports: %u\n",
>>   			dwc->num_usb2_ports, dwc->num_usb3_ports);
>> -
> 
> Drop this random change.

The removal of extra line here done you mean ?

> 
>>   	iounmap(base);
>>   
>> +	if ((dwc->num_usb2_ports > DWC3_MAX_PORTS) ||
>> +		(dwc->num_usb3_ports > DWC3_MAX_PORTS))
> 
> Again, continuation lines should be indented at least two tabs further.
> 
>> +		return -ENOMEM;
>> +
>>   	return 0;
>>   }
> 
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index 2ea6df7e6571..fc5d15edab1c 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -33,6 +33,9 @@
>>   
>>   #include <linux/power_supply.h>
>>   
>> +/* Number of ports supported by a multiport controller */
> 
> 	/*
> 	 * Maximum number of ports currently supported for multiport
> 	 * controllers.
> 	 */
> 
>> +#define DWC3_MAX_PORTS 4
>> +
>>   #define DWC3_MSG_MAX	500
>>   
>>   /* Global constants */
>> @@ -1029,8 +1032,8 @@ struct dwc3_scratchpad_array {
>>    * @usb_psy: pointer to power supply interface.
>>    * @usb2_phy: pointer to USB2 PHY
>>    * @usb3_phy: pointer to USB3 PHY
>> - * @usb2_generic_phy: pointer to USB2 PHY
>> - * @usb3_generic_phy: pointer to USB3 PHY
>> + * @usb2_generic_phy: pointer to array of USB2 PHY
>> + * @usb3_generic_phy: pointer to array of USB3 PHY
> 
> s/PHY/PHYs/
> 
>>    * @num_usb2_ports: number of USB2 ports
>>    * @num_usb3_ports: number of USB3 ports
>>    * @phys_ready: flag to indicate that PHYs are ready
> 
> Johan

Thanks for the review. Will fix these nits in v14.

Regards,
Krishna,
