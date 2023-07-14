Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0131C753A59
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbjGNMHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjGNMHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:07:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AED7212B;
        Fri, 14 Jul 2023 05:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689336468; x=1720872468;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=/htYl69qlNj31QSX3mVg5JuWkegOCtKSr3VzQLqpegg=;
  b=IxfPROnrLQk9jqvbh2JGJ8sAIn0p6o/FwmYdKsvg9LLmHzi7c2aH/fuV
   3r2oV4xTrObClI4urRlEIZNafbgSdWUhuvvjgGjvrup19vTjrvVvNDYgX
   B7rAJdOoAbSZqDJyPWDt0d9GoZda6LhMjwatb5l0wUPNZbiXnpvj9D84/
   ldvC6TU5x7E/n3VFW1MwfjMAaHrSO6m22Iwk4unlF4VT7M4UBvqqxWBtb
   YeJoHj0lGn133RF9nUKRE+3IUxuAGo8VBDjZPt37mePAe34dT+D+YLSlz
   ucdWvTAeIf5cg8nlVcgjgJEZ2kvpKV2HgZlQ4YE2WaQN9p65VvLMclLnj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="362926043"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="362926043"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 05:07:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="846433196"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="846433196"
Received: from rchauhax-mobl1.gar.corp.intel.com ([10.249.35.123])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 05:07:44 -0700
Date:   Fri, 14 Jul 2023 15:07:42 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Ruihong Luo <colorsu1922@gmail.com>
cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        stable@vger.kernel.org, luoruihong@xiaomi.com,
        weipengliang@xiaomi.com, wengjinfei@xiaomi.com
Subject: Re: [PATCH v4] serial: 8250_dw: Preserve original value of DLF
 register
In-Reply-To: <20230713004235.35904-1-colorsu1922@gmail.com>
Message-ID: <5fac4a28-ff70-d6e6-dcee-8cb45916789@linux.intel.com>
References: <20230713004235.35904-1-colorsu1922@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-16913354-1689336427=:1695"
Content-ID: <93c61472-25c0-bc4d-bf2c-23a581131bc@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-16913354-1689336427=:1695
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <6b473574-4ff8-9b19-862f-115f12225a5@linux.intel.com>

On Thu, 13 Jul 2023, Ruihong Luo wrote:

> Preserve the original value of the Divisor Latch Fraction (DLF) register.
> When the DLF register is modified without preservation, it can disrupt
> the baudrate settings established by firmware or bootloader, leading to
> data corruption and the generation of unreadable or distorted characters.
> 
> Fixes: 701c5e73b296 ("serial: 8250_dw: add fractional divisor support")

You forgot to add:

Cc: stable@vger.kernel.org

> Signed-off-by: Ruihong Luo <colorsu1922@gmail.com>

Other than that,

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

> ---
> v4:
> * Use the old_dlf to hold the DLF register value
> 
>  drivers/tty/serial/8250/8250_dwlib.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
> index 75f32f054ebb..84843e204a5e 100644
> --- a/drivers/tty/serial/8250/8250_dwlib.c
> +++ b/drivers/tty/serial/8250/8250_dwlib.c
> @@ -244,7 +244,7 @@ void dw8250_setup_port(struct uart_port *p)
>  	struct dw8250_port_data *pd = p->private_data;
>  	struct dw8250_data *data = to_dw8250_data(pd);
>  	struct uart_8250_port *up = up_to_u8250p(p);
> -	u32 reg;
> +	u32 reg, old_dlf;
>  
>  	pd->hw_rs485_support = dw8250_detect_rs485_hw(p);
>  	if (pd->hw_rs485_support) {
> @@ -270,9 +270,11 @@ void dw8250_setup_port(struct uart_port *p)
>  	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
>  		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
>  
> +	/* Preserve value written by firmware or bootloader  */
> +	old_dlf = dw8250_readl_ext(p, DW_UART_DLF);
>  	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
>  	reg = dw8250_readl_ext(p, DW_UART_DLF);
> -	dw8250_writel_ext(p, DW_UART_DLF, 0);
> +	dw8250_writel_ext(p, DW_UART_DLF, old_dlf);
>  
>  	if (reg) {
>  		pd->dlf_size = fls(reg);
> 
--8323329-16913354-1689336427=:1695--
