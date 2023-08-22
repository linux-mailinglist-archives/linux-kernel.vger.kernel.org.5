Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CD278420B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbjHVN1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbjHVN1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:27:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C84BE;
        Tue, 22 Aug 2023 06:27:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED68D62931;
        Tue, 22 Aug 2023 13:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADE6C433C7;
        Tue, 22 Aug 2023 13:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692710858;
        bh=jKMOvy9lc4aP5jpn9CLs1Fndc4z1ORTZc5x1QXcYTTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YjPvp/A7LjlsdSeaWLFFOXlkAvZCXWNzCKrqKYyl8TqQX6OwVRBp9dI5kd+59nvpr
         1WlYe5KF2FT0eIwaXBCtYXMinscuWvK3YjiH7TMO0ifdUgOrhMlpstfW9lLdQxkGoJ
         sMLb4UnGdMTUzYpyFcC+YyTTUNPK+J/Q6AsklPkM=
Date:   Tue, 22 Aug 2023 15:27:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>,
        Zhirong Qiu <zhirong.qiu@unisoc.com>,
        Zhaochen Su <Zhaochen.Su@unisoc.com>
Subject: Re: [PATCH] tty/serial: Cancel work queue before closing uart
Message-ID: <2023082205-jazz-evade-7f1a@gregkh>
References: <20230818031532.15591-1-Wenhua.Lin@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818031532.15591-1-Wenhua.Lin@unisoc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 11:15:32AM +0800, Wenhua Lin wrote:
> When the system constantly sleeps and wankes up, plugging and unplugging
> the USB will probalility trigger a kernel crash problem. The reason is
> that at this time, the system entered deep and turned off uart, and the
> abnormal behavior of plugging and upplugging the USB triggered the read
> data process of uart, causing access to uart to hang. The final solution
> we came up with is to cancel the work queue before shutting down uart
> , while ensuring that there is no uart business.
> 
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>  drivers/tty/serial/sprd_serial.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index b58f51296ace..eddff4360155 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -20,6 +20,7 @@
>  #include <linux/slab.h>
>  #include <linux/tty.h>
>  #include <linux/tty_flip.h>
> +#include "../tty.h"
>  
>  /* device name */
>  #define UART_NR_MAX		8
> @@ -1221,7 +1222,10 @@ static int sprd_probe(struct platform_device *pdev)
>  static int sprd_suspend(struct device *dev)
>  {
>  	struct sprd_uart_port *sup = dev_get_drvdata(dev);
> +	struct uart_port *uport = &sup->port;
> +	struct tty_port *tty = &uport->state->port;
>  
> +	tty_buffer_cancel_work(tty);

What does this serial port have to do with the USB subsystem in your
changelog text?

And as the kernel bot said, this breaks the build, you can't do this
within a serial driver, sorry.

greg k-h
