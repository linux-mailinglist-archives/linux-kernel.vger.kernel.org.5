Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869347671D3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjG1Q20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjG1Q2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:28:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136D73AAC;
        Fri, 28 Jul 2023 09:28:23 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SEIM4C005087;
        Fri, 28 Jul 2023 16:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=w0oGhDyW9VdO2m5FSV0ApOWQSQ6yHZfu9JMXkORo2A4=;
 b=Vi1n7mSVETaFyQ2vYTLrQNirsdWhi2Dz5wvecVRq81uVi/b8WQMzCsKduTyUb+StB49O
 Kn8RqUisfZdw43W8bRHYrjyyBip2We1ud1oIXvPimaVYl3r986xwDRWf7pnH9L4ysj8o
 BvySdfzgR1kUIili/Hccnl2LnMqYJcx+CWLBW7BBkzB3Zq1htNRKAhXAU1Ug0MJFvq4O
 Qwo18K4tY2ABcVnT8tibMxK5EMkjC9LBGY71zGC6qLarZqG5W0e583AvMLsjhrDGLOGy
 +UZhEjuDMMDqMQcnqoEmRZU/f4PIya4Y9N/PgMnTTwaJV4tPylggLwj1PdFxR9Gir+na gg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s403vj1dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 16:28:19 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36SGSIW1013242
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 16:28:18 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 28 Jul 2023 09:28:18 -0700
Date:   Fri, 28 Jul 2023 09:28:17 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Vikash Garodia <quic_vgarodia@quicinc.com>
CC:     <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_dikshita@quicinc.com>
Subject: Re: [PATCH 11/33] iris: vidc: add helpers for memory management
Message-ID: <20230728162817.GE1428172@hu-bjorande-lv.qualcomm.com>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-12-git-send-email-quic_vgarodia@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1690550624-14642-12-git-send-email-quic_vgarodia@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FlWOmzjyQT2xxyu7ikpawU1qJjPo6G5V
X-Proofpoint-ORIG-GUID: FlWOmzjyQT2xxyu7ikpawU1qJjPo6G5V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0
 mlxlogscore=771 mlxscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 06:53:22PM +0530, Vikash Garodia wrote:
> diff --git a/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_memory.c b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_memory.c
[..]
> +static const struct msm_vidc_memory_ops msm_mem_ops = {
> +	.dma_buf_get                    = msm_vidc_dma_buf_get,
> +	.dma_buf_put                    = msm_vidc_dma_buf_put,
> +	.dma_buf_put_completely         = msm_vidc_dma_buf_put_completely,
> +	.dma_buf_attach                 = msm_vidc_dma_buf_attach,
> +	.dma_buf_detach                 = msm_vidc_dma_buf_detach,
> +	.dma_buf_map_attachment         = msm_vidc_dma_buf_map_attachment,
> +	.dma_buf_unmap_attachment       = msm_vidc_dma_buf_unmap_attachment,
> +	.memory_alloc_map               = msm_vidc_memory_alloc_map,
> +	.memory_unmap_free              = msm_vidc_memory_unmap_free,
> +	.buffer_region                  = msm_vidc_buffer_region,

Will there ever be more than one implementation of the
msm_vidc_memory_ops?

Unless there's a really strong reason, just call the functions directly
without the function pointers and call_mem_op(), this will be slightly
faster, but more importantly it allows for much faster navigation of the
code base.

Regards,
Bjorn
