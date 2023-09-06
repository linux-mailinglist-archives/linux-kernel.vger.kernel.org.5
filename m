Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D57A79351E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 08:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbjIFGHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 02:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjIFGHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 02:07:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3577BCFD;
        Tue,  5 Sep 2023 23:06:54 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3865vbwW013568;
        Wed, 6 Sep 2023 06:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qxr42ql5aMOpWgX1vEbk5lPxZtcSCxMRPwV05h/mT2g=;
 b=igklol5UJkSg98XbuwZerz83gMzh1L/j77E8RYJ2uueL/BzfLxsBllaFI1MdwoZ+ngdX
 L6OU0rhEfsqVAXOJvYtsNMfPrSdIcopmATISiFbI2DBV3Jqn1m+0XNzWs5uTpBiYn0FU
 34XeYKRCxmA+pRAP2XU2Ygmxt3aOIL/yxBE/WdIduNcRt0Vf5/MTpm7tpbAmdqRi4TNg
 /RRs/7kxpmMnFhCtIyLVnaSrY30g3HhVNFgEGUAr/7IkDtykV7yXhBe6oYnRYdRdyB0T
 PmdU1583NQNgRL/G5p49ncf5oePO0xgV9RCX5xBoGS+TjR7fu2gabys/OoNUhJFtdhc7 5A== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxhbhg988-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 06:06:40 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38666dNX015213
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Sep 2023 06:06:39 GMT
Received: from [10.216.33.5] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 5 Sep
 2023 23:06:34 -0700
Message-ID: <5aa663df-1182-4481-920b-8792f00ee046@quicinc.com>
Date:   Wed, 6 Sep 2023 11:36:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/4] clk: qcom: branch: Add mem ops support for branch2
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
References: <20230808051407.647395-1-quic_imrashai@quicinc.com>
 <20230808051407.647395-3-quic_imrashai@quicinc.com>
 <cb32b5abb9fbe13fb82d906b37908276.sboyd@kernel.org>
From:   Imran Shaik <quic_imrashai@quicinc.com>
In-Reply-To: <cb32b5abb9fbe13fb82d906b37908276.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jdYxSRQv35OUq7JhHSx1xSh2FJzbAiK2
X-Proofpoint-ORIG-GUID: jdYxSRQv35OUq7JhHSx1xSh2FJzbAiK2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=924 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060052
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/23/2023 12:22 AM, Stephen Boyd wrote:
> Quoting Imran Shaik (2023-08-07 22:14:05)
>> diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
>> index 0cf800b9d08d..0ffda6bef00e 100644
>> --- a/drivers/clk/qcom/clk-branch.h
>> +++ b/drivers/clk/qcom/clk-branch.h
>> @@ -24,8 +24,11 @@
>>   struct clk_branch {
>>          u32     hwcg_reg;
>>          u32     halt_reg;
>> +       u32     mem_enable_reg;
>> +       u32     mem_ack_reg;
>>          u8      hwcg_bit;
>>          u8      halt_bit;
>> +       u8      mem_enable_ack_bit;
>>          u8      halt_check;
>>   #define BRANCH_VOTED                   BIT(7) /* Delay on disable */
>>   #define BRANCH_HALT                    0 /* pol: 1 = halt */
> 
> I suspect making a wrapper around struct clk_branch would be a better
> approach so that we don't bloat all the other clk_branch structures that
> exist in the qcom clk drivers.
> 
>   $ git grep 'struct clk_branch' -- drivers/clk/qcom | wc -l
>     6357
> 
> How many of these are going to be using these new registers? It may also
> make sense to do that for hardware clock gating as well, but I'm not
> really sure. Anyway, the idea is
> 
> 	struct clk_mem_branch {
> 		u32 enable_reg;
> 		u32 ack_reg;
> 		u8  ack_bit;
> 		struct clk_branch branch;
> 	};
> 
> and then a container_of define. Plus, you can put some comment above the
> structure to describe when these clks are used.

Sure, will use the approach mentioned above and push the next series.

Thanks,
Imran
