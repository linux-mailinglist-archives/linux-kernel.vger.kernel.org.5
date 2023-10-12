Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9ADB7C6B52
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbjJLKkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbjJLKkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:40:06 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85474C4;
        Thu, 12 Oct 2023 03:40:01 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 999D612000B;
        Thu, 12 Oct 2023 13:39:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 999D612000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1697107197;
        bh=DMO1fbaxiJGjPN9WQ10e4eW8hl/woEJKz7PL7eN8BOw=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=FUs6xpMDNynoss+EKicaa+qA+s1dgXtfUaEV7MufTshWMqE4qiPfVvKrNHixa/rUr
         EeoZi1k5/1KlED5F0EkJSzosHj9f0c8ZXc90E3nTR+0I8W2r9d2u5M8b7LwP7OMOsR
         fbIY1iy/pYC/D34wzIMp824YvmBWDAj/cBoh0tX6BkMrVcErPkptWEKJrcqVNB4tjm
         H9KpqRrT2Dp1FscdbSzwXVNRq02x2/X7JWF641RmUt1XhsozpULvAzZXnbDe26JXGG
         Iwk1LKCFssZ8urNWj1hsnq1Ou9jdvIqoTZdzWZ9zCSPSxKQvSdbG5Pd4JT3JqTVcpI
         S0W28fgZlGv2w==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu, 12 Oct 2023 13:39:57 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 12 Oct
 2023 13:39:57 +0300
Date:   Thu, 12 Oct 2023 13:39:57 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     <pkrasavin@imaqliq.ru>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@sberdevices.ru>,
        <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH] tty: serial: meson: hard LOCKUP on crtscts mode
Message-ID: <20231012103957.p2faputywfgh776x@CAB-WSD-L081021>
References: <OF28B2B8C9.5BC0CD28-ON00258A46.0037688F-00258A46.0039155B@gdc.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <OF28B2B8C9.5BC0CD28-ON00258A46.0037688F-00258A46.0039155B@gdc.ru>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180559 [Oct 12 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 539 539 807534d9021bfe9ca369c363d15ac993cd93d4d9, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2;lists.infradead.org:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/10/12 08:55:00
X-KSMG-LinksScanning: Clean, bases: 2023/10/12 08:55:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/12 09:26:00 #22171384
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pavel,

On Thu, Oct 12, 2023 at 10:23:30AM +0000, pkrasavin@imaqliq.ru wrote:
> There might be hard lockup if we set crtscts mode on port without RTS/CTS configured:
> 
> # stty -F /dev/ttyAML6 crtscts; echo 1 > /dev/ttyAML6; echo 2 > /dev/ttyAML6
> [   95.890386] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [   95.890857] rcu:     3-...0: (201 ticks this GP) idle=e33c/1/0x4000000000000000 softirq=5844/5846 fqs=4984
> [   95.900212] rcu:     (detected by 2, t=21016 jiffies, g=7753, q=296 ncpus=4)
> [   95.906972] Task dump for CPU 3:
> [   95.910178] task:bash            state:R  running task     stack:0     pid:205   ppid:1      flags:0x00000202
> [   95.920059] Call trace:
> [   95.922485]  __switch_to+0xe4/0x168
> [   95.925951]  0xffffff8003477508
> [   95.974379] watchdog: Watchdog detected hard LOCKUP on cpu 3
> [   95.974424] Modules linked in: 88x2cs(O) rtc_meson_vrtc
> 
> Possible solution would be to not allow to setup crtscts on such port.
> 
> Tested on S905X3 based board.
> 
> Signed-off-by: Pavel Krasavin <pkrasavin@imaqliq.com>
> 
> --- a/drivers/tty/serial/meson_uart.c	2023-08-22 12:46:50.933814528 +0300
> +++ b/drivers/tty/serial/meson_uart.c	2023-08-22 14:48:15.593169948 +0300
> @@ -380,10 +380,15 @@ static void meson_uart_set_termios(struc
>  	else
>  		val |= AML_UART_STOP_BIT_1SB;
>  
> -	if (cflags & CRTSCTS)
> -		val &= ~AML_UART_TWO_WIRE_EN;
> -	else
> +	if (cflags & CRTSCTS) {
> +		if (port->flags & UPF_HARD_FLOW) {
> +			val &= ~AML_UART_TWO_WIRE_EN;
> +		} else {
> +			termios->c_cflag &= ~CRTSCTS;
> +		}

Please do not use braces where is single statement. In other words:

	if (cflags & CRTSCTS) {
		if (port->flags & UPF_HARD_FLOW)
			val &= ~AML_UART_TWO_WIRE_EN;
		else
			termios->c_cflag &= ~CRTSCTS;
	} else {
		val |= AML_UART_TWO_WIRE_EN;
	}

> +	} else {
>  		val |= AML_UART_TWO_WIRE_EN;
> +	}
>  
>  	writel(val, port->membase + AML_UART_CONTROL);
>  
> @@ -705,6 +710,7 @@ static int meson_uart_probe(struct platf
>  	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
>  	int ret = 0;
>  	int irq;
> +	bool has_rtscts;
>  
>  	if (pdev->dev.of_node)
>  		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
> @@ -732,6 +738,7 @@ static int meson_uart_probe(struct platf
>  		return irq;
>  
>  	of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
> +	has_rtscts = of_property_read_bool(pdev->dev.of_node, "uart-has-rtscts");
>  
>  	if (meson_ports[pdev->id]) {
>  		return dev_err_probe(&pdev->dev, -EBUSY,
> @@ -762,6 +769,8 @@ static int meson_uart_probe(struct platf
>  	port->mapsize = resource_size(res_mem);
>  	port->irq = irq;
>  	port->flags = UPF_BOOT_AUTOCONF | UPF_LOW_LATENCY;
> +	if (has_rtscts)
> +		port->flags |= UPF_HARD_FLOW;
>  	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MESON_CONSOLE);
>  	port->dev = &pdev->dev;
>  	port->line = pdev->id;
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Thank you,
Dmitry
