Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E4676DF94
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 07:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjHCFNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 01:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjHCFNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 01:13:39 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B381E43;
        Wed,  2 Aug 2023 22:13:37 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3178dd81ac4so481567f8f.3;
        Wed, 02 Aug 2023 22:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691039616; x=1691644416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/+wHAm+pSFsxBZxH6R9J1UEW1BsnRshtaSbp6LTgTk=;
        b=d4ad+ZC+kClI2upxC11+SImqqZyeTqMKTuOLkGgqk7rkYixRfmW3N6EmiZbJQIH+tE
         jmsZ52ipcB8K/M0Ct1HdDWLdfIJrQGu+lLLxJ2eEdy5Aziidjt5A/M2YbBOKWDXCa1am
         WJmIqHUzem7xVaCuNbE8i2FkqOtTWbMyyI5ij+ch7OIY0Xdv72JnfIE5nwFErOaJWZ2w
         Rr0HN/fzgRZCqZNPwO6wRsBNlYwz24bWc2J5dlXn3HPRDJfSXXhoAq/qw0JjylUcNB9U
         pBIlDOlDaqvgZKgZqPC461fNnrfQ+59jN9Ij0Um7RWUNBxLo5ARUmbAm172L4zDXx9ra
         h4/Q==
X-Gm-Message-State: ABy/qLbu5EWV8hYiyroVRNPOdNMgQ8MmsdZZElkZS2iBe/6Wc6svf941
        ujtH8TZwMOgCLKxoArnvcHA=
X-Google-Smtp-Source: APBJJlGOTuijVRnR5/YBVOcI0cNMM7JyNVucFPypSjaaX0VaS+h/17bq0LW3VcIIB6IbYB5UoI3lFQ==
X-Received: by 2002:adf:ee52:0:b0:317:57f0:fae with SMTP id w18-20020adfee52000000b0031757f00faemr6252072wro.63.1691039615638;
        Wed, 02 Aug 2023 22:13:35 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id c4-20020a056000104400b003143b14848dsm20683080wrx.102.2023.08.02.22.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 22:13:34 -0700 (PDT)
Message-ID: <496b56e1-1cc3-dfa3-d628-aeab62b9e60f@kernel.org>
Date:   Thu, 3 Aug 2023 07:13:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] serial: core: Fix serial_base_match() after fixing
 controller port name
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
References: <20230802114846.21899-1-tony@atomide.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230802114846.21899-1-tony@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 08. 23, 13:48, Tony Lindgren wrote:
> While fixing DEVNAME to be more usable, I broke serial_base_match() as
> the ctrl and port prefix for device seemed unnecessary.

It's not completely clear to me what you are actually fixing. Please 
elaborate in more detail.

> Let's fix the issue by checking against dev->type and drv->name.
> 
> Fixes: 1ef2c2df1199 ("serial: core: Fix serial core controller port name to show controller id")


> Reported-by: kernel test robot <oliver.sang@intel.com>

Then we are missing a Link here.

> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   drivers/tty/serial/serial_base.h     |  3 +++
>   drivers/tty/serial/serial_base_bus.c | 10 ++++++++--
>   drivers/tty/serial/serial_ctrl.c     |  2 +-
>   drivers/tty/serial/serial_port.c     |  2 +-
>   4 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_base.h b/drivers/tty/serial/serial_base.h
> --- a/drivers/tty/serial/serial_base.h
> +++ b/drivers/tty/serial/serial_base.h
> @@ -6,6 +6,9 @@
>    * Author: Tony Lindgren <tony@atomide.com>
>    */
>   
> +#define SERIAL_BASE_CTRL_NAME	"ctrl"
> +#define SERIAL_BASE_PORT_NAME	"port"

Could you make those char[] instead? The compiler/linker will hopefully 
(will it?) de-dup the occurrences, but the arrays would look cleaner and 
safer from this POV.

>   #define to_serial_base_ctrl_device(d) container_of((d), struct serial_ctrl_device, dev)
>   #define to_serial_base_port_device(d) container_of((d), struct serial_port_device, dev)
>   
> diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
> --- a/drivers/tty/serial/serial_base_bus.c
> +++ b/drivers/tty/serial/serial_base_bus.c
> @@ -29,9 +29,15 @@ static const struct device_type serial_port_type = {
>   
>   static int serial_base_match(struct device *dev, struct device_driver *drv)
>   {
> -	int len = strlen(drv->name);
> +	if (dev->type == &serial_ctrl_type &&
> +	    !strncmp(SERIAL_BASE_CTRL_NAME, drv->name, 4))
> +		return 1;
>   
> -	return !strncmp(dev_name(dev), drv->name, len);
> +	if (dev->type == &serial_port_type &&
> +	    !strncmp(SERIAL_BASE_PORT_NAME, drv->name, 4))
> +		return 1;
> +
> +	return 0;
>   }
>   
>   static struct bus_type serial_base_bus_type = {
> diff --git a/drivers/tty/serial/serial_ctrl.c b/drivers/tty/serial/serial_ctrl.c
> --- a/drivers/tty/serial/serial_ctrl.c
> +++ b/drivers/tty/serial/serial_ctrl.c
> @@ -47,7 +47,7 @@ void serial_ctrl_unregister_port(struct uart_driver *drv, struct uart_port *port
>   }
>   
>   static struct device_driver serial_ctrl_driver = {
> -	.name = "ctrl",
> +	.name = SERIAL_BASE_CTRL_NAME,
>   	.suppress_bind_attrs = true,
>   	.probe = serial_ctrl_probe,
>   	.remove = serial_ctrl_remove,
> diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
> --- a/drivers/tty/serial/serial_port.c
> +++ b/drivers/tty/serial/serial_port.c
> @@ -83,7 +83,7 @@ void uart_remove_one_port(struct uart_driver *drv, struct uart_port *port)
>   EXPORT_SYMBOL(uart_remove_one_port);
>   
>   static struct device_driver serial_port_driver = {
> -	.name = "port",
> +	.name = SERIAL_BASE_PORT_NAME,
>   	.suppress_bind_attrs = true,
>   	.probe = serial_port_probe,
>   	.remove = serial_port_remove,

-- 
js
suse labs

