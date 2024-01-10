Return-Path: <linux-kernel+bounces-21558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F198482911C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9288A287BA6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6F0186F;
	Wed, 10 Jan 2024 00:02:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E1317C6;
	Wed, 10 Jan 2024 00:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14BDBDA7;
	Tue,  9 Jan 2024 16:02:50 -0800 (PST)
Received: from [192.168.20.13] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9CEC3F5A1;
	Tue,  9 Jan 2024 16:02:00 -0800 (PST)
Message-ID: <1b0de096-101a-9764-0396-d8b86878badf@arm.com>
Date: Tue, 9 Jan 2024 18:01:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] serial: 8250_bcm2835aux: Restore clock error handling
Content-Language: en-US
To: Stefan Wahren <wahrenst@gmx.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Adrien Thierry <athierry@redhat.com>, linux-serial@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20231220114334.4712-1-wahrenst@gmx.net>
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20231220114334.4712-1-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,


On 12/20/23 05:43, Stefan Wahren wrote:
> The commit fcc446c8aa63 ("serial: 8250_bcm2835aux: Add ACPI support")
> dropped the error handling for clock acquiring. But even an optional
> clock needs this.

Right, the call was changed to _optional() during review but the error 
handling didn't get put back.

> 
> Fixes: fcc446c8aa63 ("serial: 8250_bcm2835aux: Add ACPI support")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>   drivers/tty/serial/8250/8250_bcm2835aux.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
> index 15a2387a5b25..4f4502fb5454 100644
> --- a/drivers/tty/serial/8250/8250_bcm2835aux.c
> +++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
> @@ -119,6 +119,8 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
> 
>   	/* get the clock - this also enables the HW */
>   	data->clk = devm_clk_get_optional(&pdev->dev, NULL);
> +	if (IS_ERR(data->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(data->clk), "could not get clk\n");
> 
>   	/* get the interrupt */
>   	ret = platform_get_irq(pdev, 0);
> --

And on ACPI machines it returns NULL, which passes the error check now, 
so it works on an ACPI based pi.

Thanks!

Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>



