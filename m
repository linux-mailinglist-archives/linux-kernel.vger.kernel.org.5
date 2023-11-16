Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C397EDE9D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345030AbjKPKfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbjKPKfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:35:16 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EDAD42;
        Thu, 16 Nov 2023 02:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=hATFZBvv9C0tyg+qA91L6v4ZurGsEZYprS7gdv+GBJ8=; b=IH1ZtbPTAuU0WICTCh4llxJigD
        E/G3qGRosmSCagARmbK1UzD/WCTB8v3H/CATKlDAxE2+VOad+/3t89p4RArERBubpIpED6d3i3QVx
        Cow9yH27OMWDCWxDHyiR1Dkfo/41+RFY65o0UsGUORKREvdW1EjViu+TnDMZe7Vj1JL4=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:59436 helo=asus64.hugovil.com)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1r3ZiB-0000sO-Jg; Thu, 16 Nov 2023 05:35:04 -0500
Date:   Thu, 16 Nov 2023 05:35:02 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc:     <git@amd.com>, <michal.simek@amd.com>, <jacmet@sunsite.dk>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <corbet@lwn.net>, <christophe.leroy@csgroup.eu>,
        <rdunlap@infradead.org>, <airlied@redhat.com>,
        <ogabbay@kernel.org>, <linux-doc@vger.kernel.org>,
        <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
        <shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>
Message-Id: <20231116053502.a66a6da2a82db94f4cbdb350@hugovil.com>
In-Reply-To: <20231116072915.3338387-3-manikanta.guntupalli@amd.com>
References: <20231116072915.3338387-1-manikanta.guntupalli@amd.com>
        <20231116072915.3338387-3-manikanta.guntupalli@amd.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,URIBL_CSS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH V3 2/2] serial: uartlite: Use dynamic allocation for
 major number when uart ports > 4
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 12:59:15 +0530
Manikanta Guntupalli <manikanta.guntupalli@amd.com> wrote:

Hi,

> Device number 204 has a range of minors on major number.
> uart_register_driver is failing due to lack of minor numbers
> when more number of uart ports used. So, to avoid minor number
> limitation on 204 major number use dynamic major allocation
> when more than 4 uart ports used otherwise use static major
> allocation.
> 
> https://docs.kernel.org/arch/arm/sa1100/serial_uart.html
> 
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> ---
> Changes for V2:
> Update logic to use either static or dynamic major allocation.
> Update commit description.
> Update description of SERIAL_UARTLITE_NR_UARTS in Kconfig.
> Changes for V3:
> Fix typo.
> Remove parentheses.
> ---
>  drivers/tty/serial/Kconfig    | 2 ++
>  drivers/tty/serial/uartlite.c | 5 +++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 732c893c8d16..c3c82b740078 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -532,6 +532,8 @@ config SERIAL_UARTLITE_NR_UARTS
>  	help
>  	  Set this to the number of uartlites in your system, or the number
>  	  you think you might implement.
> +	  If maximum number of uartlite serial ports are more than 4, then driver uses

"are more" -> "is more"

"then driver" -> "the driver" (or "then the driver")

Hugo.

> +	  dynamic allocation instead of static allocation for major number.
>  
>  config SERIAL_SUNCORE
>  	bool
> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> index 404c14acafa5..66d751edcf45 100644
> --- a/drivers/tty/serial/uartlite.c
> +++ b/drivers/tty/serial/uartlite.c
> @@ -24,8 +24,13 @@
>  #include <linux/pm_runtime.h>
>  
>  #define ULITE_NAME		"ttyUL"
> +#if CONFIG_SERIAL_UARTLITE_NR_UARTS > 4
> +#define ULITE_MAJOR             0       /* use dynamic node allocation */
> +#define ULITE_MINOR             0
> +#else
>  #define ULITE_MAJOR		204
>  #define ULITE_MINOR		187
> +#endif
>  #define ULITE_NR_UARTS		CONFIG_SERIAL_UARTLITE_NR_UARTS
>  
>  /* ---------------------------------------------------------------------
> -- 
> 2.25.1
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>
