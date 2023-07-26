Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A5876290A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjGZDGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjGZDGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:06:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8AD1BDA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 20:06:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6017E61176
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096C8C433C8;
        Wed, 26 Jul 2023 03:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690340767;
        bh=NEOYLP0iznHbMTzUU1WZ7txltHSA0/SCINhS/IbFbPU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KKKZzkFQ3GhIJTIU/R3X+a3LwSNBQmigXdNNLlKxV3HynLFUp12f+shUAsV7nxE2T
         apogwZkAs2KQ7wfnRbRWr95TdgVmepWi1R23/+XyUiIQApr01h3GCVXlM1x0mle4wU
         WC7tz3XK5lZzP6O+MgSwphNVisONDwNgpT8o4E3c/zvDlFie7x7rBfjQAr/dzM8QC3
         7Kz85d6c0k9fSbOT7eGKSYnfpBtkIJGLGQSbMEi/gF+W5URn93dyKZWXACYKSl88jZ
         gpYYGeENSvyhTtEjLdl7Qmd7I7dpB44Wh3pYaT1tvdFCwWmIcDeS2MsWL1o/OkGC7J
         XOTvSM0taNrOw==
Date:   Tue, 25 Jul 2023 20:06:06 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Johannes Zink <j.zink@pengutronix.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] net: stmmac: correct MAC propagation delay
Message-ID: <20230725200606.5264b59c@kernel.org>
In-Reply-To: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
References: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2023 12:01:31 +0200 Johannes Zink wrote:
> The IEEE1588 Standard specifies that the timestamps of Packets must be
> captured when the PTP message timestamp point (leading edge of first
> octet after the start of frame delimiter) crosses the boundary between
> the node and the network. As the MAC latches the timestamp at an
> internal point, the captured timestamp must be corrected for the
> additional path latency, as described in the publicly available
> datasheet [1].
> 
> This patch only corrects for the MAC-Internal delay, which can be read
> out from the MAC_Ingress_Timestamp_Latency register, since the Phy
> framework currently does not support querying the Phy ingress and egress
> latency. The Closs Domain Crossing Circuits errors as indicated in [1]
> are already being accounted in the stmmac_get_tx_hwtstamp() function and
> are not corrected here.
> 
> As the Latency varies for different link speeds and MII
> modes of operation, the correction value needs to be updated on each
> link state change.
> 
> As the delay also causes a phase shift in the timestamp counter compared
> to the rest of the network, this correction will also reduce phase error
> when generating PPS outputs from the timestamp counter.
> 
> [1] i.MX8MP Reference Manual, rev.1 Section 11.7.2.5.3 "Timestamp
> correction"

Hi Richard,

any opinion on this one?

