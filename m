Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE977754336
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbjGNTaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjGNTaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:30:22 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2703A86;
        Fri, 14 Jul 2023 12:30:20 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 8A5319E3;
        Fri, 14 Jul 2023 21:30:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1689363017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ENvKCLxq5zLf8E0WPSbrdFAwoJ7ACgVSNM/TRb9/0ho=;
        b=bB46+QMRneEu+kWHHE4SYl42hgTuLLopI5X8xILyfg2/0iY9eJW6gn0yvBjYqqWMPD5xXm
        9dCPYu7w3AFDiKF8wWxuJFcTEPr85jkp8L7HL9yAosWSlwkqUQj5WJxSeo3FXQ/krNIIVF
        83m9/D6XJqTrTbylwuJUvMYsTelXmXomydZ9zylh6OXq1ASYkC1AurgP2np3G+IAzkARDC
        WOhevo9HzkGV27zU0DS3TZ666ZxetLtRCpL1f2lyYHvT4AWN/EbtciaEFHnOPJYO+VLrd5
        hQ9HDwWFQ4ByCiUkMj5pVn9nUJiBl6I0pZcbPjymlA3Bzn+vdVPe1tmNTcbtpw==
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 21:30:17 +0200
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3] mtd: spi-nor: Correct flags for Winbond w25q128
In-Reply-To: <20230714-spi-nor-winbond-w25q128-v3-1-bdb2192f079b@linaro.org>
References: <20230714-spi-nor-winbond-w25q128-v3-1-bdb2192f079b@linaro.org>
Message-ID: <a5dd9f7d14c94c9be99c93b9475683bf@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2023-07-14 20:29, schrieb Linus Walleij:
> The Winbond "w25q128" (actual vendor name W25Q128JV) has
> exactly the same flags as the sibling device "w25q128jv".
> The devices both require unlocking to enable write access.
> 
> The actual product naming between devices vs the Linux
> strings in winbond.c:
> 
> 0xef4018: "w25q128"   W25Q128JV-IM/JM
> 0xef7018: "w25q128jv" W25Q128JV-IN/IQ/JQ

This is still wrong btw. According to:
https://www.winbond.com/resource-files/W25Q128JV%20RevI%2008232021%20Plus.pdf

This should be
0xef4018: "w25q128"   W25Q128JV-IN/IQ/JQ
0xef7018: "w25q128jv" W25Q128JV-IM/JM

Otherwise, looks good. Either Tudor can change that in
place while picking up the patch or you could send a new
version.

Either way:
Reviewed-by: Michael Walle <michael@walle.cc>

Thanks!
-michael

> The latter device, "w25q128jv" supports features named DTQ
> and QPI, otherwise it is the same.
> 
> Not having the right flags has the annoying side effect
> that write access does not work.
> 
> After this patch I can write to the flash on the Inteno
> XG6846 router.
> 
> The flash memory also supports dual and quad SPI modes.
> This does not currently manifest, but by turning on SFDP
> parsing, the right SPI modes are emitted in
> /sys/kernel/debug/spi-nor/spi1.0/capabilities
> for this chip, so we also turn on this.
> 
> Since we suspect that older chips may be using the same
> device ID, we need to keep NO_SFDP_FLAGS(SECT_4K) as these
> older chips may not support SFDP.
> 
> cat jedec_id
> ef4018
> cat manufacturer
> winbond
> cat partname
> w25q128
> hexdump -v -C sfdp
> 00000000  53 46 44 50 05 01 00 ff  00 05 01 10 80 00 00 ff
> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> 00000020  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> 00000030  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> 00000040  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> 00000050  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> 00000060  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> 00000070  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> 00000080  e5 20 f9 ff ff ff ff 07  44 eb 08 6b 08 3b 42 bb
> 00000090  fe ff ff ff ff ff 00 00  ff ff 40 eb 0c 20 0f 52
> 000000a0  10 d8 00 00 36 02 a6 00  82 ea 14 c9 e9 63 76 33
> 000000b0  7a 75 7a 75 f7 a2 d5 5c  19 f7 4d ff e9 30 f8 80
> 
> Cc: stable@vger.kernel.org
> Suggested-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v3:
> - Keep NO_SFDP_FLAGS(SECT_4K) around.
> - Update commit message
> - Link to v2: 
> https://lore.kernel.org/r/20230712-spi-nor-winbond-w25q128-v2-1-50c9f1d58d6c@linaro.org
> 
> Changes in v2:
> - Only add the write access flags.
> - Use SFDP parsing to properly detect the various
>   available SPI modes.
> - Link to v1: 
> https://lore.kernel.org/r/20230712-spi-nor-winbond-w25q128-v1-1-f78f3bb42a1c@linaro.org
> ---
>  drivers/mtd/spi-nor/winbond.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/winbond.c 
> b/drivers/mtd/spi-nor/winbond.c
> index 834d6ba5ce70..8f30a67cd27a 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -121,6 +121,8 @@ static const struct flash_info winbond_nor_parts[] 
> = {
>  	{ "w25q80bl", INFO(0xef4014, 0, 64 * 1024,  16)
>  		NO_SFDP_FLAGS(SECT_4K) },
>  	{ "w25q128", INFO(0xef4018, 0, 64 * 1024, 256)
> +		PARSE_SFDP
> +		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>  		NO_SFDP_FLAGS(SECT_4K) },
>  	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> 
> ---
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> change-id: 20230711-spi-nor-winbond-w25q128-321a602ee267
> 
> Best regards,
