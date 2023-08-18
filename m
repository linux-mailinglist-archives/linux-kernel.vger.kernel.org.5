Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B50F780636
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 09:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358139AbjHRHQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 03:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358135AbjHRHP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 03:15:57 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EA030DF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 00:15:55 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 83A02957;
        Fri, 18 Aug 2023 09:15:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1692342953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Be1l9jlqDSr/+Vna3fROrPkK+Sce6tQqng+uemlZghY=;
        b=rH0DK2crq7R5+CGkVPumDVriL8K/DDyC54D3vIkceS50ytbr0635qyMrW+/YG1EHKmqSJD
        3cQugFqvvN52MjSJ6mPmE01yIsscLXSvbaQcBdr2QEVNAfwwnyF6eTl9bTPpHHpjQN6xSl
        G5FPy3PXbt0WUJrnOwLZT5tpgvaIfZIAEpx71tBWri2tqCRm4SOk3K0oODFyLN5sS7BAU1
        0SO8CVuJcDXsK1pyzZfbIR/81rWKyYn1kVMhgUv0pYfbCWrwUyBxPPINtbOzxlwUxsP6+i
        TiaaWS6jyLyMb/h2AaFLBi1PCm1WB3klbbrfVdblIJHMsGxoigLBfoaDc1lpOw==
MIME-Version: 1.0
Date:   Fri, 18 Aug 2023 09:15:53 +0200
From:   Michael Walle <michael@walle.cc>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mtd: spi-nor: Check bus width while setting QE bit
In-Reply-To: <20230818064524.1229100-2-hsinyi@chromium.org>
References: <20230818064524.1229100-2-hsinyi@chromium.org>
Message-ID: <e8a6f1962bac27032838382663eea7e1@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> spi_nor_write_16bit_sr_and_check() should also check if bus width is
> 4 before setting QE bit.
> 
> Fixes: 39d1e3340c73 ("mtd: spi-nor: Fix clearing of QE bit on 
> lock()/unlock()")
> Suggested-by: Michael Walle <michael@walle.cc>
> Suggested-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

I'm not sure if the comment beneath needs an update, too.

In any case:
Reviewed-by: Michael Walle <michael@walle.cc>

> ---
> v2: 
> https://lore.kernel.org/lkml/20230816104245.2676965-1-hsinyi@chromium.org/
> ---
>  drivers/mtd/spi-nor/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 614960c7d22cc..1328128dfe65c 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -870,7 +870,9 @@ static int spi_nor_write_16bit_sr_and_check(struct 
> spi_nor *nor, u8 sr1)
>  		ret = spi_nor_read_cr(nor, &sr_cr[1]);
>  		if (ret)
>  			return ret;
> -	} else if (nor->params->quad_enable) {
> +	} else if (spi_nor_get_protocol_width(nor->read_proto) == 4 &&
> +		   spi_nor_get_protocol_width(nor->write_proto) == 4 &&
> +		   nor->params->quad_enable) {
>  		/*
>  		 * If the Status Register 2 Read command (35h) is not
>  		 * supported, we should at least be sure we don't
