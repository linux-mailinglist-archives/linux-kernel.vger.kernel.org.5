Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEBD77C12E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjHNUBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjHNUA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:00:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B4510C8;
        Mon, 14 Aug 2023 13:00:55 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EK0Cbl002351;
        Mon, 14 Aug 2023 20:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kMtRRDuAd2KJxcf6Ohfkhp6dTC3I4yyTmRVW39+tgVM=;
 b=KhirO8mR9IhI/ZSfjeDch98NOOjLbl89voWww1SBxD0f6dZHsr9aWZ4qe7eiWIO8Kpnb
 s/2clJeaJNBIn0fINGCdu2tbnjadzoFVchEV1zrypK4CnrtpMLUCfj7JF4euPmjLZhTE
 B6C+KcYn8C629034E5gFXQu6RUxfUM2aVvErjTVdI72S231yLvwNzSsUpyREUaIv/AKT
 0pG1TVwPO6HqvmzY9+4KUy+R7St9BpZwFM5sA87X5oPRLP5zPJbbSWubiSJq7WtyA8RA
 L51My6kn9T9lCK5uDF4+vBA/CeF/SrrM38Moz1n9nTllZysLt4/oej2Kin79nG5v5rmb fQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3j94rgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 20:00:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EK0nUu023830
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 20:00:49 GMT
Received: from [10.50.35.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 14 Aug
 2023 13:00:45 -0700
Message-ID: <1f009684-4d99-ecf6-001e-7925d0159a02@quicinc.com>
Date:   Tue, 15 Aug 2023 01:30:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 29/33] iris: variant: iris3: add helpers for buffer size
 calculations
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-30-git-send-email-quic_vgarodia@quicinc.com>
 <7e51bbe3-5a28-da22-84fa-3f2964556198@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <7e51bbe3-5a28-da22-84fa-3f2964556198@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kBA5l3udh32uBtStpjMlkrmhMrzsBDf8
