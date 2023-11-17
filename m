Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396C07EEC85
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 08:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjKQHQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 02:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQHQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 02:16:33 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF454194;
        Thu, 16 Nov 2023 23:16:30 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH6eQuk011693;
        Fri, 17 Nov 2023 07:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=i1ovUif6eJCX2viZU9GHW5+dl22Rd3wZG3iOri/yqjw=;
 b=bzoedOpd3EVcAooCyf4/qwHtrph7lYmr4U3Qa9BgRteSfQrddJ9E4ITt0+6ZPD7mhKQh
 rgEfVnWbE9dAu0UVTSVAgsTee3l2Zn5BKDKtucnuzcVieUQ9+877aIvgmLXSfqdGBf3z
 ITUt+pxHBamsXUI00AtEhvTGxA+NbMv9Sex3iQIitnp99aQBpMYTXK3SxVZNKlo8yD5E
 imWfa7GDcO/wd9qSMzbheF7vXETgvvbw817TI4w3O5R1Tglw4PPeN3GGW7s6w+dUh9yz
 JWdPBRumWLVtm83qX0i6neORaYc8AL7x0TdIg4w1ZEP+0wHclYMunstX3huAb8OHJIKR Rg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udt8bs1a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 07:16:05 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AH7G4Yj032531
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 07:16:04 GMT
Received: from [10.214.227.50] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 16 Nov
 2023 23:15:59 -0800
Message-ID: <dab82933-4383-4277-9cff-90cba6231b54@quicinc.com>
Date:   Fri, 17 Nov 2023 12:45:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] iommu/arm-smmu: re-enable context caching in smmu
 reset operation
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>,
        <dmitry.baryshkov@linaro.org>, <a39.skl@gmail.com>,
        <quic_pkondeti@quicinc.com>, <quic_molvera@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <qipl.kernel.upstream@quicinc.com>
References: <20231114135654.30475-1-quic_bibekkum@quicinc.com>
 <20231114135654.30475-4-quic_bibekkum@quicinc.com>
 <e5b0d8c7-82cf-4a3a-9a6e-28e7b468df8d@linaro.org>
From:   Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <e5b0d8c7-82cf-4a3a-9a6e-28e7b468df8d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: T1UlbemtRDwpaktjWt03nFsUnxAG5Iyq
X-Proofpoint-GUID: T1UlbemtRDwpaktjWt03nFsUnxAG5Iyq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_05,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 mlxlogscore=778 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311170051
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/2023 10:13 PM, Konrad Dybcio wrote:
> 
> 
> On 11/14/23 14:56, Bibek Kumar Patro wrote:
>> Context caching is re-enabled in the prefetch buffer for Qualcomm SoCs
>> through SoC specific reset ops, which is disabled in the default MMU-500
>> reset ops, but is expected for context banks using ACTLR register to
>> retain the prefetch value during reset and runtime suspend.
>>
>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>> ---
> And I assume that goes for all SMMU500 implementations?
> 

Right, for all SMMU500 implementation for Qualcomm SoCs.
Hence implemented this enablement with Qualcomm specific reset operation.

> Looking at the 8550 ACTRL array from patch 2, CPRE is not enabled
> at all times.. Is that because of performance, or some other
> technical reason?
> 
> Will this regress platforms without ACTRL tables?
> 

It should not regress, If you check my recent reply on Dimitry's
response, the Corelink revision is r2p4 and it can be enabled.
On the Robin's mentioned errata workarounds, let me check once.

Thanks & regards,
Bibek

> Konrad
