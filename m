Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F327D251A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 20:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjJVSEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 14:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVSEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 14:04:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DB3EB;
        Sun, 22 Oct 2023 11:04:29 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39MHrXnN017932;
        Sun, 22 Oct 2023 18:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=r6WaxMpdUmwjwDPCw6l+Jo0VHXva34qXWZID+ugfozw=;
 b=ZzSBwl6LR2VQfRx+qnLQQ48MIB6Rujy3XJksRbjTXUQJIxoEl26ktUnFTGcnS8SjWmwz
 bc3xzgXABH1gi9wqQtLSvCQuo+p+1HiMK/381jM1ga5iH3fTA953edA7CTK82g0rLRi8
 JgkkOa0+DrrKREtiyiAPdSAJlo7xoPlx8xpp7Itqs58mJ7o7U3VZVA0mG/Jnm4e1WnRR
 5x4D7/HRHESO8EQkOQcZn2LKY7lYw3XBEpAjKGH67+9KvBjDBRZEl+GwNhDvAfeH0qDX
 Dq3Yq+k+UYtouKU5Mp0a6qs+aSvPmyPXzFl115ZbOE6b7mSa9pQaVi4dku+bedMamSBU /Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv6872drk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Oct 2023 18:04:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39MI48Si011837
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Oct 2023 18:04:08 GMT
Received: from [10.216.52.212] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 22 Oct
 2023 11:03:59 -0700
Message-ID: <257716c4-7194-4d26-a34c-fff09234628f@quicinc.com>
Date:   Sun, 22 Oct 2023 23:33:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 03/10] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
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
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZTJPBcyZ_zLXbgE5@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qXlYAIJnx-Q8i5ItSB5csTQroOf_lBIg
X-Proofpoint-ORIG-GUID: qXlYAIJnx-Q8i5ItSB5csTQroOf_lBIg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-22_15,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=697 impostorscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310220166
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

No, I think it would be appropriate to say "at least one phy (HS/SS)" as 
even one phy is sufficient to get things working.

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
This is an established term AFAIK. So I've been using it here like this.

>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202309200156.CxQ3yaLY-lkp@intel.com/
> 
> Drop these two lines, as people have already suggested.
> 
ACK.

>> Co-developed-by: Harsh Agarwal <quic_harshq@quicinc.com>
>> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
>> Co-developed-by:Krishna Kurapati <quic_kriskura@quicinc.com>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> 
> Thinh pointed out the problems with the above which were also reported
> by checkpatch.pl.
> 
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
Got it. Will be careful about such things next time.

Regards,
Krishna,
