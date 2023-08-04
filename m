Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037C576FDBE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjHDJqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjHDJqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:46:45 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19D749CC;
        Fri,  4 Aug 2023 02:46:40 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 14E622E4;
        Fri,  4 Aug 2023 11:45:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691142333;
        bh=T9fM136WuCH10eLpbSwvpxJ/SxDOh5z0DDnIQBOK0DU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=wf5/fEPa+Zm9AAhdmsprYX/UBj5jdh7EsHSB00EqtVTORR9NYypJgy7oZtSJrzGGo
         W/+cP67O9k1fA4V18BZF7L5XYUPz6K7ZSscF8Enn7EpyZ4CmM7M6Q37/DFoOo6Kf1M
         P9yqx+n7AD4iSuuO1KR2GSNc7NNNmmrTvCW1Koec=
Message-ID: <9a6397b2-0e57-c73f-f0a5-651e64985e06@ideasonboard.com>
Date:   Fri, 4 Aug 2023 12:46:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] serial: core: Fix kmemleak issue for serial core device
 remove
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20230804090909.51529-1-tony@atomide.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230804090909.51529-1-tony@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 12:09, Tony Lindgren wrote:
> Kmemleak reports issues for serial8250 ports after the hardware specific
> driver takes over on boot as noted by Tomi.
> 
> The kerneldoc for device_initialize() says we must call device_put()
> after calling device_initialize(). We are calling device_put() on the
> error path, but are missing it from the device remove path. This causes
> release() to never get called for the devices on remove.
> 
> Let's add the missing put_device() calls for both serial ctrl and
> port devices.
> 
> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> Reported-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   drivers/tty/serial/serial_base_bus.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
> --- a/drivers/tty/serial/serial_base_bus.c
> +++ b/drivers/tty/serial/serial_base_bus.c
> @@ -99,6 +99,7 @@ void serial_base_ctrl_device_remove(struct serial_ctrl_device *ctrl_dev)
>   		return;
>   
>   	device_del(&ctrl_dev->dev);
> +	put_device(&ctrl_dev->dev);
>   }
>   
>   struct serial_ctrl_device *serial_base_ctrl_add(struct uart_port *port,
> @@ -174,6 +175,7 @@ void serial_base_port_device_remove(struct serial_port_device *port_dev)
>   		return;
>   
>   	device_del(&port_dev->dev);
> +	put_device(&port_dev->dev);
>   }
>   
>   static int serial_base_init(void)

Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

