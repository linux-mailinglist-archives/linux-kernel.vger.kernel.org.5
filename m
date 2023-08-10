Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377FB7773E2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbjHJJMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbjHJJM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:12:28 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D47A2123;
        Thu, 10 Aug 2023 02:12:08 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37A99XXP123734;
        Thu, 10 Aug 2023 04:09:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691658573;
        bh=6CrqwtdtTMQQYtirl768oVpxOHXUYkfqpbiJtiq6HIU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=DefJEtk6YcDg8i2NG+00iUx9T2oRygzNIbBPA9bxWAtkpYvDRlPD66D39mQVumz+9
         Lk/1mScSfkJexCQsQ/Pmf5UbM2YtV5aImYBCNXJ2mbOo8i2Wh7a7lb/4p5kYeNACwE
         UAnxIVwWJ/MRjf33Ik1p6e0hUu9FUkgtJXqG2AM4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37A99XP2031836
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 04:09:33 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 04:09:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 04:09:32 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37A99Vjo084143;
        Thu, 10 Aug 2023 04:09:31 -0500
Date:   Thu, 10 Aug 2023 14:39:30 +0530
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
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] serial: core: Fix serial core port id, including
 multiport devices
Message-ID: <20230810090930.fylxbzh5v5jffh75@dhruva>
References: <20230810065737.47294-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230810065737.47294-1-tony@atomide.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 10, 2023 at 09:57:34 +0300, Tony Lindgren wrote:
> We want to fix the serial core port DEVNAME to use a port id of the
> hardware specific controller port instance instead of the port->line.
> 
> For example, the 8250 driver sets up a number of serial8250 ports
> initially that can be inherited by the hardware specific driver. At that
> the port->line no longer decribes the port's relation to the serial core
> controller instance.
> 
> Let's fix the issue by assigning port->port_id for each serial core
> controller port instance.
> 
> Fixes: 7d695d83767c ("serial: core: Fix serial_base_match() after fixing controller port name")
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/tty/serial/serial_base.h     |  1 +
>  drivers/tty/serial/serial_base_bus.c | 28 +++++++++++++++++++++++++++-
>  2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/serial_base.h b/drivers/tty/serial/serial_base.h
> --- a/drivers/tty/serial/serial_base.h
> +++ b/drivers/tty/serial/serial_base.h
> @@ -16,6 +16,7 @@ struct device;
>  
>  struct serial_ctrl_device {
>  	struct device dev;
> +	struct ida port_ida;

LGTM!

Reviewed-by: Dhruva Gole <d-gole@ti.com>

[...]

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
