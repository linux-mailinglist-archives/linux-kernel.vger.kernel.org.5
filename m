Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BABB77E5FA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244192AbjHPQE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344495AbjHPQEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:04:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA11121;
        Wed, 16 Aug 2023 09:04:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B443664904;
        Wed, 16 Aug 2023 16:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90265C433C8;
        Wed, 16 Aug 2023 16:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692201879;
        bh=4Zp3gWJ/UNXl5LmVpCbTdj3eqr5kWiHHc7k0ReSn3hQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OdpNHr+CytMtoJpZeiAl2Xzi7+pDId7Xfjb/3bZi8Pk+XWouoXSg9a0POUmnKK8gK
         OcEephfmv973Ybjmgpmuw41k/dYlLPEoZBlRChm34EsmWn2GrifjY+cu6oGNAcj2iL
         yvl1HfXQFX1oVYxsFaFsda2FVI4l+03j9ERhPGMus+ri/E5ah7C1JLAadr/LTYE6NK
         r09mWMjaoFOrWOKTgJGMpmiRDwOzOIdg4JCkytUL61ndvuQYLeRJrJZXIYOIuBZw7T
         ew5tURaBN7HSkAWt7eFw8H8tSWC+0A3uKowil81GNaAOWA5a0ytyeF5GaWTP/fZZyA
         bVnJ+wQ04434g==
Date:   Wed, 16 Aug 2023 23:52:53 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 06/10] net: stmmac: xgmac: support
 per-channel irq
Message-ID: <ZNzw1cqmGQaKpfGi@xhacker>
References: <20230809165007.1439-1-jszhang@kernel.org>
 <20230809165007.1439-7-jszhang@kernel.org>
 <a12b6d39-0e26-7bdc-4207-c767342ebcf6@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a12b6d39-0e26-7bdc-4207-c767342ebcf6@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 04:52:01PM +0200, Alexandre TORGUE wrote:
> On 8/9/23 18:50, Jisheng Zhang wrote:
> > The IP supports per channel interrupt, add support for this usage case.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >   .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 ++
> >   .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 33 +++++++++++--------
> >   2 files changed, 22 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > index 81cbb13a101d..12e1228ccf2a 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > @@ -327,6 +327,8 @@
> >   /* DMA Registers */
> >   #define XGMAC_DMA_MODE			0x00003000
> > +#define XGMAC_INTM			GENMASK(13, 12)
> > +#define XGMAC_INTM_MODE1		0x1
> >   #define XGMAC_SWR			BIT(0)
> >   #define XGMAC_DMA_SYSBUS_MODE		0x00003004
> >   #define XGMAC_WR_OSR_LMT		GENMASK(29, 24)
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> > index b5ba4e0cca55..ef25af92d6cc 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> > @@ -31,6 +31,13 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
> >   		value |= XGMAC_EAME;
> >   	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
> > +
> > +	if (dma_cfg->perch_irq_en) {
> > +		value = readl(ioaddr + XGMAC_DMA_MODE);
> > +		value &= ~XGMAC_INTM;
> > +		value |= FIELD_PREP(XGMAC_INTM, XGMAC_INTM_MODE1);
> > +		writel(value, ioaddr + XGMAC_DMA_MODE);
> > +	}
> >   }
> >   static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
> > @@ -365,20 +372,20 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
> >   	}
> >   	/* TX/RX NORMAL interrupts */
> > -	if (likely(intr_status & XGMAC_NIS)) {
> 
> No longer need to check NIS bit ?

Hi Alexandre,

NIS is RI | TI | TBU, since we have checked these three
bits we can ignore NIS. And dwmac4 behaves similarly.

Thanks

> 
> > -		if (likely(intr_status & XGMAC_RI)) {
> > -			u64_stats_update_begin(&rx_q->rxq_stats.syncp);
> > -			rx_q->rxq_stats.rx_normal_irq_n++;
> > -			u64_stats_update_end(&rx_q->rxq_stats.syncp);
> > -			ret |= handle_rx;
> > -		}
> > -		if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
> > -			u64_stats_update_begin(&tx_q->txq_stats.syncp);
> > -			tx_q->txq_stats.tx_normal_irq_n++;
> > -			u64_stats_update_end(&tx_q->txq_stats.syncp);
> > -			ret |= handle_tx;
> > -		}
> > +	if (likely(intr_status & XGMAC_RI)) {
> > +		u64_stats_update_begin(&rx_q->rxq_stats.syncp);
> > +		rx_q->rxq_stats.rx_normal_irq_n++;
> > +		u64_stats_update_end(&rx_q->rxq_stats.syncp);
> > +		ret |= handle_rx;
> > +	}
> > +	if (likely(intr_status & XGMAC_TI)) {
> > +		u64_stats_update_begin(&tx_q->txq_stats.syncp);
> > +		tx_q->txq_stats.tx_normal_irq_n++;
> > +		u64_stats_update_end(&tx_q->txq_stats.syncp);
> > +		ret |= handle_tx;
> >   	}
> > +	if (unlikely(intr_status & XGMAC_TBU))
> > +		ret |= handle_tx;
> >   	/* Clear interrupts */
> >   	writel(intr_en & intr_status, ioaddr + XGMAC_DMA_CH_STATUS(chan));
> 
