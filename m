Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B17768561
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 15:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjG3NC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 09:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjG3NCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 09:02:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BE48E;
        Sun, 30 Jul 2023 06:02:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF21960C34;
        Sun, 30 Jul 2023 13:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA1BC433C8;
        Sun, 30 Jul 2023 13:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690722172;
        bh=aSQY9HgsSaUQiAf8RxghVlYx43Ai3Jca+KXRTpfnolE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pGVvCfLv1qPeprL6gkTA+HdOY1f42ww7pwISpAM4apBYN42tKs9No9A4tQtfTMqyl
         CD9EadEVtrN5fSpdoqtKtQpkzkLRN7UnJGvl0H8E0DB9ZmHgnuMpfZ7U5M7dbyA2Wq
         5XzZq0SmCA+8YhIsPXPhxUTGxcG6cV+9o6XQT77vMjBiHneasPtB+qHEdyvq35pKm6
         tPLISx6/GAahXadAgU20hmI5tBDfWwJS0eULs/2YWw5Ix53QiXJqPG+zLuV0YU+9R7
         tr4BQ5qapzdsjdBFcNn6htWnkzg1OOpdR/BCWTcwG150U5oh5rp4EkHEmloDcXa56r
         UHpVC4Ic/+6Xw==
Date:   Sun, 30 Jul 2023 15:02:49 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 19/22] Input: s6sy761 - use device core to create
 driver-specific device attributes
Message-ID: <20230730130249.lb4cafvirda5uuh7@intel.intel>
References: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
 <20230729005133.1095051-19-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729005133.1095051-19-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Fri, Jul 28, 2023 at 05:51:28PM -0700, Dmitry Torokhov wrote:
> Instead of creating driver-specific device attributes with
> devm_device_add_group() have device core do this by setting up dev_groups
> pointer in the driver structure.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Andi

> ---
>  drivers/input/touchscreen/s6sy761.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscreen/s6sy761.c
> index 998d99d18911..149cc2c4925e 100644
> --- a/drivers/input/touchscreen/s6sy761.c
> +++ b/drivers/input/touchscreen/s6sy761.c
> @@ -286,10 +286,7 @@ static struct attribute *s6sy761_sysfs_attrs[] = {
>  	&dev_attr_devid.attr,
>  	NULL
>  };
> -
> -static struct attribute_group s6sy761_attribute_group = {
> -	.attrs = s6sy761_sysfs_attrs
> -};
> +ATTRIBUTE_GROUPS(s6sy761_sysfs);
>  
>  static int s6sy761_power_on(struct s6sy761_data *sdata)
>  {
> @@ -465,10 +462,6 @@ static int s6sy761_probe(struct i2c_client *client)
>  	if (err)
>  		return err;
>  
> -	err = devm_device_add_group(&client->dev, &s6sy761_attribute_group);
> -	if (err)
> -		return err;
> -
>  	pm_runtime_enable(&client->dev);
>  
>  	return 0;
> @@ -535,6 +528,7 @@ MODULE_DEVICE_TABLE(i2c, s6sy761_id);
>  static struct i2c_driver s6sy761_driver = {
>  	.driver = {
>  		.name = S6SY761_DEV_NAME,
> +		.dev_groups = s6sy761_sysfs_groups,
>  		.of_match_table = of_match_ptr(s6sy761_of_match),
>  		.pm = pm_ptr(&s6sy761_pm_ops),
>  	},
> -- 
> 2.41.0.487.g6d72f3e995-goog
> 
