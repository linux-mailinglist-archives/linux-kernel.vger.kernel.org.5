Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1EA7FD9D1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbjK2OlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbjK2OlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:41:04 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5A519A;
        Wed, 29 Nov 2023 06:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=v3XBnwWqTB4BFxU3kOY5BV2b0FffPByfQZdgq4L6Dmo=; b=SOdosZYZQiCBIaZosJXsHTSyhZ
        LNDwv9F+BLoSTWxjKgdSDvIbmW4/vdMU148o0Wi1sXHfC+Lnuzm4/KxWZRqZUQ0L6DZBlcz3bC++p
        1VQ1hHAAU3fI4RVptkUZ8Q4XeTcnLBEEYC64xCDa/Gt7cvDeEv1yNQsg852AZU7x9pzM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:60844 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1r8LkG-0005nw-MS; Wed, 29 Nov 2023 09:40:57 -0500
Date:   Wed, 29 Nov 2023 09:40:56 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Haoran Liu <liuhaoran14@163.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <20231129094056.62cf23816318e2c19400b94b@hugovil.com>
In-Reply-To: <20231129115236.33177-1-liuhaoran14@163.com>
References: <20231129115236.33177-1-liuhaoran14@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH] [tty/serial] 8250_acorn: Add error handling in
 serial_card_probe
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 03:52:36 -0800
Haoran Liu <liuhaoran14@163.com> wrote:

Hi,
you should add a proper prefix to your patch, like:
"serial: 8250_acorn: Add..."

You can use "git log --oneline drivers/tty/serial" to have an idea on
what prefix to add.

> This patch adds error handling to the serial_card_probe
> function in drivers/tty/serial/8250/8250_acorn.c. The

You can drop the full path to the file (and also the file itself) in
your commit log message, as this information is available in the diff.

> serial8250_register_8250_port call within this function
> previously lacked proper handling for failure scenarios.
> 
> Signed-off-by: Haoran Liu <liuhaoran14@163.com>
> ---
>  drivers/tty/serial/8250/8250_acorn.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_acorn.c b/drivers/tty/serial/8250/8250_acorn.c
> index 758c4aa203ab..378ae6936028 100644
> --- a/drivers/tty/serial/8250/8250_acorn.c
> +++ b/drivers/tty/serial/8250/8250_acorn.c
> @@ -43,6 +43,7 @@ serial_card_probe(struct expansion_card *ec, const struct ecard_id *id)
>  	struct uart_8250_port uart;
>  	unsigned long bus_addr;
>  	unsigned int i;
> +	int ret;
>  
>  	info = kzalloc(sizeof(struct serial_card_info), GFP_KERNEL);
>  	if (!info)
> @@ -72,6 +73,14 @@ serial_card_probe(struct expansion_card *ec, const struct ecard_id *id)
>  		uart.port.mapbase = bus_addr + type->offset[i];
>  
>  		info->ports[i] = serial8250_register_8250_port(&uart);
> +		if (IS_ERR(info->ports[i])) {
> +			ret = PTR_ERR(info->ports[i]);
> +			while (i--)
> +				serial8250_unregister_port(info->ports[i]);
> +
> +			kfree(info);
> +			return ret;

I am just wondering if unregistering all ports in case one fails is the
correct course of action? Looking at other drivers in the same folder
(8250_exar, 8250_pericom, 8250_pci), they seem to abort registering
new ports in case of error, but do not unregister previously registered
ports?

For 8250_pci1xxxx, in case of failure the for/loop still continues...

For 8250_men_mcb however, the probe exit in case of error.

Hugo Villeneuve.


> +		}
>  	}
>  
>  	return 0;
> -- 
> 2.17.1
> 
> 
