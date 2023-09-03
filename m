Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32750790BD2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 14:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbjICMGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 08:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjICMGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 08:06:18 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C216A124;
        Sun,  3 Sep 2023 05:06:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2BB79CE094F;
        Sun,  3 Sep 2023 12:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0A9C433C7;
        Sun,  3 Sep 2023 12:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693742772;
        bh=uMU9EfafyRUVVf/watUPf5fAzj8d5nWkpTB+sYZ1Wio=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m28LDd+jRuHOM0q67ccD62WT+rhQWi1Q4o60xgRu2q0NoOKsGPiSGvb04yCaFPMim
         3l8Xc68ar+63CFNaMBN/YdXe1V9WsQpb6md0KUI3olME9UmJcYYX46zvluJPcQCT7n
         Atgv6Lx1o0RlpuqC/4NgYFzK9IgqjWvRltn830V166dCqlU6d/Eo5/r4fJGUKmpnF4
         qnWIxrAf7Ny2h6Ivf3qPcPuCooM1AYQhoDg6qGXkhaCqMA5+ARKbpjg22eBFSkeRuB
         tbaeedffWQKtP4isP+hqzDYiV1rgb8tMUCdm5PfS/yrHrtdF4uCj9ypH4PWdA9HqFD
         40DQxE2GPenCA==
Date:   Sun, 3 Sep 2023 13:06:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] iio: adc: ltc2497: Simplify probe()
Message-ID: <20230903130639.1be1cf8c@jic23-huawei>
In-Reply-To: <20230902170529.62297-1-biju.das.jz@bp.renesas.com>
References: <20230902170529.62297-1-biju.das.jz@bp.renesas.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  2 Sep 2023 18:05:29 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Simpilfy probe() by replacing device_get_match_data() and id lookup for
> retrieving match data by using i2c_get_match_data().
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Applied to the togreg branch of iio.git and pushed out testing.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ltc2497.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> index 5bdd40729611..6401a7727c31 100644
> --- a/drivers/iio/adc/ltc2497.c
> +++ b/drivers/iio/adc/ltc2497.c
> @@ -95,7 +95,6 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
>  
>  static int ltc2497_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	const struct ltc2497_chip_info *chip_info;
>  	struct iio_dev *indio_dev;
>  	struct ltc2497_driverdata *st;
> @@ -115,9 +114,7 @@ static int ltc2497_probe(struct i2c_client *client)
>  	st->client = client;
>  	st->common_ddata.result_and_measure = ltc2497_result_and_measure;
>  
> -	chip_info = device_get_match_data(dev);
> -	if (!chip_info)
> -		chip_info = (const struct ltc2497_chip_info *)id->driver_data;
> +	chip_info = i2c_get_match_data(client);
>  	st->common_ddata.chip_info = chip_info;
>  
>  	resolution = chip_info->resolution;

