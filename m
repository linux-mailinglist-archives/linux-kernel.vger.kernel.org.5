Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282F87700D3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjHDNH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjHDNHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:07:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD0646B3;
        Fri,  4 Aug 2023 06:07:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95BA761FEA;
        Fri,  4 Aug 2023 13:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C69C433C8;
        Fri,  4 Aug 2023 13:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691154473;
        bh=Ix21ZoIpr3Zj2///A+pnY9xaodUdrVwtTiATphHyP0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSl2/lv/cAXX3fUVQ9tWUTRmLeyH2YEBQVpGq6HZwuuTYfrBK6kJqxtZraR7RDf84
         E2zwvZZvtKFqzDEsE6vfDCtekxxp02bwjETxsKhA0/6q/B0+jQMhaWElzYfOym9uL0
         ty5d0ksPw8XoiGiAigzm8BXsI4+ewQzVEUPrQaCQ=
Date:   Fri, 4 Aug 2023 15:07:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: max310x: add comments for membase address
 workaround
Message-ID: <2023080417-surname-sizzling-591e@gregkh>
References: <20230803140551.970141-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230803140551.970141-1-hugo@hugovil.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 10:05:51AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Add comments about workaround used to configure membase address. This
> follows suggestions made during review of a sc16is7xx driver patch to
> add the same workaround.
> 
> Link: https://lore.kernel.org/lkml/2936e18f-44ea-faed-9fa0-2ddefe7c3194@linux.intel.com
> Link: https://lore.kernel.org/lkml/20230801131655.80bd8f97f018dda6155d65f6@hugovil.com/
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/tty/serial/max310x.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 416d553b73a7..5903dd033fd0 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -1369,6 +1369,11 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
>  		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
>  		s->p[i].port.iotype	= UPIO_PORT;
>  		s->p[i].port.iobase	= i;
> +		/*
> +		 * Use all ones as membase to make sure uart_configure_port() in
> +		 * serial_core.c does not abort for SPI/I2C devices where the
> +		 * membase address is not applicable.
> +		 */
>  		s->p[i].port.membase	= (void __iomem *)~0;
>  		s->p[i].port.uartclk	= uartclk;
>  		s->p[i].port.rs485_config = max310x_rs485_config;
> 
> base-commit: 426263d5fb400ccde5444748693dc75bda18f01e
> -- 
> 2.30.2
> 

Meta-comment, your email system is not correct and is not able to be
verified as I get the following when attempting to apply your patch:

---
  ✗ [PATCH] serial: max310x: add comments for membase address workaround
  ---
  ✗ BADSIG: DKIM/hugovil.com

Please fix up for future submissions.

thanks,

greg k-h
