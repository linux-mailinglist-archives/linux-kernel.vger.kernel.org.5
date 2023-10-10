Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC987BF7B7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjJJJpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjJJJor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:44:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D65FB;
        Tue, 10 Oct 2023 02:44:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9031EC433C7;
        Tue, 10 Oct 2023 09:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696931073;
        bh=7YEHaqsLTuRNgAsuwQ/rOKY1wHlB6nQFsPl4GdRnH0Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tieprnbQcR/MA380yekPeBfVtwJBUs424sGj2ujDysOPpJtzqQDlXntLWViz881BP
         eoOlfMh61dkXBsH2VxxYEkkY/xrXfM1xwCDoqu1dhT4jN4XwA/xvDP8YXlBojEJLqm
         yvQbhd0/fr0SBOgr/5LiZHa0mBgfSSY3EJqwWSeIxH7UL0Db402/c3OZ4PbYVYVGfe
         5P3aSlYuN9/RRtaQMys7x2M/RyIym5xemK5Fa4kXF9byINBPGb7UPFU+tetxivzjfQ
         IgdwAlHibR7/7ZIuEVBoR2QvauL5laVKDDO5GhyOM9dwqaJA6sEsnBnwlSUOzClw5A
         lBlz0gm4np6Cg==
Date:   Tue, 10 Oct 2023 10:44:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <marius.cristea@microchip.com>
Cc:     <lars@metafoo.de>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] iio: adc: MCP3564: fix warn: unsigned '__x' is never
 less than zero.
Message-ID: <20231010104444.12e61984@jic23-huawei>
In-Reply-To: <20231002161618.36373-1-marius.cristea@microchip.com>
References: <20231002161618.36373-1-marius.cristea@microchip.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2023 19:16:18 +0300
<marius.cristea@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
> 
> The patch efea15e3c65d: "iio: adc: MCP3564: fix the static checker warning"
> leads to the following Smatch static checker warning:
> 
>    smatch warnings:
>    drivers/iio/adc/mcp3564.c:1105 mcp3564_fill_scale_tbls() warn: unsigned '__x' is never less than zero.
> 
> vim +/__x +1105 drivers/iio/adc/mcp3564.c
> 
>    1094
>    1095  static void mcp3564_fill_scale_tbls(struct mcp3564_state *adc)
>    1096  {
>    .....
>    1103          for (i = 0; i < MCP3564_MAX_PGA; i++) {
>    1104                  ref = adc->vref_mv;
>  > 1105                  tmp1 = shift_right((u64)ref * NANO, pow);  
>    1106                  div_u64_rem(tmp1, NANO, &tmp0);
>    1107
>    .....
>    1113  }
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309280738.NWjVfVt4-lkp@intel.com/
> Fixes: efea15e3c65d (iio: adc: MCP3564: fix the static checker warning)

This fix is fine but can you talk me through how the static checker warning fix
in question has anything to do with this one?

Was it just a case of fixing that issue allowing the static checker to
get further before giving up?  In which case the description needs modifying.

Or am I missing something in the following fix?

diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index 64145f4ae55c..9ede1a5d5d7b 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -1422,11 +1422,8 @@ static int mcp3564_probe(struct spi_device *spi)
        struct mcp3564_state *adc;
 
        indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
-       if (!indio_dev) {
-               dev_err_probe(&indio_dev->dev, PTR_ERR(indio_dev),
-                             "Can't allocate iio device\n");
+       if (!indio_dev)
                return -ENOMEM;
-       }
 
as that's all I'm seeing in that commit.

> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---
>  drivers/iio/adc/mcp3564.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
> index 9ede1a5d5d7b..e3f1de5fcc5a 100644
> --- a/drivers/iio/adc/mcp3564.c
> +++ b/drivers/iio/adc/mcp3564.c
> @@ -1102,7 +1102,7 @@ static void mcp3564_fill_scale_tbls(struct mcp3564_state *adc)
>  
>  	for (i = 0; i < MCP3564_MAX_PGA; i++) {
>  		ref = adc->vref_mv;
> -		tmp1 = shift_right((u64)ref * NANO, pow);
> +		tmp1 = ((u64)ref * NANO) >> pow;
>  		div_u64_rem(tmp1, NANO, &tmp0);
>  
>  		tmp1 = tmp1 * mcp3564_hwgain_frac[(2 * i) + 1];
> 
> base-commit: 5e99f692d4e32e3250ab18d511894ca797407aec

