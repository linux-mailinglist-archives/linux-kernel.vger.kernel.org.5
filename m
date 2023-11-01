Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780E87DDCDE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 07:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345216AbjKAGuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 02:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjKAGuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 02:50:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA35A6;
        Tue, 31 Oct 2023 23:49:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5249C433C8;
        Wed,  1 Nov 2023 06:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698821396;
        bh=IrJZzwa1LgUljgZ2pNJ6BxSyMe71q3iklIBfrKxqK5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zz4teDGVyicLH+2JW0PTJ/4ys7ufZO5iW4ESyOqVpIzH++E1HRi7nYG3N+BJCa6ja
         sWDNEPGZ6CyFu0VTP3itptGAxbgW+oGvrnMTZSmA38HcsW6ND8od9LDYmCznkCNNSB
         pvWFb3+LKGTKPu2DkztOkcBPwFeWrgQHjxLfTOyA=
Date:   Wed, 1 Nov 2023 07:49:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] tty: serial: Add RS422 flag to struct serial_rs485
Message-ID: <2023110127-wireless-candy-c298@gregkh>
References: <20231101064404.45711-1-crescentcy.hsieh@moxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101064404.45711-1-crescentcy.hsieh@moxa.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 02:44:04PM +0800, Crescent CY Hsieh wrote:
> Add "SER_RS422_ENABLED" flag within struct serial_rs485, so that serial
> port can switching interface into RS422 if supported by using ioctl
> command "TIOCSRS485".
> 
> In case of interfaces confliction, add checks within
> uart_sanitize_serial_rs485() such that only one of RS422/RS485 is set.
> 
> Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> 
> ---
> Changes in v2:
> - Revise the logic that checks whether RS422/RS485 are enabled
>   simultaneously.
> 
> v1: https://lore.kernel.org/all/20231030053632.5109-1-crescentcy.hsieh@moxa.com/
> 
> ---
>  drivers/tty/serial/serial_core.c | 19 +++++++++++++++++--
>  include/uapi/linux/serial.h      |  4 ++++
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 831d03361..54a104c52 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1305,7 +1305,7 @@ static int uart_get_icount(struct tty_struct *tty,
>  
>  #define SER_RS485_LEGACY_FLAGS	(SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | \
>  				 SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX | \
> -				 SER_RS485_TERMINATE_BUS)
> +				 SER_RS485_TERMINATE_BUS | SER_RS422_ENABLED)

A new flag is "legacy"?

>  
>  static int uart_check_rs485_flags(struct uart_port *port, struct serial_rs485 *rs485)
>  {
> @@ -1371,11 +1371,26 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
>  {
>  	u32 supported_flags = port->rs485_supported.flags;
>  
> -	if (!(rs485->flags & SER_RS485_ENABLED)) {
> +	if (!(rs485->flags & (SER_RS485_ENABLED | SER_RS422_ENABLED))) {
>  		memset(rs485, 0, sizeof(*rs485));
>  		return;
>  	}
>  
> +	/* Pick sane setting if the user enables both interfaces */
> +	if (rs485->flags & SER_RS485_ENABLED && rs485->flags & SER_RS422_ENABLED) {
> +		dev_warn_ratelimited(port->dev,
> +			"%s (%d): Invalid serial interface setting, using RS485 instead\n",
> +			port->name, port->line);

Why is this ratelimited?  What would cause lots of repeats of this?


> +		rs485->flags &= ~SER_RS422_ENABLED;
> +	}
> +
> +	/* Clear other bits and return if RS422 is enabled */
> +	if (rs485->flags & SER_RS422_ENABLED) {
> +		memset(rs485, 0, sizeof(*rs485));
> +		rs485->flags |= SER_RS422_ENABLED;
> +		return;
> +	}
> +
>  	/* Pick sane settings if the user hasn't */
>  	if ((supported_flags & (SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND)) &&
>  	    !(rs485->flags & SER_RS485_RTS_ON_SEND) ==
> diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
> index 53bc1af67..427609fd5 100644
> --- a/include/uapi/linux/serial.h
> +++ b/include/uapi/linux/serial.h
> @@ -137,6 +137,8 @@ struct serial_icounter_struct {
>   * * %SER_RS485_ADDRB		- Enable RS485 addressing mode.
>   * * %SER_RS485_ADDR_RECV - Receive address filter (enables @addr_recv). Requires %SER_RS485_ADDRB.
>   * * %SER_RS485_ADDR_DEST - Destination address (enables @addr_dest). Requires %SER_RS485_ADDRB.
> + *
> + * * %SER_RS422_ENABLED		- RS422 enabled.
>   */
>  struct serial_rs485 {
>  	__u32	flags;
> @@ -149,6 +151,8 @@ struct serial_rs485 {
>  #define SER_RS485_ADDR_RECV		(1 << 7)
>  #define SER_RS485_ADDR_DEST		(1 << 8)
>  
> +#define SER_RS422_ENABLED		(1 << 9)

Why the extra blank line before this?

And why isn't it using the proper BIT() type macro instead (yeah, the
others are not, I understand...)

Also, what userspace code is going to use this?  How is it tested?

thanks,

greg k-h
