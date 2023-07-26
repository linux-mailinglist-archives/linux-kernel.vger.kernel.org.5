Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6422B762D91
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjGZHaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjGZH3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:29:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E283E2D68;
        Wed, 26 Jul 2023 00:28:00 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q6FgbZ023720;
        Wed, 26 Jul 2023 07:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tT7G2j3HSZWRAH7XDW1HDetddXyDBJGikutodB97Mwo=;
 b=ALGErt7Snj0CaCMLSWamol1bCn4oO8DlpSOnSlo8T1VNCdJftl+m2u6DOfRXfXYJDo72
 zBX1prZWREjGLKPSWTeRpEjzL3ubHrD6ce/zqvU2UNhb0EjdDbMBezwOa/HU4/YSPpTa
 UCpRVK8LiLdX8+PzeX4dslIOwICSgM3JRlU0FIYNBmfz/TfvPs7lWrIweM6krV3HWumI
 vgh+JE3pbdL13w/xP1TxAeZdG2vdCqXnBpd5zyTcVvi/Emtc6qjr+hUOg9LXFNdF7IC+
 gUmf7lKKlngHUkF+WUmW7sBJiqgCbuqhNR/cyi3fSaJ2tAwdz5dvczD9/ofOnRNDWko0 Cg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2dqaj8eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 07:27:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36Q7RscN021675
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 07:27:54 GMT
Received: from [10.216.26.63] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 26 Jul
 2023 00:27:51 -0700
Message-ID: <faa31984-7185-6d25-dbb7-3e25e0883e5b@quicinc.com>
Date:   Wed, 26 Jul 2023 12:57:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] spi: spi-qcom-qspi: Add mem_ops to avoid PIO for
 badly sized reads
Content-Language: en-CA
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
References: <20230725110226.1.Ia2f980fc7cd0b831e633391f0bb1272914d8f381@changeid>
 <20230725110226.2.Id4a39804e01e4a06dae9b73fd2a5194c4c7ea453@changeid>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <20230725110226.2.Id4a39804e01e4a06dae9b73fd2a5194c4c7ea453@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: I6GRsnzcu_DfHsA6s8xbHSrncElncclz
X-Proofpoint-ORIG-GUID: I6GRsnzcu_DfHsA6s8xbHSrncElncclz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_01,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=947
 bulkscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260064
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/25/2023 11:32 PM, Douglas Anderson wrote:
> In the patch ("spi: spi-qcom-qspi: Fallback to PIO for xfers that
> aren't multiples of 4 bytes") we detect reads that we can't handle
> properly and fallback to PIO mode. While that's correct behavior, we
> can do better by adding "spi_controller_mem_ops" for our
> controller. Once we do this then the caller will give us a transfer
> that's a multiple of 4-bytes so we can DMA.
>
> Fixes: b5762d95607e ("spi: spi-qcom-qspi: Add DMA mode support")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

I checked with a couple of folks here and seemingly the POR for QSPI 
controller is for storage device only, so in all likelihood we should be 
having a spi-flash at the other end.

For other devices there is QUP anyway.

Hence personally I am happy with this change.

Thank you...


Reviewed-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>


> ---
>
>   drivers/spi/spi-qcom-qspi.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>
> diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
> index 39b4d8a8107a..b2bbcfd93637 100644
> --- a/drivers/spi/spi-qcom-qspi.c
> +++ b/drivers/spi/spi-qcom-qspi.c
> @@ -659,6 +659,30 @@ static irqreturn_t qcom_qspi_irq(int irq, void *dev_id)
>   	return ret;
>   }
>   
> +static int qcom_qspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
> +{
> +	/*
> +	 * If qcom_qspi_can_dma() is going to return false we don't need to
> +	 * adjust anything.
> +	 */
> +	if (op->data.nbytes <= QSPI_MAX_BYTES_FIFO)
> +		return 0;
> +
> +	/*
> +	 * When reading, the transfer needs to be a multiple of 4 bytes so
> +	 * shrink the transfer if that's not true. The caller will then do a
> +	 * second transfer to finish things up.
> +	 */
> +	if (op->data.dir == SPI_MEM_DATA_IN && (op->data.nbytes & 0x3))
> +		op->data.nbytes &= ~0x3;
> +
> +	return 0;
> +}
> +
> +static const struct spi_controller_mem_ops qcom_qspi_mem_ops = {
> +	.adjust_op_size = qcom_qspi_adjust_op_size,
> +};
> +
>   static int qcom_qspi_probe(struct platform_device *pdev)
>   {
>   	int ret;
> @@ -743,6 +767,7 @@ static int qcom_qspi_probe(struct platform_device *pdev)
>   	if (of_property_read_bool(pdev->dev.of_node, "iommus"))
>   		master->can_dma = qcom_qspi_can_dma;
>   	master->auto_runtime_pm = true;
> +	master->mem_ops = &qcom_qspi_mem_ops;
>   
>   	ret = devm_pm_opp_set_clkname(&pdev->dev, "core");
>   	if (ret)
