Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF007D7CBF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 08:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344119AbjJZGMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 02:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343862AbjJZGMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 02:12:20 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD77115
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 23:12:17 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39Q6BjYj074753;
        Thu, 26 Oct 2023 01:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698300705;
        bh=UUmCoi9sFG2gDuFW3OlSaYRvhK1O3scFJQltzhb7fyE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=H4SX4had2TqA/rDyNI8f+yNlJESgMdnCkK+oMvBlq2i28a5dITife4wRZHl0Sfqh5
         7jPLgktJK/5gmSXjCM5gkReG8i+UqZnJps7G+uRJIIZLl0B2h374EFHdFy/Tp3c1G6
         4Af66N4pbSgkFzGV8snQQi4S25OtLdZa9y8gkQQQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39Q6BjIP098846
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Oct 2023 01:11:45 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 26
 Oct 2023 01:11:45 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 26 Oct 2023 01:11:45 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39Q6BhqZ101067;
        Thu, 26 Oct 2023 01:11:44 -0500
Date:   Thu, 26 Oct 2023 11:41:43 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     AceLan Kao <acelan.kao@canonical.com>
CC:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] mtd: spi-nor: Improve reporting for software reset
 failures
Message-ID: <20231026061143.bjbgfkyhnnyh2ovb@dhruva>
References: <20231026012017.518610-1-acelan.kao@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231026012017.518610-1-acelan.kao@canonical.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 26, 2023 at 09:20:17 +0800, AceLan Kao wrote:
> From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
> 
> When the software reset command isn't supported, we now report it
> as an informational message(dev_info) instead of a warning(dev_warn).
> This adjustment helps avoid unnecessary alarm and confusion regarding
> software reset capabilities.
> 
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> ---
> v2. only lower the priority for the not supported failure
> v3. replace ENOTSUPP with EOPNOTSUPP and check the first command only
> v4. move the version information below the '---' line
> ---
>  drivers/mtd/spi-nor/core.c | 5 ++++-
>  drivers/spi/spi-mem.c      | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 1b0c6770c14e..42e52af76289 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3252,7 +3252,10 @@ static void spi_nor_soft_reset(struct spi_nor *nor)
>  
>  	ret = spi_mem_exec_op(nor->spimem, &op);
>  	if (ret) {
> -		dev_warn(nor->dev, "Software reset failed: %d\n", ret);
> +		if (ret == -EOPNOTSUPP)
> +			dev_info(nor->dev, "Software reset enable command doesn't support: %d\n", ret);

Does "Software reset command isn't supported:" make more sense?

> +		else
> +			dev_warn(nor->dev, "Software reset failed: %d\n", ret);
>  		return;
>  	}
>  
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index edd7430d4c05..93b77ac0b798 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -323,7 +323,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  		return ret;
>  
>  	if (!spi_mem_internal_supports_op(mem, op))
> -		return -ENOTSUPP;
> +		return -EOPNOTSUPP;

Reviewed-by: Dhruva Gole <d-gole@ti.com>

>  
>  	if (ctlr->mem_ops && ctlr->mem_ops->exec_op && !spi_get_csgpiod(mem->spi, 0)) {
>  		ret = spi_mem_access_start(mem);
> -- 
> 2.34.1
> 
> 


-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
