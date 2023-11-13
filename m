Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9417EA27C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 19:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjKMSBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 13:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMSBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 13:01:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB3FDB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 10:01:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27800C433C7;
        Mon, 13 Nov 2023 18:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699898471;
        bh=/fQB8yzDRwI8suGbN18tEiqj2tDHOeeWavzxzxadeqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V28qkMWlDEpLGChLVOSuTSVOqsy48qAtgXtDB2uF7uhrJEi1ey5P4BeKAnt+AaIFt
         vxlsjlZO4BmgfXlGasbfGW95XvRWaPUNlQBxz8cm3yIRq6yZSVj3vlTXemAEuuc99a
         rpuwtjbcXqkc7twnSRwrTRqImpsKuWYJhGIuCo7aTJtejQep4BFoJfqijZLlSf0MHW
         rlxUM7YXWR1QAMpmDUJrhcAi0Zq+II2Sj5mAG2Ydkb0NavWdI+YmTn19VAD8G0Jtnu
         2COdOM3m5e5zuo+006I+/S5Sh91jdtUNiRiks5uPZhyePOVzsFJBr2UHc3hlB2Ir9f
         lqzd5IGAL/w9Q==
Date:   Mon, 13 Nov 2023 18:01:07 +0000
From:   Simon Horman <horms@kernel.org>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Keguang Zhang <keguang.zhang@gmail.com>,
        linux-mips@vger.kernel.org, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: |PATCH] stmmac: dwmac-loongson: Add architecture dependency
Message-ID: <20231113180107.GA52493@kernel.org>
References: <20231113154522.0bca3521@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113154522.0bca3521@endymion.delvare>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 03:45:22PM +0100, Jean Delvare wrote:
> Only present the DWMAC_LOONGSON option on architectures where it can
> actually be used.
> 
> This follows the same logic as the DWMAC_INTEL option.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> I'm not familiar with the hardware, so please let me know if the
> dependency needs to be adjusted somehow.
> 
>  drivers/net/ethernet/stmicro/stmmac/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-6.6.orig/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ linux-6.6/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -269,7 +269,7 @@ config DWMAC_INTEL
>  config DWMAC_LOONGSON
>  	tristate "Loongson PCI DWMAC support"
>  	default MACH_LOONGSON64
> -	depends on STMMAC_ETH && PCI
> +	depends on MACH_LOONGSON64 && STMMAC_ETH && PCI

Hi Jean,

Could we consider also allowing the build to occur if COMPILE_TEST is set?
This would maintain the current level of build test coverage.

Something line this (completely untested!):

	depends on (MACH_LOONGSON64 || COMPILE_TEST) && STMMAC_ETH && PCI

>  	depends on COMMON_CLK
>  	help
>  	  This selects the LOONGSON PCI bus support for the stmmac driver,
> 
> 
> -- 
> Jean Delvare
> SUSE L3 Support
> 
