Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFD3760AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjGYGuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjGYGuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02421116;
        Mon, 24 Jul 2023 23:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 793696112D;
        Tue, 25 Jul 2023 06:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671E8C433B9;
        Tue, 25 Jul 2023 06:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690267818;
        bh=VyFFoh1Iq0hSHIAUXK47aCTmThAolpzOKvMyobjjmH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZNnbIrrecIYS1J6LUQ3kcJ1z1uuc9h6VlACHcF7d/xkN5FC7pNOn3v0mFXCqs2hgF
         TQmYDM7104ApfVVlyCA+DBnDRzc+vcBI9SKlgQDa1x2G6OKn/CXOnU23lYYWg1x3tW
         KPMEDskopJYZnKjykqbmsiba8a0ZDKqQhS5xKn80=
Date:   Tue, 25 Jul 2023 08:50:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 1/2] serial: sprd: Assign sprd_port after initialized
 to avoid wrong access
Message-ID: <2023072548-jolliness-unbolted-621c@gregkh>
References: <20230725064053.235448-1-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725064053.235448-1-chunyan.zhang@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 02:40:52PM +0800, Chunyan Zhang wrote:
> The global pointer 'sprd_port' may not zero when sprd_probe returns
> failure, that is a risk for sprd_port to be accessed afterward, and
> may lead to unexpected errors.
> 
> For example:
> 
> There are two UART ports, UART1 is used for console and configured in
> kernel command line, i.e. "console=";
> 
> The UART1 probe failed and the memory allocated to sprd_port[1] was
> released, but sprd_port[1] was not set to NULL;
> 
> In UART2 probe, the same virtual address was allocated to sprd_port[2],
> and UART2 probe process finally will go into sprd_console_setup() to
> register UART1 as console since it is configured as preferred console
> (filled to console_cmdline[]), but the console parameters (sprd_port[1])
> belong to UART2.
> 
> So move the sprd_port[] assignment to where the port already initialized
> can avoid the above issue.
> 
> Fixes: b7396a38fb28 ("tty/serial: Add Spreadtrum sc9836-uart driver support")
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
> V3:
> - Call uart_unregister_driver() only when the 'sprd_ports_num' decreases to 0;
> - Add calling sprd_rx_free_buf() instread of sprd_remove() under clean_up lable. 
> 
> V2:
> - Leave sprd_remove() to keep the unrelated code logic the same.
> ---
>  drivers/tty/serial/sprd_serial.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index b58f51296ace..fc1377029021 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -1106,7 +1106,7 @@ static bool sprd_uart_is_console(struct uart_port *uport)
>  static int sprd_clk_init(struct uart_port *uport)
>  {
>  	struct clk *clk_uart, *clk_parent;
> -	struct sprd_uart_port *u = sprd_port[uport->line];
> +	struct sprd_uart_port *u = container_of(uport, struct sprd_uart_port, port);

Now that you are not allocaing the sprd_port[] pointers, shouldn't you
also remove that variable entirely?

thanks,

greg k-h
