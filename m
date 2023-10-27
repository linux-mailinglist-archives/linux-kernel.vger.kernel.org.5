Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02597D8F20
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjJ0HCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0HCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:02:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16B4116
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:02:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FB1C433C8;
        Fri, 27 Oct 2023 07:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698390128;
        bh=6uDtxu9NToL+dgANdhbnVtq5L5gPE7a1Qlw45vyXH3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vhPAbV/nersKCP+O7HPSDBRqYGO+v5Nwj5SPhTsBLBif2E23Z8z90idXj4gdpgWac
         C3qjdcxJXV/n53lXw0R74aXpM0wqEtChtaVYFIw9TTny0U73KM+YGflAr3VBmpYJt7
         gZEhvBtOdRn9iDPUnDUT5nbpQ46GNs1Xr5vSFE5s=
Date:   Fri, 27 Oct 2023 09:02:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
Cc:     linux-kernel@vger.kernel.org, lee@kernel.org, arnd@arndb.de
Subject: Re: [PATCH v1 1/3] drivers: mfd: Add support for TPS65224
Message-ID: <2023102739-absolve-coastal-6b4d@gregkh>
References: <20231026133226.290040-1-sirisha.gairuboina@Ltts.com>
 <20231026133226.290040-2-sirisha.gairuboina@Ltts.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026133226.290040-2-sirisha.gairuboina@Ltts.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 07:02:24PM +0530, Gairuboina Sirisha wrote:
> From: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
> 
> Added support for tps65224 driver pmic core, header, Makefile and Kconfig

What is a "tps65224"?  Please provide some more information so we know
how to review this.

> 
> Signed-off-by: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
> ---
>  drivers/mfd/Kconfig          |   5 +
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/tps65224-core.c  | 291 ++++++++++++++
>  include/linux/mfd/tps65224.h | 735 +++++++++++++++++++++++++++++++++++
>  4 files changed, 1032 insertions(+)
>  create mode 100644 drivers/mfd/tps65224-core.c
>  create mode 100644 include/linux/mfd/tps65224.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 90ce58fd629e..2e4906484eed 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1767,6 +1767,11 @@ config MFD_TPS6594_SPI
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called tps6594-spi.
> +config MFD_TPS65224

You need a blank line before this, right?

> +        tristate
> +        select MFD_CORE
> +        select REGMAP
> +        select REGMAP_IRQ

No help text at all to describe what this is?

> --- /dev/null
> +++ b/drivers/mfd/tps65224-core.c
> @@ -0,0 +1,291 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Core functions for TI TPS65224 PMIC
> + *
> + * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com/

No changes have happened since 2015 to this code?

> +EXPORT_SYMBOL_GPL(tps65224_device_init);
> +
> +MODULE_AUTHOR("Gairuboina Sirisha <sirisha.gairuboina@ltts.com>");

That dosn't match the copyright line :(

> --- /dev/null
> +++ b/include/linux/mfd/tps65224.h

Why do you need a .h file at all?  This is just used in one .c file,
right?

thanks,

greg k-h