X-Proofpoint-GUID: kBA5l3udh32uBtStpjMlkrmhMrzsBDf8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_17,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140185
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2023 7:49 PM, Dmitry Baryshkov wrote:
> On 28/07/2023 16:23, Vikash Garodia wrote:
>> From: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>
>> This implements iris3 specific buffer size calculation for
>> firmware internal buffers, input and output buffers for
>> encoder and decoder.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> ---
>>   .../qcom/iris/variant/iris3/inc/hfi_buffer_iris3.h | 1481
>> ++++++++++++++++++++
>>   .../iris/variant/iris3/inc/msm_vidc_buffer_iris3.h |   19 +
>>   .../iris/variant/iris3/src/msm_vidc_buffer_iris3.c |  595 ++++++++
>>   3 files changed, 2095 insertions(+)
>>   create mode 100644
>> drivers/media/platform/qcom/iris/variant/iris3/inc/hfi_buffer_iris3.h
>>   create mode 100644
>> drivers/media/platform/qcom/iris/variant/iris3/inc/msm_vidc_buffer_iris3.h
>>   create mode 100644
>> drivers/media/platform/qcom/iris/variant/iris3/src/msm_vidc_buffer_iris3.c
>>
>> diff --git
>> a/drivers/media/platform/qcom/iris/variant/iris3/inc/hfi_buffer_iris3.h
>> b/drivers/media/platform/qcom/iris/variant/iris3/inc/hfi_buffer_iris3.h
>> new file mode 100644
>> index 0000000..cb068ca
>> --- /dev/null
>> +++ b/drivers/media/platform/qcom/iris/variant/iris3/inc/hfi_buffer_iris3.h
>> @@ -0,0 +1,1481 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights
>> reserved.
>> + */
>> +
>> +#ifndef __HFI_BUFFER_IRIS3__
>> +#define __HFI_BUFFER_IRIS3__
>> +
>> +#include <linux/types.h>
>> +
>> +#include "hfi_property.h"
>> +
>> +typedef u8      HFI_U8;
>> +typedef s8      HFI_S8;
>> +typedef u16     HFI_U16;
>> +typedef s16     HFI_S16;
>> +typedef u32     HFI_U32;
>> +typedef s32     HFI_S32;
>> +typedef u64     HFI_U64;
>> +typedef u32     HFI_BOOL;
> 
> No custom typedefs please.
> 
>> +
>> +#ifndef MIN
>> +#define  MIN(x, y) (((x) < (y)) ? (x) : (y))
>> +#endif
>> +
>> +#ifndef MAX
>> +#define  MAX(x, y) (((x) > (y)) ? (x) : (y))
>> +#endif
> 
> You have seen <linux/minmax.h>, didn't you? If so, why are you adding new
> wrappers?
> 
>> +
>> +#define HFI_ALIGNMENT_4096 (4096)
>> +
>> +#define BUF_SIZE_ALIGN_16 (16)
>> +#define BUF_SIZE_ALIGN_32 (32)
>> +#define BUF_SIZE_ALIGN_64 (64)
>> +#define BUF_SIZE_ALIGN_128 (128)
>> +#define BUF_SIZE_ALIGN_256 (256)
>> +#define BUF_SIZE_ALIGN_512 (512)
>> +#define BUF_SIZE_ALIGN_4096 (4096)
> 
> So nice, so useless.
> 
>> +
>> +#define HFI_ALIGN(a, b) (((b) & ((b) - 1)) ? (((a) + (b) - 1) / \
>> +    (b) * (b)) : (((a) + (b) - 1) & (~((b) - 1))))
> 
> Can you use ALIGN instead?
> 
>> +
>> +#define HFI_WORKMODE_1 1
>> +#define HFI_WORKMODE_2 2
>> +
>> +#define HFI_DEFAULT_METADATA_STRIDE_MULTIPLE (64)
>> +#define HFI_DEFAULT_METADATA_BUFFERHEIGHT_MULTIPLE (16)
>> +
>> +#define HFI_COLOR_FORMAT_YUV420_NV12_UBWC_Y_TILE_HEIGHT (8)
>> +#define HFI_COLOR_FORMAT_YUV420_NV12_UBWC_Y_TILE_WIDTH (32)
>> +#define HFI_COLOR_FORMAT_YUV420_NV12_UBWC_UV_TILE_HEIGHT (8)
>> +#define HFI_COLOR_FORMAT_YUV420_NV12_UBWC_UV_TILE_WIDTH (16)
>> +#define HFI_COLOR_FORMAT_YUV420_TP10_UBWC_Y_TILE_HEIGHT (4)
>> +#define HFI_COLOR_FORMAT_YUV420_TP10_UBWC_Y_TILE_WIDTH (48)
>> +#define HFI_COLOR_FORMAT_YUV420_TP10_UBWC_UV_TILE_HEIGHT (4)
>> +#define HFI_COLOR_FORMAT_YUV420_TP10_UBWC_UV_TILE_WIDTH (24)
>> +#define HFI_COLOR_FORMAT_RGBA8888_UBWC_TILE_HEIGHT (4)
>> +#define HFI_COLOR_FORMAT_RGBA8888_UBWC_TILE_WIDTH (16)
>> +
>> +#define HFI_NV12_IL_CALC_Y_STRIDE(stride, frame_width, stride_multiple) \
>> +    (stride = HFI_ALIGN(frame_width, stride_multiple))
> 
> macros with side actions are not really welcomed. Especially as they do not
> bring any additional value and can be inlined.
> 
>> +
>> +#define HFI_NV12_IL_CALC_Y_BUFHEIGHT(buf_height, frame_height, \
>> +    min_buf_height_multiple) (buf_height = HFI_ALIGN(frame_height, \
>> +    min_buf_height_multiple))
>> +
>> +#define HFI_NV12_IL_CALC_UV_STRIDE(stride, frame_width, stride_multiple) \
>> +    (stride = HFI_ALIGN(frame_width, stride_multiple))
>> +
>> +#define HFI_NV12_IL_CALC_UV_BUFHEIGHT(buf_height, frame_height, \
>> +    min_buf_height_multiple) (buf_height = HFI_ALIGN((((frame_height) +
>> 1) \
>> +     >> 1),    min_buf_height_multiple))
>> +
>> +#define HFI_NV12_IL_CALC_BUF_SIZE(buf_size, y_bufsize, y_stride,
>> y_buf_height, \
>> +    uv_buf_size, uv_stride, uv_buf_height) \
>> +    do { \
>> +        y_bufsize = (y_stride * y_buf_height); \
>> +        uv_buf_size = (uv_stride * uv_buf_height); \
>> +        buf_size = HFI_ALIGN(y_bufsize + uv_buf_size, HFI_ALIGNMENT_4096) \
>> +    } while (0)
>> +
>> +#define HFI_NV12_UBWC_IL_CALC_Y_BUF_SIZE(y_bufsize, y_stride,
>> y_buf_height) \
>> +    (y_bufsize = HFI_ALIGN(y_stride * y_buf_height, HFI_ALIGNMENT_4096))
>> +
>> +#define HFI_NV12_UBWC_IL_CALC_UV_BUF_SIZE(uv_buf_size, \
>> +    uv_stride, uv_buf_height) \
>> +    (uv_buf_size = HFI_ALIGN(uv_stride * uv_buf_height,
>> HFI_ALIGNMENT_4096))
>> +
>> +#define HFI_NV12_UBWC_IL_CALC_BUF_SIZE_V2(buf_size,\
>> +    frame_width, frame_height, y_stride_multiple,\
>> +    y_buffer_height_multiple, uv_stride_multiple, \
>> +    uv_buffer_height_multiple, y_metadata_stride_multiple, \
>> +    y_metadata_buffer_height_multiple, \
>> +    uv_metadata_stride_multiple, uv_metadata_buffer_height_multiple) \
>> +    do { \
>> +        HFI_U32 y_buf_size, uv_buf_size, y_meta_size, uv_meta_size;   \
>> +        HFI_U32 stride, _height; \
>> +        HFI_U32 half_height = (frame_height + 1) >> 1; \
>> +        HFI_NV12_IL_CALC_Y_STRIDE(stride, frame_width,\
>> +                    y_stride_multiple); \
>> +        HFI_NV12_IL_CALC_Y_BUFHEIGHT(_height, half_height,\
>> +                    y_buffer_height_multiple); \
>> +        HFI_NV12_UBWC_IL_CALC_Y_BUF_SIZE(y_buf_size, stride, _height);\
>> +        HFI_NV12_IL_CALC_UV_STRIDE(stride, frame_width, \
>> +                    uv_stride_multiple); \
>> +        HFI_NV12_IL_CALC_UV_BUFHEIGHT(_height, half_height, \
>> +                    uv_buffer_height_multiple); \
>> +        HFI_NV12_UBWC_IL_CALC_UV_BUF_SIZE(uv_buf_size, stride, _height);\
>> +        HFI_UBWC_CALC_METADATA_PLANE_STRIDE(stride, frame_width,\
>> +                y_metadata_stride_multiple, \
>> +            HFI_COLOR_FORMAT_YUV420_NV12_UBWC_Y_TILE_WIDTH);\
>> +        HFI_UBWC_METADATA_PLANE_BUFHEIGHT(_height, half_height, \
>> +                y_metadata_buffer_height_multiple,\
>> +            HFI_COLOR_FORMAT_YUV420_NV12_UBWC_Y_TILE_HEIGHT);\
>> +        HFI_UBWC_METADATA_PLANE_BUFFER_SIZE(y_meta_size, stride, \
>> +                _height);    \
>> +        HFI_UBWC_UV_METADATA_PLANE_STRIDE(stride, frame_width,\
>> +                uv_metadata_stride_multiple, \
>> +            HFI_COLOR_FORMAT_YUV420_NV12_UBWC_UV_TILE_WIDTH); \
>> +        HFI_UBWC_UV_METADATA_PLANE_BUFHEIGHT(_height, half_height,\
>> +                uv_metadata_buffer_height_multiple,\
>> +            HFI_COLOR_FORMAT_YUV420_NV12_UBWC_UV_TILE_HEIGHT);\
>> +        HFI_UBWC_METADATA_PLANE_BUFFER_SIZE(uv_meta_size, stride, \
>> +                 _height); \
>> +        buf_size = (y_buf_size + uv_buf_size + y_meta_size + \
>> +            uv_meta_size) << 1;\
>> +    } while (0)
> 
> Even more macro with side effects. Please consider rewriting them to be
> functions. Small function is usually easier to understand compared to the
> complex macro.
> 
The calculations here are about the size of internal buffers, which is
based on agreed interface between driver and hardware. We will discuss with
hardware team on the suggested changes so that driver and hardware aligned
on the size calculations.

