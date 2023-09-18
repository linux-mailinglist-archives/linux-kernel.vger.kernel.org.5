Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E517A43BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240306AbjIRH74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240643AbjIRH7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:59:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE0610D5;
        Mon, 18 Sep 2023 00:56:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434C0C433C9;
        Mon, 18 Sep 2023 07:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695023761;
        bh=LxrT4DjTJ8KTCe3CTiQGS6Js7PzesfHyt4s8YnU5JSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XQqPCAFzllF9KAuDQlKVMnSIGX1iWq6y/clSyozwFbqVn7Sif/WSt35flcSi0T+4F
         koMrnvyuYZvcW2BXBuY63/CMKEpDZuHaATfFytKlG4GnxklGIK9b0wRzzzqOSODKCH
         pmhWhbf3mXx1dK5+wf1gRZVeOd20eAIu4vDTM9gM=
Date:   Mon, 18 Sep 2023 09:55:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     patrice.chotard@st.com, jslaby@suse.com,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] serial: st-asc: Fix to check return value of
 platform_get_irq() in asc_init_port()
Message-ID: <2023091849-chill-haziness-1a35@gregkh>
References: <tencent_7E9B9A5A97AD3B30550F1A8553D44F09C607@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_7E9B9A5A97AD3B30550F1A8553D44F09C607@qq.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 03:54:59PM +0800, Zhang Shurong wrote:
> The platform_get_irq might be failed and return a negative result. So
> there should have an error handling code.
> 
> Fixed this by adding an error handling code.
> 
> Fixes: c4b058560762 ("serial:st-asc: Add ST ASC driver.")
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> ---
> v1->v2: generated patch based on tty-next tree.
> 
>  drivers/tty/serial/st-asc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
> index e7048515a79c..3d60ab6e9581 100644
> --- a/drivers/tty/serial/st-asc.c
> +++ b/drivers/tty/serial/st-asc.c
> @@ -723,9 +723,13 @@ static int asc_init_port(struct asc_port *ascport,
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
> 2.30.2
> 

Does not apply to 6.6-rc2 :(
