Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027877F6558
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345726AbjKWRXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345674AbjKWRWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:22:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8173D7D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:22:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA634C43391;
        Thu, 23 Nov 2023 17:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700760176;
        bh=r3SxNvUBmnsHaNki4VDL+z3dKpTAlqM3g+IFMWeGKZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sbXjB2BocU+UI6sPiH8wBmSuXF7P0SStfzI8JAEYAWKM3au6YJa39iCCw7SDXOwlY
         ljrhBwcyrIuHfmpzSQC7CBDkk1v0o4e+IsC+K6+9VPipuEqZB3SSqjqBdqS2J5s7ET
         Amz+cMRpcuOPsrttCpogfe/jwqPsnfWep011zalw=
Date:   Thu, 23 Nov 2023 14:16:46 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v5] tty: serial: Add RS422 flag to struct serial_rs485
Message-ID: <2023112346-immunity-clamshell-51c7@gregkh>
References: <20231121095122.15948-1-crescentcy.hsieh@moxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121095122.15948-1-crescentcy.hsieh@moxa.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 05:51:22PM +0800, Crescent CY Hsieh wrote:
> --- a/include/uapi/linux/serial.h
> +++ b/include/uapi/linux/serial.h
> @@ -11,6 +11,7 @@
>  #ifndef _UAPI_LINUX_SERIAL_H
>  #define _UAPI_LINUX_SERIAL_H
>  
> +#include <linux/const.h>
>  #include <linux/types.h>
>  
>  #include <linux/tty_flags.h>
> @@ -137,17 +138,19 @@ struct serial_icounter_struct {
>   * * %SER_RS485_ADDRB		- Enable RS485 addressing mode.
>   * * %SER_RS485_ADDR_RECV - Receive address filter (enables @addr_recv). Requires %SER_RS485_ADDRB.
>   * * %SER_RS485_ADDR_DEST - Destination address (enables @addr_dest). Requires %SER_RS485_ADDRB.
> + * * %SER_RS485_MODE_RS422	- Enable RS422. Requires %SER_RS485_ENABLED.
>   */
>  struct serial_rs485 {
>  	__u32	flags;
> -#define SER_RS485_ENABLED		(1 << 0)
> -#define SER_RS485_RTS_ON_SEND		(1 << 1)
> -#define SER_RS485_RTS_AFTER_SEND	(1 << 2)
> -#define SER_RS485_RX_DURING_TX		(1 << 4)
> -#define SER_RS485_TERMINATE_BUS		(1 << 5)
> -#define SER_RS485_ADDRB			(1 << 6)
> -#define SER_RS485_ADDR_RECV		(1 << 7)
> -#define SER_RS485_ADDR_DEST		(1 << 8)
> +#define SER_RS485_ENABLED		_BITUL(0)
> +#define SER_RS485_RTS_ON_SEND		_BITUL(1)
> +#define SER_RS485_RTS_AFTER_SEND	_BITUL(2)
> +#define SER_RS485_RX_DURING_TX		_BITUL(3)
> +#define SER_RS485_TERMINATE_BUS		_BITUL(4)
> +#define SER_RS485_ADDRB			_BITUL(5)
> +#define SER_RS485_ADDR_RECV		_BITUL(6)
> +#define SER_RS485_ADDR_DEST		_BITUL(7)
> +#define SER_RS485_MODE_RS422		_BITUL(8)

You just broke userspace by changing the flags for existing values :(

Please be much more careful in the future, do not do "cleanup" patches
along with a "add a new feature" patch, as it would have been much more
obvious as to what happened here if you had done that.

thanks,

greg k-h
