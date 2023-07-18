Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8CB757D65
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjGRNZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjGRNZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:25:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F177318E;
        Tue, 18 Jul 2023 06:25:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E1E06157F;
        Tue, 18 Jul 2023 13:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C6FC433C8;
        Tue, 18 Jul 2023 13:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689686719;
        bh=MKqbN3b2rv/J1xMVTMwrvaZB7Tc3AJ+NAm9r4fkKzTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x4yR6Xc/nyqMRzveJsq42U+veA7gOWFvU/wA10gUsKOYuunIQ2ZUGcaUxmnDOyPg9
         JOjv0Ip3Cj8efbzgdlpe1sUUZejrL6LsuJw9VHC573Bdc7gigSC/Ew8/UxNgH960/i
         N6cN8IR0liVljLuGmng894OPNi5kTg0uns2EKtEg=
Date:   Tue, 18 Jul 2023 15:25:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     sunran001@208suo.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: add missing clk_put()
Message-ID: <2023071845-playable-snippet-278a@gregkh>
References: <20230718075401.16668-1-xujianghui@cdjrlc.com>
 <047273ae4e4c25eb7b81fd69d761161e@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <047273ae4e4c25eb7b81fd69d761161e@208suo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 03:55:23PM +0800, sunran001@208suo.com wrote:
> This patch fixes the following Coccinelle error:
> 
> ./drivers/tty/serial/bcm63xx_uart.c:854:2-8: ERROR: missing clk_put;
> clk_get on line 849 and execution via conditional on line 853
> 
> Signed-off-by: Ran Sun <sunran001@208suo.com>
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

Ran, as was pointed out before, you obviously didn't even test this
patch, nor any of the other submissions you made.

Please take the time to learn C a bit better, and then start out in a
part of the kernel where basic changes are accepted, like
drivers/staging/ so that you can learn how to properly send patches
(this was incorrectly sent as well.)

Then you can work up to attempting to fix other changes like this, if
they are correct, and you will know how to properly test your changes
instead of just making rote changes like this without understanding the
implications of them.

best of luck!

greg k-h
