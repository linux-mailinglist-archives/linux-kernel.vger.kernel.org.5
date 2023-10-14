Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE0F7C9555
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 18:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjJNQRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 12:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjJNQRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 12:17:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54733A2;
        Sat, 14 Oct 2023 09:17:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF41CC433C7;
        Sat, 14 Oct 2023 16:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697300257;
        bh=xHY0aHf0uD11zRpqxPLjkEWTV0MfIpfqhqDSbGx/3+Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=At2Q3ivBEO+OXY8uC47sAGzBJemm3FZ4BfSamI6PiCXBAQElgcbtZ3hBnhPSDf3GP
         cdMt3u+vLbROMtypOnZW1rG8B9MQfI3P6phPTRiIvyCP/hSF485e91/vJzyaODEz2j
         PsjKMD5zNqFbhHhWtc1KNxRSH21OvL+Ql4rNPMqKBuPEqhIQid/TOjpY7J20/OIXKD
         LZV94XdL9C4Gz7HAGTdecNnSZQTLSjxWhTq/wEThigCQtM4uPeZrGbo4ibeIvyyCHd
         JJe6DAflemxalqZNdKtgHcGR9sS/n7nEtEXxSjk9ZVzRTVzALSAtUTHP11aqjNh5CH
         dhaPORddHjLFA==
Date:   Sat, 14 Oct 2023 17:17:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <marius.cristea@microchip.com>
Cc:     <lars@metafoo.de>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: MCP3564: fix warn: unsigned '__x' is never
 less than zero.
Message-ID: <20231014171752.5c4d7a86@jic23-huawei>
In-Reply-To: <20231013132333.10582-1-marius.cristea@microchip.com>
References: <20231013132333.10582-1-marius.cristea@microchip.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 16:23:33 +0300
<marius.cristea@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
> 
> The patch 33ec3e5fc1ea: "iio: adc: adding support for MCP3564 ADC"
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
> Fixes: 33ec3e5fc1ea (iio: adc: adding support for MCP3564 ADC)
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
Applied to the togreg branch of iio.git and pushed out as testing briefly
for 0-day to take a look.

Thanks,

Jonathan

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

