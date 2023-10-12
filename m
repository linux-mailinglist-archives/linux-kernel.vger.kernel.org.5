Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8507C6913
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbjJLJLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjJLJLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:11:18 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46642A9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:11:16 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 22DBB3D5;
        Thu, 12 Oct 2023 11:11:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1697101869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lK+j//CfxO3PYmVwwW1MbgLEZ/P1cVy+TAusj8NdskE=;
        b=Ja5gDszj+51Fi2Cfu4nzJrOq5NxF/0nOXMEmSRYTN6swk49ZBbBuqnaCAfx3d4gtwtx8Re
        X2cXexpgbBsEhuhOeMY392bEVBg5wkoVJwILvlWqFTPgegiLmVvi29+B1QEtC550xVWTTz
        ZghI/IhmXzwnFl2tT0plAFkFPlT8JDhAQ0LmC6S3MUgSVuhR2Rt8QQo+Xp+ukEYk32Tq8h
        fYyAmhLv8GcyUwZG9RPTJNdE08TvjhdJG7bK+QyXu3l7oXISj1PTiB4hJlOjDorS9FnoIN
        BEl/xE5O6aj8WDl+Qw3GGGc35tpb/mkV7JnKtTyFnfW7KwACYc+ljIXEy+NcLQ==
MIME-Version: 1.0
Date:   Thu, 12 Oct 2023 11:11:09 +0200
From:   Michael Walle <michael@walle.cc>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com, quic_varada@quicinc.com
Subject: Re: [PATCH] mtd: spi-nor: Ensure operation completion before shutdown
In-Reply-To: <20231012055148.2445303-1-quic_mdalam@quicinc.com>
References: <20231012055148.2445303-1-quic_mdalam@quicinc.com>
Message-ID: <bb12db1205a5d1bfbee341d23defe0be@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2023-10-12 07:51, schrieb Md Sadre Alam:
> Ensure that there are no pending spi operation inprogress
> when system halts.

What operation might be in progress here? Did you encounter some 
problems?
Please explain it in more detail in the commit message.

Fixes tag?

-michael

> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
>  drivers/mtd/spi-nor/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 1c443fe568cf..adc4d2c68695 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3690,6 +3690,9 @@ static void spi_nor_shutdown(struct spi_mem 
> *spimem)
>  {
>  	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
> 
> +	/* Ensure no pending spi operation in progress */
> +	spi_nor_wait_till_ready(nor);
> +
>  	spi_nor_restore(nor);
>  }
