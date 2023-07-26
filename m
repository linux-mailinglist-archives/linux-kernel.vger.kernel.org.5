Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527B2762B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjGZGGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjGZGGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:06:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B361982;
        Tue, 25 Jul 2023 23:06:33 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q55Pus010113;
        Wed, 26 Jul 2023 06:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=s7FCjzxoUJY++zgFbBCgzuoWWwtgFeG0MWA5SCk/YG8=;
 b=EzPITTPWd/912OfIJXR9KuQLnGZkrEJQAeTsU0oQIYG6WYQfhA4c4H4qP4DEs9uzEafQ
 U2QU6sUmBavNq1BloQKUrkGnvGJOp/HAGReLNggvrYnNeL4sDBybRm6Qs6n3UFzjTwS1
 oObJTn9RJW8xJmnZP8wOo9ncO3958RmF6vDEpbLXReDlXbtA67u/k0r9J3ltU7lUynWn
 nZRK/xVBmh5JqHzAwxIiznDQWbNyFKpMkcpO9ogvRvsFRboDkfz1nW/DtgFH5S6W8zyQ
 z/ZVO/Und04lmV3JnEwrIiGcyAnaTjMkrwdGBY81i9ou4NCSwte6vrJ1IlcuiejgrkdB ww== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2cf8tc1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 06:06:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36Q66SSs025657
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 06:06:28 GMT
Received: from [10.216.26.63] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 25 Jul
 2023 23:06:26 -0700
Message-ID: <d2cc7c22-6afb-f59e-ae37-0604e362222e@quicinc.com>
Date:   Wed, 26 Jul 2023 11:36:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] spi: spi-qcom-qspi: Fallback to PIO for xfers that
 aren't multiples of 4 bytes
Content-Language: en-CA
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
References: <20230725110226.1.Ia2f980fc7cd0b831e633391f0bb1272914d8f381@changeid>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <20230725110226.1.Ia2f980fc7cd0b831e633391f0bb1272914d8f381@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EP3rMtVCIQAIeUo-N8Z8Oj7MD2ckisJL
X-Proofpoint-GUID: EP3rMtVCIQAIeUo-N8Z8Oj7MD2ckisJL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_14,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=868
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260053
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/25/2023 11:32 PM, Douglas Anderson wrote:
> The Qualcomm QSPI driver appears to require that any reads using DMA
> are a mutliple of 4 bytes. If this isn't true then the controller will
> clobber any extra bytes in memory following the last word. Let's
> detect this and falback to PIO.
>
> This fixes problems reported by slub_debug=FZPUA, which would complain
> about "kmalloc Redzone overwritten". One such instance said:
>
>    0xffffff80c29d541a-0xffffff80c29d541b @offset=21530. First byte 0x0 instead of 0xcc
>    Allocated in mtd_kmalloc_up_to+0x98/0xac age=36 cpu=3 pid=6658
>
> Tracing through what was happening I saw that, while we often did DMA
> tranfers of 0x1000 bytes, sometimes we'd end up doing ones of 0x41a
> bytes. Those 0x41a byte transfers were the problem.
>
> NOTE: a future change will enable the SPI "mem ops" to help avoid this
> case, but it still seems good to add the extra check in the transfer.
>
> Fixes: b5762d95607e ("spi: spi-qcom-qspi: Add DMA mode support")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>


Thank you for the fix,

Vijay/


> ---
>
>   drivers/spi/spi-qcom-qspi.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
> index a0ad9802b606..39b4d8a8107a 100644
> --- a/drivers/spi/spi-qcom-qspi.c
> +++ b/drivers/spi/spi-qcom-qspi.c
> @@ -355,10 +355,22 @@ static int qcom_qspi_setup_dma_desc(struct qcom_qspi *ctrl,
>   
>   	for (i = 0; i < sgt->nents; i++) {
>   		dma_ptr_sg = sg_dma_address(sgt->sgl + i);
> +		dma_len_sg = sg_dma_len(sgt->sgl + i);
>   		if (!IS_ALIGNED(dma_ptr_sg, QSPI_ALIGN_REQ)) {
>   			dev_warn_once(ctrl->dev, "dma_address not aligned to %d\n", QSPI_ALIGN_REQ);
>   			return -EAGAIN;
>   		}
> +		/*
> +		 * When reading with DMA the controller writes to memory 1 word
> +		 * at a time. If the length isn't a multiple of 4 bytes then
> +		 * the controller can clobber the things later in memory.
> +		 * Fallback to PIO to be safe.
> +		 */
> +		if (ctrl->xfer.dir == QSPI_READ && (dma_len_sg & 0x03)) {
> +			dev_warn_once(ctrl->dev, "fallback to PIO for read of size %#010x\n",
> +				      dma_len_sg);
> +			return -EAGAIN;
> +		}
>   	}
>   
>   	for (i = 0; i < sgt->nents; i++) {
