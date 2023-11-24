Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4117F72CB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjKXLei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKXLeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:34:36 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B246CCE;
        Fri, 24 Nov 2023 03:34:42 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOBOS1D026795;
        Fri, 24 Nov 2023 11:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vRVEH7FyUe2r0RGGbZQpVmk5oX6JLJC9ovHaN86FYHk=;
 b=p1mrNvAa1R6kCFdRla4m5dNzz1TAc3r0T4pfrsy3s3YJFXRCmwCsD3XGc8Ib7l184TAB
 rpwcefOD0JMNNTDoSpM3vLZC0lGoC/nmoaoYskacf+0kZ73jOS35GbgY95ZC+vFoq3Cf
 F8WdoUQzm4OsaDyqI/k3uuHnNk3HsfEW4bgYClTlCW306YRBUwtFRgJgLBbuw4+8oKNM
 MwOZn52VTiZRRPrFN8+d3jWqVvrBtz159aNWJ3Gkye245Lz+rlumL7DYJltcJpabKbv+
 ++7EaqE6eRTVi1t+xM2tWeGRy756MOLWHivp5WTaKS9vP+AhedUMwyWHxgwTbAKaU++o pQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uj4hwjqqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 11:34:38 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AOBYbPv016090
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 11:34:37 GMT
Received: from [10.218.19.46] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 24 Nov
 2023 03:34:32 -0800
Message-ID: <9c41d1ce-d4e7-efca-1be0-ddf296f59ac8@quicinc.com>
Date:   Fri, 24 Nov 2023 17:04:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V2 4/4] clk: qcom: videocc-sm8150: Add runtime PM support
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20231118123944.2202630-1-quic_skakitap@quicinc.com>
 <20231118123944.2202630-5-quic_skakitap@quicinc.com>
 <9710258c-3419-41f2-9b30-f818b031ae5f@linaro.org>
From:   "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
In-Reply-To: <9710258c-3419-41f2-9b30-f818b031ae5f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vyB1itvbmqZJMeEQ4qxXnHo2KRgPhvTn
X-Proofpoint-ORIG-GUID: vyB1itvbmqZJMeEQ4qxXnHo2KRgPhvTn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240089
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/23/2023 1:31 AM, Konrad Dybcio wrote:
>
>
> On 11/18/23 13:39, Satya Priya Kakitapalli wrote:
>> Add runtime PM support to ensure the supply rails are enabled
>> when necessary.
>>
>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>> ---
>> Changes since v1:
>>   - None.
>>
>>   drivers/clk/qcom/videocc-sm8150.c | 20 ++++++++++++++++++--
>>   1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/videocc-sm8150.c 
>> b/drivers/clk/qcom/videocc-sm8150.c
>> index 52a9a453a143..b57df5ff96c4 100644
>> --- a/drivers/clk/qcom/videocc-sm8150.c
>> +++ b/drivers/clk/qcom/videocc-sm8150.c
>> @@ -6,6 +6,7 @@
>>   #include <linux/clk-provider.h>
>>   #include <linux/module.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>>   #include <linux/regmap.h>
>>     #include <dt-bindings/clock/qcom,videocc-sm8150.h>
>> @@ -240,17 +241,32 @@ MODULE_DEVICE_TABLE(of, 
>> video_cc_sm8150_match_table);
>>   static int video_cc_sm8150_probe(struct platform_device *pdev)
>>   {
>>       struct regmap *regmap;
>> +    int ret;
>> +
>> +    ret = devm_pm_runtime_enable(&pdev->dev);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = pm_runtime_resume_and_get(&pdev->dev);
>> +    if (ret)
>> +        return ret;
>>         regmap = qcom_cc_map(pdev, &video_cc_sm8150_desc);
>> -    if (IS_ERR(regmap))
>> +    if (IS_ERR(regmap)) {
>> +        pm_runtime_put(&pdev->dev);
> Shouldn't this be _sync?
>

Yes, will update it on v2


> Konrad
