Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9DD76FD1A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjHDJUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjHDJTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:19:46 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE3E559A;
        Fri,  4 Aug 2023 02:16:15 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so18037415e9.0;
        Fri, 04 Aug 2023 02:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691140565; x=1691745365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YPz23FqYIlc5j/8gCdxJ8bH3cCRTTK8EI1tYOkWYBck=;
        b=a2lwhoj6h+d1aSp9kI2/HN3qF7qrSjKIkvbfWoFQokReBw+ocizhgXrNHQNdWvhwvm
         Nu8Mrj48ah/bBJVpxNJL5Oe5/N+KeGbWhVtvLXmWBYAhX6jJLcGEUX/mvHvklW6o/EfC
         NvDCxEW5TXJnUZEe6ZYD90brLl8wRU9Mag3/OcGrgOSPRJfkPJDD9W68nlLXtmVzzY1u
         8sFng9mGx2ueuUv6a1pUJTyNgMFgDTCWzrTUTt7WnwuingeCCaxFYhDd3KqOUewatIXt
         LjIlQcgk592kEg2BhvFHjheiujb19eYJbv5fLxa4fFwAD6xPAXlAkY1MnizDMHKIlC0E
         iUMQ==
X-Gm-Message-State: AOJu0YxtKIriVvJKDyFO87cGZYYws/E9CebdEi3qtjTCXbsjKQ5KplbO
        J2O5lCllRM5YmHTvWbnsjYI=
X-Google-Smtp-Source: AGHT+IG/66fvkEhbHoVVsOBJpbIp3Zg3a4Sd/dRm6m+w7TJJBw4j/UdNxgMq0QEuaimBZD9mkDpPoA==
X-Received: by 2002:a1c:cc08:0:b0:3fb:b3aa:1c8f with SMTP id h8-20020a1ccc08000000b003fbb3aa1c8fmr1015720wmb.28.1691140564756;
        Fri, 04 Aug 2023 02:16:04 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id e22-20020a05600c219600b003fc080acf68sm6215241wme.34.2023.08.04.02.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 02:16:04 -0700 (PDT)
Message-ID: <959278d8-d76e-fda8-6d0d-64e284c0ba1b@kernel.org>
Date:   Fri, 4 Aug 2023 11:16:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] serial: core: Fix kmemleak issue for serial core device
 remove
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
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
References: <20230804090909.51529-1-tony@atomide.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230804090909.51529-1-tony@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 08. 23, 11:09, Tony Lindgren wrote:
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

I didn't check the code, but device_unregister()?

-- 
js
suse labs

