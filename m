Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AF9769B81
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjGaP4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbjGaP4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:56:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472651BD3;
        Mon, 31 Jul 2023 08:55:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53351611E7;
        Mon, 31 Jul 2023 15:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36676C433C8;
        Mon, 31 Jul 2023 15:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690818949;
        bh=On7tcWop1PVuNke51d2quVjv7A17F0AwH668ZMj59gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YMFAhqNtvytv42Be/aCJ1x1QkSoFRQJOOZJc7RJqZJgwhCz+RGCIUeDztxjzSgXTg
         HlbqTZcbsK91gzFsqEjCI4httu+HobT3DGYaegkPSHpMsJZijgNve9t0CBbxjzIZaF
         4nkC4OfXbEdA0BgJDMFoB1Hvt6BG/j0phmjv3aGI=
Date:   Mon, 31 Jul 2023 17:55:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org, Lech Perczak <lech.perczak@camlingroup.com>
Subject: Re: [PATCH v9 04/10] serial: sc16is7xx: refactor GPIO controller
 registration
Message-ID: <2023073118-mousiness-sandlot-6258@gregkh>
References: <20230725142343.1724130-1-hugo@hugovil.com>
 <20230725142343.1724130-5-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725142343.1724130-5-hugo@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 10:23:36AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> In preparation for upcoming patch "fix regression with GPIO
> configuration". To facilitate review and make code more modular.

I would much rather the issue be fixed _before_ the code is refactored,
unless it is impossible to fix it without the refactor?

> 
> Cc: <stable@vger.kernel.org> # 6.1.x

What commit id does this fix?

> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
> Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 40 ++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 32d43d00a583..5b0aeef9d534 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -332,6 +332,7 @@ struct sc16is7xx_one {
>  
>  struct sc16is7xx_port {
>  	const struct sc16is7xx_devtype	*devtype;
> +	struct device			*dev;

Why is this pointer needed?

Why is it grabbed and yet the reference count is never incremented?  Who
owns the reference count and when will it go away?

And what device is this?  The parent?  Current device?  What type of
device is it?  And why is it needed?

Using "raw" devices is almost never something a driver should do, they
are only passed into functions by the driver core, but then the driver
should instantly turn them into the "real" structure.


thanks,

greg k-h
