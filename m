Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADD5778D41
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbjHKLSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbjHKLSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:18:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA2CEE7E;
        Fri, 11 Aug 2023 04:18:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9839CD75;
        Fri, 11 Aug 2023 04:18:42 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35F4E3F6C4;
        Fri, 11 Aug 2023 04:17:58 -0700 (PDT)
Date:   Fri, 11 Aug 2023 12:17:54 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Martin Botka <martin.botka@somainline.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Alan Ma <tech@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 2/3] nvmem: sunxi_sid: Add support for H616 SID
Message-ID: <20230811121754.3a4dc270@donnerap.manchester.arm.com>
In-Reply-To: <20230811-sid-h616-v1-2-d1dfc9f47b19@somainline.org>
References: <20230811-sid-h616-v1-0-d1dfc9f47b19@somainline.org>
        <20230811-sid-h616-v1-2-d1dfc9f47b19@somainline.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 13:02:35 +0200
Martin Botka <martin.botka@somainline.org> wrote:

Hi Martin,

> Add support for the H616 SID controller.

thanks for upstreaming this!

> 
> The config can be reused from A64.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
>  drivers/nvmem/sunxi_sid.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> index a970f1741cc6..df6fb5e0b724 100644
> --- a/drivers/nvmem/sunxi_sid.c
> +++ b/drivers/nvmem/sunxi_sid.c
> @@ -216,6 +216,7 @@ static const struct of_device_id sunxi_sid_of_match[] = {
>  	{ .compatible = "allwinner,sun50i-a64-sid", .data = &sun50i_a64_cfg },
>  	{ .compatible = "allwinner,sun50i-h5-sid", .data = &sun50i_a64_cfg },
>  	{ .compatible = "allwinner,sun50i-h6-sid", .data = &sun50i_h6_cfg },
> +	{ .compatible = "allwinner,sun50i-h616-sid", .data = &sun50i_a64_cfg },

You don't need a new compatible string, then.
Just use 
  compatible = "allwinner,sun50i-h616-sid", "allwinner,sun50i-a64-sid";
in the DT, and add that combo to the binding, then you don't need any
driver patches at all - with the added benefit of that already working
with existing kernels.

Though I wonder if that has really only 256 bytes of fuses? Do we have any
evidence of that?

Cheers,
Andre

>  	{/* sentinel */},
>  };
>  MODULE_DEVICE_TABLE(of, sunxi_sid_of_match);
> 

