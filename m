Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051C17B4104
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 16:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbjI3Ohl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 10:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjI3Ohk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 10:37:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324FAC5;
        Sat, 30 Sep 2023 07:37:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0C4C433C7;
        Sat, 30 Sep 2023 14:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696084657;
        bh=8Fc/CeyGTNVfQR93VmyE2psqKuXvZfPHfaLUp1L7J3A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o6Cqf/Fc75retJsJnzU1RZ910q51QLx3aAp8Z0SNJqznHx/nSw9qmogYotNTqB0j/
         2lEzUxZf6PEn7YkYNAKlCC/eKlQkHoA7h31Nstdj0CtTmfqCo//GV84q0wah//NXoW
         IqY8dSjEO10mlbkvj2R3TS2MzN0zV3tDiP73VXaeI6/kcHqWgkrd/aLJWCfQbzMZwL
         vMh6GCd7UW7vyGEIWpgkYniVBcBI9myl4x2hwUfmV3b73J9pSo4Fq6tHQTrLiFxeqq
         VLTtOQx7JvUtNnXwObtYaEjcooBpPr1S39NSD0/pHA7V9sYi3I997Z7BBW0kKH+xaX
         9eDYC1gssdpRg==
Date:   Sat, 30 Sep 2023 15:37:36 +0100
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
Subject: Re: [PATCH v3 04/27] staging: iio: resolver: ad2s1210: check return
 of ad2s1210_initial()
Message-ID: <20230930153736.52229088@jic23-huawei>
In-Reply-To: <20230929-ad2s1210-mainline-v3-4-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-4-fa4364281745@baylibre.com>
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

On Fri, 29 Sep 2023 12:23:09 -0500
David Lechner <dlechner@baylibre.com> wrote:

> From: David Lechner <david@lechnology.com>
> 
> From: David Lechner <dlechner@baylibre.com>
> 
> This adds a check to the return value of ad2s1210_initial() since it
> can fail. The call is also moved before devm_iio_device_register() so
> that we don't have to unregister the device if it fails.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied

> ---
> 
> v3 changes:
> * This is a new patch split out from "staging: iio: resolver: ad2s1210:
>  fix probe"
> 
>  drivers/staging/iio/resolver/ad2s1210.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 8fde08887f7f..b5e071d7c5fd 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -672,6 +672,10 @@ static int ad2s1210_probe(struct spi_device *spi)
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = ad2s1210_initial(st);
> +	if (ret < 0)
> +		return ret;
> +
>  	indio_dev->info = &ad2s1210_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = ad2s1210_channels;
> @@ -683,7 +687,6 @@ static int ad2s1210_probe(struct spi_device *spi)
>  		return ret;
>  
>  	st->fclkin = spi->max_speed_hz;
> -	ad2s1210_initial(st);
>  
>  	return 0;
>  }
> 

