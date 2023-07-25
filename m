Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85519760978
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjGYFkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjGYFkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:40:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1241F199F;
        Mon, 24 Jul 2023 22:40:17 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P4nfHU031536;
        Tue, 25 Jul 2023 05:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=COHe3LDQmKpdXE+KtpoZP+UYF9boMe2h9XYUp/wFUqQ=;
 b=nq3qhNIl7biaBeGfWRBY9mfCAJp/lKel2R4hMmwPJQDgwul1kSaJDcZY9miIOlS4cRmV
 TPf9xByVXcrcCNVZIh71WkFgBfcBa4TZ+C3MT7aSOQCdVzi3KU6MXC/J5ylIcCSYjLiZ
 RnxEXVvEjad5EKICdPb03+ZMdHuwXukEsjHIROKyq5SwYB4JbS1vXcoSbh30FiB5CPRw
 cefCodLe/0lFtd+3NVqZJyRdAFsLdO145PRtyeKluq4I9SmqRc9yXBZqG9TQFfKvdR1o
 Twjl7sdKIRffwowzua4tyHcpVcbQ6lrdq3a9oW89Lnu0wORJM4ak4R/Kpjfer8sIwmfQ sQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1y6m0yjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 05:40:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P5e6Wm000543
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 05:40:06 GMT
Received: from [10.216.16.76] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 24 Jul
 2023 22:40:00 -0700
Message-ID: <abdd4284-948d-b03d-7b60-cca0229457dc@quicinc.com>
Date:   Tue, 25 Jul 2023 11:09:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v9 03/10] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
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
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>, <quic_shazhuss@quicinc.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-4-quic_kriskura@quicinc.com>
 <ZJrL5SXrSiYbvq2o@hovoldconsulting.com>
 <e225fa01-c3be-8bfc-03de-59b507c70d3b@quicinc.com>
 <ZL6bvQkBUsFErpXd@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZL6bvQkBUsFErpXd@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2BVdpLFSNGIWtpYPBLCraSCJkGIZz3Nw
X-Proofpoint-ORIG-GUID: 2BVdpLFSNGIWtpYPBLCraSCJkGIZz3Nw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_02,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=840 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250050
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/2023 9:11 PM, Johan Hovold wrote:
> [ Please remember to trim your replies. ]
> 
> On Sun, Jul 23, 2023 at 08:29:47PM +0530, Krishna Kurapati PSSNV wrote:
>> On 6/27/2023 5:15 PM, Johan Hovold wrote:
>>> On Wed, Jun 21, 2023 at 10:06:21AM +0530, Krishna Kurapati wrote:
> 
>>>> +#define XHCI_EXT_PORT_MAJOR(x)	(((x) >> 24) & 0xff)
>>>> +#define XHCI_EXT_PORT_MINOR(x)	(((x) >> 16) & 0xff)
>>>> +#define XHCI_EXT_PORT_COUNT(x)	(((x) >> 8) & 0xff)
>>>
>>> Again, don't copy defines from xhci.
>>>
>>> Looks like these should be moved to the xhci-ext-caps.h header along
>>> with struct xhci_protocol_caps.
>>
>> Moving the defines would be sufficient right ? Just wanted to know if
>> there is any reason you are suggesting to move the structure as well so
>> that I can update commit text accordingly.
> 
> The defines are used for parsing the members of struct
> xhci_protocol_caps and they belong together even if no driver has
> apparently ever used the structure.
Hi Johan,

Thanks for the suggestions. Will push out v10 today.

Regards,
Krishna,
