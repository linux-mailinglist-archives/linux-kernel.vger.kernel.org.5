Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE6780FA5C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377820AbjLLW1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377788AbjLLW1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:27:01 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826F0D3;
        Tue, 12 Dec 2023 14:27:07 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCLF2QX017447;
        Tue, 12 Dec 2023 22:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=qcppdkim1; bh=yurFKjLq7+bIUjRG15ojt
        gITIwSZr74Zdau5UeQsB4g=; b=XY6jxhGs8it9aWZgklDQAdVsJRv3tHKys36i9
        oL2kgFXU2ZKR1RUvq0DWmRkQoBI+8W5Gmrrk6p6qGqWta5TmlBhKkq3/urWdrpWF
        8Yw8gwBbW9gu/EHLfaH/B9NuRJpCqDuC3M4Md5nxNVAY0zoPQ1tvoR2fpzDNphTy
        CGVazSsSPng4bDG7bxQYXbyStm7WtlF5Bc3+2XN58E06x2QPDQUHJpXblWOH9al/
        AQN2VyeOpsbvLRcRgDOoso1g7VsOK7nXKoLPwA7z4nxVaayAo4lApZ9E4qiHLaQC
        nP8wP7ERsm8ogBO+6Hqvbn5HtEzGsP9dYGwUo5eihvIQPalXQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uxru2h5bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 22:26:48 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BCMQllE004339
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 22:26:47 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Dec 2023 14:26:44 -0800
Date:   Tue, 12 Dec 2023 14:26:43 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Sneh Shah <quic_snehshah@quicinc.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <netdev@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [PATCH net v4] net: stmmac: dwmac-qcom-ethqos: Fix drops in 10M
 SGMII RX
Message-ID: <20231212222643.GP1766637@hu-bjorande-lv.qualcomm.com>
References: <20231212092208.22393-1-quic_snehshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231212092208.22393-1-quic_snehshah@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dHxn2cy1gxmYT5OduOK80qziNe_XFr8K
X-Proofpoint-ORIG-GUID: dHxn2cy1gxmYT5OduOK80qziNe_XFr8K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 02:52:08PM +0530, Sneh Shah wrote:
> In 10M SGMII mode all the packets are being dropped due to wrong Rx clock.
> SGMII 10MBPS mode needs RX clock divider programmed to avoid drops in Rx.
> Update configure SGMII function with Rx clk divider programming.
> 

Thanks you for the updates!

Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

> Fixes: 463120c31c58 ("net: stmmac: dwmac-qcom-ethqos: add support for SGMII")
> Tested-by: Andrew Halaney <ahalaney@redhat.com>
> Signed-off-by: Sneh Shah <quic_snehshah@quicinc.com>
> ---
> v4 changelog:
> - Updated commit message to add more details on why 10M SGMII Rx is failing
> - Added a macro for Rx clock divider value
> v3 changelog:
> - Added comment to explain why MAC needs to be reconfigured for SGMII
> v2 changelog:
> - Use FIELD_PREP to prepare bifield values in place of GENMASK
> - Add fixes tag
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index d3bf42d0fceb..31631e3f89d0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -34,6 +34,7 @@
>  #define RGMII_CONFIG_LOOPBACK_EN		BIT(2)
>  #define RGMII_CONFIG_PROG_SWAP			BIT(1)
>  #define RGMII_CONFIG_DDR_MODE			BIT(0)
> +#define RGMII_CONFIG_SGMII_CLK_DVDR		GENMASK(18, 10)

Thank you for the clarification of rgmii vs sgmii. Perhaps this could be
made clearer by renaming the rgmii ones as well? In a separate patch
series, of course.

Regards,
Bjorn

>  
>  /* SDCC_HC_REG_DLL_CONFIG fields */
>  #define SDCC_DLL_CONFIG_DLL_RST			BIT(30)
> @@ -78,6 +79,8 @@
>  #define ETHQOS_MAC_CTRL_SPEED_MODE		BIT(14)
>  #define ETHQOS_MAC_CTRL_PORT_SEL		BIT(15)
>  
> +#define SGMII_10M_RX_CLK_DVDR			0x31
> +
>  struct ethqos_emac_por {
>  	unsigned int offset;
>  	unsigned int value;
> @@ -598,6 +601,9 @@ static int ethqos_configure_rgmii(struct qcom_ethqos *ethqos)
>  	return 0;
>  }
>  
> +/* On interface toggle MAC registers gets reset.
> + * Configure MAC block for SGMII on ethernet phy link up
> + */
>  static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
>  {
>  	int val;
> @@ -617,6 +623,10 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
>  	case SPEED_10:
>  		val |= ETHQOS_MAC_CTRL_PORT_SEL;
>  		val &= ~ETHQOS_MAC_CTRL_SPEED_MODE;
> +		rgmii_updatel(ethqos, RGMII_CONFIG_SGMII_CLK_DVDR,
> +			      FIELD_PREP(RGMII_CONFIG_SGMII_CLK_DVDR,
> +					 SGMII_10M_RX_CLK_DVDR),
> +			      RGMII_IO_MACRO_CONFIG);
>  		break;
>  	}
>  
> -- 
> 2.17.1
> 
