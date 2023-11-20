Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897D77F191C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjKTQwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjKTQwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:52:07 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2DBBA;
        Mon, 20 Nov 2023 08:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=IEmqZPNEHiRj9re2F4iCenA7GeqZoGYK1eYZxhU0tA4=; b=bp/7xqTWwBpASz6lw0QLmHwfKa
        nbLaNxx6zUa49+0GkKPCOz6bL/SGXVNBlUbiCFhawFla2zuB+XUkafOCRl8OqtJMErw2aiihhNHw5
        apeF4CXyT/Qhl0dJ9DqLblIcrZkNK04vhBRgD/0vop+i1u4tBGBxEL1E8VSTQ9Awzrtk=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55666 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1r57V2-00009x-Lj; Mon, 20 Nov 2023 11:51:53 -0500
Date:   Mon, 20 Nov 2023 11:51:52 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-Id: <20231120115152.77214ee015e6c501e500b22a@hugovil.com>
In-Reply-To: <f2e9790d8b49aeba8b43ce018d30a35b837ac1eb.1700409299.git.christophe.jaillet@wanadoo.fr>
References: <f2e9790d8b49aeba8b43ce018d30a35b837ac1eb.1700409299.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2] serial: atmel: convert not to use
 dma_request_slave_channel()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2023 16:55:15 +0100
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

Hi,
change the subject to:

"... replace deprecated dma_request_slave_channel()"

Hugo.


> dma_request_slave_channel() is deprecated. dma_request_chan() should
> be used directly instead.
> 
> Switch to the preferred function and update the error handling accordingly.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: Also update atmel_prepare_rx_dma()
> ---
>  drivers/tty/serial/atmel_serial.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 1946fafc3f3e..6aeb4648843b 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1013,14 +1013,18 @@ static int atmel_prepare_tx_dma(struct uart_port *port)
>  	struct device *mfd_dev = port->dev->parent;
>  	dma_cap_mask_t		mask;
>  	struct dma_slave_config config;
> +	struct dma_chan *chan;
>  	int ret, nent;
>  
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_SLAVE, mask);
>  
> -	atmel_port->chan_tx = dma_request_slave_channel(mfd_dev, "tx");
> -	if (atmel_port->chan_tx == NULL)
> +	chan = dma_request_chan(mfd_dev, "tx");
> +	if (IS_ERR(chan)) {
> +		atmel_port->chan_tx = NULL;
>  		goto chan_err;
> +	}
> +	atmel_port->chan_tx = chan;
>  	dev_info(port->dev, "using %s for tx DMA transfers\n",
>  		dma_chan_name(atmel_port->chan_tx));
>  
> @@ -1188,6 +1192,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
>  	dma_cap_mask_t		mask;
>  	struct dma_slave_config config;
>  	struct circ_buf		*ring;
> +	struct dma_chan *chan;
>  	int ret, nent;
>  
>  	ring = &atmel_port->rx_ring;
> @@ -1195,9 +1200,12 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_CYCLIC, mask);
>  
> -	atmel_port->chan_rx = dma_request_slave_channel(mfd_dev, "rx");
> -	if (atmel_port->chan_rx == NULL)
> +	chan = dma_request_chan(mfd_dev, "rx");
> +	if (IS_ERR(chan)) {
> +		atmel_port->chan_rx = NULL;
>  		goto chan_err;
> +	}
> +	atmel_port->chan_rx = chan;
>  	dev_info(port->dev, "using %s for rx DMA transfers\n",
>  		dma_chan_name(atmel_port->chan_rx));
>  
> -- 
> 2.34.1
> 
