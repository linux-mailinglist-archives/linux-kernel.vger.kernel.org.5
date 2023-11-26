Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9127F932A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 15:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjKZOsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 09:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZOsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 09:48:12 -0500
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBEA92
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 06:48:18 -0800 (PST)
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
        by cmsmtp with ESMTPS
        id 7G5pr0WavL9Ag7GQkrUdsI; Sun, 26 Nov 2023 14:48:18 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 7GQirWBHKAKSc7GQjrFf2C; Sun, 26 Nov 2023 14:48:17 +0000
X-Authority-Analysis: v=2.4 cv=N6w6qkxB c=1 sm=1 tr=0 ts=65635ab1
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=yGeM7+xMb5a5VK1DGQx1ew==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10
 a=f0Whz4inhACu9W4x6ooA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Hr/7m9hoMvRnDst3lNW04H2ADFNUoGwpJyvyjtjjCiw=; b=k/taYEh+v8r6b8Ru5iAQrLIIaz
        KR9OtTQ6TTh4jK0kiz24EHOKxXiWKkARx/ESXAF3ehFRh3egvucQn3MoNe3TGrzJgTsOCe8N9HLf+
        PS9jtbyJMzlXtryibQbpPwZVbMD1pLbt1CZt/H6TFx3NB2hhxI7oUVq/WLenXT8tcPz/lhDA+6sKI
        dX3S05+LaZ1ZI9qs4vELXGyoH7CiivCwLL2sCKrNwh3yFrybW80xz53X94HBCidiAQG8vkrZ+Qg8Q
        1MA8pZNoEkncc7X2o5ePbIBGFckcsGaoe7McJ6MqseZMQrlBZisv0+MFS5Unqmxh0TPsBNDcfuK02
        2Qy1d+Ng==;
Received: from 187.184.157.122.cable.dyn.cableonline.com.mx ([187.184.157.122]:42256 helo=[192.168.0.9])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1r7GQi-002JlB-0q;
        Sun, 26 Nov 2023 08:48:16 -0600
Message-ID: <b62a458c-dd5e-4e8c-bb2f-f997ae329614@embeddedor.com>
Date:   Sun, 26 Nov 2023 08:48:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mux: Turn 'mux' into a flexible array in 'struct
 mux_chip'
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Peter Rosin <peda@axentia.se>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <d17bd9b622dbe3f7cb2f18736ef3138a6927f86c.1700986053.git.christophe.jaillet@wanadoo.fr>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <d17bd9b622dbe3f7cb2f18736ef3138a6927f86c.1700986053.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.157.122
X-Source-L: No
X-Exim-ID: 1r7GQi-002JlB-0q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.122.cable.dyn.cableonline.com.mx ([192.168.0.9]) [187.184.157.122]:42256
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGqbRGYa9LcMNxKfle6VGiv9VGRP7aHkDQToIjD9MZhe1AopHO0njz4ENCGueGkNiyVaAwPA75HjkFX8F5wSHpvWf+AfB02C+Dfu/x2517qxPIYJ7qC6
 +JJw6TpQobNjgm+QVX+1hwHxcoLbzEwle4ebt92QwQmYFDJ4JufjULrU67QIG1INoN2k8qbck75hMpxy7womzuH9+xJPvFhw7PgCMYJwfG0VdGAxkyFSduTZ
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/26/23 02:08, Christophe JAILLET wrote:
> The 'mux' array stored in 'struct mux_chip' can be changed into a flexible
> array.
> 
> This saves:
>     - a pointer in the structure
>     - an indirection when accessing the array
>     - some pointer arithmetic when computing and storing the address in
>       'mux'
> 
> It is also now possible to use __counted_by() and struct_size() for
> additional safety.
> 
> The address for the 'priv' memory is computed with mux_chip_priv(). It
> should work as good with a flexible array.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> The struct_size() goodies only work if sizeof_priv is 0. Adding an
> additional size_add() would make it safe in all cases but would make code
> less readable (IMHO).

Just save struct_size() in another variable, and use size_add() like this:

size_t size = struct_size(..);

.. kzalloc(size_add(size, sizeof_priv), ...);

--
Gustavo

> ---
>   drivers/mux/core.c         | 4 +---
>   include/linux/mux/driver.h | 5 +++--
>   2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> index 775816112932..80b2607b083b 100644
> --- a/drivers/mux/core.c
> +++ b/drivers/mux/core.c
> @@ -98,13 +98,11 @@ struct mux_chip *mux_chip_alloc(struct device *dev,
>   	if (WARN_ON(!dev || !controllers))
>   		return ERR_PTR(-EINVAL);
>   
> -	mux_chip = kzalloc(sizeof(*mux_chip) +
> -			   controllers * sizeof(*mux_chip->mux) +
> +	mux_chip = kzalloc(struct_size(mux_chip, mux, controllers) +
>   			   sizeof_priv, GFP_KERNEL);
>   	if (!mux_chip)
>   		return ERR_PTR(-ENOMEM);
>   
> -	mux_chip->mux = (struct mux_control *)(mux_chip + 1);
>   	mux_chip->dev.class = &mux_class;
>   	mux_chip->dev.type = &mux_type;
>   	mux_chip->dev.parent = dev;
> diff --git a/include/linux/mux/driver.h b/include/linux/mux/driver.h
> index 18824064f8c0..c29e9b7fb17b 100644
> --- a/include/linux/mux/driver.h
> +++ b/include/linux/mux/driver.h
> @@ -56,18 +56,19 @@ struct mux_control {
>   /**
>    * struct mux_chip -	Represents a chip holding mux controllers.
>    * @controllers:	Number of mux controllers handled by the chip.
> - * @mux:		Array of mux controllers that are handled.
>    * @dev:		Device structure.
>    * @id:			Used to identify the device internally.
>    * @ops:		Mux controller operations.
> + * @mux:		Array of mux controllers that are handled.
>    */
>   struct mux_chip {
>   	unsigned int controllers;
> -	struct mux_control *mux;
>   	struct device dev;
>   	int id;
>   
>   	const struct mux_control_ops *ops;
> +
> +	struct mux_control mux[] __counted_by(controllers);
>   };
>   
>   #define to_mux_chip(x) container_of((x), struct mux_chip, dev)
