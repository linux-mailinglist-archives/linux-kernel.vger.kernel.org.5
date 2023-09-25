Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8474A7AD749
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjIYLxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 07:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjIYLxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:53:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B797D103
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 04:53:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29217C433C8;
        Mon, 25 Sep 2023 11:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695642790;
        bh=YRhfpioOfX3S6JRC0rfosLAUExubXaO5w4Y65Hn0l3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a6+WVnlGezj+qtyUXIXhLe67qX3OJQ0fWbhw0S038ekCwzLpi1+NXHMKhdQ29V3dN
         4167nqxFrnEgn32OxJsYLFgw3ZLa3EskOVouzXgoCTZ0bomEP9Ex3uKrO4HfONA0UC
         2YikxQkceBk2dE0PiFOjpvUJKNUwPM34/92yujU5KTQOaJ9fGp6+1Sqn6cSKPP6rGj
         gxvYjvqLBagF8b4uUSyjQ3zhTe98iCSg90cezYi/0onijme4eTgeDETP9OXjzfyjxm
         cyHBdGCgOVJZARPG08VigXX7vVPioD7eZxY8BrLaZzYC1fy5J1a/RPGfWvf/oWWQ3K
         T+XBUulr4kvmQ==
Date:   Mon, 25 Sep 2023 19:53:00 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     pawell@cadence.com, pavel@denx.de, rogerq@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: cdns3: Modify the return value of
 cdns_set_active () to void when CONFIG_PM_SLEEP is disabled
Message-ID: <20230925115300.GC2070044@nchen-desktop>
References: <20230920144045.2165758-1-xiaolei.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920144045.2165758-1-xiaolei.wang@windriver.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-09-20 22:40:45, Xiaolei Wang wrote:
> The return type of cdns_set_active () is inconsistent
> depending on whether CONFIG_PM_SLEEP is enabled, so the
> return value is modified to void type.
> 
> Reported-by: Pavel Machek <pavel@denx.de>
> Closes: https://lore.kernel.org/all/ZP7lIKUzD68XA91j@duo.ucw.cz/
> Fixes: 2319b9c87fe2 ("usb: cdns3: Put the cdns set active part outside the spin lock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> Reviewed-by: Pavel Machek <pavel@denx.de>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>

Acked-by: Peter Chen <peter.chen@kernel.org>
> ---
> 
> Changes in v3:
> - Add Cc: stable@vger.kernel.org
> 
> ---
>  drivers/usb/cdns3/core.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> index 4a4dbc2c1561..81a9c9d6be08 100644
> --- a/drivers/usb/cdns3/core.h
> +++ b/drivers/usb/cdns3/core.h
> @@ -131,8 +131,7 @@ void cdns_set_active(struct cdns *cdns, u8 set_active);
>  #else /* CONFIG_PM_SLEEP */
>  static inline int cdns_resume(struct cdns *cdns)
>  { return 0; }
> -static inline int cdns_set_active(struct cdns *cdns, u8 set_active)
> -{ return 0; }
> +static inline void cdns_set_active(struct cdns *cdns, u8 set_active) { }
>  static inline int cdns_suspend(struct cdns *cdns)
>  { return 0; }
>  #endif /* CONFIG_PM_SLEEP */
> -- 
> 2.25.1
> 

-- 

Thanks,
Peter Chen
