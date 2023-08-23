Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD1B785677
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjHWLJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbjHWLJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:09:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69711E5C;
        Wed, 23 Aug 2023 04:09:26 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37N9h1w1015825;
        Wed, 23 Aug 2023 11:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UVvMXHO/XFHx6DMXMgPPo7D24V4dCu7dna6epDKo/Ig=;
 b=gSm1t6g+HOlrm4WRS3KLzgCF3XsvYKVCPjl20bn0bLWkxqDKBZN5GPw5ls1Qs3/X1z78
 Uhz/vbCDZKnTHfsMK1UaWuMkYrGZWZFFF0CGgwDbXSs11JF51E6FFKwmZB11qlz9NTRG
 gqtKsbv3iyrO+9GGC5X5IV4IFxo195lQDlOOM+F3tLc+u7OZ25iluWUxebMIeUM5BNKv
 niVkUBIn2gQ2QsxCM6f2DXGJw5DweX7n0XHlN8dF9RaRa8M0SRLzwuwMo36jUneG/WZr
 31Uvs6EfkgqHHTrGzWiyovYhERRYMDDdGbc3dNsH/7WtTIl5ZpDCo/rMyXDTjJG7EZQY 3g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn2t41sbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 11:09:20 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37NB8qRi007848
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 11:08:52 GMT
Received: from [10.50.32.23] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 23 Aug
 2023 04:08:47 -0700
Message-ID: <39226076-0865-40fa-a7ca-fc01e450d5eb@quicinc.com>
Date:   Wed, 23 Aug 2023 16:38:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] soc: qcom: Add driver to read secondary
 bootloader (XBL) log
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC:     <psodagud@quicinc.com>, <quic_ppareek@quicinc.com>,
        <quic_kprasan@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>
References: <20230822121512.8631-1-quic_ninanaik@quicinc.com>
 <20230822121512.8631-2-quic_ninanaik@quicinc.com>
 <39ce6d07-7692-7194-b153-e73ba7fb687c@linaro.org>
 <c45b35cd-3906-442c-b99e-a6c06a0c5994@quicinc.com>
From:   Ninad Naik <quic_ninanaik@quicinc.com>
In-Reply-To: <c45b35cd-3906-442c-b99e-a6c06a0c5994@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tF8OiNja4dFdIlNTa9elMIf8syyW8ZNP
X-Proofpoint-ORIG-GUID: tF8OiNja4dFdIlNTa9elMIf8syyW8ZNP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_06,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=699 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On 8/22/2023 8:44 PM, Jeff Johnson wrote:
> On 8/22/2023 5:43 AM, Bryan O'Donoghue wrote:
>> On 22/08/2023 13:15, Ninad Naik wrote:
> ..snip..
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
>>> + */
>>
>> 2023
> 
> if this is derived work based upon existing downstream code then I 
> suspect the LF 2021 copyright is correct and should be maintained, and a
Yes, this driver is derived from an existing downstream code and hence 
2021 license is carried forward> QuIC 2023 copyright should be added
> 
Ack.

Thanks,
Ninad
