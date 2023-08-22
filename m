Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15F2783CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbjHVJ1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbjHVJ1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:27:48 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0C43CC8;
        Tue, 22 Aug 2023 02:27:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A9F4980A6;
        Tue, 22 Aug 2023 09:27:45 +0000 (UTC)
Date:   Tue, 22 Aug 2023 12:27:44 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        vigneshr@ti.com
Subject: Re: [PATCH] bus: ti-sysc: Use fsleep() instead of usleep_range() in
 sysc_reset()
Message-ID: <20230822092744.GT11676@atomide.com>
References: <20230821-fix-ti-sysc-reset-v1-1-5a0a5d8fae55@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821-fix-ti-sysc-reset-v1-1-5a0a5d8fae55@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Julien Panis <jpanis@baylibre.com> [230821 14:24]:
> The am335x-evm started producing boot errors because of subtle timing
> changes:
> 
> Unhandled fault: external abort on non-linefetch (0x1008) at 0xf03c1010
> ...
> sysc_reset from sysc_probe+0xf60/0x1514
> sysc_probe from platform_probe+0x5c/0xbc
> ...
> 
> The fix consists in using the appropriate sleep function in sysc reset.
> For flexible sleeping, fsleep is recommended. Here, sysc delay parameter
> can take any value in [0 - 255] us range. As a result, fsleep() should
> be used, calling udelay() for a sysc delay lower than 10 us.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> Fixes: e709ed70d122 ("bus: ti-sysc: Fix missing reset delay handling")
> ---
> Fix boot errors for am335x-evm in sysc_reset(), by using fsleep() instead
> of usleep_range() function. Thus, udelay() will be called if the configured
> sysc delay is lower than 10 us (which is usually the case, since the value
> set in the device tree is currently 2 us).

OK, interesting. Yeah I've only ever seen values of 2 us needed here.

Regards,

Tony

> ---
>  drivers/bus/ti-sysc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> index 4cb23b9e06ea..59b8bdd9203e 100644
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -2147,8 +2147,7 @@ static int sysc_reset(struct sysc *ddata)
>  	}
>  
>  	if (ddata->cfg.srst_udelay)
> -		usleep_range(ddata->cfg.srst_udelay,
> -			     ddata->cfg.srst_udelay * 2);
> +		fsleep(ddata->cfg.srst_udelay);
>  
>  	if (ddata->post_reset_quirk)
>  		ddata->post_reset_quirk(ddata);
> 
> ---
> base-commit: f7757129e3dea336c407551c98f50057c22bb266
> change-id: 20230821-fix-ti-sysc-reset-5c164051345b
> 
> Best regards,
> -- 
> Julien Panis <jpanis@baylibre.com>
> 
