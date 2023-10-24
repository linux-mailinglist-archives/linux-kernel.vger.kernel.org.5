Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E4B7D4B63
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbjJXI75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbjJXI7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:59:55 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B4712E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:59:52 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 2992E133;
        Tue, 24 Oct 2023 10:59:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1698137990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZqGqaIFtGkF5J02xsc7tMyJ4K90Kq7KYiL/pwEQrR8A=;
        b=P19fH+nc6zNGHO+8hat2XBGJCy1s0Bc3pRhGCdjL/AjBOS2bGL69m6+p1IO749fclu25CL
        cDtYBYZLAZvHnJX8S/6iV8aTjboMOiC1lRzzVSdGfrVxDw4+rkgpNe0yDrANYH5FpfPpkA
        ifUlCGqFJEOm9SW6y/bGZX3/8A2nf8l8JJ9zo8ORlxAnHJx4Om1+yBD0ZQ5AjB6Zdyfi6E
        I6XHCX8CvhHzS5tu/DNtPa4zK0GKHCvKRJH7aSGRblMmYVxaZ7buV7/ZoPN0DByGplndGq
        AqZvLZqUXU2YFZcooc+zrkZUCwtGtbXojoxBLago26fh4NrBjIcU6sdqNiJJ7g==
MIME-Version: 1.0
Date:   Tue, 24 Oct 2023 10:59:50 +0200
From:   Michael Walle <michael@walle.cc>
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2] mtd: spi-nor: Improve reporting for software reset
 failures
In-Reply-To: <20231024074332.462741-1-acelan.kao@canonical.com>
References: <20231024074332.462741-1-acelan.kao@canonical.com>
Message-ID: <4c11d06931f9b4e29c0e8feafc18e763@walle.cc>
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

[+Mika]


> From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
> 
> When the software reset command isn't supported, we now report it as an
> informational message(dev_info) instead of a warning(dev_warn).
> This adjustment helps avoid unnecessary alarm and confusion regarding
> software reset capabilities.
> 
> v2. only lower the priority for the not supported failure
> 
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> ---
>  drivers/mtd/spi-nor/core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 1b0c6770c14e..76920dbc568b 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3252,7 +3252,10 @@ static void spi_nor_soft_reset(struct spi_nor 
> *nor)
> 
>  	ret = spi_mem_exec_op(nor->spimem, &op);
>  	if (ret) {
> -		dev_warn(nor->dev, "Software reset failed: %d\n", ret);
> +		if (ret == -ENOTSUPP)

It bothers me that we use ENOTSUPP here. We should really use 
EOPNOTSUPP.
The core uses EOPNOTSUPP everywhere except for the intel things.

Please have a look at changing that to EOPNOTSUPP. See also:
https://lore.kernel.org/linux-mtd/85f9c462-c155-dc17-dc97-3254acfa55d2@microchip.com/


> +			dev_info(nor->dev, "Software reset enable command doesn't support: 
> %d\n", ret);

I'm not sure this is helpful. It's only the intel SPI controller which
does magic things (instead of just issuing our commands). Mika, do you
know wether your controller will do a reset on it's own? I presume so,
because AFAIR you have some kind of high level controller which also 
does
SFDP parsing and read opcode handling on their own.

> +		else
> +			dev_warn(nor->dev, "Software reset failed: %d\n", ret);
>  		return;
>  	}
> 
> @@ -3262,7 +3265,10 @@ static void spi_nor_soft_reset(struct spi_nor 
> *nor)
> 
>  	ret = spi_mem_exec_op(nor->spimem, &op);
>  	if (ret) {
> -		dev_warn(nor->dev, "Software reset failed: %d\n", ret);
> +		if (ret == -ENOTSUPP)
> +			dev_info(nor->dev, "Software reset command doesn't support: %d\n", 
> ret);

I'd leave that as is, because how are the chances that the first one is
supported and the second command, isn't?
When working with the intel controller, we'll return early after the
first spi_mem_exec_op().

-michael

> +		else
> +			dev_warn(nor->dev, "Software reset failed: %d\n", ret);
>  		return;
>  	}
