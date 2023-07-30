Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733C176852E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 13:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjG3LzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 07:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjG3Lyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 07:54:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B1C10D3;
        Sun, 30 Jul 2023 04:54:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2AC060C3B;
        Sun, 30 Jul 2023 11:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6A4C433C8;
        Sun, 30 Jul 2023 11:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690718079;
        bh=h8Bvd9Q9O5xEzuY+S6AbRK4A8J3G/3ih916psi4y4Mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aakay1r0mgVUNYwWeOi5r4R712O1sc2xu15UTf1h++oj3ZC+BYFuY+Hsd4IqCWJGR
         Pxb15jQ+Pio9tesL6UQSleR4PFiPC2Av06upYAcAbsVlnxwOgEQArRW/AipK1uR2Uh
         280oAuEahqPoj+wjQ2ShAnmj4GgIQ+tcFcvSL7G0=
Date:   Sun, 30 Jul 2023 13:54:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     patrice.chotard@foss.st.com, jirislaby@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: st-asc: Fix to check return value of
 platform_get_irq() in asc_init_port()
Message-ID: <2023073028-pantyhose-replace-b960@gregkh>
References: <tencent_1FBC566A2B186CCC634D4109F54D62F2C605@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_1FBC566A2B186CCC634D4109F54D62F2C605@qq.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 12:28:47PM +0800, Zhang Shurong wrote:
> The platform_get_irq might be failed and return a negative result. So
> there should have an error handling code.
> 
> Fixed this by adding an error handling code.
> 
> Fixes: c4b058560762 ("serial:st-asc: Add ST ASC driver.")
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> ---
>  drivers/tty/serial/st-asc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
> index aa471c9c24d9..2f1807fa9bdb 100644
> --- a/drivers/tty/serial/st-asc.c
> +++ b/drivers/tty/serial/st-asc.c
> @@ -688,9 +688,13 @@ static int asc_init_port(struct asc_port *ascport,
>  	port->ops	= &asc_uart_ops;
>  	port->fifosize	= ASC_FIFO_SIZE;
>  	port->dev	= &pdev->dev;
> -	port->irq	= platform_get_irq(pdev, 0);
>  	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_ST_ASC_CONSOLE);
>  
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0)
> +		return ret;
> +	port->irq = ret;
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	port->membase = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(port->membase))
> -- 
> 2.41.0
> 

Does not apply to my tty-next tree :(

