Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902037B15DD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjI1IRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI1IRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:17:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE6BAC;
        Thu, 28 Sep 2023 01:17:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C89C433C9;
        Thu, 28 Sep 2023 08:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695889065;
        bh=f0Py5KsQnV1kllOtBgaMRjOqXMqsVEKHE9P7jkmTxLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mdKT26sKpwvKyVxjrAM3SwSFoLqZQ3Ap9kIl3LPvUuGJri7B/UskSlNUv3pTUlydj
         +cKEq+FCaDatZOay9enVHnlVG0SmJU+tjbwN50C51rL/jz5Bn9ZRZiqPTS+5QBN0F+
         U5KdvwyZuPYLoyKpkGLGxI7c0lpnWRHDl84zjW4w=
Date:   Thu, 28 Sep 2023 10:17:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v2 1/5] serial: core: tidy invalid baudrate handling in
 uart_get_baud_rate
Message-ID: <2023092835-applied-shakable-f5dc@gregkh>
References: <20230920022644.2712651-1-jcmvbkbc@gmail.com>
 <20230920022644.2712651-2-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920022644.2712651-2-jcmvbkbc@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 07:26:40PM -0700, Max Filippov wrote:
> uart_get_baud_rate has input parameters 'min' and 'max' limiting the
> range of acceptable baud rates from the caller's perspective. If neither
> current or old termios structures have acceptable baud rate setting and
> 9600 is not in the min/max range either the function returns 0 and
> issues a warning.
> However for a UART that does not support speed of 9600 baud this is
> expected behavior.
> Clarify that 0 can be (and always could be) returned from the
> uart_get_baud_rate. Don't issue a warning in that case.
> Move the warinng to the uart_get_divisor instead, which is often called
> with the uart_get_baud_rate return value.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  drivers/tty/serial/serial_core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 7bdc21d5e13b..a8e2915832e8 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -431,7 +431,7 @@ EXPORT_SYMBOL(uart_update_timeout);
>   * baud.
>   *
>   * If the new baud rate is invalid, try the @old termios setting. If it's still
> - * invalid, we try 9600 baud.
> + * invalid, we try 9600 baud. If that is also invalid 0 is returned.
>   *
>   * The @termios structure is updated to reflect the baud rate we're actually
>   * going to be using. Don't do this for the case where B0 is requested ("hang
> @@ -515,8 +515,6 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
>  							max - 1, max - 1);
>  		}
>  	}
> -	/* Should never happen */
> -	WARN_ON(1);

I'm ok with this removal, but:

>  	return 0;
>  }
>  EXPORT_SYMBOL(uart_get_baud_rate);
> @@ -539,6 +537,7 @@ uart_get_divisor(struct uart_port *port, unsigned int baud)
>  {
>  	unsigned int quot;
>  
> +	WARN_ON(baud == 0);

Why is this needed?  If this isn't happening today, then there's no need
to check for this here.  Or if it can happen, we should return an error,
not cause a possible reboot of the system if panic-on-warn is enabled.

thanks,

greg k-h
