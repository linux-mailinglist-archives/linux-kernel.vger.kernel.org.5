Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3ED76A4FA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjGaXrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjGaXq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:46:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AF1E7C;
        Mon, 31 Jul 2023 16:46:55 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VNQIT8014107;
        Mon, 31 Jul 2023 23:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HE87F8f+rEZfMqN7IxCafKBAXA6f/kM48CtBdJPVbO0=;
 b=ORmvvi4eC6yrctwqeQcRkTxcMDLpxRlEdTzbVuhaeDYRcsms6Yi8nfbaERNo7TtFE7/m
 mzjMaF30bOOzzSyhqwXFkndO/BoOLRC/+/assGreQXbfeHB8UmWtxUnsXJEur8G/fPRy
 qaVbtrNo7RalQNYNLoVOojdGYd2KN2fW14iSlnYwjkqKgFI1VpbpZ6AHkZLD+nYPwIBp
 p02OLYtH8h7wwUwWBPxVK/l5HNUKR9FID4465yDpq0bkVGLEhKnlDNaEbqxJ8oFF64dM
 8yBZgBNB1h/EX1e4bDFXm5Pi2UoJlq1Ynh6q+xqLwKo5TEecovstw/LVC+qG6Ih6CepB ig== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6a2va8y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 23:46:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36VNknUg004568
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 23:46:49 GMT
Received: from [192.168.142.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 16:46:48 -0700
Message-ID: <71460c5f-2aac-67b0-3779-d748f9e512aa@quicinc.com>
Date:   Mon, 31 Jul 2023 16:46:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] soc: qcom: aoss: Move length requirements from caller
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alex Elder <elder@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
References: <20230731041013.2950307-1-quic_bjorande@quicinc.com>
 <20230731041013.2950307-2-quic_bjorande@quicinc.com>
 <e4592feb-3878-b0eb-61e4-fb6dfc358e1a@quicinc.com>
 <20230731231014.GI1428172@hu-bjorande-lv.qualcomm.com>
From:   Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <20230731231014.GI1428172@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gtdIssoZJu70iXyKmnIHOTRi2T8Zb4Oc
X-Proofpoint-GUID: gtdIssoZJu70iXyKmnIHOTRi2T8Zb4Oc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_16,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/2023 4:10 PM, Bjorn Andersson wrote:
> On Mon, Jul 31, 2023 at 02:29:44PM -0700, Chris Lew wrote:
>>
>>
>> On 7/30/2023 9:10 PM, Bjorn Andersson wrote:
>>> diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
>>>    	/* The message RAM only implements 32-bit accesses */
>>>    	__iowrite32_copy(qmp->msgram + qmp->offset + sizeof(u32),
>>> -			 data, len / sizeof(u32));
>>> -	writel(len, qmp->msgram + qmp->offset);
>>> +			 buf, sizeof(buf) / sizeof(u32));
>>> +	writel(sizeof(buf), qmp->msgram + qmp->offset);
>>
>> Looks like we are telling the firmware the packet size will always be
>> QMP_MSG_LEN?
>>
>> This should be ok but might be a problem when debugging. The AOSS firmware
>> only logs size of the message instead of the full string because of memory
>> constraints.
>>
> 
> Until now ipa_power_retention() has been passing 36 here, everyone else
> 64, so it is ok.
> 
>> We would normally match the firmware and host logs based on size, but won't
>> be able to differentiate this way with a fixed size.
> 
> I don't mind us changing it to ALIGN(len, 4), but as that would change
> the current behavior I'd like to do so in a subsequent patch.
> 
> Speaking of behavior, is 64 the max message size? We inherited the 64
> from the initial downstream implementation, but qmp->size is quite a bit
> bigger.
> 

The max message size the firmware can handle is 0x64, so 100 bytes, but 
I haven't seen any messages go above 64 bytes.

> Regards,
> Bjorn
