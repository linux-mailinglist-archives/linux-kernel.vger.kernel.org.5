Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5A9759277
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjGSKOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGSKOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:14:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10D41FC0;
        Wed, 19 Jul 2023 03:14:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 285D761360;
        Wed, 19 Jul 2023 10:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39C4C433C7;
        Wed, 19 Jul 2023 10:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689761675;
        bh=p8PJMo/HkUOLoUQK33wST8XgeJ0+lpjnWYTA907y6OQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=siEaH933L7LS9GDP+q5CsFA9WlPrVqWTIkwQz7tssFEWlZbR5wOkL+eE8Qs9bljMU
         jn/w9mMY83V+ynUBaK5fdYLaJDGXgQSeiuPTHOZwNCmFCNDOo86ZX00HRsitD4FhsM
         6x6d8/QjfsBrGAUVrUxzGdpJ8L9TM7QRbzPvV31fenV7BSleoua2w4JIS1PPZbE90/
         OtJPwLUOFAK6/wk+aOmfSAXNYNDROhuUaklWwqqWRRv7/BzaDF5JL8vGUZ86k6z/CR
         R2QK99nXLkIXaUAio6qea9Pndn7gNC5eoC+gTiDtJ3+Yg5MPLL8RVzvXHRVTyO+8R7
         KhS7pGmnUgGGQ==
Message-ID: <9c1b702d-fdee-b7c0-9e79-4822f0d2340b@kernel.org>
Date:   Wed, 19 Jul 2023 19:14:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] ata: pata_arasan_cf: Use dev_err_probe() instead
 dev_err() in data_xfer()
To:     =?UTF-8?B?5p2c5pWP5p2w?= <duminjie@vivo.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "open list:LIBATA PATA ARASAN COMPACT FLASH CONTROLLER" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     "opensource.kernel" <opensource.kernel@vivo.com>
References: <20230719100322.6164-1-duminjie@vivo.com>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230719100322.6164-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 19:03, 杜敏杰 wrote:
> It is possible for dma_request_chan() to return EPROBE_DEFER, which means
> acdev->host->dev is not ready yet.
> At this point dev_err() will have no output.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
> V1 - V3:
> Fix code format.
> ---
>  drivers/ata/pata_arasan_cf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
> index 6ab294322..c85932c20 100644
> --- a/drivers/ata/pata_arasan_cf.c
> +++ b/drivers/ata/pata_arasan_cf.c
> @@ -529,7 +529,8 @@ static void data_xfer(struct work_struct *work)
>  	/* dma_request_channel may sleep, so calling from process context */
>  	acdev->dma_chan = dma_request_chan(acdev->host->dev, "data");
>  	if (IS_ERR(acdev->dma_chan)) {
> -		dev_err(acdev->host->dev, "Unable to get dma_chan\n");
> +		dev_err_probe(acdev->host->dev, PTR_ERR(acdev->dma_chan),
> +						"Unable to get dma_chan\n")

Seriously ? You keep resending the same. Still not aligned. And even
worse: this will not even compile as this is missing ";".

Please improve your process and (1) act on comments and (2) properly
test your changes.


>  		acdev->dma_chan = NULL;
>  		goto chan_request_fail;
>  	}

-- 
Damien Le Moal
Western Digital Research

