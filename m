Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824DE77C060
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjHNTHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjHNTH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:07:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDBB10FA;
        Mon, 14 Aug 2023 12:07:23 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EGdsPc002700;
        Mon, 14 Aug 2023 19:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ecaR+c9Q+E7EA3RErR5yGANZ+wUKh7X7Dg5uAxghj8s=;
 b=GFXOL1v44UyvKa9t4RAmRb4y+TNMxzw1t6W8r3CcWB1CZdRNJHqRu0t38/Gww+GM+lM8
 7X98xdYvjOg3wmDrYOQtXiH6f9/+nFjNbBuY9x6sgX4FN7lX6QOZkQ80XFtnj4wMIxAP
 WWBfUGy8ON0DsmyWO4thMPkypV+ojuMpu2uFGmvxp7w5F/pBczlk9frGg02+CTsBOwR7
 oKotgFZBvyT4ge4IjLBhHVS0IF1ZCzUsg5+67N0sc9Io1o1r/cYhLwHzQTWxtr8k1b+U
 SmaafBeZBno3wrgrQatrA4XFM+zOuQEqGgchAjAWboIGtCmm1JZWr4oVDYKqihgf5Qv2 JA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3gn4qph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:07:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EJ7C0h015795
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:07:12 GMT
Received: from [10.50.35.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 14 Aug
 2023 12:07:08 -0700
Message-ID: <f8df76c6-02a5-15aa-5743-e3eee9b88ef4@quicinc.com>
Date:   Tue, 15 Aug 2023 00:37:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 12/33] iris: vidc: add helper functions for resource
 management
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>,
        <hans.verkuil@cisco.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-13-git-send-email-quic_vgarodia@quicinc.com>
 <f95fa8c8-1794-fcbc-809d-62bfcc667822@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <f95fa8c8-1794-fcbc-809d-62bfcc667822@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: o8D5TqJDqaqYMcVQl2ogYeUjOlq5wwnl
X-Proofpoint-GUID: o8D5TqJDqaqYMcVQl2ogYeUjOlq5wwnl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 mlxlogscore=647 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140177
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2023 11:00 PM, Konrad Dybcio wrote:
> On 28.07.2023 15:23, Vikash Garodia wrote:
>> From: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>
>> This implements ops to initialize, enable and disable extrenal
>> resources needed by video driver like power domains, clocks etc.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> ---
> There's a whole bunch of kerneldoc abuses (comments should start with
> /* and not /**). Make sure you have proper spaces between single-line
> C-style comments (e.g. /*Get should be /* Get etc.)
> 
> Capitalizing the first word within the comment would be nice too.
Agree! will fix the comments in next version.
> 
> 
> Do we need a separate bus table? i.e. does it make sense to adjust the
> bandwidth values separately from the clock rates?

Yes, we do need to vote for bus bandwidth separately hence separate bus
table is required.
> 
> Do you think there will be more than one set of msm_vidc_resources_ops?
> Perhaps it'd make sense to drop that layer of abstraction if not. Many
> function names could drop the __ prefix.
> 
> A whole bunch of d_vpr_h seem almost excessive.
Sure, all custom debug wrappers will be removed in next version
> 
> MSM_VIDC_CLKFLAG_* are unused.
> 
Thanks for pointing it, will remove in next version.

Thanks,
Dikshita
> Konrad
