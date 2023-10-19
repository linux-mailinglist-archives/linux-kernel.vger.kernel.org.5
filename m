Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5AA7CF973
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345829AbjJSMxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345722AbjJSMwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:52:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6DC11B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:52:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97689C433CC;
        Thu, 19 Oct 2023 12:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697719955;
        bh=yuOr6eC+UVD/IHhv/fixcoalqBvESFwRL92GtxeNa7I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pNnFayKsiffxCOuRCKBeRs5ptNAQMvMDxbA3GN2LaSThQrvAZiASeOSymI0QNje4U
         6ATHOmk+SUzkTwID1dB+nrE4OplbCrDvSBsGykpQTMkgE0wSZmsjHkb5FUxudGcRjM
         s6uF9dQgQ989gKDx+90fS6/B7AV5KOcciYeV6AIyzyHXUlXeKykkrI+TFqPJJITl0D
         uvjQYh/AVgw6Jmvfbc71rZr275c6wvAPHStRa+JDbnJPw4D5UD2DGQB0HjFaJ49j2m
         6JUQPk7KFnbLo5xUhUQXSTVyzru/XxHk+MswENfOAS3XhXtDl7in3l7qJ0yB4X2yVQ
         7NrhVeQ2dUrNA==
From:   Pratyush Yadav <pratyush@kernel.org>
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: Lower the priority of the software reset
 failure message
In-Reply-To: <20231019064547.348446-1-acelan.kao@canonical.com> (AceLan Kao's
        message of "Thu, 19 Oct 2023 14:45:47 +0800")
References: <20231019064547.348446-1-acelan.kao@canonical.com>
Date:   Thu, 19 Oct 2023 14:52:33 +0200
Message-ID: <mafs07cnin59q.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19 2023, AceLan Kao wrote:

> From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
>
> Not all SPI drivers support soft reset enable and soft reset commands.
> This failure is expected and not critical. Thus, we avoid reporting it
> to regular users to prevent potential confusion regarding power-off issues.

No, failure to soft reset can very much be critical in certain cases.
For example, if you are operating the flash in 8D-8D-8D mode and do not
have the hard reset line connected, the bootloader (or the kernel) would
be unable to detect or operate the flash after a warm reboot.

Perhaps it makes sense to just call it when SNOR_F_BROKEN_RESET is set?
This way you do not unnecessarily call it when you do not need to, and
won't see the error message.

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
> @@ -3252,7 +3252,7 @@ static void spi_nor_soft_reset(struct spi_nor *nor)
>  
>  	ret = spi_mem_exec_op(nor->spimem, &op);
>  	if (ret) {
> -		dev_warn(nor->dev, "Software reset failed: %d\n", ret);
> +		dev_info(nor->dev, "Software reset failed: %d\n", ret);
>  		return;
>  	}
>  
> @@ -3262,7 +3262,7 @@ static void spi_nor_soft_reset(struct spi_nor *nor)
>  
>  	ret = spi_mem_exec_op(nor->spimem, &op);
>  	if (ret) {
> -		dev_warn(nor->dev, "Software reset failed: %d\n", ret);
> +		dev_info(nor->dev, "Software reset failed: %d\n", ret);
>  		return;
>  	}

-- 
Regards,
Pratyush Yadav
