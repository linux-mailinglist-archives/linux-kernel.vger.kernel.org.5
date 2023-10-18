Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C587CD9E3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjJRK5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjJRK5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:57:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2643127;
        Wed, 18 Oct 2023 03:57:26 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39I66CgB002721;
        Wed, 18 Oct 2023 10:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+9G1rNi8ZKoIo5cxQUMpLRREI2HWckZiGdh4LMt+5qw=;
 b=ODolELWfZ3qxcSG44Qt3wFm58qc2uiXDlycgCHQFKuuRpHoDj4pRtyROy7F5ZtoKzsqf
 GDRJqs3ytQMrsoO7BVMpwNOg2M69/H8MHO84qnpSomjHP/nP0d67/4DSEqTtWIcif1fD
 T6ZwVyVjG9/qMzI8npngokDoMYxj0tyTvXZK8Bdoll7rKyw70FpSNjIWC6DYFZLrP9um
 gd17jmGe2d5/zXAzvpghdrYr/rb4rrvX5KQ5LYXquUq4mtG7XTEf0XkiZ4rjxA9LmxUQ
 uaTCR7iy3W/iMqJr5JUr2eGhiPHmB5GZK7sdGiMHkGbHkytsFWR6h/K7DMaZUMzOSe5J MA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsvxwtar8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 10:57:23 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39IAvM70028480
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 10:57:22 GMT
Received: from [10.216.39.143] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 18 Oct
 2023 03:57:17 -0700
Message-ID: <4aba7e8e-f130-dc03-b64d-126b8b87dc27@quicinc.com>
Date:   Wed, 18 Oct 2023 16:27:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V2 2/4] clk: qcom: branch: Add mem ops support for branch2
 clocks
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20231011090028.1706653-1-quic_imrashai@quicinc.com>
 <20231011090028.1706653-3-quic_imrashai@quicinc.com>
 <9888cc31bca1e1e148e3a0e4be4a0b5d.sboyd@kernel.org>
From:   Imran Shaik <quic_imrashai@quicinc.com>
In-Reply-To: <9888cc31bca1e1e148e3a0e4be4a0b5d.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DUAASrMmlY-zPGf6TmyDWr04ojfLzoAd
X-Proofpoint-ORIG-GUID: DUAASrMmlY-zPGf6TmyDWr04ojfLzoAd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_09,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180090
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/2023 1:54 AM, Stephen Boyd wrote:
> Quoting Imran Shaik (2023-10-11 02:00:26)
>> diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
>> index fc4735f74f0f..9ac8d04b425a 100644
>> --- a/drivers/clk/qcom/clk-branch.c
>> +++ b/drivers/clk/qcom/clk-branch.c
>> @@ -134,6 +135,42 @@ static void clk_branch2_disable(struct clk_hw *hw)
>>          clk_branch_toggle(hw, false, clk_branch2_check_halt);
>>   }
>>   
>> +static int clk_branch2_mem_enable(struct clk_hw *hw)
>> +{
>> +       struct clk_mem_branch *mem_br = to_clk_mem_branch(hw);
>> +       const char *name = clk_hw_get_name(&mem_br->branch.clkr.hw);
>> +       u32 val;
>> +       int timeout = 200, ret;
> 
> const int timeout?
> 

Will drop the timeout as per Konrad's review comment and pass the int 
literal.

>> +
>> +       regmap_update_bits(mem_br->branch.clkr.regmap, mem_br->mem_enable_reg,
>> +                       mem_br->mem_enable_ack_bit, mem_br->mem_enable_ack_bit);
>> +
>> +       ret = regmap_read_poll_timeout(mem_br->branch.clkr.regmap, mem_br->mem_ack_reg,
>> +                       val, val & mem_br->mem_enable_ack_bit, 0, timeout);
> 
> The 'mem_br->branch' is used a few times so please make another local
> variable for that called 'branch'.
> 
>> +       if (ret) {
>> +               WARN(1, "%s mem enable failed", name);
> 
> Needs a newline on the message string.
> 

Sure, will update this in the next series.

>> +               return ret;
>> +       }
>> +
>> +       return clk_branch2_enable(hw);
>> +}
>> +
>> +static void clk_branch2_mem_disable(struct clk_hw *hw)
>> +{
>> +       struct clk_mem_branch *mem_br = to_clk_mem_branch(hw);
>> +
>> +       regmap_update_bits(mem_br->branch.clkr.regmap, mem_br->mem_enable_reg,
>> +                                               mem_br->mem_enable_ack_bit, 0);
> 
> Please add a newline here.
> 

Sure.

Thanks,
Imran

>> +       return clk_branch2_disable(hw);
>> +}
>> +
