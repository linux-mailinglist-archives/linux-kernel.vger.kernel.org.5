Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B617E8030
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbjKJSHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjKJSFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:05:04 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDD32B7AE;
        Fri, 10 Nov 2023 03:09:31 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA9rahH004338;
        Fri, 10 Nov 2023 11:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AAJ2DnWw91bvf04Qt3Nf9uO+jAD3wkFbYUZX4Ih8fqM=;
 b=neeyUEPE7aZ+lfuRwu9LPRcoo/JZfjPyrAJJ2UA/YZn6JWzMOccbaTvJCIx2GpaSsYvA
 98MPeUMnEoMvp2ygR2ROpkskRdgagxOVeQ2RVAqn5AMzGesb7lhk8T1c1W8DWADTNy33
 Gy1K0+Gj04mUBX7yrLdxpjyxW82DT2KUgAPxhnmqkrgIOxx1tNRZAsHvnHRWG3+ck6gQ
 EQ3g4TBblEwM+22HbbTpCuX0wuOMu8PTLOMvrZBy/K82EdTpDMCsf9c13CXsJGiosUyN
 p+qnVUS/FyEoyHzAHpimHEiZCrimhgEd2SPYJKT5sXgS5tozCrfQi4QRZr6jhzlHVkqb FA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u8u2buf78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 11:09:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AAB9IU4018848
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 11:09:18 GMT
Received: from [10.249.28.118] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 10 Nov
 2023 03:09:10 -0800
Message-ID: <660f50a6-79e7-4b62-aad4-29453fa5b2be@quicinc.com>
Date:   Fri, 10 Nov 2023 16:39:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 05/10] usb: dwc3: qcom: Refactor IRQ handling in QCOM
 Glue driver
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>
References: <ZTY7Lwjd3_8NlfEi@hovoldconsulting.com>
 <cabf24d0-8eea-4eb5-8205-bf7fe6017ec2@quicinc.com>
 <ZTZ-EvvbuA6HpycT@hovoldconsulting.com>
 <fb5e5e1d-520c-4cbc-adde-f30e853421a1@quicinc.com>
 <ZTdqnSHq_Jo8AuPW@hovoldconsulting.com>
 <04615205-e380-4719-aff1-f32c26004b14@quicinc.com>
 <ZUz4RD3MjnLlPn6V@hovoldconsulting.com>
 <2b19b5e2-5eb0-49e0-8c47-8aff3d48f34e@quicinc.com>
 <ZU31gx-LY5GBJGPU@hovoldconsulting.com>
 <dc20ecc0-f930-49c5-9e21-5a6e4c8ce637@quicinc.com>
 <ZU4JeenAf_K8liAI@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZU4JeenAf_K8liAI@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1pLQFTu8NgxLhVqW22HR8zXXno5HtEqp
X-Proofpoint-ORIG-GUID: 1pLQFTu8NgxLhVqW22HR8zXXno5HtEqp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_07,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=721 impostorscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100090
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>>
>> While I do so, since there are no qusb2 targets present on femto phy's, do
>> you suggest we still add them to port structure in dwc3-qcom ? I am inclined
>> to add it because it would make implementation look cleaner w.r.t code and
>> also spurious interrupts are not getting triggered (which was my primary
>> concern as it was never tested).
> 
> Yes, that's what I've been suggesting all along. It's a per-port
> interrupt so that's where it belongs.
> 
> We should still try to determine when each interrupt should be enabled
> and how best to implement that (hence all my questions).
> 
> For example, if there is no use for hs interrupts on SoCs using femto
> PHYs we should fix the bindings. If we can use dp/dm on SoCs using QUSB2
> PHYs, we should probably just ignore the hs interrupt when all three are
> defined (especially since that functionality has never worked anyway).
> 

Sure. Will finalise this once I get the complete info (why do we have 
dp/dm on qusb targets)

And apologies, I mentioned "qusb2 targets on femto phy's".
It was supposed to be "hs_phy_irq's on femto phy targets", but I think 
you got the gist of my question. Thanks for the response.

Regards,
Krishna,
