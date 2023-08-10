Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45099777B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbjHJOun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjHJOum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:50:42 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F332106;
        Thu, 10 Aug 2023 07:50:40 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AClMHt009211;
        Thu, 10 Aug 2023 16:50:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=vaMlEgPg5I7tAR2lchils5eu9/vHom1Oza1Aqb5piz0=; b=ol
        Rb6IntAJLXule+Rlxb42pIQj6Z7ZStYQNTuxbKu2MO3VZo5jqD8H1+j/7xvCmyCl
        4AO/chBZoIfgebJ5w9whaEd474CKHua8xlv3DQkGFLM3zH+vEpww7IQHnVjk8Rea
        FrwKNQVzodeSGy0zwjzK3zItpC8EKze4hY+U+kfLq/F6R8c4QA1Nkl2DRcvD0m5b
        PLG0EupWIXPqrTinH84cFF6lkkXP4WXvg57iNNw5dWUeA7O9/brudZlYsjEBJptZ
        +lVl0r1idkGDN879nPy2bjUcfz+S3rlnzT6x0u86iHNjZWlTzbU5/Uojb/2+iM9h
        /KKbGfiIUEmyWWR8ph2Q==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sd0730nj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 16:50:21 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6AF67100057;
        Thu, 10 Aug 2023 16:50:20 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5CE47222CB0;
        Thu, 10 Aug 2023 16:50:20 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 10 Aug
 2023 16:50:19 +0200
Message-ID: <cc4ae254-659d-54d6-5007-155390d006d8@foss.st.com>
Date:   Thu, 10 Aug 2023 16:50:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next v3 05/10] net: stmmac: reflect multi irqs for
 tx/rx channels and mac and safety
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
 <20230809165007.1439-6-jszhang@kernel.org>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230809165007.1439-6-jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_11,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 18:50, Jisheng Zhang wrote:
