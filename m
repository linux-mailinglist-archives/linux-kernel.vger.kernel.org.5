Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A54979BA38
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358088AbjIKWHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbjIKIvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:51:48 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384DB1A1;
        Mon, 11 Sep 2023 01:51:44 -0700 (PDT)
Received: from ideasonboard.com (mob-5-90-67-213.net.vodafone.it [5.90.67.213])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A3F8A475;
        Mon, 11 Sep 2023 10:50:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694422212;
        bh=8uXAO3FzFIcCephXei1u765Sn1EKQC0vRvu9+fY0Qls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wXcRkp56biKpP1V+2Y+dQ6SvLlYZA0Kl2sUZsHqgqTHusPBDYm3Iq6XjPwd45Qk4A
         2kMpyKWYHFa7PkfBlX4YvpPFZt8TBTGhfewOLPyDH+UMGrcreZ961atYG3tPV1HWD1
         BkwPljerJzVwSyabthsP4wnJcYqTFg7MeHqe4CYc=
Date:   Mon, 11 Sep 2023 10:51:39 +0200
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] media: i2c: adv7180: Drop CONFIG_OF ifdeffery
Message-ID: <kqswttssjf7yswvs6kkg2yob33xfhldunhyff5tknccdgjwqyg@ehhwmcygizmw>
References: <20230910152200.56086-1-biju.das.jz@bp.renesas.com>
 <20230910152200.56086-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230910152200.56086-3-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju

On Sun, Sep 10, 2023 at 04:22:00PM +0100, Biju Das wrote:
> Drop of_match_ptr() from adv7180_driver and get rid of ugly CONFIG_OF
> if check. This slightly increases the size of adv7180_driver on non-OF
> system and shouldn't be an issue.
>
> Add mod_devicetable.h include.
>
> It also allows, in case if needed, to enumerate this device via ACPI with
> PRP0001 magic.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Jacopo Mondi <jacopo.mondi+renesas@ideasonboard.com>

Thanks
  j

> ---
>  drivers/media/i2c/adv7180.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
> index fc4f29e74e05..54134473186b 100644
> --- a/drivers/media/i2c/adv7180.c
> +++ b/drivers/media/i2c/adv7180.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2013 Cogent Embedded, Inc.
>   * Copyright (C) 2013 Renesas Solutions Corp.
>   */
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/errno.h>
> @@ -1584,7 +1585,6 @@ static const struct i2c_device_id adv7180_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, adv7180_id);
>
> -#ifdef CONFIG_OF
>  static const struct of_device_id adv7180_of_id[] = {
>  	{ .compatible = "adi,adv7180", &adv7180_info },
>  	{ .compatible = "adi,adv7180cp", &adv7180_info },
> @@ -1600,13 +1600,12 @@ static const struct of_device_id adv7180_of_id[] = {
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, adv7180_of_id);
> -#endif
>
>  static struct i2c_driver adv7180_driver = {
>  	.driver = {
>  		   .name = KBUILD_MODNAME,
>  		   .pm = ADV7180_PM_OPS,
> -		   .of_match_table = of_match_ptr(adv7180_of_id),
> +		   .of_match_table = adv7180_of_id,
>  		   },
>  	.probe = adv7180_probe,
>  	.remove = adv7180_remove,
> --
> 2.25.1
>
