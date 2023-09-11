Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A699179AE85
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347164AbjIKVY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243117AbjIKQvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:51:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B296CEB;
        Mon, 11 Sep 2023 09:51:07 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BGGAub029684;
        Mon, 11 Sep 2023 16:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Lc0OQ1l3brsi+ky7bI6N525itSHtisKT84iuVnkdUzs=;
 b=F9agODGpUrwjoQEva5njVjt/FTNeeHKVhzXLQ/4dZoHg8vbNHNnbF94dNEBQ4gnrmky6
 1e3uIG1SXPXVVaUHMg4vj6mVfsZFd3pm64p5Vx/OVUIARiRGLhFTtEmpEqfBRsViqPic
 tGB71XND/0fXjhxzJUfR4ATNWzBTse5BshqTj+lOr43Ll4wv9oCVt6DMzuliiSh/fws+
 vmLUSYVpv8htd/UlIe7ad6Dl+umPhGsDWvOT5j4tdRYX67v04wJcaAar5wlwnqKsbe5+
 wkQUWAoXDeVT+L0UGNfCEIAJcYN3+ZYJsf2Mb3fY5ZCtTjBBK3VaeIXdtQKqbK4aTspr cg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t268fg2g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 16:49:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38BGn9EJ024485
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 16:49:09 GMT
Received: from [10.71.110.104] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 11 Sep
 2023 09:49:05 -0700
Message-ID: <24d36d44-888b-291c-488b-7dee0d7e8e62@quicinc.com>
Date:   Mon, 11 Sep 2023 09:49:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] drm/msm/dpu: fail dpu_plane_atomic_check() based on
 mdp clk limits
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <freedreno@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        "Sean Paul" <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        "David Airlie" <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>,
        <dri-devel@lists.freedesktop.org>, <quic_jesszhan@quicinc.com>,
        <quic_parellan@quicinc.com>, <nespera@igalia.com>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Archit Taneja <architt@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230908185427.29026-1-quic_abhinavk@quicinc.com>
 <CAA8EJprD4nJ=wGZ3XUoxAXi0ybPsGPUOg22FwXVg+dzAmJ8v1Q@mail.gmail.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAA8EJprD4nJ=wGZ3XUoxAXi0ybPsGPUOg22FwXVg+dzAmJ8v1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S3bX5gBfTXUw-UKTocoAI4StvUPdb1Ig
X-Proofpoint-ORIG-GUID: S3bX5gBfTXUw-UKTocoAI4StvUPdb1Ig
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309110155
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/2023 4:06 PM, Dmitry Baryshkov wrote:
> On Fri, 8 Sept 2023 at 21:56, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>
>> Currently, dpu_plane_atomic_check() does not check whether the
>> plane can process the image without exceeding the per chipset
>> limits for MDP clock. This leads to underflow issues because the
>> SSPP is not able to complete the processing for the data rate of
>> the display.
>>
>> Fail the dpu_plane_atomic_check() if the SSPP cannot process the
>> image without exceeding the MDP clock limits.
>>
>> Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
>> index 98c1b22e9bca..62dd9f9b4dce 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
>> @@ -733,9 +733,11 @@ static int dpu_plane_check_inline_rotation(struct dpu_plane *pdpu,
>>   static int dpu_plane_atomic_check_pipe(struct dpu_plane *pdpu,
>>                  struct dpu_sw_pipe *pipe,
>>                  struct dpu_sw_pipe_cfg *pipe_cfg,
>> -               const struct dpu_format *fmt)
>> +               const struct dpu_format *fmt,
>> +               const struct drm_display_mode *mode)
>>   {
>>          uint32_t min_src_size;
>> +       struct dpu_kms *kms = _dpu_plane_get_kms(&pdpu->base);
>>
>>          min_src_size = DPU_FORMAT_IS_YUV(fmt) ? 2 : 1;
>>
>> @@ -774,6 +776,12 @@ static int dpu_plane_atomic_check_pipe(struct dpu_plane *pdpu,
>>                  return -EINVAL;
>>          }
>>
>> +       /* max clk check */
>> +       if (_dpu_plane_calc_clk(mode, pipe_cfg) > kms->perf.max_core_clk_rate) {
>> +               DPU_DEBUG_PLANE(pdpu, "plane exceeds max mdp core clk limits\n");
>> +               return -E2BIG;
>> +       }
>> +
>>          return 0;
>>   }
>>
>> @@ -899,12 +907,13 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
>>                  r_pipe_cfg->dst_rect.x1 = pipe_cfg->dst_rect.x2;
>>          }
>>
>> -       ret = dpu_plane_atomic_check_pipe(pdpu, pipe, pipe_cfg, fmt);
>> +       ret = dpu_plane_atomic_check_pipe(pdpu, pipe, pipe_cfg, fmt, &crtc_state->mode);
>>          if (ret)
>>                  return ret;
>>
>>          if (r_pipe->sspp) {
>> -               ret = dpu_plane_atomic_check_pipe(pdpu, r_pipe, r_pipe_cfg, fmt);
>> +               ret = dpu_plane_atomic_check_pipe(pdpu, r_pipe, r_pipe_cfg, fmt,
>> +                                                 &crtc_state->mode);
> 
> I think this should be adjusted_mode. In the end, according to the
> docs CRTC should be programmed with the adjusted_mode, while the
> state->mode is the mode at the end of the pipeline (if I got it
> correct).
> 
> So e.g. if we add DS to the picture, state->mode will be screen
> resolution, while adjusted_moe will be pre-scale resolution, which is
> the one that matters from the bandwidth point of view.
> 
> 

Ack, I should change this to adjusted_mode although today this would be 
the same behavior as dpu_crtc doesn't have a mode_fixup.

so mode = adjusted_mode

https://gitlab.freedesktop.org/drm/msm/-/blob/msm-next/drivers/gpu/drm/drm_atomic_helper.c#L425

