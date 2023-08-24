Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADC0786AD5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbjHXI5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236353AbjHXI5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:57:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F6C10D3;
        Thu, 24 Aug 2023 01:57:20 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37O6GnDb019400;
        Thu, 24 Aug 2023 08:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HXdRR3xVYZTemP/v5/O0iPiBXK3LfikLy6SU21yXpTA=;
 b=YfeYjBjoJXNpSsrQQDedYANgFxzx8xiiExveoUWtJqEEYg0lQMeUrT+SDJjY/+wBLgeb
 4+Flp7lw4+x+rSQyX8k0XiXxly0Ioo5euvY23RFj/jK0QwQSfLzthWcDYq8pTfDsN5g8
 qGVcYnTLch2CNRSX5lLIoxp5BrZ+jdgPSQACGkRXIdT4ARj2BbcE5ShYbgnQU+eCuSHR
 +1VVCef4/bGtJP1phfKWaQb5Ee6KjUKj/Z1dkrDoTZVr7hfyUg2gTP1kQqwv7ce61pAU
 7DYOY8HGeRDigxrtyykx3CfOaVvryDXGcjLwWsFLP0ktiTlIFCJwSBlcuy1tkQ3CEJNU 2Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sp1k9garb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 08:57:09 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37O8v8J5024410
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 08:57:08 GMT
Received: from [10.216.13.16] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 24 Aug
 2023 01:57:03 -0700
Message-ID: <7abb9a41-a66f-a20a-1cd9-bfc18a2161da@quicinc.com>
Date:   Thu, 24 Aug 2023 14:26:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/6] soc: qcom: llcc: Refactor llcc driver to support
 multiple configuration
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230810061140.15608-1-quic_kbajaj@quicinc.com>
 <20230810061140.15608-3-quic_kbajaj@quicinc.com>
 <79ccb7c0-dc4b-87a7-3721-488f3ef3b192@linaro.org>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <79ccb7c0-dc4b-87a7-3721-488f3ef3b192@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sHegNJ9AJBLfsiuQDnCFkIOurQUTSzzK
X-Proofpoint-ORIG-GUID: sHegNJ9AJBLfsiuQDnCFkIOurQUTSzzK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_06,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 spamscore=0 mlxlogscore=750
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



On 8/10/2023 5:52 PM, Bryan O'Donoghue wrote:
> On 10/08/2023 07:11, Komal Bajaj wrote:
>> +    if (!cfgs || cfgs->num_config != DEF_NUM_CFG) {
>> +        ret = -EINVAL;
>> +        goto err;
>> +    }
>> +    cfg = &cfgs->llcc_config[DEF_NUM_CFG - 1];
>
> This is a bit of a redundant check.
>
> You add in the check for num_config != 1, then deref llc_config[0] but 
> in patch #4 you get an index and check that index against num_config

Hi Bryan, Thanks for reviewing the patch.
Correct, in patch#4, index is checked against num_config, but the 
condition also checks for equality case.
For ex. in patch#6, num_config is 4, so index can vary from 0-3.

>
> I'm not seeing how at this point in your series, how num_config could 
> be anything other than 1.
>
> I'd do away with the DEF_NUM_CFG define in this code/series completely.
>
> num_config should encode all the necessary detail we need, DEF_NUM_CFG 
> just adds noise.

Got your point, will remove the macro DEF_NUM_CFG from the series.

Thanks
Komal

>
> ---
> bod

