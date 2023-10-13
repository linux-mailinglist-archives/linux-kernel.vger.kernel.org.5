Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2F87C8095
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjJMIru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjJMIrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:47:48 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC37B8;
        Fri, 13 Oct 2023 01:47:43 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id AB6FD120005;
        Fri, 13 Oct 2023 11:47:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru AB6FD120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1697186860;
        bh=HXYs0MWtc7HSmVrsJHHWD9cunUnnrMkSxFLeis0BXgc=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=ASk2sTinITZwMZMEIvojDyQtBS3v3XcRska4kG/NFjMvFH4VwatpW3baQJ1/CJn4U
         5kXO/hQLH67soKJ1u/VhII1KkPQxzSXSQ6tCwpJymOGgwfMuKvDKpVd95gMc4R2hPM
         WxsJdKKNNwbZEQ6YoXzxKC8CqulwdfjA3S9pIgvfI/ipTLOyvYKPTW26s6rLl8ARLb
         +XqEf903a9QMzfvqrFApB95rY6taFgxGan/Shc8sjIsdsxJrsdzsxyByj6Kn0VUPnq
         vxzume0/i5voUT/vloUcjmlhhKkCZ0prTF+f+ymHummBsU+yg34h3Rn472cYNhDOsh
         kXep/5zV25aIg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 13 Oct 2023 11:47:40 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 13 Oct
 2023 11:47:40 +0300
Date:   Fri, 13 Oct 2023 11:47:40 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     Pavel Krasavin <pkrasavin@imaqliq.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH v3] tty: serial: meson: hard LOCKUP on crtscts mode
Message-ID: <20231013084740.y6da63hlpurbqzsc@CAB-WSD-L081021>
References: <OF6CF5FFA0.CCFD0E8E-ON00258A46.00549EDF-00258A46.0054BB62@gdc.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <OF6CF5FFA0.CCFD0E8E-ON00258A46.00549EDF-00258A46.0054BB62@gdc.ru>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180594 [Oct 13 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 539 539 807534d9021bfe9ca369c363d15ac993cd93d4d9, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;lists.infradead.org:7.1.1;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/10/13 07:17:00
X-KSMG-LinksScanning: Clean, bases: 2023/10/13 07:17:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/13 05:40:00 #22179781
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 03:25:29PM +0000, Pavel Krasavin wrote:
> From: Pavel Krasavin <pkrasavin@imaqliq.com>
> 
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

Reviewed-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

> ---
> v3: "From:" line added to the mail
> v2: https://lore.kernel.org/lkml/OF950BEF72.7F425944-ON00258A46.00488A76-00258A46.00497D44@gdc.ru/
> braces for single statement removed according to Dmitry's note
> v1: https://lore.kernel.org/lkml/OF28B2B8C9.5BC0CD28-ON00258A46.0037688F-00258A46.0039155B@gdc.ru/
> ---
> 
> --- a/drivers/tty/serial/meson_uart.c	2023-10-12 15:44:02.410538523 +0300
> +++ b/drivers/tty/serial/meson_uart.c	2023-10-12 15:58:06.242395253 +0300
> @@ -380,10 +380,14 @@ static void meson_uart_set_termios(struc
>  	else
>  		val |= AML_UART_STOP_BIT_1SB;
>  
> -	if (cflags & CRTSCTS)
> -		val &= ~AML_UART_TWO_WIRE_EN;
> -	else
> +	if (cflags & CRTSCTS) {
> +		if (port->flags & UPF_HARD_FLOW)
> +			val &= ~AML_UART_TWO_WIRE_EN;
> +		else
> +			termios->c_cflag &= ~CRTSCTS;
> +	} else {
>  		val |= AML_UART_TWO_WIRE_EN;
> +	}
>  
>  	writel(val, port->membase + AML_UART_CONTROL);
>  
> @@ -705,6 +709,7 @@ static int meson_uart_probe(struct platf
>  	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
>  	int ret = 0;
>  	int irq;
> +	bool has_rtscts;
>  
>  	if (pdev->dev.of_node)
>  		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
> @@ -732,6 +737,7 @@ static int meson_uart_probe(struct platf
>  		return irq;
>  
>  	of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
> +	has_rtscts = of_property_read_bool(pdev->dev.of_node, "uart-has-rtscts");
>  
>  	if (meson_ports[pdev->id]) {
>  		return dev_err_probe(&pdev->dev, -EBUSY,
> @@ -762,6 +768,8 @@ static int meson_uart_probe(struct platf
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
