Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8068757821
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjGRJde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjGRJd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:33:26 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29902E55;
        Tue, 18 Jul 2023 02:33:25 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2b8390003e2so67063441fa.0;
        Tue, 18 Jul 2023 02:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689672803; x=1692264803;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKSX+1IEj9WwpflsadgWtRaqKWW0KmmUlzdN9e1GQrk=;
        b=Iqy+vV1SMp9QzpFIlypJEnJcM+7w5vjLpYr+rJsnlMuMOCQrP9/OMRdS2Tu+Po4UNX
         j4fH5JJKZXpq9nJwHyfeukrryNDB7426uIPow3Ym65CT+ZHiKs70gQnBHa+PoWlSnzXp
         YGFB20cDNDTdBzsoLBY3B2xfMpIvmzXgI/Z6jmW3/IYlUEhQKjMAmwBhW9WhsRwAdOXo
         TrnVoX5qQrM36B95QSZy7KDJVyEk0rspaADCUxqUrB+wg4Hllvz4t18myo+COwCLIjF3
         yIK6PX0YG4mkyojhn5AM7Jj6DVrKYvr7A5GalAbhYj4d4nq3ew5CQwKtqyxzhY8Cjctz
         /CVg==
X-Gm-Message-State: ABy/qLarbJUdrKbpI2Xp2GYbxXVDZG1UUlHIgQNQEeKzTEz+EkuLuoiT
        EV5ksGQiCyx+rbVj2+ap0lU=
X-Google-Smtp-Source: APBJJlFQKnqZLiX/Zeb73TCKFBNgH+1uPlUO4uXcJWeY/VksFe+ZdTOUXc/jaJeaE0FpwSNyPcVRRA==
X-Received: by 2002:a2e:9c4d:0:b0:2b6:fcd0:2aa1 with SMTP id t13-20020a2e9c4d000000b002b6fcd02aa1mr1448253ljj.43.1689672803097;
        Tue, 18 Jul 2023 02:33:23 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id gy11-20020a170906f24b00b009737b8d47b6sm755938ejb.203.2023.07.18.02.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 02:33:22 -0700 (PDT)
Message-ID: <3652da4b-8ccf-34a8-bdb7-757a3109ac54@kernel.org>
Date:   Tue, 18 Jul 2023 11:33:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>, gregkh@linuxfoundation.org,
        ilpo.jarvinen@linux.intel.com, shenwei.wang@nxp.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
References: <20230718065645.6588-1-sherry.sun@nxp.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: Fix possible integer overflow
In-Reply-To: <20230718065645.6588-1-sherry.sun@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 07. 23, 8:56, Sherry Sun wrote:
> This patch addresses the following Coverity report, fix it by casting
> sport->port.frame_time to type u64.
> 
> CID 32305660: Unintentional integer overflow (OVERFLOW_BEFORE_WIDEN)
> Potentially overflowing expression sport->port.frame_time * 8U with type
> unsigned int (32 bits, unsigned) is evaluated using 32-bit arithmetic,
> and then used in a context that expects an expression of type u64 (64
> bits, unsigned).
> 
> Fixes: cf9aa72d2f91 ("tty: serial: fsl_lpuart: optimize the timer based EOP logic")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>   drivers/tty/serial/fsl_lpuart.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index c1980ea52666..07b3b26732db 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1373,7 +1373,7 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
>   
>   	sport->last_residue = 0;
>   	sport->dma_rx_timeout = max(nsecs_to_jiffies(
> -		sport->port.frame_time * DMA_RX_IDLE_CHARS), 1UL);
> +		(u64)sport->port.frame_time * DMA_RX_IDLE_CHARS), 1UL);

Can you explain how that can overflow? In the worst case (1 start bit, 8 
data bits, 2 stop bits, parity bit, address bit, 50 bauds), frame_time 
would contain:
13*1e9/50 = 260,000,000. (260 ms)

Then the multiplication above is:
260,000,000*8 = 2,080,000,000. (2 seconds)

which is still less than 2^32-1.

thanks,
-- 
js
suse labs

