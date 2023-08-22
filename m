Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A31783EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbjHVLad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjHVLac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:30:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB747CD7;
        Tue, 22 Aug 2023 04:30:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D8A8639AE;
        Tue, 22 Aug 2023 11:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313EFC433C8;
        Tue, 22 Aug 2023 11:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692703828;
        bh=6RYnnMxHVsAhH6PvvqKQGkf38Ka3yLC0O+JsZ9/8zR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M7wsRiush/wtx+236v2mUKr3EhqS3t/Pet4KRw0o19pq0M1GSX06v9eruy9K2cYP0
         3n3us6IgSUmCoLug6Mbfhikg/Vvs/vy3X31v1TaMzombEkY+ueKyW9xamEkdWp4moJ
         7+z8zECA4mUeD44LgQFjrjyEvsweczlqFW++C5dc=
Date:   Tue, 22 Aug 2023 13:30:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>
Cc:     richard.genoud@gmail.com, jirislaby@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@tuxon.dev, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] serial: atmel: Fix Spectre v1 vulnerability reported by
 smatch
Message-ID: <2023082220-matchless-stagnate-7dab@gregkh>
References: <20230822111321.56434-1-Hari.PrasathGE@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822111321.56434-1-Hari.PrasathGE@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 04:43:21PM +0530, Hari Prasath Gujulan Elango wrote:
> smatch reports the below spectre variant 1 vulnerability.
> 
> drivers/tty/serial/atmel_serial.c:2675 atmel_console_setup() warn: potential spectre issue 'atmel_ports' [r] (local cap)
> 
> Fix the same by using the array_index_nospec() to mitigate this
> potential vulnerability especially because the console index is
> controlled by user-space.
> 
> Signed-off-by: Hari Prasath Gujulan Elango <Hari.PrasathGE@microchip.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 3467a875641a..25f004dd9efd 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -33,6 +33,7 @@
>  #include <linux/suspend.h>
>  #include <linux/mm.h>
>  #include <linux/io.h>
> +#include <linux/nospec.h>
>  
>  #include <asm/div64.h>
>  #include <asm/ioctls.h>
> @@ -2662,13 +2663,23 @@ static void __init atmel_console_get_options(struct uart_port *port, int *baud,
>  
>  static int __init atmel_console_setup(struct console *co, char *options)
>  {
> -	struct uart_port *port = &atmel_ports[co->index].uart;
> -	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> +	struct uart_port *port;
> +	struct atmel_uart_port *atmel_port;
>  	int baud = 115200;
>  	int bits = 8;
>  	int parity = 'n';
>  	int flow = 'n';
>  
> +	if (unlikely(co->index < 0 || co->index >= ATMEL_MAX_UART))

Only ever use likely/unlikely if you can measure the difference with and
without the marking.  Otherwise do not use it as the compiler and cpu do
a better job than we do in figuring this out.


> +		return -ENODEV;
> +
> +	co->index = array_index_nospec(co->index, ATMEL_MAX_UART);

How exactl is index controlled by userspace such that a spectre gadget
can be used here?  You have to be able to call this multiple times in a
row, unsuccessfully and successfully, how does that happen through the
console api?

thanks,

greg k-h
