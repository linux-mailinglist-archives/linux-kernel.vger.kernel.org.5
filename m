Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6372E7F3961
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjKUWld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjKUWlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:41:32 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6106E7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:41:28 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7a683bd610dso210724439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700606488; x=1701211288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P6Y5P6vvizTkCcH4d/w5IMJ1P3rAQH0RFmdfD+hCzFk=;
        b=SippKTRuhIN+Tm6Ut4P3RFBAAExms/ddv4eoR9OxmXCt/h7ClDFBpFqFz0wLphpMQr
         5va03IrpKhS5jmjAWzObhba6k+AJcoIxy+X8SPt3LwZx+3eGzwqS8lBg8U4fFqvt0Jky
         WTLCgiJOXQnbD/9pFhV3rNIqjUe19MitqRtyg+pS3PvEps4QZbA8/FxGLyTx8jQ9vAfK
         oWXO6QAn7OuWdjrs3ZlagUTw+mnu8QYELLNOpuvHFguXSPUOUnV0df2XC7KnZSSAILPc
         UfVzanVQp53Jb6OcBOZ1NiBMb/oZ/hwUKgr0/UkhEDh1w4S/PugxU6AEb+lAPgI4ELbb
         tDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700606488; x=1701211288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6Y5P6vvizTkCcH4d/w5IMJ1P3rAQH0RFmdfD+hCzFk=;
        b=MCGAqIQvteyVj3Wx/50XKkHzS75jh7QlwBefes2PcuJJg+AJcp+eN6RtiVefirQG33
         rkCvp1WFPdRUCAxMagsKVf4dVoElWGbfODnMjPx1BWqF+EJGvXK9LyDwjdMLh6ZwpJMH
         wnRVZ+H2y6irhZNTG0LZ5PMozwrmF/Whs8BbjhkcCPU990mvrsqcaQyE33fiDM6mbyh4
         xQS8Gn43bu68Mecmd3imXdIl3Ptke8IfwypSQwJ4IetI+we+sDxltxlGhVVeBCqXck9o
         y1PIDjCd6IMM8CFLsrQkB1l3xCs4HSBwwBXYvo/B33cWXU15PVzl9gymQF3n4e88G5zL
         dc9A==
X-Gm-Message-State: AOJu0YzGTdlXffPWSiNXB9xbR0v20YlTpUPhpgM2RX60ryt5A+MUBZw7
        ZhsYWDYaZgMnVerpNZNDjQcfHg==
X-Google-Smtp-Source: AGHT+IFH/7RqkC4+CMkzTbT30NHfcCp/3hQroU+yf96S1nn9LE96a/StCjzs0+QoFrxTjKwkdSqwCg==
X-Received: by 2002:a6b:f719:0:b0:79f:d04d:ce5a with SMTP id k25-20020a6bf719000000b0079fd04dce5amr326806iog.2.1700606488169;
        Tue, 21 Nov 2023 14:41:28 -0800 (PST)
Received: from ?IPV6:2605:a601:adae:4500:3d43:c8e2:1496:e620? ([2605:a601:adae:4500:3d43:c8e2:1496:e620])
        by smtp.gmail.com with ESMTPSA id s7-20020a056602010700b007b34b374dd1sm509116iot.18.2023.11.21.14.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 14:41:27 -0800 (PST)
Message-ID: <8c0f4eba-1923-4686-b07b-1f3b78b298e9@sifive.com>
Date:   Tue, 21 Nov 2023 16:41:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] tty/serial: Add RISC-V SBI debug console based
 earlycon
Content-Language: en-US
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
References: <20231118033859.726692-1-apatel@ventanamicro.com>
 <20231118033859.726692-4-apatel@ventanamicro.com>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231118033859.726692-4-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

On 2023-11-17 9:38 PM, Anup Patel wrote:
> We extend the existing RISC-V SBI earlycon support to use the new
> RISC-V SBI debug console extension.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  drivers/tty/serial/Kconfig              |  2 +-
>  drivers/tty/serial/earlycon-riscv-sbi.c | 24 ++++++++++++++++++++----
>  2 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 732c893c8d16..1f2594b8ab9d 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -87,7 +87,7 @@ config SERIAL_EARLYCON_SEMIHOST
>  
>  config SERIAL_EARLYCON_RISCV_SBI
>  	bool "Early console using RISC-V SBI"
> -	depends on RISCV_SBI_V01
> +	depends on RISCV_SBI
>  	select SERIAL_CORE
>  	select SERIAL_CORE_CONSOLE
>  	select SERIAL_EARLYCON
> diff --git a/drivers/tty/serial/earlycon-riscv-sbi.c b/drivers/tty/serial/earlycon-riscv-sbi.c
> index 27afb0b74ea7..5351e1e31f45 100644
> --- a/drivers/tty/serial/earlycon-riscv-sbi.c
> +++ b/drivers/tty/serial/earlycon-riscv-sbi.c
> @@ -15,17 +15,33 @@ static void sbi_putc(struct uart_port *port, unsigned char c)
>  	sbi_console_putchar(c);
>  }
>  
> -static void sbi_console_write(struct console *con,
> -			      const char *s, unsigned n)
> +static void sbi_0_1_console_write(struct console *con,
> +				  const char *s, unsigned int n)
>  {
>  	struct earlycon_device *dev = con->data;
>  	uart_console_write(&dev->port, s, n, sbi_putc);
>  }
>  
> +static void sbi_dbcn_console_write(struct console *con,
> +				   const char *s, unsigned int n)
> +{
> +	sbi_debug_console_write(n, __pa(s));

This only works for strings in the linear mapping or the kernel mapping (not
vmalloc, which includes the stack). So I don't think we can use __pa() here.

> +}
> +
>  static int __init early_sbi_setup(struct earlycon_device *device,
>  				  const char *opt)
>  {
> -	device->con->write = sbi_console_write;
> -	return 0;
> +	int ret = 0;
> +
> +	if (sbi_debug_console_available) {
> +		device->con->write = sbi_dbcn_console_write;
> +	} else {
> +		if (IS_ENABLED(CONFIG_RISCV_SBI_V01))

"else if", no need for the extra block/indentation.

Regards,
Samuel

> +			device->con->write = sbi_0_1_console_write;
> +		else
> +			ret = -ENODEV;
> +	}
> +
> +	return ret;
>  }
>  EARLYCON_DECLARE(sbi, early_sbi_setup);

