Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7363C78DF69
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244286AbjH3TZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242463AbjH3Ikg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:40:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA17B1B7;
        Wed, 30 Aug 2023 01:40:33 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U6vI00029802;
        Wed, 30 Aug 2023 08:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=71ekcuHULVbsEdIqnFr9o/2b5AzjhuE5u9KKik9CREM=;
 b=fwCKf5LHSBDwL9fakypZEcfTwWadqWelme2NzJcvHkElUfJVaGSzu72dN+KUH0ryZTnX
 vOCHN5Humh4xfx8XtNJ2U80FZNWePEUwkIP+sLgYbzWsJPZvGHw1vood/BgLgh8IOz7a
 RAXh4fjxA4D5qHw7rg9R0cC1tJfxObCrmUKupd9MlZ5Lsd3fLn34EjGUoN2IALh8sInA
 96a9NSezsUeefPGlT/5TaRvUr/vYesl6WPHLZUKJuqptlDDlD8RiSHfbYBkTkNvmZ2cv
 rmTf5ipuCuS+N98KCuhccHdqAGegM2+hlbtjCBztpmO4qSb/52wiaq83K87Jy9KW0UJZ BQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ssv008qh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 08:40:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37U8eLQv000435
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 08:40:21 GMT
Received: from [10.216.62.155] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 30 Aug
 2023 01:40:17 -0700
Message-ID: <16ae9733-3e22-db7f-56c4-47c1a55cf23c@quicinc.com>
Date:   Wed, 30 Aug 2023 14:10:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] clk: qcom: clk-rcg2: Fix wrong RCG clock rate for high
 parent frequencies
To:     Marijn Suijten <marijn.suijten@somainline.org>
CC:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_saahtoma@quicinc.com>
References: <20230720083304.28881-1-quic_devipriy@quicinc.com>
 <v2jtnqomqr3bmewtollty2wlu73ymtbobt3pd5aypprmezhow2@edrb3w3kz56b>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <v2jtnqomqr3bmewtollty2wlu73ymtbobt3pd5aypprmezhow2@edrb3w3kz56b>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6vol6wSwB92wY49cXFpnU8zPApqwJ_EE
X-Proofpoint-GUID: 6vol6wSwB92wY49cXFpnU8zPApqwJ_EE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 mlxlogscore=910 lowpriorityscore=0 phishscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300080
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/2023 12:37 AM, Marijn Suijten wrote:
> Can you retitle this to state "overflow" rather than just "wrong"?
> That's more descriptive.
> 
> E.g "Fix clockrate overflow for high parent frequencies"
Sure okay
> 
> On 2023-07-20 14:03:04, Devi Priya wrote:
>> If the parent clock rate is greater than unsigned long max/2 then
>> integer overflow happens when calculating the clock rate on 32-bit systems.
>> As RCG2 uses half integer dividers, the clock rate is first being
>> multiplied by 2 which will overflow the unsigned long max value. So, use
>> unsigned long long for rate computations to avoid overflow.
>>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   drivers/clk/qcom/clk-rcg2.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
>> index e22baf3a7112..42d00b134975 100644
>> --- a/drivers/clk/qcom/clk-rcg2.c
>> +++ b/drivers/clk/qcom/clk-rcg2.c
>> @@ -156,18 +156,18 @@ static int clk_rcg2_set_parent(struct clk_hw *hw, u8 index)
>>    *            hid_div       n
>>    */
>>   static unsigned long
>> -calc_rate(unsigned long rate, u32 m, u32 n, u32 mode, u32 hid_div)
>> +calc_rate(unsigned long parent_rate, u32 m, u32 n, u32 mode, u32 hid_div)
>>   {
>> +	u64 rate = parent_rate;
>> +
>>   	if (hid_div) {
>>   		rate *= 2;
>> -		rate /= hid_div + 1;
>> +		do_div(rate, hid_div + 1);
> 
> I'm pretty sure mult_frac() could have solved this as well, without
> temporarily going to u64?
> 
>      mult_frac(rate, 2, hid_div + 1)

Yes, sure will update
> 
>>   	}
>>   
>>   	if (mode) {
>> -		u64 tmp = rate;
>> -		tmp *= m;
>> -		do_div(tmp, n);
>> -		rate = tmp;
>> +		rate *= m;
>> +		do_div(rate, n);
> 
>      mult_frac(rate, m, n)

Will update in V2

Thanks,
Devi Priya
> 
> Or am I totally wrong?
> 
> - Marijn
> 
>>   	}
>>   
>>   	return rate;
>> -- 
>> 2.17.1
>>
