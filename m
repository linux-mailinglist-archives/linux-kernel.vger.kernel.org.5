Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C498D7CF189
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjJSHox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344874AbjJSHow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:44:52 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D72AB6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:44:49 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id CAEFAA3A;
        Thu, 19 Oct 2023 09:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1697701484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UHhHJ2y+Q+UNfBPleafnf7D6uFO4IuCG7DUy+7588gM=;
        b=wbPuvufBMzu65294UcblHg5bAM0606+pdGi0GET0b+BpVlJEl4pNBRDa0QDCeanql6EVpd
        0wRWaVh2cgZXwVCQ92fBWMNy/T2Cl3TPtW5V8z0SgLyl35ZGLQ8UGxyxOPnvjigrDE4xRc
        Bj9BwtuvhAg3N0hOTgN2AditZXB+y3NDgDTS7A1mqA5I7/45RckfrskC5o0FcSRBoiZNHG
        p2rBMgMxKrt5cUTFuL3YOkUR+uVEvfCKjMf4GojW0psIsBPm1J2cR4jN5KMLMhQYBpWQnd
        DNGXi5VKpWrit+UTMh2sYMJ9ftjzkz0W2lSFpDFJBfFCIoKTFiDhJlDMU7U8tA==
MIME-Version: 1.0
Date:   Thu, 19 Oct 2023 09:44:44 +0200
From:   Michael Walle <michael@walle.cc>
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: Lower the priority of the software reset
 failure message
In-Reply-To: <20231019064547.348446-1-acelan.kao@canonical.com>
References: <20231019064547.348446-1-acelan.kao@canonical.com>
Message-ID: <cf4143937dea52a4a4f40ed602ec74b1@walle.cc>
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

Hi,

> Not all SPI drivers support soft reset enable and soft reset commands.
> This failure is expected and not critical.

This is not really expected. What driver is this? Let me guess, the 
intel
SPI driver.

Please mention this in the commit message.

> Thus, we avoid reporting it
> to regular users to prevent potential confusion regarding power-off 
> issues.
> 
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> ---
>  drivers/mtd/spi-nor/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 1b0c6770c14e..7bca8ffcd756 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3252,7 +3252,7 @@ static void spi_nor_soft_reset(struct spi_nor 
> *nor)
> 
>  	ret = spi_mem_exec_op(nor->spimem, &op);
>  	if (ret) {
> -		dev_warn(nor->dev, "Software reset failed: %d\n", ret);
> +		dev_info(nor->dev, "Software reset failed: %d\n", ret);

What is the value of ret here? Ideally it should be -EOPNOTSUPP and then
don't print this message at all. Otherwise leave it at dev_warn(). Also,
please add a comment here.

-michael
