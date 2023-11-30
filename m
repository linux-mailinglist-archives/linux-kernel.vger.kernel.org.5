Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B3E7FFD7B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376945AbjK3VZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376920AbjK3VZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:25:45 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83391B4;
        Thu, 30 Nov 2023 13:25:51 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUFUed9007773;
        Thu, 30 Nov 2023 21:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SinarTaG18/Jxu/GEfEglXJrj97OXep1bjFax2ms69M=;
 b=l9RZCdSkQo3UYNI4StfM59m9Q1kcyHtypVaQ/9nb5VhyblEu763e5lN7VQxZSGtZtPwG
 VlnUOi5QfgtPdaAR26w9Vt3nws24fCCnJ6y4cuWpAmwHw2siQdIK6pgTqeAZy4OVMkv6
 GLcREX5xVd9+WPwlJql+Idz5qaAi1Iz2k1l9Ej6Wp6vmc0ocYRlRHL1vhK31xZjlc6q9
 maoQWgHThruV0rKs2j3MvYuQ5scqKepdyn8cxTMPmnLTZ2s6lQoHpUmKgEjKplrhsKU6
 wove9IjatiZsef1BGfRI6dyipy0wNrzd/v9DeYDnCYK4nNMQv9g6MXuEbz6jwBsYciAq 1g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3upbxskey7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 21:25:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AULPYBQ021634
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 21:25:34 GMT
Received: from [10.71.109.77] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 30 Nov
 2023 13:25:33 -0800
Message-ID: <7569f43e-4446-2565-57d5-d8b43e1b4a8d@quicinc.com>
Date:   Thu, 30 Nov 2023 13:25:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Freedreno] [PATCH] drm/msm/dpu: Correct UBWC settings for
 sc8280xp
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, <dri-devel@lists.freedesktop.org>
CC:     Rob Clark <robdclark@chromium.org>,
        <linux-arm-msm@vger.kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Danylo Piliaiev <dpiliaiev@igalia.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231130192119.32538-1-robdclark@gmail.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20231130192119.32538-1-robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HvwV4zuC6SWa-MIPsXEKpTOBFEiUaqzP
X-Proofpoint-GUID: HvwV4zuC6SWa-MIPsXEKpTOBFEiUaqzP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_21,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=788 lowpriorityscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300156
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/2023 11:21 AM, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> The UBWC settings need to match between the display and GPU.  When we
> updated the GPU settings, we forgot to make the corresponding update on
> the display side.
> 
> Reported-by: Steev Klimaszewski <steev@kali.org>
> Fixes: 07e6de738aa6 ("drm/msm/a690: Fix reg values for a690")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
