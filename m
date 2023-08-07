Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7617728E8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjHGPTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjHGPTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:19:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E982610DE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:18:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 796CE61DF2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 15:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275B4C433C7;
        Mon,  7 Aug 2023 15:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691421538;
        bh=Ol5bMly7ZqSw89nfp8mGDx2BhxDc6aLMJTh/iG345hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YRp/HqOwWwHkISGl6UlLg2lhuOJ3o0X4pe3nR6DzFJ6au08VpBT9ZQPWXQ2jgpCEz
         8IZLlaeQVQNCQrn9p49EF7NkJQ3aZ0m0DG+RdLt5rKwOAfWinT8Q24WbwuqofDvtpR
         itQgofis4FrIyi0nxdIEdKehqg9yJATp6vdSotCLcjsjbu9cMXulryywabJ2OgQYr5
         gRBBPX6y9ROcoTv5J2E3HSKQcQyCSK7f7qoF7Brg5Mv81gdJL8OKWyXnRVMJ4/omNJ
         sPbQQzirY9MYcN1gFDpaZVQPqQ4XsPapJ1kycY9apdtExhLO4rQ7Rpbhpe6bqHSZHI
         RYwJTvM+Grrlw==
Date:   Mon, 7 Aug 2023 17:18:53 +0200
From:   Simon Horman <horms@kernel.org>
To:     Furong Xu <0x1207@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH] net: stmmac: xgmac: RX queue routing configuration
Message-ID: <ZNELXd4I8r+YlWXP@vergenet.net>
References: <20230807065609.1096076-1-0x1207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807065609.1096076-1-0x1207@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 02:56:09PM +0800, Furong Xu wrote:
> Commit abe80fdc6ee6 ("net: stmmac: RX queue routing configuration")
> introduced RX queue routing to DWMAC4 core.
> This patch extend the support to XGMAC2 core.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>

Hi Furong Xu,

as this is a feature for a Networking it (probably) should
be targeted at net-next - as opposed to net, which is for bug fixes.
The target tree should be included in the subject.

  Subject: [PATCH net-next] ...

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index a0c2ef8bb0ac..24918d95f612 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -127,6 +127,39 @@ static void dwxgmac2_tx_queue_prio(struct mac_device_info *hw, u32 prio,
>  	writel(value, ioaddr + reg);
>  }
>  
> +static void dwxgmac2_rx_queue_routing(struct mac_device_info *hw,
> +				      u8 packet, u32 queue)
> +{
> +	void __iomem *ioaddr = hw->pcsr;
> +	u32 value;
> +
> +	static const struct stmmac_rx_routing dwxgmac2_route_possibilities[] = {
> +		{ XGMAC_AVCPQ, XGMAC_AVCPQ_SHIFT },
> +		{ XGMAC_PTPQ, XGMAC_PTPQ_SHIFT },
> +		{ XGMAC_DCBCPQ, XGMAC_DCBCPQ_SHIFT },
> +		{ XGMAC_UPQ, XGMAC_UPQ_SHIFT },
> +		{ XGMAC_MCBCQ, XGMAC_MCBCQ_SHIFT },
> +	};
> +
> +	value = readl(ioaddr + XGMAC_RXQ_CTRL1);
> +
> +	/* routing configuration */
> +	value &= ~dwxgmac2_route_possibilities[packet - 1].reg_mask;
> +	value |= (queue << dwxgmac2_route_possibilities[packet-1].reg_shift) &
> +		dwxgmac2_route_possibilities[packet - 1].reg_mask;
> +
> +	/* some packets require extra ops */
> +	if (packet == PACKET_AVCPQ) {
> +		value &= ~XGMAC_TACPQE;
> +		value |= 0x1 << XGMAC_TACPQE_SHIFT;

FIELD_PREP seems appropriate here.

> +	} else if (packet == PACKET_MCBCQ) {
> +		value &= ~XGMAC_MCBCQEN;
> +		value |= 0x1 << XGMAC_MCBCQEN_SHIFT;

And here.

> +	}
> +
> +	writel(value, ioaddr + XGMAC_RXQ_CTRL1);
> +}
> +
>  static void dwxgmac2_prog_mtl_rx_algorithms(struct mac_device_info *hw,
>  					    u32 rx_alg)
>  {

...
