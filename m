Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2DF777B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbjHJOwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjHJOwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:52:36 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99C12106;
        Thu, 10 Aug 2023 07:52:35 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37ACHBbv008415;
        Thu, 10 Aug 2023 16:52:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=uxD1byUTfrhwfQBYzxSaLD/QBU94QFTUviGR6L3yWtk=; b=OM
        94/Fm4Z3mD/XrR7SpHIi8b4+CRVQTx4On2KNdshYzJ/c+SzNoM3Qn08cGc3CIrMg
        /RlRRbo0BO4/d0vx9msdrFYVc0cG1kX4AdL+kT2bSCt+JH35kLaU1FDO+vGdoHnh
        +94ZlKg9U/MRTrKZCZMycBOElY+9dR731ie/Od5RX7/pb/ankpiJ0atgh8DE8AB5
        qNVRx8JooAT8JdZNgXbTsYBxWn45VpashSwx87JKW9P739e4ndKqoKaQEm2bcSru
        ndaIq/eNkmesbWYDGkHevAa0WQ4r465ZhdRSt5NCfpoURtZsZGn8Kt7xyVxmZEkl
        8uiY65WweVbMdT3zP9lw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3scdv7pw6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 16:52:13 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 72F1A100053;
        Thu, 10 Aug 2023 16:52:03 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 68C8C222CB3;
        Thu, 10 Aug 2023 16:52:03 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 10 Aug
 2023 16:52:02 +0200
Message-ID: <a12b6d39-0e26-7bdc-4207-c767342ebcf6@foss.st.com>
Date:   Thu, 10 Aug 2023 16:52:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next v3 06/10] net: stmmac: xgmac: support per-channel
 irq
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230809165007.1439-1-jszhang@kernel.org>
 <20230809165007.1439-7-jszhang@kernel.org>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230809165007.1439-7-jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_12,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 18:50, Jisheng Zhang wrote:
> The IP supports per channel interrupt, add support for this usage case.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 ++
>   .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 33 +++++++++++--------
>   2 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index 81cbb13a101d..12e1228ccf2a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -327,6 +327,8 @@
>   
>   /* DMA Registers */
>   #define XGMAC_DMA_MODE			0x00003000
> +#define XGMAC_INTM			GENMASK(13, 12)
> +#define XGMAC_INTM_MODE1		0x1
>   #define XGMAC_SWR			BIT(0)
>   #define XGMAC_DMA_SYSBUS_MODE		0x00003004
>   #define XGMAC_WR_OSR_LMT		GENMASK(29, 24)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> index b5ba4e0cca55..ef25af92d6cc 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> @@ -31,6 +31,13 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
>   		value |= XGMAC_EAME;
>   
>   	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
> +
> +	if (dma_cfg->perch_irq_en) {
> +		value = readl(ioaddr + XGMAC_DMA_MODE);
> +		value &= ~XGMAC_INTM;
> +		value |= FIELD_PREP(XGMAC_INTM, XGMAC_INTM_MODE1);
> +		writel(value, ioaddr + XGMAC_DMA_MODE);
> +	}
>   }
>   
>   static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
> @@ -365,20 +372,20 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
>   	}
>   
>   	/* TX/RX NORMAL interrupts */
> -	if (likely(intr_status & XGMAC_NIS)) {

No longer need to check NIS bit ?

> -		if (likely(intr_status & XGMAC_RI)) {
> -			u64_stats_update_begin(&rx_q->rxq_stats.syncp);
> -			rx_q->rxq_stats.rx_normal_irq_n++;
> -			u64_stats_update_end(&rx_q->rxq_stats.syncp);
> -			ret |= handle_rx;
> -		}
> -		if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
> -			u64_stats_update_begin(&tx_q->txq_stats.syncp);
> -			tx_q->txq_stats.tx_normal_irq_n++;
> -			u64_stats_update_end(&tx_q->txq_stats.syncp);
> -			ret |= handle_tx;
> -		}
> +	if (likely(intr_status & XGMAC_RI)) {
> +		u64_stats_update_begin(&rx_q->rxq_stats.syncp);
> +		rx_q->rxq_stats.rx_normal_irq_n++;
> +		u64_stats_update_end(&rx_q->rxq_stats.syncp);
> +		ret |= handle_rx;
> +	}
> +	if (likely(intr_status & XGMAC_TI)) {
> +		u64_stats_update_begin(&tx_q->txq_stats.syncp);
> +		tx_q->txq_stats.tx_normal_irq_n++;
> +		u64_stats_update_end(&tx_q->txq_stats.syncp);
> +		ret |= handle_tx;
>   	}
> +	if (unlikely(intr_status & XGMAC_TBU))
> +		ret |= handle_tx;
>   
>   	/* Clear interrupts */
>   	writel(intr_en & intr_status, ioaddr + XGMAC_DMA_CH_STATUS(chan));