Thanks,
Dikshita
>> +
>> +#define HFI_YUV420_TP10_CALC_Y_STRIDE(stride, frame_width,
>> stride_multiple) \
>> +    do { \
>> +        stride = HFI_ALIGN(frame_width, 192); \
>> +        stride = HFI_ALIGN(stride * 4 / 3, stride_multiple); \
>> +    } while (0)
>> +
>> +#define HFI_YUV420_TP10_CALC_Y_BUFHEIGHT(buf_height, frame_height, \
>> +                min_buf_height_multiple) \
>> +    (buf_height = HFI_ALIGN(frame_height, min_buf_height_multiple))
>> +
>> +#define HFI_YUV420_TP10_CALC_UV_STRIDE(stride, frame_width,
>> stride_multiple) \
>> +    do { \
>> +        stride = HFI_ALIGN(frame_width, 192); \
>> +        stride = HFI_ALIGN(stride * 4 / 3, stride_multiple); \
>> +    } while (0)
>> +
>> +#define HFI_YUV420_TP10_CALC_UV_BUFHEIGHT(buf_height, frame_height, \
>> +                min_buf_height_multiple) \
>> +    (buf_height = HFI_ALIGN(((frame_height + 1) >> 1), \
>> +            min_buf_height_multiple))
>> +
>> +#define HFI_YUV420_TP10_CALC_BUF_SIZE(buf_size, y_buf_size, y_stride,\
>> +        y_buf_height, uv_buf_size, uv_stride, uv_buf_height) \
>> +    do {    \
>> +        y_buf_size = (y_stride * y_buf_height); \
>> +        uv_buf_size = (uv_stride * uv_buf_height); \
>> +        buf_size = y_buf_size + uv_buf_size \
>> +    } while (0)
>> +
>> +#define HFI_YUV420_TP10_UBWC_CALC_Y_BUF_SIZE(y_buf_size, y_stride, \
>> +                    y_buf_height) \
>> +    (y_buf_size = HFI_ALIGN(y_stride * y_buf_height, HFI_ALIGNMENT_4096))
>> +
>> +#define HFI_YUV420_TP10_UBWC_CALC_UV_BUF_SIZE(uv_buf_size, uv_stride, \
>> +                    uv_buf_height) \
>> +    (uv_buf_size = HFI_ALIGN(uv_stride * uv_buf_height,
>> HFI_ALIGNMENT_4096))
>> +
>> +#define HFI_YUV420_TP10_UBWC_CALC_BUF_SIZE(buf_size, y_stride,
>> y_buf_height, \
>> +    uv_stride, uv_buf_height, y_md_stride, y_md_height, uv_md_stride, \
>> +    uv_md_height)\
>> +    do { \
>> +        HFI_U32 y_data_size, uv_data_size, y_md_size, uv_md_size; \
>> +        HFI_YUV420_TP10_UBWC_CALC_Y_BUF_SIZE(y_data_size, y_stride,\
>> +                        y_buf_height); \
>> +        HFI_YUV420_TP10_UBWC_CALC_UV_BUF_SIZE(uv_data_size, uv_stride, \
>> +                        uv_buf_height); \
>> +        HFI_UBWC_METADATA_PLANE_BUFFER_SIZE(y_md_size, y_md_stride, \
>> +                        y_md_height); \
>> +        HFI_UBWC_METADATA_PLANE_BUFFER_SIZE(uv_md_size, uv_md_stride, \
>> +                        uv_md_height); \
>> +        buf_size = y_data_size + uv_data_size + y_md_size + \
>> +                        uv_md_size; \
>> +    } while (0)
>> +
>> +#define HFI_YUV420_P010_CALC_Y_STRIDE(stride, frame_width,
>> stride_multiple) \
>> +    (stride = HFI_ALIGN(frame_width * 2, stride_multiple))
>> +
>> +#define HFI_YUV420_P010_CALC_Y_BUFHEIGHT(buf_height, frame_height, \
>> +                min_buf_height_multiple) \
>> +    (buf_height = HFI_ALIGN(frame_height, min_buf_height_multiple))
>> +
>> +#define HFI_YUV420_P010_CALC_UV_STRIDE(stride, frame_width,
>> stride_multiple) \
>> +    (stride = HFI_ALIGN(frame_width * 2, stride_multiple))
>> +
>> +#define HFI_YUV420_P010_CALC_UV_BUFHEIGHT(buf_height, frame_height, \
>> +                min_buf_height_multiple) \
>> +    (buf_height = HFI_ALIGN(((frame_height + 1) >> 1), \
>> +            min_buf_height_multiple))
>> +
>> +#define HFI_YUV420_P010_CALC_BUF_SIZE(buf_size, y_data_size, y_stride, \
>> +    y_buf_height, uv_data_size, uv_stride, uv_buf_height) \
>> +    do { \
>> +        y_data_size = HFI_ALIGN(y_stride * y_buf_height, \
>> +                HFI_ALIGNMENT_4096);\
>> +        uv_data_size = HFI_ALIGN(uv_stride * uv_buf_height, \
>> +                HFI_ALIGNMENT_4096); \
>> +        buf_size = y_data_size + uv_data_size; \
>> +    } while (0)
>> +
>> +#define HFI_RGB888_CALC_STRIDE(stride, frame_width, stride_multiple) \
>> +    (stride = ((frame_width * 3) + stride_multiple - 1) & \
>> +             (0xffffffff - (stride_multiple - 1)))
>> +
>> +#define HFI_RGB888_CALC_BUFHEIGHT(buf_height, frame_height, \
>> +            min_buf_height_multiple) \
>> +    (buf_height = ((frame_height + min_buf_height_multiple - 1) & \
>> +            (0xffffffff - (min_buf_height_multiple - 1))))
>> +
>> +#define HFI_RGB888_CALC_BUF_SIZE(buf_size, stride, buf_height) \
>> +    (buf_size = ((stride) * (buf_height)))
>> +
>> +#define HFI_RGBA8888_CALC_STRIDE(stride, frame_width, stride_multiple) \
>> +    (stride = HFI_ALIGN((frame_width << 2), stride_multiple))
>> +
>> +#define HFI_RGBA8888_CALC_BUFHEIGHT(buf_height, frame_height, \
>> +            min_buf_height_multiple) \
>> +    (buf_height = HFI_ALIGN(frame_height, min_buf_height_multiple))
>> +
>> +#define HFI_RGBA8888_CALC_BUF_SIZE(buf_size, stride, buf_height) \
>> +    (buf_size = (stride) * (buf_height))
>> +
>> +#define HFI_RGBA8888_UBWC_CALC_DATA_PLANE_BUF_SIZE(buf_size, stride, \
>> +                buf_height) \
>> +    (buf_size = HFI_ALIGN((stride) * (buf_height), HFI_ALIGNMENT_4096))
>> +
>> +#define HFI_RGBA8888_UBWC_BUF_SIZE(buf_size, data_buf_size, \
>> +    metadata_buffer_size, stride, buf_height, _metadata_tride, \
>> +    _metadata_buf_height) \
>> +    do { \
>> +        HFI_RGBA8888_UBWC_CALC_DATA_PLANE_BUF_SIZE(data_buf_size, \
>> +                stride, buf_height); \
>> +        HFI_UBWC_METADATA_PLANE_BUFFER_SIZE(metadata_buffer_size, \
>> +                _metadata_tride, _metadata_buf_height); \
>> +        buf_size = data_buf_size + metadata_buffer_size \
>> +    } while (0)
>> +
>> +#define HFI_UBWC_CALC_METADATA_PLANE_STRIDE(metadata_stride, frame_width,\
>> +    metadata_stride_multiple, tile_width_in_pels) \
>> +    ((metadata_stride = HFI_ALIGN(((frame_width + (tile_width_in_pels -
>> 1)) /\
>> +    tile_width_in_pels), metadata_stride_multiple)))
>> +
>> +#define HFI_UBWC_METADATA_PLANE_BUFHEIGHT(metadata_buf_height,
>> frame_height, \
>> +    metadata_height_multiple, tile_height_in_pels) \
>> +    ((metadata_buf_height = HFI_ALIGN(((frame_height + \
>> +    (tile_height_in_pels - 1)) / tile_height_in_pels), \
>> +    metadata_height_multiple)))
>> +
>> +#define HFI_UBWC_UV_METADATA_PLANE_STRIDE(metadata_stride, frame_width, \
>> +    metadata_stride_multiple, tile_width_in_pels) \
>> +    ((metadata_stride = HFI_ALIGN(((((frame_width + 1) >> 1) +\
>> +    (tile_width_in_pels - 1)) / tile_width_in_pels), \
>> +    metadata_stride_multiple)))
>> +
>> +#define HFI_UBWC_UV_METADATA_PLANE_BUFHEIGHT(metadata_buf_height,
>> frame_height,\
>> +    metadata_height_multiple, tile_height_in_pels) \
>> +    (metadata_buf_height = HFI_ALIGN(((((frame_height + 1) >> 1) + \
>> +    (tile_height_in_pels - 1)) / tile_height_in_pels), \
>> +    metadata_height_multiple))
>> +
>> +#define HFI_UBWC_METADATA_PLANE_BUFFER_SIZE(buffer_size, _metadata_tride, \
>> +                    _metadata_buf_height) \
>> +    ((buffer_size = HFI_ALIGN(_metadata_tride * _metadata_buf_height, \
>> +                    HFI_ALIGNMENT_4096)))
>> +
>> +#define BUFFER_ALIGNMENT_512_BYTES 512
>> +#define BUFFER_ALIGNMENT_256_BYTES 256
>> +#define BUFFER_ALIGNMENT_128_BYTES 128
>> +#define BUFFER_ALIGNMENT_64_BYTES 64
>> +#define BUFFER_ALIGNMENT_32_BYTES 32
>> +#define BUFFER_ALIGNMENT_16_BYTES 16
>> +#define BUFFER_ALIGNMENT_8_BYTES 8
>> +#define BUFFER_ALIGNMENT_4_BYTES 4
> 
> -ETOOMUCH.
> 
> [skipped the rest, internal reviewer exception]
> 
