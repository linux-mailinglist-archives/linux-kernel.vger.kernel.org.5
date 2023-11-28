Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8487FB4BD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbjK1Irt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbjK1Ire (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:47:34 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1AF1BB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:47:30 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id E2CF36E;
        Tue, 28 Nov 2023 09:47:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1701161249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B/FGvUrY1T+u4h3eD8cuv8IgBGuuyis0jyMyILTG5Cs=;
        b=omIgNta8GaYBjwrBX8v6awEENxnGYsQM/8IyIay2A7m4msZtcUozD/UUm49ThMV/vAZkci
        LC7XPI+nffCV4X4RH5dIgY9pXwuLSsV4w/N6kZ/KXp7voyAmZlzKVlvcA62h7f3THJU1hJ
        898RUgUrd3gLjvBoHdPfFptncr3yIGMXYmhwv57RmcgopcQ6k5cPMvUUhPlMGY+31LYCyN
        3CNHdOzUSlA4fVkKqS1wsLiN1ix91UnCe3DoqVOt4VJyxoY/KCpVPFmhRrQIvKNQlWeyrh
        H/5umPg9aIPG1sZuFX2BHGI0fm+ol8eb5dxzgVzPKkdIQXkd3R6eZ8XhUGJoAw==
MIME-Version: 1.0
Date:   Tue, 28 Nov 2023 09:47:28 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     miquel.raynal@bootlin.com, jaimeliao.tw@gmail.com,
        jaimeliao@mxic.com.tw, pratyush@kernel.org, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: stop printing superfluous debug info
In-Reply-To: <20231127165908.1734951-1-tudor.ambarus@linaro.org>
References: <20231127165908.1734951-1-tudor.ambarus@linaro.org>
Message-ID: <42c96d63d1ea4f7e8f16a3c8eb0a4cf1@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> The mtd data can be obtain with the mtd ioctls and the SPI NOR
> flash name can be determined interrogating the sysfs entries.
> Stop polluting the kernel log.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> 
> ---
>  drivers/mtd/spi-nor/core.c | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 25a64c65717d..6de76fd009d1 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3517,25 +3517,6 @@ int spi_nor_scan(struct spi_nor *nor, const char 
> *name,
>  	/* No mtd_info fields should be used up to this point. */
>  	spi_nor_set_mtd_info(nor);
> 
> -	dev_info(dev, "%s (%lld Kbytes)\n", info->name,
> -			(long long)mtd->size >> 10);

I'd lower this to dev_dbg() and print the jedec id. It might come in
handy for a quick glance during bootup if debug is enabled.

> -
> -	dev_dbg(dev,
> -		"mtd .name = %s, .size = 0x%llx (%lldMiB), "
> -		".erasesize = 0x%.8x (%uKiB) .numeraseregions = %d\n",
> -		mtd->name, (long long)mtd->size, (long long)(mtd->size >> 20),
> -		mtd->erasesize, mtd->erasesize / 1024, mtd->numeraseregions);
> -
> -	if (mtd->numeraseregions)
> -		for (i = 0; i < mtd->numeraseregions; i++)
> -			dev_dbg(dev,
> -				"mtd.eraseregions[%d] = { .offset = 0x%llx, "
> -				".erasesize = 0x%.8x (%uKiB), "
> -				".numblocks = %d }\n",
> -				i, (long long)mtd->eraseregions[i].offset,
> -				mtd->eraseregions[i].erasesize,
> -				mtd->eraseregions[i].erasesize / 1024,
> -				mtd->eraseregions[i].numblocks);
>  	return 0;

Part of this is already available through the spi-nor debugfs, although 
not
the actual mtd properties. These I think, should go into the mtdcore
itself if really needed. Either through dev_dbg() or debugfs.

-michael
