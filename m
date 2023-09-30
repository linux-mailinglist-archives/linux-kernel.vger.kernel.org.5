Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117C67B40E6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 16:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbjI3O2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 10:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjI3O2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 10:28:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE409C2;
        Sat, 30 Sep 2023 07:28:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BF1C433C8;
        Sat, 30 Sep 2023 14:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696084112;
        bh=EFUuCbhUP3y4UwQR6s/o4IYaEP1EMEPhSS82/Wkm9DM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SVUzApjXL+nBzojIYxm/i1UPgw7x+roRjgFjtNC4QC0UGB08akDwz+SIFvvn2rx36
         Eyvyx6555HC+ZCcg6XiJZ8xNr3BJIBOtmXMBifeG1Umw9qYjTtWfMfbPEFB17D92Gn
         qwr3zCKFznnqROfTnSMwis7pcQh6fFd25vS7YJZ+MzEfNvA/xdzyu4UxbCNn0rK5zM
         JwDnLFyW4flvri+ZHgdGW21HAzLcEegcxCKICMdF+hFXwYgpAvWUb7RMIBjeTfLFvx
         1MvjNmdFJKeuogZodPlrm8n5YHfGKc33bKWsGQ+jaWyY4ezwKrlF8fUZpzM4VQ88OU
         2ZRC1fOHlii4A==
Date:   Sat, 30 Sep 2023 15:28:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev,
        David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/27] staging: iio: resolver: ad2s1210: fix use
 before initialization
Message-ID: <20230930152831.432647d7@jic23-huawei>
In-Reply-To: <20230929-ad2s1210-mainline-v3-2-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-2-fa4364281745@baylibre.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2023 12:23:07 -0500
David Lechner <dlechner@baylibre.com> wrote:

> From: David Lechner <david@lechnology.com>
> 
> From: David Lechner <dlechner@baylibre.com>
> 
> This fixes a use before initialization in ad2s1210_probe(). The
> ad2s1210_setup_gpios() function uses st->sdev but it was being called
> before this field was initialized.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied to the togreg banch of iio.git and pushed out as testing for 0-day to
poke at it.

I didn't pull this out as a fix to upstream quicker because it would
make a mess of the rest of applying the rest of the series.

Maybe we want to consider backporting some of these at somepoint.

Jonathan

> ---
> 
> v3 changes:
> * This is a new patch split out from "staging: iio: resolver: ad2s1210:
>  fix probe"
> 
>  drivers/staging/iio/resolver/ad2s1210.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index f695ca0547e4..3f08b59f4e19 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -658,9 +658,6 @@ static int ad2s1210_probe(struct spi_device *spi)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  	st = iio_priv(indio_dev);
> -	ret = ad2s1210_setup_gpios(st);
> -	if (ret < 0)
> -		return ret;
>  
>  	spi_set_drvdata(spi, indio_dev);
>  
> @@ -671,6 +668,10 @@ static int ad2s1210_probe(struct spi_device *spi)
>  	st->resolution = 12;
>  	st->fexcit = AD2S1210_DEF_EXCIT;
>  
> +	ret = ad2s1210_setup_gpios(st);
> +	if (ret < 0)
> +		return ret;
> +
>  	indio_dev->info = &ad2s1210_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = ad2s1210_channels;
> 

