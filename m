Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D99C80E629
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbjLLIaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbjLLIaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:30:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF45173B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:30:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5A6C433C7;
        Tue, 12 Dec 2023 08:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702369811;
        bh=OBpRdN0eEvuNt0h+qruB6z/fQi2iOsF3hWkodHHSVPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OZNhOMNNza3SZ7r1OO/hGEdpRUswF4DtFxtQ5FvZBkM3P1yVJv1RklxLZssjIui2Y
         F0St+QlfnN+emxxB0p1PL69TZVpEJY7z0II+lmFg439aulZxbI49uSjdSxkx4Jg4tP
         Wzn+4t3g7qJeFEJpWfVZNT0U1NoaXMThJv0wIvzE=
Date:   Tue, 12 Dec 2023 09:30:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     nikita.shubin@maquefel.me
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Johan Jonker <jbx6244@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v6 20/40] mtd: rawnand: add support for ts72xx
Message-ID: <2023121220-shine-caviar-68dc@gregkh>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
 <20231212-ep93xx-v6-20-c307b8ac9aa8@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-ep93xx-v6-20-c307b8ac9aa8@maquefel.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 11:20:37AM +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Technologic Systems has it's own nand controller implementation in CPLD.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  drivers/mtd/nand/raw/Kconfig                       |   7 +
>  drivers/mtd/nand/raw/Makefile                      |   1 +
>  drivers/mtd/nand/raw/technologic-nand-controller.c | 220 +++++++++++++++++++++
>  3 files changed, 228 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index cbf8ae85e1ae..3937c10dea1c 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -449,6 +449,13 @@ config MTD_NAND_RENESAS
>  	  Enables support for the NAND controller found on Renesas R-Car
>  	  Gen3 and RZ/N1 SoC families.
>  
> +config MTD_NAND_TS72XX
> +	tristate "ts72xx NAND controller"
> +	depends on ARCH_EP93XX && HAS_IOMEM
> +	help
> +	  Enables support for NAND controller on ts72xx SBCs.
> +	  This is a legacy driver based on gen_nand.

Why is a new "legacy driver" being written these days?  Why not do it
properly?

thanks,

greg k-h
