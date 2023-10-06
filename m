Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3BF7BC18D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbjJFVrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbjJFVrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:47:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E915110B;
        Fri,  6 Oct 2023 14:47:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B17AC433C7;
        Fri,  6 Oct 2023 21:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696628829;
        bh=7ShH9lM/jTtdIpDBd5tkXIdLZJ6EOzXUhDKKnj55xPo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UIB5D7QUgappiPLI6dOoUHSxvt5YAjXDxSa8MYt3/cAFv/c5IHJYHnYTPpU858ZTu
         ClL/Cf8dYmT/K2AsekQJqM/9c+T/Lu+ejjHS7ojVK3HC8q8o9i3501u//0M0XEEIUA
         kQhpB665WwNyXG+96GLLJwQmYMwetRfLQ0qkrS4cswc44g/UYawosmoi4NMFiFOe4q
         duYX45Tg97UhJ6fdrukD6yY2MmoCfaH9XlYzON02quQybVLTyXOqpCIZOPLdLN7pvz
         WNUh6/12mNBI+Q820T8snzNGUsqfrHG91QPyG1E9MvoRh77CxpA+aVQH87ZXbvLdOH
         hY2YnF6sVQk4Q==
Date:   Fri, 6 Oct 2023 14:47:02 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Simon Horman <horms@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 10/30] net: wan: Add support for QMC HDLC
Message-ID: <20231006144702.778c165e@kernel.org>
In-Reply-To: <20230928070652.330429-11-herve.codina@bootlin.com>
References: <20230928070652.330429-1-herve.codina@bootlin.com>
        <20230928070652.330429-11-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2023 09:06:28 +0200 Herve Codina wrote:
> +static int qmc_hdlc_close(struct net_device *netdev)
> +{
> +	struct qmc_hdlc *qmc_hdlc = netdev_to_qmc_hdlc(netdev);
> +	struct qmc_hdlc_desc *desc;
> +	int i;
> +
> +	netif_stop_queue(netdev);
> +
> +	qmc_chan_stop(qmc_hdlc->qmc_chan, QMC_CHAN_ALL);
> +	qmc_chan_reset(qmc_hdlc->qmc_chan, QMC_CHAN_ALL);

stopping the queue looks a bit racy, a completion may come in 
and restart the queue

> +	for (i = 0; i < ARRAY_SIZE(qmc_hdlc->tx_descs); i++) {
> +		desc = &qmc_hdlc->tx_descs[i];
> +		if (!desc->skb)
> +			continue;
> +		dma_unmap_single(qmc_hdlc->dev, desc->dma_addr, desc->dma_size,
> +				 DMA_TO_DEVICE);
> +		kfree_skb(desc->skb);
> +		desc->skb = NULL;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(qmc_hdlc->rx_descs); i++) {
> +		desc = &qmc_hdlc->rx_descs[i];
> +		if (!desc->skb)
> +			continue;
> +		dma_unmap_single(qmc_hdlc->dev, desc->dma_addr, desc->dma_size,
> +				 DMA_FROM_DEVICE);
> +		kfree_skb(desc->skb);
> +		desc->skb = NULL;
> +	}
> +
> +	hdlc_close(netdev);
