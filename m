Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E957778E1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjHJM4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjHJM4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:56:23 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6616C5;
        Thu, 10 Aug 2023 05:56:21 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37AAnqUE010476;
        Thu, 10 Aug 2023 14:55:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=UJlI3EefGPgqyNpz7znYrTGmMrOIMm3+GM2TKKWSEuc=; b=pk
        CjdEjMFdARe67kfgj7f8hUvXDjuzy3CNBx8udKNVcG08xMkEajRMbhSyhW6N2L4V
        rio2rBSVZhgPxfYVEnfzcO8aJmmGW63jVXoH6kR4XWFuVTRhx5jXL+SvJjQALVgC
        Z7PqKFcxeW57DWqri6zKAXc76925m6SNzBRp8t1qOsMfj+hKZQ2h+2+JbO0cpyCr
        1ZTgOnEi+/7/cbOWSDIh+88jojPnAP/HKRuXA7ZQi/JFHju6CCJ6LXpWMrAN2V5f
        aeYcnh15wNOxEY57ZF+vIYJkBl/vUGxnNxoVwwHvOnKJShqZrtc69lj1cGxWg5F4
        Pu78Rz4+j9cj1CLVxuAA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sctu3tbxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 14:55:35 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E69D4100057;
        Thu, 10 Aug 2023 14:55:34 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AA32421A907;
        Thu, 10 Aug 2023 14:55:34 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 10 Aug
 2023 14:55:33 +0200
Message-ID: <520b37d5-16fe-7113-2405-efa6fc393e5f@foss.st.com>
Date:   Thu, 10 Aug 2023 14:55:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] net: stmmac: dwmac4: extract MAC_HW_Feature regs MSB
 first
Content-Language: en-US
To:     Furong Xu <0x1207@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Simon Horman <horms@kernel.org>
CC:     <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <xfr@outlook.com>,
        <rock.xu@nio.com>
References: <20230810095929.246901-1-0x1207@gmail.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230810095929.246901-1-0x1207@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_10,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Furong

