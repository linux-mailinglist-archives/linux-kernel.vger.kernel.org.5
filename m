Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E5D75F391
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjGXKkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjGXKkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:40:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129C610C9;
        Mon, 24 Jul 2023 03:39:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C66F6104E;
        Mon, 24 Jul 2023 10:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4724C433C8;
        Mon, 24 Jul 2023 10:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690195158;
        bh=BzE1XS3acwqK5HWUiMy9qr6lCfG4FqBFUM6dZbX7ExA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZgR2WiN9V/A5oenVYeVBhe/Puae+88qC3Pqo0jNBYHXo2lnWz6/OwjlNe0JCVUNoK
         GWmdkrjpezdIv84QaLStQcD0y5/X9GXAPupxl2sH1le0Q3dW1ghSn5v2cjemwpS8Jw
         z8L2WLgkw7n4a8nlXgvcc2xKa6yUeN4uvkTS6x531UklKN0X3erRXPUG2RebG/55qf
         oVPQAHvqzHpfxvSszMPrGUf+yxwEOPgF7k5/4zumRL2j3R5vq7pxXUHN8Qmbc2b8bj
         oPa8MnSl0g7EcTKZv4sT2gWdicfLLkCyFHWMLks9ZprGkT1a+d4U1stuXnAkFcmeIL
         wetCCfvvf++2A==
Message-ID: <579874bb-3f50-d4ff-9af9-87f3555e3511@kernel.org>
Date:   Mon, 24 Jul 2023 19:39:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] ata: pata_arasan_cf: Use dev_err_probe() instead
 dev_err() in data_xfer()
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Viresh Kumar <vireshk@kernel.org>,
        "open list:LIBATA PATA DRIVERS" <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230724095712.1541-1-duminjie@vivo.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230724095712.1541-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/23 18:57, Minjie Du wrote:
> It is possible for dma_request_chan() to return EPROBE_DEFER, which means
> acdev->host->dev is not ready yet.
> At this point dev_err() will have no output.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
> V1 - V4:
> Fix code format.

You are not fixing anything. You keep resending the same, which is missing the
dev_err_probe() message alignment like I (and Sergey) keep telling you. Can you
please take our comments seriously and act on them ? If you do not understand,
then say so and I will explain in more details.

> ---
>  drivers/ata/pata_arasan_cf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
> index 6ab294322e79..b32d47112c0a 100644
> --- a/drivers/ata/pata_arasan_cf.c
> +++ b/drivers/ata/pata_arasan_cf.c
> @@ -529,7 +529,8 @@ static void data_xfer(struct work_struct *work)
>  	/* dma_request_channel may sleep, so calling from process context */
>  	acdev->dma_chan = dma_request_chan(acdev->host->dev, "data");
>  	if (IS_ERR(acdev->dma_chan)) {
> -		dev_err(acdev->host->dev, "Unable to get dma_chan\n");
> +		dev_err_probe(acdev->host->dev, PTR_ERR(acdev->dma_chan),
> +					  "Unable to get dma_chan\n");

Just use this please, formatted *exactly* like this.

		dev_err_probe(acdev->host->dev, PTR_ERR(acdev->dma_chan),
			      "Unable to get dma_chan\n");

>  		acdev->dma_chan = NULL;
>  		goto chan_request_fail;
>  	}

-- 
Damien Le Moal
Western Digital Research

