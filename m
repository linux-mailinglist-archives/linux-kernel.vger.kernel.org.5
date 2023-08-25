Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D7E788FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 22:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjHYUpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 16:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjHYUpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:45:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD8A2135;
        Fri, 25 Aug 2023 13:45:11 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PKIG0F028065;
        Fri, 25 Aug 2023 20:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rCbT+9n5oZd2fu4/AHpTd1uvnXAylvuuPvz5cdeX7To=;
 b=Sx+a9DMnEXz7b5bgezSZt8ZwcQ2pGwkhaGTUlsDpoYdb/EElVNiJOJik0T2uRGGaDdGd
 kanEHiByoEw847vOsPJ4XNvPpPB8kUGTOfufVt9lQHt5s1mVbNd1kJhxbnXe5UlCf81t
 6Tz1zdOZFR6oWWrSrUyqjmY7Q6yd8o8zvJDso1dcvagAHM3/SuGUj3BJlx6/aFOqAgl2
 5MNGr4TEQE3weQRg4VjEIMroSd1hngx+3jU2rGBZnC4vVXLqEKTDa3n//UghLmd3IfYA
 Xpz1hpNt5L443G9QFLygiJQppYWuvKo3QYalKBbE86UWqMzzMBEPp5hUeoZB09qIK9FT Wg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3spmm69xxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 20:44:49 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37PKimSG007359
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 20:44:48 GMT
Received: from [10.110.6.4] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 25 Aug
 2023 13:44:47 -0700
Message-ID: <832a55a6-9914-a5f1-5bef-30421e47181d@quicinc.com>
Date:   Fri, 25 Aug 2023 13:44:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] drm/msm/dp: do not reinitialize phy unless retry
 during link training
Content-Language: en-US
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>, <marijn.suijten@somainline.org>
CC:     <quic_jesszhan@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1691533190-19335-1-git-send-email-quic_khsieh@quicinc.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <1691533190-19335-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NFxw4VKgL6xi8hVhddxdorYnjj4U6Uxg
X-Proofpoint-GUID: NFxw4VKgL6xi8hVhddxdorYnjj4U6Uxg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_19,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1011 mlxscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250185
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/2023 3:19 PM, Kuogee Hsieh wrote:
> DP PHY re-initialization done using dp_ctrl_reinitialize_mainlink() will
> cause PLL unlocked initially and then PLL gets locked at the end of
> initialization. PLL_UNLOCKED interrupt will fire during this time if the
> interrupt mask is enabled.

There should be a line break here.

> However currently DP driver link training implementation incorrectly
> re-initializes PHY unconditionally during link training as the PHY was
> already configured in dp_ctrl_enable_mainlink_clocks().
> 
> Fix this by re-initializing the PHY only if the previous link training
> failed.
> 
> [drm:dp_aux_isr] *ERROR* Unexpected DP AUX IRQ 0x01000000 when not busy
> 
> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/30
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

I tested and confirm that without this patch, I see this spam atleast 
once per reboot but after this patch, I have not seen this for 5 
consecutive reboots.

Hence,

Tested-by: Abhinav Kumar <quic_abhinavk@quicinc.com> # sc7280

Looking at the code flow, the dp_ctrl_reinitialize_mainlink() certainly 
looks redundant where it is, considering that the clks were enabled just 
a couple of lines above in dp_ctrl_enable_mainlink_clocks().

Hence with the minor fix in the commit,

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

> ---
>   drivers/gpu/drm/msm/dp/dp_ctrl.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index a7a5c7e..77a8d93 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1774,13 +1774,6 @@ int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
>   		return rc;
>   
>   	while (--link_train_max_retries) {
> -		rc = dp_ctrl_reinitialize_mainlink(ctrl);
> -		if (rc) {
> -			DRM_ERROR("Failed to reinitialize mainlink. rc=%d\n",
> -					rc);
> -			break;
> -		}
> -
>   		training_step = DP_TRAINING_NONE;
>   		rc = dp_ctrl_setup_main_link(ctrl, &training_step);
>   		if (rc == 0) {
> @@ -1832,6 +1825,12 @@ int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
>   			/* stop link training before start re training  */
>   			dp_ctrl_clear_training_pattern(ctrl);
>   		}
> +
> +		rc = dp_ctrl_reinitialize_mainlink(ctrl);
> +		if (rc) {
> +			DRM_ERROR("Failed to reinitialize mainlink. rc=%d\n", rc);
> +			break;
> +		}
>   	}
>   
>   	if (ctrl->link->sink_request & DP_TEST_LINK_PHY_TEST_PATTERN)
