Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AEB7CF2C1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344918AbjJSIhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbjJSIhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:37:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553A9126;
        Thu, 19 Oct 2023 01:37:34 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J7u7oQ032656;
        Thu, 19 Oct 2023 08:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WbVOwE68YZ21oWpHkUvOVrtFoR0I01uGEXEXEWCH6K0=;
 b=iK//mTTJnnDfvgt5GwLj5FkjIog9iE2QdF3/JTyZkBUQSXbmFWjmFz3TSh8VNgykItJL
 KENfncscpPJySA7KVSj8Rg5r672D59QNnIlLaWNY5kRbO+KjYR3gC9o2oI/sSuMiFZJh
 jFYEBQX3XqDqyGnxETbc36aBu+cEobmWMfL26znNjLb2I4cJwP9IPSZqi4y+ruwW71kR
 I2FgECaXf0dIu8ZzLzhF2GNHU/XbZHfRD0v9ilCjf6s0/eSSHN9XxvAPDA2DdjQ0wjaO
 JIaZpCzWXR/+UJ9SDLDTtz08iiTe9JzzLfe6vlOTzBX2qrK6b7E1KWPBmhnv4JlECLs5 Ag== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt9kju4f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 08:37:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39J8bUNk031104
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 08:37:30 GMT
Received: from [10.216.38.160] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 19 Oct
 2023 01:37:25 -0700
Message-ID: <b8fa17a7-296e-4e17-9438-a8be04dbd476@quicinc.com>
Date:   Thu, 19 Oct 2023 14:07:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/8] clk: qcom: gcc-sm8450: Keep usb30 prim gdsc on during
 runtime suspend
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>,
        Udipto Goswami <quic_ugoswami@quicinc.com>
References: <20231017131944.8356-1-quic_kriskura@quicinc.com>
 <e38ae24c09ef321c224a6b6aeb97e73b.sboyd@kernel.org>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <e38ae24c09ef321c224a6b6aeb97e73b.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -ibTTu_ICVnD7VCJyPgPnJ5w9vk8d8n4
X-Proofpoint-GUID: -ibTTu_ICVnD7VCJyPgPnJ5w9vk8d8n4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_05,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=515 spamscore=0 mlxscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/2023 6:28 AM, Stephen Boyd wrote:
> Quoting Krishna Kurapati (2023-10-17 06:19:44)
>> When runtime suspend happens in host mode, if cable is removed at this
>> instant, it triggers a resume where a xhci register access is done when
>> gdsc is not on leading to a crash. Keep usb30 prim gdsc as on during
>> runtime suspend to avoid this crash.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>> Note: I am not sure if this is the right way or setting GDSC flags to
>> PWRSTS_RET_ON is the right approach. So for now made this change to
> 
> Does using PWRSTS_RET_ON work? Does the GDSC support being turned off or
> is the lowest power state retention?

I didn't see any issue when I put it as PWRSTS_RET_ON. If the GDSC is 
off, when we remove cable in host mode, we see a crash because of xhci 
register access. But when I try putting PWRSTS_RET_ON / 
CLK_RPM_ALWAYS_ON it doesn't crash.

Regard,
Krishna,
