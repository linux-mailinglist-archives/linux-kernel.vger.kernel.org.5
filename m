Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21CC7DEED1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345619AbjKBJ1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345474AbjKBJ1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:27:12 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E18182;
        Thu,  2 Nov 2023 02:27:05 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A29Qw2s040645;
        Thu, 2 Nov 2023 04:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698917218;
        bh=EdqLodOTtlgjyV9CO9EMSOpuI3JKeo6eegqllj6+txQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=hhhmxvvL/rHOkqRaSB3M149il/k9OZMXuuo/M8GgV1WegTb2vgEWaZ1Q2b5LP3kop
         Y3Lak7DKcHfgMEKvywMC2SMUx9984d6LptAWtn8efgaFRrHnYj7W9YCKq1PtFpZ8Ag
         pJK/NSIjOMfZeBwhf1Ql3LhkSr/rcWi0NeXIKbNU=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A29Qw0O117654
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Nov 2023 04:26:58 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 Nov 2023 04:26:57 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 Nov 2023 04:26:57 -0500
Received: from [172.24.227.94] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A29QtML112967;
        Thu, 2 Nov 2023 04:26:56 -0500
Message-ID: <fbe705a6-dade-49ce-9ec8-6d7b87198d11@ti.com>
Date:   Thu, 2 Nov 2023 14:56:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] serial: 8250: 8250_omap: Clear UART_HAS_RHR_IT_DIS bit
Content-Language: en-US
To:     Ronald Wahl <rwahl@gmx.de>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ronald Wahl <ronald.wahl@raritan.com>, <stable@vger.kernel.org>
References: <20231031110909.11695-1-rwahl@gmx.de>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20231031110909.11695-1-rwahl@gmx.de>
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



On 31/10/23 16:39, Ronald Wahl wrote:
> From: Ronald Wahl <ronald.wahl@raritan.com>
> 
> This fixes commit 439c7183e5b9 ("serial: 8250: 8250_omap: Disable RX
> interrupt after DMA enable") which unfortunately set the
> UART_HAS_RHR_IT_DIS bit in the UART_OMAP_IER2 register and never
> cleared it.
> 
> Cc: stable@vger.kernel.org
> Fixes: 439c7183e5b9 ("serial: 8250: 8250_omap: Disable RX interrupt after DMA enable")
> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
> ---
> V3: - add Cc: stable@vger.kernel.org
> 
> V2: - add Fixes: tag
>     - fix author
> 
>  drivers/tty/serial/8250/8250_omap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index ca972fd37725..c7ab2963040b 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -914,7 +914,7 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
>  	if (priv->habit & UART_HAS_RHR_IT_DIS) {
>  		reg = serial_in(p, UART_OMAP_IER2);
>  		reg &= ~UART_OMAP_IER2_RHR_IT_DIS;
> -		serial_out(p, UART_OMAP_IER2, UART_OMAP_IER2_RHR_IT_DIS);
> +		serial_out(p, UART_OMAP_IER2, reg);
>  	}
> 
>  	dmaengine_tx_status(rxchan, cookie, &state);
> @@ -1060,7 +1060,7 @@ static int omap_8250_rx_dma(struct uart_8250_port *p)
>  	if (priv->habit & UART_HAS_RHR_IT_DIS) {
>  		reg = serial_in(p, UART_OMAP_IER2);
>  		reg |= UART_OMAP_IER2_RHR_IT_DIS;
> -		serial_out(p, UART_OMAP_IER2, UART_OMAP_IER2_RHR_IT_DIS);
> +		serial_out(p, UART_OMAP_IER2, reg);
>  	}
> 
>  	dma_async_issue_pending(dma->rxchan);


Thanks for the fix!

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>



> --
> 2.41.0
> 

-- 
Regards
Vignesh
