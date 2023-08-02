Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC6576CF2C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbjHBNsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbjHBNsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:48:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD914273A;
        Wed,  2 Aug 2023 06:48:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52967619A9;
        Wed,  2 Aug 2023 13:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCC6C433C7;
        Wed,  2 Aug 2023 13:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690984108;
        bh=i9DyNAh7y5hCfZqptvO1Qy2evQkU5TYUhB7k2ccVuvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m1UFG7hyap2QR4xlFhlM0wE0AgW7J1gfeazMROK/+2QwzlhBhbG2XYniYY9hIGH5h
         OM/GLSP64vuDOXGf4HtEOrjRlo26D0ddLIhKSuS1g7MVAzLhgy1As2F9rb5juKG21n
         u+WYb2XqnN8H9w2KNWyArgLi/RwBcr3RIBEokcFQ=
Date:   Wed, 2 Aug 2023 15:48:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] serial: core: Fix serial_base_match() after fixing
 controller port name
Message-ID: <2023080224-nutrient-regress-c95e@gregkh>
References: <20230802114846.21899-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802114846.21899-1-tony@atomide.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 02:48:43PM +0300, Tony Lindgren wrote:
> While fixing DEVNAME to be more usable, I broke serial_base_match() as
> the ctrl and port prefix for device seemed unnecessary.
> 
> Let's fix the issue by checking against dev->type and drv->name.
> 
> Fixes: 1ef2c2df1199 ("serial: core: Fix serial core controller port name to show controller id")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/tty/serial/serial_base.h     |  3 +++
>  drivers/tty/serial/serial_base_bus.c | 10 ++++++++--
>  drivers/tty/serial/serial_ctrl.c     |  2 +-
>  drivers/tty/serial/serial_port.c     |  2 +-
>  4 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_base.h b/drivers/tty/serial/serial_base.h
> --- a/drivers/tty/serial/serial_base.h
> +++ b/drivers/tty/serial/serial_base.h
> @@ -6,6 +6,9 @@
>   * Author: Tony Lindgren <tony@atomide.com>
>   */
>  
> +#define SERIAL_BASE_CTRL_NAME	"ctrl"
> +#define SERIAL_BASE_PORT_NAME	"port"
> +
>  #define to_serial_base_ctrl_device(d) container_of((d), struct serial_ctrl_device, dev)
>  #define to_serial_base_port_device(d) container_of((d), struct serial_port_device, dev)
>  
> diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
> --- a/drivers/tty/serial/serial_base_bus.c
> +++ b/drivers/tty/serial/serial_base_bus.c
> @@ -29,9 +29,15 @@ static const struct device_type serial_port_type = {
>  
>  static int serial_base_match(struct device *dev, struct device_driver *drv)
>  {
> -	int len = strlen(drv->name);
> +	if (dev->type == &serial_ctrl_type &&
> +	    !strncmp(SERIAL_BASE_CTRL_NAME, drv->name, 4))

maybe:
	    !strncmp(SERIAL_BASE_CTRL_NAME, drv->name, strlen(SERIAL_BASE_CTRL_NAME))

as "4" is a magic number :)


thanks,

greg k-h
