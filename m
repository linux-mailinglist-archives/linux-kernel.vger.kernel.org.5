Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08D4786AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbjHXI7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236579AbjHXI6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:58:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081F31727;
        Thu, 24 Aug 2023 01:58:52 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37O63rFV025981;
        Thu, 24 Aug 2023 08:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gHdyZeG87X895a3aglv9dRjjx9IUVgwM4dSRPE/fqZI=;
 b=HpeWWphI+o7GORFunklWxnV4Lpy4fo/Lk7S8dRYkYQW/7Y1aUxWvyB2L6Fq8LQ3m8V0r
 oqAsjYHd/Rrz0n4ZY/tDsIxXQo8tW3+69NTSz17XnEBa2WO8TFDjMby4FyjSf4sHRL5g
 eIDkTDRmvSnShipLZzAo12x3Bxtsae0fjQIdD4CUVSj9OEltdeluTjP/J1TuBNwfRte8
 4IBf8TrCpsTbGEzlosTdyThsod4knFxFERor/Z9J8oViPYgy+GSQ01BR0EyynUcGyLO7
 tdgrjJH51LR3HSTbn5XJdDuJqLnFO46TTJyoBUyw0wJc617nX2/cDPM1AZkTc/wNgXB1 /g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sp1k9gau9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 08:58:46 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37O8wjoV028782
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 08:58:45 GMT
Received: from [10.216.13.16] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 24 Aug
 2023 01:58:40 -0700
Message-ID: <3bdc4c6b-2fb9-bcdb-934c-350b7056a4e4@quicinc.com>
Date:   Thu, 24 Aug 2023 14:28:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/6] soc: qcom: Add LLCC support for multi channel DDR
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230810061140.15608-1-quic_kbajaj@quicinc.com>
 <20230810061140.15608-5-quic_kbajaj@quicinc.com>
 <a663ea2c-4724-20b3-628e-8831b6989655@linaro.org>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <a663ea2c-4724-20b3-628e-8831b6989655@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HvGRlmHebrBFzehXO1_LUm_RUAfKuPnl
X-Proofpoint-ORIG-GUID: HvGRlmHebrBFzehXO1_LUm_RUAfKuPnl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_06,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxlogscore=594
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308240071
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/2023 6:02 PM, Bryan O'Donoghue wrote:
> On 10/08/2023 07:11, Komal Bajaj wrote:
>> +    ret = nvmem_cell_read_u8(&pdev->dev, "multi-chan-ddr", cfg_index);
>> +    if (ret == -ENOENT || ret == -EOPNOTSUPP) {
>> +        if (num_config != DEF_NUM_CFG)
>> +            return -EINVAL;
>
> In other words if multi-chan-ddr is not present in the dts and the 
> num_config != 1 return -EINVAL
>
> You can just as easily say if (num_config > 1) and drop the define 
> from this code.

Sure, will make the suggested changes.

>
>> +        *cfg_index = DEF_NUM_CFG - 1;
>> +        return 0;
>
> *cfg_index = 0;
>
> For example if #define DEF_NUM_CFG 0x20 then taking the last index of 
> it would be 100% wrong.
>
> Please kill that define.

Will remove the macro.

>
> ---
> bod

