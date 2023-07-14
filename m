Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70D37530AC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 06:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjGNEo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 00:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbjGNEou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 00:44:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548541BFB;
        Thu, 13 Jul 2023 21:44:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E231D61BFB;
        Fri, 14 Jul 2023 04:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39C6C433C9;
        Fri, 14 Jul 2023 04:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689309888;
        bh=16qYXyv9GjVlWLIOgZtR6rNBawlsls2NbxhBuJjU4bA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VvV2h0OfCPZ3yH6ZmkwvN98n990BzlkoJbLWNPSMmrJahwmOxSYfEsEMeS5/Ura+i
         XGANqu7vali9D98sB4QSitrLM35qiOCvcpovLeN29Ar5V/a3CWsglVUGeQpekVwPTd
         0+k0DCC7jqgz7pKrETgjqxE06oh6JEcnV1G07lQU=
Date:   Fri, 14 Jul 2023 06:44:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     liubin001@208suo.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Fwd: [PATCH] tty:Insert clk_put before return (clk) to release
 memory
Message-ID: <2023071424-folic-boss-18e3@gregkh>
References: <tencent_EF85BF6D0EE7D05E10D527FD335467508106@qq.com>
 <57adb092639743f2619c4765379b3ec7@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57adb092639743f2619c4765379b3ec7@208suo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 12:30:14PM +0800, liubin001@208suo.com wrote:
> 
> tty/serial:Insert clk_put before return (clk) to release memory
> Signed-off-by: Liu Bin <liubin001@08suo.com>
> ---
>  drivers/tty/serial/bcm63xx_uart.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/bcm63xx_uart.c
> b/drivers/tty/serial/bcm63xx_uart.c
> index 55e82d0bf92d..7353b683952d 100644
> --- a/drivers/tty/serial/bcm63xx_uart.c
> +++ b/drivers/tty/serial/bcm63xx_uart.c
> @@ -851,6 +851,7 @@ static int bcm_uart_probe(struct platform_device *pdev)
>          clk = of_clk_get(pdev->dev.of_node, 0);
> 
>      if (IS_ERR(clk))
> +        clk_put(clk);
>          return -ENODEV;
> 
>      port->iotype = UPIO_MEM;

This obviously has not even been tested :(
