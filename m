Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1458D7FD845
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbjK2Net (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbjK2NeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:34:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C031FDA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:34:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F60C433B8;
        Wed, 29 Nov 2023 13:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701264866;
        bh=XE8B2aAvYDQZ5lRIHf6duHXOwNmaDMOCsJbq1VKxO+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OmD7vWPwKtvk2ybEIK39rFT85EvwKm66G+1FBs+GVPPGoDPYeZ4CsRqOO6m510ANk
         OkM5SH1hBgu9updQFY5bgtDS9jkU5TEdySDHijV4g/qgQFHB6pkMqVTMaZLbO5YJZr
         Rn3uqXwZHl/roohV3TNfxhVRHRN77t1ckVvl/R8w=
Date:   Wed, 29 Nov 2023 13:34:23 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Haoran Liu <liuhaoran14@163.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [tty/serial] 8250_acorn: Add error handling in
 serial_card_probe
Message-ID: <2023112901-encroach-idealist-2dd7@gregkh>
References: <20231129115236.33177-1-liuhaoran14@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129115236.33177-1-liuhaoran14@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 03:52:36AM -0800, Haoran Liu wrote:
> This patch adds error handling to the serial_card_probe
> function in drivers/tty/serial/8250/8250_acorn.c. The
> serial8250_register_8250_port call within this function
> previously lacked proper handling for failure scenarios.

You do have 72 columns to use if you want :)

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
> +		}

How was this found, and how was it tested?

thanks,

greg k-h
