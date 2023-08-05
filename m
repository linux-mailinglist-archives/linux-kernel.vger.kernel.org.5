Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD63770DD8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 07:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjHEFFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 01:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjHEFE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 01:04:57 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B314EDE;
        Fri,  4 Aug 2023 22:04:52 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37554T6S024506;
        Sat, 5 Aug 2023 00:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691211869;
        bh=HXm8Ynush4kosF6PZ2GndxlGNAcmirD9k4Zgwg7HuWI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=iYDPuqtGkLBCHop4rx4+vbWqY3qXF2b5yG9eMrFvN1FeDTkIznWxXaTcu6A4zZe4c
         4a2ObRUXPvpaytRFHtEtPUDcq5dWOsdY+QfaixXfygW1+Nw2LvkEiQd7QZGGKJyKDB
         isQZzwTu2q02bgzFXQ84S3VRoJyzWA6QGk8FixxY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37554TcT061897
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 5 Aug 2023 00:04:29 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 5
 Aug 2023 00:04:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 5 Aug 2023 00:04:29 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37554RdG102742;
        Sat, 5 Aug 2023 00:04:28 -0500
Date:   Sat, 5 Aug 2023 10:34:27 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: Fix oops for port->pm on uart_change_pm()
Message-ID: <20230805050427.tj4ya7w3a3nzc2dp@dhruva>
References: <20230804131553.52927-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230804131553.52927-1-tony@atomide.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 04, 2023 at 16:15:51 +0300, Tony Lindgren wrote:
> Unloading a hardware specific 8250 driver can produce error "Unable to
> handle kernel paging request at virtual address" about ten seconds after
> unloading the driver. This happens on uart_hangup() calling
> uart_change_pm().
> 
> Turns out commit 04e82793f068 ("serial: 8250: Reinit port->pm on port
> specific driver unbind") was only a partial fix. If the hardware specific
> driver has initialized port->pm function, we need to clear port->pm too.
> Just reinitializing port->ops does not do this. Otherwise serial8250_pm()
> will call port->pm() instead of serial8250_do_pm().

Thanks for catching and fixing this!

> 
> Fixes: 04e82793f068 ("serial: 8250: Reinit port->pm on port specific driver unbind")
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -3278,6 +3278,7 @@ void serial8250_init_port(struct uart_8250_port *up)
>  
>  	spin_lock_init(&port->lock);
>  	port->ctrl_id = 0;
> +	port->pm = NULL;

Reviewed-by: Dhruva Gole <d-gole@ti.com>

>  	port->ops = &serial8250_pops;
>  	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
>  
> -- 
> 2.41.0

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
