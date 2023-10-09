Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7470B7BE2AE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376920AbjJIO0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjJIO0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:26:44 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D3B99;
        Mon,  9 Oct 2023 07:26:40 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E7FF60003;
        Mon,  9 Oct 2023 14:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696861598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92a8cVu3f6Pk3ndmVwnkeBH7DnuU13PZsLWlEFgkb+8=;
        b=ptdUM/7cMSJVYbBrfF6v7pOBngBBoqD2a0R/MUuEMeanPcoDEjfHKfSoM8A8bH79+drPz+
        rV97RU0p5QyeWtYFPXNPPjzGoSwoAmb7zdtM9zta8Rt3qazcKpntePvK1epyDuMN8Yy2hm
        c/19/YApYNnYXqqPcSlzxHZDNltzGOFF0avCXI1W6tyEQLx7YzapC/yKZuEgCSulDYhE2G
        tiyCi8WMCoTIVnh6t72FOyCiEhCyW0D3+DoI+D5rSdROAfpCBAIJTfQNC5r7tEla35zU7C
        xa3pdnMAu7WiFZoTgbzZKx+vu0/qFQeygmLxg4z1lzB3Rw48ksl43ELSnmswNA==
Date:   Mon, 9 Oct 2023 16:26:32 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Jakub Kicinski <kuba@kernel.org>
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
Message-ID: <20231009162632.7f11a6d9@bootlin.com>
In-Reply-To: <20231006144702.778c165e@kernel.org>
References: <20230928070652.330429-1-herve.codina@bootlin.com>
        <20230928070652.330429-11-herve.codina@bootlin.com>
        <20231006144702.778c165e@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

On Fri, 6 Oct 2023 14:47:02 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 28 Sep 2023 09:06:28 +0200 Herve Codina wrote:
> > +static int qmc_hdlc_close(struct net_device *netdev)
> > +{
> > +	struct qmc_hdlc *qmc_hdlc = netdev_to_qmc_hdlc(netdev);
> > +	struct qmc_hdlc_desc *desc;
> > +	int i;
> > +
> > +	netif_stop_queue(netdev);
> > +
> > +	qmc_chan_stop(qmc_hdlc->qmc_chan, QMC_CHAN_ALL);
> > +	qmc_chan_reset(qmc_hdlc->qmc_chan, QMC_CHAN_ALL);  
> 
> stopping the queue looks a bit racy, a completion may come in 
> and restart the queue

Indeed, qmc_hdlc_xmit_complete() completion can restart the queue.

I will call netif_stop_queue() after calling qmc_chan_stop/reset().
This is the simple way to fix that without adding an internal flag.

Thanks for pointing that.

Best regards,
Hervé

> 
> > +	for (i = 0; i < ARRAY_SIZE(qmc_hdlc->tx_descs); i++) {
> > +		desc = &qmc_hdlc->tx_descs[i];
> > +		if (!desc->skb)
> > +			continue;
> > +		dma_unmap_single(qmc_hdlc->dev, desc->dma_addr, desc->dma_size,
> > +				 DMA_TO_DEVICE);
> > +		kfree_skb(desc->skb);
> > +		desc->skb = NULL;
> > +	}
> > +
> > +	for (i = 0; i < ARRAY_SIZE(qmc_hdlc->rx_descs); i++) {
> > +		desc = &qmc_hdlc->rx_descs[i];
> > +		if (!desc->skb)
> > +			continue;
> > +		dma_unmap_single(qmc_hdlc->dev, desc->dma_addr, desc->dma_size,
> > +				 DMA_FROM_DEVICE);
> > +		kfree_skb(desc->skb);
> > +		desc->skb = NULL;
> > +	}
> > +
> > +	hdlc_close(netdev);  
