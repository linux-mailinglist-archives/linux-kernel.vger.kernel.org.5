Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAEF752A83
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 20:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjGMSwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 14:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjGMSwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:52:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B5E2709;
        Thu, 13 Jul 2023 11:52:39 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DIkoAw006900;
        Thu, 13 Jul 2023 18:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=w0ZsrTSnOBfStnjIXUJ6185VAcOLGCvpnM2Umu/Mklo=;
 b=DA+YGwdDHG5Qug2ScDMBOWU+TDWDQcYA0Yy4RaZpXbSlwSsnfNhV5qNfVmroQwRiNvOS
 joD6si7BFOV4eknx0kBCrFIMcHC+dZ8ARE+Cj94txz0gXSZilfdryIoWbL4hz2LUFWpJ
 LeivQSGry+2w3+xYPMHBUPUomLCm3K7gbeqPT8ZBcDx9Rc63G4p/BtW78sckFzuybGg4
 WrC1MbuwX4rqoFlAsI/5v/rbDx+4zAWoquE2ZqOF964EEuRjHiBiGB6KLEp8r5Eyir9n
 hWvqYz3sCl34k10P2wiJqyWCc/R9kE3Ou4f7a5w1m5HYokcYxZHMHl91ODU5XFnV5NH3 YA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtpuhr09s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 18:52:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36DIqFLX017392
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 18:52:15 GMT
Received: from akhilpo-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 11:52:11 -0700
Date:   Fri, 14 Jul 2023 00:22:08 +0530
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     Rob Clark <robdclark@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm/adreno: Fix snapshot BINDLESS_DATA size
Message-ID: <3ect6gyn4ylhrkql5isb2x3bbfg55yohhgivszejtvsjxfn6s7@ricinp6rf3i4>
References: <20230711175409.157800-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230711175409.157800-1-robdclark@gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rfpCF3EEy1A_-RnZU5MYwVDSeJFMgYeS
X-Proofpoint-ORIG-GUID: rfpCF3EEy1A_-RnZU5MYwVDSeJFMgYeS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_07,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307130168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 10:54:07AM -0700, Rob Clark wrote:
> 
> From: Rob Clark <robdclark@chromium.org>
> 
> The incorrect size was causing "CP | AHB bus error" when snapshotting
> the GPU state on a6xx gen4 (a660 family).
> 
> Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/26
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
> index 790f55e24533..e788ed72eb0d 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h
> @@ -206,7 +206,7 @@ static const struct a6xx_shader_block {
>  	SHADER(A6XX_SP_LB_3_DATA, 0x800),
>  	SHADER(A6XX_SP_LB_4_DATA, 0x800),
>  	SHADER(A6XX_SP_LB_5_DATA, 0x200),
> -	SHADER(A6XX_SP_CB_BINDLESS_DATA, 0x2000),
> +	SHADER(A6XX_SP_CB_BINDLESS_DATA, 0x800),
>  	SHADER(A6XX_SP_CB_LEGACY_DATA, 0x280),
>  	SHADER(A6XX_SP_UAV_DATA, 0x80),
>  	SHADER(A6XX_SP_INST_TAG, 0x80),
> -- 
> 2.41.0
> 
Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>

-Akhil
