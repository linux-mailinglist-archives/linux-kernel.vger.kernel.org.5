Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D387B7B3249
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjI2MRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjI2MRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:17:32 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2A8195;
        Fri, 29 Sep 2023 05:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=aPBodZxRvLV0np2WN3M801BRhcUVWxN10VLoZTjTjXY=; b=oKk9Tlrg3Q0DHLupqtQSEq/wSY
        EISS1RabBeiZczqjv13RukBUcK4g/IgGNbfartgaf0MN46gfReo4pTnf51ErM9z/z9h8m/nx6/sRH
        Pe94ZTXMm/o835GuhNcUHCQ6etRaBuJ0p9VPNhusTsaQKZs1nuA08AB3L9ItbvMHOzHQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52582 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qmCQj-0001cn-8k; Fri, 29 Sep 2023 08:17:13 -0400
Date:   Fri, 29 Sep 2023 08:17:12 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        ilpo.jarvinen@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com, stable@vger.kernel.org
Message-Id: <20230929081712.7824dca40828ff873b3352ff@hugovil.com>
In-Reply-To: <20230928221246.13689-6-LinoSanfilippo@gmx.de>
References: <20230928221246.13689-1-LinoSanfilippo@gmx.de>
        <20230928221246.13689-6-LinoSanfilippo@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH 5/6] serial: core: make sure RS485 is cannot be enabled
 when it is not supported
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
remove superfluous "is" after RS485 in patch title.

Hugo.



On Fri, 29 Sep 2023 00:12:45 +0200
Lino Sanfilippo <LinoSanfilippo@gmx.de> wrote:

> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> Some uart drivers specify a rs485_config() function and then decide later
> to disable RS485 support for some reason (e.g. imx and ar933).
> 
> In these cases userspace may be able to activate RS485 via TIOCSRS485
> nevertheless, since in uart_set_rs485_config() an existing rs485_config()
> function indicates that RS485 is supported.
> 
> Make sure that this is not longer possible by checking the uarts
> rs485_supported.flags instead and bailing out if SER_RS485_ENABLED is not
> set.
> 
> Furthermore instead of returning an empty structure return -ENOTTY if the
> RS485 configuration is requested via TIOCGRS485 but RS485 is not supported.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/tty/serial/serial_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index f4feebf8200f..dca09877fabc 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1432,6 +1432,9 @@ static int uart_get_rs485_config(struct uart_port *port,
>  	unsigned long flags;
>  	struct serial_rs485 aux;
>  
> +	if (!(port->rs485_supported.flags & SER_RS485_ENABLED))
> +		return -ENOTTY;
> +
>  	spin_lock_irqsave(&port->lock, flags);
>  	aux = port->rs485;
>  	spin_unlock_irqrestore(&port->lock, flags);
> @@ -1449,7 +1452,7 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
>  	int ret;
>  	unsigned long flags;
>  
> -	if (!port->rs485_config)
> +	if (!(port->rs485_supported.flags & SER_RS485_ENABLED))
>  		return -ENOTTY;
>  
>  	if (copy_from_user(&rs485, rs485_user, sizeof(*rs485_user)))
> -- 
> 2.40.1
> 