On 8/10/23 11:59, Furong Xu wrote:
> The bit extraction sequences are a little messy.
> No code changes, just reorder them.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>   .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  | 54 +++++++++----------
>   1 file changed, 26 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> index 84d3a8551b03..3d9e20078193 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> @@ -379,27 +379,27 @@ static int dwmac4_get_hw_feature(void __iomem *ioaddr,
>   {
>   	u32 hw_cap = readl(ioaddr + GMAC_HW_FEATURE0);
>   
> -	/*  MAC HW feature0 */

Why to not start with the LSB ?

> -	dma_cap->mbps_10_100 = (hw_cap & GMAC_HW_FEAT_MIISEL);
> -	dma_cap->mbps_1000 = (hw_cap & GMAC_HW_FEAT_GMIISEL) >> 1;
> -	dma_cap->half_duplex = (hw_cap & GMAC_HW_FEAT_HDSEL) >> 2;
> -	dma_cap->vlhash = (hw_cap & GMAC_HW_FEAT_VLHASH) >> 4;
> +	/* MAC HW feature0 */
> +	dma_cap->vlins = (hw_cap & GMAC_HW_FEAT_SAVLANINS) >> 27;
>   	dma_cap->multi_addr = (hw_cap & GMAC_HW_FEAT_ADDMAC) >> 18;
> -	dma_cap->pcs = (hw_cap & GMAC_HW_FEAT_PCSSEL) >> 3;
> -	dma_cap->sma_mdio = (hw_cap & GMAC_HW_FEAT_SMASEL) >> 5;
> -	dma_cap->pmt_remote_wake_up = (hw_cap & GMAC_HW_FEAT_RWKSEL) >> 6;
> -	dma_cap->pmt_magic_frame = (hw_cap & GMAC_HW_FEAT_MGKSEL) >> 7;
> -	/* MMC */
> -	dma_cap->rmon = (hw_cap & GMAC_HW_FEAT_MMCSEL) >> 8;
> -	/* IEEE 1588-2008 */
> -	dma_cap->atime_stamp = (hw_cap & GMAC_HW_FEAT_TSSEL) >> 12;
> -	/* 802.3az - Energy-Efficient Ethernet (EEE) */
> -	dma_cap->eee = (hw_cap & GMAC_HW_FEAT_EEESEL) >> 13;
>   	/* TX and RX csum */
> -	dma_cap->tx_coe = (hw_cap & GMAC_HW_FEAT_TXCOSEL) >> 14;
>   	dma_cap->rx_coe =  (hw_cap & GMAC_HW_FEAT_RXCOESEL) >> 16;
> -	dma_cap->vlins = (hw_cap & GMAC_HW_FEAT_SAVLANINS) >> 27;
> +	dma_cap->tx_coe = (hw_cap & GMAC_HW_FEAT_TXCOSEL) >> 14;
> +	/* 802.3az - Energy-Efficient Ethernet (EEE) */
> +	dma_cap->eee = (hw_cap & GMAC_HW_FEAT_EEESEL) >> 13;
> +	/* IEEE 1588-2008 */
> +	dma_cap->atime_stamp = (hw_cap & GMAC_HW_FEAT_TSSEL) >> 12;
>   	dma_cap->arpoffsel = (hw_cap & GMAC_HW_FEAT_ARPOFFSEL) >> 9;
> +	/* MMC */
> +	dma_cap->rmon = (hw_cap & GMAC_HW_FEAT_MMCSEL) >> 8;
> +	dma_cap->pmt_magic_frame = (hw_cap & GMAC_HW_FEAT_MGKSEL) >> 7;
> +	dma_cap->pmt_remote_wake_up = (hw_cap & GMAC_HW_FEAT_RWKSEL) >> 6;
> +	dma_cap->sma_mdio = (hw_cap & GMAC_HW_FEAT_SMASEL) >> 5;
> +	dma_cap->vlhash = (hw_cap & GMAC_HW_FEAT_VLHASH) >> 4;
> +	dma_cap->pcs = (hw_cap & GMAC_HW_FEAT_PCSSEL) >> 3;
> +	dma_cap->half_duplex = (hw_cap & GMAC_HW_FEAT_HDSEL) >> 2;
> +	dma_cap->mbps_1000 = (hw_cap & GMAC_HW_FEAT_GMIISEL) >> 1;
> +	dma_cap->mbps_10_100 = (hw_cap & GMAC_HW_FEAT_MIISEL);
>   
>   	/* MAC HW feature1 */
>   	hw_cap = readl(ioaddr + GMAC_HW_FEATURE1);
> @@ -408,7 +408,6 @@ static int dwmac4_get_hw_feature(void __iomem *ioaddr,
>   	dma_cap->av = (hw_cap & GMAC_HW_FEAT_AVSEL) >> 20;
>   	dma_cap->tsoen = (hw_cap & GMAC_HW_TSOEN) >> 18;
>   	dma_cap->sphen = (hw_cap & GMAC_HW_FEAT_SPHEN) >> 17;
> -
>   	dma_cap->addr64 = (hw_cap & GMAC_HW_ADDR64) >> 14;
>   	switch (dma_cap->addr64) {
>   	case 0:
> @@ -424,31 +423,30 @@ static int dwmac4_get_hw_feature(void __iomem *ioaddr,
>   		dma_cap->addr64 = 32;
>   		break;
>   	}
> -
>   	/* RX and TX FIFO sizes are encoded as log2(n / 128). Undo that by
>   	 * shifting and store the sizes in bytes.
>   	 */
>   	dma_cap->tx_fifo_size = 128 << ((hw_cap & GMAC_HW_TXFIFOSIZE) >> 6);
>   	dma_cap->rx_fifo_size = 128 << ((hw_cap & GMAC_HW_RXFIFOSIZE) >> 0);
> +
>   	/* MAC HW feature2 */
>   	hw_cap = readl(ioaddr + GMAC_HW_FEATURE2);
> +	/* Number of Auxiliary Snapshot Inputs */
> +	dma_cap->aux_snapshot_n = (hw_cap & GMAC_HW_FEAT_AUXSNAPNUM) >> 28;
> +	/* PPS output */
> +	dma_cap->pps_out_num = (hw_cap & GMAC_HW_FEAT_PPSOUTNUM) >> 24;
>   	/* TX and RX number of channels */
> -	dma_cap->number_rx_channel =
> -		((hw_cap & GMAC_HW_FEAT_RXCHCNT) >> 12) + 1;
>   	dma_cap->number_tx_channel =
>   		((hw_cap & GMAC_HW_FEAT_TXCHCNT) >> 18) + 1;
> +	dma_cap->number_rx_channel =
> +		((hw_cap & GMAC_HW_FEAT_RXCHCNT) >> 12) + 1;
>   	/* TX and RX number of queues */
> -	dma_cap->number_rx_queues =
> -		((hw_cap & GMAC_HW_FEAT_RXQCNT) >> 0) + 1;
>   	dma_cap->number_tx_queues =
>   		((hw_cap & GMAC_HW_FEAT_TXQCNT) >> 6) + 1;
> -	/* PPS output */
> -	dma_cap->pps_out_num = (hw_cap & GMAC_HW_FEAT_PPSOUTNUM) >> 24;
> -
> +	dma_cap->number_rx_queues =
> +		((hw_cap & GMAC_HW_FEAT_RXQCNT) >> 0) + 1;
>   	/* IEEE 1588-2002 */
>   	dma_cap->time_stamp = 0;
> -	/* Number of Auxiliary Snapshot Inputs */
> -	dma_cap->aux_snapshot_n = (hw_cap & GMAC_HW_FEAT_AUXSNAPNUM) >> 28;
>   
>   	/* MAC HW feature3 */
>   	hw_cap = readl(ioaddr + GMAC_HW_FEATURE3);

