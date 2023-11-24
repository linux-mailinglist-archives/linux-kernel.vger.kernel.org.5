Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B73A7F7664
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345280AbjKXOgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjKXOgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:36:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C9A19AD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:36:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C6DC433CA;
        Fri, 24 Nov 2023 14:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700836604;
        bh=MdOhhUKumd3kzb9H02LyP8oNeaYzZ+2LZ3UTYMLXOVE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rzqSDjKnVMIT1WOvjbr9cWJa/zbBDJL1pf4jeyHfhOTVq83WXx9Qk+UXtUnUDQFaG
         rIW4sQC4/HBhQJzo+2g4ffQ8N7oW3f0ZsljPKUjUzDiy9LrPHscy67npgbuhPQOWQb
         luGHy5jTRMLkfoor6lk44wZF51xP2ysfsrluz0l+0uIOicSKhjdb7MIslKMTxuV7O+
         z0D9ydOrFyErQi92VsJ6RNBvEZppmeCYPeqICtO+lZ3jQvF0ZE8EmFmyZZ6ndY+hfV
         MxlVMQIBlaTFtpRil+H+MObpob3N/Ej0/oJn7NaJw4KWgA/V8KCSpZg6vqcxfqFBcU
         feDGnYbW/6Stg==
From:   Pratyush Yadav <pratyush@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     pratyush@kernel.org, michael@walle.cc,
        linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] docs: mtd: spi-nor: add sections about flash
 additions and testing
In-Reply-To: <20231123160721.64561-2-tudor.ambarus@linaro.org> (Tudor
        Ambarus's message of "Thu, 23 Nov 2023 18:07:20 +0200")
References: <20231123160721.64561-1-tudor.ambarus@linaro.org>
        <20231123160721.64561-2-tudor.ambarus@linaro.org>
Date:   Fri, 24 Nov 2023 15:36:42 +0100
Message-ID: <mafs0sf4vdxqd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Thu, Nov 23 2023, Tudor Ambarus wrote:

> Add sections about how to propose a new flash addition and about the
> minimum testing requirements.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  Documentation/driver-api/mtd/spi-nor.rst | 189 +++++++++++++++++++++++
>  1 file changed, 189 insertions(+)
>
> diff --git a/Documentation/driver-api/mtd/spi-nor.rst b/Documentation/driver-api/mtd/spi-nor.rst
> index c22f8c0f7950..cc8e81e09544 100644
> --- a/Documentation/driver-api/mtd/spi-nor.rst
> +++ b/Documentation/driver-api/mtd/spi-nor.rst
> @@ -63,3 +63,192 @@ The main API is spi_nor_scan(). Before you call the hook, a driver should
>  initialize the necessary fields for spi_nor{}. Please see
>  drivers/mtd/spi-nor/spi-nor.c for detail. Please also refer to spi-fsl-qspi.c
>  when you want to write a new driver for a SPI NOR controller.
[...]
> +4/ Use `mtd-utils <https://git.infradead.org/mtd-utils.git>`__
> +and verify that erase, read and page program operations work fine.
> +
> +a/ Generate a 2 MB file::
> +
> +    root@1:~# dd if=/dev/urandom of=./spi_test bs=1M count=2
> +    2+0 records in
> +    2+0 records out
> +    2097152 bytes (2.1 MB, 2.0 MiB) copied, 0.848566 s, 2.5 MB/s
> +
> +b/ Verify erase::
> +
> +    root@1:~# mtd_debug write /dev/mtd1 0 2097152 spi_test
> +    Copied 2097152 bytes from spi_test to address 0x00000000 in flash

Perhaps mention that the 2 MiB region should already be erased.
Otherwise some flashes might refuse the writes (like the ones with ECC
-- Cypress S28 family comes to mind). Experienced engineers should know
this already but it might trip up some beginners.

Looks good otherwise. Thanks for working on this.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

> +
> +    root@1:~# mtd_debug erase /dev/mtd1 0 2097152
> +    Erased 2097152 bytes from address 0x00000000 in flash
> +
> +    root@1:~# mtd_debug read /dev/mtd1 0 2097152 spi_read
> +    Copied 2097152 bytes from address 0x00000000 in flash to spi_read
> +
> +    root@1:~# hexdump -C spi_read
> +    00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
> +    *
> +    00200000
> +
[...]

-- 
Regards,
Pratyush Yadav
