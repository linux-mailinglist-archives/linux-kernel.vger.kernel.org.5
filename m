Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640BE75921B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjGSJwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjGSJwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:52:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E544DEC;
        Wed, 19 Jul 2023 02:52:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E0A46134C;
        Wed, 19 Jul 2023 09:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108ABC433C7;
        Wed, 19 Jul 2023 09:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689760365;
        bh=p+VPpRPArB1Uz3WdiGB0Q/lkKspNzGEsJXp0xntNTak=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Z2abMUCWvgN0XC/hFUeMnoraY3M5H4fMDZRTWHPLtOgiRZ537ho5YDalpZPLAwvKe
         43IOiBWoLFBmgfopQKpevAknmbqSAn2D16htatfxHAl35e3leKXTT9BrdrYfbZovL0
         ZAJMWBN259/aumSwifFgPxHg0bUm9L3vjvf0zI8uNbw8CAI+nkVOwwW7JcbX3FrG7J
         TZZ+r8LoT8aFp78cAeR9t7xhoDBifxW9KK86OqxjzfV8F0Edgeen8j2AE3kJ1bRJHo
         elCtZ7lOaeqSADv+LRMr4OyqEMB/qeCXkVNyPJ6ZBV9KZkhOtL+brCmBDHH+wPo+7T
         DcEqa5KQs+eNQ==
Message-ID: <66dcf813-af1d-c7a0-5c02-3d2585ff6cc7@kernel.org>
Date:   Wed, 19 Jul 2023 18:52:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] ata: pata_arasan_cf: Use dev_err_probe() instead
 dev_err() in data_xfer()
Content-Language: en-US
To:     =?UTF-8?B?5p2c5pWP5p2w?= <duminjie@vivo.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Viresh Kumar <vireshk@kernel.org>,
        "open list:LIBATA PATA DRIVERS" <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     "opensource.kernel" <opensource.kernel@vivo.com>
References: <20230719094902.5643-1-duminjie@vivo.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230719094902.5643-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 18:49, 杜敏杰 wrote:
> It is possible for dma_request_chan() to return EPROBE_DEFER, which means
> acdev->host->dev is not ready yet.
> At this point dev_err() will have no output.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  drivers/ata/pata_arasan_cf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
> index 6ab294322..fd54682f1 100644
> --- a/drivers/ata/pata_arasan_cf.c
> +++ b/drivers/ata/pata_arasan_cf.c
> @@ -529,7 +529,8 @@ static void data_xfer(struct work_struct *work)
>  	/* dma_request_channel may sleep, so calling from process context */
>  	acdev->dma_chan = dma_request_chan(acdev->host->dev, "data");
>  	if (IS_ERR(acdev->dma_chan)) {
> -		dev_err(acdev->host->dev, "Unable to get dma_chan\n");
> +		dev_err_probe(acdev->host->dev, PTR_ERR(acdev->dma_chan),
> +					  "Unable to get dma_chan\n");

Still not aligned...

        dev_err_probe(acdev->host->dev, PTR_ERR(acdev->dma_chan),
                      "Unable to get dma_chan\n");

Like this please.

>  		acdev->dma_chan = NULL;
>  		goto chan_request_fail;
>  	}

-- 
Damien Le Moal
Western Digital Research

