Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891857ABF16
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjIWJAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjIWJAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:00:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0077194;
        Sat, 23 Sep 2023 02:00:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660B2C433C7;
        Sat, 23 Sep 2023 09:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695459611;
        bh=YtwQBuQyMXymPxM6ljmzlmpMeRjYV+8uUzyCjUIiWkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jwsi1G13a5bMOQADUKA28oYIlcldKinNLMjx+5JBVRUdn3Y+3e0jV9v1PQhkhBBM2
         ncX3dw88m6RDyvjjahuzmgDiNZ5gcnQEirjNlP0oQQhM7UZb3vR7o/LweiufMsQDn0
         hmuE+JxSjTLMjtpSdNa1z4n2NIlTaC6+mI5Ad7CfyQXV7C9xBGiNwgbIpfOh17BBAo
         SEOTqEwo5GtFT/5vnFQ7VSRJNKgzhxOst+DQZBSW/PqsV3yqO/h68UBUuRg4D26Qhz
         JqwGQ+UyJAHxoN7olNgQXUefkOtAjNIWPStIbUQk3fdXr30zReefPRJcE7CLqUK/Y1
         S85hWi+T5tAPw==
Date:   Sat, 23 Sep 2023 11:01:14 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] spi: mchp-pci1xxxx: Annotate struct pci1xxxx_spi with
 __counted_by
Message-ID: <ZQ8Z2hXuR8F0g/C3@work>
References: <20230922175322.work.170-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175322.work.170-kees@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:53:23AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct pci1xxxx_spi.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-spi@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  drivers/spi/spi-pci1xxxx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
> index 3638e974f5d4..5b2d3e4e21b7 100644
> --- a/drivers/spi/spi-pci1xxxx.c
> +++ b/drivers/spi/spi-pci1xxxx.c
> @@ -77,7 +77,7 @@ struct pci1xxxx_spi {
>  	struct pci_dev *dev;
>  	u8 total_hw_instances;
>  	void __iomem *reg_base;
> -	struct pci1xxxx_spi_internal *spi_int[];
> +	struct pci1xxxx_spi_internal *spi_int[] __counted_by(total_hw_instances);
>  };
>  
>  static const struct pci_device_id pci1xxxx_spi_pci_id_table[] = {
> -- 
> 2.34.1
> 
> 
