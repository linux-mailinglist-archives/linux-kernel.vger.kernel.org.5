Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBE37903B0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 00:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350898AbjIAWkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 18:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350908AbjIAWkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:40:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2525B8;
        Fri,  1 Sep 2023 14:55:14 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381LaaOZ032526;
        Fri, 1 Sep 2023 21:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HazOzvjlOVztOGuiiRKq62q+xU7gLIZ3wqTtkKa8RHY=;
 b=dITP7fuz6kkx4OxVTRmtdnflx3HE/Xl1jnWnkzr0ZCvZMbtdsUZ5VdBp+Z8vJEdKpG+z
 v+X0d+Z+CFQ2NItEOUsm5Wa7gXjvOayy1/WkvG47CUlxFy96ivpMGTsX2SKCYy7IKgES
 Ydluabl/AlKV3QR3DTRRYRoitpT9atjPEjqtP2Pp8HlHQGhQl1Z8kkta5Lzi56D7A40G
 oGdJFnDmCT5/zV8oW/tHrONjLfZaj6qMtK2nPpqc190027QmbLPs8TndiZp08otF+ZC8
 oK1KrRBmU0pA1jopOdg46ZNJF+3kyIEVq81uHahI8Ebie7QyhEsXF4+p8mwNE//bJmvC wg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suc22j05y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 21:54:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 381LswSP010596
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Sep 2023 21:54:58 GMT
Received: from [10.216.57.50] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 1 Sep
 2023 14:54:50 -0700
Message-ID: <565edf1c-96a5-83e3-50ce-9c328f457abf@quicinc.com>
Date:   Sat, 2 Sep 2023 03:24:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v11 06/13] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Johan Hovold" <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>,
        Harsh Agarwal <quic_harshq@quicinc.com>
References: <20230828133033.11988-1-quic_kriskura@quicinc.com>
 <20230828133033.11988-7-quic_kriskura@quicinc.com>
 <9eee5666-8bd1-9a42-53b4-6a07ccba652e@quicinc.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <9eee5666-8bd1-9a42-53b4-6a07ccba652e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7D2gvNj7QVsiB8NneCWmL1FpTADYYefn
X-Proofpoint-ORIG-GUID: 7D2gvNj7QVsiB8NneCWmL1FpTADYYefn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_19,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=817 phishscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010205
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/2023 6:43 AM, Wesley Cheng wrote:
> Hi Krishna,
> 
>>           if (dwc->usb2_phy)
>>               otg_set_vbus(dwc->usb2_phy->otg, false);
>> -        phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
>> -        phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
>> +        phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
>> +        phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
> 
> Throughout this patch, you are looping across all PHYs irrespective of 
> if we are in device mode or not.  This is the only exception where you 
> are setting only PHY index 0 (for both SS and HS PHYs).  Do you think we 
> should also only modify PHY index#0 for other PHY related sequences?
> 
Hi Wesley,

  Multiport controllers are host only capable currently. So if the 
GHWPARAMS indicate we are DRD/peripheral capable, we set 
num_usb2/3_ports to "1" unconditionally. So there would not be any 
looping necessary here.

>>           if (ret)
>> @@ -1804,9 +1887,12 @@ static int dwc3_read_port_info(struct dwc3 *dwc)
>>       dev_dbg(dwc->dev, "hs-ports: %u ss-ports: %u\n",
>>               dwc->num_usb2_ports, dwc->num_usb3_ports);
>> -
>>       iounmap(base);
>> +    if ((dwc->num_usb2_ports > DWC3_MAX_PORTS) ||
>> +        (dwc->num_usb3_ports > DWC3_MAX_PORTS))
>> +        return -ENOMEM;
>> +
> 
> Shouldn't this be more applicable to be included in patch#4 in this series?
> 
The read_port_info function was only initially intended to read only 
port count and later the macro was added. So the check was put here.

Regards,
Krishna,
