Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDB5787471
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242267AbjHXPkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242314AbjHXPkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:40:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D981B2;
        Thu, 24 Aug 2023 08:40:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9060B60D38;
        Thu, 24 Aug 2023 15:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778F2C433C8;
        Thu, 24 Aug 2023 15:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692891630;
        bh=24Y+FUB1WBhGN7gY7KmvjDZd/+f+iSS9R43cj1X4AA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0gO9hIo6QjDcUxB7ZSW21np+V/Xt9DnRxhtAveI9gV36FerJLJ/RQ5+2H3QK386yI
         YaaoP8wds9CT4gmZksniOXC2x70Pcb6dOA8YK5eNKpLHiRO5+0SEQ1e7IoLhII3d6O
         GK6kQHa1+avw0fZOtzbK4D0SRsqju5qqZGgJz+cA=
Date:   Thu, 24 Aug 2023 17:40:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     azkali <a.ffcc7@gmail.com>, Adam Jiang <chaoj@nvidia.com>,
        CTCaer <ctcaer@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] misc: bm92txx: Add driver for the ROHM BM92Txx
Message-ID: <2023082402-rearview-babbling-257c@gregkh>
References: <20230824153059.212244-1-linkmauve@linkmauve.fr>
 <20230824153059.212244-3-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824153059.212244-3-linkmauve@linkmauve.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 05:30:54PM +0200, Emmanuel Gil Peyrot wrote:
> From: azkali <a.ffcc7@gmail.com>
> 
> This is used as the USB-C Power Delivery controller of the Nintendo
> Switch.
> 
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> Signed-off-by: azkali <a.ffcc7@gmail.com>
> Signed-off-by: Adam Jiang <chaoj@nvidia.com>
> Signed-off-by: CTCaer <ctcaer@gmail.com>
> ---
>  MAINTAINERS            |    1 +
>  drivers/misc/Kconfig   |   11 +
>  drivers/misc/Makefile  |    1 +
>  drivers/misc/bm92txx.c | 2403 ++++++++++++++++++++++++++++++++++++++++

Why here and not in drivers/usb/typec/ ?

>  4 files changed, 2416 insertions(+)
>  create mode 100644 drivers/misc/bm92txx.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc100a02fa7b..fe80d7693944 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18457,6 +18457,7 @@ ROHM USB-C POWER DELIVERY CONTROLLERS
>  M:	Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
>  S:	Supported
>  F:	Documentation/devicetree/bindings/misc/rohm,bm92txx.yaml
> +F:	drivers/misc/bm92txx.c
>  
>  ROSE NETWORK LAYER
>  M:	Ralf Baechle <ralf@linux-mips.org>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 75e427f124b2..a2483819766a 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -561,6 +561,17 @@ config TPS6594_PFSM
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called tps6594-pfsm.
>  
> +config BM92TXX
> +	tristate "Rohm Semiconductor BM92TXX USB Type-C Support"
> +	depends on I2C=y

Why =y?  That shouldn't matter, can't this just read:
	depends on I2C

> +static int bm92t_read_reg(struct bm92t_info *info,
> +			  unsigned char reg, unsigned char *buf, int num)
> +{
> +	struct i2c_msg xfer_msg[2];
> +	int err;
> +	unsigned char reg_addr;
> +
> +	reg_addr = reg;
> +
> +	xfer_msg[0].addr = info->i2c_client->addr;
> +	xfer_msg[0].len = 1;
> +	xfer_msg[0].flags = 0;
> +	xfer_msg[0].buf = &reg_addr;
> +
> +	xfer_msg[1].addr = info->i2c_client->addr;
> +	xfer_msg[1].len = num;
> +	xfer_msg[1].flags = I2C_M_RD;
> +	xfer_msg[1].buf = buf;
> +
> +	err = i2c_transfer(info->i2c_client->adapter, xfer_msg, 2);
> +	if (err < 0)
> +		dev_err(&info->i2c_client->dev, "%s: transfer error %d\n", __func__, err);

There shouldn't be a need to put __func__ in a dev_*() call.

And why not use the device you have here, not the i2c client device?
Isn't the platform device the "correct" one that had the error?

thanks,

greg k-h