The subject read to me like it's about *MII clocking delays, I figured
you may have missed it, too.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index 6ee7cf07cfd7..95a4d6099577 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -536,6 +536,7 @@ struct stmmac_hwtimestamp {
>  	void (*get_systime) (void __iomem *ioaddr, u64 *systime);
>  	void (*get_ptptime)(void __iomem *ioaddr, u64 *ptp_time);
>  	void (*timestamp_interrupt)(struct stmmac_priv *priv);
> +	void (*correct_latency)(struct stmmac_priv *priv);
>  };
>  
>  #define stmmac_config_hw_tstamping(__priv, __args...) \
> @@ -554,6 +555,8 @@ struct stmmac_hwtimestamp {
>  	stmmac_do_void_callback(__priv, ptp, get_ptptime, __args)
>  #define stmmac_timestamp_interrupt(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, ptp, timestamp_interrupt, __args)
> +#define stmmac_correct_latency(__priv, __args...) \
> +	stmmac_do_void_callback(__priv, ptp, correct_latency, __args)
>  
>  struct stmmac_tx_queue;
>  struct stmmac_rx_queue;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
> index fa2c3ba7e9fe..7e0fa024e0ad 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
> @@ -60,6 +60,48 @@ static void config_sub_second_increment(void __iomem *ioaddr,
>  		*ssinc = data;
>  }
>  
> +static void correct_latency(struct stmmac_priv *priv)
> +{
> +	void __iomem *ioaddr = priv->ptpaddr;
> +	u32 reg_tsic, reg_tsicsns;
> +	u32 reg_tsec, reg_tsecsns;
> +	u64 scaled_ns;
> +	u32 val;
> +
> +	/* MAC-internal ingress latency */
> +	scaled_ns = readl(ioaddr + PTP_TS_INGR_LAT);
> +
> +	/* See section 11.7.2.5.3.1 "Ingress Correction" on page 4001 of
> +	 * i.MX8MP Applications Processor Reference Manual Rev. 1, 06/2021
> +	 */
> +	val = readl(ioaddr + PTP_TCR);
> +	if (val & PTP_TCR_TSCTRLSSR)
> +		/* nanoseconds field is in decimal format with granularity of 1ns/bit */
> +		scaled_ns = ((u64)NSEC_PER_SEC << 16) - scaled_ns;
> +	else
> +		/* nanoseconds field is in binary format with granularity of ~0.466ns/bit */
> +		scaled_ns = ((1ULL << 31) << 16) -
> +			DIV_U64_ROUND_CLOSEST(scaled_ns * PSEC_PER_NSEC, 466U);
> +
> +	reg_tsic = scaled_ns >> 16;
> +	reg_tsicsns = scaled_ns & 0xff00;
> +
> +	/* set bit 31 for 2's compliment */
> +	reg_tsic |= BIT(31);
> +
> +	writel(reg_tsic, ioaddr + PTP_TS_INGR_CORR_NS);
> +	writel(reg_tsicsns, ioaddr + PTP_TS_INGR_CORR_SNS);
> +
> +	/* MAC-internal egress latency */
> +	scaled_ns = readl(ioaddr + PTP_TS_EGR_LAT);
> +
> +	reg_tsec = scaled_ns >> 16;
> +	reg_tsecsns = scaled_ns & 0xff00;
> +
> +	writel(reg_tsec, ioaddr + PTP_TS_EGR_CORR_NS);
> +	writel(reg_tsecsns, ioaddr + PTP_TS_EGR_CORR_SNS);
> +}
> +
>  static int init_systime(void __iomem *ioaddr, u32 sec, u32 nsec)
>  {
>  	u32 value;
> @@ -221,4 +263,5 @@ const struct stmmac_hwtimestamp stmmac_ptp = {
>  	.get_systime = get_systime,
>  	.get_ptptime = get_ptptime,
>  	.timestamp_interrupt = timestamp_interrupt,
> +	.correct_latency = correct_latency,
>  };
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index efe85b086abe..ee78e69e9ae3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -909,6 +909,8 @@ static int stmmac_init_ptp(struct stmmac_priv *priv)
>  	priv->hwts_tx_en = 0;
>  	priv->hwts_rx_en = 0;
>  
> +	stmmac_correct_latency(priv, priv);
> +
>  	return 0;
>  }
>  
> @@ -1094,6 +1096,8 @@ static void stmmac_mac_link_up(struct phylink_config *config,
>  
>  	if (priv->dma_cap.fpesel)
>  		stmmac_fpe_link_state_handle(priv, true);
> +
> +	stmmac_correct_latency(priv, priv);
>  }
>  
>  static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
> index bf619295d079..d1fe4b46f162 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
> @@ -26,6 +26,12 @@
>  #define	PTP_ACR		0x40	/* Auxiliary Control Reg */
>  #define	PTP_ATNR	0x48	/* Auxiliary Timestamp - Nanoseconds Reg */
>  #define	PTP_ATSR	0x4c	/* Auxiliary Timestamp - Seconds Reg */
> +#define	PTP_TS_INGR_CORR_NS	0x58	/* Ingress timestamp correction nanoseconds */
> +#define	PTP_TS_EGR_CORR_NS	0x5C	/* Egress timestamp correction nanoseconds*/
> +#define	PTP_TS_INGR_CORR_SNS	0x60	/* Ingress timestamp correction subnanoseconds */
> +#define	PTP_TS_EGR_CORR_SNS	0x64	/* Egress timestamp correction subnanoseconds */
> +#define	PTP_TS_INGR_LAT	0x68	/* MAC internal Ingress Latency */
> +#define	PTP_TS_EGR_LAT	0x6c	/* MAC internal Egress Latency */
>  
>  #define	PTP_STNSUR_ADDSUB_SHIFT	31
>  #define	PTP_DIGITAL_ROLLOVER_MODE	0x3B9ACA00	/* 10e9-1 ns */
> 
> ---
> base-commit: ba80e20d7f3f87dab3f9f0c0ca66e4b1fcc7be9f
> change-id: 20230719-stmmac_correct_mac_delay-4278cb9d9bc1
> 
> Best regards,

