Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B717DEE5F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjKBIvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbjKBIu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:50:58 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1B6137;
        Thu,  2 Nov 2023 01:50:46 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A28oYrQ033035;
        Thu, 2 Nov 2023 03:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698915034;
        bh=EykruRatXE7RVb6LMNRJfyVGU31FMDJe9o9Z2a0tiH0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=j91EtjcCIX1vHpL0h8LqkBFRxyMkf2zF6zoaFHG2tA4qzww2mbRuvOLDXSdOd9lDr
         Tzy2/ajzP558x+Y9WvxDPXF02cIRsGj3zPM2YQvmpjEqsNX/8+jG9JJofyMo/Z1Dy4
         aY/ZKlGVcenM42kwtY0UPXXYXA7s3OcyGYR0QDrE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A28oYBq114998
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Nov 2023 03:50:34 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 Nov 2023 03:50:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 Nov 2023 03:50:34 -0500
Received: from [172.24.227.94] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A28oUf1079168;
        Thu, 2 Nov 2023 03:50:31 -0500
Message-ID: <b3e76fae-fc04-4231-b215-560f4c97ebe1@ti.com>
Date:   Thu, 2 Nov 2023 14:20:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] serial: 8250: 8250_omap: Do not start RX DMA on THRI
 interrupt
Content-Language: en-US
To:     Ronald Wahl <rwahl@gmx.de>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Ronald Wahl <ronald.wahl@raritan.com>, <stable@vger.kernel.org>
References: <20231101171431.16495-1-rwahl@gmx.de>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20231101171431.16495-1-rwahl@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/11/23 22:44, Ronald Wahl wrote:
> From: Ronald Wahl <ronald.wahl@raritan.com>
> 
> Starting RX DMA on THRI interrupt is too early because TX may not have
> finished yet.
> 
> This change is inspired by commit 90b8596ac460 ("serial: 8250: Prevent
> starting up DMA Rx on THRI interrupt") and fixes DMA issues I had with
> an AM62 SoC that is using the 8250 OMAP variant.
> 
> Cc: stable@vger.kernel.org
> Fixes: c26389f998a8 ("serial: 8250: 8250_omap: Add DMA support for UARTs on K3 SoCs")
> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
> ---
> V4: - add missing braces to fix build warning
> 
> V3: - add Cc: stable@vger.kernel.org
> 
> V2: - add Fixes: tag
>     - fix author
> 
>  drivers/tty/serial/8250/8250_omap.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index c7ab2963040b..1122f37fe744 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1282,10 +1282,12 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
> 
>  	status = serial_port_in(port, UART_LSR);
> 
> -	if (priv->habit & UART_HAS_EFR2)
> -		am654_8250_handle_rx_dma(up, iir, status);
> -	else
> -		status = omap_8250_handle_rx_dma(up, iir, status);
> +	if ((iir & 0x3f) != UART_IIR_THRI) {
> +		if (priv->habit & UART_HAS_EFR2)
> +			am654_8250_handle_rx_dma(up, iir, status);
> +		else
> +			status = omap_8250_handle_rx_dma(up, iir, status);
> +	}

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Thanks for the fix!

> 
>  	serial8250_modem_status(up);
>  	if (status & UART_LSR_THRE && up->dma->tx_err) {
> --
> 2.41.0
> 

-- 
Regards
Vignesh