> The IP supports per channel interrupt, when intel adds the per channel
> interrupt support, the per channel irq is from MSI vector, but this
> feature can also be supported on non-MSI platforms. Do some necessary
> renaming to reflects this fact.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  4 +-
>   .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  2 +-
>   .../net/ethernet/stmicro/stmmac/stmmac_main.c | 48 +++++++++----------
>   include/linux/stmmac.h                        |  4 +-
>   4 files changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> index 0ffae785d8bd..99a072907008 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> @@ -953,7 +953,7 @@ static int stmmac_config_single_msi(struct pci_dev *pdev,
>   
>   	res->irq = pci_irq_vector(pdev, 0);
>   	res->wol_irq = res->irq;
> -	plat->flags &= ~STMMAC_FLAG_MULTI_MSI_EN;
> +	plat->flags &= ~STMMAC_FLAG_PERCH_IRQ_EN;
>   	dev_info(&pdev->dev, "%s: Single IRQ enablement successful\n",
>   		 __func__);
>   
> @@ -1005,7 +1005,7 @@ static int stmmac_config_multi_msi(struct pci_dev *pdev,
>   	if (plat->msi_sfty_ue_vec < STMMAC_MSI_VEC_MAX)
>   		res->sfty_ue_irq = pci_irq_vector(pdev, plat->msi_sfty_ue_vec);
>   
> -	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> +	plat->flags |= STMMAC_FLAG_PERCH_IRQ_EN;
>   	dev_info(&pdev->dev, "%s: multi MSI enablement successful\n", __func__);
>   
>   	return 0;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> index 84d3a8551b03..9bf8adf466a2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> @@ -175,7 +175,7 @@ static void dwmac4_dma_init(void __iomem *ioaddr,
>   
>   	value = readl(ioaddr + DMA_BUS_MODE);
>   
> -	if (dma_cfg->multi_msi_en) {
> +	if (dma_cfg->perch_irq_en) {
>   		value &= ~DMA_BUS_MODE_INTM_MASK;
>   		value |= (DMA_BUS_MODE_INTM_MODE1 << DMA_BUS_MODE_INTM_SHIFT);
>   	}
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 15ed3947361b..4ed5c976c7a3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -125,11 +125,11 @@ module_param(chain_mode, int, 0444);
>   MODULE_PARM_DESC(chain_mode, "To use chain instead of ring mode");
>   
>   static irqreturn_t stmmac_interrupt(int irq, void *dev_id);
> -/* For MSI interrupts handling */
> +/* For multi interrupts handling */
>   static irqreturn_t stmmac_mac_interrupt(int irq, void *dev_id);
>   static irqreturn_t stmmac_safety_interrupt(int irq, void *dev_id);
> -static irqreturn_t stmmac_msi_intr_tx(int irq, void *data);
> -static irqreturn_t stmmac_msi_intr_rx(int irq, void *data);
> +static irqreturn_t stmmac_queue_intr_tx(int irq, void *data);
> +static irqreturn_t stmmac_queue_intr_rx(int irq, void *data);
>   static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32 queue);
>   static void stmmac_reset_tx_queue(struct stmmac_priv *priv, u32 queue);
>   static void stmmac_reset_queues_param(struct stmmac_priv *priv);
> @@ -3513,7 +3513,7 @@ static void stmmac_free_irq(struct net_device *dev,
>   	}
>   }
>   
> -static int stmmac_request_irq_multi_msi(struct net_device *dev)
> +static int stmmac_request_irq_multi(struct net_device *dev)

What mean "irq_multi". You change previously "multi_msi" by "perch_irq", 
maybe you could do something with this "perch" naming ?

>   {
>   	struct stmmac_priv *priv = netdev_priv(dev);
>   	enum request_irq_err irq_err;
> @@ -3530,7 +3530,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>   			  0, int_name, dev);
>   	if (unlikely(ret < 0)) {
>   		netdev_err(priv->dev,
> -			   "%s: alloc mac MSI %d (error: %d)\n",
> +			   "%s: alloc mac irq %d (error: %d)\n",
>   			   __func__, dev->irq, ret);
>   		irq_err = REQ_IRQ_ERR_MAC;
>   		goto irq_error;
> @@ -3547,7 +3547,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>   				  0, int_name, dev);
>   		if (unlikely(ret < 0)) {
>   			netdev_err(priv->dev,
> -				   "%s: alloc wol MSI %d (error: %d)\n",
> +				   "%s: alloc wol irq %d (error: %d)\n",
>   				   __func__, priv->wol_irq, ret);
>   			irq_err = REQ_IRQ_ERR_WOL;
>   			goto irq_error;
> @@ -3565,7 +3565,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>   				  0, int_name, dev);
>   		if (unlikely(ret < 0)) {
>   			netdev_err(priv->dev,
> -				   "%s: alloc lpi MSI %d (error: %d)\n",
> +				   "%s: alloc lpi irq %d (error: %d)\n",
>   				   __func__, priv->lpi_irq, ret);
>   			irq_err = REQ_IRQ_ERR_LPI;
>   			goto irq_error;
> @@ -3583,7 +3583,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>   				  0, int_name, dev);
>   		if (unlikely(ret < 0)) {
>   			netdev_err(priv->dev,
> -				   "%s: alloc sfty ce MSI %d (error: %d)\n",
> +				   "%s: alloc sfty ce irq %d (error: %d)\n",
>   				   __func__, priv->sfty_ce_irq, ret);
>   			irq_err = REQ_IRQ_ERR_SFTY_CE;
>   			goto irq_error;
> @@ -3601,14 +3601,14 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>   				  0, int_name, dev);
>   		if (unlikely(ret < 0)) {
>   			netdev_err(priv->dev,
> -				   "%s: alloc sfty ue MSI %d (error: %d)\n",
> +				   "%s: alloc sfty ue irq %d (error: %d)\n",
>   				   __func__, priv->sfty_ue_irq, ret);
>   			irq_err = REQ_IRQ_ERR_SFTY_UE;
>   			goto irq_error;
>   		}
>   	}
>   
> -	/* Request Rx MSI irq */
> +	/* Request Rx queue irq */
>   	for (i = 0; i < priv->plat->rx_queues_to_use; i++) {
>   		if (i >= MTL_MAX_RX_QUEUES)
>   			break;
> @@ -3618,11 +3618,11 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>   		int_name = priv->int_name_rx_irq[i];
>   		sprintf(int_name, "%s:%s-%d", dev->name, "rx", i);
>   		ret = request_irq(priv->rx_irq[i],
> -				  stmmac_msi_intr_rx,
> +				  stmmac_queue_intr_rx,
>   				  0, int_name, &priv->dma_conf.rx_queue[i]);
>   		if (unlikely(ret < 0)) {
>   			netdev_err(priv->dev,
> -				   "%s: alloc rx-%d  MSI %d (error: %d)\n",
> +				   "%s: alloc rx-%d irq %d (error: %d)\n",
>   				   __func__, i, priv->rx_irq[i], ret);
>   			irq_err = REQ_IRQ_ERR_RX;
>   			irq_idx = i;
> @@ -3633,7 +3633,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>   		irq_set_affinity_hint(priv->rx_irq[i], &cpu_mask);
>   	}
>   
> -	/* Request Tx MSI irq */
> +	/* Request Tx queue irq */
>   	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
>   		if (i >= MTL_MAX_TX_QUEUES)
>   			break;
> @@ -3643,11 +3643,11 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>   		int_name = priv->int_name_tx_irq[i];
>   		sprintf(int_name, "%s:%s-%d", dev->name, "tx", i);
>   		ret = request_irq(priv->tx_irq[i],
> -				  stmmac_msi_intr_tx,
> +				  stmmac_queue_intr_tx,
>   				  0, int_name, &priv->dma_conf.tx_queue[i]);
>   		if (unlikely(ret < 0)) {
>   			netdev_err(priv->dev,
> -				   "%s: alloc tx-%d  MSI %d (error: %d)\n",
> +				   "%s: alloc tx-%d irq %d (error: %d)\n",
>   				   __func__, i, priv->tx_irq[i], ret);
>   			irq_err = REQ_IRQ_ERR_TX;
>   			irq_idx = i;
> @@ -3722,8 +3722,8 @@ static int stmmac_request_irq(struct net_device *dev)
>   	int ret;
>   
>   	/* Request the IRQ lines */
> -	if (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN)
> -		ret = stmmac_request_irq_multi_msi(dev);
> +	if (priv->plat->flags & STMMAC_FLAG_PERCH_IRQ_EN)
> +		ret = stmmac_request_irq_multi(dev);
>   	else
>   		ret = stmmac_request_irq_single(dev);
>   
> @@ -5938,7 +5938,7 @@ static irqreturn_t stmmac_safety_interrupt(int irq, void *dev_id)
>   	return IRQ_HANDLED;
>   }
>   
> -static irqreturn_t stmmac_msi_intr_tx(int irq, void *data)
> +static irqreturn_t stmmac_queue_intr_tx(int irq, void *data)
>   {
>   	struct stmmac_tx_queue *tx_q = (struct stmmac_tx_queue *)data;
>   	struct stmmac_dma_conf *dma_conf;
> @@ -5970,7 +5970,7 @@ static irqreturn_t stmmac_msi_intr_tx(int irq, void *data)
>   	return IRQ_HANDLED;
>   }
>   
> -static irqreturn_t stmmac_msi_intr_rx(int irq, void *data)
> +static irqreturn_t stmmac_queue_intr_rx(int irq, void *data)
>   {
>   	struct stmmac_rx_queue *rx_q = (struct stmmac_rx_queue *)data;
>   	struct stmmac_dma_conf *dma_conf;
> @@ -6007,12 +6007,12 @@ static void stmmac_poll_controller(struct net_device *dev)
>   	if (test_bit(STMMAC_DOWN, &priv->state))
>   		return;
>   
> -	if (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN) {
> +	if (priv->plat->flags & STMMAC_FLAG_PERCH_IRQ_EN) {
>   		for (i = 0; i < priv->plat->rx_queues_to_use; i++)
> -			stmmac_msi_intr_rx(0, &priv->dma_conf.rx_queue[i]);
> +			stmmac_queue_intr_rx(0, &priv->dma_conf.rx_queue[i]);
>   
>   		for (i = 0; i < priv->plat->tx_queues_to_use; i++)
> -			stmmac_msi_intr_tx(0, &priv->dma_conf.tx_queue[i]);
> +			stmmac_queue_intr_tx(0, &priv->dma_conf.tx_queue[i]);
>   	} else {
>   		disable_irq(dev->irq);
>   		stmmac_interrupt(dev->irq, dev);
> @@ -7278,8 +7278,8 @@ int stmmac_dvr_probe(struct device *device,
>   	priv->plat = plat_dat;
>   	priv->ioaddr = res->addr;
>   	priv->dev->base_addr = (unsigned long)res->addr;
> -	priv->plat->dma_cfg->multi_msi_en =
> -		(priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN);
> +	priv->plat->dma_cfg->perch_irq_en =
> +		(priv->plat->flags & STMMAC_FLAG_PERCH_IRQ_EN);
>   
>   	priv->dev->irq = res->irq;
>   	priv->wol_irq = res->wol_irq;
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 11671fd6adee..76249117c0ff 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -96,7 +96,7 @@ struct stmmac_dma_cfg {
>   	int mixed_burst;
>   	bool aal;
>   	bool eame;
> -	bool multi_msi_en;
> +	bool perch_irq_en;
>   	bool dche;
>   };
>   
> @@ -211,7 +211,7 @@ struct dwmac4_addrs {
>   #define STMMAC_FLAG_TSO_EN			BIT(4)
>   #define STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP	BIT(5)
>   #define STMMAC_FLAG_VLAN_FAIL_Q_EN		BIT(6)
> -#define STMMAC_FLAG_MULTI_MSI_EN		BIT(7)
> +#define STMMAC_FLAG_PERCH_IRQ_EN		BIT(7)
>   #define STMMAC_FLAG_EXT_SNAPSHOT_EN		BIT(8)
>   #define STMMAC_FLAG_INT_SNAPSHOT_EN		BIT(9)
>   #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)

