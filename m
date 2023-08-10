Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0682C777B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbjHJPEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjHJPEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:04:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2978C2686;
        Thu, 10 Aug 2023 08:04:33 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AALjq9021976;
        Thu, 10 Aug 2023 15:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TK76T8JsuQV42EmOYZCZFwEvmN0wbaC53CusTjApZOo=;
 b=DXQlG2znAcULfBWopl2byj6nzFXGpD366to0hTbkIHfV9dTvr/IkL/XLJvlCC8v2l7XE
 fWLeBCMK/rUnyo8KEwwTSnxUSpxiDcmr8dPzz7kWWVgh9fofcYc21TX6bIetyWql8oCB
 4nadcL60/5PAJEVpMK8iifRct2LI2sbvd6iV4jeyrsd99E8PsDmp7+HZ+VVATrePQwdm
 G+fMM4GRAYEFE3NCk2sRuSuJAk+YrJ0fRdVb3Wt5KVvRFsB32pF0bI89XoH+MtQZIbCu
 yQaSNjoQkr5Z4+BNKWlbRWLzV4qZC8Bq9pu6AOvYEt8zxBmyGKRCWty5VssnlU9Bs0b3 9A== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3scr39hdbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 15:04:29 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37AF4SwC028561
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 15:04:28 GMT
Received: from [10.216.45.127] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 10 Aug
 2023 08:04:24 -0700
Message-ID: <54d108d9-abfc-6b8e-7c1a-c93eef265575@quicinc.com>
Date:   Thu, 10 Aug 2023 20:34:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/6] soc: qcom: llcc: Refactor llcc driver to support
 multiple configuration
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230810061140.15608-1-quic_kbajaj@quicinc.com>
 <20230810061140.15608-3-quic_kbajaj@quicinc.com>
 <79ccb7c0-dc4b-87a7-3721-488f3ef3b192@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <79ccb7c0-dc4b-87a7-3721-488f3ef3b192@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SFqwyGv90PO2KqXVPSq6LP3y4IXeYjhS
X-Proofpoint-ORIG-GUID: SFqwyGv90PO2KqXVPSq6LP3y4IXeYjhS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=719 clxscore=1011 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100128
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

I would take this blame on me to suggest this..,but i was trying to
avoid the hard-coding initially done for [1], now, num_config[2]
converted to ARRAY_SIZE(), i find no harm in checking
cfgs->num_config >  DEF_NUM_CFG
since, anyways it will move to different function in #4.

[1]
https://lore.kernel.org/lkml/39b4bafd-410f-cae8-13ae-e18d751b51a2@quicinc.com/

[2]
.num_cfgs	= 1,

-Mukesh
> 
> I'm not seeing how at this point in your series, how num_config could be 
> anything other than 1.
> 
> I'd do away with the DEF_NUM_CFG define in this code/series completely.
> 
> num_config should encode all the necessary detail we need, DEF_NUM_CFG 
> just adds noise.
> 
> ---
> bod
