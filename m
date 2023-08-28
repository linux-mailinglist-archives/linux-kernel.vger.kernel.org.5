Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBB278A906
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjH1JhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjH1JhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:37:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B12113;
        Mon, 28 Aug 2023 02:37:02 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37S8xYY0003697;
        Mon, 28 Aug 2023 09:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FZlRFk85xm5SzVZnUHE/P5SR7tD1zBGbVkLxHkbTQsg=;
 b=gc6iMnSWr0my6EW2XOO5yiB0txWrSEhrMlwaL+wsggBJzkl1kmujxFgIa8Jr2xITP+SG
 vSS40DVwadOHH70zJVkGuymYLic/47IV+VcPHJlg3CuC2/AcCSuQeI+KiXA/l8ZuKErI
 riaak9FQHKYo2xh4kqiQM5cjhm4IeJBsa0TvBQoh5FSTZ4vqtlUNwo/H7/uIAsVXz66c
 n+2SK/6aDMPC4ow0N+NgQ07jc1/Drjn7t2Ctubia8IbOK4OicDI5M0zABBnFbizHA0s1
 3Z9Y67MJzH68cgcXd+qYkQNX/AAXlYn4vLCZjeTeJIuQgpu03geEcGNoNLCvnBb/hyMT +Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sq9sdk18c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 09:36:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37S9aLhV003810
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 09:36:21 GMT
Received: from [10.217.198.224] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 28 Aug
 2023 02:36:18 -0700
Message-ID: <09d89b1c-8c78-7671-a385-99c6a8910fde@quicinc.com>
Date:   Mon, 28 Aug 2023 15:06:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] irqchip/qcom-pdc: don't read version register if it
 is not available
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20230825213552.1646321-1-dmitry.baryshkov@linaro.org>
Content-Language: en-US
From:   "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
In-Reply-To: <20230825213552.1646321-1-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ab9yEwWZFUr1Bf8RYWr4nubiUf-rs9Np
X-Proofpoint-ORIG-GUID: ab9yEwWZFUr1Bf8RYWr4nubiUf-rs9Np
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_06,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 clxscore=1011 mlxlogscore=643 mlxscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280087
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

This patch may be useful if there was a case where some PDCs don't have 
version register populated/available,
In all PDC versions, version register is always available but due to reg 
size not good enough in device tree for SM8150 it failed to read.

reg size in device node must be expanded if its too small to access all 
registers and i think
additional check in driver to check if size is good enough would not be 
of much use.

Thanks,
Maulik

On 8/26/2023 3:05 AM, Dmitry Baryshkov wrote:

> On Qualcomm SM8150 the PDC resource has size 0x400. When PDC driver
> tries to read the version register (0x1000), it reads past the end of
> this resource, causing kernel crash.
>
> Check the size of PDC resource before reading the PDC_VERSION register.
>
> Fixes: bc82cc42644b ("irqchip/qcom-pdc: Add support for v3.2 HW")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
